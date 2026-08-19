CREATE DATABASE IF NOT EXISTS retail_sales;
USE retail_sales;


-- =========================================================
-- 1. TABLE SETUP
-- =========================================================

CREATE TABLE IF NOT EXISTS superstore (
    row_id        INT,
    order_id      VARCHAR(20),
    order_date    DATE,
    ship_date     DATE,
    ship_mode     VARCHAR(50),
    customer_id   VARCHAR(20),
    customer_name VARCHAR(100),
    segment       VARCHAR(50),
    country       VARCHAR(50),
    city          VARCHAR(100),
    state         VARCHAR(100),
    postal_code   VARCHAR(20),
    region        VARCHAR(50),
    product_id    VARCHAR(20),
    category      VARCHAR(50),
    sub_category  VARCHAR(50),
    product_name  VARCHAR(255),
    sales         DECIMAL(10,4),
    quantity      INT,
    discount      DECIMAL(4,2),
    profit        DECIMAL(10,4)
);


-- =========================================================
-- 2. DATA LOAD
-- =========================================================

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'path/to/samplesuperstore.csv'
INTO TABLE superstore
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    row_id,
    order_id,
    @order_date,
    @ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
)
SET
    order_date = STR_TO_DATE(@order_date, '%m/%d/%Y'),
    ship_date  = STR_TO_DATE(@ship_date, '%m/%d/%Y');


-- =========================================================
-- 3. DATA CLEANING & VALIDATION
-- =========================================================

SET SQL_SAFE_UPDATES = 0;

UPDATE superstore
SET product_name = REPLACE(product_name, '"', '');

SET SQL_SAFE_UPDATES = 1;

SELECT row_id, COUNT(*) AS duplicate_count
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS total_rows
FROM superstore;

SELECT *
FROM superstore
LIMIT 5;

SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM superstore;

SELECT COUNT(*) AS bad_dates
FROM superstore
WHERE order_date IS NULL;

SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(discount) AS avg_discount
FROM superstore;


-- =========================================================
-- 4. BEGINNER ANALYSIS
-- =========================================================

-- Q1. Highest-value orders

SELECT
    order_id,
    customer_name,
    product_name,
    sales,
    profit
FROM superstore
WHERE sales > 1000
ORDER BY sales DESC
LIMIT 20;


-- Q2. Category performance

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(*) AS num_orders
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


-- Q3. Regional sales by category

SELECT
    region,
    category,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY region, category
ORDER BY region, total_sales DESC;


-- =========================================================
-- 5. INTERMEDIATE ANALYSIS
-- =========================================================

-- Q4. Orders above average order value

SELECT
    order_id,
    customer_name,
    sales
FROM superstore
WHERE sales > (
    SELECT AVG(sales)
    FROM superstore
)
ORDER BY sales DESC
LIMIT 20;


-- Q5. Order value classification

SELECT
    order_id,
    sales,
    CASE
        WHEN sales >= 1000 THEN 'High'
        WHEN sales >= 300 THEN 'Medium'
        ELSE 'Low'
    END AS value_tier
FROM superstore
LIMIT 50;


-- Q6. Monthly sales and profit

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY month
ORDER BY month;


-- Q7. Sales by value tier

SELECT
    CASE
        WHEN sales >= 1000 THEN 'High'
        WHEN sales >= 300 THEN 'Medium'
        ELSE 'Low'
    END AS value_tier,
    COUNT(*) AS num_orders,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY value_tier
ORDER BY total_sales DESC;


-- =========================================================
-- 6. ADVANCED ANALYSIS
-- =========================================================

-- Q8. Running total of monthly sales

SELECT
    month,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY month
    ) AS running_total
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY month
) AS monthly;


-- Q9. Most profitable products by category

SELECT
    category,
    product_name,
    total_profit,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_profit DESC
    ) AS profit_rank
FROM (
    SELECT
        category,
        product_name,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY category, product_name
) AS product_profits
ORDER BY category, profit_rank
LIMIT 30;


-- Q10. Month-over-month sales growth

SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY month
    ) AS prev_month_sales,
    ROUND(
        (
            total_sales -
            LAG(total_sales) OVER (ORDER BY month)
        )
        / LAG(total_sales) OVER (ORDER BY month) * 100,
        2
    ) AS mom_growth_pct
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY month
) AS monthly;


-- Q11. Customer RFM-style segmentation

WITH customer_stats AS (
    SELECT
        customer_id,
        customer_name,
        MAX(order_date) AS last_order_date,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM superstore
    GROUP BY customer_id, customer_name
)
SELECT
    customer_id,
    customer_name,
    DATEDIFF(
        (SELECT MAX(order_date) FROM superstore),
        last_order_date
    ) AS recency_days,
    frequency,
    monetary,
    CASE
        WHEN monetary > 5000 AND frequency > 10 THEN 'VIP'
        WHEN monetary > 2000 THEN 'Loyal'
        ELSE 'Regular'
    END AS segment
FROM customer_stats
ORDER BY monetary DESC
LIMIT 30;


-- =========================================================
-- 7. CUSTOMER SEGMENTATION VIEW
-- =========================================================

CREATE OR REPLACE VIEW customer_segments AS
WITH customer_stats AS (
    SELECT
        customer_id,
        customer_name,
        MAX(order_date) AS last_order_date,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM superstore
    GROUP BY customer_id, customer_name
)
SELECT
    customer_id,
    customer_name,
    DATEDIFF(
        (SELECT MAX(order_date) FROM superstore),
        last_order_date
    ) AS recency_days,
    frequency,
    monetary,
    CASE
        WHEN monetary > 5000 AND frequency > 10 THEN 'VIP'
        WHEN monetary > 2000 THEN 'Loyal'
        ELSE 'Regular'
    END AS segment
FROM customer_stats;


-- View example

SELECT *
FROM customer_segments
WHERE segment = 'VIP'
ORDER BY monetary DESC;


-- =========================================================
-- 8. FULL DATASET
-- =========================================================

SELECT *
FROM superstore
LIMIT 10194;