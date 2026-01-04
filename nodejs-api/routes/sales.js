/**
 * Sales API Routes
 */

const express = require('express');
const router = express.Router();
const { query } = require('../config/database');
const { createObjectCsvStringifier } = require('csv-writer');
const PDFDocument = require('pdfkit');

// ============================================
// GET /api/sales - Get all sales
// ============================================
router.get('/', async (req, res) => {
  try {
    const { limit, date_from, date_to } = req.query;

    let queryText = 'SELECT * FROM sales WHERE 1=1';
    const values = [];
    let paramCount = 1;

    if (date_from) {
      queryText += ` AND order_date >= $${paramCount++}`;
      values.push(date_from);
    }

    if (date_to) {
      queryText += ` AND order_date <= $${paramCount++}`;
      values.push(date_to);
    }

    queryText += ' ORDER BY order_date DESC';

    if (limit) {
      queryText += ` LIMIT $${paramCount++}`;
      values.push(parseInt(limit));
    }

    const result = await query(queryText, values);

    res.json({
      success: true,
      data: result.rows,
      count: result.rowCount
    });
  } catch (error) {
    console.error('Error fetching sales:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch sales',
      error: error.message
    });
  }
});

// ============================================
// GET /api/sales/summary - Get sales summary
// ============================================
router.get('/summary', async (req, res) => {
  try {
    const { period } = req.query;

    let dateFilter = '';
    switch (period) {
      case 'today':
        dateFilter = "AND DATE(order_date) = CURRENT_DATE";
        break;
      case 'week':
        dateFilter = "AND order_date >= CURRENT_DATE - INTERVAL '7 days'";
        break;
      case 'month':
        dateFilter = "AND order_date >= CURRENT_DATE - INTERVAL '30 days'";
        break;
      default:
        dateFilter = '';
    }

    const summaryQuery = `
      SELECT
        COUNT(*) as total_orders,
        SUM(total) as total_revenue,
        SUM(quantity) as total_items_sold,
        AVG(total) as average_order_value
      FROM sales
      WHERE 1=1 ${dateFilter}
    `;

    const result = await query(summaryQuery);

    res.json({
      success: true,
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Error fetching sales summary:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch sales summary',
      error: error.message
    });
  }
});

// ============================================
// GET /api/sales/export/csv - Export sales as CSV
// ============================================
router.get('/export/csv', async (req, res) => {
  try {
    const { date_from, date_to } = req.query;

    let queryText = 'SELECT * FROM sales WHERE 1=1';
    const values = [];
    let paramCount = 1;

    if (date_from) {
      queryText += ` AND order_date >= $${paramCount++}`;
      values.push(date_from);
    }

    if (date_to) {
      queryText += ` AND order_date <= $${paramCount++}`;
      values.push(date_to);
    }

    queryText += ' ORDER BY order_date DESC';

    const result = await query(queryText, values);

    // Create CSV
    const csvStringifier = createObjectCsvStringifier({
      header: [
        { id: 'id', title: 'ID' },
        { id: 'order_date', title: 'Order Date' },
        { id: 'product_name', title: 'Product Name' },
        { id: 'category', title: 'Category' },
        { id: 'quantity', title: 'Quantity' },
        { id: 'price', title: 'Unit Price' },
        { id: 'total', title: 'Total' },
        { id: 'payment_method', title: 'Payment Method' }
      ]
    });

    const csvHeader = csvStringifier.getHeaderString();
    const csvBody = csvStringifier.stringifyRecords(result.rows);

    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', `attachment; filename=sales-report-${new Date().toISOString().split('T')[0]}.csv`);
    res.send(csvHeader + csvBody);
  } catch (error) {
    console.error('Error exporting sales:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to export sales',
      error: error.message
    });
  }
});

// ============================================
// GET /api/sales/export/pdf - Export sales as PDF
// ============================================
router.get('/export/pdf', async (req, res) => {
  try {
    const { date_from, date_to } = req.query;

    let queryText = 'SELECT * FROM sales WHERE 1=1';
    const values = [];
    let paramCount = 1;

    if (date_from) {
      queryText += ` AND order_date >= $${paramCount++}`;
      values.push(date_from);
    }

    if (date_to) {
      queryText += ` AND order_date <= $${paramCount++}`;
      values.push(date_to);
    }

    queryText += ' ORDER BY order_date DESC';

    const result = await query(queryText, values);

    // Create PDF
    const doc = new PDFDocument({ margin: 50 });

    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', `attachment; filename=sales-report-${new Date().toISOString().split('T')[0]}.pdf`);

    doc.pipe(res);

    // Title
    doc.fontSize(20).text('Sales Report', { align: 'center' });
    doc.moveDown();
    doc.fontSize(10).text(`Generated: ${new Date().toLocaleString()}`, { align: 'center' });
    doc.moveDown();

    // Summary
    const totalRevenue = result.rows.reduce((sum, row) => sum + parseFloat(row.total || 0), 0);
    const totalItems = result.rows.reduce((sum, row) => sum + parseFloat(row.quantity || 0), 0);
    doc.fontSize(12).text(`Total Sales: ${result.rows.length}`);
    doc.text(`Total Items Sold: ${totalItems.toFixed(2)}`);
    doc.text(`Total Revenue: ₱${totalRevenue.toFixed(2)}`);
    doc.moveDown();

    // Table Header
    doc.fontSize(9).font('Helvetica-Bold');
    const tableTop = doc.y;
    doc.text('Date', 50, tableTop);
    doc.text('Product', 110, tableTop);
    doc.text('Category', 220, tableTop);
    doc.text('Qty', 300, tableTop);
    doc.text('Price', 340, tableTop);
    doc.text('Total', 400, tableTop);
    doc.text('Payment', 460, tableTop);

    doc.moveDown();
    doc.font('Helvetica');

    // Table Rows
    result.rows.forEach((row, i) => {
      const y = doc.y;

      if (y > 700) {
        doc.addPage();
        doc.fontSize(9).font('Helvetica-Bold');
        doc.text('Date', 50, 50);
        doc.text('Product', 110, 50);
        doc.text('Category', 220, 50);
        doc.text('Qty', 300, 50);
        doc.text('Price', 340, 50);
        doc.text('Total', 400, 50);
        doc.text('Payment', 460, 50);
        doc.moveDown();
        doc.font('Helvetica');
      }

      const currentY = doc.y;
      const date = new Date(row.order_date).toLocaleDateString();

      doc.text(date, 50, currentY, { width: 55 });
      doc.text(row.product_name || '-', 110, currentY, { width: 105 });
      doc.text(row.category || '-', 220, currentY, { width: 75 });
      doc.text(row.quantity || '0', 300, currentY, { width: 35 });
      doc.text(`₱${parseFloat(row.price || 0).toFixed(2)}`, 340, currentY, { width: 55 });
      doc.text(`₱${parseFloat(row.total || 0).toFixed(2)}`, 400, currentY, { width: 55 });
      doc.text(row.payment_method || '-', 460, currentY, { width: 80 });

      doc.moveDown(0.5);
    });

    doc.end();
  } catch (error) {
    console.error('Error exporting sales PDF:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to export sales PDF',
      error: error.message
    });
  }
});

module.exports = router;
