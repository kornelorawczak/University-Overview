-- hint locks are explicit instructions that can overwrite the default lock system in sql
-- server. They allow the custom locking methods

-- WITH (NOLOCK) basically means there is no lock at all, it allows dirty reads - reading
-- uncomitted data 

DROP TABLE IF EXISTS Products4;
CREATE TABLE Products4 (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products4 VALUES 
(1, 'Product A', 100.00),
(2, 'Product B', 200.00),
(3, 'Product C', 300.00);

-- Setup
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES 
(1, 'Product A', 100.00),
(2, 'Product B', 200.00),
(3, 'Product C', 300.00);

-- DEMO 1: Serializable without NOLOCK
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
SELECT * FROM Products4 WHERE Price BETWEEN 150 AND 250;

SELECT 
    resource_type,
    request_mode,
    request_status,
    resource_description
FROM sys.dm_tran_locks 
WHERE request_session_id = @@SPID
AND resource_type IN ('KEY', 'PAGE', 'OBJECT', 'RID');

COMMIT;

-- DEMO 2: Serializable with NOLOCK
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
SELECT * FROM Products4 WITH (NOLOCK) WHERE Price BETWEEN 150 AND 250;

SELECT 
    resource_type,
    request_mode,
    request_status,
    resource_description
FROM sys.dm_tran_locks 
WHERE request_session_id = @@SPID
AND resource_type IN ('KEY', 'PAGE', 'OBJECT', 'RID');

COMMIT;
-- Here we can see that there are no locks held