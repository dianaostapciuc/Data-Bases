USE second_hw
GO

-- a) modify the type of column

CREATE OR ALTER PROC change_column_weight
AS
BEGIN
	ALTER TABLE PRODUCT
	ALTER COLUMN weight VARCHAR(10)
	PRINT 'altered table PRODUCT, column weight to varchar'
END
GO

-- exec change_column_weight

-- a) undo
CREATE OR ALTER PROC undo_change_column_weight
AS
BEGIN
	ALTER TABLE PRODUCT
	ALTER COLUMN weight INT
	PRINT 'altered table PRODUCT, column weight back to varchar'
END
GO

-- exec undo_change_column_weight

-- b) add/remove a column
CREATE OR ALTER PROC add_column_sales
AS
BEGIN
	ALTER TABLE SALES
	ADD name VARCHAR(30)
	PRINT 'altered table SALES, added column name'
END
GO
-- exec add_column_sales

-- b) undo
CREATE OR ALTER PROC undo_add_column_sales
AS
BEGIN
	ALTER TABLE SALES
	DROP COLUMN name 
	PRINT 'altered table SALES, dropped column name'
END
GO
--exec undo_add_column_sales

-- c) add/remove a default constraint
CREATE OR ALTER PROC add_constr_purchases
AS
BEGIN
	ALTER TABLE PURCHASES
	ADD CONSTRAINT default_final_price DEFAULT 0 FOR final_price
	PRINT 'altered table PURCHASES, added constraint'
END
GO
--exec add_constr_purchases

-- c) undo
CREATE OR ALTER PROC undo_add_constr_purchases
AS
BEGIN
	ALTER TABLE PURCHASES
	DROP CONSTRAINT default_final_price
	PRINT 'altered table PURCHASES, dropped constraint'
END
GO
--exec undo_add_constr_purchases

--d) add/remove a primary key
CREATE OR ALTER PROC drop_pk_telephone
AS
BEGIN
	ALTER TABLE TELEPHONE
	DROP CONSTRAINT pk_telephone
	PRINT 'altered table TELEPHONE, dropped constraint'
END
GO
--exec drop_pk_telephone

-- d) undo
CREATE OR ALTER PROC undo_drop_pk_telephone
AS
BEGIN
	ALTER TABLE TELEPHONE
	ADD CONSTRAINT pk_telephone PRIMARY KEY(tid)
	PRINT 'altered table DEPOSIT, dropped constraint'
END
GO
--exec undo_drop_pk_telephone

-- e) add/remove a candidate key (uniqueness)
CREATE OR ALTER PROC add_cand_product_type
AS
BEGIN
	ALTER TABLE PRODUCT_TYPE
	ADD CONSTRAINT unique_ptid UNIQUE(ptid)
	PRINT 'altered table PRODUCT_TYPE, added constraint'
END
GO
--exec add_cand_product_type

-- e) undo
CREATE OR ALTER PROC undo_add_cand_product_type
AS
BEGIN
	ALTER TABLE PRODUCT_TYPE
	DROP CONSTRAINT unique_ptid
	PRINT 'altered table PRODUCT_TYPE, dropped constraint'
END
GO
--exec undo_add_cand_product_type

-- f) add/remove foreign key
CREATE OR ALTER PROC remove_foreign_key
AS
BEGIN 
	ALTER TABLE PURCHASES
	DROP CONSTRAINT fk_pid
	PRINT 'altered table PURCHASES, dropped foreign key constraint'
END
GO
--exec remove_foreign_key

-- f) undo
CREATE OR ALTER PROC undo_remove_foreign_key
AS
BEGIN 
	ALTER TABLE PURCHASES
	ADD CONSTRAINT fk_pid FOREIGN KEY (pid) REFERENCES PRODUCT(pid)
	PRINT 'altered table PURCHASES, dropped foreign key constraint'
END
GO
--exec undo_remove_foreign_key

-- g) create/drop a table
CREATE OR ALTER PROC create_test_table
AS
BEGIN
	CREATE TABLE TEST
	( id int PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	age INT,
	weight INT,
	result VARCHAR(50))
	PRINT 'created table TEST'
END
GO
--exec create_test_table

-- g) undo
CREATE OR ALTER PROC undo_create_test_table
AS
BEGIN
	DROP TABLE IF EXISTS TEST
	PRINT 'dropped table TEST'
END
GO
--exec undo_create_test_table

-- create a new table that holds the current version of the DB:

CREATE TABLE VERSION_CHANGE
(current_procedure VARCHAR(100),
back_procedure VARCHAR(100),
version INT UNIQUE)
GO

INSERT INTO VERSION_CHANGE VALUES('change_column_weight','undo_change_column_weight',1),
('add_column_sales', 'undo_add_column_sales',2),('add_constr_purchases','undo_add_constr_purchases',3),
('drop_pk_telephone', 'undo_drop_pk_telephone',4),('add_cand_product_type','undo_add_cand_product_type',5),
('remove_foreign_key', 'undo_remove_foreign_key',6),('create_test_table','undo_create_test_table',7)

-- SELECT * FROM VERSION_CHANGE

-- Create a new table that holds the current version of the database schema

CREATE TABLE CURRENT_VERSION
(current_version INT DEFAULT 0)

INSERT INTO CURRENT_VERSION VALUES(0)

-- SELECT * FROM CURRENT_VERSION

GO
CREATE OR ALTER PROCEDURE go_to_version(@version INT)
AS
BEGIN
	DECLARE @current_version INT
	IF @version < 0 or @version > 7 -- check parameter
		BEGIN
			RAISERROR('version number wrong!',17,1)
			RETURN
		END
	ELSE
		IF @version = @current_version
			BEGIN
				PRINT ('this is the current one.')
				RETURN
			END
		ELSE
			DECLARE @current_procedure NVARCHAR(50)
			SET @current_version = (SELECT current_version FROM CURRENT_VERSION)
			IF @current_version < @version
				BEGIN
					WHILE @current_version < @version
						BEGIN
							PRINT N'we are at version: ' + CAST(@current_version as NVARCHAR(10))
							SET @current_procedure = (SELECT current_procedure FROM VERSION_CHANGE WHERE version = @current_procedure+1)
							EXEC(@current_procedure)
							SET @current_version = @current_version + 1
						END
				END
			ELSE
			IF @current_version > @version
				BEGIN
					WHILE @current_version < @version
						BEGIN
							PRINT N'we are at version: ' + CAST(@current_version as NVARCHAR(10))
							SET @current_procedure = (SELECT back_procedure FROM VERSION_CHANGE WHERE version = @current_procedure)
							EXEC(@current_procedure)
							SET @current_version = @current_version - 1
						END
				END
			UPDATE CURRENT_VERSION
			SET current_version = @current_version
			PRINT('current version updated!')
END

SELECT * FROM VERSION_CHANGE
GO
exec go_to_version 7
exec go_to_version 2
exec go_to_version 6
exec go_to_version 0
exec go_to_version -2