"""
Simple Sales Data Export for Google Colab
==========================================

Exports sales data to CSV format for ML training in Google Colab.

This script creates a simple CSV file with the following columns:
- date: Order date (YYYY-MM-DD)
- product_name: Name of the product
- category: Product category (Pastry/Beverage)
- quantity: Quantity sold
- price: Unit price
- total: Total sales amount

Usage:
    python export_sales_for_colab.py

Output:
    sales_for_colab.csv - Ready to upload to Google Colab
"""

import os
import sys
import django
import pandas as pd
from datetime import datetime, timedelta

# Setup Django
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'baneloforecasting.settings')
django.setup()

from dashboard.models import Sale


def export_sales_csv():
    """Export sales data to CSV for Colab"""

    print("=" * 70)
    print("EXPORTING SALES DATA FOR GOOGLE COLAB")
    print("=" * 70)

    print("\n📊 Fetching sales data from database...")

    try:
        # Get all sales (or last N days if you prefer)
        sales = Sale.objects.all().order_by('order_date').values(
            'order_date',
            'product_name',
            'category',
            'quantity',
            'price',
            'total'
        )

        # Convert to DataFrame
        df = pd.DataFrame(sales)

        if df.empty:
            print("❌ No sales data found!")
            return

        # Format date column
        df['order_date'] = pd.to_datetime(df['order_date']).dt.date
        df.rename(columns={'order_date': 'date'}, inplace=True)

        # Ensure data types
        df['quantity'] = pd.to_numeric(df['quantity'], errors='coerce').fillna(0)
        df['price'] = pd.to_numeric(df['price'], errors='coerce').fillna(0)
        df['total'] = pd.to_numeric(df['total'], errors='coerce').fillna(0)

        # Save to CSV
        output_file = 'sales_for_colab.csv'
        df.to_csv(output_file, index=False)

        print(f"\n✅ Export Complete!")
        print(f"   • Total records: {len(df)}")
        print(f"   • Date range: {df['date'].min()} to {df['date'].max()}")
        print(f"   • Products: {df['product_name'].nunique()}")
        print(f"   • Categories: {df['category'].unique().tolist()}")
        print(f"\n📁 File saved: {output_file}")
        print(f"\n📋 Columns in CSV:")
        print(f"   {', '.join(df.columns.tolist())}")
        print("\n🚀 Next Steps:")
        print("   1. Download this CSV file")
        print("   2. Upload to Google Colab")
        print("   3. Run the training notebook")
        print("=" * 70 + "\n")

        return output_file

    except Exception as e:
        print(f"❌ Error: {e}")
        print("\nMake sure:")
        print("  - PostgreSQL database is running")
        print("  - DATABASE_URL environment variable is set")
        print("  - Django settings are configured")
        return None


if __name__ == '__main__':
    export_sales_csv()
