CREATE TABLE POSITION
( oid INT PRIMARY KEY NOT NULL,
role varchar(50) not null)

INSERT INTO POSITION VALUES (1,'manager')
INSERT INTO POSITION VALUES (2,'cashier')
INSERT INTO POSITION VALUES (3,'security guard')
INSERT INTO POSITION VALUES (4,'staff')

CREATE TABLE DEPARTMENT
( did INT PRIMARY KEY NOT NULL,
name varchar(50) not null)

INSERT INTO DEPARTMENT VALUES (1,'Call center')
INSERT INTO DEPARTMENT VALUES (2,'Human Resources')
INSERT INTO DEPARTMENT VALUES (3,'Marketing')
INSERT INTO DEPARTMENT VALUES (4,'Customer service')
INSERT INTO DEPARTMENT VALUES (5,'Product Management')

CREATE TABLE EMPLOYEE
( eid INT PRIMARY KEY NOT NULL,
oid INT FOREIGN KEY REFERENCES POSITION(oid),
did INT FOREIGN KEY REFERENCES DEPARTMENT(did),
name varchar(50) not null,
date_of_birth date,
salary int)

INSERT INTO EMPLOYEE VALUES (1,1,2,'Anne', '1995-mar-08', 2000)
INSERT INTO EMPLOYEE VALUES (2,2,3,'John', '1998-jan-18', 2400)
INSERT INTO EMPLOYEE VALUES (3,2,1,'Ed', '2002-feb-26', 3000)
INSERT INTO EMPLOYEE VALUES (4,3,5,'Klaus', '2004-apr-28', 2900)
INSERT INTO EMPLOYEE VALUES (5,1,5,'Clara', '1992-mar-15', 2200)
INSERT INTO EMPLOYEE VALUES (6,4,1,'Oli', '2000-dec-02', 3500)
INSERT INTO EMPLOYEE VALUES (7,4,2,'Ophelia', '2001-sep-20', 1800)
INSERT INTO EMPLOYEE VALUES (8,4,3,'Jan', '1993-jan-08', 2200)

CREATE TABLE PRODUCT_TYPE
( ptid INT PRIMARY KEY NOT NULL,
ptype varchar(50) not null,
hair_type varchar(50))

INSERT INTO PRODUCT_TYPE VALUES (1,'shampoo', 'curly hair')
INSERT INTO PRODUCT_TYPE VALUES (2,'shampoo', 'straight hair')
INSERT INTO PRODUCT_TYPE VALUES (3,'conditioner', 'curly hair')
INSERT INTO PRODUCT_TYPE VALUES (4,'conditioner', 'straight hair')
INSERT INTO PRODUCT_TYPE VALUES (5,'hair mask', 'curly hair')
INSERT INTO PRODUCT_TYPE VALUES (6,'hair mask', 'straight hair')

CREATE TABLE DEPOSIT
( deid INT PRIMARY KEY NOT NULL,
name varchar(50) not null,
nr_products int)

INSERT INTO DEPOSIT VALUES (1,'B15', 150)
INSERT INTO DEPOSIT VALUES (2,'A13', 250)
INSERT INTO DEPOSIT VALUES (3,'B15', 300)
INSERT INTO DEPOSIT VALUES (4,'Z34', 20)
INSERT INTO DEPOSIT VALUES (5,'A13', 645)
INSERT INTO DEPOSIT VALUES (6,'L12', 305)
INSERT INTO DEPOSIT VALUES (7,'Z34', 20)

CREATE TABLE PRODUCT
( pid INT PRIMARY KEY NOT NULL,
ptid INT FOREIGN KEY REFERENCES PRODUCT_TYPE(ptid),
deid INT FOREIGN KEY REFERENCES DEPOSIT(deid),
creation_date date,
expiry_date date,
weight int)

