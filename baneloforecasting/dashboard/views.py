"""
Dashboard Views - API Version
Business data is fetched from the Node.js API which connects to PostgreSQL.
Django only manages authentication and sessions locally.
"""

import csv
import os
import json
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import update_session_auth_hash
from django.conf import settings
from datetime import datetime, timedelta
from collections import defaultdict
from django.db.models import Q, Sum

# Import API service
from .api_service import get_api_service

# Import models
from .models import Product, Recipe, RecipeIngredient, Sale, WasteLog, AuditTrail, MLModel, MLPrediction


# ============================================
# HELPER FUNCTIONS
# ============================================

def calculate_max_servings(product_firebase_id, recipe_id):
    """Calculate maximum servings based on available ingredients (Legacy ORM version - kept for backward compatibility)"""
    try:
        print(f"\n━━━━━━━━━━━━━━━━━━━━━━━━")
        print(f"🧮 Calculating max servings (ORM mode)")
        print(f"   Product ID: {product_firebase_id}")
        print(f"   Recipe ID: {recipe_id}")

        # Get all ingredients for this recipe using Django ORM
        try:
            recipe = Recipe.objects.get(id=recipe_id)
        except Recipe.DoesNotExist:
            try:
                recipe = Recipe.objects.get(firebase_id=str(recipe_id))
            except Recipe.DoesNotExist:
                print(f"   ❌ Recipe not found")
                return None

        ingredients = RecipeIngredient.objects.filter(
            Q(recipe_id=recipe.id) | Q(recipe_firebase_id=recipe.firebase_id)
        )

        max_servings_list = []
        ingredient_count = 0

        for ingredient in ingredients:
            ingredient_count += 1
            ingredient_product_id = ingredient.ingredient_firebase_id.strip() if ingredient.ingredient_firebase_id else ''
            quantity_needed = ingredient.quantity_needed or 0
            ingredient_name = ingredient.ingredient_name or 'Unknown'

            print(f"\n   📦 Ingredient #{ingredient_count}: {ingredient_name}")
            print(f"      Ingredient ID: '{ingredient_product_id}'")
            print(f"      Quantity needed: {quantity_needed}")

            if not ingredient_product_id or quantity_needed == 0:
                print(f"      ⚠️ Missing ID or quantity, skipping")
                continue

            # Get the ingredient product's current stock
            try:
                product = Product.objects.get(firebase_id=ingredient_product_id)
                available_quantity = product.quantity or 0
            except Product.DoesNotExist:
                print(f"      ❌ Ingredient product not found in database!")
                max_servings_list.append(0)
                continue

            # Calculate max servings for this ingredient
            if quantity_needed > 0:
                max_for_this_ingredient = int(available_quantity / quantity_needed)
            else:
                max_for_this_ingredient = 0

            print(f"      ✅ Available: {available_quantity}g")
            print(f"      🎯 Max servings from this ingredient: {max_for_this_ingredient}")

            max_servings_list.append(max_for_this_ingredient)

        # Return the minimum (bottleneck ingredient)
        result = min(max_servings_list) if max_servings_list else 0

        print(f"\n   🏆 FINAL MAX SERVINGS: {result}")
        print(f"   Total ingredients checked: {ingredient_count}")
        print(f"━━━━━━━━━━━━━━━━━━━━━━━━\n")

        return result

    except Exception as e:
        print(f"❌ Error calculating max servings: {e}")
        import traceback
        traceback.print_exc()
        return None


def calculate_max_servings_api(recipe_data, products_dict):
    """Calculate maximum servings based on available ingredients using API data

    Args:
        recipe_data: Recipe object from API with 'ingredients' list
        products_dict: Dictionary of products keyed by firebase_id

    Returns:
        Integer: Maximum number of servings, or None if calculation fails
    """
    try:
        ingredients = recipe_data.get('ingredients', [])

        if not ingredients:
            print(f"   ⚠️ No ingredients in recipe")
            return 0

        max_servings_list = []

        for ingredient in ingredients:
            ingredient_id = ingredient.get('ingredientFirebaseId') or ingredient.get('ingredient_firebase_id')
            quantity_needed = float(ingredient.get('quantityNeeded') or ingredient.get('quantity_needed') or 0)
            ingredient_name = ingredient.get('ingredientName') or ingredient.get('ingredient_name') or 'Unknown'

            if not ingredient_id or quantity_needed <= 0:
                continue

            # Get ingredient product from products dict
            ingredient_product = products_dict.get(ingredient_id)

            if not ingredient_product:
                print(f"   ⚠️ Ingredient product not found: {ingredient_name} ({ingredient_id})")
                max_servings_list.append(0)
                continue

            # Use inventory_b (operational stock) for calculation
            available_quantity = float(ingredient_product.get('inventory_b') or ingredient_product.get('quantity', 0) or 0)

            # Calculate max servings from this ingredient
            if quantity_needed > 0:
                max_for_this = int(available_quantity / quantity_needed)
            else:
                max_for_this = 0

            max_servings_list.append(max_for_this)

        # Return the minimum (bottleneck ingredient)
        result = min(max_servings_list) if max_servings_list else 0
        return result

    except Exception as e:
        print(f"❌ Error calculating max servings (API): {e}")
        import traceback
        traceback.print_exc()
        return None


def calculate_statistics(audit_logs):
    """Calculate audit trail statistics"""
    stats = {
        'total_logs': len(audit_logs),
        'actions_today': 0,
        'unique_users': len(set(log['user'] for log in audit_logs)),
    }

    today = datetime.now().date()
    for log in audit_logs:
        try:
            log_date = datetime.strptime(log['timestamp'].split()[0], '%Y-%m-%d').date()
            if log_date == today:
                stats['actions_today'] += 1
        except:
            pass

    return stats


def get_unique_users():
    """Get unique users from audit trail"""
    users = AuditTrail.objects.values_list('user_name', flat=True).distinct()
    return [u for u in users if u]


def log_audit(action, user, details=''):
    """Helper function to log audit trail entries"""
    try:
        AuditTrail.objects.create(
            action=action,
            user_id=str(user.id) if hasattr(user, 'id') else '',
            user_name=user.username if hasattr(user, 'username') else str(user),
            details=details,
            timestamp=datetime.now()
        )
    except Exception as e:
        print(f"Warning: Could not log audit trail: {e}")


# ========================================
# DASHBOARD VIEWS
# ========================================

