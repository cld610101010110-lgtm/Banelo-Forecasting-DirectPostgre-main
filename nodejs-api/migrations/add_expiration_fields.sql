-- Migration: Add expiration tracking fields to products table
-- Date: 2026-01-04
-- Description: Adds is_perishable, shelf_life_days, expiration_date, and is_active fields

-- Add new columns to products table (if they don't exist)
ALTER TABLE products
ADD COLUMN IF NOT EXISTS description TEXT DEFAULT '',
ADD COLUMN IF NOT EXISTS sku VARCHAR(100) DEFAULT '',
ADD COLUMN IF NOT EXISTS is_perishable BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS shelf_life_days INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS expiration_date TIMESTAMP,
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;

-- Create an index on expiration_date for faster queries
CREATE INDEX IF NOT EXISTS idx_products_expiration_date ON products(expiration_date);

-- Create an index on is_active for faster queries
CREATE INDEX IF NOT EXISTS idx_products_is_active ON products(is_active);

-- Update existing products to set is_active = TRUE
UPDATE products SET is_active = TRUE WHERE is_active IS NULL;

COMMENT ON COLUMN products.is_perishable IS 'Indicates if the product has an expiration date';
COMMENT ON COLUMN products.shelf_life_days IS 'Number of days the product is good for after receiving';
COMMENT ON COLUMN products.expiration_date IS 'The date when the product expires';
COMMENT ON COLUMN products.is_active IS 'Indicates if the product is active in the system';
