SELECT TOP 1
       salesHeader.SalesOrderID,
       salesHeader.SalesOrderNumber,
       salesHeader.PurchaseOrderNumber,
       SUM(salesDetail.UnitPrice * salesDetail.OrderQty) as TotalPriceWithoutDiscount,
       SUM(salesDetail.UnitPrice * salesDetail.OrderQty) - SUM(salesDetail.LineTotal)  as DiscountAmount,
       SUM(salesDetail.LineTotal) as TotalPriceWithDiscount
FROM SalesLT.SalesOrderDetail as salesDetail
JOIN SalesLT.SalesOrderHeader as salesHeader 
       ON salesDetail.SalesOrderID = salesHeader.SalesOrderID
GROUP BY salesHeader.SalesOrderID, salesHeader.salesOrderNumber, salesHeader.PurchaseOrderNumber
ORDER BY DiscountAmount desc