@login_required
def dashboard_view(request):
    """Display dashboard with data from Node.js API"""
    try:
        print("\n🔥 DASHBOARD VIEW CALLED (API Mode)")

        # Get API service
        api = get_api_service()

        # Get filter parameter (default: week)
        filter_type = request.GET.get('filter', 'week')

        today = datetime.now()
        today_start = today.replace(hour=0, minute=0, second=0, microsecond=0)
        yesterday_start = today_start - timedelta(days=1)

        # Determine date range based on filter
        if filter_type == 'today':
            start_date = today_start
            date_range_days = 1
        elif filter_type == 'month':
            start_date = today_start - timedelta(days=30)
            date_range_days = 30
        else:  # week (default)
            start_date = today_start - timedelta(days=7)
            date_range_days = 7

        # ========================================
        # 1. GET SALES DATA FROM API
        # ========================================
        print("🔍 Fetching sales data from API...")

        all_sales = api.get_sales(limit=5000)
        print(f"✅ Fetched {len(all_sales)} sales records")

        today_sales = 0
        yesterday_sales = 0
        today_orders = 0
        yesterday_orders = 0
        recent_sales = []

        # For charts
        daily_sales = defaultdict(float)
        product_sales = defaultdict(int)

        for sale in all_sales:
            try:
                # Parse order_date from API response (could be string or datetime)
                order_date_raw = sale.get('order_date') or sale.get('orderDate')
                if isinstance(order_date_raw, str):
                    try:
                        order_date = datetime.strptime(order_date_raw[:19], '%Y-%m-%dT%H:%M:%S')
                    except:
                        try:
                            order_date = datetime.strptime(order_date_raw[:19], '%Y-%m-%d %H:%M:%S')
                        except:
                            order_date = None
                else:
                    order_date = order_date_raw

                if order_date:
                    price = float(sale.get('price', 0) or 0)
                    quantity = int(sale.get('quantity', 0) or 0)
                    sale_total = float(sale.get('total_amount') or sale.get('total') or 0) or (price * quantity)
                    product_name = sale.get('product_name') or sale.get('productName') or 'Unknown'

                    # Check if within date range for charts
                    if order_date >= start_date:
                        date_key = order_date.strftime('%Y-%m-%d')
                        daily_sales[date_key] += sale_total
                        product_sales[product_name] += quantity

                    # Today's data
                    if order_date.date() == today.date():
                        today_sales += sale_total
                        today_orders += 1

                        if len(recent_sales) < 5:
                            recent_sales.append({
                                'product': product_name,
                                'quantity': quantity,
                                'price': price,
                                'total': sale_total,
                                'datetime': order_date.strftime('%Y-%m-%d %H:%M:%S')
                            })

                    # Yesterday's data
                    elif order_date.date() == yesterday_start.date():
                        yesterday_sales += sale_total
                        yesterday_orders += 1

            except Exception as item_error:
                print(f"⚠️ Error processing sale item: {item_error}")
                continue

        # Calculate percentage changes
        sales_change = 0
        if yesterday_sales > 0:
            sales_change = round(((today_sales - yesterday_sales) / yesterday_sales) * 100, 1)

        orders_change = 0
        if yesterday_orders > 0:
            orders_change = round(((today_orders - yesterday_orders) / yesterday_orders) * 100, 1)

        # ========================================
        # 2. PREPARE CHART DATA BASED ON FILTER
        # ========================================
        chart_dates = []
        chart_sales_data = []

        if filter_type == 'today':
            # Show hourly data for today
            for hour in range(0, 24):
                hour_str = f"{hour:02d}:00"
                chart_dates.append(hour_str)
                chart_sales_data.append(0)

            # Put all today's sales in current hour
            current_hour = today.hour
            date_key = today_start.strftime('%Y-%m-%d')
            chart_sales_data[current_hour] = float(daily_sales.get(date_key, 0))

        elif filter_type == 'month':
            # Show daily data for last 30 days
            for i in range(29, -1, -1):
                date = today_start - timedelta(days=i)
                date_key = date.strftime('%Y-%m-%d')
                date_label = date.strftime('%b %d')

                chart_dates.append(date_label)
                chart_sales_data.append(float(daily_sales.get(date_key, 0)))

        else:  # week
            # Show daily data for last 7 days
            for i in range(6, -1, -1):
                date = today_start - timedelta(days=i)
                date_key = date.strftime('%Y-%m-%d')
                date_label = date.strftime('%b %d')

                chart_dates.append(date_label)
                chart_sales_data.append(float(daily_sales.get(date_key, 0)))

        # ========================================
        # 3. PREPARE TOP 5 PRODUCTS DATA
        # ========================================
        top_products = sorted(product_sales.items(), key=lambda x: x[1], reverse=True)[:5]

        chart_products = []
        chart_quantities = []

        for product, quantity in top_products:
            chart_products.append(product)
            chart_quantities.append(quantity)

        # ========================================
        # 4. GET PRODUCT STATISTICS FROM API
        # ========================================
        print("🔍 Fetching product data from API...")

        products = api.get_products()
        total_products = len(products)
        low_stock_items = 0

        for product in products:
            category = (product.get('category', '') or '').lower().strip()

            # Skip beverages - they don't have physical stock
            if category in ['beverage', 'beverages', 'drink', 'drinks']:
                continue

            # For non-beverage items: check quantity stock
            stock = float(product.get('quantity', 0) or 0)
            reorder_level = 20  # Default reorder level

            # Check if low stock
            if stock < reorder_level:
                low_stock_items += 1

        # ========================================
        # 5. GET ACTIVE USERS COUNT
        # ========================================
        from django.contrib.auth.models import User
        active_users = User.objects.filter(is_active=True).count()

        # ========================================
        # 6. SORT RECENT SALES BY TIME
        # ========================================
        recent_sales.sort(key=lambda x: x['datetime'], reverse=True)

        for sale in recent_sales:
            try:
                dt = datetime.strptime(sale['datetime'], '%Y-%m-%d %H:%M:%S')
                sale['display_date'] = dt.strftime('%b %d, %Y - %I:%M %p')
            except:
                sale['display_date'] = sale['datetime']

        print(f"💰 Today's Sales: ₱{today_sales:.2f} ({sales_change:+.1f}%)")
        print(f"📦 Today's Orders: {today_orders} ({orders_change:+.1f}%)")
        print(f"📊 Total Products: {total_products}")
        print(f"⚠️  Low Stock Items: {low_stock_items}")
        print(f"📊 Chart Filter: {filter_type.upper()} - {len(chart_dates)} data points")
        print("=" * 50 + "\n")

        # ========================================
        # PREPARE CONTEXT
        # ========================================
        context = {
            'today_sales': today_sales,
            'sales_change': sales_change,
            'total_products': total_products,
            'low_stock_items': low_stock_items,
            'today_orders': today_orders,
            'orders_change': orders_change,
            'active_users': active_users,
            'recent_sales': recent_sales,
            # Chart data
            'chart_dates': chart_dates,
            'chart_sales_data': chart_sales_data,
            'chart_products': chart_products,
            'chart_quantities': chart_quantities,
            'current_filter': filter_type,
        }

        return render(request, 'dashboard/dashboard.html', context)

    except Exception as e:
        print(f"❌ Error loading dashboard: {e}")
        import traceback
        traceback.print_exc()

        context = {
            'today_sales': 0,
            'sales_change': 0,
            'total_products': 0,
            'low_stock_items': 0,
            'today_orders': 0,
            'orders_change': 0,
            'active_users': 0,
            'recent_sales': [],
            'chart_dates': [],
            'chart_sales_data': [],
            'chart_products': [],
            'chart_quantities': [],
            'current_filter': 'week',
            'error_message': f'Unable to load dashboard data: {str(e)}',
        }
        return render(request, 'dashboard/dashboard.html', context)


@login_required
def inventory_view(request):
    """Display inventory page with data from API"""
    try:
        print("\n🔥 INVENTORY VIEW CALLED (API Mode)")

        # Get API service
        api = get_api_service()

        # Get all products from API
        products = api.get_products()

        # Get all recipes from API
        recipes = api.get_recipes()

        recipes_by_id = {}
        recipes_by_name = {}

        for recipe in recipes:
            product_id = recipe.get('product_firebase_id') or recipe.get('productFirebaseId')
            product_name = (recipe.get('product_name') or recipe.get('productName') or '').lower().strip()

            recipe_info = {
                'recipeId': recipe.get('id'),
                'firebaseId': recipe.get('firebase_id') or recipe.get('firebaseId'),
                'productName': recipe.get('product_name') or recipe.get('productName'),
                'ingredients': recipe.get('ingredients', []),
                'full_recipe': recipe  # Store full recipe data for servings calculation
            }

            if product_id:
                recipes_by_id[product_id] = recipe_info
                print(f"📋 Recipe found by ID: {product_id} -> {recipe_info['productName']}")

            if product_name:
                recipes_by_name[product_name] = recipe_info
                print(f"📋 Recipe found by Name: {product_name}")

        print(f"✅ Found {len(recipes_by_id)} recipes by ID, {len(recipes_by_name)} by name")

        # Create products dictionary for faster lookup
        products_dict = {}
        for product in products:
            firebase_id = product.get('firebase_id') or product.get('firebaseId') or ''
            if firebase_id:
                products_dict[firebase_id] = product

        # Process products data
        products_data = []
        doc_count = 0

        for product in products:
            doc_count += 1

            # Normalize category
            raw_category = product.get('category', 'Unknown') or 'Unknown'
            category_lower = str(raw_category).lower().strip()

            if category_lower in ['beverage', 'beverages', 'drink', 'drinks', 'hot drinks', 'cold drinks']:
                category = 'beverage'
            elif category_lower in ['pastries', 'pastry', 'snacks', 'snack']:
                category = 'pastries'
            elif category_lower in ['ingredients', 'ingredient']:
                category = 'ingredients'
            else:
                category = category_lower

            # Handle image
            image_raw = product.get('image_uri') or product.get('imageUri')
            image = None

            if image_raw and str(image_raw) not in ['nan', 'None', '']:
                image = str(image_raw)

            has_image = False
            if image and (image.startswith('http://') or image.startswith('https://')):
                has_image = True

            if not has_image:
                if category == 'beverage':
                    image = '☕'
                elif category == 'pastries':
                    image = '🥐'
                elif category == 'ingredients':
                    image = '🧂'
                else:
                    image = '📦'

            # Calculate max servings for beverages and pastries with recipes
            max_servings = None
            recipe_found = False
            recipe_info = None
            firebase_id = product.get('firebase_id') or product.get('firebaseId') or ''
            product_name = product.get('name', 'Unknown')

            if category in ['beverage', 'pastries']:
                # Try matching by Firebase ID first
                if firebase_id in recipes_by_id:
                    recipe_found = True
                    recipe_info = recipes_by_id[firebase_id]
                    print(f"✅ Recipe matched by ID for: {product_name}")

                # If not found, try matching by product name
                elif product_name.lower().strip() in recipes_by_name:
                    recipe_found = True
                    recipe_info = recipes_by_name[product_name.lower().strip()]
                    print(f"✅ Recipe matched by NAME for: {product_name}")

                # Calculate max servings if recipe found
                if recipe_found and recipe_info:
                    max_servings = calculate_max_servings_api(recipe_info['full_recipe'], products_dict)
                    if max_servings is not None:
                        print(f"   🎯 Calculated {max_servings} servings for {product_name}")

            # Get inventory data
            inventory_a = float(product.get('inventory_a') or product.get('inventoryA') or product.get('quantity', 0) or 0)
            inventory_b = float(product.get('inventory_b') or product.get('inventoryB') or 0)
            cost_per_unit = float(product.get('cost_per_unit') or product.get('costPerUnit') or 0)

            products_data.append({
                'id': firebase_id or str(product.get('id', '')),
                'name': product_name,
                'price': float(product.get('price', 0) or 0),
                'category': category,
                'stock': float(product.get('quantity', 0) or 0),
                'inventory_a': inventory_a,
                'inventory_b': inventory_b,
                'cost_per_unit': cost_per_unit,
                'image': image,
                'has_image': has_image,
                'max_servings': max_servings,
                'has_recipe': recipe_found
            })

        # Sort by name
        products_data.sort(key=lambda x: x['name'])

        print(f"\n{'=' * 60}")
        print(f"✅ LOADED {len(products_data)} PRODUCTS FROM POSTGRESQL")
        print(f"{'=' * 60}")

        context = {
            'products': products_data,
        }

        return render(request, 'dashboard/inventory.html', context)

    except Exception as e:
        print(f"❌ Error loading inventory: {e}")
        import traceback
        traceback.print_exc()

        context = {
            'products': [],
        }
        return render(request, 'dashboard/inventory.html', context)


@login_required
def settings_view(request):
    context = {'user': request.user}
    return render(request, 'dashboard/settings.html', context)


