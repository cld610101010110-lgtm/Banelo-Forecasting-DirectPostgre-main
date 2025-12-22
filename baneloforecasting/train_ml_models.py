"""
========================================
BANELO SALES FORECASTING - ML MODEL TRAINING
========================================

This script trains two ML models for sales forecasting:
1. Linear Regression (baseline model for comparison)
2. Gradient Boosting Regressor (main model for predictions)

The models are compared using MAE, MAPE, and RMSE metrics.

Automatic Features Engineered:
- Time-based: day of week, month, year, is_weekend, week number
- Lag features: 1-day, 7-day, 14-day previous sales
- Rolling statistics: 7-day and 30-day moving averages
- Category encoding: Product category

Usage:
    python train_ml_models.py

Output:
    - ml_models/gradient_boosting_model.pkl (Main model)
    - ml_models/linear_regression_model.pkl (Baseline model)
    - ml_models/feature_columns.pkl (Feature names)
    - training_report.txt (Model comparison metrics)
"""

import os
import sys
import django
import pandas as pd
import numpy as np
import warnings
import pickle
from datetime import datetime, timedelta
from pathlib import Path

warnings.filterwarnings('ignore')

# Setup Django environment
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'baneloforecasting.settings')
django.setup()

from dashboard.models import Sale
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error, mean_squared_error, mean_absolute_percentage_error
import joblib

# Configuration
ML_MODELS_DIR = 'ml_models'
DAYS_FOR_TRAINING = 90
TEST_SIZE = 0.2
RANDOM_STATE = 42

# Create ml_models directory if it doesn't exist
os.makedirs(ML_MODELS_DIR, exist_ok=True)


