CREATE TRIGGER SalesLT.trgUpdateModifiedDate
ON SalesLT.Customer
AFTER UPDATE
AS
BEGIN
    UPDATE c
    SET c.ModifiedDate = GETDATE()
    FROM SalesLT.Customer AS c
    INNER JOIN inserted AS i ON c.CustomerID = i.CustomerID;
END;
GO

-- Testing
SELECT CustomerID, FirstName, LastName, ModifiedDate
FROM SalesLT.Customer
WHERE CustomerID = 3;

UPDATE SalesLT.Customer
SET FirstName = 'Kornel'
WHERE CustomerID = 3;