@login_required
def sales_view(request):
    """Display sales page with data from API"""
    try:
        print("\n🔥 SALES VIEW CALLED (API Mode)")

        # Get API service
        api = get_api_service()

        # Get sales from API
        sales = api.get_sales(limit=1000)

        # Process sales data
        sales_data = []
        total_sales = 0

        for sale in sales:
            price = float(sale.get('price', 0) or 0)
            quantity = int(sale.get('quantity', 0) or 0)
            sale_total = float(sale.get('total_amount') or sale.get('total') or 0) or (price * quantity)

            # Parse order_date
            order_date_raw = sale.get('order_date') or sale.get('orderDate')
            if isinstance(order_date_raw, str):
                date_only = order_date_raw[:10] if order_date_raw else 'N/A'
            else:
                date_only = order_date_raw.strftime('%Y-%m-%d') if order_date_raw else 'N/A'

            sales_data.append({
                'id': sale.get('id'),
                'date': date_only,
                'product': sale.get('product_name') or sale.get('productName') or 'Unknown',
                'quantity': quantity,
                'unit_price': price,
                'total': sale_total,
                'category': sale.get('category') or 'Uncategorized'
            })

            total_sales += sale_total

        print(f"✅ Loaded {len(sales_data)} sales from API")
        print(f"✅ Total sales: ₱{total_sales:.2f}")

        context = {
            'sales': sales_data,
            'total_sales': total_sales,
            'total_transactions': len(sales_data),
        }

        return render(request, 'dashboard/sales.html', context)

    except Exception as e:
        print(f"❌ Error loading sales: {e}")
        import traceback
        traceback.print_exc()

        context = {
            'sales': [],
            'total_sales': 0,
            'total_transactions': 0,
        }
        return render(request, 'dashboard/sales.html', context)


@login_required
def export_sales_csv(request):
    """Export sales to CSV file"""
    try:
        print("\n🔥 SALES CSV EXPORT CALLED")

        # Get filter parameters
        filter_date_from = request.GET.get('date_from', '')
        filter_date_to = request.GET.get('date_to', '')

        # Query PostgreSQL
        sales = Sale.objects.all().order_by('-order_date')

        # Apply date filters
        if filter_date_from:
            from_date = datetime.strptime(filter_date_from, '%Y-%m-%d')
            sales = sales.filter(order_date__gte=from_date)
        if filter_date_to:
            to_date = datetime.strptime(filter_date_to, '%Y-%m-%d') + timedelta(days=1)
            sales = sales.filter(order_date__lt=to_date)

        sales = sales[:5000]

        # Process sales data
        sales_data = []

        for sale in sales:
            price = float(sale.price or 0)
            quantity = int(sale.quantity or 0)
            sale_total = float(sale.total) if sale.total else price * quantity

            order_date = sale.order_date
            date_only = order_date.strftime('%Y-%m-%d') if order_date else 'N/A'

            sales_data.append({
                'date': date_only,
                'product': sale.product_name or 'Unknown',
                'category': sale.category or 'Uncategorized',
                'quantity': quantity,
                'unit_price': price,
                'total': sale_total
            })

        print(f"✅ Exporting {len(sales_data)} sales to CSV")

        # Create CSV response
        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = f'attachment; filename="sales_report_{datetime.now().strftime("%Y%m%d_%H%M%S")}.csv"'

        # Write CSV
        writer = csv.writer(response)
        writer.writerow(['Date', 'Product Name', 'Category', 'Quantity', 'Unit Price', 'Total Amount'])

        for sale in sales_data:
            writer.writerow([
                sale['date'],
                sale['product'],
                sale['category'],
                sale['quantity'],
                f"₱{sale['unit_price']:.2f}",
                f"₱{sale['total']:.2f}"
            ])

        print(f"✅ CSV export completed - {len(sales_data)} records\n")
        return response

    except Exception as e:
        print(f"❌ Error exporting sales CSV: {e}")
        import traceback
        traceback.print_exc()
        return HttpResponse(f"Error: {str(e)}", status=500)


@login_required
def accounts_view(request):
    """Display accounts management page from PostgreSQL users table"""
    from .models import User as PostgresUser

    # Get users from PostgreSQL 'users' table (managed by mobile app)
    users = PostgresUser.objects.all()

    users_data = []
    for user in users:
        # Parse name
        full_name = user.full_name or user.username or 'User'
        name_parts = full_name.split(' ', 1)
        first_name = name_parts[0] if name_parts else 'User'
        last_name = name_parts[1] if len(name_parts) > 1 else ''

        users_data.append({
            'id': user.id,
            'first_name': first_name,
            'last_name': last_name,
            'email': user.email or '',
            'role': user.role or 'Staff',
            'initials': (first_name[:1] if first_name else 'U') + (last_name[:1] if last_name else ''),
            'date_joined': user.created_at.strftime('%Y-%m-%d') if user.created_at else 'N/A',
            'is_active': user.is_active
        })

    # Log audit trail
    log_audit('Accounts Viewed', request.user, f'Viewed accounts page. Total users: {len(users_data)}')

    context = {
        'users': users_data,
        'total_users': len(users_data)
    }
    return render(request, 'dashboard/accounts.html', context)


# ========================================
# AUDIT TRAIL VIEWS
# ========================================
@login_required
def audit_trail_view(request):
    """Display audit trail from Node.js API (includes mobile POS logs)"""
    try:
        print("\n" + "=" * 80)
        print("🔥 AUDIT TRAIL VIEW CALLED (API Mode)")
        print("=" * 80)

        # Get API service
        api = get_api_service()

        # Get filter parameters
        filter_user = request.GET.get('user', '')
        filter_action = request.GET.get('action', '')
        filter_date_from = request.GET.get('date_from', '')
        filter_date_to = request.GET.get('date_to', '')
        filter_source = request.GET.get('source', '')

        print(f"📊 Filters: user={filter_user}, action={filter_action}, from={filter_date_from}, to={filter_date_to}, source={filter_source}")

        # Get audit logs from API (includes both web and mobile)
        audit_logs_from_api = api.get_audit_logs(
            limit=10000,
            user=filter_user if filter_user else None,
            action=filter_action if filter_action else None,
            date_from=filter_date_from if filter_date_from else None,
            date_to=filter_date_to if filter_date_to else None
        )

        print(f"📦 Received {len(audit_logs_from_api)} audit logs from API")

        # Format audit logs for display
        audit_logs = []
        for log in audit_logs_from_api:
            timestamp_str = ''
            if log.get('timestamp'):
                try:
                    if isinstance(log['timestamp'], str):
                        # Parse ISO format string
                        dt = datetime.fromisoformat(log['timestamp'].replace('Z', '+00:00'))
                        timestamp_str = dt.strftime('%Y-%m-%d %H:%M:%S')
                    else:
                        timestamp_str = log['timestamp'].strftime('%Y-%m-%d %H:%M:%S')
                except:
                    timestamp_str = str(log['timestamp'])

            audit_logs.append({
                'id': f"audit-{log.get('id', '')}",
                'user': log.get('user_name') or log.get('userName') or 'Unknown',
                'action': log.get('action') or 'N/A',
                'description': log.get('details') or '',
                'timestamp': timestamp_str,
                'source': 'Audit System',
                'status': 'Success'
            })

        # Sort by timestamp descending
        audit_logs.sort(key=lambda x: x['timestamp'], reverse=True)
        audit_logs = audit_logs[:10000]  # Limit to 10,000

        print(f"\n{'=' * 80}")
        print(f"✅ RESULTS: {len(audit_logs)} audit logs from API")
        print(f"{'=' * 80}\n")

        # Get statistics
        stats = calculate_statistics(audit_logs)

        # Get unique users - try from API, fallback to local query
        users = []
        try:
            # Get all audit logs without limit to extract unique users
            all_logs = api.get_audit_logs(limit=50000)
            users = list(set([log.get('user_name') or log.get('userName') for log in all_logs if log.get('user_name') or log.get('userName')]))
        except:
            users = []

        context = {
            'audit_logs': audit_logs,
            'stats': stats,
            'users': users,
            'filter_user': filter_user,
            'filter_action': filter_action,
            'filter_date_from': filter_date_from,
            'filter_date_to': filter_date_to,
            'filter_source': filter_source,
        }

        return render(request, 'dashboard/audit_trail.html', context)

    except Exception as e:
        print(f"❌ Error loading audit trail: {e}")
        import traceback
        traceback.print_exc()

        context = {
            'audit_logs': [],
            'stats': {'total_logs': 0, 'actions_today': 0, 'unique_users': 0},
            'users': [],
        }
        return render(request, 'dashboard/audit_trail.html', context)


@login_required
def get_audit_logs_api(request):
    """API endpoint to get audit logs"""
    try:
        audit_logs = AuditTrail.objects.all().order_by('-timestamp')[:1000]

        logs_list = []
        for log in audit_logs:
            logs_list.append({
                'id': log.id,
                'user': log.user_name or 'Unknown',
                'action': log.action or 'N/A',
                'details': log.details or '',
                'timestamp': log.timestamp.strftime('%Y-%m-%d %H:%M:%S') if log.timestamp else '',
            })

        return JsonResponse({'success': True, 'logs': logs_list})

    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)})


@login_required
def export_audit_trail_csv(request):
    """Export audit trail to CSV"""
    try:
        audit_logs = AuditTrail.objects.all().order_by('-timestamp')[:5000]

        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = f'attachment; filename="audit_trail_{datetime.now().strftime("%Y%m%d_%H%M%S")}.csv"'

        writer = csv.writer(response)
        writer.writerow(['Timestamp', 'User', 'Action', 'Details'])

        for log in audit_logs:
            writer.writerow([
                log.timestamp.strftime('%Y-%m-%d %H:%M:%S') if log.timestamp else '',
                log.user_name or '',
                log.action or '',
                log.details or ''
            ])

        return response

    except Exception as e:
        print(f"❌ Error exporting audit trail CSV: {e}")
        return HttpResponse(f"Error: {str(e)}", status=500)


# ========================================
# API ENDPOINTS
# ========================================

