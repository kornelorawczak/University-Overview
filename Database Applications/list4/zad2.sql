-- Savepoint is a marker that allows to roll back a transaction to this save point, when 
-- there is a part of the transaction not executing properly

CREATE PROCEDURE SalesLT.UpdateCustomerCompanyName
    @CustomerID INT,
    @NewCompanyName VARCHAR
AS BEGIN 
-- This will detect if the procedure is called within an exisiting transaction
    DECLARE @TransactionCount INT = @@TRANCOUNT;
    IF @TransactionCount > 0
        -- IF it is then create savepoint
        SAVE TRANSACTION CompanyNameUpdateSave;
    ELSE 
        -- else - we start executing transaction
        BEGIN TRANSACTION;
    
    BEGIN TRY 
        UPDATE SalesLT.Customer
        SET CompanyName = @NewCompanyName
        WHERE CustomerID = @CustomerID;
        -- Fictional condition - we only update for women
        IF (SELECT Title FROM SalesLT.Customer WHERE CustomerID = @CustomerID) = 'Mr.'
        BEGIN   
            RAISERROR('Update aborted: We can only update the company name of a man', 16, 1);
        END;

        IF @TransactionCount = 0
            -- We commit a transaction only if this procedure started it
            COMMIT TRANSACTION;
    END TRY 
    BEGIN CATCH
        IF @TransactionCount = 0 
            -- If the error occured in the transaction started inside procudere - rollback
            ROLLBACK TRANSACTION;
        ELSE 
            -- If called within a transaction, rollback to savepoint
            ROLLBACK TRANSACTION CompanyNameUpdateSave;
            -- Rethrow error - for testing
            DECLARE @ErrorMsg NVARCHAR(4000) = ERROR_MESSAGE();
            RAISERROR(@ErrorMsg, 16, 1);
    END CATCH 
END;

-- Now to test the procedure 
BEGIN TRANSACTION;
    -- First, we perform a valid update
    UPDATE SalesLT.Customer 
    SET LastName = 'Pompa'
    WHERE CustomerID = 5;
    -- This procedure will be failed because customer 4 is a man
    EXEC SalesLT.UpdateCustomerCompanyName @CustomerID = 5, @NewCompanyName = 'Amazon'
ROLLBACK TRANSACTION;
