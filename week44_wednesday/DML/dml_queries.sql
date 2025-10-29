-- Skapa databasen och använd den
CREATE DATABASE dml_db;
USE dml_db;

-- Skapa tabellen customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    phone VARCHAR(50),
    salary DECIMAL(18,2)
);

-- Lägg till fler kunder (totalt 10)
INSERT INTO customer (full_name, city, phone, salary)
VALUES
('Anna Svensson', 'Stockholm', '08-123456', 35000),
('Erik Larsson', 'Göteborg', '031-654321', 45000),
('Lisa Berg', 'Malmö', '040-987654', 50000),
('John Doe', 'Stockholm', '08-111222', 40000),
('Karin Nilsson', 'Uppsala', '018-223344', 38000),
('Oskar Holm', 'Stockholm', '08-555666', 52000),
('Sara Lind', 'Göteborg', '031-222333', 47000),
('Peter Andersson', 'Malmö', '040-112233', 36000),
('Maria Eriksson', 'Umeå', '090-998877', 41000),
('Johan Bergström', 'Västerås', '021-556677', 39000);

-- Hämta alla kunder (SELECT)
SELECT * FROM customer;

-- Hämta kunder från Stockholm med salary > 35000
SELECT full_name, city, salary
FROM customer
WHERE city = 'Stockholm' AND salary > 35000;

-- Räkna kunder i varje stad
SELECT city, COUNT(*) AS number_of_customers
FROM customer
GROUP BY city;

-- Visa unika städer
SELECT DISTINCT city
FROM customer;

-- Sortera kunder efter salary (stigande)
SELECT full_name, salary
FROM customer
ORDER BY salary ASC;

-- Sortera kunder efter salary (fallande)
SELECT full_name, salary
FROM customer
ORDER BY salary DESC;

-- Uppdatera en kunds telefonnummer
UPDATE customer
SET phone = '08-999888'
WHERE full_name = 'Anna Svensson';

-- Ta bort en kund
DELETE FROM customer
WHERE full_name = 'Lisa Berg';

-- Kontrollera tabellen efter UPDATE och DELETE
SELECT * FROM customer;