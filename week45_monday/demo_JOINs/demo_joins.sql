/*
	NOTIS: DENNA GÅR MOT northwind DATABASEN
*/

-- 1. INNER JOIN – Visa alla ordrar tillsammans med kundens namn och land.
-- Kopplar ihop tabellerna `order` och `customer` via customer_id.
-- Resultatet visar varje order med information om vilken kund som gjort den.
SELECT 
    o.order_id,
    c.company_name AS customer_name,
    c.country AS customer_country,
    o.order_date,
    o.ship_city,
    o.ship_country
FROM `order` o
INNER JOIN customer c ON o.customer_id = c.customer_id
ORDER BY c.country, o.order_date;

-- 2. INNER JOIN – Visa ordrar, kunder och anställda i samma fråga.
-- Hämtar data från tre tabeller för att visa vilken anställd hanterade vilken kunds order.
SELECT 
    o.order_id,
    c.company_name AS customer_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    o.order_date
FROM `order` o
INNER JOIN customer c ON o.customer_id = c.customer_id
INNER JOIN employee e ON o.employee_id = e.employee_id
ORDER BY o.order_date DESC;

-- 3. INNER JOIN – Visa produkter med tillhörande kategori.
-- Varje produkt är kopplad till en kategori via category_id.
-- Resultatet visar endast produkter som har en matchande kategori.
SELECT 
    p.product_name,
    c.category_name
FROM product p
INNER JOIN category c ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

-- 4. LEFT JOIN – Visa alla produkter, även de utan kategori.
-- Om en produkt saknar kategori kommer category_name att vara NULL.
-- (I standarddatan finns alltid kategori, men du kan testa genom att sätta en kategori till NULL.)
SELECT 
    p.product_name,
    c.category_name
FROM product p
LEFT JOIN category c ON p.category_id = c.category_id
ORDER BY c.category_name;

-- 5. RIGHT JOIN – Visa alla kategorier, även de som inte har några produkter.
-- Visar t.ex. en kategori som inte ännu har några produkter kopplade till sig.
SELECT 
    p.product_name,
    c.category_name
FROM product p
RIGHT JOIN category c ON p.category_id = c.category_id
ORDER BY c.category_name;

-- 6. INNER JOIN – Visa orderdetaljer och produkter med totalbelopp.
-- Beräknar totalpris per orderrad (unit_price * quantity).
-- Varje rad representerar en produkt i en specifik order.
SELECT 
    od.order_id,
    p.product_name,
    od.unit_price,
    od.quantity,
    (od.unit_price * od.quantity) AS total_price
FROM order_detail od
INNER JOIN product p ON od.product_id = p.product_id
ORDER BY od.order_id;

-- 7. LEFT JOIN + GROUP BY – Visa antal ordrar per anställd.
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(o.order_id) AS orders_handled
FROM employee e
JOIN `order` o ON e.employee_id = o.employee_id
GROUP BY e.employee_id
ORDER BY orders_handled DESC;

-- 8. Kombinerad JOIN – Visa ordrar med kund och produktinformation.
-- Hämtar data från fyra tabeller för att visa vem som beställde vad och i vilken mängd.
SELECT 
    o.order_id,
    c.company_name AS customer_name,
    p.product_name,
    od.quantity
FROM `order` o
INNER JOIN customer c ON o.customer_id = c.customer_id
INNER JOIN order_detail od ON o.order_id = od.order_id
INNER JOIN product p ON od.product_id = p.product_id
ORDER BY o.order_id, p.product_name;

-- Hämta alla ordrar med kundens namn och den anställde som hanterade ordern
SELECT 
    o.order_id,
    c.company_name AS customer,
    e.first_name AS employee_firstname,
    e.last_name AS employee_lastname,
    o.order_date
FROM `order` AS o
JOIN customer AS c ON o.customer_id = c.customer_id
JOIN employee AS e ON o.employee_id = e.employee_id;

-- Den hämtar orderinformation (order), kopplar ihop den med kunden (customer) och anställd (employee) som registrerat ordern — alltså tre tabeller i en naturlig relation.
