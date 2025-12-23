SELECT addresses.City,
       COUNT(distinct customers.CustomerID)  as NumberOfCustomers,
       COUNT(distinct customers.SalesPerson) as NumberOfSalesPersons
FROM SalesLT.Customer        as customers
JOIN SalesLT.CustomerAddress as caddresses on customers.CustomerID = caddresses.CustomerID
JOIN SalesLT.Address         as addresses  on caddresses.AddressID = addresses.AddressID
GROUP BY addresses.City;