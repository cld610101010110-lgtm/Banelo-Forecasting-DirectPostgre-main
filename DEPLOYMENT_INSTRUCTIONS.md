# Deployment Instructions

## Recent Changes (2026-01-04)

### Bug Fixes & New Features

#### 1. Fixed Bugs:
- ✅ **Inventory Delete**: Now uses API service instead of Django ORM
- ✅ **Recipe Edit**: Fixed to use `firebase_id` consistently
- ✅ **Recipe Delete**: Fixed to use `firebase_id` consistently

#### 2. New Features:
- ✅ **Expiration Tracking**: Added `is_perishable`, `shelf_life_days`, `expiration_date` fields to products
- ✅ **Print Reports**: Added CSV/PDF export for waste, sales, and sales forecast
- ✅ **Recipe-Based Products**: Beverages and Pastries now automatically have 0 stock (recipe-based)

---

## Deployment Steps

### 1. Database Migration

Run the SQL migration to add expiration fields to the products table:

```bash
psql -h your_database_host -U your_database_user -d banelo_db -f nodejs-api/migrations/add_expiration_fields.sql
```

Or manually execute the SQL in your PostgreSQL database.

### 2. Install Node.js Dependencies

The following packages were added:
- `pdfkit` - PDF generation
- `csv-writer` - CSV export

Install them:

```bash
cd nodejs-api
npm install
```

### 3. Install Python Dependencies (Optional)

For sales forecast PDF export:

```bash
pip install reportlab
```

### 4. Restart Services

**Node.js API Server:**
```bash
cd nodejs-api
npm start
```

**Django Web Server:**
```bash
python manage.py runserver
```

---

## Testing the Fixes

### Test Inventory Delete:
1. Go to Inventory page
2. Try to delete a product
3. Should succeed without "no such column" error

### Test Recipe Edit:
1. Go to Recipe Management
2. Edit a recipe and modify ingredients
3. Save and verify changes persist after page refresh

### Test Recipe Delete:
1. Go to Recipe Management
2. Delete a recipe
3. Should succeed without errors

### Test Export Reports:

**Waste Report (CSV):**
```
GET /api/waste/export/csv?date_from=2024-01-01&date_to=2024-12-31
```

**Sales Report (PDF):**
```
GET /api/sales/export/pdf?date_from=2024-01-01&date_to=2024-12-31
```

**Sales Forecast (PDF):**
```
GET /dashboard/sales-forecast/export/pdf/?days=7
```

---

## API Changes

### New Product Fields

When creating or updating products via API, you can now include:

```json
{
  "firebase_id": "product_123",
  "name": "Milk",
  "category": "Dairy",
  "price": 50,
  "quantity": 100,
  "is_perishable": true,
  "shelf_life_days": 7,
  "expiration_date": "2024-12-31",
  "description": "Fresh milk",
  "sku": "MLK001"
}
```

### Recipe-Based Products

Products with category "Beverages" or "Pastries" will automatically have:
- `quantity = 0`
- `inventory_a = 0`
- `inventory_b = 0`

This prevents manual stock entry for recipe-based products.

---

## Debugging

### Enable Node.js API Logging

Check the console output when making API requests:
- Recipe operations show detailed logs with ✅ success and ❌ error icons
- Product operations show creation/update logs

### Check Database Connection

```bash
psql -h your_host -U your_user -d banelo_db
\dt  # List all tables
\d products  # Describe products table
```

Verify the following columns exist:
- `is_perishable`
- `shelf_life_days`
- `expiration_date`
- `is_active`
- `description`
- `sku`

---

## Troubleshooting

### "Column does not exist" errors

Run the migration SQL file to add missing columns.

### Recipe edit/delete not working

Check Node.js console logs for detailed error messages. The logs will show:
- Which recipe ID is being used
- Whether the recipe was found
- Any SQL errors

### Export reports failing

For Node.js exports (waste, sales):
```bash
cd nodejs-api
npm install pdfkit csv-writer
```

For Django exports (sales forecast):
```bash
pip install reportlab
```

---

## Rollback

If you need to rollback the expiration fields:

```sql
ALTER TABLE products
DROP COLUMN IF EXISTS is_perishable,
DROP COLUMN IF EXISTS shelf_life_days,
DROP COLUMN IF EXISTS expiration_date,
DROP COLUMN IF EXISTS is_active,
DROP COLUMN IF EXISTS description,
DROP COLUMN IF EXISTS sku;
```

Note: This will permanently delete any expiration data!
