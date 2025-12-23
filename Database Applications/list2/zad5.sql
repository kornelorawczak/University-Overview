CREATE TYPE dbo.ProductIDList AS TABLE
(
    ProductID INT PRIMARY KEY
);
GO

CREATE OR ALTER PROCEDURE dbo.SetDiscontinuedDate
(
    @ProductIDs dbo.ProductIDList READONLY,
    @DiscontinuedDate DATETIME
) AS
BEGIN
    UPDATE products
    SET DiscontinuedDate = @DiscontinuedDate
    FROM SalesLT.Product as products
    INNER JOIN @ProductIDs ids ON products.ProductID = ids.ProductID
    WHERE products.DiscontinuedDate IS NULL;

    DECLARE @Count INT;
    SELECT @Count = COUNT(*)
    FROM SalesLT.Product as products
    INNER JOIN @ProductIDs ids ON products.ProductID = ids.ProductID
    WHERE products.DiscontinuedDate IS NOT NULL;

    IF @Count > 0
    BEGIN
        PRINT CONCAT(@Count, ' product(s) had DiscontinuedDate != NULL and were not updated.');
    END
END;
GO

DECLARE @Products dbo.ProductIDList;
INSERT INTO @Products (ProductID) VALUES (680), (706);
EXEC dbo.SetDiscontinuedDate @ProductIDs = @Products, @DiscontinuedDate = '2025-10-17';

SELECT ProductID, Name, DiscontinuedDate
FROM SalesLT.Product
WHERE ProductID IN (680, 706);