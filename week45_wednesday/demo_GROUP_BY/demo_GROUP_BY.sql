-- 1. Antal ordrar per kund
SELECT customer_id, COUNT(*) AS order_count
FROM `order`
GROUP BY customer_id;
-- ORDER BY order_count DESC;

Utan GROUP BY vet databasen inte hur den ska räkna COUNT(*) per kund — den kan bara räkna totalt. GROUP BY säger "gruppera raderna per kund_id innan du räknar".

-- 2. Total försäljning per anställd
SELECT employee_id, SUM(freight) AS total_freight
FROM `order`
GROUP BY employee_id;

-- 3. Antal produkter per kategori
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id;

-- 4. Genomsnittligt pris per leverantör
SELECT supplier_id, AVG(unit_price) AS avg_price
FROM products
GROUP BY supplier_id;

-- 5. Total intäkt per kund (order_details + `order`)
SELECT o.customer_id, SUM(od.unit_price * od.quantity) AS total_sales
FROM order_details od
JOIN `order` o ON od.order_id = o.order_id
GROUP BY o.customer_id;

/*
  ----------------------------------------------------------------
*/

-- Totalt orderbelopp för varje kund
-- För att visa totalvärdet på alla ordrar per kund, kan vi använda GROUP BY för att gruppera datan på kundnivå och sedan använda SUM-funktionen på kolumnen unit_price * quantity från order_detail.

SELECT
  c.company_name AS customer_name,
  SUM(od.unit_price * od.quantity) AS total_order_amount
FROM customer AS c
JOIN `order` AS o ON c.customer_id = o.customer_id
JOIN order_detail AS od ON o.order_id = od.order_id
GROUP BY c.customer_id, customer_name
ORDER BY total_order_amount DESC;

-- Detta ger en lista på varje kunds namn och den totala summan av deras ordrar, sorterat i fallande ordning efter totalvärde.

/*
  ----------------------------------------------------------------
*/

-- Totalt orderbelopp för varje kund under ett specifikt år (med WHERE och HAVING)
-- Om vi vill filtrera fram det totala orderbeloppet för varje kund under ett specifikt år, till exempel 2015, och samtidigt endast visa de kunder vars totalorder är över ett visst belopp, använder vi både WHERE och HAVING.

SELECT
  o.order_date,
  c.company_name AS customer_name,
  SUM(od.unit_price * od.quantity) AS total_order_amount
FROM customer AS c
JOIN `order` AS o ON c.customer_id = o.customer_id
JOIN order_detail AS od ON o.order_id = od.order_id
WHERE YEAR(o.order_date) = 2015
GROUP BY c.customer_id, customer_name
HAVING total_order_amount > 500
ORDER BY total_order_amount DESC;

-- WHERE YEAR(o.order_date) = 2015 filtrerar ordrar till de som är från år 2015.
-- HAVING total_order_amount > 500 ser till att endast kunder med en total orderbelopp över 500 visas.
-- GROUP BY: Grupperar datan på c.customer_id och c.customer_name.
-- SUM: Summerar kolumnen unit_price * quantity för varje kund.
-- HAVING: Filtrerar grupperade resultat för att endast inkludera kunder med en total orderbelopp över 500.
-- ORDER BY: Sorterar resultatet efter kundens namn i alfabetisk ordning.