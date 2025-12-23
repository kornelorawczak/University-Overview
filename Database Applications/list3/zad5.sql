
-- Create the table
CREATE TABLE SalesLT.ProductPricesHistory
(
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    StandardCost MONEY NOT NULL,
    ListPrice MONEY NOT NULL,
    ValidFrom DATETIME NOT NULL,
    ValidTo DATETIME NULL,   -- null means that the price is still valid
    CONSTRAINT FK_ProductPricesHistory_Product FOREIGN KEY (ProductID) REFERENCES SalesLT.Product(ProductID)
);
GO

IF OBJECT_ID('SalesLT.trgProductPricesHistoryUpdate', 'TR') IS NOT NULL
    DROP TRIGGER SalesLT.trgProductPricesHistoryUpdate;
GO

CREATE TRIGGER SalesLT.trgProductPricesHistoryUpdate ON SalesLT.Product
AFTER UPDATE
AS
BEGIN
    -- Create the new record for a change (current price, so the ValidTo is null)
    INSERT INTO SalesLT.ProductPricesHistory (ProductID, StandardCost, ListPrice, ValidFrom, ValidTo)
    SELECT
        i.ProductID,
        i.StandardCost,
        i.ListPrice,
        GETDATE(),   
        NULL
    FROM inserted AS i
    INNER JOIN deleted d ON i.ProductID = d.ProductID
    WHERE i.StandardCost <> d.StandardCost OR i.ListPrice <> d.ListPrice;

    -- We need to update the changed history for a price that isnt valid now as we made the change
    UPDATE pph
    SET pph.ValidTo = GETDATE()
    FROM SalesLT.ProductPricesHistory AS pph
    INNER JOIN deleted AS d ON pph.ProductID = d.ProductID
    WHERE pph.ValidTo IS NULL
      AND (d.StandardCost <> (SELECT TOP 1 StandardCost FROM inserted i WHERE i.ProductID = d.ProductID)
           OR d.ListPrice <> (SELECT TOP 1 ListPrice FROM inserted i WHERE i.ProductID = d.ProductID));
END;
GO

-- Initialize table
INSERT INTO SalesLT.ProductPricesHistory (ProductID, StandardCost, ListPrice, ValidFrom, ValidTo)
SELECT ProductID, StandardCost, ListPrice, GETDATE(), NULL
FROM SalesLT.Product;

-- See 
SELECT * FROM SalesLT.ProductPricesHistory

-- Test, doing changes
UPDATE SalesLT.Product
SET ListPrice = ListPrice * 10
WHERE ProductID = 709;