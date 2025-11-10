-- Kolla om autocommit är på (1 för true, 0 för false)
SELECT @@autocommit;

-- Stäng av autocommit
SET autocommit = 0;

/*
  Basic example
*/
START TRANSACTION;
UPDATE `order` SET freight = 33.48 WHERE order_id = 10248;
UPDATE `order` SET freight = 12.71 WHERE order_id = 10249;
SELECT * FROM `order` WHERE order_id IN (10248, 10249);
-- ROLLBACK; ifall du inte vill COMMITa någon ändring i din transaktion
COMMIT;

/*
  Exempel med SAVEPOINTs
*/
START TRANSACTION;

UPDATE `order` SET freight = 33.48 WHERE order_id = 10248;
UPDATE `order` SET freight = 12.71 WHERE order_id = 10249;
SAVEPOINT step1;

SELECT * FROM `order` WHERE order_id IN (10248, 10249, 10250, 10251);

UPDATE `order` SET freight = 10 WHERE order_id = 10250;
UPDATE `order` SET freight = 10 WHERE order_id = 10251;
SAVEPOINT step2;

ROLLBACK TO SAVEPOINT step1;
COMMIT;

/*
  ---------------------------------------------------------
  Mer omfattande exempel:
*/

-- 2️ Starta transaktion
START TRANSACTION;

-- 3️ Skapa ny order för kund 103
INSERT INTO `order` (customer_id, order_date)
VALUES (103, CURDATE());

-- Spara order_id till variabel
SET @new_order_id = LAST_INSERT_ID();

-- 4️ Lägg till en orderrad (5 st av produkt 11)
INSERT INTO order_detail (order_id, product_id, quantity, unit_price)
VALUES (@new_order_id, 11, 5, (SELECT unit_price FROM product WHERE product_id = 11));

-- 5️ Sänk lagret på produkten
UPDATE product
SET units_in_stock = units_in_stock - 5
WHERE product_id = 11;

-- 6️ Kontrollera vad som hänt (innan commit)
SELECT * FROM `order` WHERE order_id = @new_order_id;
SELECT * FROM order_detail WHERE order_id = @new_order_id;
SELECT product_id, units_in_stock FROM product WHERE product_id = 11;

-- 7️ Om du vill spara ändringarna:
-- COMMIT;

-- 8️ Om du INTE vill att det ska slå igenom:
-- ROLLBACK;

-- 9️ Kontrollera efter commit/rollback:
SELECT * FROM `order` WHERE order_id = @new_order_id;
SELECT product_id, units_in_stock FROM product WHERE product_id = 11;
