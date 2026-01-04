# Expiration Tracking Feature Specification

## 📋 Requirements (From Research Team)

### **What Expires**
- ✅ **ONLY Ingredients** (raw materials used in recipes)
- ❌ **NOT finished products** (Beverages, Pastries)

### **How It Works**

1. **Setting Shelf Life**
   - User sets `shelf_life_days` when adding an ingredient
   - Example: "Milk has 7 days shelf life"
   - This is the countdown duration

2. **Starting the Countdown**
   - Countdown **STARTS** when ingredient is transferred from **Inventory A** to **Inventory B**
   - NOT when the ingredient is purchased or added
   - Transfer A→B means: "We're now using this batch"

3. **Expiration Date Calculation**
   ```
   Transfer Date (A→B) + Shelf Life Days = Expiration Date
   ```
   - Example: Transferred on Jan 1 + 7 days = Expires on Jan 8

4. **Automatic Waste Recording**
   - When expiration date is reached
   - System automatically creates a waste log entry
   - Reason: "Expired"

---

## 🗄️ Database Fields

```sql
products table:
├── is_perishable (boolean)      -- TRUE for ingredients that can expire
├── shelf_life_days (integer)    -- How many days until expiration
├── expiration_date (timestamp)  -- Calculated when transferred to B
└── transferred_to_b (boolean)   -- Track if moved from A to B
```

---

## 🔄 Implementation Flow

### **1. Add Ingredient (Inventory A)**
```javascript
{
  "name": "Fresh Milk",
  "category": "Ingredients",  // Not Beverages/Pastries
  "inventory_a": 100,
  "inventory_b": 0,
  "is_perishable": true,
  "shelf_life_days": 7,
  "expiration_date": null  // Not set yet!
}
```

### **2. Transfer A → B**
```javascript
// When user clicks "Transfer to Inventory B"
POST /api/products/transfer
{
  "firebaseId": "product_milk_001",
  "quantity": 50
}

// Backend calculates:
expiration_date = NOW() + shelf_life_days
// Example: 2024-01-01 + 7 days = 2024-01-08

// Update product:
{
  "inventory_a": 50,  // 100 - 50
  "inventory_b": 50,  // 0 + 50
  "expiration_date": "2024-01-08",
  "transferred_to_b": true
}
```

### **3. Daily Expiration Check (Scheduled Job)**
```javascript
// Run every day at midnight
async function checkExpiredIngredients() {
  // Find all expired ingredients
  const expired = await query(`
    SELECT * FROM products
    WHERE is_perishable = TRUE
      AND expiration_date IS NOT NULL
      AND expiration_date <= NOW()
      AND inventory_b > 0
  `);

  // Auto-create waste logs
  for (const product of expired) {
    await createWasteLog({
      product_firebase_id: product.firebase_id,
      product_name: product.name,
      quantity: product.inventory_b,
      reason: "Expired",
      waste_date: NOW()
    });

    // Clear inventory B
    await updateProduct(product.firebase_id, {
      inventory_b: 0,
      quantity: 0,
      expiration_date: null
    });
  }
}
```

---

## ✅ Code Changes Needed

### **1. Update Transfer Endpoint** (`nodejs-api/routes/products.js`)

```javascript
router.post('/transfer', async (req, res) => {
  try {
    const { firebaseId, quantity } = req.body;

    // Get current product
    const productResult = await query(
      'SELECT * FROM products WHERE firebase_id = $1',
      [firebaseId]
    );

    const product = productResult.rows[0];
    const currentInventoryA = parseFloat(product.inventory_a || 0);
    const currentInventoryB = parseFloat(product.inventory_b || 0);

    // Calculate new values
    const newInventoryA = currentInventoryA - quantity;
    const newInventoryB = currentInventoryB + quantity;

    // Calculate expiration date if perishable
    let expirationDate = product.expiration_date;
    if (product.is_perishable && product.shelf_life_days > 0) {
      const now = new Date();
      const expDate = new Date(now.getTime() + (product.shelf_life_days * 24 * 60 * 60 * 1000));
      expirationDate = expDate.toISOString();
    }

    // Update product
    await query(
      `UPDATE products
       SET inventory_a = $1,
           inventory_b = $2,
           quantity = $2,
           expiration_date = $3,
           transferred_to_b = TRUE,
           updated_at = NOW()
       WHERE firebase_id = $4`,
      [newInventoryA, newInventoryB, expirationDate, firebaseId]
    );

    res.json({
      success: true,
      message: `Transferred ${quantity} units. ${expirationDate ? `Expires: ${new Date(expirationDate).toLocaleDateString()}` : ''}`,
      newInventoryA,
      newInventoryB,
      expirationDate
    });
  } catch (error) {
    console.error('Error transferring inventory:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to transfer inventory',
      error: error.message
    });
  }
});
```

### **2. Create Scheduled Job** (`nodejs-api/jobs/check-expiration.js`)

```javascript
const cron = require('node-cron');
const { query } = require('../config/database');

// Run every day at midnight
cron.schedule('0 0 * * *', async () => {
  console.log('🕐 Running expiration check...');

  try {
    // Find expired ingredients
    const result = await query(`
      SELECT * FROM products
      WHERE is_perishable = TRUE
        AND expiration_date IS NOT NULL
        AND expiration_date <= NOW()
        AND inventory_b > 0
    `);

    console.log(`Found ${result.rowCount} expired items`);

    for (const product of result.rows) {
      // Create waste log
      await query(
        `INSERT INTO waste_logs
         (product_firebase_id, product_name, category, quantity, reason, waste_date, created_at)
         VALUES ($1, $2, $3, $4, $5, NOW(), NOW())`,
        [
          product.firebase_id,
          product.name,
          product.category,
          product.inventory_b,
          'Expired - Auto-recorded'
        ]
      );

      // Clear inventory B
      await query(
        `UPDATE products
         SET inventory_b = 0, quantity = 0, expiration_date = NULL
         WHERE firebase_id = $1`,
        [product.firebase_id]
      );

      console.log(`✅ Recorded ${product.name} as expired waste`);
    }
  } catch (error) {
    console.error('❌ Error checking expiration:', error);
  }
});
```

### **3. Add to server.js**

```javascript
// Import the cron job
require('./jobs/check-expiration');
```

---

## 📱 UI Changes Needed

### **Add Product Form**
```
✅ Is Perishable? [Checkbox]
✅ Shelf Life (days): [Number Input] - Only show if perishable
```

### **Transfer Modal**
```
Transfer 50 units to Inventory B
⚠️ This item has a 7-day shelf life
📅 Will expire on: 2024-01-08
[Confirm Transfer]
```

### **Inventory List**
```
Product Name | Inv A | Inv B | Expiration | Status
Milk         | 50    | 50    | Jan 8      | [Expires in 3 days]
Coffee       | 100   | 0     | -          | -
```

---

## 🧪 Testing Checklist

- [ ] Add ingredient with is_perishable=true, shelf_life_days=7
- [ ] Transfer from A to B
- [ ] Verify expiration_date is set
- [ ] Manually set expiration_date to yesterday
- [ ] Run cron job manually to test
- [ ] Verify waste log is created
- [ ] Verify inventory_b is cleared

---

## 📦 Dependencies Needed

```bash
npm install node-cron
```

---

## 🚀 Deployment Steps

1. Add migration for `transferred_to_b` column
2. Update transfer endpoint
3. Create cron job file
4. Test manually
5. Deploy to Railway
6. Monitor logs for cron execution
