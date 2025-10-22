CREATE DATABASE IF NOT EXISTS normalization_demo;

CREATE TABLE food_orders (
    customer_name VARCHAR(100),
    `order` VARCHAR(100)
);

INSERT INTO food_orders
(customer_name, `order`)
VALUES('John Doe', 'Burger, Fries, Coke')

INSERT INTO food_orders
(customer_name, `order`)
VALUES('Foo Bar', 'Nuggets, Fries, Fanta')

select * from food_orders;
