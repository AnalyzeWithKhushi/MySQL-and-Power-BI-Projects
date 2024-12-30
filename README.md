# MySQL-and-Power-BI-Projects
## Summary of Report- In this project, we integrated MySQL for data management and Power BI for data visualization to create an interactive dashboard that provides insightful analysis of retail sales data stored in the global_retail_sales_db database. We prepared the data by converting date formats and conducted various analyses, including sales performance, customer demographics, product performance, shipping metrics, and order and rating analysis. These insights were visualized in Power BI using various chart types, facilitating data-driven decision-making and delivering valuable business insights.

## 1. Database Creation and Setup
•	Create Database
Purpose: This step initializes the database where all the sales data will be stored.
CREATE DATABASE global_retail_sales_db;

•	Select Data from Table
Purpose: This query retrieves all data from the global_retail_sales table for examination and analysis.
SELECT * FROM global_retail_sales;

•	Describe Table Structure
Purpose: This query provides the structure of the global_retail_sales table, detailing column names and data types.
DESCRIBE global_retail_sales;

•	Update Order Date Format
Purpose: This query converts the Order Date column format from string to date for more accurate date-related operations.
UPDATE global_retail_sales
SET `Order Date` = STR_TO_DATE(`Order Date`, '%d-%m-%Y');

•	Modify Order Date Column Type
Purpose: This alters the data type of the Order Date column to DATE after converting its format.
ALTER TABLE global_retail_sales
MODIFY COLUMN `Order Date` DATE;

## 2. Sales Performance Analysis
•	Total Sales by Year
Purpose: This query calculates the total sales for each year to analyze yearly sales performance.
SELECT SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY YEAR(`Order Date`);

•	Total Sales by Month
Purpose: This query calculates the total sales for each month to observe monthly sales trends.
SELECT SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY MONTH(`Order Date`);

•	Total Sales for February
Purpose: This query filters the sales data to show total sales for the month of February.
SELECT SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
WHERE MONTH(`Order Date`) = 2; -- February

•	Average Sales Price
Purpose: This query calculates the average sales price of all products, providing insight into pricing trends.
SELECT AVG(`Sales Price`) AS average_sales_price
FROM global_retail_sales;

•	Total Quantity Sold
Purpose: This query calculates the total quantity of products sold to measure sales volume.
SELECT SUM(`Quantity`) AS total_quantity_sold
FROM global_retail_sales;

•	Sales per Unit
Purpose: This query calculates the average sales per unit, which helps in understanding the revenue generated per product.
SELECT AVG(`Sales per Unit`) AS average_sales_per_unit
FROM global_retail_sales;

•	Monthly Sales Difference
Purpose: This query calculates the sales difference between consecutive months to identify growth or decline patterns.
SELECT 
MONTH(`Order Date`) AS month, 
SUM(`Total Sales`) AS total_sales, 
LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`)) AS previous_month_sales,
(SUM(`Total Sales`) - LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`))) AS sales_difference
FROM global_retail_sales
GROUP BY MONTH(`Order Date`);

•	Sales Trend by Month
Purpose: This query calculates and orders the total sales by month to analyze the sales trend.
SELECT 
MONTH(`Order Date`) AS month, 
SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY MONTH(`Order Date`) 
ORDER BY MONTH(`Order Date`);

•	Quarterly Sales Analysis
Purpose: This query calculates the total sales for each quarter to observe quarterly sales performance.
SELECT 
QUARTER(`Order Date`) AS quarter, 
SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY QUARTER(`Order Date`);

•	Monthly Sales Growth Rate
Purpose: This query calculates the monthly growth rate to assess the percentage change in sales month-over-month.
SELECT 
MONTH(`Order Date`) AS month, 
SUM(`Total Sales`) AS total_sales, 
(SUM(`Total Sales`) - LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`))) / LAG(SUM(`Total Sales`), 1) OVER (ORDER BY MONTH(`Order Date`)) * 100 AS sales_growth_rate
FROM global_retail_sales
GROUP BY MONTH(`Order Date`);

•	Sales Comparison by Year and Month
Purpose: This query compares total sales for each month across different years to identify yearly trends.
SELECT 
YEAR(`Order Date`) AS year, 
MONTH(`Order Date`) AS month, 
SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`) 
ORDER BY YEAR(`Order Date`), MONTH(`Order Date`);

## 3. Customer Demographics Analysis
•	Sales by Gender
Purpose: This query calculates total sales grouped by buyer gender to understand gender-based sales performance.
SELECT `Buyer Gender`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Buyer Gender`;

•	Sales by Age Group
Purpose: This query calculates total sales grouped by buyer age to analyze age-based sales distribution.
SELECT `Buyer Age`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Buyer Age`;

•	Sales by Location
Purpose: This query calculates total sales grouped by order location to understand geographic sales distribution.
SELECT `Order Location`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Order Location`;

## 4. Product Performance Analysis
•	Sales by Product Category
Purpose: This query calculates total sales grouped by product category to identify top-performing categories.
SELECT `Product Category`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Product Category`;

•	Sales by Product ID
Purpose: This query calculates total sales grouped by product ID to determine best-selling products.
SELECT `Product ID`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `Product ID`;

## 5. Shipping Metrics Analysis
•	International vs. Domestic Sales
Purpose: This query calculates total sales grouped by shipping type (international vs. domestic) to compare market performance.
SELECT `International Shipping`, SUM(`Total Sales`) AS total_sales
FROM global_retail_sales
GROUP BY `International Shipping`;

•	Total Shipping Charges
Purpose: This query calculates total shipping charges to evaluate the overall shipping cost.
SELECT SUM(`Shipping Charges`) AS total_shipping_charges
FROM global_retail_sales;

## 6. Order and Rating Analysis
•	Order Count
Purpose: This query counts the total number of orders to measure sales volume.
SELECT COUNT(`Order ID`) AS order_count
FROM global_retail_sales;

•	Average Rating
Purpose: This query calculates the average rating of products to gauge customer satisfaction.
SELECT AVG(`Rating`) AS average_rating
FROM global_retail_sales;

•	Review Analysis
Purpose: This query analyzes the count of reviews and average rating per product to assess product performance and feedback.
SELECT 
`Product ID`, 
COUNT(`Review`) AS total_reviews, 
AVG(`Rating`) AS average_rating 
FROM global_retail_sales 
GROUP BY `Product ID`;

## 7. Additional Metrics Analysis
•	Sales Over Time
Purpose: This query calculates total sales grouped by month to analyze sales trends over time.
SELECT 
MONTH(`Order Date`) AS month, 
SUM(`Total Sales`) AS total_sales 
FROM global_retail_sales 
GROUP BY MONTH(`Order Date`);

•	Order Date Analysis
Purpose: This query counts the total number of orders grouped by order date to understand daily sales distribution.
SELECT 
`Order Date`, 
COUNT(`Order ID`) AS order_count 
FROM global_retail_sales 
GROUP BY `Order Date`;
