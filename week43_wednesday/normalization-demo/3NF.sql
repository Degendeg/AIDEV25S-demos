-- Separera kunddata till en ny tabell
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255)
);

-- Sätt in unika kunder
INSERT INTO customers (customer_name)
SELECT DISTINCT customer_name FROM food_orders;

-- Lägg till en kundreferens i food_orders
ALTER TABLE food_orders
ADD COLUMN customer_id INT;

-- Koppla beställningarna till kundtabellen
UPDATE food_orders
SET customer_id = (SELECT customer_id FROM customers WHERE customers.customer_name = food_orders.customer_name);

-- Slutligen, ta bort den redundanta kolumnen customer_name i food_orders
ALTER TABLE food_orders
DROP COLUMN customer_name;

SELECT fo.order_id, fo.item, c.customer_name
FROM food_orders fo
INNER JOIN customers c ON fo.customer_id = c.customer_id;