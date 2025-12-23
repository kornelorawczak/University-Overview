DROP TABLE IF EXISTS Orders6;
GO

CREATE TABLE Orders6 (
    ID INT IDENTITY PRIMARY KEY,
    UserID INT,
    Name NVARCHAR(50),
    Name2 NVARCHAR(50)
)
GO

-- 400k zlych wierszy
INSERT INTO Orders6 (UserID, Name, Name2)
SELECT TOP (400000) 1, 'A', 'A'
FROM sys.objects a CROSS JOIN sys.objects b;

-- 1k wierszy dobrych
INSERT INTO Orders6 (UserID, Name, Name2)
SELECT TOP (1000) 2, 'B', 'B'
FROM sys.objects a CROSS JOIN sys.objects b;
GO

-- Non filtered index = scanning whole table 
CREATE NONCLUSTERED INDEX IX_User ON Orders6(Name)
INCLUDE(ID);

-- Filtered Index - only on pending orders, so its pretty small and now we can 
-- work on that, without having to scan the whole table 
CREATE NONCLUSTERED INDEX IX_Category_Filtered ON Orders6(Name2)
INCLUDE(ID)
WHERE Name2='B';
GO

SET SHOWPLAN_XML ON;
GO

SELECT o.ID
FROM Orders6 as o 
WHERE Name='B'

SELECT o.ID
FROM Orders6 as o
WHERE Name2='B'

SET SHOWPLAN_XML OFF;
GO