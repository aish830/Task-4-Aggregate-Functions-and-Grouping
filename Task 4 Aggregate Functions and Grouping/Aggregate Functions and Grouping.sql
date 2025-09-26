-- Aggregate Functions & Grouping practice 

-- Safe cleanup (if re-running)
DROP TABLE IF EXISTS orders;
DROP 

-- Create a sample orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    quantity INT,
    price NUMERIC(12,2),   -- price for the whole order row (not per unit)
    order_date DATE DEFAULT CURRENT_DATE
);

select * from orders;

-- Insert sample data
INSERT INTO orders (customer_name, product, quantity, price, order_date) VALUES
('Radha',    'Laptop', 1, 55000.00, '2025-09-10'),
('Raj',      'Laptop', 2, 110000.00, '2025-09-11'),
('Dev',  'Mobile', 3, 45000.00, '2025-09-12'),
('Radha',    'Mobile', 1, 15000.00, '2025-09-13'),
('Darsh',    'Tablet', 2, 30000.00, '2025-09-14'),
('Raj',      'Tablet', 1, 15000.00, '2025-09-15'),
('Radha',    'Laptop', 1, 55000.00, '2025-09-16'),
('Gita',      'Mobile', 2, 30000.00, '2025-09-17');

-- ========== Simple aggregates ==========
-- 1. COUNT: number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- 2. SUM: total revenue (sum of price)
SELECT SUM(price) AS total_revenue FROM orders;

-- 3. AVG: average order price
SELECT AVG(price) AS avg_order_price FROM orders;

-- 4. MIN and MAX order price
SELECT MIN(price) AS lowest_order_price, MAX(price) AS highest_order_price FROM orders;

-- ========== Aggregates with grouping ==========
-- 5. Total sales per customer
SELECT customer_name, SUM(price) AS total_sales, COUNT(*) AS orders_count
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC;

-- 6. Total quantity and total revenue per product
SELECT product, SUM(quantity) AS total_quantity, SUM(price) AS total_revenue
FROM orders
GROUP BY product
ORDER BY total_revenue DESC;

-- 7. Average price per product (useful for per-order average)
SELECT product, AVG(price) AS avg_price, COUNT(*) AS orders_count
FROM orders
GROUP BY product
ORDER BY avg_price DESC;

-- ========== HAVING: filter groups ==========
-- 8. Customers with total sales more than 60,000
SELECT customer_name, SUM(price) AS total_sales
FROM orders
GROUP BY customer_name
HAVING SUM(price) > 60000
ORDER BY total_sales DESC;

-- 9. Products with total quantity greater than 2
SELECT product, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product
HAVING SUM(quantity) > 2;

-- ========== More useful patterns ==========
-- 10. Combine GROUP BY and date range (monthly totals)
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(price) AS month_revenue,
       COUNT(*) AS month_orders
FROM orders
GROUP BY month
ORDER BY month;

-- 11. Use COALESCE for safe display (if some aggregates could be NULL)
SELECT customer_name, COALESCE(SUM(price), 0) AS total_sales
FROM orders
GROUP BY customer_name;

-- 12. LIMIT results (top 3 customers by revenue)
SELECT customer_name, SUM(price) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 3;
