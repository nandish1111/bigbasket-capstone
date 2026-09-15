-- 1. INNER JOIN + GROUP BY + HAVING
-- Delivered revenue by category, showing only categories above ₹10,000

SELECT p.category,
       COUNT(*) AS order_count,
       SUM(o.amount_inr) AS total_revenue,
       AVG(o.amount_inr) AS avg_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
HAVING total_revenue > 10000;

-- 2. LEFT JOIN
-- Count orders for every product, including products with zero orders

SELECT p.product_id,
       p.product_name,
       COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_orders ASC, p.product_id;