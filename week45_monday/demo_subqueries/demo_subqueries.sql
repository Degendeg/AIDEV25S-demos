-- Lista alla kunder som har lagt minst en order. Istället för att använda en `JOIN`, kan vi använda en subquery för att kontrollera vilka `customer_id` som finns i `order`-tabellen.
SELECT customer_id, company_name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM order);

-- Lista alla produkter vars pris är högre än genomsnittspriset för alla produkter.
SELECT product_name, unit_price
FROM product
WHERE unit_price > (SELECT AVG(unit_price) FROM product);

-- Lista beställningar som gjorts av kunder från "USA"
SELECT order_id, customer_id, order_date
FROM order
WHERE customer_id IN (SELECT customer_id FROM customer WHERE country = 'USA');

-- Lista anställda som har hanterat minst en order med ett ordervärde över $1,000.
SELECT employee_id, first_name, last_name
FROM employee
WHERE employee_id IN (SELECT employee_id FROM order WHERE freight > 1000);

-- Lista alla produkter som har beställts fler än 50 gånger i total kvantitet.
SELECT product_name
FROM product
WHERE product_id IN (SELECT product_id FROM order_detail GROUP BY product_id HAVING SUM(quantity) > 50);

-- Hämta alla kunder som har lagt minst en order
SELECT customer_id, company_name
FROM customer AS c
WHERE EXISTS (
    SELECT 1
    FROM `order` AS o
    WHERE o.customer_id = c.customer_id
);