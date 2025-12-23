IF OBJECT_ID('SalesLT.CustomerBackup', 'U') IS NOT NULL
    DROP TABLE SalesLT.CustomerBackup;

-- Create a copy of the structure only
SELECT TOP 0 *
INTO SalesLT.CustomerBackup
FROM SalesLT.Customer;

-- Clear table
TRUNCATE TABLE SalesLT.CustomerBackup;

-- Standard copy using select - 33ms
SET IDENTITY_INSERT SalesLT.CustomerBackup ON;

DECLARE @startTime DATETIME = GETDATE();

INSERT INTO SalesLT.CustomerBackup (
    CustomerID, NameStyle, Title, FirstName, 
    MiddleName, LastName, Suffix,
    CompanyName, SalesPerson, EmailAddress, 
    Phone, PasswordHash,
    PasswordSalt, rowguid, ModifiedDate
)
SELECT
    CustomerID, NameStyle, Title, FirstName, 
    MiddleName, LastName, Suffix,
    CompanyName, SalesPerson, EmailAddress, 
    Phone, PasswordHash,
    PasswordSalt, rowguid, ModifiedDate
FROM SalesLT.Customer;

DECLARE @endTime DATETIME = GETDATE();

SET IDENTITY_INSERT SalesLT.CustomerBackup OFF;

PRINT 'Standard INSERT SELECT time (ms): ' + CAST(DATEDIFF(ms, @startTime, @endTime) AS VARCHAR(10));

-- Copying using cursor loop - 2690ms - slower because each row is loaded 

DECLARE @startTime DATETIME = GETDATE();

SET IDENTITY_INSERT SalesLT.CustomerBackup ON;

DECLARE @CustomerID INT,
        @NameStyle BIT,
        @Title NVARCHAR(8),
        @FirstName NVARCHAR(50),
        @MiddleName NVARCHAR(50),
        @LastName NVARCHAR(50),
        @Suffix NVARCHAR(10),
        @CompanyName NVARCHAR(128),
        @SalesPerson NVARCHAR(256),
        @EmailAddress NVARCHAR(50),
        @Phone NVARCHAR(25),
        @PasswordHash NVARCHAR(128),
        @PasswordSalt NVARCHAR(10),
        @rowguid UNIQUEIDENTIFIER,
        @ModifiedDate DATETIME;

DECLARE customer_cursor CURSOR FOR
SELECT CustomerID, NameStyle, Title, FirstName, MiddleName, LastName, Suffix,
       CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash,
       PasswordSalt, rowguid, ModifiedDate
FROM SalesLT.Customer;

OPEN customer_cursor;

FETCH NEXT FROM customer_cursor INTO
    @CustomerID, @NameStyle, @Title, @FirstName, @MiddleName, @LastName, @Suffix,
    @CompanyName, @SalesPerson, @EmailAddress, @Phone, @PasswordHash,
    @PasswordSalt, @rowguid, @ModifiedDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO SalesLT.CustomerBackup (
        CustomerID, NameStyle, Title, FirstName, MiddleName, LastName, Suffix,
        CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash,
        PasswordSalt, rowguid, ModifiedDate
    )
    VALUES (
        @CustomerID, @NameStyle, @Title, @FirstName, @MiddleName, @LastName, @Suffix,
        @CompanyName, @SalesPerson, @EmailAddress, @Phone, @PasswordHash,
        @PasswordSalt, @rowguid, @ModifiedDate
    );

    FETCH NEXT FROM customer_cursor INTO
        @CustomerID, @NameStyle, @Title, @FirstName, @MiddleName, @LastName, @Suffix,
        @CompanyName, @SalesPerson, @EmailAddress, @Phone, @PasswordHash,
        @PasswordSalt, @rowguid, @ModifiedDate;
END

CLOSE customer_cursor;
DEALLOCATE customer_cursor;

SET IDENTITY_INSERT SalesLT.CustomerBackup OFF;

DECLARE @endTime DATETIME = GETDATE();

PRINT 'Cursor INSERT time (ms): ' + CAST(DATEDIFF(ms, @startTime, @endTime) AS VARCHAR(10));
