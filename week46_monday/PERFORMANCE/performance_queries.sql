CREATE DATABASE IF NOT EXISTS performance_db;
USE performance_db;

/*
  -----------------------------------------------
*/

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50),
    adress VARCHAR(100),
    city VARCHAR(50),
    income INT
);

/*
  -----------------------------------------------
*/

DELIMITER //

CREATE PROCEDURE populate_customer(IN num_of_customers INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < num_of_customers DO
        INSERT INTO customer (full_name, adress, city, income)
        VALUES (
            CONCAT('Kund', i+1),
            CONCAT('Adress', i+1),
            ELT(FLOOR(1 + RAND()*5),'Stockholm','Göteborg','Malmö','Uppsala','Västerås'),
            FLOOR(RAND()*100000)
        );
        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

/*
  -----------------------------------------------
*/

-- CALL populate_customer(333333);

-- hämta data
SELECT COUNT(*) FROM customer;
SELECT full_name, adress, city, income FROM customer;
-- TRUNCATE TABLE customer;

-- skapa index
CREATE INDEX IX_City ON customer(city);

-- ta bort index
DROP INDEX IX_City ON customer;

-- visar hur MySQL planerar att köra en query inklusive index + ordning tabeller scannas
EXPLAIN SELECT * FROM customer WHERE city = 'Stockholm'; -- kör FÖRE och EFTER index