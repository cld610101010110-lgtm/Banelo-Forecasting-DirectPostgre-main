/**
 * Expiration Checking Cron Job
 *
 * Runs daily at midnight to check for expired perishable items in Inventory B
 * Automatically creates waste logs and clears expired inventory
 */

const cron = require('node-cron');
const { query } = require('../config/database');

// Run every day at midnight (0 0 * * *)
// For testing, you can change to: '*/5 * * * *' (every 5 minutes)
cron.schedule('0 0 * * *', async () => {
  console.log('\n' + '='.repeat(60));
  console.log('🕐 Running expiration check...');
  console.log('='.repeat(60));
  console.log(`Timestamp: ${new Date().toISOString()}`);

  try {
    // Find all expired perishable items in Inventory B
    const result = await query(`
      SELECT * FROM products
      WHERE is_perishable = TRUE
        AND expiration_date IS NOT NULL
        AND expiration_date <= NOW()
        AND inventory_b > 0
      ORDER BY expiration_date ASC
    `);

    console.log(`\n📊 Found ${result.rowCount} expired item(s)`);

    if (result.rowCount === 0) {
      console.log('✅ No expired items found. All good!');
      console.log('='.repeat(60) + '\n');
      return;
    }

    // Process each expired item
    for (const product of result.rows) {
      const expiredDate = new Date(product.expiration_date).toLocaleDateString();
      const quantityWasted = parseFloat(product.inventory_b || 0);

      console.log(`\n⚠️  EXPIRED: ${product.name}`);
      console.log(`   - Expired on: ${expiredDate}`);
      console.log(`   - Quantity in Inventory B: ${quantityWasted} ${product.unit || 'units'}`);
      console.log(`   - Category: ${product.category}`);

      try {
        // Create waste log entry
        await query(
          `INSERT INTO waste_logs
           (product_firebase_id, product_name, category, quantity, reason, waste_date, created_at, recorded_by)
           VALUES ($1, $2, $3, $4, $5, NOW(), NOW(), $6)`,
          [
            product.firebase_id,
            product.name,
            product.category,
            quantityWasted,
            'Expired - Auto-recorded by system',
            'System'
          ]
        );

        console.log(`   ✅ Waste log created`);

        // Clear inventory B and reset expiration date
        await query(
          `UPDATE products
           SET inventory_b = 0,
               quantity = 0,
               expiration_date = NULL,
               transferred_to_b = FALSE,
               updated_at = NOW()
           WHERE firebase_id = $1`,
          [product.firebase_id]
        );

        console.log(`   ✅ Inventory B cleared`);
        console.log(`   ✅ ${product.name} processed successfully`);

      } catch (error) {
        console.error(`   ❌ Error processing ${product.name}:`, error.message);
      }
    }

    console.log(`\n✅ Expiration check completed`);
    console.log(`   - Total expired items: ${result.rowCount}`);
    console.log(`   - All expired items have been logged as waste`);
    console.log('='.repeat(60) + '\n');

  } catch (error) {
    console.error('\n❌ Error during expiration check:');
    console.error(error);
    console.error('='.repeat(60) + '\n');
  }
});

console.log('✅ Expiration check cron job initialized (runs daily at midnight)');

module.exports = {};
