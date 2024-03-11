CREATE TABLE Ta
(
	aid INT PRIMARY KEY,
	a2 INT UNIQUE,
	name VARCHAR(20)
)

CREATE TABLE Tb
(
	bid INT PRIMARY KEY,
	b2 INT
)

CREATE TABLE Tc
(
	cid INT PRIMARY KEY,
	aid INT FOREIGN KEY REFERENCES Ta(aid),
	bid INT FOREIGN KEY REFERENCES Tb(bid)
)

-- inserting data into the tables:
DECLARE @i INT=0
DECLARE @fk1 INT
DECLARE @fk2 INT
WHILE @i<50
BEGIN
	INSERT INTO Ta VALUES (@i,@i*2,CONCAT('test',RAND()*@i))
	INSERT INTO Tb VALUES (@i,RAND()*@i)

	SET @fk1=(SELECT TOP 1 aid FROM Ta ORDER BY NEWID())
	SET @fk2=(SELECT TOP 1 bid FROM Tb ORDER BY NEWID())

	INSERT INTO Tc VALUES (@i,@fk1,@fk2)

	SET @i=@i+1
END
GO
-- pk -> automatically has a clustered index on it
-- unique constraint -> non-clustered index on it

-- a) 
-- clustered index scan (goes through the whole table for the match)
SELECT * FROM Ta WHERE a2%2 = 0

-- clustered index seek (particular range of rows)
SELECT * FROM Ta WHERE aid between 10 and 20

-- non-clustered index scan (retrieves all rows from table)
SELECT a2, name FROM Ta

-- non-clustered index seek(searching for particular values where we have the unique constraint)
SELECT a2 FROM Ta WHERE a2>10

-- key look up (+ seek)
SELECT a2, name FROM Ta WHERE a2=10

-- b)
SELECT * FROM Tb WHERE b2 = 5 -- here, we have a clustered index on the pk of the table (so, it scans)
CREATE NONCLUSTERED INDEX TB_b2 on Tb(b2) -- now, we have a non-clustered index, so we seek the value we need

-- c) create a view that joins 2 tables

-- i'll join tables a and c, with the help of the non-clustered existing index i have on A
CREATE NONCLUSTERED INDEX Tc_aid on Tc(aid) -- non-clustered index on C
GO

CREATE OR ALTER VIEW JoiningTables
AS
	SELECT a.aid as A_PK, a.name as A_NAME, c.cid AS C_PK FROM Ta a
	INNER JOIN Tc c ON c.aid = a.aid
GO

SELECT * FROM JoiningTables