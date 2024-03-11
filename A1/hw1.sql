CREATE TABLE POSITION
( oid INT PRIMARY KEY IDENTITY,
role varchar(50) not null)

INSERT INTO POSITION VALUES ('manager')
INSERT INTO POSITION VALUES ('cashier')
INSERT INTO POSITION VALUES ('security guard')
INSERT INTO POSITION VALUES ('staff')

CREATE TABLE EMPLOYEE
( eid INT PRIMARY KEY IDENTITY,
name varchar(50) not null,
date_of_birth date,
salary int)

INSERT INTO EMPLOYEE VALUES ('Anne', '1995-mar-08', 2000)
INSERT INTO EMPLOYEE VALUES ('John', '1998-jan-18', 2400)
INSERT INTO EMPLOYEE VALUES ('Ed', '2002-feb-26', 3000)
INSERT INTO EMPLOYEE VALUES ('Klaus', '2004-apr-28', 2900)
INSERT INTO EMPLOYEE VALUES ('Clara', '1992-mar-15', 2200)
INSERT INTO EMPLOYEE VALUES ('Oli', '2000-dec-02', 3500)
INSERT INTO EMPLOYEE VALUES ('Ophelia', '2001-sep-20', 1800)
INSERT INTO EMPLOYEE VALUES ('Jan', '1993-jan-08', 2200)

CREATE TABLE DEPARTMENT
( did INT PRIMARY KEY IDENTITY,
name varchar(50) not null)

INSERT INTO DEPARTMENT VALUES ('Call center')
INSERT INTO DEPARTMENT VALUES ('Human Resources')
INSERT INTO DEPARTMENT VALUES ('Marketing')
INSERT INTO DEPARTMENT VALUES ('Customer service')
INSERT INTO DEPARTMENT VALUES ('Product Management')

CREATE TABLE PRODUCT
( pid INT PRIMARY KEY IDENTITY,
name varchar(50),
creation_date date,
expiry_date date,
weight int)

INSERT INTO PRODUCT VALUES ('2023-jan-11', '2025-jan-11', 100)
INSERT INTO PRODUCT VALUES ('2023-jan-11', '2025-jan-11', 100)


CREATE TABLE SALES
(  pid INT FOREIGN KEY REFERENCES PRODUCT(pid),
eid INT FOREIGN KEY REFERENCES EMPLOYEE(eid),
initial_price int)

CREATE TABLE PRODUCT_TYPE
( ptid INT PRIMARY KEY IDENTITY,
ptype varchar(50) not null,
hair_type varchar(50))

CREATE TABLE DEPOSIT
( deid INT PRIMARY KEY IDENTITY,
name varchar(50) not null,
location varchar(50) not null,
nr_products int)

CREATE TABLE CUSTOMER
( cid INT PRIMARY KEY IDENTITY,
name varchar(50) not null,
date_of_birth date,
cnp varchar(50) not null)

CREATE TABLE PURCHASES
( prid INT FOREIGN KEY REFERENCES PRODUCT(pid),
cid INT FOREIGN KEY REFERENCES CUSTOMER(cid),
final_price int,
discount_applied varchar(5))

CREATE TABLE TELEPHONE
( tid INT PRIMARY KEY IDENTITY,
number varchar(50) not null,
phone_company varchar(50) not null)


