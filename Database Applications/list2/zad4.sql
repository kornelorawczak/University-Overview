CREATE TYPE dbo.ReaderIDList AS TABLE
(
    Czytelnik_ID INT PRIMARY KEY
);
GO

CREATE OR ALTER PROCEDURE dbo.SumBorrowedDays
(
    @ReaderIDs dbo.ReaderIDList READONLY
) AS
BEGIN
    SELECT
        c.Czytelnik_ID,
        SUM(w.Liczba_Dni) AS TotalDays
    FROM
        @ReaderIDs r
        INNER JOIN Czytelnik c ON c.Czytelnik_ID = r.Czytelnik_ID
        LEFT JOIN Wypozyczenie w ON w.Czytelnik_ID = c.Czytelnik_ID
    GROUP BY
        c.Czytelnik_ID
    ORDER BY
        c.Czytelnik_ID;
END;
GO

DECLARE @Readers dbo.ReaderIDList;
INSERT INTO @Readers (Czytelnik_ID) VALUES (1), (2);
EXEC dbo.SumBorrowedDays @ReaderIDs = @Readers;