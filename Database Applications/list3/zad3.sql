-- Clean up 
IF OBJECT_ID('dbo.Prices', 'U') IS NOT NULL DROP TABLE dbo.Prices;
IF OBJECT_ID('dbo.Rates', 'U') IS NOT NULL DROP TABLE dbo.Rates;
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL DROP TABLE dbo.Products;
GO

-- Create tables
CREATE TABLE dbo.Products (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Rates (
    Currency NVARCHAR(10) PRIMARY KEY,
    PricePLN DECIMAL(18,3) NOT NULL  
);

CREATE TABLE dbo.Prices (
    ProductID INT NOT NULL FOREIGN KEY REFERENCES dbo.Products(ID),
    Currency NVARCHAR(10) NOT NULL,
    Price DECIMAL(18,3) NOT NULL,
    CONSTRAINT PK_Prices PRIMARY KEY (ProductID, Currency)
);
GO

-- Insert sample data
INSERT INTO dbo.Products (ProductName)
VALUES ('Bike'), ('Helmet'), ('Gloves');

INSERT INTO dbo.Rates (Currency, PricePLN)
VALUES 
('PLN', 1.0),
('EUR', 4.3),
('USD', 4.0);

INSERT INTO dbo.Prices (ProductID, Currency, Price)
VALUES
(1, 'EUR', 100.0),  
(1, 'PLN', 430.0),  
(2, 'USD', 50.0),
(2, 'PLN', 200.0),
(3, 'EUR', 10.0);   
GO

SELECT * FROM dbo.Prices;

-- Cursor solution
DECLARE 
    @ProductID INT,
    @Currency NVARCHAR(10),
    @Price DECIMAL(18,3),
    @Rate DECIMAL(18,3);

DECLARE price_cursor CURSOR FOR
SELECT ProductID, Currency, Price FROM Prices;

OPEN price_cursor;

FETCH NEXT FROM price_cursor INTO @ProductID, @Currency, @Price;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @Rate = PricePLN FROM Rates WHERE Currency = @Currency;

    IF @Rate IS NULL
    BEGIN
        PRINT 'Deleting price for ProductID=' + CAST(@ProductID AS NVARCHAR(10)) +
              'and Currency=' + @Currency + ', because the rate wasnt found';
        DELETE FROM Prices
        WHERE ProductID = @ProductID AND Currency = @Currency;
    END
    ELSE
    BEGIN
        IF @Currency <> 'PLN'
        BEGIN
            DECLARE @PriceInPLN DECIMAL(18,3);
            SET @PriceInPLN = @Price * @Rate;

            -- Ensure that there is always price defined in PLN
            IF EXISTS (
                SELECT 1 FROM Prices WHERE ProductID = @ProductID AND Currency = 'PLN'
            )
                UPDATE Prices
                SET Price = @PriceInPLN
                WHERE ProductID = @ProductID AND Currency = 'PLN';
            ELSE
                INSERT INTO Prices (ProductID, Currency, Price)
                VALUES (@ProductID, 'PLN', @PriceInPLN);
        END
    END

    FETCH NEXT FROM price_cursor INTO @ProductID, @Currency, @Price;
END

CLOSE price_cursor;
DEALLOCATE price_cursor;
GO

-- ITs not possible to do it all in just sql query because we need row by row examination
-- In order to achieve that we would need to assume that every productID has a pln price in Prices and we 
-- would have to abolish the need to update, insert or delete rows dynamically