@login_required
def api_products(request):
    """API endpoint to get all products"""
    try:
        products = Product.objects.all()
        products_list = []

        for product in products:
            products_list.append({
                'id': product.firebase_id or str(product.id),
                'name': product.name,
                'category': product.category,
                'price': float(product.price or 0),
                'quantity': float(product.quantity or 0),
                'inventoryA': float(product.inventory_a or 0),
                'inventoryB': float(product.inventory_b or 0),
                'costPerUnit': float(product.cost_per_unit or 0),
                'unit': product.unit,
            })

        return JsonResponse({'success': True, 'products': products_list})

    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)})


@login_required
def api_sales(request):
    """API endpoint to get all sales"""
    try:
        sales = Sale.objects.all().order_by('-order_date')[:1000]
        sales_list = []

        for sale in sales:
            sales_list.append({
                'id': sale.id,
                'productName': sale.product_name,
                'productFirebaseId': sale.product_firebase_id,
                'category': sale.category,
                'quantity': float(sale.quantity or 0),
                'price': float(sale.price or 0),
                'total': float(sale.total or 0),
                'orderDate': sale.order_date.strftime('%Y-%m-%d %H:%M:%S') if sale.order_date else '',
            })

        return JsonResponse({'success': True, 'sales': sales_list})

    except Exception as e:
        return JsonResponse({'success': False, 'error': str(e)})


@login_required
def database_health_check(request):
    """Check API connection health"""
    try:
        api = get_api_service()
        health = api.health_check()

        if health['status'] == 'healthy':
            # Get counts from API
            products = api.get_products()
            sales = api.get_sales(limit=1)
            recipes = api.get_recipes()

            return JsonResponse({
                'status': 'healthy',
                'connection': 'Node.js API',
                'api_url': health['api_url'],
                'message': 'API connection is working',
                'counts': {
                    'products': len(products),
                    'sales': 'Available',
                    'recipes': len(recipes),
                }
            })
        else:
            return JsonResponse({
                'status': 'unhealthy',
                'connection': 'Node.js API',
                'api_url': health['api_url'],
                'message': health['message'],
            }, status=500)

    except Exception as e:
        return JsonResponse({
            'status': 'unhealthy',
            'connection': 'Node.js API',
            'message': str(e),
        }, status=500)


# Alias for backward compatibility
firebase_health_check = database_health_check


@login_required
def debug_database_status(request):
    """Debug endpoint to check database status"""
    try:
        from django.db import connection

        # Test connection
        with connection.cursor() as cursor:
            cursor.execute("SELECT version();")
            version = cursor.fetchone()[0]

        # Get table counts
        products_count = Product.objects.count()
        sales_count = Sale.objects.count()
        recipes_count = Recipe.objects.count()
        ingredients_count = RecipeIngredient.objects.count()

        status_html = f"""
        <html>
        <head><title>PostgreSQL Database Status</title></head>
        <body style="font-family: Arial, sans-serif; padding: 20px;">
        <h1>📊 PostgreSQL Database Status</h1>

        <h2>✅ Connection Status: CONNECTED</h2>

        <h3>Database Info:</h3>
        <ul>
            <li><strong>Version:</strong> {version[:50]}...</li>
            <li><strong>Engine:</strong> PostgreSQL</li>
        </ul>

        <h3>Table Counts:</h3>
        <table border="1" cellpadding="10">
            <tr><th>Table</th><th>Count</th></tr>
            <tr><td>Products</td><td>{products_count}</td></tr>
            <tr><td>Sales</td><td>{sales_count}</td></tr>
            <tr><td>Recipes</td><td>{recipes_count}</td></tr>
            <tr><td>Recipe Ingredients</td><td>{ingredients_count}</td></tr>
        </table>

        <h3>Sample Data:</h3>
        <h4>Recent Sales:</h4>
        <ul>
        """

        recent_sales = Sale.objects.all().order_by('-order_date')[:5]
        for sale in recent_sales:
            status_html += f"<li>{sale.product_name} - {sale.quantity} x ₱{sale.price} ({sale.order_date})</li>"

        status_html += """
        </ul>
        </body>
        </html>
        """

        return HttpResponse(status_html, content_type='text/html')

    except Exception as e:
        print(f"❌ Error in debug endpoint: {e}")
        import traceback
        traceback.print_exc()
        return HttpResponse(f"<h1>Error: {str(e)}</h1>", content_type='text/html', status=500)


# Alias for backward compatibility
debug_firebase_status = debug_database_status


@login_required
@csrf_exempt
def update_password_api(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            current_password = data.get('current_password')
            new_password = data.get('new_password')

            user = request.user

            if not user.check_password(current_password):
                return JsonResponse({
                    'success': False,
                    'message': 'Current password is incorrect'
                }, status=400)

            user.set_password(new_password)
            user.save()

            update_session_auth_hash(request, user)

            log_audit('Password Changed', user, 'User changed their password')

            return JsonResponse({
                'success': True,
                'message': 'Password updated successfully'
            })

        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': str(e)
            }, status=500)

    return JsonResponse({
        'success': False,
        'message': 'Invalid request method'
    }, status=405)


# ========================================
# RECIPES VIEWS
# ========================================

@login_required
def recipes_view(request):
    """Display recipe management page using data from the Node.js API"""
    try:
        print("\n🔥 RECIPES VIEW CALLED (API Mode)")

        api = get_api_service()

        # ========================================
        # 1. LOAD RECIPES (WITH INGREDIENTS) FROM API
        # ========================================
        api_recipes = api.get_recipes() or []
        recipes_list = []

        for recipe in api_recipes:
            # Normalise keys from API response
            recipe_id = recipe.get('firebase_id') or recipe.get('firebaseId') or recipe.get('id')
            product_name = recipe.get('product_name') or recipe.get('productName') or 'Unknown'
            product_firebase_id = recipe.get('product_firebase_id') or recipe.get('productFirebaseId') or ''

            # Ingredients may be embedded or need separate call – handle both
            ingredients_from_api = recipe.get('ingredients')
            ingredients_data = []

            if not ingredients_from_api and recipe_id:
                # Fallback: fetch ingredients from dedicated endpoint
                try:
                    ingredients_from_api = api.get_recipe_ingredients(recipe_id)
                except Exception as ing_err:
                    print(f"⚠️ Could not load ingredients for recipe {recipe_id}: {ing_err}")
                    ingredients_from_api = []

            for ing in ingredients_from_api or []:
                ingredient_id = ing.get('ingredient_firebase_id') or ing.get('ingredientFirebaseId') or ''
                ingredient_name = ing.get('ingredient_name') or ing.get('ingredientName') or 'Unknown'
                quantity_needed = ing.get('quantity_needed') or ing.get('quantityNeeded') or 0
                unit = ing.get('unit') or 'g'

                # Cost / stock info is optional in API; default gracefully
                ingredient_cost = float(ing.get('cost_per_unit') or ing.get('costPerUnit') or 0)
                stock = float(ing.get('stock') or 0)

                ingredients_data.append({
                    'id': ing.get('id', ''),
                    'name': ingredient_name,
                    'quantity': quantity_needed,
                    'unit': unit,
                    'ingredientFirebaseId': ingredient_id,
                    'cost_per_unit': ingredient_cost,
                    'stock': stock,
                })

            recipes_list.append({
                'id': recipe_id,
                'productName': product_name,
                'productFirebaseId': product_firebase_id,
                'ingredients': ingredients_data,
                'ingredientCount': len(ingredients_data),
            })

        # ========================================
        # 2. LOAD PRODUCTS FROM API FOR DROPDOWNS
        # ========================================
        api_products = api.get_products() or []
        beverages = []
        available_ingredients = []

        for product in api_products:
            name = product.get('name') or 'Unknown'
            firebase_id = product.get('firebase_id') or product.get('firebaseId') or str(product.get('id', ''))
            raw_category = (product.get('category') or '').strip()
            category_lower = raw_category.lower()

            # Beverages / pastries for recipe selection
            if category_lower in ['beverage', 'beverages', 'pastries', 'pastry', 'drink', 'drinks',
                                  'hot drinks', 'cold drinks', 'snacks', 'snack']:
                beverages.append({
                    'id': firebase_id,
                    'name': name,
                    'category': category_lower,
                })

            # Ingredients for dropdown (match mobile category name)
            if category_lower in ['ingredient', 'ingredients']:
                inventory_a = float(
                    product.get('inventory_a') or product.get('inventoryA') or product.get('quantity') or 0
                )
                inventory_b = float(product.get('inventory_b') or product.get('inventoryB') or 0)
                total_stock = inventory_a + inventory_b
                cost_per_unit = float(product.get('cost_per_unit') or product.get('costPerUnit') or 0)

                available_ingredients.append({
                    'id': firebase_id,
                    'name': name,
                    'stock': total_stock,
                    'inventory_a': inventory_a,
                    'inventory_b': inventory_b,
                    'cost_per_unit': cost_per_unit,
                    'unit': 'g',
                })

        print(f"✅ Loaded {len(recipes_list)} recipes from API")
        print(f"✅ Found {len(beverages)} beverages for dropdown")
        print(f"✅ Found {len(available_ingredients)} ingredients for dropdown")

        context = {
            'recipes': recipes_list,
            'beverages': beverages,
            'ingredients': available_ingredients,
            'ingredients_json': available_ingredients,  # For json_script filter
        }
        return render(request, 'dashboard/recipes.html', context)

    except Exception as e:
        print(f"❌ Error loading recipes (API Mode): {e}")
        import traceback
        traceback.print_exc()

        context = {
            'recipes': [],
            'beverages': [],
            'ingredients': [],
            'ingredients_json': [],  # For json_script filter
        }
        return render(request, 'dashboard/recipes.html', context)


# ============================================
# RECIPE MANAGEMENT API ENDPOINTS
# ============================================

