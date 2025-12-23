SELECT pcategories.Name as CategoryName,
          products.Name as ProductName 
FROM SalesLT.Product         as products
JOIN SalesLT.ProductCategory as pcategories 
    on pcategories.ProductCategoryID = products.ProductCategoryID
    WHERE pcategories.ProductCategoryID IN (
        -- tworzymy zbiór identyfikatorów kategorii, które są czyimś rodzicami - czyli nie są liśćmi
        SELECT distinct ParentProductCategoryID
        FROM SalesLT.ProductCategory 
    );
