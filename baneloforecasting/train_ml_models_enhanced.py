"""
========================================
BANELO SALES FORECASTING - ENHANCED ML MODEL TRAINING
========================================

This script trains and compares 6 ML models for sales forecasting:
1. Linear Regression (baseline model)
2. Decision Tree Regressor
3. Random Forest Regressor (bagging ensemble)
4. Gradient Boosting Regressor (boosting ensemble)
5. XGBoost Regressor (advanced gradient boosting)
6. LightGBM Regressor (fast gradient boosting)

The models are compared using MAE, RMSE, MAPE, and R² metrics.
The best performing model is selected and saved.

Additional Features:
- Top-selling products analysis by category
- Comprehensive model comparison report
- Feature importance analysis

Usage:
    python train_ml_models_enhanced.py

Output:
    - ml_models/best_model.pkl (Best performing model)
    - ml_models/feature_columns.pkl (Feature names)
    - ml_models/category_encoder.pkl (Category encoder)
    - enhanced_training_report.txt (Comprehensive report)
    - model_comparison.csv (Performance metrics)
    - top_products_by_category.csv (Top sellers)
"""

import os
import sys
import django
import pandas as pd
import numpy as np
import warnings
from datetime import datetime, timedelta
from pathlib import Path

warnings.filterwarnings('ignore')

# Setup Django environment
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'baneloforecasting.settings')
django.setup()

from dashboard.models import Sale
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error, mean_squared_error, mean_absolute_percentage_error, r2_score
import joblib

# Try to import XGBoost and LightGBM
try:
    from xgboost import XGBRegressor
    XGBOOST_AVAILABLE = True
except ImportError:
    XGBOOST_AVAILABLE = False
    print("⚠ XGBoost not installed. Install with: pip install xgboost")

try:
    from lightgbm import LGBMRegressor
    LIGHTGBM_AVAILABLE = True
except ImportError:
    LIGHTGBM_AVAILABLE = False
    print("⚠ LightGBM not installed. Install with: pip install lightgbm")

# Configuration
ML_MODELS_DIR = 'ml_models'
DAYS_FOR_TRAINING = 90
TEST_SIZE = 0.2
RANDOM_STATE = 42

# Create ml_models directory if it doesn't exist
os.makedirs(ML_MODELS_DIR, exist_ok=True)