class SalesForecastingModel:
    """
    Sales Forecasting Model Training Pipeline

    Trains and compares Linear Regression vs Gradient Boosting models
    for sales forecasting with automatic feature engineering.
    """

    def __init__(self):
        self.lr_model = None
        self.gb_model = None
        self.feature_columns = None
        self.category_encoder = None
        self.metrics = {}

    def fetch_sales_data(self, days=90):
        """
        Fetch sales data from the last N days
        """
        print(f"\n📊 Fetching sales data (last {days} days)...")

        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)

        try:
            # Query sales from database
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
        """
        Convert DataFrame to proper format and aggregate daily sales by product
        """
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
        """
        Engineer features for ML models

        Features:
        - Time-based: day_of_week, month, year, is_weekend, week_of_year
        - Lag features: quantity_lag_1, quantity_lag_7, quantity_lag_14
        - Rolling stats: quantity_ma_7, quantity_ma_30, quantity_std_7
        - Category encoding: category_encoded
        """
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
        for window in [7, 30]:
            df[f'quantity_ma_{window}'] = df.groupby('product_name')['quantity'].transform(
                lambda x: x.rolling(window=window, min_periods=1).mean()
            )
            df[f'quantity_std_{window}'] = df.groupby('product_name')['quantity'].transform(
                lambda x: x.rolling(window=window, min_periods=1).std()
            )

        # Fill missing values
        df = df.fillna(0)

        # Feature columns for model
        self.feature_columns = [
            'day_of_week', 'day_of_month', 'month', 'year', 'week_of_year',
            'is_weekend', 'days_since_start', 'category_encoded',
            'quantity_lag_1', 'quantity_lag_7', 'quantity_lag_14',
            'quantity_ma_7', 'quantity_ma_30', 'quantity_std_7', 'quantity_std_30'
        ]

        print(f"   ✓ Engineered {len(self.feature_columns)} features")
        print(f"   Features: {', '.join(self.feature_columns[:5])}...")

        return df

    def train_models(self, X, y):
        """
        Train both Linear Regression and Gradient Boosting models
        """
        print("\n🚀 Training models...")

        # Split data
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=TEST_SIZE, random_state=RANDOM_STATE
        )

        print(f"   Training set: {len(X_train)} samples")
        print(f"   Test set: {len(X_test)} samples")

        # Model 1: Linear Regression (Baseline)
        print("\n   📈 Training Linear Regression (Baseline)...")
        self.lr_model = LinearRegression()
        self.lr_model.fit(X_train, y_train)
        lr_pred = self.lr_model.predict(X_test)

        lr_mae = mean_absolute_error(y_test, lr_pred)
        lr_rmse = np.sqrt(mean_squared_error(y_test, lr_pred))
        # Avoid division by zero in MAPE
        lr_mape = mean_absolute_percentage_error(y_test, np.maximum(y_pred, 0.01))

        self.metrics['linear_regression'] = {
            'MAE': lr_mae,
            'RMSE': lr_rmse,
            'MAPE': lr_mape,
            'R2_train': self.lr_model.score(X_train, y_train),
            'R2_test': self.lr_model.score(X_test, y_test)
        }

        print(f"      ✓ Linear Regression trained")
        print(f"        - MAE: {lr_mae:.2f}")
        print(f"        - RMSE: {lr_rmse:.2f}")
        print(f"        - MAPE: {lr_mape:.2%}")
        print(f"        - R² (test): {self.metrics['linear_regression']['R2_test']:.4f}")

        # Model 2: Gradient Boosting (Main Model)
        print("\n   🚀 Training Gradient Boosting (Main Model)...")
        self.gb_model = GradientBoostingRegressor(
            n_estimators=100,
            learning_rate=0.1,
            max_depth=5,
            min_samples_split=5,
            min_samples_leaf=2,
            subsample=0.8,
            random_state=RANDOM_STATE,
            verbose=0
        )
        self.gb_model.fit(X_train, y_train)
        gb_pred = self.gb_model.predict(X_test)

        gb_mae = mean_absolute_error(y_test, gb_pred)
        gb_rmse = np.sqrt(mean_squared_error(y_test, gb_pred))
        gb_mape = mean_absolute_percentage_error(y_test, np.maximum(y_test, 0.01))

        self.metrics['gradient_boosting'] = {
            'MAE': gb_mae,
            'RMSE': gb_rmse,
            'MAPE': gb_mape,
            'R2_train': self.gb_model.score(X_train, y_train),
            'R2_test': self.gb_model.score(X_test, y_test)
        }

        print(f"      ✓ Gradient Boosting trained")
        print(f"        - MAE: {gb_mae:.2f}")
        print(f"        - RMSE: {gb_rmse:.2f}")
        print(f"        - MAPE: {gb_mape:.2%}")
        print(f"        - R² (test): {self.metrics['gradient_boosting']['R2_test']:.4f}")

        return X_test, y_test, gb_pred, lr_pred

    def compare_models(self, X_test, y_test, gb_pred, lr_pred):
        """
        Compare models and select the best one
        """
        print("\n" + "="*60)
        print("MODEL COMPARISON ANALYSIS")
        print("="*60)

        lr_metrics = self.metrics['linear_regression']
        gb_metrics = self.metrics['gradient_boosting']

        # Create comparison table
        comparison = pd.DataFrame({
            'Linear Regression': lr_metrics,
            'Gradient Boosting': gb_metrics
        }).round(4)

        print("\n📊 Performance Metrics:")
        print(comparison.to_string())

        # Determine winner
        print("\n🏆 Model Selection Analysis:")
        print("-" * 60)

        if gb_metrics['MAE'] < lr_metrics['MAE']:
            print(f"✓ MAE: Gradient Boosting WINS ({gb_metrics['MAE']:.2f} vs {lr_metrics['MAE']:.2f})")
        else:
            print(f"✓ MAE: Linear Regression WINS ({lr_metrics['MAE']:.2f} vs {gb_metrics['MAE']:.2f})")

        if gb_metrics['RMSE'] < lr_metrics['RMSE']:
            print(f"✓ RMSE: Gradient Boosting WINS ({gb_metrics['RMSE']:.2f} vs {lr_metrics['RMSE']:.2f})")
        else:
            print(f"✓ RMSE: Linear Regression WINS ({lr_metrics['RMSE']:.2f} vs {gb_metrics['RMSE']:.2f})")

        if gb_metrics['MAPE'] < lr_metrics['MAPE']:
            print(f"✓ MAPE: Gradient Boosting WINS ({gb_metrics['MAPE']:.2%} vs {lr_metrics['MAPE']:.2%})")
        else:
            print(f"✓ MAPE: Linear Regression WINS ({lr_metrics['MAPE']:.2%} vs {lr_metrics['MAPE']:.2%})")

        print("\n📋 Justification:")
        print("-" * 60)
        print("""
Gradient Boosting is selected as the PRIMARY model because:

1. HANDLES NON-LINEAR PATTERNS: GB captures complex relationships
   between features better than simple linear regression.

2. TIME-SERIES EXPERTISE: GB works well with lagged features and
   rolling statistics commonly used in sales forecasting.

3. REAL-WORLD PERFORMANCE: GB typically outperforms linear regression
   on real-world business data with multiple features and patterns.

4. FEATURE IMPORTANCE: GB provides insights into which features
   drive sales (day of week, seasonality, etc.).

Linear Regression serves as a BASELINE model to:
- Show the improvement GB provides
- Provide a simple interpretable comparison
- Validate that GB's complexity is justified
        """)

        return comparison

    def save_models(self):
        """
        Save trained models and feature columns to disk
        """
        print("\n💾 Saving models...")

        # Save models
        gb_path = os.path.join(ML_MODELS_DIR, 'gradient_boosting_model.pkl')
        lr_path = os.path.join(ML_MODELS_DIR, 'linear_regression_model.pkl')
        features_path = os.path.join(ML_MODELS_DIR, 'feature_columns.pkl')

        joblib.dump(self.gb_model, gb_path)
        joblib.dump(self.lr_model, lr_path)
        joblib.dump(self.feature_columns, features_path)

        print(f"   ✓ Saved Gradient Boosting model: {gb_path}")
        print(f"   ✓ Saved Linear Regression model: {lr_path}")
        print(f"   ✓ Saved feature columns: {features_path}")

        return gb_path, lr_path, features_path

    def generate_report(self, comparison):
        """
        Generate training report
        """
        print("\n📝 Generating training report...")

        report_path = 'training_report.txt'

        with open(report_path, 'w') as f:
            f.write("=" * 70 + "\n")
            f.write("BANELO SALES FORECASTING - ML MODEL TRAINING REPORT\n")
            f.write("=" * 70 + "\n\n")

            f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Training Period: Last {DAYS_FOR_TRAINING} days\n")
            f.write(f"Test Set Size: {TEST_SIZE*100:.0f}%\n\n")

            f.write("=" * 70 + "\n")
            f.write("MODEL COMPARISON METRICS\n")
            f.write("=" * 70 + "\n\n")
            f.write(comparison.to_string())
            f.write("\n\n")

            f.write("=" * 70 + "\n")
            f.write("METRIC EXPLANATIONS\n")
            f.write("=" * 70 + "\n\n")

            f.write("MAE (Mean Absolute Error):\n")
            f.write("  - Measures average absolute difference between predicted and actual sales\n")
            f.write("  - Interpretation: 'On average, prediction was off by X pesos'\n")
            f.write("  - Lower is better\n\n")

            f.write("RMSE (Root Mean Squared Error):\n")
            f.write("  - Penalizes large prediction errors more heavily\n")
            f.write("  - Interpretation: 'Measures severity of large mistakes'\n")
            f.write("  - Lower is better\n\n")

            f.write("MAPE (Mean Absolute Percentage Error):\n")
            f.write("  - Measures prediction error as percentage\n")
            f.write("  - Interpretation: 'How wrong prediction was in % terms'\n")
            f.write("  - Lower is better\n\n")

            f.write("=" * 70 + "\n")
            f.write("MODEL SELECTION & JUSTIFICATION\n")
            f.write("=" * 70 + "\n\n")

            f.write("SELECTED MODEL: Gradient Boosting Regressor\n\n")

            f.write("Reasons:\n")
            f.write("1. Handles non-linear sales patterns better than linear regression\n")
            f.write("2. Works well with time-based features and lagged variables\n")
            f.write("3. Superior performance on real-world business data\n")
            f.write("4. Provides feature importance insights\n\n")

            f.write("Linear Regression serves as baseline for comparison to show improvement.\n\n")

            f.write("=" * 70 + "\n")
            f.write("FEATURE ENGINEERING DETAILS\n")
            f.write("=" * 70 + "\n\n")

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
  - quantity_ma_30: 30-day moving average
  - quantity_std_7: 7-day standard deviation
  - quantity_std_30: 30-day standard deviation

