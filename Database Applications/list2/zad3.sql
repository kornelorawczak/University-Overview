CREATE OR ALTER PROCEDURE dbo.AddCzytelnik
(
    @PESEL CHAR(11),
    @Lastname VARCHAR(30),
    @City VARCHAR(30),
    @Date_of_birth DATE
) AS
BEGIN
    IF @PESEL NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    BEGIN
        THROW 50001, 'Invalid PESEL format: must consist of exactly 11 digits.', 1;
        RETURN;
    END

    DECLARE 
        @year INT,
        @month INT,
        @day INT,
        @century INT,
        @peselYear INT,
        @peselMonth INT,
        @peselDay INT;

    SET @peselYear  = CAST(SUBSTRING(@PESEL, 1, 2) AS INT);
    SET @peselMonth = CAST(SUBSTRING(@PESEL, 3, 2) AS INT);
    SET @peselDay   = CAST(SUBSTRING(@PESEL, 5, 2) AS INT);

    IF @peselMonth BETWEEN 1 AND 12
        SET @century = 1900;
    ELSE IF @peselMonth BETWEEN 21 AND 32
    BEGIN
        SET @century = 2000;
        SET @peselMonth = @peselMonth - 20;
    END
    ELSE
    BEGIN
        THROW 50002, 'Invalid PESEL month digits.', 1;
        RETURN;
    END

    SET @year  = @century + @peselYear;
    SET @month = @peselMonth;
    SET @day   = @peselDay;

    IF FORMAT(@Date_of_birth, 'yyMMdd') <> 
       RIGHT('0' + CAST(@peselYear AS VARCHAR(2)),2) +
       RIGHT('0' + CAST(@peselMonth AS VARCHAR(2)),2) +
       RIGHT('0' + CAST(@peselDay AS VARCHAR(2)),2)
    BEGIN
        THROW 50003, 'Birth date does not match PESEL date.', 1;
        RETURN;
    END

    DECLARE @sum INT = 
        CAST(SUBSTRING(@PESEL, 1 , 1) AS INT) * 1 +
        CAST(SUBSTRING(@PESEL, 2 , 1) AS INT) * 3 +
        CAST(SUBSTRING(@PESEL, 3 , 1) AS INT) * 7 +
        CAST(SUBSTRING(@PESEL, 4 , 1) AS INT) * 9 +
        CAST(SUBSTRING(@PESEL, 5 , 1) AS INT) * 1 +
        CAST(SUBSTRING(@PESEL, 6 , 1) AS INT) * 3 +
        CAST(SUBSTRING(@PESEL, 7 , 1) AS INT) * 7 +
        CAST(SUBSTRING(@PESEL, 8 , 1) AS INT) * 9 +
        CAST(SUBSTRING(@PESEL, 9 , 1) AS INT) * 1 +
        CAST(SUBSTRING(@PESEL, 10, 1) AS INT) * 3 

    DECLARE @controlDigit INT = (10 - (@sum % 10)) % 10;

    IF @controlDigit <> CAST(RIGHT(@PESEL,1) AS INT)
    BEGIN
        THROW 50004, 'Invalid PESEL control digit.', 1;
        RETURN;
    END

    IF UNICODE(SUBSTRING(@Lastname, 1, 1)) < UNICODE('A') 
    OR UNICODE(SUBSTRING(@Lastname, 1, 1)) > UNICODE('Z')
    BEGIN
        THROW 50005, 'Invalid last name: first letter must be uppercase.', 1;
        RETURN;
    END

    IF UNICODE(SUBSTRING(@Lastname, 2, 1)) < UNICODE('a') 
    OR UNICODE(SUBSTRING(@Lastname, 2, 1)) > UNICODE('z')
    BEGIN
        THROW 50005, 'Invalid last name: second letter must be lowercase.', 1;
        RETURN;
    END

    IF LEN(@Lastname) < 2
    BEGIN
        THROW 50005, 'Invalid last name: must contain at least 2 letters.', 1;
        RETURN;
    END


    INSERT INTO Czytelnik (PESEL, Nazwisko, Miasto, Data_Urodzenia)
    VALUES (@PESEL, @Lastname, @City, @Date_of_birth);
    PRINT 'Reader added successfully.';
END;
GO

-- ALTER TABLE dbo.Czytelnik ALTER COLUMN Nazwisko varchar(50) COLLATE Latin1_General_CS_AS;
DELETE FROM dbo.Czytelnik WHERE PESEL = '02070803628';

EXEC dbo.AddCzytelnik 
    @PESEL = '02070803628', 
    @Lastname = 'Polak',
    @City = 'Wroclaw',
    @Date_of_birth = '1902-07-08';

EXEC dbo.AddCzytelnik 
    @PESEL = '01290903629',
    @Lastname = 'Polak',
    @City = 'Wroclaw',
    @Date_of_birth = '2001-09-09';

EXEC dbo.AddCzytelnik 
    @PESEL = '02070803628', 
    @Lastname = 'polak',
    @City = 'Wroclaw',
    @Date_of_birth = '1902-07-08';
