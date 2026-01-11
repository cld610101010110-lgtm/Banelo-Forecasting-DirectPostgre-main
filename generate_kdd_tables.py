"""
Generate publication-quality table images for KDD Paper
"""

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import Rectangle
import os

# Set high quality for images
plt.rcParams['figure.dpi'] = 300
plt.rcParams['savefig.dpi'] = 300
plt.rcParams['font.family'] = 'serif'
plt.rcParams['font.size'] = 11

# Create output directory
os.makedirs('kdd_tables', exist_ok=True)

# ============================================
# Table 1: Linear Regression Model Performance Metrics
# ============================================
fig, ax = plt.subplots(figsize=(14, 4))
ax.axis('tight')
ax.axis('off')

# Table data
table1_data = [
    ['Metric', 'Value', 'Interpretation'],
    ['MAE (Mean Absolute Error)', '1.06 units', 'Average prediction error is approximately 1 unit'],
    ['RMSE (Root Mean Squared Error)', '1.27 units', 'Error metric that penalizes larger deviations'],
    ['MAPE (Mean Absolute Percentage Error)', '55.13%', 'Average percentage deviation from actual values'],
    ['R² (Coefficient of Determination)', '0.1897', 'Model explains ~19% of sales variance'],
    ['Training Time', '0.009 sec', 'Real-time prediction capability']
]

table1 = ax.table(cellText=table1_data, cellLoc='left', loc='center',
                  colWidths=[0.35, 0.15, 0.5])

table1.auto_set_font_size(False)
table1.set_fontsize(11)
table1.scale(1, 2.2)

# Style the header row
for i in range(3):
    cell = table1[(0, i)]
    cell.set_facecolor('#6D4C41')
    cell.set_text_props(weight='bold', color='white', fontsize=12)
    cell.set_edgecolor('white')
    cell.set_linewidth(2)

# Style data rows - alternating colors
for i in range(1, 6):
    for j in range(3):
        cell = table1[(i, j)]
        if i % 2 == 0:
            cell.set_facecolor('#F5F5DC')
        else:
            cell.set_facecolor('white')
        cell.set_edgecolor('#8D6E63')
        cell.set_linewidth(1)

        # Bold the first column
        if j == 0:
            cell.set_text_props(weight='bold', fontsize=10.5)
        # Bold the value column
        if j == 1:
            cell.set_text_props(weight='bold', color='#6D4C41', fontsize=11)

# Add title
plt.title('Table 1: Linear Regression Model Performance Metrics',
          fontsize=14, fontweight='bold', pad=20, loc='left')

plt.tight_layout()
plt.savefig('kdd_tables/table1_performance_metrics.png',
            bbox_inches='tight', facecolor='white', edgecolor='none')
print("✓ Table 1 saved: table1_performance_metrics.png")
plt.close()

# ============================================
# Table 2: Cross-Validation Results (5-Fold)
# ============================================
fig, ax = plt.subplots(figsize=(10, 3.5))
ax.axis('tight')
ax.axis('off')

# Table data
table2_data = [
    ['Metric', 'Value'],
    ['Mean CV MAE', '20.67'],
    ['Standard Deviation', '±39.15'],
    ['Number of Folds', '5'],
    ['Purpose', 'Ensure generalization to unseen data']
]

table2 = ax.table(cellText=table2_data, cellLoc='left', loc='center',
                  colWidths=[0.55, 0.45])

table2.auto_set_font_size(False)
table2.set_fontsize(11)
table2.scale(1, 2.5)

# Style the header row
for i in range(2):
    cell = table2[(0, i)]
    cell.set_facecolor('#6D4C41')
    cell.set_text_props(weight='bold', color='white', fontsize=12)
    cell.set_edgecolor('white')
    cell.set_linewidth(2)

# Style data rows
for i in range(1, 5):
    for j in range(2):
        cell = table2[(i, j)]
        if i % 2 == 0:
            cell.set_facecolor('#F5F5DC')
        else:
            cell.set_facecolor('white')
        cell.set_edgecolor('#8D6E63')
        cell.set_linewidth(1)

        # Bold the first column
        if j == 0:
            cell.set_text_props(weight='bold', fontsize=10.5)
        # Bold the value column
        if j == 1:
            cell.set_text_props(weight='bold', color='#6D4C41', fontsize=11)

# Add title
plt.title('Table 2: Cross-Validation Results (5-Fold)',
          fontsize=14, fontweight='bold', pad=20, loc='left')

plt.tight_layout()
plt.savefig('kdd_tables/table2_cross_validation.png',
            bbox_inches='tight', facecolor='white', edgecolor='none')
print("✓ Table 2 saved: table2_cross_validation.png")
plt.close()

# ============================================
# Table 3: Category-Specific Performance Analysis
# ============================================
fig, ax = plt.subplots(figsize=(10, 3))
ax.axis('tight')
ax.axis('off')

# Table data
table3_data = [
    ['Category', 'MAE', 'RMSE', 'R² Score'],
    ['Beverages', '1.08', '1.30', '0.18'],
    ['Pastries', '1.05', '1.26', '0.19'],
    ['Overall', '1.06', '1.27', '0.1897']
]

table3 = ax.table(cellText=table3_data, cellLoc='center', loc='center',
                  colWidths=[0.3, 0.23, 0.23, 0.24])

table3.auto_set_font_size(False)
table3.set_fontsize(11)
table3.scale(1, 2.8)

# Style the header row
for i in range(4):
    cell = table3[(0, i)]
    cell.set_facecolor('#6D4C41')
    cell.set_text_props(weight='bold', color='white', fontsize=12)
    cell.set_edgecolor('white')
    cell.set_linewidth(2)

# Style data rows
for i in range(1, 4):
    for j in range(4):
        cell = table3[(i, j)]
        if i % 2 == 0:
            cell.set_facecolor('#F5F5DC')
        else:
            cell.set_facecolor('white')
        cell.set_edgecolor('#8D6E63')
        cell.set_linewidth(1)

        # Bold the first column (category names)
        if j == 0:
            cell.set_text_props(weight='bold', fontsize=11)
        else:
            cell.set_text_props(weight='bold', color='#6D4C41', fontsize=11)

        # Highlight "Overall" row
        if i == 3:
            cell.set_facecolor('#D7CCC8')
            cell.set_text_props(weight='bold', fontsize=11.5)

# Add title
plt.title('Table 3: Category-Specific Performance Analysis',
          fontsize=14, fontweight='bold', pad=20, loc='left')

plt.tight_layout()
plt.savefig('kdd_tables/table3_category_performance.png',
            bbox_inches='tight', facecolor='white', edgecolor='none')
print("✓ Table 3 saved: table3_category_performance.png")
plt.close()

print("\n" + "="*60)
print("ALL TABLES GENERATED SUCCESSFULLY!")
print("="*60)
print("\nGenerated files in 'kdd_tables/' folder:")
print("  1. table1_performance_metrics.png")
print("  2. table2_cross_validation.png")
print("  3. table3_category_performance.png")
print("\n✓ All tables are publication-quality (300 DPI)")
print("✓ Using cafe color theme (#6D4C41)")
print("✓ Ready to insert into your KDD Word document")
