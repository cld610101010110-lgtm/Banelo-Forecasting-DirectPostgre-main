/**
 * Waste Logs API Routes
 */

const express = require('express');
const router = express.Router();
const { query, pool } = require('../config/database');
const { createObjectCsvStringifier } = require('csv-writer');
const PDFDocument = require('pdfkit');

// ============================================
// GET /api/waste-logs - Get all waste logs
// ============================================
router.get('/', async (req, res) => {
  try {
    const { date_from, date_to } = req.query;

    let queryText = 'SELECT * FROM waste_logs WHERE 1=1';
    const values = [];
    let paramCount = 1;

    if (date_from) {
      queryText += ` AND waste_date >= $${paramCount++}`;
      values.push(date_from);
    }

    if (date_to) {
      const toDate = new Date(date_to);
      toDate.setDate(toDate.getDate() + 1);
      queryText += ` AND waste_date < $${paramCount++}`;
      values.push(toDate.toISOString());
    }

    queryText += ' ORDER BY waste_date DESC';

    const result = await query(queryText, values);

    res.json({
      success: true,
      data: result.rows,
      count: result.rowCount
    });
  } catch (error) {
    console.error('Error fetching waste logs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch waste logs',
      error: error.message
    });
  }
});

// ============================================
// POST /api/waste - Add waste log
// ============================================
router.post('/', async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      productFirebaseId,
      productName,
      category,
      quantity,
      reason,
      recordedBy
    } = req.body;

    // Validate inputs
    if (!productFirebaseId || !quantity) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: productFirebaseId and quantity'
      });
    }

    if (quantity <= 0) {
      return res.status(400).json({
        success: false,
        message: 'Quantity must be greater than 0'
      });
    }

    await client.query('BEGIN');

    // Get current product
    const productResult = await client.query(
      'SELECT * FROM products WHERE id = $1',
      [productFirebaseId]
    );

    if (productResult.rowCount === 0) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }

    const product = productResult.rows[0];
    const currentInventoryB = parseFloat(product.inventory_b || 0);

    // Check if enough stock in B
    if (currentInventoryB < quantity) {
      return res.status(400).json({
        success: false,
        message: `Insufficient stock in Inventory B. Available: ${currentInventoryB}, Requested: ${quantity}`
      });
    }

    // Create waste log
    await client.query(
      `INSERT INTO waste_logs
       (product_firebase_id, product_name, category, quantity, reason, recorded_by, waste_date, created_at)
       VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW())`,
      [productFirebaseId, productName, category, quantity, reason, recordedBy || 'system']
    );

    // Update inventory_b
    const newInventoryB = currentInventoryB - quantity;
    await client.query(
      `UPDATE products
       SET inventory_b = $1, quantity = $1, updated_at = NOW()
       WHERE id = $2`,
      [newInventoryB, productFirebaseId]
    );

    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: `Successfully recorded ${quantity} units of ${productName} as waste`,
      newInventoryB: newInventoryB
    });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error adding waste log:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to add waste log',
      error: error.message
    });
  } finally {
    client.release();
  }
});

// ============================================
// GET /api/waste/export/csv - Export waste logs as CSV
// ============================================
router.get('/export/csv', async (req, res) => {
  try {
    const { date_from, date_to } = req.query;

    let queryText = 'SELECT * FROM waste_logs WHERE 1=1';
    const values = [];
    let paramCount = 1;

    if (date_from) {
      queryText += ` AND waste_date >= $${paramCount++}`;
      values.push(date_from);
    }

    if (date_to) {
      const toDate = new Date(date_to);
      toDate.setDate(toDate.getDate() + 1);
      queryText += ` AND waste_date < $${paramCount++}`;
      values.push(toDate.toISOString());
    }

    queryText += ' ORDER BY waste_date DESC';

    const result = await query(queryText, values);

    // Create CSV
    const csvStringifier = createObjectCsvStringifier({
      header: [
        { id: 'id', title: 'ID' },
        { id: 'product_name', title: 'Product Name' },
        { id: 'category', title: 'Category' },
        { id: 'quantity', title: 'Quantity' },
        { id: 'reason', title: 'Reason' },
        { id: 'recorded_by', title: 'Recorded By' },
        { id: 'waste_date', title: 'Waste Date' }
      ]
    });

    const csvHeader = csvStringifier.getHeaderString();
    const csvBody = csvStringifier.stringifyRecords(result.rows);

    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', `attachment; filename=waste-report-${new Date().toISOString().split('T')[0]}.csv`);
    res.send(csvHeader + csvBody);
  } catch (error) {
    console.error('Error exporting waste logs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to export waste logs',
      error: error.message
    });
  }
});

