# Figure Titles and Explanations for Figures 51-55
## Ready-to-Use Captions for KDD Document

---

## Figure 51: Linear Regression Model Results

**Title:**
Figure 51. Actual vs Predicted Sales Using Linear Regression Model

**Note:**
This figure demonstrates the performance of the Linear Regression model when applied to the Banelo sales forecasting task. The scatter plot compares actual sales (x-axis) with predicted sales (y-axis), where each point represents a sales transaction. The model parameters displayed at the top show the intercept (0.8890) and coefficients [0.9131, 0.2374, -0.0671] that define the linear relationship. The close clustering of points around the diagonal reference line indicates strong prediction accuracy, with the model achieving MAE of 1.06 units. This visual evidence confirms Linear Regression as the best fit model for the Banelo forecasting system.

---

## Figure 52: Model Performance Comparison

**Title:**
Figure 52. Model Performance Comparison: Error Margins Determine Best Model

**Note:**
This figure presents a comprehensive comparison of prediction accuracy across all six machine learning models tested. The bar chart displays two key error metrics: Mean Absolute Error (MAE, green bars) and Root Mean Squared Error (RMSE, red bars) for each model. Linear Regression achieved the lowest error margins (MAE: 1.0623, RMSE: 1.2694), clearly demonstrating superior performance. Lower values indicate better prediction accuracy, with MAE representing the average prediction error in units and RMSE penalizing larger errors more heavily. This empirical comparison proves Linear Regression is the optimal model choice for deployment in the Banelo POS system.

---

## Figure 53: Linear Regression Model in Use

**Title:**
Figure 53. Using Linear Regression Model to Predict Sales: Real-World Performance

**Note:**
This figure shows the Linear Regression model in actual use, predicting sales across 15 sample transactions. The line graph displays predicted sales (red line with square markers) overlaid with actual sales (blue dots), where error bars indicate the magnitude of prediction errors. The close alignment between predicted and actual values demonstrates the model's practical reliability when deployed in the Banelo system. Small error bars confirm accurate predictions with minimal deviation, proving the model performs consistently well on real sales data. This visualization validates that the model's performance generalizes beyond training data to actual business scenarios.

---

## Figure 54: Lowest Prediction Error Analysis

**Title:**
Figure 54. Lowest Prediction Error: Why Linear Regression is Best

**Note:**
This figure isolates the Mean Absolute Error (MAE) metric to clearly demonstrate why Linear Regression is the optimal model choice. The bar chart compares MAE values across all six models, with Linear Regression (LR) highlighted in green achieving the lowest error of 1.0623 units. This means predictions are accurate within approximately 1 unit on average—the best performance among all models tested. Random Forest (1.1123), XGBoost (1.1189), LightGBM (1.1191), and Gradient Boosting (1.1200) achieved similar but higher errors, while Decision Tree (1.2826) performed worst. Lower MAE directly translates to more accurate sales forecasts, making Linear Regression the best fit for the Banelo forecasting system.

---

## Figure 55: Fastest Training Speed

**Title:**
Figure 55. Fastest Training Speed: Linear Regression Converges Instantly

**Note:**
This figure compares training time efficiency across all six models, revealing a critical practical advantage of Linear Regression. The bar chart shows Linear Regression requires only 0.009 seconds to train—marked as "FASTEST" in green—because it uses an analytical solution (normal equation) rather than iterative optimization. In contrast, Random Forest (0.145s), XGBoost (0.189s), LightGBM (0.098s), and Gradient Boosting (0.234s) require significantly longer training times due to iterative learning processes. This instant convergence enables real-time model updates in the Banelo POS system as new sales data arrives throughout operating hours, providing a decisive practical advantage for deployment alongside Linear Regression's superior accuracy.

---

## Quick Copy-Paste Format

### For Figure 51:
**Title:** Figure 51. Actual vs Predicted Sales Using Linear Regression Model
**Note:** This figure demonstrates the performance of the Linear Regression model when applied to the Banelo sales forecasting task. The scatter plot compares actual sales with predicted sales, showing close clustering of points around the diagonal reference line, indicating strong prediction accuracy with MAE of 1.06 units.

### For Figure 52:
**Title:** Figure 52. Model Performance Comparison: Error Margins Determine Best Model
**Note:** This figure presents a comprehensive comparison of prediction accuracy across all six machine learning models. Linear Regression achieved the lowest error margins (MAE: 1.0623, RMSE: 1.2694), demonstrating superior performance and proving it is the optimal model choice for the Banelo system.

### For Figure 53:
**Title:** Figure 53. Using Linear Regression Model to Predict Sales: Real-World Performance
**Note:** This figure shows the Linear Regression model in actual use across 15 sample transactions. The close alignment between predicted sales (red line) and actual sales (blue dots) with small error bars demonstrates the model's practical reliability when deployed in real-world scenarios.

### For Figure 54:
**Title:** Figure 54. Lowest Prediction Error: Why Linear Regression is Best
**Note:** This figure isolates the Mean Absolute Error (MAE) metric across all six models. Linear Regression achieved the lowest error of 1.0623 units (highlighted in green), meaning predictions are accurate within approximately 1 unit on average—the best performance among all models tested.

### For Figure 55:
**Title:** Figure 55. Fastest Training Speed: Linear Regression Converges Instantly
**Note:** This figure compares training time efficiency, showing Linear Regression requires only 0.009 seconds to train (marked "FASTEST") due to its analytical solution. This instant convergence enables real-time model updates in the Banelo POS system, providing a decisive practical advantage alongside superior accuracy.

---

## How to Insert in Word

1. **Place cursor** below the figure image
2. **Type or paste the title** in bold: `Figure 51. Actual vs Predicted Sales Using Linear Regression Model`
3. **Add the note** below the title in regular text
4. **Optional:** Format the title as a Word caption using Insert → Caption

---

## Summary Table

| Figure | Main Message | Key Metric | Why Important |
|--------|--------------|------------|---------------|
| 51 | LR model results | MAE: 1.06 | Visual proof of best fit |
| 52 | All models compared | MAE: 1.06 lowest | Empirical comparison |
| 53 | Model in use | Small error bars | Real-world validation |
| 54 | Lowest error | MAE: 1.06 best | Proves accuracy superiority |
| 55 | Fastest training | 0.009 seconds | Proves speed advantage |

---

**Created:** 2026-01-27
**For:** Figures 51-55 in KDD Document
**Status:** Ready to copy-paste into Word document
