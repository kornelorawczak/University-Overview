
IF OBJECT_ID('dbo.Egzemplarz', 'U') IS NOT NULL DROP TABLE dbo.Egzemplarz1;
IF OBJECT_ID('dbo.Ksiazka', 'U') IS NOT NULL DROP TABLE dbo.Ksiazka1;

CREATE TABLE dbo.Ksiazka1 (
    Ksiazka_ID   INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,  
    Tytul         NVARCHAR(200) NOT NULL,
    Autor         NVARCHAR(200) NULL,
    RokWydania    INT NULL
);

CREATE TABLE dbo.Egzemplarz1 (
    Egzemplarz_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,  
    Ksiazka_ID    INT NOT NULL,  
    NumerEgzemplarza NVARCHAR(50) NULL,
    Stan          NVARCHAR(50) NULL,
    CONSTRAINT FK_Egzemplarz_Ksiazka FOREIGN KEY (Ksiazka_ID) REFERENCES dbo.Ksiazka(Ksiazka_ID)
);

INSERT INTO dbo.Ksiazka1 (Tytul, Autor, RokWydania) VALUES
('Clean Code', 'Robert C. Martin', 2008),
('Design Patterns', 'Erich Gamma', 1994),
('Refactoring', 'Martin Fowler', 1999);

INSERT INTO dbo.Egzemplarz1 (Ksiazka_ID, NumerEgzemplarza, Stan) VALUES
(1, 'CLEAN-001', 'Good'),
(1, 'CLEAN-002', 'Worn'),
(1, 'CLEAN-003', 'Good'),
(2, 'DP-001', 'New'),
(3, 'REF-001', 'Good'),
(3, 'REF-002', 'Worn');

-- Clustered Index defines the physical order of rows in table. Each index = row, and they
-- are continuosly spread in memory so the lookups and range queries are fast.
-- There can only be one clusted index in a table
SET SHOWPLAN_XML ON;
GO

SELECT 
    k.Tytul,
    k.Autor,
    e.NumerEgzemplarza,
    e.Stan
FROM dbo.Ksiazka1 k
INNER JOIN dbo.Egzemplarz1 e ON k.Ksiazka_ID = e.Ksiazka_ID
WHERE k.Tytul = 'Clean Code';

SET SHOWPLAN_XML OFF;
GO
-- Non Clustered index only store a pointer to the row in memory. They are smaller in size
-- but lookups have to access the pointer so they are slower. Also there can be 
-- multiple non cluster indexes in a table

CREATE NONCLUSTERED INDEX IX_Egzemplarz1_KsiazkaID 
ON dbo.Egzemplarz1 (Ksiazka_ID);
CREATE NONCLUSTERED INDEX IX_Ksiazka1_Tytul 
ON dbo.Ksiazka1 (Tytul);

SET SHOWPLAN_XML ON;
GO

SELECT 
    k.Tytul,
    k.Autor,
    e.NumerEgzemplarza,
    e.Stan
FROM dbo.Ksiazka1 k WITH (INDEX(IX_Ksiazka1_Tytul))
INNER JOIN dbo.Egzemplarz1 e WITH (INDEX(IX_Egzemplarz1_KsiazkaID)) 
    ON k.Ksiazka_ID = e.Ksiazka_ID
WHERE k.Tytul = 'Clean Code';

SET SHOWPLAN_XML OFF;
GO