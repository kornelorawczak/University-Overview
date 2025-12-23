SELECT customers.LastName,
       customers.FirstName,
       SUM(salesDetail.UnitPrice * salesDetail.OrderQty * salesDetail.UnitPriceDiscount) as SavedAmount
FROM SalesLT.Customer as customers 
JOIN SalesLT.SalesOrderHeader as salesHeader 
       ON salesHeader.CustomerID = customers.CustomerID
JOIN SalesLT.SalesOrderDetail as salesDetail
       ON salesDetail.SalesOrderID = salesHeader.SalesOrderID
GROUP BY customers.FirstName, customers.LastName
ORDER BY SavedAmount desc 