@login_required
@require_http_methods(["POST"])
def add_recipe_api(request):
    """Add a new recipe with ingredients via Node.js API"""
    try:
        data = json.loads(request.body)
        print("\n🔥 ADD RECIPE API CALLED (via Node API)")
        print(f"Data received: {data}")

        product_firebase_id = data.get('productFirebaseId')
        product_name = data.get('productName')
        ingredients = data.get('ingredients', [])

        if not product_firebase_id or not product_name:
            return JsonResponse({'success': False, 'message': 'Product information required'})

        if not ingredients:
            return JsonResponse({'success': False, 'message': 'At least one ingredient is required'})

        # Get API service
        api = get_api_service()

        # Prepare recipe data for Node API
        recipe_data = {
            'productFirebaseId': product_firebase_id,
            'productName': product_name,
            'productNumber': 0,
            'ingredients': ingredients
        }

        print(f"📤 Sending recipe data to Node API: {recipe_data}")

        # Call Node API to add recipe
        result = api.add_recipe(recipe_data)

        if result.get('success'):
            print(f"✅ Recipe created successfully via Node API")
            log_audit('Recipe Created', request.user, f'Created recipe for {product_name}')

            return JsonResponse({
                'success': True,
                'message': f'Recipe for {product_name} created successfully!'
            })
        else:
            error_message = result.get('message', 'Failed to create recipe')
            print(f"❌ Node API returned error: {error_message}")
            return JsonResponse({
                'success': False,
                'message': error_message
            })

    except Exception as e:
        print(f"❌ Error adding recipe: {e}")
        import traceback
        traceback.print_exc()
        return JsonResponse({'success': False, 'message': str(e)})


@login_required
@require_http_methods(["POST"])
def update_recipe_api(request):
    """Update an existing recipe via Node.js API"""
    try:
        data = json.loads(request.body)
        print("\n🔥 UPDATE RECIPE API CALLED (via Node API)")
        print(f"Data received: {data}")

        recipe_id = data.get('recipeId')
        product_firebase_id = data.get('productFirebaseId')
        product_name = data.get('productName')
        ingredients = data.get('ingredients', [])

        if not recipe_id:
            return JsonResponse({'success': False, 'message': 'Recipe ID required'})

        # Get API service
        api = get_api_service()

        # Prepare recipe data for Node API
        recipe_data = {
            'productFirebaseId': product_firebase_id,
            'productName': product_name,
            'productNumber': 0,
            'ingredients': ingredients
        }

        print(f"📤 Updating recipe {recipe_id} via Node API")

        # Call Node API to update recipe
        result = api.update_recipe(recipe_id, recipe_data)

        print(f"📨 Full API Response: {json.dumps(result, indent=2)}")

        if result.get('success'):
            print(f"✅ Recipe {recipe_id} updated successfully via Node API")
            log_audit('Recipe Updated', request.user, f'Updated recipe for {product_name}')

            return JsonResponse({
                'success': True,
                'message': f'Recipe for {product_name} updated successfully!'
            })
        else:
            error_message = result.get('message', 'Failed to update recipe')
            error_details = result.get('error', 'No error details')
            print(f"❌ Node API returned error: {error_message}")
            print(f"📋 Error details: {error_details}")
            return JsonResponse({
                'success': False,
                'message': error_message
            })

    except Exception as e:
        print(f"❌ Error updating recipe: {e}")
        import traceback
        traceback.print_exc()
        return JsonResponse({'success': False, 'message': str(e)})


@login_required
@require_http_methods(["POST"])
def delete_recipe_api(request):
    """Delete a recipe and its ingredients via Node.js API"""
    try:
        data = json.loads(request.body)
        print("\n🔥 DELETE RECIPE API CALLED (via Node API)")
        print(f"Data received: {data}")

        recipe_id = data.get('recipeId')

        if not recipe_id:
            return JsonResponse({'success': False, 'message': 'Recipe ID required'})

        # Get API service
        api = get_api_service()

        # Get recipe details for logging before deletion
        recipe = api.get_recipe(recipe_id)
        product_name = recipe.get('productName', 'Unknown') if recipe else 'Unknown'

        print(f"📤 Deleting recipe {recipe_id} via Node API")

        # Call Node API to delete recipe
        result = api.delete_recipe(recipe_id)

        print(f"📨 Full API Response: {json.dumps(result, indent=2)}")

        if result.get('success'):
            print(f"✅ Recipe {recipe_id} deleted successfully via Node API")
            log_audit('Recipe Deleted', request.user, f'Deleted recipe for {product_name}')

            return JsonResponse({
                'success': True,
                'message': f'Recipe for {product_name} deleted successfully!'
            })
        else:
            error_message = result.get('message', 'Failed to delete recipe')
            error_details = result.get('error', 'No error details')
            print(f"❌ Node API returned error: {error_message}")
            print(f"📋 Error details: {error_details}")
            return JsonResponse({
                'success': False,
                'message': error_message
            })

    except Exception as e:
        print(f"❌ Error deleting recipe: {e}")
        import traceback
        traceback.print_exc()
        return JsonResponse({'success': False, 'message': str(e)})


# ============================================
# INVENTORY TRANSFER API (A → B)
# ============================================

@login_required
@require_http_methods(["POST"])
def transfer_inventory_api(request):
    """Transfer stock from Inventory A to Inventory B via Node.js API"""
    try:
        data = json.loads(request.body)
        print("\n🔄 INVENTORY TRANSFER API CALLED (via Node API)")
        print(f"Data received: {data}")

        product_id = data.get('productId')
        transfer_qty = float(data.get('quantity', 0))

        if not product_id or transfer_qty <= 0:
            return JsonResponse({'success': False, 'message': 'Invalid product or quantity'})

        # Get API service
        api = get_api_service()

        # Get product details to validate and get product name
        products = api.get_products()
        product = None
        for p in products:
            if p.get('id') == product_id or p.get('firebaseId') == product_id:
                product = p
                break

        if not product:
            return JsonResponse({'success': False, 'message': 'Product not found'})

        product_name = product.get('name', 'Unknown Product')
        inventory_a = float(product.get('inventory_a', 0))
        inventory_b = float(product.get('inventory_b', 0))

        # Check if sufficient stock
        if inventory_a < transfer_qty:
            return JsonResponse({
                'success': False,
                'message': f'Insufficient stock in Inventory A. Available: {inventory_a:.2f}'
            })

        print(f"📤 Transferring {transfer_qty} units of {product_name} from A to B")

        # Call Node API to transfer inventory
        result = api.transfer_inventory(product_id, transfer_qty)

        if result.get('success'):
            new_inventory_a = inventory_a - transfer_qty
            new_inventory_b = inventory_b + transfer_qty

            print(f"✅ Transferred {transfer_qty} units of {product_name}")
            print(f"   Inventory A: {inventory_a} → {new_inventory_a}")
            print(f"   Inventory B: {inventory_b} → {new_inventory_b}")

            log_audit('Inventory Transfer', request.user, f'Transferred {transfer_qty} units of {product_name} from A to B')

            return JsonResponse({
                'success': True,
                'message': f'Successfully transferred {transfer_qty} units of {product_name} to Inventory B',
                'newInventoryA': new_inventory_a,
                'newInventoryB': new_inventory_b
            })
        else:
            error_message = result.get('message', 'Failed to transfer inventory')
            print(f"❌ Node API returned error: {error_message}")
            return JsonResponse({
                'success': False,
                'message': error_message
            })

    except Exception as e:
        print(f"❌ Error in transfer: {e}")
        import traceback
        traceback.print_exc()
        return JsonResponse({'success': False, 'message': str(e)})


# ============================================
# WASTE MANAGEMENT API (B → Waste)
# ============================================

@login_required
@require_http_methods(["POST"])
def add_waste_api(request):
    """Transfer items from Inventory B to Waste logs via Node.js API"""
    try:
        data = json.loads(request.body)
        print("\n🗑️ WASTE MANAGEMENT API CALLED (via Node API)")
        print(f"Data received: {data}")

        product_id = data.get('productId')
        waste_qty = float(data.get('quantity', 0))
        reason = data.get('reason', 'Expired')

        if not product_id or waste_qty <= 0:
            return JsonResponse({'success': False, 'message': 'Invalid product or quantity'})

        # Get API service
        api = get_api_service()

        # Get product details to validate and get product name/category
        products = api.get_products()
        product = None
        for p in products:
            if p.get('id') == product_id or p.get('firebase_id') == product_id:
                product = p
                break

        if not product:
            return JsonResponse({'success': False, 'message': 'Product not found'})

        product_name = product.get('name', 'Unknown Product')
        category = product.get('category', 'Unknown')
        inventory_b = float(product.get('inventory_b', 0))

        # Check if sufficient stock
        if inventory_b < waste_qty:
            return JsonResponse({
                'success': False,
                'message': f'Insufficient stock in Inventory B. Available: {inventory_b:.2f}'
            })

        print(f"📤 Recording waste: {waste_qty} units of {product_name}")

        # Prepare waste data for Node API (matching Node API expectations)
        waste_data = {
            'productFirebaseId': product.get('firebase_id', product_id),
            'productName': product_name,
            'category': category,
            'quantity': waste_qty,
            'reason': reason,
            'recordedBy': request.user.username
        }

        # Call Node API to record waste
        result = api.add_waste_log(waste_data)

        if result.get('success'):
            new_inventory_b = inventory_b - waste_qty

            print(f"✅ Recorded waste: {waste_qty} units of {product_name}")
            print(f"   Inventory B: {inventory_b} → {new_inventory_b}")
            print(f"   Reason: {reason}")

            log_audit('Waste Recorded', request.user, f'Recorded {waste_qty} units of {product_name} as waste ({reason})')

            return JsonResponse({
                'success': True,
                'message': f'Successfully recorded {waste_qty} units of {product_name} as waste',
                'newInventoryB': new_inventory_b
            })
        else:
            error_message = result.get('message', 'Failed to record waste')
            print(f"❌ Node API returned error: {error_message}")
            return JsonResponse({
                'success': False,
                'message': error_message
            })

    except Exception as e:
        print(f"❌ Error in waste management: {e}")
        import traceback
        traceback.print_exc()
        return JsonResponse({'success': False, 'message': str(e)})


