-- Förklaring av Stored Procedures
-- DELIMITER: Används för att ändra standardavgränsaren ; när man definierar en Stored Procedure.
-- IN Parameter: Parametrar som skickas in när man anropar proceduren och kan användas för att filtrera eller specificera resultatet.
-- Anrop av procedur: CALL används för att köra en Stored Procedure med eventuella inparametrar.

-- Lista alla SPs
SHOW PROCEDURE STATUS WHERE Db = 'northwind';

-- Ta bort SP
DROP PROCEDURE get_all_products;

/*
  ----------------------------------------------------------------
*/

-- 1. Enkel Stored Procedure för att hämta alla produkter
-- Den här proceduren returnerar alla produkter från product-tabellen.

DELIMITER //

CREATE PROCEDURE get_all_products()
BEGIN
    SELECT * FROM product;
END //

DELIMITER ;

-- Anrop:
CALL get_all_products();

/*
  ----------------------------------------------------------------
*/

-- 2. Stored Procedure med inparametrar för att filtrera efter kundnamn och ort
-- Denna procedur returnerar alla kunder baserat på ett sökvillkor för kundnamn och stad.

DELIMITER //

CREATE PROCEDURE get_customer_list(
    IN company_name_param VARCHAR(40),
    IN city_param VARCHAR(15)
)
BEGIN
    SELECT * 
    FROM customer
    WHERE company_name LIKE CONCAT('%', company_name_param, '%')
      AND city LIKE CONCAT('%', city_param, '%');
END //

DELIMITER ;

-- Anrop:
CALL get_customer_list('', 'London');  -- Hämtar alla kunder i London
CALL get_customer_list('Antonio', ''); -- Hämtar alla kunder med "Antonio" i företagsnamnet

/*
  ----------------------------------------------------------------
*/

-- 3. Stored Procedure med inparameter för att hämta order över ett visst belopp
-- Denna procedur returnerar ordrar som överstiger ett visst belopp, vilket kan skickas som en inparameter.

DELIMITER //

CREATE PROCEDURE get_large_orders(
    IN min_amount DECIMAL(20, 4)
)
BEGIN
    SELECT order_id, customer_id, order_date, freight
    FROM `order`
    WHERE freight > min_amount;
END //

DELIMITER ;

-- Anrop:
CALL get_large_orders(500);

/*
  ----------------------------------------------------------------
*/

-- 4. Stored Procedure för att lägga till en ny kund
-- Den här proceduren tar in tre inparametrar (kundens namn, stad och telefonnummer) och lägger till en ny kund i customer-tabellen.

DELIMITER //

CREATE PROCEDURE add_new_customer(
    IN customer_id VARCHAR(5),
    IN company_name VARCHAR(40),
    IN contact_name VARCHAR(30),
    IN contact_title VARCHAR(30),
    IN address VARCHAR(60),
    IN city VARCHAR(15),
    IN region VARCHAR(15),
    IN postal_code VARCHAR(10),
    IN country VARCHAR(15),
    IN phone VARCHAR(24),
    IN fax VARCHAR(24)
)
BEGIN
    INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax)
    VALUES (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax);
END //

DELIMITER ;

-- Anrop:
CALL add_new_customer('C001', 'ABC Corp', 'John Doe', 'Manager', '123 Main St', 'Stockholm', 'Vällingby', '10101', 'Sweden', '+467707070', NULL);