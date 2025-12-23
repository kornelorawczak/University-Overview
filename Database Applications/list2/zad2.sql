-- 1. Creating Tables
DROP TABLE IF EXISTS fldata;
DROP TABLE IF EXISTS firstnames;
DROP TABLE IF EXISTS lastnames;
GO

CREATE TABLE firstnames (
    id INT IDENTITY PRIMARY KEY,
    firstname VARCHAR(50)
);
GO

CREATE TABLE lastnames (
    id INT IDENTITY PRIMARY KEY,
    lastname VARCHAR(50)
);
GO

CREATE TABLE fldata (
    firstname VARCHAR(50),
    lastname  VARCHAR(50),
    CONSTRAINT fldata_PK PRIMARY KEY (firstname, lastname)
);
GO

-- 2. Add some data
INSERT INTO firstnames (firstname) VALUES
('Anna'), ('Jan'), ('Krzysztof'), ('Maria'), ('Ewa'), ('Tomasz'), ('Piotr'), ('Kornel'), ('Izabela'), ('Mariusz');

INSERT INTO lastnames (lastname) VALUES
('Nowak'), ('Kowalski'), ('Wiśniewski'), ('Wójcik'), ('Kamiński'), ('Lewandowski'), ('Przybylski'), ('Marcinkowska'), ('Orawski');
GO

-- 3. The Procedure declaration
CREATE PROCEDURE dbo.GenerateRandomFLData @pairs INT as 
BEGIN
    DECLARE @maxPossible INT;

    SELECT @maxPossible = COUNT(*) FROM firstnames CROSS JOIN lastnames;
    IF @pairs > @maxPossible
    BEGIN
        THROW 50001, 'The number of requested pairs is too large', 1;
        RETURN;
    END 

    DELETE FROM fldata;
    DECLARE @allPairs TABLE (firstname VARCHAR(50), lastname VARCHAR(50));

    INSERT INTO @allPairs (firstname, lastname) 
    SELECT f.firstname, l.lastname 
    FROM firstnames as f CROSS JOIN lastnames as l;

    INSERT INTO fldata (firstname, lastname)
    SELECT TOP (@pairs) firstname, lastname 
    FROM @allPairs ORDER BY NEWID();
END;
GO
-- 4. Testing the procedure
EXEC dbo.GenerateRandomFLData @pairs = 10;
SELECT * FROM fldata;

EXEC dbo.GenerateRandomFLData @pairs = 100;
SELECT * FROM fldata;