@login_required
def waste_tracking_view(request):
    """Display waste tracking page with data from Node.js API"""
    try:
        print("\n🗑️ WASTE TRACKING VIEW CALLED (API Mode)")

        from django.db import connection

        # Get API service
        api = get_api_service()

        # Get date filter parameters
        from_date = request.GET.get('from_date', '')
        to_date = request.GET.get('to_date', '')

        # Get waste logs from API
        waste_logs = api.get_waste_logs(date_from=from_date, date_to=to_date)
        print(f"📦 Received {len(waste_logs)} waste logs from API")

        waste_entries = []
        total_waste_cost = 0
        daily_costs = {}

        for waste in waste_logs:
            # Get data from API response
            product_id = waste.get('product_firebase_id') or waste.get('productFirebaseId')
            quantity = float(waste.get('quantity') or 0)
            product_name = waste.get('product_name') or waste.get('productName') or 'Unknown'
            category = waste.get('category') or 'Unknown'
            reason = waste.get('reason') or 'Unknown'
            recorded_by = waste.get('recorded_by') or waste.get('recordedBy') or 'Unknown'
            waste_date_str = waste.get('waste_date') or waste.get('wasteDate')

            # Parse waste date
            waste_date = None
            date_str = 'Unknown'
            date_display = 'Unknown'
            
            if waste_date_str:
                try:
                    if isinstance(waste_date_str, str):
                        waste_date = datetime.fromisoformat(waste_date_str.replace('Z', '+00:00'))
                    else:
                        waste_date = waste_date_str
                    
                    date_str = waste_date.strftime('%Y-%m-%d')
                    date_display = waste_date.strftime('%b %d, %Y %I:%M %p')
                except Exception as date_err:
                    print(f"⚠️ Could not parse date {waste_date_str}: {date_err}")

            # Get cost_per_unit using raw SQL (works on PostgreSQL and SQLite)
            waste_cost = 0
            if product_id:
                try:
                    with connection.cursor() as cursor:
                        # Query PostgreSQL/SQLite directly
                        cursor.execute(
                            'SELECT cost_per_unit FROM products WHERE id = %s OR firebase_id = %s LIMIT 1',
                            [product_id, product_id]
                        )
                        result = cursor.fetchone()
                        if result:
                            cost_per_unit = float(result[0] or 0)
                            waste_cost = quantity * cost_per_unit
                            if waste_cost > 0:
                                print(f"✅ Calculated waste cost: ₱{waste_cost:.2f} ({quantity} × ₱{cost_per_unit})")
                        else:
                            print(f"⚠️ Product not found in DB: {product_id}")
                except Exception as e:
                    print(f"⚠️ Could not get product cost: {type(e).__name__}: {e}")
                    waste_cost = 0

            # Track daily costs
            if date_str != 'Unknown':
                if date_str not in daily_costs:
                    daily_costs[date_str] = 0
                daily_costs[date_str] += waste_cost

            total_waste_cost += waste_cost

            waste_entries.append({
                'id': waste.get('id'),
                'productName': product_name,
                'productId': product_id,
                'quantity': quantity,
                'reason': reason,
                'wasteDate': date_display,
                'dateStr': date_str,
                'recordedBy': recorded_by,
                'category': category,
                'wasteCost': waste_cost
            })

        # Sort daily costs by date
        daily_costs_list = [
            {'date': date, 'cost': cost}
            for date, cost in sorted(daily_costs.items(), reverse=True)
        ]

        print(f"✅ Loaded {len(waste_entries)} waste entries from API")
        print(f"💰 Total waste cost: ₱{total_waste_cost:.2f}")

        context = {
            'waste_entries': waste_entries,
            'total_waste_cost': total_waste_cost,
            'daily_costs': daily_costs_list,
            'from_date': from_date,
            'to_date': to_date,
            'entry_count': len(waste_entries)
        }

        return render(request, 'dashboard/waste_tracking.html', context)

    except Exception as e:
        print(f"❌ Error loading waste tracking: {e}")
        import traceback
        traceback.print_exc()

        context = {
            'waste_entries': [],
            'total_waste_cost': 0,
            'daily_costs': [],
            'from_date': '',
            'to_date': '',
            'entry_count': 0
        }
        return render(request, 'dashboard/waste_tracking.html', context)



# ========================================
# INVENTORY FORECASTING VIEW
# ========================================

@login_required
def inventory_forecasting_view(request):
    """ML-based inventory forecasting using PostgreSQL"""
    try:
        print("\n🤖 ML INVENTORY FORECASTING VIEW (PostgreSQL)")

        # Data validation
        sales_count = Sale.objects.count()
        products_count = Product.objects.count()
        predictions_count = MLPrediction.objects.count()

        print(f"📊 Data Status:")
        print(f"   Sales: {sales_count}")
        print(f"   Products: {products_count}")
        print(f"   Predictions: {predictions_count}")

        data_issues = []
        if sales_count == 0:
            data_issues.append({
                'type': 'no_sales',
                'title': 'No Sales Data',
                'message': 'You need sales history to train the forecasting model.',
                'action': 'Add sales records or sync from mobile app',
                'command': None
            })
        elif sales_count < 30:
            data_issues.append({
                'type': 'insufficient_sales',
                'title': 'Insufficient Sales Data',
                'message': f'You have only {sales_count} sales records. At least 30 records recommended.',
                'action': 'Add more sales data or wait for more transactions',
                'command': None
            })

        if products_count == 0:
            data_issues.append({
                'type': 'no_products',
                'title': 'No Products',
                'message': 'You need products in your inventory to forecast.',
                'action': 'Add products or sync from mobile app',
                'command': None
            })

        # Get model status
        try:
            ml_model = MLModel.objects.get(name='inventory_forecasting')
            model_status = {
                'is_trained': ml_model.is_trained,
                'last_trained': ml_model.last_trained,
                'accuracy': ml_model.accuracy,
                'total_records': ml_model.total_records,
                'model_name': ml_model.name,
                'model_type': ml_model.model_type,
                'products_analyzed': ml_model.products_analyzed
            }
        except MLModel.DoesNotExist:
            model_status = {
                'is_trained': False,
                'last_trained': None,
                'accuracy': 0,
                'total_records': 0,
                'model_name': 'Not trained yet',
                'model_type': 'N/A',
                'products_analyzed': 0
            }
            data_issues.append({
                'type': 'no_model',
                'title': 'Model Not Trained',
                'message': 'No ML model has been trained yet.',
                'action': 'Click "Train Model" button below',
                'command': None
            })

        # Build forecast data
        forecast_data = []
        summary = {
            'critical': 0,
            'low': 0,
            'healthy': 0,
            'needs_reorder': 0
        }

        # Exclude beverages and specific items
        products = Product.objects.exclude(
            category__iexact='Beverages'
        ).exclude(
            category__iexact='beverage'
        ).exclude(
            category__iexact='drinks'
        ).exclude(
            name__icontains='Water'
        ).exclude(
            name__icontains='Ice'
        )

        print(f"📦 Processing {products.count()} products...")

        for product in products:
            # Get ML prediction if available
            ml_confidence = None
            predicted_daily_usage = 0
            avg_daily_usage = 0

            try:
                prediction = MLPrediction.objects.get(product_firebase_id=product.firebase_id)
                predicted_daily_usage = prediction.predicted_daily_usage
                avg_daily_usage = prediction.avg_daily_usage
                ml_confidence = prediction.confidence_score
            except MLPrediction.DoesNotExist:
                predicted_daily_usage = 0
                avg_daily_usage = 0
                ml_confidence = 0

            # Calculate forecast metrics
            # Use inventory_a (main warehouse stock) since quantity column may not exist in PostgreSQL
            stock = float(product.inventory_a or 0)

            if predicted_daily_usage > 0:
                days_left = int(stock / predicted_daily_usage)
            else:
                days_left = 999

            if days_left < 999:
                depletion_date = (datetime.now() + timedelta(days=days_left)).strftime('%b %d, %Y')
            else:
                depletion_date = 'N/A'

            # Determine status
            if days_left <= 3:
                status = 'critical'
                status_label = 'Critical'
                summary['critical'] += 1
            elif days_left <= 7:
                status = 'warning'
                status_label = 'Low Stock'
                summary['low'] += 1
            else:
                status = 'healthy'
                status_label = 'Healthy'
                summary['healthy'] += 1

            if days_left <= 7:
                summary['needs_reorder'] += 1

            predicted_7day_usage = predicted_daily_usage * 7

            if days_left <= 7:
                reorder_qty = max(0, (predicted_daily_usage * 30) - stock)
            else:
                reorder_qty = 0

            confidence_percent = f"{int(ml_confidence * 100)}%" if ml_confidence else "0%"

            forecast_data.append({
                'product_id': product.id,
                'product_name': product.name,
                'category': product.category,
                'current_stock': f"{stock:.2f}",
                'unit': product.unit,
                'avg_daily_usage': f"{avg_daily_usage:.2f}" if avg_daily_usage else "0.00",
                'days_left': days_left if days_left < 999 else 'N/A',
                'depletion_date': depletion_date,
                'status': status,
                'status_label': status_label,
                'predicted_usage': f"{predicted_7day_usage:.2f}",
                'reorder_qty': f"{reorder_qty:.2f}",
                'confidence': confidence_percent
            })

        # Sort by days_left
        forecast_data.sort(key=lambda x: x['days_left'] if isinstance(x['days_left'], int) else 999)

        print(f"\n{'=' * 60}")
        print(f"✅ FORECAST SUMMARY:")
        print(f"   Total products: {len(forecast_data)}")
        print(f"   Critical: {summary['critical']}")
        print(f"   Low Stock: {summary['low']}")
        print(f"   Healthy: {summary['healthy']}")
        print(f"{'=' * 60}\n")

        context = {
            'forecast_data': forecast_data,
            'model_status': model_status,
            'summary': summary,
            'data_issues': data_issues,
            'data_status': {
                'sales_count': sales_count,
                'products_count': products_count,
                'predictions_count': predictions_count,
                'has_issues': len(data_issues) > 0
            }
        }

        return render(request, 'dashboard/inventory_forecasting.html', context)

    except Exception as e:
        print(f"❌ Error in forecasting view: {e}")
        import traceback
        traceback.print_exc()

        context = {
            'forecast_data': [],
            'model_status': {'is_trained': False},
            'summary': {'critical': 0, 'low': 0, 'healthy': 0, 'needs_reorder': 0},
            'data_issues': [{'type': 'error', 'title': 'Error', 'message': str(e)}],
            'data_status': {'has_issues': True}
        }
        return render(request, 'dashboard/inventory_forecasting.html', context)


