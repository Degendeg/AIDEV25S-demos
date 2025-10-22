-- Lägg till order_id för att identifiera varje beställning
ALTER TABLE food_orders
ADD COLUMN order_id INT AUTO_INCREMENT PRIMARY KEY;

-- Uppdatera befintliga data med unika order_id
UPDATE food_orders
SET order_id = 1 WHERE customer_name = 'John Doe' AND item = 'Burger' AND order_id IS NULL;
UPDATE food_orders
SET order_id = 2 WHERE customer_name = 'Foo Bar' AND item = 'Nuggets' AND order_id IS NULL;
UPDATE food_orders
SET order_id = 3 WHERE customer_name = 'John Doe' AND item = 'Burger' AND order_id IS NULL;

select * from food_orders;

-- alter table food_orders modify column order_id INT first;