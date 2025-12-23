SELECT prodmodel.Name as ProductModelName,
       COUNT(prod.ProductID) as ProductCount
FROM SalesLT.Product as prod 
JOIN SalesLT.ProductModel as prodmodel 
    on prod.ProductModelID = prodmodel.ProductModelID 
GROUP BY prodmodel.ProductModelID, prodmodel.Name
HAVING COUNT(prod.ProductID) > 1
ORDER BY ProductCount DESC;
-- Grupowanie po nazwie moze byc bledne, bo nazwa moze nie byc unikatowa