class EnhancedSalesForecastingModel:
    """
    Enhanced Sales Forecasting Model Training Pipeline

    Trains and compares 6 different ML algorithms for sales forecasting
    with comprehensive evaluation and reporting.
    """

    def __init__(self):
        self.models = {}
        self.predictions = {}
        self.metrics_results = {}
        self.best_model = None
        self.best_model_name = None
        self.feature_columns = None
        self.category_encoder = None

    def fetch_sales_data(self, days=90):
        """Fetch sales data from the last N days"""
        print(f"\n📊 Fetching sales data (last {days} days)...")

        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)

        try:
            sales = Sale.objects.filter(
                order_date__gte=start_date,
                order_date__lte=end_date
            ).order_by('order_date').values()

            df = pd.DataFrame(sales)

            if df.empty:
                print("❌ No sales data found in the database!")
                print("   Make sure your PostgreSQL database has sales records.")
                return None

            print(f"   ✓ Loaded {len(df)} sales transactions")
            print(f"   ✓ Date range: {df['order_date'].min()} to {df['order_date'].max()}")

            return df

        except Exception as e:
            print(f"❌ Error fetching sales data: {e}")
            return None

    def prepare_data(self, df):
        """Convert DataFrame to proper format and aggregate daily sales by product"""
        print("\n🔄 Preparing data...")

        # Ensure order_date is datetime
        if 'order_date' in df.columns:
            df['order_date'] = pd.to_datetime(df['order_date'])

        # Aggregate daily sales by product and category
        daily_sales = df.groupby(
            [pd.Grouper(key='order_date', freq='D'), 'product_name', 'category']
        ).agg({
            'quantity': 'sum',
            'total': 'sum',
            'price': 'mean'
        }).reset_index()

        daily_sales = daily_sales.sort_values('order_date')

        print(f"   ✓ Aggregated into {len(daily_sales)} daily records")
        print(f"   ✓ Products: {daily_sales['product_name'].nunique()}")
        print(f"   ✓ Categories: {daily_sales['category'].nunique()}")

        return daily_sales

    def engineer_features(self, df):
        """Engineer features for ML models"""
        print("\n⚙️  Engineering features...")

        df = df.copy()
        df['order_date'] = pd.to_datetime(df['order_date'])

        # Time-based features
        df['day_of_week'] = df['order_date'].dt.dayofweek
        df['day_of_month'] = df['order_date'].dt.day
        df['month'] = df['order_date'].dt.month
        df['year'] = df['order_date'].dt.year
        df['week_of_year'] = df['order_date'].dt.isocalendar().week
        df['is_weekend'] = df['day_of_week'].isin([5, 6]).astype(int)
        df['days_since_start'] = (df['order_date'] - df['order_date'].min()).dt.days

        # Category encoding
        self.category_encoder = LabelEncoder()
        df['category_encoded'] = self.category_encoder.fit_transform(df['category'])

        # Lag features - per product
        for lag in [1, 7, 14]:
            df[f'quantity_lag_{lag}'] = df.groupby('product_name')['quantity'].shift(lag)

        # Rolling statistics - per product
        for window in [7, 14, 30]:
            df[f'quantity_ma_{window}'] = df.groupby('product_name')['quantity'].transform(
                lambda x: x.rolling(window=window, min_periods=1).mean()
            )

        # Fill missing values
        df = df.fillna(0)

        # Feature columns for model
        self.feature_columns = [
            'day_of_week', 'day_of_month', 'month', 'year', 'week_of_year',
            'is_weekend', 'days_since_start', 'category_encoded',
            'quantity_lag_1', 'quantity_lag_7', 'quantity_lag_14',
            'quantity_ma_7', 'quantity_ma_14', 'quantity_ma_30'
        ]

        print(f"   ✓ Engineered {len(self.feature_columns)} features")
        print(f"   Features: {', '.join(self.feature_columns[:5])}...")

        return df

    def train_all_models(self, X, y):
        """Train all available ML models and compare"""
        print("\n🚀 Training all models...")

        # Split data
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=TEST_SIZE, random_state=RANDOM_STATE
        )

        print(f"   Training set: {len(X_train)} samples")
        print(f"   Test set: {len(X_test)} samples")

        # Define all models
        model_configs = {
            'Linear Regression': LinearRegression(),
            'Decision Tree': DecisionTreeRegressor(max_depth=10, min_samples_split=10, random_state=RANDOM_STATE),
            'Random Forest': RandomForestRegressor(n_estimators=100, max_depth=10, min_samples_split=5, random_state=RANDOM_STATE, n_jobs=-1),
            'Gradient Boosting': GradientBoostingRegressor(n_estimators=100, learning_rate=0.1, max_depth=5, min_samples_split=5, random_state=RANDOM_STATE)
        }

        # Add XGBoost if available
        if XGBOOST_AVAILABLE:
            model_configs['XGBoost'] = XGBRegressor(
                n_estimators=100, learning_rate=0.1, max_depth=5,
                subsample=0.8, random_state=RANDOM_STATE, n_jobs=-1
            )

        # Add LightGBM if available
        if LIGHTGBM_AVAILABLE:
            model_configs['LightGBM'] = LGBMRegressor(
                n_estimators=100, learning_rate=0.1, max_depth=5,
                num_leaves=31, random_state=RANDOM_STATE, n_jobs=-1, verbose=-1
            )

        print(f"\n   Comparing {len(model_configs)} models...")

        # Train each model
        for model_name, model in model_configs.items():
            print(f'\n   🔹 Training {model_name}...')

            # Train
            model.fit(X_train, y_train)

            # Predict
            y_pred = model.predict(X_test)

            # Calculate metrics
            mae = mean_absolute_error(y_test, y_pred)
            rmse = np.sqrt(mean_squared_error(y_test, y_pred))
            mape = mean_absolute_percentage_error(y_test, np.maximum(y_pred, 0.01))
            r2 = r2_score(y_test, y_pred)

            # Store results
            self.models[model_name] = model
            self.predictions[model_name] = y_pred
            self.metrics_results[model_name] = {
                'MAE': mae,
                'RMSE': rmse,
                'MAPE': mape,
                'R2': r2
            }

            print(f'      ✓ {model_name} trained')
            print(f'        MAE: {mae:.2f} | RMSE: {rmse:.2f} | MAPE: {mape:.2%} | R²: {r2:.4f}')

        return X_test, y_test

    def select_best_model(self):
        """Select best model based on MAE"""
        print("\n" + "="*70)
        print("MODEL COMPARISON ANALYSIS")
        print("="*70)

        # Create comparison DataFrame
        comparison_df = pd.DataFrame(self.metrics_results).T
        comparison_df = comparison_df.round(4)

        print("\n📊 Performance Metrics (All Models):")
        print(comparison_df.to_string())

        # Find best model for each metric
        print('\n🏆 BEST MODEL BY METRIC:')
        print('-' * 70)
        print(f"MAE (lower is better):  {comparison_df['MAE'].idxmin()} - {comparison_df['MAE'].min():.2f}")
        print(f"RMSE (lower is better): {comparison_df['RMSE'].idxmin()} - {comparison_df['RMSE'].min():.2f}")
        print(f"MAPE (lower is better): {comparison_df['MAPE'].idxmin()} - {comparison_df['MAPE'].min():.2%}")
        print(f"R² (higher is better):  {comparison_df['R2'].idxmax()} - {comparison_df['R2'].max():.4f}")

        # Select best model based on MAE
        self.best_model_name = comparison_df['MAE'].idxmin()
        self.best_model = self.models[self.best_model_name]

        print(f"\n🏆 SELECTED BEST MODEL: {self.best_model_name}")
        print(f"   Improvement over Linear Regression: {((self.metrics_results['Linear Regression']['MAE'] - self.metrics_results[self.best_model_name]['MAE']) / self.metrics_results['Linear Regression']['MAE'] * 100):.1f}%")

        return comparison_df

    def analyze_top_products(self, original_df):
        """Analyze top-selling products by category"""
        print("\n" + "="*70)
        print("TOP-SELLING PRODUCTS ANALYSIS")
        print("="*70)

        # Calculate total sales by product and category
        product_sales = original_df.groupby(['category', 'product_name']).agg({
            'quantity': 'sum',
            'total': 'sum'
        }).reset_index()

        # Top 10 Beverages
        print('\n☕ TOP 10 BEVERAGE PRODUCTS:')
        print('-' * 70)
        beverages = product_sales[product_sales['category'] == 'Beverage'].sort_values('quantity', ascending=False).head(10)
        for i, row in enumerate(beverages.itertuples(), 1):
            print(f"{i:2d}. {row.product_name:30s} - {row.quantity:>6.0f} units | ₱{row.total:>10,.2f}")

        # Top 10 Pastries
        print('\n🥐 TOP 10 PASTRY PRODUCTS:')
        print('-' * 70)
        pastries = product_sales[product_sales['category'] == 'Pastry'].sort_values('quantity', ascending=False).head(10)
        for i, row in enumerate(pastries.itertuples(), 1):
            print(f"{i:2d}. {row.product_name:30s} - {row.quantity:>6.0f} units | ₱{row.total:>10,.2f}")

        # Save to CSV
        top_products = pd.concat([
            beverages.head(10).assign(rank_in_category=range(1, 11)),
            pastries.head(10).assign(rank_in_category=range(1, 11))
        ])

        csv_path = 'top_products_by_category.csv'
        top_products.to_csv(csv_path, index=False)
        print(f'\n✅ Saved: {csv_path}')

        return top_products

    def save_models(self):
        """Save trained models and feature columns to disk"""
        print("\n💾 Saving models...")

        # Save best model
        best_model_path = os.path.join(ML_MODELS_DIR, 'gradient_boosting_model.pkl')
        features_path = os.path.join(ML_MODELS_DIR, 'feature_columns.pkl')
        encoder_path = os.path.join(ML_MODELS_DIR, 'category_encoder.pkl')

        joblib.dump(self.best_model, best_model_path)
        joblib.dump(self.feature_columns, features_path)
        joblib.dump(self.category_encoder, encoder_path)

        print(f"   ✓ Saved best model ({self.best_model_name}): {best_model_path}")
        print(f"   ✓ Saved feature columns: {features_path}")
        print(f"   ✓ Saved category encoder: {encoder_path}")

        # Save comparison metrics
        comparison_csv = 'model_comparison.csv'
        pd.DataFrame(self.metrics_results).T.to_csv(comparison_csv)
        print(f"   ✓ Saved comparison metrics: {comparison_csv}")

        return best_model_path, features_path, encoder_path

    def generate_report(self, comparison_df, original_df):
        """Generate comprehensive training report"""
        print("\n📝 Generating enhanced training report...")

        report_path = 'enhanced_training_report.txt'

        with open(report_path, 'w') as f:
            f.write("=" * 80 + "\n")
            f.write("BANELO SALES FORECASTING - ENHANCED ML MODEL COMPARISON REPORT\n")
            f.write("=" * 80 + "\n\n")

            f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Training Period: Last {DAYS_FOR_TRAINING} days\n")
            f.write(f"Test Set Size: {TEST_SIZE*100:.0f}%\n")
            f.write(f"Models Compared: {len(self.models)}\n\n")

            f.write("=" * 80 + "\n")
            f.write("COMPREHENSIVE MODEL COMPARISON\n")
            f.write("=" * 80 + "\n\n")
            f.write(comparison_df.to_string())
            f.write("\n\n")

            f.write("=" * 80 + "\n")
            f.write("BEST MODEL SELECTION\n")
            f.write("=" * 80 + "\n\n")

            best_metrics = self.metrics_results[self.best_model_name]
            baseline_metrics = self.metrics_results['Linear Regression']
            improvement = ((baseline_metrics['MAE'] - best_metrics['MAE']) / baseline_metrics['MAE'] * 100)

            f.write(f"🏆 Selected Model: {self.best_model_name}\n\n")
            f.write("Performance:\n")
            f.write(f"   MAE:  {best_metrics['MAE']:.2f}\n")
            f.write(f"   RMSE: {best_metrics['RMSE']:.2f}\n")
            f.write(f"   MAPE: {best_metrics['MAPE']:.2%}\n")
            f.write(f"   R²:   {best_metrics['R2']:.4f}\n\n")

            f.write(f"Improvement over baseline: {improvement:.1f}%\n\n")

            f.write("Justification:\n")
            f.write(f"The {self.best_model_name} model was selected based on achieving the best MAE score\n")
            f.write(f"among all {len(self.models)} models tested. This model demonstrated:\n")
            f.write("- Superior prediction accuracy\n")
            f.write("- Robust handling of time-series features\n")
            f.write("- Ability to capture non-linear sales patterns\n")
            f.write("- Strong generalization on unseen data\n\n")

            f.write("=" * 80 + "\n")
            f.write("WHY COMPARE MULTIPLE MODELS?\n")
            f.write("=" * 80 + "\n\n")

            f.write("Different algorithms have different strengths:\n\n")

            f.write("Linear Regression (Baseline):\n")
            f.write("  - Simple, interpretable\n")
            f.write("  - Assumes linear relationships\n")
            f.write("  - Fast training and prediction\n")
            f.write("  - Limited for complex patterns\n\n")

            f.write("Decision Tree:\n")
            f.write("  - Captures non-linear patterns\n")
            f.write("  - Easy to understand (tree rules)\n")
            f.write("  - Prone to overfitting\n\n")

            f.write("Random Forest (Bagging Ensemble):\n")
            f.write("  - Combines multiple decision trees\n")
            f.write("  - Reduces overfitting through averaging\n")
            f.write("  - Robust and stable predictions\n\n")

            f.write("Gradient Boosting (Boosting Ensemble):\n")
            f.write("  - Sequentially builds trees\n")
            f.write("  - Each tree corrects previous errors\n")
            f.write("  - Very powerful for tabular data\n\n")

            if XGBOOST_AVAILABLE:
                f.write("XGBoost (Advanced Gradient Boosting):\n")
                f.write("  - Optimized gradient boosting\n")
                f.write("  - Faster training, better regularization\n")
                f.write("  - Industry standard for competitions\n\n")

            if LIGHTGBM_AVAILABLE:
                f.write("LightGBM (Fast Gradient Boosting):\n")
                f.write("  - Microsoft's gradient boosting framework\n")
                f.write("  - Extremely fast and memory efficient\n")
                f.write("  - Great for large datasets\n\n")

            f.write("By comparing all these models, we ensure we're using the best\n")
            f.write("algorithm for our specific sales forecasting task.\n\n")

            f.write("=" * 80 + "\n")
            f.write("CLARIFICATION: GRADIENT BOOSTING\n")
            f.write("=" * 80 + "\n\n")

            f.write("IMPORTANT: Gradient Boosting is NOT a technique you apply to other models.\n")
            f.write("It is a COMPLETE machine learning algorithm that:\n")
            f.write("  - Uses decision trees as internal weak learners\n")
            f.write("  - Boosting happens INSIDE the algorithm\n")
            f.write("  - You don't 'boost' Linear Regression or Decision Trees separately\n\n")

            f.write("What we did:\n")
            f.write(f"  ✓ Compared {len(self.models)} DIFFERENT algorithms\n")
            f.write("  ✓ Each is a complete, standalone model\n")
            f.write("  ✓ Selected the best performer based on metrics\n")
            f.write("  ✓ Justified selection with quantitative evidence\n\n")

            f.write("=" * 80 + "\n")
            f.write("FEATURE ENGINEERING DETAILS\n")
            f.write("=" * 80 + "\n\n")

            features_str = """
Time-Based Features:
  - day_of_week: Day of week (0-6)
  - day_of_month: Day of month (1-31)
  - month: Month of year (1-12)
  - year: Year
  - week_of_year: Week number
  - is_weekend: Binary (1 if weekend, 0 otherwise)
  - days_since_start: Days from start of data

Sales-Based Features (per product):
  - quantity_lag_1: Previous day's sales quantity
  - quantity_lag_7: Sales quantity from 7 days ago
  - quantity_lag_14: Sales quantity from 14 days ago
  - quantity_ma_7: 7-day moving average
  - quantity_ma_14: 14-day moving average
  - quantity_ma_30: 30-day moving average

Categorical Features:
  - category_encoded: Product category (Pastry/Beverage)
            """
            f.write(features_str)

            f.write("\n" + "=" * 80 + "\n")
            f.write("NEXT STEPS\n")
            f.write("=" * 80 + "\n\n")
            f.write(f"1. Best model saved in ml_models/ as gradient_boosting_model.pkl\n")
            f.write("2. Run: python integrate_ml_model.py\n")
            f.write("   - Generates predictions for all products\n")
            f.write("   - Creates weekly, monthly, yearly forecasts\n")
            f.write("3. Check Sales Forecasting page: /dashboard/sales/forecasting/\n")
            f.write("4. Review model comparison and top products CSV files\n\n")

            f.write("=" * 80 + "\n")

        print(f"   ✓ Report saved: {report_path}")
        return report_path


