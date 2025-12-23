DROP TABLE Sales5;

CREATE TABLE Sales5 (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO Sales5 (SaleID, CustomerID, Amount, SaleDate) VALUES
(1, 101, 150.00, '2024-01-01'),
(2, 102, 200.00, '2024-01-05'),
(3, 101, 300.00, '2024-01-10');

-- Without a covering index
-- There is an Clustered Index Scan performed, which has to use the PK to search for 
-- a customer id 101 to return the amount
SET SHOWPLAN_XML ON;
GO

SELECT CustomerID, Amount
FROM Sales5
WHERE CustomerID = 101;

SET SHOWPLAN_XML OFF;
GO

-- With covering index (creating a non-clustered index)
-- We can see that there is only an index seek executed on the created index,
-- which includes the CustomerID and Amount so no table search (key search) is needed
-- This improves performance 
CREATE INDEX IX_Sales_Customer_Cover
ON Sales5(CustomerID)
INCLUDE (Amount);

SET SHOWPLAN_XML ON;
GO

SELECT CustomerID, Amount
FROM Sales5
WHERE CustomerID = 101;


SET SHOWPLAN_XML OFF;
GO