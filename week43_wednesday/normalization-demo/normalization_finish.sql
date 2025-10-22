-- Representerar unika beställningar med gemensam order_id för varje beställning.
-- Här kan vi också spara info som datum eller status.
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Ny kolumn som kommer agera FK i food_orders för relation mot customer_orders
ALTER TABLE food_orders
ADD COLUMN main_order_id INT;

-- Sätt ett främmande nyckel-referens till customer_orders-tabellen.
ALTER TABLE food_orders
ADD FOREIGN KEY (main_order_id) REFERENCES customer_orders(order_id);

INSERT INTO customer_orders (customer_id, order_date) VALUES (1, '2024-10-10');  -- Första beställningen för John Doe
INSERT INTO customer_orders (customer_id, order_date) VALUES (2, '2024-10-11');  -- Första beställningen för Foo Bar

-- Koppla ihop items till första beställningen för John Doe
UPDATE food_orders SET main_order_id = 1 WHERE order_id IN (1, 2, 3);

-- Koppla ihop items till första beställningen för Foo Bar
UPDATE food_orders SET main_order_id = 2 WHERE order_id IN (4, 5, 6);

-- Om John Doe har en ny beställning:
INSERT INTO customer_orders (customer_id, order_date) VALUES (1, '2024-10-12');  -- Andra beställningen för John Doe
UPDATE food_orders SET main_order_id = 3 WHERE order_id IN (7, 8, 9);

-- Ny tabell som heter customer_orders, då döper vi om food_orders till något bättre:
alter table food_orders rename order_items;

-- JOIN-fråga för att visa en specifik beställning med alla dess items & kundinfo.
SELECT co.order_id AS main_order_id, co.order_date, c.customer_name, oi.item
FROM customer_orders co
JOIN order_items oi ON co.order_id = oi.main_order_id
JOIN customers c ON co.customer_id = c.customer_id
ORDER BY co.order_id;

-- Här ser du order_id per item, main_order_id för ordern
select * from order_items;