"""
Comprehensive ML Model Training and Evaluation for Banelo Sales Forecasting
Run this in Google Colab to get complete results for all 6 models
"""

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from xgboost import XGBRegressor
from lightgbm import LGBMRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score, mean_absolute_percentage_error
import time

print("="*80)
print("BANELO SALES FORECASTING - COMPREHENSIVE MODEL EVALUATION")
print("="*80)

# ============================================
# 1. LOAD AND PREPARE DATA
# ============================================
print("\n[1] LOADING DATASET...")

# Upload your sales_for_colab.csv to Colab first, then uncomment:
# from google.colab import files
# uploaded = files.upload()

df = pd.read_csv('sales_for_colab.csv')
print(f"✓ Dataset loaded: {len(df)} records")

# Filter valid sales (quantity > 0)
df = df[df['quantity'] > 0]
print(f"✓ After filtering: {len(df)} valid sales records")

# Convert date to numeric features
df['date'] = pd.to_datetime(df['date'])
df['day'] = df['date'].dt.day
df['month'] = df['date'].dt.month
df['day_of_week'] = df['date'].dt.dayofweek
df['year'] = df['date'].dt.year

print("\n[2] FEATURE ENGINEERING...")

# Create features
X = df[['day', 'month', 'day_of_week']]
y = df['quantity']

print(f"✓ Features (X): {X.shape}")
print(f"✓ Target (y): {y.shape}")
print(f"✓ Features used: {list(X.columns)}")

# ============================================
# 2. TRAIN-TEST SPLIT
# ============================================
print("\n[3] SPLITTING DATA...")

# Use 80-20 split (standard for ML)
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

print(f"✓ Training set: {len(X_train)} samples ({len(X_train)/len(X)*100:.1f}%)")
print(f"✓ Test set: {len(X_test)} samples ({len(X_test)/len(X)*100:.1f}%)")

# ============================================
# 3. DEFINE ALL 6 MODELS
# ============================================
print("\n[4] DEFINING MODELS...")

models = {
    'Linear Regression': LinearRegression(),
    'Decision Tree': DecisionTreeRegressor(random_state=42, max_depth=10),
    'Random Forest': RandomForestRegressor(n_estimators=100, random_state=42, max_depth=10),
    'Gradient Boosting': GradientBoostingRegressor(n_estimators=100, random_state=42, max_depth=5),
    'XGBoost': XGBRegressor(n_estimators=100, random_state=42, max_depth=5),
    'LightGBM': LGBMRegressor(n_estimators=100, random_state=42, max_depth=5, verbose=-1)
}

print(f"✓ {len(models)} models defined")

# ============================================
# 4. TRAIN AND EVALUATE ALL MODELS
# ============================================
print("\n" + "="*80)
print("TRAINING AND EVALUATION RESULTS")
print("="*80)

results = []

for name, model in models.items():
    print(f"\n{'='*80}")
    print(f"MODEL: {name}")
    print(f"{'='*80}")

    # --- TRAINING ---
    print(f"\n[Training {name}...]")
    start_time = time.time()
    model.fit(X_train, y_train)
    training_time = time.time() - start_time
    print(f"✓ Training completed in {training_time:.4f} seconds")

    # --- PREDICTIONS ---
    start_pred_time = time.time()
    y_train_pred = model.predict(X_train)
    y_test_pred = model.predict(X_test)
    prediction_time = time.time() - start_pred_time

    # --- TRAINING METRICS ---
    train_mae = mean_absolute_error(y_train, y_train_pred)
    train_rmse = np.sqrt(mean_squared_error(y_train, y_train_pred))
    train_r2 = r2_score(y_train, y_train_pred)

    # --- TEST/VALIDATION METRICS ---
    test_mae = mean_absolute_error(y_test, y_test_pred)
    test_rmse = np.sqrt(mean_squared_error(y_test, y_test_pred))
    test_r2 = r2_score(y_test, y_test_pred)
    test_mse = mean_squared_error(y_test, y_test_pred)
    test_mape = mean_absolute_percentage_error(y_test, y_test_pred) * 100

    # --- OVERFITTING CHECK ---
    mae_gap = test_mae - train_mae
    rmse_gap = test_rmse - train_rmse

    # --- CROSS-VALIDATION (5-Fold) ---
    print(f"[Running 5-Fold Cross-Validation...]")
    cv_scores = cross_val_score(model, X_train, y_train,
                                 cv=5, scoring='neg_mean_absolute_error')
    cv_mae_mean = -cv_scores.mean()
    cv_mae_std = cv_scores.std()

    # --- DISPLAY RESULTS ---
    print(f"\n{'─'*80}")
    print(f"PERFORMANCE METRICS")
    print(f"{'─'*80}")

    print(f"\n📊 TEST SET PERFORMANCE (PRIMARY METRICS):")
    print(f"   MAE (Mean Absolute Error):       {test_mae:.4f} units")
    print(f"   RMSE (Root Mean Squared Error):  {test_rmse:.4f} units")
    print(f"   MSE (Mean Squared Error):        {test_mse:.4f} units²")
    print(f"   R² (R-squared):                  {test_r2:.4f} ({test_r2*100:.2f}%)")
    print(f"   MAPE (Mean Abs Percentage Error): {test_mape:.2f}%")

    print(f"\n📈 TRAINING SET PERFORMANCE:")
    print(f"   Training MAE:   {train_mae:.4f} units")
    print(f"   Training RMSE:  {train_rmse:.4f} units")
    print(f"   Training R²:    {train_r2:.4f} ({train_r2*100:.2f}%)")

    print(f"\n🔍 OVERFITTING ANALYSIS:")
    print(f"   MAE Gap (Test - Train):  {mae_gap:.4f} units")
    print(f"   RMSE Gap (Test - Train): {rmse_gap:.4f} units")
    if mae_gap < 0.1:
        print(f"   ✓ Minimal overfitting (excellent generalization)")
    elif mae_gap < 0.3:
        print(f"   ✓ Acceptable overfitting (good generalization)")
    else:
        print(f"   ⚠ Possible overfitting (larger gap)")

    print(f"\n🔄 5-FOLD CROSS-VALIDATION:")
    print(f"   CV MAE (Mean ± Std): {cv_mae_mean:.4f} ± {cv_mae_std:.4f}")
    print(f"   This shows consistency across different data splits")

    print(f"\n⏱️  EFFICIENCY METRICS:")
    print(f"   Training Time:     {training_time:.4f} seconds")
    print(f"   Prediction Time:   {prediction_time:.4f} seconds")
    print(f"   Speed: {'INSTANT' if training_time < 0.01 else 'FAST' if training_time < 0.1 else 'MODERATE'}")

    # Store results
    results.append({
        'Model': name,
        'MAE': test_mae,
        'RMSE': test_rmse,
        'MSE': test_mse,
        'R²': test_r2,
        'MAPE (%)': test_mape,
        'Train MAE': train_mae,
        'Train RMSE': train_rmse,
        'Train R²': train_r2,
        'MAE Gap': mae_gap,
        'RMSE Gap': rmse_gap,
        'CV MAE Mean': cv_mae_mean,
        'CV MAE Std': cv_mae_std,
        'Training Time (s)': training_time,
        'Prediction Time (s)': prediction_time
    })

