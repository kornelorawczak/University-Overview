CREATE FUNCTION dbo.Fn_ReadersThatHoldBooksLongerThan (@Days INT) RETURNS TABLE AS RETURN (
    SELECT c.PESEL, COUNT(DISTINCT w.Egzemplarz_ID) as SpecimentCount
    FROM dbo.Czytelnik as c
    JOIN dbo.Wypozyczenie as w on c.Czytelnik_ID = w.Czytelnik_ID
    WHERE w.Liczba_Dni >= @Days
    GROUP BY c.PESEL 
);
GO

SELECT * FROM dbo.Fn_ReadersThatHoldBooksLongerThan(6);
