SELECT DISTINCT address.City
FROM SalesLT.SalesOrderHeader AS soh
JOIN SalesLT.Address AS address
    ON soh.ShipToAddressID = address.AddressID
ORDER BY address.City;
