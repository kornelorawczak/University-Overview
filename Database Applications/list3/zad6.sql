DROP TABLE dbo.brand_approvals;

CREATE TABLE dbo.brand_approvals(
    brand_id INT IDENTITY PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

CREATE TABLE dbo.brands(
    brand_id INT IDENTITY PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

-- Ten widok prezentuje wszystkie dane z dbo.brands ze statusem Approved oraz te z dbo.brand_approvals z statusem Pending Approval
CREATE VIEW dbo.vw_brands 
AS
SELECT
    brand_name,
    'Approved' approval_status
FROM
    dbo.brands
UNION
SELECT
    brand_name,
    'Pending Approval' approval_status
FROM
    dbo.brand_approvals;

-- Trigger ten nadpisuje jakby nasz view, dodając do niego tylko taki brand który nie jest w tabelki dbo.brands 
CREATE TRIGGER dbo.trg_vw_brands 
ON dbo.vw_brands
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.brand_approvals ( 
        brand_name
    )
    SELECT
        i.brand_name
    FROM
        inserted i
    WHERE
        i.brand_name NOT IN (
            SELECT 
                brand_name
            FROM
                dbo.brands
        );
END

INSERT INTO dbo.vw_brands(brand_name)
VALUES('Eddy Merckx');

SELECT
	brand_name,
	approval_status
FROM
	dbo.vw_brands;