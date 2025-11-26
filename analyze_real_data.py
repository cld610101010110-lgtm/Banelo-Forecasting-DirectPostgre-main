"""
Analyze Real Data from CSV Files
==================================

This script analyzes your real sales data to understand patterns
and determine if you have enough data for ML training.

Safe Operation:
- READ ONLY - Does not modify any files or database
- Works with CSV files from your Google Drive
- Generates statistics and recommendations

Usage:
    1. Download CSV files from Google Drive to ./real_data/ folder
    2. Run: python analyze_real_data.py
"""

import os
import sys
from datetime import datetime, timedelta
import csv
from collections import defaultdict

# Expected CSV files from Google Drive
EXPECTED_FILES = {
    'sales': 'sales_data.csv',
    'products': 'products_data.csv',
    'recipes': 'recipes_data.csv',
    'recipe_ingredients': 'recipe_ingredients.csv'
}

# Data directory
DATA_DIR = 'real_data'


def ensure_data_directory():
    """Create data directory if it doesn't exist"""
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR)
        print(f"✅ Created directory: {DATA_DIR}/")
        print(f"\n📥 NEXT STEP: Download your CSV files from Google Drive")
        print(f"   and place them in the '{DATA_DIR}/' folder\n")
        return False
    return True


def check_files_exist():
    """Check which CSV files are available"""
    print("=" * 70)
    print("CHECKING AVAILABLE DATA FILES")
    print("=" * 70)

    available = {}
    missing = []

    for key, filename in EXPECTED_FILES.items():
        filepath = os.path.join(DATA_DIR, filename)
        if os.path.exists(filepath):
            size = os.path.getsize(filepath)
            available[key] = filepath
            print(f"✅ Found: {filename} ({size:,} bytes)")
        else:
            missing.append(filename)
            print(f"❌ Missing: {filename}")

    if missing:
        print(f"\n⚠️  Please add these files to '{DATA_DIR}/' folder:")
        for filename in missing:
            print(f"   - {filename}")
        print()

    return available


def analyze_sales_data(filepath):
    """Analyze sales data CSV"""
    print("\n" + "=" * 70)
    print("📊 ANALYZING SALES DATA")
    print("=" * 70)

    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            sales = list(reader)

        if not sales:
            print("⚠️  No sales data found in CSV")
            return None

        # Basic statistics
        total_sales = len(sales)
        print(f"\n📈 Total Sales Records: {total_sales}")

        # Date range analysis
        dates = []
        for sale in sales:
            try:
                if 'order_date' in sale:
                    date_str = sale['order_date'].split()[0]  # Get date part
                    dates.append(datetime.strptime(date_str, '%Y-%m-%d'))
            except:
                continue

        if dates:
            min_date = min(dates)
            max_date = max(dates)
            days_range = (max_date - min_date).days + 1

            print(f"📅 Date Range: {min_date.strftime('%Y-%m-%d')} to {max_date.strftime('%Y-%m-%d')}")
            print(f"📆 Total Days Covered: {days_range} days")
            print(f"📊 Average Sales per Day: {total_sales / days_range:.1f}")

            # ML readiness assessment
            print(f"\n🤖 ML TRAINING READINESS:")
            if days_range >= 90:
                print(f"   ✅ EXCELLENT - {days_range} days is great for training!")
            elif days_range >= 60:
                print(f"   ✅ GOOD - {days_range} days is sufficient for thesis")
            elif days_range >= 30:
                print(f"   ⚠️  ACCEPTABLE - {days_range} days is minimum for basic models")
            else:
                print(f"   ❌ LIMITED - {days_range} days may need synthetic data supplement")

        # Product analysis
        product_sales = defaultdict(int)
        product_quantities = defaultdict(float)
        categories = defaultdict(int)

        for sale in sales:
            product = sale.get('product_name', 'Unknown')
            category = sale.get('category', 'Unknown')
            qty = float(sale.get('quantity', 0))

            product_sales[product] += 1
            product_quantities[product] += qty
            categories[category] += 1

        print(f"\n📦 Products in Dataset: {len(product_sales)}")
        print(f"🏷️  Categories: {len(categories)}")

        # Top products
        print(f"\n🏆 TOP 10 PRODUCTS BY SALES COUNT:")
        sorted_products = sorted(product_sales.items(), key=lambda x: x[1], reverse=True)
        for i, (product, count) in enumerate(sorted_products[:10], 1):
            qty = product_quantities[product]
            print(f"   {i:2d}. {product[:40]:40s} - {count:4d} sales ({qty:.0f} units)")

        # Category breakdown
        print(f"\n📊 SALES BY CATEGORY:")
        sorted_categories = sorted(categories.items(), key=lambda x: x[1], reverse=True)
        for category, count in sorted_categories:
            percentage = (count / total_sales) * 100
            print(f"   {category:20s}: {count:5d} sales ({percentage:5.1f}%)")

        # Generate recommendation
        print(f"\n💡 RECOMMENDATIONS:")
        if total_sales >= 200 and days_range >= 60:
            print(f"   ✅ Your data is GOOD for ML training!")
            print(f"   ✅ Proceed with real data only for thesis")
        elif total_sales >= 100:
            print(f"   ⚠️  Your data is ACCEPTABLE for ML training")
            print(f"   💡 Consider generating synthetic data to supplement")
        else:
            print(f"   ⚠️  Limited data - synthetic data recommended")
            print(f"   💡 We'll create synthetic data based on your real patterns")

        return {
            'total_sales': total_sales,
            'days_range': days_range if dates else 0,
            'products': len(product_sales),
            'categories': len(categories),
            'top_products': sorted_products[:10],
            'category_breakdown': sorted_categories
        }

    except Exception as e:
        print(f"❌ Error analyzing sales data: {e}")
        import traceback
        traceback.print_exc()
        return None


