"""
Safe Synthetic Data Generator - CSV ONLY
=========================================

⚠️  IMPORTANT SAFETY FEATURES:
✅ Works ONLY with CSV files (NO database connection)
✅ Reads patterns from your real data
✅ Generates synthetic data in SEPARATE CSV files
✅ Never touches your PostgreSQL database
✅ Clearly labeled output files (synthetic_*)

This generator creates realistic synthetic sales data based on
patterns observed in your real data, suitable for ML training
demonstrations in your thesis.

Usage:
    1. Make sure you have real_data/sales_data.csv
    2. Run: python generate_synthetic_data.py
    3. Output: synthetic_data/synthetic_sales_data.csv
    4. Use combined data in Google Colab for training

For Thesis:
    - Clearly document that synthetic data was used
    - Keep synthetic data separate from real data
    - Use for demonstrating model scalability
"""

import os
import csv
import random
from datetime import datetime, timedelta
from collections import defaultdict

# Directories
REAL_DATA_DIR = 'real_data'
SYNTHETIC_DATA_DIR = 'synthetic_data'

# Configuration
DEFAULT_DAYS_TO_GENERATE = 60  # Generate 60 days of synthetic data
DEFAULT_SALES_MULTIPLIER = 1.5  # Generate 1.5x more sales than real data


