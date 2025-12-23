-- Create tables M1(K INT, V VARCHAR(20)) and S1(K INT, MFK INT, V VARCHAR(20)) where K is a
-- primary key and MFK is a foreign key to the table M. Now, create tables M2 and S2 where the only difference
-- is that M2 has a primary key based on two columns: K1 and K2 and S2 has an appropriate foreign key. Add
-- some test data, check whether foreign key contraint is working properly. Finally, add ON UPDATE and ON
-- DELETE clauses and show the difference where different values NO ACTION, SET NULL or CASCADE are
-- introduced.

-- 1. Create first two tables
-- CREATE TABLE M1 (
--     K INT PRIMARY KEY,
--     V VARCHAR(20)
-- );

-- CREATE TABLE S1 (
--     K INT PRIMARY KEY,
--     MFK INT FOREIGN KEY REFERENCES M1(K),
--     V VARCHAR(20)
-- );

-- 2. Add test data to first two tables
-- INSERT INTO M1 VALUES (1, 'Mouse1'), (2, 'Mouse2');
-- INSERT INTO S1 VALUES (1, 1, 'Snake1'), (2, 1, 'Snake2');

-- Should Fail 
-- INSERT INTO S1 VALUES (3, 3, 'Snake3')

-- 3. Create another two tables
-- CREATE TABLE M2 (
--     K1 INT,
--     K2 INT,
--     V VARCHAR(20),
--     CONSTRAINT PK_M2 PRIMARY KEY (K1, K2)
-- );

-- CREATE TABLE S2 (
--     K INT PRIMARY KEY,
--     MFK1 INT,
--     MFK2 INT,
--     V VARCHAR(20),
--     CONSTRAINT FK_S2_M2 FOREIGN KEY (MFK1, MFK2) REFERENCES M2(K1, K2)
-- );

-- 4. Add test data to another two tables
-- INSERT INTO M2 VALUES (1, 1, 'MousePair1'), (1, 2, 'MousePair2'), (2, 1, 'MousePair3');
-- INSERT INTO S2 VALUES (1, 1, 1, 'Snakes1'), (2, 1, 2, 'Snakes2'), (3, 1, 2, 'Snakes3');

-- Should fail 
-- INSERT INTO S2 VALUES (4, 2, 2, 'Snakes4');

-- 5. On default, the table has a NO ACTION constraint which means that it's impossible to delete 
-- this row, because there would be a snake unlinked to anything
-- DELETE FROM M1 WHERE K = 1;

-- 6. Now, let's change S1 to ON DELETE CASCADE, so the deletion will be possible and will delete 
-- the linked snake too 
-- DROP TABLE S1;
-- CREATE TABLE S1 (
--     K INT PRIMARY KEY,
--     MFK INT,
--     V VARCHAR(20),
--     CONSTRAINT FK_S1_M1 FOREIGN KEY (MFK) REFERENCES M1(K) ON DELETE CASCADE ON UPDATE CASCADE
-- );
-- INSERT INTO M1 VALUES (1, 'Mouse1');
-- INSERT INTO S1 VALUES (1, 1, 'Snake1'), (2, 1, 'Snake2'), (3, 2, 'Snake3');
-- DELETE FROM M1 WHERE K = 1;
-- SELECT * FROM S1;

-- 7. Now, we change S1 to ON DELETE SET NULL, so when deleting the linked mouse, the snake will 
-- have a field set to null - be unlinked
-- DROP TABLE S1;
-- CREATE TABLE S1 (
--     K INT PRIMARY KEY,
--     MFK INT NULL,
--     V VARCHAR(20),
--     CONSTRAINT FK_S1_M1 FOREIGN KEY (MFK) REFERENCES M1(K) ON DELETE SET NULL
-- );
-- INSERT INTO M1 VALUES (1, 'Mouse1');
-- INSERT INTO S1 VALUES (1, 1, 'Snake1'), (2, 1, 'Snake2'), (3, 2, 'Snake3');
-- DELETE FROM M1 WHERE K = 1;

-- SELECT * FROM S1;
-- 8. Now, we change S2 to ON UPDATE SET NULL, so when updating linked mouses,
-- if the snakes lose the primary key linked, they will have it set to null
DROP TABLE S2
CREATE TABLE S2 (
    K INT PRIMARY KEY,
    MFK1 INT,
    MFK2 INT,
    V VARCHAR(20),
    CONSTRAINT FK_S2_M2 FOREIGN KEY (MFK1, MFK2) REFERENCES M2(K1, K2) ON UPDATE SET NULL
);

INSERT INTO S2 VALUES (1, 1, 1, 'Snakes1'), (2, 1, 2, 'Snakes2'), (3, 1, 2, 'Snakes3');
UPDATE M2 SET K1 = 3, K2 = 3 WHERE K1 = 1 AND K2 = 1;

SELECT * FROM S2