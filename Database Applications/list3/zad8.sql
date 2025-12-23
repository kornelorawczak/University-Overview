-- DDL triggers react to the schema changes and not data changes
-- F.e to creating or dropping the table, renaming objects or creating views or functions

-- (a) which prevents dropping or modifying the schema of 3 selected tables, 
CREATE TRIGGER trgBlockTableChanges
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    DECLARE @event XML = EVENTDATA();
    DECLARE @objectName NVARCHAR(255);
    SET @objectName = @event.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)');

    IF @objectName IN ('Table1', 'Table2', 'Table3')
    BEGIN
        RAISERROR('You cannot alter or drop protected tables: Table1, Table2, Table3.', 16, 1);
        ROLLBACK;
    END
END;
GO

CREATE TABLE dbo.Table1 (
    ID INT IDENTITY(1,1) PRIMARY KEY,
);
GO

CREATE TABLE dbo.Table2 (
    ID INT IDENTITY(1,1) PRIMARY KEY,
);
GO

CREATE TABLE dbo.Table3 (
    ID INT IDENTITY(1,1) PRIMARY KEY,
);
GO

-- TEST
DROP TABLE dbo.Table1;

-- (b) which ensures that added or modified column name starts with a capital letter
DROP TRIGGER trgCapsColumnName ON DATABASE;

CREATE TRIGGER trgCapsColumnName
ON DATABASE FOR ALTER_TABLE
AS
BEGIN
    DECLARE @column NVARCHAR(128);
    SET @column = EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/Create/Columns/Name)[1]', 'NVARCHAR(128)');
    -- PRINT CAST(EVENTDATA() AS NVARCHAR(MAX));

    -- Check all column names in the event
    IF @column IS NOT NULL AND 
        LEFT(@column, 1) COLLATE Latin1_General_CS_AS <> UPPER(LEFT(@column, 1)) 
        COLLATE Latin1_General_CS_AS
    BEGIN
        THROW 50005, 'All column names must start with a capital letter (A-Z).', 1;
    END
END;

DROP TABLE dbo.Table4;

-- TEST
CREATE TABLE dbo.Table4 (
    Id INT PRIMARY KEY,
);

ALTER TABLE dbo.Table4 ADD name NVARCHAR(100);