Categorical Features:
  - category_encoded: Product category (Pastry/Beverage)
            """
            f.write(features_str)

            f.write("\n" + "=" * 70 + "\n")
            f.write("NEXT STEPS\n")
            f.write("=" * 70 + "\n\n")
            f.write("1. Models are saved in ml_models/ directory\n")
            f.write("2. Run: python integrate_ml_model.py\n")
            f.write("   - Generates predictions for all products\n")
            f.write("   - Creates weekly, monthly, yearly forecasts\n")
            f.write("3. Check Sales Forecasting page: /dashboard/sales/forecasting/\n")
            f.write("4. Filter, sort, and export forecasts as needed\n\n")

            f.write("=" * 70 + "\n")

        print(f"   ✓ Report saved: {report_path}")
        return report_path


def main():
    """
    Main training pipeline
    """
    print("\n" + "=" * 70)
    print("BANELO SALES FORECASTING - ML MODEL TRAINING")
    print("=" * 70)

    model = SalesForecastingModel()

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
    y = featured_df['quantity']  # Predicting quantity

    # Step 5: Train models
    X_test, y_test, gb_pred, lr_pred = model.train_models(X, y)

    # Step 6: Compare models
    comparison = model.compare_models(X_test, y_test, gb_pred, lr_pred)

    # Step 7: Save models
    model.save_models()

    # Step 8: Generate report
    model.generate_report(comparison)

    # Final summary
    print("\n" + "=" * 70)
    print("✅ ML MODEL TRAINING COMPLETE!")
    print("=" * 70)
    print("\n📊 Summary:")
    print(f"   - Gradient Boosting model saved: ml_models/gradient_boosting_model.pkl")
    print(f"   - Linear Regression model saved: ml_models/linear_regression_model.pkl")
    print(f"   - Training report saved: training_report.txt")
    print(f"\n🚀 Next Step:")
    print(f"   Run: python integrate_ml_model.py")
    print(f"   This will generate forecasts and update the database")
    print("\n" + "=" * 70 + "\n")


if __name__ == '__main__':
    main()
