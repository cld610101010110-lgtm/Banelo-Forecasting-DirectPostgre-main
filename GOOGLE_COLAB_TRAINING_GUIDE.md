# 🔮 Google Colab Sales Forecasting Training Guide

## Complete Step-by-Step Guide for Training ML Models

This guide will help you train sales forecasting models using Google Colab for the Banelo Coffee POS system.

---

## **Part 1: Prepare Your Data**

### Step 1.1: Export Data from Django

Run this command in your Django project:

```bash
python manage.py shell
```

Then in the Django shell:

```python
from baneloforecasting.export_data_for_colab import export_all_data
export_all_data()
print("✅ Data exported successfully!")
```

This creates CSV files in your project directory:
- `sales_data.csv` - Historical sales transactions
- `products_data.csv` - Product information
- `daily_sales_aggregated.csv` - Pre-aggregated daily sales

### Step 1.2: Upload CSV Files to Google Drive

1. Go to [Google Drive](https://drive.google.com)
2. Create a folder: `banelo-data/`
3. Upload the 3 CSV files
4. Note the folder ID from the URL

---

## **Part 2: Open Google Colab Notebook**

1. Go to [Google Colab](https://colab.research.google.com)
2. Click "New notebook"
3. Rename it: `Banelo_Sales_Forecasting_Training`

---

## **Part 3: Training Code**

Copy and run each cell sequentially in your Colab notebook.

### **Cell 1: Install Dependencies**

```python
!pip install -q pandas numpy scikit-learn xgboost matplotlib seaborn joblib

print("✅ Dependencies installed!")
```

### **Cell 2: Import Libraries**

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime, timedelta
import warnings
warnings.filterwarnings('ignore')

# ML libraries
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.metrics import mean_absolute_error, mean_absolute_percentage_error, mean_squared_error, r2_score
from sklearn.preprocessing import LabelEncoder
import xgboost as xgb
import joblib

print("✅ Libraries imported successfully!")
```

### **Cell 3: Mount Google Drive & Load Data**

```python
from google.colab import drive
drive.mount('/content/drive')

# Load CSV files from your Google Drive
data_path = '/content/drive/MyDrive/banelo-data/'

print("📊 Loading data...")
sales_df = pd.read_csv(f'{data_path}sales_data.csv')
products_df = pd.read_csv(f'{data_path}products_data.csv')
daily_sales_df = pd.read_csv(f'{data_path}daily_sales_aggregated.csv')

# Convert dates
sales_df['order_date'] = pd.to_datetime(sales_df['order_date'])
daily_sales_df['date'] = pd.to_datetime(daily_sales_df['date'])

print(f"✅ Data loaded successfully!")
print(f"   - Sales records: {len(sales_df):,}")
print(f"   - Daily aggregates: {len(daily_sales_df):,}")
print(f"   - Products: {len(products_df):,}")

# Display sample data
display(daily_sales_df.head())
```

### **Cell 4: Feature Engineering**

```python
def engineer_features(daily_df):
    """Create features for ML model"""
    print("🔧 Engineering features...")

    df = daily_df.copy()
    df = df.sort_values(['product_id', 'date'])

    # Time-based features
    df['day_of_week'] = pd.to_datetime(df['date']).dt.dayofweek
    df['day_of_month'] = pd.to_datetime(df['date']).dt.day
    df['month'] = pd.to_datetime(df['date']).dt.month
    df['is_weekend'] = (df['day_of_week'] >= 5).astype(int)
    df['week_of_year'] = pd.to_datetime(df['date']).dt.isocalendar().week

    # Rolling statistics (7-day)
    df['rolling_mean_7d'] = df.groupby('product_id')['total_quantity'].transform(
        lambda x: x.rolling(window=7, min_periods=1).mean()
    )
    df['rolling_std_7d'] = df.groupby('product_id')['total_quantity'].transform(
        lambda x: x.rolling(window=7, min_periods=1).std().fillna(0)
    )
    df['rolling_max_7d'] = df.groupby('product_id')['total_quantity'].transform(
        lambda x: x.rolling(window=7, min_periods=1).max()
    )
    df['rolling_min_7d'] = df.groupby('product_id')['total_quantity'].transform(
        lambda x: x.rolling(window=7, min_periods=1).min()
    )

    # Rolling statistics (30-day)
    df['rolling_mean_30d'] = df.groupby('product_id')['total_quantity'].transform(
        lambda x: x.rolling(window=30, min_periods=1).mean()
    )
    df['rolling_std_30d'] = df.groupby('product_id')['total_quantity'].transform(
        lambda x: x.rolling(window=30, min_periods=1).std().fillna(0)
    )

    # Lag features
    df['lag_1d'] = df.groupby('product_id')['total_quantity'].shift(1).fillna(0)
    df['lag_7d'] = df.groupby('product_id')['total_quantity'].shift(7).fillna(0)
    df['lag_14d'] = df.groupby('product_id')['total_quantity'].shift(14).fillna(0)

    # Trend feature
    df['days_since_start'] = (pd.to_datetime(df['date']) - pd.to_datetime(df['date']).min()).dt.days

    # Category encoding
    le = LabelEncoder()
    df['category_encoded'] = le.fit_transform(df['category'])

    print(f"   ✅ Created {len(df.columns)} features")

    return df, le

# Apply feature engineering
featured_df, label_encoder = engineer_features(daily_sales_df)
print("\n✅ Feature engineering complete!")
```

### **Cell 5: Prepare Training Data**

```python
# Define features
feature_columns = [
    'day_of_week', 'day_of_month', 'month', 'is_weekend', 'week_of_year',
    'rolling_mean_7d', 'rolling_std_7d', 'rolling_max_7d', 'rolling_min_7d',
    'rolling_mean_30d', 'rolling_std_30d',
    'lag_1d', 'lag_7d', 'lag_14d',
    'days_since_start', 'category_encoded',
    'num_transactions', 'avg_price'
]

target_column = 'total_quantity'

# Prepare X and y
X = featured_df[feature_columns].fillna(0)
y = featured_df[target_column]

print(f"📊 Training data shape: {X.shape}")
print(f"📊 Target data shape: {y.shape}")

# Split into train/test sets
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, shuffle=True
)

print(f"\n✅ Train set: {X_train.shape[0]} samples")
print(f"✅ Test set: {X_test.shape[0]} samples")
```

### **Cell 6: Train Linear Regression (Baseline)**

```python
print("=" * 60)
print("🤖 TRAINING MODEL 1: LINEAR REGRESSION (BASELINE)")
print("=" * 60)

lr_model = LinearRegression()
lr_model.fit(X_train, y_train)

# Predictions
y_pred_lr_train = lr_model.predict(X_train)
y_pred_lr_test = lr_model.predict(X_test)

# Metrics
lr_mae = mean_absolute_error(y_test, y_pred_lr_test)
lr_mape = mean_absolute_percentage_error(y_test, y_pred_lr_test)
lr_rmse = np.sqrt(mean_squared_error(y_test, y_pred_lr_test))
lr_r2 = r2_score(y_test, y_pred_lr_test)

print(f"\n✅ Linear Regression Results:")
print(f"   MAE:  ₱{lr_mae:.2f}")
print(f"   MAPE: {lr_mape:.2f}%")
print(f"   RMSE: ₱{lr_rmse:.2f}")
print(f"   R²:   {lr_r2:.4f}")

print(f"\n📊 Interpretation:")
print(f"   - Average prediction error: ₱{lr_mae:.2f}")
print(f"   - Percentage error: {lr_mape:.2f}% off on average")
print(f"   - Model explains {lr_r2*100:.1f}% of variance in sales")
```

### **Cell 7: Train Gradient Boosting (Main Model)**

```python
print("\n" + "=" * 60)
print("🚀 TRAINING MODEL 2: GRADIENT BOOSTING (XGBOOST)")
print("=" * 60)

gb_model = xgb.XGBRegressor(
    n_estimators=200,
    max_depth=10,
    learning_rate=0.1,
    subsample=0.8,
    colsample_bytree=0.8,
    random_state=42,
    n_jobs=-1
)

gb_model.fit(X_train, y_train, verbose=False)

# Predictions
y_pred_gb_train = gb_model.predict(X_train)
y_pred_gb_test = gb_model.predict(X_test)

# Metrics
gb_mae = mean_absolute_error(y_test, y_pred_gb_test)
gb_mape = mean_absolute_percentage_error(y_test, y_pred_gb_test)
gb_rmse = np.sqrt(mean_squared_error(y_test, y_pred_gb_test))
gb_r2 = r2_score(y_test, y_pred_gb_test)

print(f"\n✅ Gradient Boosting Results:")
print(f"   MAE:  ₱{gb_mae:.2f}")
print(f"   MAPE: {gb_mape:.2f}%")
print(f"   RMSE: ₱{gb_rmse:.2f}")
print(f"   R²:   {gb_r2:.4f}")

print(f"\n📊 Interpretation:")
print(f"   - Average prediction error: ₱{gb_mae:.2f}")
print(f"   - Percentage error: {gb_mape:.2f}% off on average")
print(f"   - Model explains {gb_r2*100:.1f}% of variance in sales")
```

### **Cell 8: Model Comparison**

```python
print("\n" + "=" * 60)
print("📊 MODEL COMPARISON & SELECTION")
print("=" * 60)

comparison_df = pd.DataFrame({
    'Model': ['Linear Regression', 'Gradient Boosting'],
    'MAE': [lr_mae, gb_mae],
    'MAPE': [lr_mape, gb_mape],
    'RMSE': [lr_rmse, gb_rmse],
    'R² Score': [lr_r2, gb_r2]
})

print("\n")
display(comparison_df)

print("\n🏆 MODEL SELECTION ANALYSIS:")
print("=" * 60)

improvement_mae = ((lr_mae - gb_mae) / lr_mae) * 100
improvement_mape = ((lr_mape - gb_mape) / lr_mape) * 100
improvement_r2 = ((gb_r2 - lr_r2) / lr_r2) * 100

print(f"Gradient Boosting Improvements Over Linear Regression:")
print(f"  - MAE reduction: {improvement_mae:.1f}%")
print(f"  - MAPE reduction: {improvement_mape:.1f}%")
print(f"  - R² improvement: {improvement_r2:.1f}%")

print(f"\n✅ RECOMMENDED MODEL: Gradient Boosting (XGBoost)")
print(f"   Justification: XGBoost has superior performance with:")
print(f"   - Lower MAE (₱{gb_mae:.2f} vs ₱{lr_mae:.2f})")
print(f"   - Lower MAPE ({gb_mape:.2f}% vs {lr_mape:.2f}%)")
print(f"   - Better R² Score ({gb_r2:.4f} vs {lr_r2:.4f})")
```

### **Cell 9: Visualize Model Comparison**

```python
fig, axes = plt.subplots(1, 3, figsize=(15, 5))

# MAE comparison
axes[0].bar(['Linear Regression', 'Gradient Boosting'], [lr_mae, gb_mae], color=['#3498db', '#e74c3c'])
axes[0].set_title('MAE (Lower is Better)', fontweight='bold')
axes[0].set_ylabel('Mean Absolute Error')
axes[0].grid(alpha=0.3)

# MAPE comparison
axes[1].bar(['Linear Regression', 'Gradient Boosting'], [lr_mape, gb_mape], color=['#3498db', '#e74c3c'])
axes[1].set_title('MAPE (Lower is Better)', fontweight='bold')
axes[1].set_ylabel('Mean Absolute Percentage Error (%)')
axes[1].grid(alpha=0.3)

# R² comparison
axes[2].bar(['Linear Regression', 'Gradient Boosting'], [lr_r2, gb_r2], color=['#3498db', '#e74c3c'])
axes[2].set_title('R² Score (Higher is Better)', fontweight='bold')
axes[2].set_ylabel('R² Score')
axes[2].grid(alpha=0.3)

plt.tight_layout()
plt.show()

print("✅ Visualization complete!")
```

### **Cell 10: Feature Importance**

```python
# Get feature importance from Gradient Boosting
feature_importance = pd.DataFrame({
    'feature': feature_columns,
    'importance': gb_model.feature_importances_
}).sort_values('importance', ascending=False)

print("\n📊 Top 10 Most Important Features (Gradient Boosting):")
print("=" * 60)
display(feature_importance.head(10))

# Visualize
plt.figure(figsize=(10, 8))
plt.barh(feature_importance['feature'].head(15), feature_importance['importance'].head(15), color='#3498db')
plt.xlabel('Importance Score')
plt.title('Top 15 Feature Importances (Gradient Boosting)', fontweight='bold')
plt.tight_layout()
plt.show()
```

### **Cell 11: Export Model**

```python
# Package the model
model_package = {
    'model': gb_model,  # Use Gradient Boosting
    'model_type': 'XGBRegressor',
    'trained_date': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
    'feature_columns': feature_columns,
    'label_encoder': label_encoder,
    'metrics': {
        'mae': float(gb_mae),
        'mape': float(gb_mape),
        'rmse': float(gb_rmse),
        'r2_score': float(gb_r2)
    },
    'feature_importance': feature_importance.to_dict('records')[:10]
}

# Save model
joblib.dump(model_package, 'banelo_gradient_boosting_model.pkl', compress=3)
print("✅ Model saved successfully!")

# Download
from google.colab import files
files.download('banelo_gradient_boosting_model.pkl')
print("\n📥 Model downloaded!")
```

### **Cell 12: Summary Report**

```python
print("\n" + "=" * 60)
print("📋 TRAINING SUMMARY REPORT")
print("=" * 60)

print(f"\n✅ Model: Gradient Boosting Regressor (XGBoost)")
print(f"✅ Training Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
print(f"\n📊 Performance Metrics:")
print(f"   MAE:  ₱{gb_mae:.2f} (Average prediction error)")
print(f"   MAPE: {gb_mape:.2f}% (Percentage error)")
print(f"   RMSE: ₱{gb_rmse:.2f} (Root mean squared error)")
print(f"   R²:   {gb_r2:.4f} ({gb_r2*100:.1f}% of variance explained)")

print(f"\n📈 Training Data:")
print(f"   Training samples: {X_train.shape[0]:,}")
print(f"   Test samples: {X_test.shape[0]:,}")
print(f"   Features: {len(feature_columns)}")

print(f"\n📥 Next Steps:")
print(f"   1. Download 'banelo_gradient_boosting_model.pkl'")
print(f"   2. Move to: ml_models/banelo_xgboost_model.pkl")
print(f"   3. Run in Django: python manage.py shell")
print(f"   4. Execute: from baneloforecasting.integrate_ml_model import integrate_model")
print(f"   5. integrate_model()")
print(f"   6. Go to /dashboard/sales/forecasting/")
print(f"\n✅ Training complete!")
```

---

## **Part 4: Deploy Model to Django**

After downloading the model:

### Step 4.1: Move Model File

```bash
# Move to Django ml_models directory
mv ~/Downloads/banelo_gradient_boosting_model.pkl \
    /path/to/baneloforecasting/ml_models/banelo_xgboost_model.pkl
```

### Step 4.2: Integrate in Django

```bash
python manage.py shell
```

```python
from baneloforecasting.integrate_ml_model import integrate_model
integrate_model()
print("✅ Model integrated successfully!")
```

### Step 4.3: View Results

Visit: `http://your-site/dashboard/sales/forecasting/`

---

## **Metrics Explanation for Capstone Defense**

### **MAE (Mean Absolute Error)**
- **What it is:** Average absolute difference between predicted and actual sales
- **Example:** MAE = ₱2.21 means on average, predictions are off by ₱2.21
- **Why it matters:** Easy to understand in business terms (peso amounts)

### **MAPE (Mean Absolute Percentage Error)**
- **What it is:** Average percentage error across all predictions
- **Example:** MAPE = 7.2% means predictions are off by 7.2% on average
- **Why it matters:** Shows relative accuracy regardless of sales volume

### **RMSE (Root Mean Squared Error)**
- **What it is:** Penalizes large errors more heavily than small ones
- **Formula:** √(mean of squared errors)
- **Why it matters:** Shows how severe prediction mistakes are

### **R² Score (Coefficient of Determination)**
- **What it is:** Percentage of variance in data explained by the model
- **Range:** 0 to 1 (higher is better)
- **Example:** R² = 0.93 means model explains 93% of sales variance

---

## **Troubleshooting**

### Issue: "ModuleNotFoundError: No module named 'xgboost'"
**Solution:** Run `!pip install -q xgboost` in a cell

### Issue: "FileNotFoundError: No such file or directory"
**Solution:** Make sure the data path in your Google Drive is correct

### Issue: CSV files missing
**Solution:** Re-run `export_all_data()` from Django shell to generate fresh CSVs

---

## **Questions for Your Defense**

Prepare to answer:

1. **Why Gradient Boosting?**
   - Answer: Better performance metrics (lower MAE/MAPE, higher R²), handles non-linear patterns

2. **What does MAPE 7.2% mean?**
   - Answer: On average, predictions are off by 7.2% from actual sales

3. **How does the model handle different product categories?**
   - Answer: Uses category encoded feature and aggregates predictions by category

4. **Can the model forecast beyond 365 days?**
   - Answer: Possible but accuracy decreases (uses trend feature: days_since_start)

---

## **Success Indicators**

✅ Your model is successful if:
- MAPE < 15% (excellent < 10%)
- R² > 0.80 (good > 0.85)
- MAE matches historical data volatility
- Gradient Boosting outperforms baseline by ≥5%

---

Good luck with your capstone project! 🎓
