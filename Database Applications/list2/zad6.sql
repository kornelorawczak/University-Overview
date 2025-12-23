-- Table variable 
-- it works in current scope only and ends at the end of procedure
-- it is not visible in other sessions and it doesn't appear in tempdb
DECLARE @TableVar TABLE
(
    ID INT,
    Name VARCHAR(50)
);

INSERT INTO @TableVar VALUES (1,'Paul'), (2,'Bob');

-- Local temp table
-- also works in current scope and ends with the procedure but does appear in tempdb
CREATE TABLE #LocalTemp
(
    ID INT,
    Name VARCHAR(50)
);

INSERT INTO #LocalTemp VALUES (1,'Alpha'), (2,'Beta');
SELECT * 
FROM tempdb.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '#LocalTemp%';

-- Global temp table
-- it's scope is all sessions and it ends with closing of original session and all sessions that reference it 
CREATE TABLE ##GlobalTemp
(
    ID INT,
    Name VARCHAR(50)
);

INSERT INTO ##GlobalTemp VALUES (1,'X');
SELECT * 
FROM tempdb.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '##GlobalTemp%';


SELECT * FROM #LocalTemp; -- works in session but not in new query
SELECT * FROM ##GlobalTemp; -- works in all sessions
