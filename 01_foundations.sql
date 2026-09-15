-- 1. SELECT + WHERE
-- Show orders placed by customers from Bengaluru

SELECT o.order_id,
       o.order_date,
       o.amount_inr,
       c.name,
       c.city
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.city = 'Bengaluru';

-- 2. DISTINCT
-- Show all unique product categories

SELECT DISTINCT category
FROM products;

-- 3. ORDER BY + LIMIT
-- Show the 5 highest-value orders

SELECT order_id,
       order_date,
       amount_inr
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;

-- 4. Alias using AS
-- Count all orders and rename the output column

SELECT COUNT(*) AS total_orders
FROM orders;

-- 5. IN
-- Show orders paid using UPI or Wallet

SELECT order_id,
       payment_mode,
       amount_inr
FROM orders
WHERE payment_mode IN ('UPI', 'Wallet');

-- 6. BETWEEN
-- Show orders with amount between ₹100 and ₹500

SELECT order_id,
       amount_inr
FROM orders
WHERE amount_inr BETWEEN 100 AND 500;

-- 7. NOT BETWEEN
-- Show orders with amount outside the ₹100 to ₹500 range

SELECT order_id,
       amount_inr
FROM orders
WHERE amount_inr NOT BETWEEN 100 AND 500;

-- 8. IS NULL
-- Show orders where the rating is missing

SELECT order_id,
       rating
FROM orders
WHERE rating IS NULL;