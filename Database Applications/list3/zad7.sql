IF OBJECT_ID('dbo.Specimen', 'U') IS NOT NULL DROP TABLE dbo.Specimen;
IF OBJECT_ID('dbo.Book', 'U') IS NOT NULL DROP TABLE dbo.Book;
GO

CREATE TABLE dbo.Book (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE dbo.Specimen (
    SpecimenID INT IDENTITY(1,1) PRIMARY KEY,
    OriginalBookID INT NOT NULL,
    CONSTRAINT FK_Specimen_Book FOREIGN KEY (OriginalBookID) REFERENCES dbo.Book(BookID)
);
GO

IF OBJECT_ID('dbo.trgMaxFivePerBook', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trgMaxFivePerBook;
GO

CREATE TRIGGER dbo.trgMaxFivePerBook
ON dbo.Specimen
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM dbo.Specimen s
        INNER JOIN inserted i ON s.OriginalBookID = i.OriginalBookID
        GROUP BY s.OriginalBookID
        HAVING COUNT(*) > 5
    )
    BEGIN
        RAISERROR('A book cannot have more than 5 specimens.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

INSERT INTO dbo.Book (Title) VALUES ('Masterworks');

INSERT INTO dbo.Specimen (OriginalBookID) VALUES (1);
INSERT INTO dbo.Specimen (OriginalBookID) VALUES (1);
INSERT INTO dbo.Specimen (OriginalBookID) VALUES (1);
INSERT INTO dbo.Specimen (OriginalBookID) VALUES (1);
INSERT INTO dbo.Specimen (OriginalBookID) VALUES (1);

INSERT INTO dbo.Specimen (OriginalBookID) VALUES (1);

SELECT * FROM dbo.Specimen