INSERT INTO PRODUCT VALUES(1,1,5,'2022-jan-05', '2024-jan-05', 100)
INSERT INTO PRODUCT VALUES(2,2,4,'2022-feb-15', '2024-feb-15', 200)
INSERT INTO PRODUCT VALUES(3,5,7,'2021-jan-25', '2023-jan-25', 100)
INSERT INTO PRODUCT VALUES(4,6,6,'2022-sep-10', '2025-sep-10', 280)
INSERT INTO PRODUCT VALUES(5,3,7,'2023-aug-01', '2026-aug-01', 300)
INSERT INTO PRODUCT VALUES(6,2,5,'2020-dec-26', '2024-dec-26', 800)
INSERT INTO PRODUCT VALUES(7,4,5,'2021-apr-20', '2025-apr-20', 600)
INSERT INTO PRODUCT VALUES(8,3,7,'2022-jul-23', '2025-jul-23', 500)
INSERT INTO PRODUCT VALUES(9,2,5,'2021-jan-24', '2024-jan-24', 100)
INSERT INTO PRODUCT VALUES(10,6,7,'2022-feb-23', '2026-feb-23', 360)

CREATE TABLE SALES
(  ssid INT PRIMARY KEY NOT NULL,
pid INT FOREIGN KEY REFERENCES PRODUCT(pid),
eid INT FOREIGN KEY REFERENCES EMPLOYEE(eid),
initial_price int)

INSERT INTO SALES VALUES(1,2,7,100)
INSERT INTO SALES VALUES(2,3,8,200)
INSERT INTO SALES VALUES(3,1,2,50)
INSERT INTO SALES VALUES(4,10,5,256)
INSERT INTO SALES VALUES(5,10,7,300)
INSERT INTO SALES VALUES(6,9,2,314)
INSERT INTO SALES VALUES(7,3,3,650)
INSERT INTO SALES VALUES(8,1,1,320)
INSERT INTO SALES VALUES(9,8,6,110)
INSERT INTO SALES VALUES(10,6,4,142)

CREATE TABLE CUSTOMER
( cid INT PRIMARY KEY NOT NULL,
name varchar(50) not null,
date_of_birth date,
cnp varchar(50) not null)


INSERT INTO CUSTOMER VALUES(1,'James', '2000-apr-25', '5864125489563')
INSERT INTO CUSTOMER VALUES(2,'Robert', '1985-jan-02', '2154698564824')
INSERT INTO CUSTOMER VALUES(3,'Paula', '1988-feb-06', '1465823945876')
INSERT INTO CUSTOMER VALUES(4,'Rae', '2002-dec-30', '6523495625486')
INSERT INTO CUSTOMER VALUES(5,'Cara', '2005-jul-26', '354854635468')
INSERT INTO CUSTOMER VALUES(6,'Marie', '2004-jun-09', '5463258745965')
INSERT INTO CUSTOMER VALUES(7,'Kylie', '1995-jun-04', '1568453284591')
INSERT INTO CUSTOMER VALUES(8,'Will', '2001-may-26', '1254896584265')
INSERT INTO CUSTOMER VALUES(9,'Billy', '1984-jan-16', '2548965845965')
INSERT INTO CUSTOMER VALUES(10,'Amy', '2008-feb-14', '1549856328457')

CREATE TABLE TELEPHONE
(
    tid INT,
    prefix VARCHAR(20) NOT NULL,
    cid INT,
    number VARCHAR(50) NOT NULL,
    phone_company VARCHAR(50) NOT NULL,
    PRIMARY KEY (tid, prefix),
    FOREIGN KEY (cid) REFERENCES CUSTOMER(cid)
)

