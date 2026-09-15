-- 1. CASE revenue tiers
-- Tier every product based on total Delivered revenue

SELECT product_id,
       product_name,
       total_revenue,
       CASE
           WHEN total_revenue >= 3000 THEN 'High'
           WHEN total_revenue >= 1000 THEN 'Medium'
           ELSE 'Low'
       END AS revenue_tier
FROM (
    SELECT p.product_id,
           p.product_name,
           COALESCE(
               SUM(
                   CASE
                       WHEN o.status = 'Delivered'
                       THEN o.amount_inr
                       ELSE 0
                   END
               ), 0
           ) AS total_revenue
    FROM products p
    LEFT JOIN orders o
        ON p.product_id = o.product_id
    GROUP BY p.product_id, p.product_name
);

-- 2. Monthly category revenue
-- Delivered revenue by category and month

SELECT p.category AS category,
       strftime('%Y-%m', o.order_date) AS month,
       COUNT(*) AS order_count,
       SUM(o.amount_inr) AS total_revenue,
       AVG(o.amount_inr) AS avg_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category, strftime('%Y-%m', o.order_date)
ORDER BY p.category, month;

-- 3. Category target report
-- Compare Delivered revenue against category targets

WITH category_revenue AS (
    SELECT p.category,
           SUM(o.amount_inr) AS total_revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY p.category
)
SELECT cr.category,
       cr.total_revenue,
       t.target_revenue_inr,
       t.target_revenue_inr - cr.total_revenue AS variance,
       ((cr.total_revenue - t.target_revenue_inr) * 100.0)
           / t.target_revenue_inr AS percentage_variance,
       CASE
           WHEN cr.total_revenue >= t.target_revenue_inr
               THEN 'Above Target'
           WHEN ((cr.total_revenue - t.target_revenue_inr) * 100.0)
                    / t.target_revenue_inr >= -15
               THEN 'Below Target - Watch'
           ELSE 'Below Target - Critical'
       END AS target_status
FROM category_revenue cr
JOIN category_targets t
    ON cr.category = t.category;