def analyze_products_data(filepath):
    """Analyze products data CSV"""
    print("\n" + "=" * 70)
    print("📦 ANALYZING PRODUCTS DATA")
    print("=" * 70)

    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            products = list(reader)

        print(f"\n📊 Total Products: {len(products)}")

        # Category breakdown
        categories = defaultdict(int)
        for product in products:
            category = product.get('category', 'Unknown')
            categories[category] += 1

        print(f"\n📊 PRODUCTS BY CATEGORY:")
        for category, count in sorted(categories.items(), key=lambda x: x[1], reverse=True):
            print(f"   {category:20s}: {count:3d} products")

        return {'total_products': len(products), 'categories': len(categories)}

    except Exception as e:
        print(f"❌ Error analyzing products: {e}")
        return None


def generate_summary_report(sales_stats, products_stats):
    """Generate final summary and recommendations"""
    print("\n" + "=" * 70)
    print("📋 SUMMARY REPORT")
    print("=" * 70)

    if sales_stats:
        print(f"\n✅ Sales Data:")
        print(f"   • {sales_stats['total_sales']} total sales records")
        print(f"   • {sales_stats['days_range']} days of data")
        print(f"   • {sales_stats['products']} unique products sold")
        print(f"   • {sales_stats['categories']} product categories")

    if products_stats:
        print(f"\n✅ Product Data:")
        print(f"   • {products_stats['total_products']} products in inventory")
        print(f"   • {products_stats['categories']} categories")

    print("\n" + "=" * 70)
    print("🎯 NEXT STEPS FOR YOUR THESIS")
    print("=" * 70)

    if sales_stats and sales_stats['total_sales'] >= 100:
        print("\n✅ OPTION 1: Use Real Data Only (Recommended)")
        print("   • Your data is sufficient for thesis ML demonstration")
        print("   • More credible and authentic")
        print("   • Run: Use your CSV files directly in Google Colab")

    print("\n💡 OPTION 2: Supplement with Synthetic Data")
    print("   • Keep real and synthetic data clearly separated")
    print("   • Use synthetic data ONLY in CSV files (not database)")
    print("   • Run: python generate_synthetic_data.py")
    print("   • Then use combined CSVs in Google Colab")

    print("\n📓 OPTION 3: Train ML Model in Google Colab")
    print("   • Upload your CSV files to Colab")
    print("   • Use the provided notebook template")
    print("   • File: forecasting_model_training.ipynb")

    print("\n" + "=" * 70)
    print("🛡️  SAFETY REMINDER")
    print("=" * 70)
    print("✅ All analysis is READ-ONLY")
    print("✅ Your PostgreSQL database is NOT affected")
    print("✅ Synthetic data will be CSV only (separate files)")
    print("✅ No changes to your Railway connections")
    print("=" * 70 + "\n")


def main():
    """Main analysis function"""
    print("=" * 70)
    print("REAL DATA ANALYSIS - SAFE & READ-ONLY")
    print("=" * 70)
    print("\n🛡️  This script only READS your CSV files")
    print("🛡️  No database or file modifications will be made\n")

    # Ensure directory exists
    if not ensure_data_directory():
        print("⏸️  Please add your CSV files and run again")
        return

    # Check available files
    available_files = check_files_exist()

    if not available_files:
        print("\n❌ No data files found. Please add CSV files to proceed.")
        return

    # Analyze available data
    sales_stats = None
    products_stats = None

    if 'sales' in available_files:
        sales_stats = analyze_sales_data(available_files['sales'])

    if 'products' in available_files:
        products_stats = analyze_products_data(available_files['products'])

    # Generate summary
    generate_summary_report(sales_stats, products_stats)


if __name__ == '__main__':
    main()