# ============================================
# 5. COMPREHENSIVE COMPARISON TABLE
# ============================================
print(f"\n\n{'='*80}")
print("COMPREHENSIVE MODEL COMPARISON")
print(f"{'='*80}\n")

results_df = pd.DataFrame(results)

# Sort by MAE (best first)
results_df = results_df.sort_values('MAE')
results_df['Rank'] = range(1, len(results_df) + 1)

# Display full comparison
print(results_df.to_string(index=False))

# ============================================
# 6. KEY FINDINGS SUMMARY
# ============================================
print(f"\n\n{'='*80}")
print("KEY FINDINGS")
print(f"{'='*80}\n")

best_model = results_df.iloc[0]
worst_model = results_df.iloc[-1]

print(f"🏆 BEST MODEL: {best_model['Model']}")
print(f"   • Lowest MAE: {best_model['MAE']:.4f} units")
print(f"   • RMSE: {best_model['RMSE']:.4f} units")
print(f"   • R²: {best_model['R²']:.4f} ({best_model['R²']*100:.2f}%)")
print(f"   • Training Time: {best_model['Training Time (s)']:.4f} seconds")
print(f"   • Overfitting Gap: {best_model['MAE Gap']:.4f} units")

print(f"\n❌ WORST MODEL: {worst_model['Model']}")
print(f"   • Highest MAE: {worst_model['MAE']:.4f} units")
print(f"   • RMSE: {worst_model['RMSE']:.4f} units")
print(f"   • R²: {worst_model['R²']:.4f}")

print(f"\n📊 PERFORMANCE RANGE:")
print(f"   • MAE Range: {results_df['MAE'].min():.4f} to {results_df['MAE'].max():.4f}")
print(f"   • Improvement: {((worst_model['MAE'] - best_model['MAE']) / worst_model['MAE'] * 100):.2f}%")

print(f"\n⚡ FASTEST MODEL: {results_df.iloc[results_df['Training Time (s)'].argmin()]['Model']}")
print(f"   • Training Time: {results_df['Training Time (s)'].min():.4f} seconds")

print(f"\n✓ BEST GENERALIZATION: {results_df.iloc[results_df['MAE Gap'].argmin()]['Model']}")
print(f"   • MAE Gap: {results_df['MAE Gap'].min():.4f} units (minimal overfitting)")

# ============================================
# 7. DETAILED METRICS TABLE FOR REPORT
# ============================================
print(f"\n\n{'='*80}")
print("DETAILED METRICS TABLE (COPY TO YOUR PAPER)")
print(f"{'='*80}\n")

# Create a clean table for the paper
paper_table = results_df[['Rank', 'Model', 'MAE', 'RMSE', 'R²', 'MAPE (%)',
                          'Training Time (s)', 'MAE Gap']].copy()
paper_table.columns = ['Rank', 'Model', 'MAE', 'RMSE', 'R²', 'MAPE (%)',
                       'Training Time (s)', 'Overfitting Gap']

print(paper_table.to_string(index=False))

# ============================================
# 8. EXPORT RESULTS
# ============================================
print(f"\n\n{'='*80}")
print("EXPORTING RESULTS")
print(f"{'='*80}\n")

# Save to CSV
results_df.to_csv('model_evaluation_results.csv', index=False)
print("✓ Full results saved to: model_evaluation_results.csv")

paper_table.to_csv('model_comparison_table.csv', index=False)
print("✓ Paper table saved to: model_comparison_table.csv")

print("\n" + "="*80)
print("EVALUATION COMPLETE!")
print("="*80)
print("\n💡 Use these results in your KDD paper's Results section")
print("📊 The best model is ready for deployment in the Banelo POS system")