INSERT INTO TELEPHONE VALUES(1,'RO',1,'0745856956', 'Orange')
INSERT INTO TELEPHONE VALUES(2,'UK',2,'0764235698', 'Orange')
INSERT INTO TELEPHONE VALUES(3,'UK',3,'0744123654', 'Telekom')
INSERT INTO TELEPHONE VALUES(4,'RO',4,'0723541289', 'Digi')
INSERT INTO TELEPHONE VALUES(5,'AL',5,'0747885102', 'Orange')
INSERT INTO TELEPHONE VALUES(6,'HU',6,'0775648823', 'Digi')
INSERT INTO TELEPHONE VALUES(7,'HU',7,'0796526330', 'Digi')
INSERT INTO TELEPHONE VALUES(8,'RO',8,'0741258963', 'Telekom')
INSERT INTO TELEPHONE VALUES(9,'RM',9,'0785112056', 'Digi')
INSERT INTO TELEPHONE VALUES(10,'IS',10,'0744812546', 'Orange')


CREATE TABLE PURCHASES
( prid INT PRIMARY KEY NOT NULL,
pid INT FOREIGN KEY REFERENCES PRODUCT(pid),
cid INT FOREIGN KEY REFERENCES CUSTOMER(cid),
final_price int,
discount_applied varchar(5))

INSERT INTO PURCHASES VALUES(1,2,7,250, 'no')
INSERT INTO PURCHASES VALUES(2,9,5,100, 'yes')
INSERT INTO PURCHASES VALUES(3,4,6,205, 'no')
INSERT INTO PURCHASES VALUES(4,3,1,50,'yes')
INSERT INTO PURCHASES VALUES(5,8,8,600,'no')
INSERT INTO PURCHASES VALUES(6,6,4,480,'yes')
INSERT INTO PURCHASES VALUES(7,7,4,500,'no')
INSERT INTO PURCHASES VALUES(8,9,9,150,'yes')
INSERT INTO PURCHASES VALUES(9,6,1,100,'yes')
INSERT INTO PURCHASES VALUES(10,1,9, 412, 'no')

-- this is an example of inserting something wrong:
INSERT INTO PURCHASES VALUES(15,20,200,'yes')

-- modify:
UPDATE PRODUCT
SET weight = 50
WHERE ptid = 3 OR deid = 7
SELECT * FROM PRODUCT

UPDATE PURCHASES
SET discount_applied = 'yes'
WHERE final_price>=300 AND pid >3
SELECT * FROM PURCHASES

UPDATE SALES
SET initial_price = 70
WHERE eid IN (7,8)
SELECT * FROM SALES

-- delete:
DELETE FROM TELEPHONE
WHERE number LIKE '0744%'
SELECT * FROM TELEPHONE

DELETE FROM PURCHASES
WHERE final_price IS NOT NULL AND cid BETWEEN 8 AND 10

-- 2.a)
SELECT * FROM PURCHASES
WHERE discount_applied = 'yes' OR final_price < 300

SELECT * FROM PURCHASES
WHERE pid < 5
UNION
SELECT * FROM PURCHASES
WHERE final_price < 500
ORDER BY pid 

-- 2.b)
SELECT * FROM CUSTOMER
WHERE name like 'R%'
INTERSECT
SELECT * FROM CUSTOMER
WHERE date_of_birth > '2000-01-01'

SELECT * FROM DEPARTMENT
WHERE did IN (3,4,5)

-- 2.c)
SELECT * FROM CUSTOMER
WHERE NAME like 'R%'
EXCEPT
SELECT * FROM CUSTOMER
WHERE date_of_birth > '2000-01-01'

SELECT * FROM DEPARTMENT
WHERE did NOT IN (1,2)

-- 2.d)
-- joining three tables:
SELECT * FROM EMPLOYEE e 
INNER JOIN DEPARTMENT d ON d.did = e.did
INNER JOIN POSITION p on p.oid = e.oid

SELECT DISTINCT p.weight FROM PRODUCT p
LEFT JOIN PRODUCT_TYPE t ON t.ptid = t.ptid
WHERE hair_type = 'curly hair'


SELECT * FROM PRODUCT p
RIGHT JOIN DEPOSIT d ON d.deid = p.deid
WHERE d.nr_products > 300