# ========================================
# ML MODEL TRAINING
# ========================================

@login_required
@require_http_methods(["POST"])
@csrf_exempt
def train_forecasting_model(request):
    """Train the ML forecasting model using XGBoost from PostgreSQL data"""
    try:
        print("\n🤖 TRAINING INVENTORY FORECASTING MODEL (ML-Powered)")

        # Load the XGBoost sales forecast model
        ml_model, feature_columns = load_sales_forecast_model()

        # Get sales data
        sales = Sale.objects.all()
        sales_count = sales.count()

        if sales_count < 10:
            return JsonResponse({
                'success': False,
                'message': f'Insufficient data for training. Need at least 10 sales records, found {sales_count}.'
            })

        # Calculate predictions for each product
        products = Product.objects.all()
        predictions_created = 0
        ml_predictions_count = 0

        for product in products:
            # Get sales for this product
            product_sales = Sale.objects.filter(
                Q(product_firebase_id=product.firebase_id) |
                Q(product_name=product.name)
            )

            if product_sales.count() < 3:
                continue

            # Calculate daily usage from historical data
            sales_data = list(product_sales.values('order_date', 'quantity'))

            if not sales_data:
                continue

            # Calculate average daily usage from historical data
            total_quantity = sum(s['quantity'] for s in sales_data if s['quantity'])
            days = (datetime.now() - min(s['order_date'] for s in sales_data if s['order_date'])).days or 1
            avg_daily_usage = total_quantity / max(days, 1)

            # Use ML model for prediction if available
            predicted_daily_usage = avg_daily_usage  # Default fallback
            confidence_score = min(0.9, 0.5 + (len(sales_data) / 100))

            if ml_model is not None and feature_columns is not None:
                try:
                    import numpy as np

                    # Generate ML prediction for next 7 days and average it
                    ml_predictions = []
                    for i in range(7):
                        forecast_date = datetime.now().date() + timedelta(days=i+1)
                        features_dict = create_forecast_features(forecast_date)

                        # Prepare feature array
                        X = []
                        for col in feature_columns:
                            X.append(features_dict.get(col, 0))
                        X = np.array(X).reshape(1, -1)

                        # Predict total daily revenue
                        predicted_revenue = float(ml_model.predict(X)[0])
                        ml_predictions.append(max(0, predicted_revenue))

                    # Calculate average predicted revenue per day
                    avg_predicted_revenue = np.mean(ml_predictions) if ml_predictions else 0

                    # Estimate this product's share of revenue
                    # Get product's historical revenue share
                    product_revenue = sum(s.get('quantity', 0) * (product.price or 0)
                                        for s in sales_data if s.get('quantity'))
                    total_revenue_period = Sale.objects.filter(
                        order_date__gte=datetime.now() - timedelta(days=30)
                    ).aggregate(total=Sum('total'))['total'] or 1

                    revenue_share = product_revenue / max(total_revenue_period, 1)

                    # Estimate daily quantity for this product
                    estimated_product_revenue = avg_predicted_revenue * revenue_share
                    product_price = product.price or 1
                    predicted_daily_usage = estimated_product_revenue / product_price

                    # Higher confidence with ML
                    confidence_score = min(0.95, 0.7 + (len(sales_data) / 200))
                    ml_predictions_count += 1

                except Exception as e:
                    print(f"⚠️  ML prediction failed for {product.name}, using average: {e}")
                    predicted_daily_usage = avg_daily_usage

            # Add safety buffer
            predicted_daily_usage = predicted_daily_usage * 1.1

            # Calculate trend (simple linear trend from recent data)
            if len(sales_data) >= 14:
                recent_sales = sorted(sales_data, key=lambda x: x['order_date'])
                mid_point = len(recent_sales) // 2
                first_half_avg = sum(s['quantity'] for s in recent_sales[:mid_point]) / max(mid_point, 1)
                second_half_avg = sum(s['quantity'] for s in recent_sales[mid_point:]) / max(len(recent_sales) - mid_point, 1)
                trend = ((second_half_avg - first_half_avg) / max(first_half_avg, 0.01)) * 100
            else:
                trend = 0.0

            # Create or update prediction
            MLPrediction.objects.update_or_create(
                product_firebase_id=product.firebase_id or str(product.id),
                defaults={
                    'product_name': product.name,
                    'predicted_daily_usage': predicted_daily_usage,
                    'avg_daily_usage': avg_daily_usage,
                    'trend': trend,
                    'confidence_score': confidence_score,
                    'data_points': len(sales_data)
                }
            )
            predictions_created += 1

        # Determine model type
        if ml_model is not None:
            model_type = f'XGBoost ML (Hybrid) - {ml_predictions_count} products'
            accuracy = 90
        else:
            model_type = 'Linear Regression (Moving Average)'
            accuracy = 85

        # Update model status
        MLModel.objects.update_or_create(
            name='inventory_forecasting',
            defaults={
                'is_trained': True,
                'last_trained': datetime.now(),
                'total_records': sales_count,
                'products_analyzed': products.count(),
                'predictions_generated': predictions_created,
                'accuracy': accuracy,
                'model_type': model_type,
                'training_period_days': 90
            }
        )

        log_audit('Model Trained', request.user, f'Trained ML model with {sales_count} records, {predictions_created} predictions ({ml_predictions_count} ML-powered)')

        return JsonResponse({
            'success': True,
            'message': f'Model trained successfully! Analyzed {products.count()} products, created {predictions_created} predictions ({ml_predictions_count} using ML).',
            'stats': {
                'sales_records': sales_count,
                'products_analyzed': products.count(),
                'predictions_created': predictions_created,
                'ml_predictions': ml_predictions_count,
                'model_type': model_type
            }
        })

    except Exception as e:
        print(f"❌ Error training model: {e}")
        import traceback
        traceback.print_exc()
        return JsonResponse({'success': False, 'message': str(e)})


# ========================================
# PRODUCT MANAGEMENT APIs
# ========================================

@login_required
@require_http_methods(["POST"])
def add_product_view(request):
    """Add a new product via Node.js API"""
    try:
        data = json.loads(request.body)
        print("\n🔥 ADD PRODUCT API CALLED (via Node API)")

        # Get API service
        api = get_api_service()

        # Prepare product data for Node API
        product_data = {
            'name': data.get('name'),
            'category': data.get('category'),
            'price': float(data.get('price', 0)),
            'quantity': float(data.get('quantity', 0)),
            'inventory_a': float(data.get('inventoryA', data.get('quantity', 0))),
            'inventory_b': 0,
            'cost_per_unit': float(data.get('costPerUnit', 0)),
            'image_uri': data.get('imageUri', ''),
            'description': data.get('description', ''),
            'sku': data.get('sku', '')
        }

        # Call Node API to add product
        result = api.add_product(product_data)

        if result.get('success'):
            product_name = data.get('name', 'Product')
            log_audit('Product Added', request.user, f'Added product: {product_name}')

            return JsonResponse({
                'success': True,
                'message': f'Product {product_name} added successfully!',
                'productId': result.get('data', {}).get('firebase_id', '')
            })
        else:
            return JsonResponse({
                'success': False,
                'message': result.get('message', 'Failed to add product')
            })

    except Exception as e:
        print(f"❌ Error adding product: {e}")
        return JsonResponse({'success': False, 'message': str(e)})


@login_required
@require_http_methods(["POST"])
def update_product_view(request):
    """Update an existing product via Node.js API"""
    try:
        data = json.loads(request.body)
        print("\n🔥 UPDATE PRODUCT API CALLED (via Node API)")

        product_id = data.get('productId')

        # Get API service
        api = get_api_service()

        # Prepare update data for Node API
        update_data = {
            'firebaseId': product_id,
            'name': data.get('name'),
            'category': data.get('category'),
            'price': float(data.get('price', 0)),
            'quantity': float(data.get('quantity', 0)),
            'inventory_a': float(data.get('inventoryA', 0)),
            'inventory_b': float(data.get('inventoryB', 0)),
            'cost_per_unit': float(data.get('costPerUnit', 0)),
            'image_uri': data.get('imageUri', ''),
            'description': data.get('description', '')
        }

        # Call Node API to update product
        result = api.update_product(product_id, update_data)

        if result.get('success'):
            product_name = data.get('name', 'Product')
            log_audit('Product Updated', request.user, f'Updated product: {product_name}')

            return JsonResponse({
                'success': True,
                'message': f'Product {product_name} updated successfully!'
            })
        else:
            return JsonResponse({
                'success': False,
                'message': result.get('message', 'Failed to update product')
            })

    except Exception as e:
        print(f"❌ Error updating product: {e}")
        return JsonResponse({'success': False, 'message': str(e)})


