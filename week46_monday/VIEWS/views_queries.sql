-- Visa kundens totala orderbelopp och antal ordrar, med en vy som kan återanvändas för rapporter.
CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.company_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(od.unit_price * od.quantity), 2) AS total_amount
FROM customer AS c
JOIN customer_order AS o ON o.customer_id = c.customer_id
JOIN order_detail AS od ON od.order_id = o.order_id
GROUP BY c.customer_id, c.company_name;

-- Visa alla kunder med totalt orderbelopp över 5000
SELECT *
FROM customer_order_summary
WHERE total_amount > 5000
ORDER BY total_amount DESC;

-- Uppdatera vyn
CREATE OR REPLACE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.company_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.unit_price * od.quantity) AS total_amount,
    AVG(od.unit_price) AS avg_price
FROM customer AS c
JOIN customer_order AS o ON o.customer_id = c.customer_id
JOIN order_detail AS od ON od.order_id = o.order_id
GROUP BY c.customer_id, c.company_name;

-- Ta bort vyn
DROP VIEW customer_order_summary;