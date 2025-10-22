delete from food_orders;

ALTER TABLE food_orders
DROP COLUMN `order`;

-- Skapa ny kolumn för atomära värden
ALTER TABLE food_orders
ADD COLUMN item VARCHAR(255);

-- Sätt in atomära värden (manuellt uppdelade)
INSERT INTO food_orders (customer_name, item)
VALUES
('John Doe', 'Burger'),
('John Doe', 'Fries'),
('John Doe', 'Coke'),
('Foo Bar', 'Nuggets'),
('Foo Bar', 'Fries'),
('Foo Bar', 'Fanta'),
('John Doe', 'Burger'),
('John Doe', 'Fries'),
('John Doe', 'Coke');

select * from food_orders;