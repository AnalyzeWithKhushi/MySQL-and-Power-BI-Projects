-- Create Database
CREATE DATABASE global_retail_sales_db;

-- Select Data from Table
SELECT * FROM global_retail_sales;

-- Describe Table Structure
DESCRIBE global_retail_sales;

-- Update Order Date Format
UPDATE global_retail_sales
SET `Order Date` = STR_TO_DATE(`Order Date`, '%d-%m-%Y');

-- Modify Order Date Column Type
ALTER TABLE global_retail_sales
MODIFY COLUMN `Order Date` DATE;

-- Sales Performance Analysis
-- Total Sales by Year
SELECT SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY YEAR(`Order Date`);

-- Total Sales by Month
SELECT SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY MONTH(`Order Date`);

-- Total Sales for February
SELECT SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
WHERE MONTH(`Order Date`) = 2; -- February

-- Average Sales Price
SELECT AVG(`Sales Price`) AS average_sales_price
FROM global_retail_sales;

-- Total Quantity Sold
SELECT SUM(`Quantity`) AS total_quantity_sold
FROM global_retail_sales;

-- Sales per Unit
SELECT AVG(`Sales per Unit`) AS average_sales_per_unit
FROM global_retail_sales;

-- Monthly Sales Difference
SELECT 
  MONTH(`Order Date`) AS month, 
  SUM(`Total Sales`) AS total_sales, 
  LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`)) AS previous_month_sales,
  (SUM(`Total Sales`) - LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`))) AS sales_difference
FROM global_retail_sales
GROUP BY MONTH(`Order Date`);

-- Sales Trend by Month
SELECT 
  MONTH(`Order Date`) AS month, 
  SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY MONTH(`Order Date`) 
ORDER BY MONTH(`Order Date`);

-- Quarterly Sales Analysis
SELECT 
  QUARTER(`Order Date`) AS quarter, 
  SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY QUARTER(`Order Date`);

-- Monthly Sales Growth Rate
SELECT 
  MONTH(`Order Date`) AS month, 
  SUM(`Total Sales`) AS total_sales, 
  (SUM(`Total Sales`) - LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`))) / LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`)) * 100 AS sales_growth_rate
FROM global_retail_sales
GROUP BY MONTH(`Order Date`);

-- Sales Comparison by Year and Month
SELECT 
  YEAR(`Order Date`) AS year, 
  MONTH(`Order Date`) AS month, 
  SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`) 
ORDER BY YEAR(`Order Date`), MONTH(`Order Date`);

-- Customer Demographics Analysis
-- Sales by Gender
SELECT `Buyer Gender`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Buyer Gender`;

-- Sales by Age Group
SELECT `Buyer Age`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Buyer Age`;

-- Sales by Location
SELECT `Order Location`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Order Location`;

-- Product Performance Analysis
-- Sales by Product Category
SELECT `Product Category`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Product Category`;

-- Sales by Product ID
SELECT `Product ID`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Product ID`;

-- Shipping Metrics Analysis
-- International vs. Domestic Sales
SELECT `International Shipping`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `International Shipping`;

-- Total Shipping Charges
SELECT SUM(`Shipping Charges`) AS total_shipping_charges
FROM global_retail_sales;

-- Order and Rating Analysis
-- Order Count
SELECT COUNT(`Order ID`) AS order_count
FROM global_retail_sales;

-- Average Rating
SELECT AVG(`Rating`) AS average_rating
FROM global_retail_sales;

-- Review Analysis
SELECT 
  `Product ID`, 
  COUNT(`Review`) AS total_reviews, 
  AVG(`Rating`) AS average_rating 
FROM global_retail_sales 
GROUP BY `Product ID`;

-- Additional Metrics Analysis
-- Sales Over Time
SELECT 
  MONTH(`Order Date`) AS month, 
  SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY MONTH(`Order Date`);

-- Order Date Analysis
SELECT 
  `Order Date`, 
  COUNT(`Order ID`) AS order_count 
FROM global_retail_sales 
GROUP BY `Order Date`;