class SyntheticDataGenerator:
    """Generate synthetic sales data based on real patterns"""

    def __init__(self, real_sales_file):
        self.real_sales_file = real_sales_file
        self.real_data = []
        self.product_patterns = defaultdict(lambda: {
            'avg_quantity': 0,
            'avg_price': 0,
            'sales_count': 0,
            'category': 'Unknown',
            'quantities': [],
            'prices': []
        })

    def load_real_data(self):
        """Load and analyze real sales data"""
        print("📊 Loading real sales data...")

        try:
            with open(self.real_sales_file, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                self.real_data = list(reader)

            print(f"   ✅ Loaded {len(self.real_data)} real sales records")
            return True

        except FileNotFoundError:
            print(f"   ❌ File not found: {self.real_sales_file}")
            print(f"   💡 Please run analyze_real_data.py first")
            return False

        except Exception as e:
            print(f"   ❌ Error loading data: {e}")
            return False

    def analyze_patterns(self):
        """Analyze sales patterns from real data"""
        print("🔍 Analyzing sales patterns...")

        if not self.real_data:
            print("   ❌ No data to analyze")
            return False

        # Analyze each product
        for sale in self.real_data:
            product_name = sale.get('product_name', 'Unknown')
            category = sale.get('category', 'Unknown')
            quantity = float(sale.get('quantity', 1))
            price = float(sale.get('price', 0))

            # Store pattern data
            pattern = self.product_patterns[product_name]
            pattern['category'] = category
            pattern['sales_count'] += 1
            pattern['quantities'].append(quantity)
            pattern['prices'].append(price)

        # Calculate averages
        for product, pattern in self.product_patterns.items():
            if pattern['quantities']:
                pattern['avg_quantity'] = sum(pattern['quantities']) / len(pattern['quantities'])
                pattern['avg_price'] = sum(pattern['prices']) / len(pattern['prices'])

        print(f"   ✅ Analyzed patterns for {len(self.product_patterns)} products")

        # Show top products
        sorted_products = sorted(
            self.product_patterns.items(),
            key=lambda x: x[1]['sales_count'],
            reverse=True
        )[:5]

        print(f"\n   📈 Top 5 Products (will generate more of these):")
        for product, pattern in sorted_products:
            print(f"      • {product[:40]:40s} - {pattern['sales_count']} sales")

        return True

    def generate_synthetic_sales(self, days=60, multiplier=1.5):
        """Generate synthetic sales data"""
        print(f"\n🤖 Generating synthetic sales data...")
        print(f"   📅 Days to generate: {days}")
        print(f"   📊 Sales multiplier: {multiplier}x")

        synthetic_sales = []

        # Determine date range
        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)

        # Calculate how many sales to generate per day
        total_real_sales = len(self.real_data)
        target_total_sales = int(total_real_sales * multiplier)
        sales_per_day = target_total_sales // days

        print(f"   🎯 Target: ~{sales_per_day} sales per day ({target_total_sales} total)")

        # Generate sales for each day
        sale_id = 10000  # Start IDs at 10000 to differentiate from real data
        current_date = start_date

        for day in range(days):
            current_date = start_date + timedelta(days=day)

            # Vary daily sales (weekends might be different)
            is_weekend = current_date.weekday() >= 5
            daily_sales = int(sales_per_day * (1.2 if is_weekend else 1.0))

            # Add some randomness
            daily_sales = int(daily_sales * random.uniform(0.7, 1.3))

            # Generate sales for this day
            for _ in range(daily_sales):
                # Pick a product based on its popularity
                product_name = self._pick_random_product()
                pattern = self.product_patterns[product_name]

                # Generate quantity (with variation around average)
                avg_qty = pattern['avg_quantity']
                quantity = max(1, int(avg_qty * random.uniform(0.5, 1.5)))

                # Generate price (with slight variation)
                avg_price = pattern['avg_price']
                price = round(avg_price * random.uniform(0.95, 1.05), 2)

                # Create sale record
                sale_time = current_date + timedelta(
                    hours=random.randint(8, 20),
                    minutes=random.randint(0, 59)
                )

                synthetic_sales.append({
                    'sale_id': f"SYN{sale_id}",
                    'product_id': '',
                    'product_firebase_id': '',
                    'product_name': product_name,
                    'category': pattern['category'],
                    'quantity': quantity,
                    'price': price,
                    'total': round(quantity * price, 2),
                    'order_date': sale_time.strftime('%Y-%m-%d %H:%M:%S'),
                    'created_at': sale_time.strftime('%Y-%m-%d %H:%M:%S'),
                    'data_type': 'SYNTHETIC'  # Clear label
                })

                sale_id += 1

        print(f"   ✅ Generated {len(synthetic_sales)} synthetic sales")
        return synthetic_sales

    def _pick_random_product(self):
        """Pick a random product weighted by popularity"""
        # Weight by sales count
        products = list(self.product_patterns.keys())
        weights = [self.product_patterns[p]['sales_count'] for p in products]

        # If all weights are 0, use uniform distribution
        if sum(weights) == 0:
            return random.choice(products)

        return random.choices(products, weights=weights)[0]

    def save_synthetic_data(self, synthetic_sales, output_file):
        """Save synthetic sales to CSV"""
        print(f"\n💾 Saving synthetic data...")

        try:
            # Ensure output directory exists
            os.makedirs(os.path.dirname(output_file), exist_ok=True)

            # Write CSV
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                fieldnames = [
                    'sale_id', 'product_id', 'product_firebase_id',
                    'product_name', 'category', 'quantity', 'price',
                    'total', 'order_date', 'created_at', 'data_type'
                ]
                writer = csv.DictWriter(f, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(synthetic_sales)

            file_size = os.path.getsize(output_file)
            print(f"   ✅ Saved to: {output_file}")
            print(f"   📊 File size: {file_size:,} bytes")

            return True

        except Exception as e:
            print(f"   ❌ Error saving: {e}")
            return False

    def create_combined_dataset(self, synthetic_sales, output_file):
        """Create a combined dataset with both real and synthetic data"""
        print(f"\n🔗 Creating combined dataset...")

        try:
            combined_sales = []

            # Add real sales (with label)
            for sale in self.real_data:
                sale_copy = dict(sale)
                sale_copy['data_type'] = 'REAL'
                combined_sales.append(sale_copy)

            # Add synthetic sales
            combined_sales.extend(synthetic_sales)

            # Sort by date
            combined_sales.sort(key=lambda x: x['order_date'])

            # Save combined dataset
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                if combined_sales:
                    fieldnames = list(combined_sales[0].keys())
                    writer = csv.DictWriter(f, fieldnames=fieldnames)
                    writer.writeheader()
                    writer.writerows(combined_sales)

            real_count = len(self.real_data)
            synthetic_count = len(synthetic_sales)
            total_count = len(combined_sales)

            print(f"   ✅ Combined dataset created:")
            print(f"      • Real sales: {real_count} ({real_count/total_count*100:.1f}%)")
            print(f"      • Synthetic sales: {synthetic_count} ({synthetic_count/total_count*100:.1f}%)")
            print(f"      • Total: {total_count}")
            print(f"   💾 Saved to: {output_file}")

            return True

        except Exception as e:
            print(f"   ❌ Error creating combined dataset: {e}")
            return False


def main():
    """Main generation function"""
    print("=" * 70)
    print("SAFE SYNTHETIC DATA GENERATOR")
    print("=" * 70)
    print("\n🛡️  SAFETY GUARANTEES:")
    print("   ✅ NO database connection")
    print("   ✅ Works ONLY with CSV files")
    print("   ✅ Synthetic data in separate files")
    print("   ✅ All data clearly labeled (REAL vs SYNTHETIC)")
    print("=" * 70)

    # Check for real data
    real_sales_file = os.path.join(REAL_DATA_DIR, 'sales_data.csv')

    if not os.path.exists(real_sales_file):
        print(f"\n❌ Real data not found: {real_sales_file}")
        print(f"\n📥 SETUP REQUIRED:")
        print(f"   1. Download your CSV files from Google Drive")
        print(f"   2. Place them in '{REAL_DATA_DIR}/' folder")
        print(f"   3. Run: python analyze_real_data.py")
        print(f"   4. Then run this script again")
        return

    # Create generator
    generator = SyntheticDataGenerator(real_sales_file)

    # Load and analyze real data
    if not generator.load_real_data():
        return

    if not generator.analyze_patterns():
        return

    # Get user preferences (or use defaults)
    print(f"\n⚙️  CONFIGURATION:")
    days = DEFAULT_DAYS_TO_GENERATE
    multiplier = DEFAULT_SALES_MULTIPLIER

    print(f"   Days of synthetic data: {days}")
    print(f"   Sales multiplier: {multiplier}x")
    print(f"   (Edit script to change these values)")

    # Generate synthetic data
    synthetic_sales = generator.generate_synthetic_sales(
        days=days,
        multiplier=multiplier
    )

    if not synthetic_sales:
        print("\n❌ Failed to generate synthetic data")
        return

    # Save outputs
    synthetic_file = os.path.join(SYNTHETIC_DATA_DIR, 'synthetic_sales_data.csv')
    combined_file = os.path.join(SYNTHETIC_DATA_DIR, 'combined_sales_data.csv')

    generator.save_synthetic_data(synthetic_sales, synthetic_file)
    generator.create_combined_dataset(synthetic_sales, combined_file)

    # Final summary
    print("\n" + "=" * 70)
    print("✅ GENERATION COMPLETE!")
    print("=" * 70)
    print(f"\n📁 OUTPUT FILES:")
    print(f"   1. {synthetic_file}")
    print(f"      → Synthetic data only")
    print(f"   2. {combined_file}")
    print(f"      → Real + Synthetic combined (labeled)")
    print(f"\n🎓 FOR YOUR THESIS:")
    print(f"   • Upload 'combined_sales_data.csv' to Google Colab")
    print(f"   • The 'data_type' column labels each record (REAL/SYNTHETIC)")
    print(f"   • Document your methodology in thesis")
    print(f"   • Show transparency in data sources")
    print(f"\n🛡️  DATABASE SAFETY:")
    print(f"   ✅ Your PostgreSQL database was NOT touched")
    print(f"   ✅ All files are CSV only")
    print(f"   ✅ Railway connections unchanged")
    print("=" * 70 + "\n")


if __name__ == '__main__':
    main()
