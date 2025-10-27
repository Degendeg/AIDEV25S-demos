-- skapa databasen
CREATE DATABASE demo_db;

-- skapa tabell för customer_type
CREATE TABLE customer_type (
  customer_type_id INT AUTO_INCREMENT PRIMARY KEY,
  type_name VARCHAR(50) NOT NULL
);

-- lägg in några kundtyper
INSERT INTO customer_type (type_name)
VALUES ('regular'), ('premium'), ('vip');

-- skapa customer-tabellen med FK till customer_type
CREATE TABLE customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  phone VARCHAR(25),
  salary DECIMAL(18, 2),
  customer_type_id INT NOT NULL,
  CONSTRAINT fk_customer_customer_type
  FOREIGN KEY (customer_type_id)
  REFERENCES customer_type(customer_type_id)
);

-- lägg till några kunder
INSERT INTO customer (full_name, phone, salary, customer_type_id)
VALUES ('Sebastian Degerman', '0707707070', 99000.00, 1),
('Erik Larsson', '073-5554488', '45550.88', 2),
('Anna Svensson', '073-1234567', 66666, 3),
('John Doe', NULL, 500.9, 3);

-- lägger till kolumnen age
ALTER TABLE customer ADD COLUMN age INT;
-- ta bort kolumnen age
ALTER TABLE customer DROP COLUMN age;

-- flytta kolumn customer_type_id
ALTER TABLE customer MODIFY customer_type_id INT AFTER customer_id;

-- peka på specifik databas
USE demo_db;
-- visa samtliga tabeller i databasen
SHOW TABLES;
-- beskriv särskild tabell
DESCRIBE customer;