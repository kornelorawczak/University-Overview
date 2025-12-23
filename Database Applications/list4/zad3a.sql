CREATE TABLE products5 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE customers5 (
    id INT PRIMARY KEY,
    company_name VARCHAR(100)
);

DROP TABLE products5;
DROP TABLE customers5;

INSERT INTO products5 (id, name, price) VALUES 
(101, 'Laptop', 999.99),
(102, 'Mouse', 25.50);

INSERT INTO customers5 (id, company_name) VALUES 
(101, 'Google'),
(102, 'Microsoft');

-- 1. Dirty Read - means reading the data that is changed in undergoing transaction, but may--
--  be rolled back later

-- 1.1
BEGIN TRANSACTION;
UPDATE products5 SET price = 799.99 WHERE id = 101;

-- 1.3
ROLLBACK TRANSACTION;

-- 2. Non-Repeatable Read - happens when in the same transaction we have a read of the same
--    row twice but it gives different result because between the two reads a different 
--    transaction changes the row value 

-- 2.1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
SELECT company_name FROM customers5 WHERE id = 101;

-- 2.3
SELECT company_name FROM customers5 WHERE id = 101; 
COMMIT;

-- 3. Phantom Read - occurs when a transaction works on the same set twice but reads 
--    different amount of rows the second time 

-- 3.1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;
SELECT COUNT(*) AS amazon_customers FROM customers5 WHERE company_name = 'Amazon';

-- 3.3
SELECT COUNT(*) AS amazon_customers FROM customers5 WHERE company_name = 'Amazon'; 
COMMIT;