-- joining 2 many-to-many tables
SELECT * FROM SALES s
FULL JOIN PURCHASES p on s.pid = p.pid
WHERE s.pid > 5 and final_price is NOT NULL
ORDER BY eid

-- 2.e)
SELECT * FROM PRODUCT
WHERE pid IN (SELECT DISTINCT pid FROM SALES)

SELECT * FROM PRODUCT
WHERE pid IN (
    SELECT pid FROM SALES
    WHERE initial_price = (SELECT MAX(initial_price) FROM SALES)
)

-- 2. f)
SELECT TOP 3 d.name FROM DEPOSIT d
WHERE EXISTS(SELECT 1 FROM PRODUCT p WHERE d.deid = p.deid)

SELECT TOP 2 e.name FROM EMPLOYEE e
WHERE EXISTS(SELECT 1 FROM DEPARTMENT d WHERE d.did = e.did)

-- 2.g)
SELECT DISTINCT p.final_price, p.discount_applied, c.cnp FROM PURCHASES p INNER JOIN CUSTOMER c 
ON p.cid = c.cid
WHERE c.cnp LIKE '5%'

SELECT t.number, c.name FROM TELEPHONE t INNER JOIN CUSTOMER c
ON c.cid = t.cid
WHERE t.phone_company LIKE 'D%'

-- 2.h)
SELECT p.pid, AVG(pr.final_price*2+6)
FROM PRODUCT p
INNER JOIN PURCHASES pr ON p.pid = pr.pid
GROUP BY p.pid

SELECT p.pid, AVG(s.initial_price)
FROM PRODUCT p
INNER JOIN SALES s ON s.pid = p.pid
GROUP BY p.pid
HAVING AVG(s.initial_price) > 100

SELECT p.ptid, AVG(p.weight), pt.hair_type
FROM PRODUCT p
INNER JOIN PRODUCT_TYPE pt ON p.ptid = pt.ptid
GROUP BY p.ptid, pt.hair_type
HAVING pt.hair_type = 'curly hair' AND AVG(p.weight) >= (SELECT MIN(weight) FROM PRODUCT)

SELECT e.oid, AVG(e.salary/2), p.role
FROM EMPLOYEE e
INNER JOIN POSITION p ON e.oid = p.oid
GROUP BY e.oid, p.role
HAVING p.role = 'staff' AND AVG(e.salary/2) >= (SELECT MAX(salary) / 3 FROM EMPLOYEE)

-- 2.i)
SELECT p.weight FROM PRODUCT p
WHERE p.weight > ALL(SELECT p1.weight FROM PRODUCT p1 WHERE p1.pid = p.pid)

SELECT p.weight FROM PRODUCT p
WHERE p.weight > (SELECT MAX(p1.weight) FROM PRODUCT p1 WHERE p1.pid = p.pid)

SELECT d.nr_products FROM DEPOSIT d
WHERE d.nr_products < ANY(SELECT d1.nr_products FROM DEPOSIT d1 WHERE d1.deid = d.deid)

SELECT d.nr_products FROM DEPOSIT d
WHERE d.nr_products < (SELECT MIN(d1.nr_products) FROM DEPOSIT d1 WHERE d1.deid = d.deid)

SELECT e.salary FROM EMPLOYEE e
WHERE e.salary <>ALL(SELECT e1.salary FROM EMPLOYEE e1 WHERE e1.eid = e.eid)

SELECT e.salary FROM EMPLOYEE e
WHERE e.salary NOT IN(SELECT e1.salary FROM EMPLOYEE e1 WHERE e1.eid = e.eid)

SELECT (p.final_price*2+3) FROM PURCHASES p
WHERE p.final_price = ANY(SELECT p1.final_price FROM PURCHASES p1 WHERE p1.prid = p.prid)

SELECT p.final_price FROM PURCHASES p
WHERE p.final_price IN(SELECT p1.final_price FROM PURCHASES p1 WHERE p1.prid = p.prid)