-- Add a column CreditCardNumber to the Customer table and for 3 random rows in the SalesOrderHeader table set
-- any value for CreditCardApprovalCode column. Then for customers (Customer) with orders (SalesOrderHeader)
-- where CreditCardApprovalCode value is set, change the CreditCardNumber value for ’X’. Show all respective
-- queries to related to the exercise.

-- ALTER TABLE SalesLT.Customer ADD CreditCardNumber VARCHAR(20);

-- UPDATE TOP (3) SalesLT.SalesOrderHeader
-- SET CreditCardApprovalCode = 'X123X'
-- WHERE CreditCardApprovalCode IS NULL AND SalesOrderID > 71890;


-- SELECT SalesOrderID, CustomerID, CreditCardApprovalCode FROM SalesLT.SalesOrderHeader
-- WHERE CreditCardApprovalCode IS NOT NULL;

-- UPDATE customers
--     SET customers.CreditCardNumber = 'X' FROM SalesLT.Customer AS customers
--     JOIN SalesLT.SalesOrderHeader AS salesHeader
--     ON customers.CustomerID = salesHeader.CustomerID
--     WHERE salesHeader.CreditCardApprovalCode IS NOT NULL;

SELECT customers.CustomerID, customers.CreditCardNumber FROM SalesLT.Customer as customers
WHERE customers.CreditCardNumber = 'X';
