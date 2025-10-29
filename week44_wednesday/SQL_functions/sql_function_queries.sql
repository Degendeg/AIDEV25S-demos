-- ===============================================
-- SQL FUNKTIONER (fortsättning på dml_db / customer)
-- ===============================================

USE dml_db;

-- ======================
-- NULL-värden
-- ======================

-- Visa alla kunder som saknar email
SELECT full_name, email
FROM customer
WHERE email IS NULL;

-- Visa alla kunder som har email
SELECT full_name, email
FROM customer
WHERE email IS NOT NULL;

-- ======================
-- LIKE (mönstersökning)
-- ======================

-- Kunder vars namn börjar på bokstaven 'A'
SELECT full_name
FROM customer
WHERE full_name LIKE 'A%';

-- Kunder vars namn slutar på bokstaven 'n'
SELECT full_name
FROM customer
WHERE full_name LIKE '%n';

-- Kunder som har bokstaven 'a' någonstans i sitt namn
SELECT full_name
FROM customer
WHERE full_name LIKE '%a%';

-- ======================
-- IN (flera alternativ i villkor)
-- ======================

-- Kunder som finns i Stockholm, Göteborg eller Malmö
SELECT full_name, city
FROM customer
WHERE city IN ('Stockholm', 'Göteborg', 'Malmö');

-- Kunder som inte finns i dessa städer
SELECT full_name, city
FROM customer
WHERE city NOT IN ('Stockholm', 'Göteborg', 'Malmö');

-- ======================
-- SUBSTRING (del av text)
-- ======================

-- Visa de tre första tecknen i telefonnumret (riktnummer)
SELECT full_name,
       phone,
       SUBSTRING(phone, 1, 3) AS riktnummer
FROM customer;

-- Visa de första fyra tecknen i kundens namn
SELECT full_name,
       SUBSTRING(full_name, 1, 4) AS namnstart
FROM customer;

-- ======================
-- UPPER och LOWER (skiftläge)
-- ======================

-- Visa stad i stora bokstäver
SELECT full_name, UPPER(city) AS stad_stora
FROM customer;

-- Visa stad i små bokstäver
SELECT full_name, LOWER(city) AS stad_sma
FROM customer;

-- ======================
-- BONUS: Kombinera flera funktioner
-- ======================

-- Visa kundinfo i formatet "NAMN - STAD" med stora bokstäver
SELECT UPPER(CONCAT(full_name, ' - ', city)) AS kundinfo
FROM customer;

-- Visa förnamn (allt före första mellanslaget)
SELECT full_name,
       SUBSTRING(full_name, 1, LOCATE(' ', full_name) - 1) AS fornamn
FROM customer
WHERE LOCATE(' ', full_name) > 0;

-- ===============================================
-- SLUT PÅ DEMO
-- ===============================================