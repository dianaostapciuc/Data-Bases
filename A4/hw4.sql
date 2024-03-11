USE hair_products
GO
-- creating the testing tables

-- dropping any existent constraints
if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Tables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRunTables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRunViews]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRuns]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestTables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestViews]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Tests]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Views]
GO

--creating the tables
CREATE TABLE [Tables] (
	[TableID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [TestRunTables] (
	[TestRunID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [TestRunViews] (
	[TestRunID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [TestRuns] (
	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StartAt] [datetime] NULL ,
	[EndAt] [datetime] NULL 
) ON [PRIMARY]

GO

CREATE TABLE [TestTables] (
	[TestID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[NoOfRows] [int] NOT NULL ,
	[Position] [int] NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [TestViews] (
	[TestID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [Tests] (
	[TestID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [Views] (
	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]

GO

-- adding the constraints to the keys we have
ALTER TABLE [Tables] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 
	(
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRuns] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID]
	)  ON [PRIMARY]
GO

ALTER TABLE [TestTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Tests] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 
	(
		[TestID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Views] WITH NOCHECK ADD 
	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 
	(
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunTables] ADD 
	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE , -- if a change is made in one of the tables, it will also happen in the one that gets referenced
	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestRunViews] ADD 
	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestTables] ADD 
	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestViews] ADD 
	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	),
	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	)

/*
SELECT * FROM Tests
SELECT * FROM Tables
SELECT * FROM TestTables
SELECT * FROM Views 
SELECT * FROM TestViews 
SELECT * FROM TestRuns
SELECT * FROM TestRunTables 
SELECT * FROM TestRunViews
GO
*/

-- create views:
-- a) operating on one table
GO
CREATE OR ALTER VIEW ViewOneTable
AS
	SELECT * FROM SALES
GO

-- b) operating on 2 tables with a join operator
CREATE OR ALTER VIEW ViewTwoTables
AS
	SELECT DISTINCT p.weight, p.creation_date, p.expiry_date FROM PRODUCT p
	LEFT JOIN PRODUCT_TYPE t ON t.ptid = t.ptid
	WHERE hair_type = 'curly hair'
GO

-- c) operating on 2 tables with a group by
CREATE OR ALTER VIEW ViewGroupBy
AS 
	SELECT p.pid, AVG(s.initial_price) AS avg_initial_price
	FROM PRODUCT p
	INNER JOIN SALES s ON s.pid = p.pid
	GROUP BY p.pid
	HAVING AVG(s.initial_price) > 100;
GO


-- deleting the data:
CREATE OR ALTER PROCEDURE delete_table
@no_of_rows INT,
@table_name VARCHAR(30)
AS
BEGIN
	DECLARE @last_row INT
	IF @table_name = 'TELEPHONE'
	BEGIN 
		IF (SELECT COUNT(*) FROM TELEPHONE) < @no_of_rows
		BEGIN
			PRINT ('Too many rows to delete!')
			RETURN 1
		END
		ELSE
		BEGIN
			SET @last_row = (SELECT MAX(tid) FROM TELEPHONE) - @no_of_rows
			DELETE FROM TELEPHONE
			WHERE tid > @last_row
		END
		END
	ELSE IF @table_name = 'PRODUCT'
	BEGIN 
		IF (SELECT COUNT(*) FROM PRODUCT) < @no_of_rows
		BEGIN
			PRINT ('Too many rows to delete!')
			RETURN 1
		END
		ELSE
		BEGIN
			SET @last_row = (SELECT MAX(pid) FROM PRODUCT) - @no_of_rows
			DELETE FROM PRODUCT
			WHERE pid > @last_row
		END
		END
	ELSE IF @table_name = 'PRODUCT_TYPE'
	BEGIN 
		IF (SELECT COUNT(*) FROM PRODUCT_TYPE) < @no_of_rows
		BEGIN
			PRINT ('Too many rows to delete!')
			RETURN 1
		END
		ELSE
		BEGIN
			SET @last_row = (SELECT MAX(ptid) FROM PRODUCT_TYPE) - @no_of_rows
			DELETE FROM PRODUCT_TYPE
			WHERE ptid > @last_row
		END
		END
	ELSE IF @table_name = 'SALES'
	BEGIN 
		IF (SELECT COUNT(*) FROM DEPOSIT) < @no_of_rows
		BEGIN
			PRINT ('Too many rows to delete!')
			RETURN 1
		END
		ELSE
		BEGIN
			SET @last_row = (SELECT MAX(ssid) FROM SALES) - @no_of_rows
			DELETE FROM SALES
			WHERE ssid > @last_row
		END
		END
	ELSE
	BEGIN
		PRINT('Not a valid table name!')
		RETURN 1
	END
END
GO

-- inserting the data:
CREATE OR ALTER PROCEDURE insert_table
@no_of_rows INT,
@table_name VARCHAR(30)
AS
BEGIN
	DECLARE @input_id INT
	IF @table_name = 'TELEPHONE'
	BEGIN
		SET @input_id = (SELECT MAX(tid) + 1 FROM TELEPHONE)
		IF @input_id is NULL
			SET @input_id = 1
		DECLARE @fk INT
		SET @fk = (SELECT TOP 1 cid FROM CUSTOMER)
		WHILE @no_of_rows > 0
		BEGIN
			INSERT INTO TELEPHONE VALUES(@input_id,'RO', @fk, '0770000111', 'O')
			SET @input_id = @input_id + 1
			SET @no_of_rows = @no_of_rows - 1 
		END
	END
	ELSE IF @table_name = 'PRODUCT'
	BEGIN
		SET @input_id = (SELECT MAX(pid) + 1 FROM PRODUCT)
		IF @input_id is NULL
			SET @input_id = 1
		DECLARE @fk3 INT
		SET @fk3 = (SELECT TOP 1 ptid FROM PRODUCT_TYPE)
		DECLARE @fk4 INT
		SET @fk4 = (SELECT TOP 1 deid FROM DEPOSIT)
		WHILE @no_of_rows > 0
		BEGIN
			INSERT INTO PRODUCT VALUES(@input_id, @fk3, @fk4, '2022-jan-05', '2020-jan-07',200)
			SET @input_id = @input_id + 1
			SET @no_of_rows = @no_of_rows - 1 
		END
	END
	ELSE IF @table_name = 'PRODUCT_TYPE'
	BEGIN
		SET @input_id = (SELECT MAX(ptid) + 1 FROM PRODUCT_TYPE)
		IF @input_id is NULL
			SET @input_id = 1
		WHILE @no_of_rows > 0
		BEGIN
			INSERT INTO PRODUCT_TYPE VALUES(@input_id, 'dry shampoo', 'curly')
			SET @input_id = @input_id + 1
			SET @no_of_rows = @no_of_rows - 1 
		END
	END
	ELSE IF @table_name = 'SALES'
	BEGIN
		SET @input_id = (SELECT MAX(ssid) + 1 FROM SALES)
		IF @input_id is NULL
			SET @input_id = 1
		DECLARE @fk1 INT
		SET @fk1 = (SELECT TOP 1 pid FROM PRODUCT)
		DECLARE @fk2 INT
		SET @fk2 = (SELECT TOP 1 eid FROM EMPLOYEE)
		WHILE @no_of_rows > 0
		BEGIN
			INSERT INTO SALES VALUES(@input_id, @fk1, @fk2, 100)
			SET @input_id = @input_id + 1
			SET @no_of_rows = @no_of_rows - 1 
		END
	END

	ELSE
	BEGIN
		PRINT ('Not a valid table name!')
		RETURN 1
	END
END
GO

CREATE OR ALTER PROCEDURE select_view
	@view_name VARCHAR(30)
AS
BEGIN
	IF @view_name='ViewOneTable'
	BEGIN 
		SELECT * FROM ViewOneTable
	END

	ELSE IF @view_name='ViewTwoTables'
	BEGIN 
		SELECT * FROM ViewTwoTables
	END

	ELSE IF @view_name='ViewGroupBy'
	BEGIN 
		SELECT * FROM ViewGroupBy
	END

	ELSE
	BEGIN 
		PRINT('Not a valid view name')
		RETURN 1
	END
END
GO

DELETE FROM Tables
INSERT INTO Tables VALUES ('TELEPHONE'),('PRODUCT'),('PRODUCT_TYPE'),('SALES')
GO

DELETE FROM Views
INSERT INTO Views VALUES ('ViewOneTable'),('ViewTwoTables'),('ViewGroupBy')
GO

DELETE FROM Tests
INSERT INTO Tests VALUES ('test_10'),('test_100'),('test_1000'),('test_5000')
GO

DELETE FROM TestViews
INSERT INTO TestViews(TestID,ViewID) VALUES (1,1)
INSERT INTO TestViews(TestID,ViewID) VALUES (1,2)
INSERT INTO TestViews(TestID,ViewID) VALUES (1,3)
INSERT INTO TestViews(TestID,ViewID) VALUES (2,1)
INSERT INTO TestViews(TestID,ViewID) VALUES (2,2)
INSERT INTO TestViews(TestID,ViewID) VALUES (2,3)
INSERT INTO TestViews(TestID,ViewID) VALUES (3,1)
INSERT INTO TestViews(TestID,ViewID) VALUES (3,2)
INSERT INTO TestViews(TestID,ViewID) VALUES (3,3)
INSERT INTO TestViews(TestID,ViewID) VALUES (4,1)
INSERT INTO TestViews(TestID,ViewID) VALUES (4,2)
INSERT INTO TestViews(TestID,ViewID) VALUES (4,3)
GO

DELETE FROM TestTables
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (1,1,10,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (1,2,10,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (1,3,10,3)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (1,4,10,4)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (2,1,100,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (2,2,100,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (2,3,100,3)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (2,4,100,4)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (3,1,1000,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (3,2,1000,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (3,3,1000,3)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (3,4,1000,4)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (4,1,5000,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (4,2,5000,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (4,3,5000,3)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (4,4,5000,4)
GO

DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews
GO

CREATE OR ALTER PROCEDURE mainTest
	@testID INT
AS
BEGIN
	INSERT INTO TestRuns VALUES ((SELECT Name FROM Tests WHERE TestID=@testID),GETDATE(),GETDATE())
	DECLARE @testRunID INT
	SET @testRunID=(SELECT MAX(TestRunID) FROM TestRuns)

	DECLARE @noOfRows INT
	DECLARE @tableID INT
	DECLARE @tableName VARCHAR(30)
	DECLARE @startAt DATETIME
	DECLARE @endAt DATETIME
	DECLARE @viewID INT
	DECLARE @viewName VARCHAR(30)

	DECLARE testDeleteCursor CURSOR FOR
	SELECT TableID,NoOfRows
	FROM TestTables
	WHERE TestID=@testID
	ORDER BY Position DESC

	OPEN testDeleteCursor

	FETCH NEXT 
	FROM testDeleteCursor
	INTO @tableID,@noOfRows

	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @tableName=(SELECT Name FROM Tables WHERE TableID=@tableID)

		EXEC delete_table @noOfRows,@tableName

		FETCH NEXT 
		FROM testDeleteCursor
		INTO @tableID,@noOfRows
	END

	CLOSE testDeleteCursor
	DEALLOCATE testDeleteCursor

	DECLARE testInsertCursor CURSOR FOR
	SELECT TableID,NoOfRows
	FROM TestTables
	WHERE TestID=@testID
	ORDER BY Position ASC

	OPEN testInsertCursor

	FETCH NEXT 
	FROM testInsertCursor
	INTO @tableID,@noOfRows

	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @tableName=(SELECT Name FROM Tables WHERE TableID=@tableID)

		SET @startAt=GETDATE()
		EXEC insert_table @noOfRows,@tableName
		SET @endAt=GETDATE()

		INSERT INTO TestRunTables VALUES (@testRunID,@tableID,@startAt,@endAt)

		FETCH NEXT 
		FROM testInsertCursor
		INTO @tableID,@noOfRows
	END

	CLOSE testInsertCursor
	DEALLOCATE testInsertCursor

	DECLARE testViewCursor CURSOR FOR
	SELECT ViewID
	FROM TestViews
	WHERE TestID=@testID

	OPEN testViewCursor

	FETCH NEXT 
	FROM testViewCursor
	INTO @viewID

	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @viewName=(SELECT Name FROM Views WHERE ViewID=@viewID)

		SET @startAt=GETDATE()
		EXEC select_view @viewName
		SET @endAt=GETDATE()

		INSERT INTO TestRunViews VALUES (@testRunID,@viewID,@startAt,@endAt)

		FETCH NEXT 
		FROM testViewCursor
		INTO @viewID
	END

	CLOSE testViewCursor
	DEALLOCATE testViewCursor

	UPDATE TestRuns
	SET EndAt=GETDATE()
	WHERE TestRunID=@testRunID

END
GO

EXEC mainTest 1
EXEC mainTest 2
EXEC mainTest 3
EXEC mainTest 4


		