// ============================================
// GET /api/waste/export/pdf - Export waste logs as PDF
// ============================================
router.get('/export/pdf', async (req, res) => {
  try {
    const { date_from, date_to } = req.query;

    let queryText = 'SELECT * FROM waste_logs WHERE 1=1';
    const values = [];
    let paramCount = 1;

    if (date_from) {
      queryText += ` AND waste_date >= $${paramCount++}`;
      values.push(date_from);
    }

    if (date_to) {
      const toDate = new Date(date_to);
      toDate.setDate(toDate.getDate() + 1);
      queryText += ` AND waste_date < $${paramCount++}`;
      values.push(toDate.toISOString());
    }

    queryText += ' ORDER BY waste_date DESC';

    const result = await query(queryText, values);

    // Create PDF
    const doc = new PDFDocument({ margin: 50 });

    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', `attachment; filename=waste-report-${new Date().toISOString().split('T')[0]}.pdf`);

    doc.pipe(res);

    // Title
    doc.fontSize(20).text('Waste Report', { align: 'center' });
    doc.moveDown();
    doc.fontSize(10).text(`Generated: ${new Date().toLocaleString()}`, { align: 'center' });
    doc.moveDown();

    // Summary
    const totalQuantity = result.rows.reduce((sum, row) => sum + parseFloat(row.quantity || 0), 0);
    doc.fontSize(12).text(`Total Waste Entries: ${result.rows.length}`);
    doc.text(`Total Quantity Wasted: ${totalQuantity.toFixed(2)}`);
    doc.moveDown();

    // Table Header
    doc.fontSize(10).font('Helvetica-Bold');
    const tableTop = doc.y;
    doc.text('Date', 50, tableTop);
    doc.text('Product', 120, tableTop);
    doc.text('Category', 240, tableTop);
    doc.text('Qty', 340, tableTop);
    doc.text('Reason', 390, tableTop);

    doc.moveDown();
    doc.font('Helvetica');

    // Table Rows
    result.rows.forEach((row, i) => {
      const y = doc.y;

      if (y > 700) {
        doc.addPage();
        doc.fontSize(10).font('Helvetica-Bold');
        doc.text('Date', 50, 50);
        doc.text('Product', 120, 50);
        doc.text('Category', 240, 50);
        doc.text('Qty', 340, 50);
        doc.text('Reason', 390, 50);
        doc.moveDown();
        doc.font('Helvetica');
      }

      const currentY = doc.y;
      const date = new Date(row.waste_date).toLocaleDateString();

      doc.text(date, 50, currentY, { width: 65 });
      doc.text(row.product_name || '-', 120, currentY, { width: 115 });
      doc.text(row.category || '-', 240, currentY, { width: 95 });
      doc.text(row.quantity || '0', 340, currentY, { width: 45 });
      doc.text(row.reason || '-', 390, currentY, { width: 150 });

      doc.moveDown(0.5);
    });

    doc.end();
  } catch (error) {
    console.error('Error exporting waste logs PDF:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to export waste logs PDF',
      error: error.message
    });
  }
});

module.exports = router;
