-- This shows the constraints for each column
-- EXEC sp_helpconstraint 'SalesLT.SalesOrderHeader', 'nomsg'
-- -- ([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL)

-- This will fail due to constrains
-- INSERT INTO SalesLT.SalesOrderHeader
-- (SalesOrderID, OrderDate, DueDate, ShipDate, Status, OnlineOrderFlag, rowguid, ModifiedDate, CustomerID, ShipMethod)
-- VALUES
-- (71775, '2024-01-10', '2024-01-15', '2024-01-01', 1, 1, NEWID(), GETDATE(), 1, 'CARGO TRANSPORT 5');

-- This won't fail because we turn off constraints
-- ALTER TABLE SalesLT.SalesOrderHeader NOCHECK CONSTRAINT CK_SalesOrderHeader_ShipDate;
-- INSERT INTO SalesLT.SalesOrderHeader
-- (SalesOrderID, OrderDate, DueDate, ShipDate, Status, OnlineOrderFlag, rowguid, ModifiedDate, CustomerID, ShipMethod)
-- VALUES
-- (71775, '2024-01-10', '2024-01-15', '2024-01-01', 1, 1, NEWID(), GETDATE(), 1, 'CARGO TRANSPORT 5');

-- Turn on the constraints
-- ALTER TABLE SalesLT.SalesOrderHeader CHECK CONSTRAINT CK_SalesOrderHeader_ShipDate;

-- Find the violations
SELECT SalesOrderID, OrderDate, ShipDate
FROM SalesLT.SalesOrderHeader
WHERE ShipDate < OrderDate;