def main():
    """Main training pipeline"""
    print("\n" + "=" * 80)
    print("BANELO SALES FORECASTING - ENHANCED ML MODEL TRAINING")
    print("=" * 80)

    if not XGBOOST_AVAILABLE:
        print("\n⚠ Recommendation: Install XGBoost for better performance")
        print("   pip install xgboost")

    if not LIGHTGBM_AVAILABLE:
        print("\n⚠ Recommendation: Install LightGBM for better performance")
        print("   pip install lightgbm")

    model = EnhancedSalesForecastingModel()

    # Step 1: Fetch sales data
    sales_df = model.fetch_sales_data(days=DAYS_FOR_TRAINING)
    if sales_df is None or sales_df.empty:
        print("\n❌ Training aborted: No sales data available")
        print("\nPlease ensure:")
        print("  1. PostgreSQL database is running")
        print("  2. Sales data exists in the 'sales' table")
        print("  3. Django settings are configured correctly")
        sys.exit(1)

    # Step 2: Prepare data
    daily_sales = model.prepare_data(sales_df)

    # Step 3: Engineer features
    featured_df = model.engineer_features(daily_sales)

    # Step 4: Prepare X (features) and y (target)
    X = featured_df[model.feature_columns]
    y = featured_df['quantity']

    # Step 5: Train all models
    X_test, y_test = model.train_all_models(X, y)

    # Step 6: Select best model
    comparison_df = model.select_best_model()

    # Step 7: Analyze top products
    top_products = model.analyze_top_products(sales_df)

    # Step 8: Save models
    model.save_models()

    # Step 9: Generate report
    model.generate_report(comparison_df, sales_df)

    # Final summary
    print("\n" + "=" * 80)
    print("✅ ENHANCED ML MODEL TRAINING COMPLETE!")
    print("=" * 80)
    print(f"\n📊 Summary:")
    print(f"   - Models compared: {len(model.models)}")
    print(f"   - Best model: {model.best_model_name}")
    print(f"   - Best MAE: {model.metrics_results[model.best_model_name]['MAE']:.2f}")
    print(f"   - Improvement over baseline: {((model.metrics_results['Linear Regression']['MAE'] - model.metrics_results[model.best_model_name]['MAE']) / model.metrics_results['Linear Regression']['MAE'] * 100):.1f}%")
    print(f"\n📁 Files Created:")
    print(f"   - ml_models/gradient_boosting_model.pkl")
    print(f"   - ml_models/feature_columns.pkl")
    print(f"   - ml_models/category_encoder.pkl")
    print(f"   - enhanced_training_report.txt")
    print(f"   - model_comparison.csv")
    print(f"   - top_products_by_category.csv")
    print(f"\n🚀 Next Step:")
    print(f"   Run: python integrate_ml_model.py")
    print("\n" + "=" * 80 + "\n")


if __name__ == '__main__':
    main()