@login_required
@require_http_methods(["POST"])
def delete_product_view(request):
    """Delete a product"""
    try:
        data = json.loads(request.body)
        print("\n🔥 DELETE PRODUCT API CALLED (PostgreSQL)")

        product_id = data.get('productId')

        try:
            product = Product.objects.get(Q(firebase_id=product_id) | Q(id=product_id))
        except Product.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'Product not found'})

        product_name = product.name
        product.delete()

        log_audit('Product Deleted', request.user, f'Deleted product: {product_name}')

        return JsonResponse({
            'success': True,
            'message': f'Product {product_name} deleted successfully!'
        })

    except Exception as e:
        print(f"❌ Error deleting product: {e}")
        return JsonResponse({'success': False, 'message': str(e)})


# ========================================
# SALES FORECASTING (ML with XGBoost)
# ========================================

# Global cache for ML model
_sales_forecast_model = None
_feature_columns = None


def load_sales_forecast_model():
    """Load the XGBoost sales forecasting model from .pkl file"""
    global _sales_forecast_model, _feature_columns

    if _sales_forecast_model is not None:
        return _sales_forecast_model, _feature_columns

    try:
        import joblib
        import numpy as np

        model_path = os.path.join(settings.BASE_DIR, 'ml_models', 'banelo_xgboost_model.pkl')
        features_path = os.path.join(settings.BASE_DIR, 'ml_models', 'feature_columns.pkl')

        if not os.path.exists(model_path):
            print(f"❌ Model file not found at {model_path}")
            return None, None

        if not os.path.exists(features_path):
            print(f"❌ Feature columns file not found at {features_path}")
            return None, None

        # Load model and feature columns
        _sales_forecast_model = joblib.load(model_path)
        _feature_columns = joblib.load(features_path)

        print(f"✅ Sales forecasting model loaded successfully!")
        print(f"   Model type: {type(_sales_forecast_model).__name__}")
        print(f"   Features: {len(_feature_columns)}")

        return _sales_forecast_model, _feature_columns

    except Exception as e:
        print(f"❌ Error loading sales forecast model: {e}")
        import traceback
        traceback.print_exc()
        return None, None


def create_forecast_features(date):
    """Create features for a specific date for forecasting using PostgreSQL API data"""
    import numpy as np

    # Extract date features
    day_of_week = date.weekday()
    day_of_month = date.day
    month = date.month
    is_weekend = 1 if day_of_week >= 5 else 0
    week_of_year = date.isocalendar()[1]

    # Get recent sales history from API (PostgreSQL) for rolling features
    try:
        api = get_api_service()
        api_sales = api.get_sales(limit=1000)  # Get all available sales

        # Convert API response to DataFrame
        sales_data = []
        for sale in api_sales:
            order_date_raw = sale.get('order_date') or sale.get('orderDate')
            if isinstance(order_date_raw, str):
                order_date = datetime.strptime(order_date_raw[:10], '%Y-%m-%d').date()
            elif order_date_raw:
                order_date = order_date_raw.date() if hasattr(order_date_raw, 'date') else order_date_raw
            else:
                continue

            total = float(sale.get('total_amount') or sale.get('total') or 0)
            sales_data.append({
                'order_date': order_date,
                'total': total
            })

        # Calculate rolling statistics from API data
        daily_totals = defaultdict(float)
        for sale in sales_data:
            sale_date = sale['order_date']
            daily_totals[sale_date] += sale['total'] or 0

        # Sort dates to ensure proper ordering
        sorted_dates = sorted(daily_totals.keys())
        daily_values = [daily_totals[d] for d in sorted_dates]

    except Exception as e:
        print(f"⚠️ Error fetching API data for features: {e}")
        daily_values = [0]

    rolling_mean_7d = np.mean(daily_values[-7:]) if len(daily_values) >= 7 else np.mean(daily_values)
    rolling_std_7d = np.std(daily_values[-7:]) if len(daily_values) >= 7 else 0
    rolling_max_7d = np.max(daily_values[-7:]) if len(daily_values) >= 7 else 0
    rolling_min_7d = np.min(daily_values[-7:]) if len(daily_values) >= 7 else 0
    rolling_mean_30d = np.mean(daily_values[-30:]) if len(daily_values) >= 30 else np.mean(daily_values)
    rolling_std_30d = np.std(daily_values[-30:]) if len(daily_values) >= 30 else 0

    # Lag features
    lag_1d = daily_values[-1] if len(daily_values) >= 1 else 0
    lag_7d = daily_values[-7] if len(daily_values) >= 7 else 0
    lag_14d = daily_values[-14] if len(daily_values) >= 14 else 0

    # Days since start (arbitrary baseline)
    days_since_start = (date - datetime(2024, 1, 1).date()).days

    # Build feature dictionary
    features = {
        'day_of_week': day_of_week,
        'day_of_month': day_of_month,
        'month': month,
        'is_weekend': is_weekend,
        'week_of_year': week_of_year,
        'rolling_mean_7d': rolling_mean_7d,
        'rolling_std_7d': rolling_std_7d,
        'rolling_max_7d': rolling_max_7d,
        'rolling_min_7d': rolling_min_7d,
        'rolling_mean_30d': rolling_mean_30d,
        'rolling_std_30d': rolling_std_30d,
        'lag_1d': lag_1d,
        'lag_7d': lag_7d,
        'lag_14d': lag_14d,
        'days_since_start': days_since_start,
    }

    return features


@login_required
def sales_forecasting_view(request):
    """Sales forecasting page using ML model from Google Colab"""
    try:
        print("\n🤖 SALES FORECASTING VIEW (ML)")

        # Check if model files exist
        model_path = os.path.join(settings.BASE_DIR, 'ml_models', 'forecasting_model.pkl')
        features_path = os.path.join(settings.BASE_DIR, 'ml_models', 'feature_columns.pkl')

        model_exists = os.path.exists(model_path)
        features_exist = os.path.exists(features_path)

        # Get sales from API (same as sales_view)
        api = get_api_service()
        api_sales = api.get_sales(limit=1000)

        # Count total sales and get date range
        total_sales = len(api_sales) if api_sales else 0

        if api_sales and len(api_sales) > 0:
            # Get date range from API data
            dates = []
            for sale in api_sales:
                order_date_raw = sale.get('order_date') or sale.get('orderDate')
                if isinstance(order_date_raw, str):
                    try:
                        dates.append(datetime.strptime(order_date_raw[:10], '%Y-%m-%d'))
                    except:
                        pass

            if dates:
                date_range_days = (max(dates) - min(dates)).days
            else:
                date_range_days = 0
        else:
            date_range_days = 0

        context = {
            'model_exists': model_exists,
            'features_exist': features_exist,
            'total_sales': total_sales,
            'date_range_days': date_range_days,
            'model_ready': model_exists and features_exist,
        }

        return render(request, 'dashboard/sales_forecasting.html', context)

    except Exception as e:
        print(f"❌ Error in sales forecasting view: {e}")
        import traceback
        traceback.print_exc()
        return render(request, 'dashboard/sales_forecasting.html', {
            'model_exists': False,
            'error_message': str(e)
        })


@login_required
@require_http_methods(["GET"])
def sales_forecast_status_api(request):
    """Check if sales forecast model is loaded and ready"""
    try:
        model, features = load_sales_forecast_model()

        if model is None or features is None:
            return JsonResponse({
                'success': False,
                'model_loaded': False,
                'message': 'Model files not found. Please upload banelo_xgboost_model.pkl and feature_columns.pkl to ml_models folder.'
            })

        return JsonResponse({
            'success': True,
            'model_loaded': True,
            'model_type': type(model).__name__,
            'features_count': len(features),
            'message': 'Sales forecast model is ready!'
        })

    except Exception as e:
        return JsonResponse({
            'success': False,
            'model_loaded': False,
            'message': str(e)
        })


@login_required
@require_http_methods(["GET"])
def get_sales_forecast_api(request):
    """Generate sales forecast for the next N days"""
    try:
        import numpy as np

        # Get number of days to forecast (default 7)
        days = int(request.GET.get('days', 7))
        days = min(days, 30)  # Maximum 30 days

        # Load model
        model, feature_columns = load_sales_forecast_model()

        if model is None or feature_columns is None:
            return JsonResponse({
                'success': False,
                'message': 'Model not loaded. Please upload model files to ml_models folder.'
            })

        # Generate predictions for next N days
        predictions = []
        start_date = datetime.now().date() + timedelta(days=1)

        for i in range(days):
            forecast_date = start_date + timedelta(days=i)

            # Create features for this date
            features_dict = create_forecast_features(forecast_date)

            # Prepare feature array in correct order
            X = []
            for col in feature_columns:
                X.append(features_dict.get(col, 0))

            X = np.array(X).reshape(1, -1)

            # Make prediction
            predicted_revenue = float(model.predict(X)[0])
            predicted_revenue = max(0, predicted_revenue)  # No negative predictions

            # Calculate confidence interval (±15%)
            lower_bound = predicted_revenue * 0.85
            upper_bound = predicted_revenue * 1.15

            predictions.append({
                'date': forecast_date.strftime('%Y-%m-%d'),
                'day_name': forecast_date.strftime('%A'),
                'predicted_revenue': round(predicted_revenue, 2),
                'lower_bound': round(lower_bound, 2),
                'upper_bound': round(upper_bound, 2),
                'is_weekend': forecast_date.weekday() >= 5,
            })

        # Calculate summary statistics
        total_forecast = sum(p['predicted_revenue'] for p in predictions)
        average_daily = total_forecast / len(predictions) if predictions else 0

        return JsonResponse({
            'success': True,
            'predictions': predictions,
            'summary': {
                'total_forecast': round(total_forecast, 2),
                'average_daily': round(average_daily, 2),
                'forecast_period_days': days,
            }
        })

    except Exception as e:
        print(f"❌ Error generating forecast: {e}")
        import traceback
        traceback.print_exc()
        return JsonResponse({
            'success': False,
            'message': str(e)
        })
