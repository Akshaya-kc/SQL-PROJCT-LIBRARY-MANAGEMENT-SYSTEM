CREATE DATABASE LIBRARY;
USE LIBRARY;
CREATE table BRANCH(BRANCH_NO INT PRIMARY KEY,MANAGER_ID INT,BRANCH_ADDRESS VARCHAR(30),CONTACT_NO  varchar(15));
CREATE TABLE EMPLOYEE(EMP_ID INT primary key,EMP_NAME varchar(20),POSITION varchar(20),SALARY INT(10),Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));
create table BOOKS(ISBN varchar(10) primary key,BOOK_TITLE varchar(30),CATEGORY varchar(30),RENTAL_PRICE INT,STATUS CHAR(3),
AUTHOR VARCHAR(20),PUBLISHER VARCHAR(30));
create table CUSTOMER(CUSTOMER_ID INT primary key,CUSTOMER_NAME varchar(20),CUSTOMER_ADDRESS varchar(30),REG_DATE date);
create table ISSUE_STATUS(ISSUE_ID INT primary key,ISSUED_CUST INT,ISSUED_BOOKNAME VARCHAR(20),ISSUED_DATE DATE,ISBN_BOOK VARCHAR(10),
foreign key (ISSUED_CUST) REFERENCES CUSTOMER(CUSTOMER_ID),foreign key (ISBN_BOOK) references BOOKS(ISBN));
create table RETURN_STATUS(RETURN_ID INT primary key,RETURN_CUST VARCHAR(20),RETURN_BOOK_NAME varchar(20),RETURN_DATE DATE,ISBN_BOOK2 VARCHAR(10),
foreign key (ISBN_BOOK2)references BOOKS(ISBN));
ALTER TABLE RETURN_STATUS MODIFY COLUMN RETURN_BOOK_NAME VARCHAR(30);
ALTER TABLE ISSUE_STATUS MODIFY COLUMN ISSUED_BOOKNAME VARCHAR(30);
SELECT * FROM EMPLOYEE;
DESC ISSUE_STATUS;
INSERT INTO BRANCH VALUES(1,11,'REGEL_CHENNAI','9898989898'),(2,120,'KEDAR_NALLUR','2365252');
INSERT INTO BRANCH VALUES(3,1,'KOZHIKODE','6598326598'),(4,2,'MALAPPURAM','2525659832');
insert INTO  EMPLOYEE VALUES(1,'RAM','MANAGER',52000,1),(2,'KITH','ASSISTANT',32000,1),(3,'NIK','MANAGER',45000,1),(4,'KIRTI','CLEANING_STAFF',25000,2),
(5,'BINU','WATCH_MAN',25000,3),(6,'NIKKI','ASSISTANT',30000,4);
INSERT INTO BOOKS VALUES('ISBN11','FUNDAMENTALS OF MATHEMATICS','MATHEMATICS',20,'YES','NICK','VM PUBLISHERS'),('ISBN4','RANDAMOOZHAM','NOVEL',15,'NO','MT VASUDEVAN NAIR','RR PUBLISHERS'),
('ISBN5','TWO STATES','FICTION',12,'YES','CHETHAN BAGAT','N HOUSE');
INSERT INTO BOOKS VALUES('ISBN21','FUNDAMENTALS OF BIOLOGY','BIOLOGY',20,'NO','KIN','KIN PUBLISHERS');

INSERT INTO CUSTOMER VALUES(1,'NIMA','NIMA_CHENNAI','2024-6-3'),(2,'KARUN','K HOUSE KOZHIKODE','2024-9-5');
INSERT INTO CUSTOMER VALUES(3,'NIRMAL','NA_CHENNAI','2021-6-3');
INSERT INTO ISSUE_STATUS VALUES(1,1,'RANDAMOOZHAM','2024-6-3','ISBN4'),(2,2,'FUNDAMENTALS OF BIOOGY','2024-9-5','ISBN21');
INSERT INTO RETURN_STATUS VALUES(1,2,'FUNDAMENTALS OF BIOLOGY','2024-9-15','ISBN21'),(2,1,'RANDAMOOZHAM','2024-6-25','ISBN4');
#1
SELECT BOOK_TITLE,CATEGORY,RENTAL_PRICE FROM BOOKS WHERE  STATUS='YES';
#2
SELECT EMP_NAME,SALARY FROM EMPLOYEE order by SALARY DESC;
#3
 SELECT B.BOOK_TITLE, C.CUSTOMER_NAME
FROM ISSUE_STATUS I
INNER JOIN BOOKS B ON I.ISBN_BOOK = B.ISBN
INNER JOIN CUSTOMER C ON I.ISSUED_CUST = C.CUSTOMER_ID;


#4
select CATEGORY,count(ISBN) FROM BOOKS  group by CATEGORY;
#5
SELECT EMP_NAME,POSITION,SALARY FROM EMPLOYEE WHERE SALARY>50000;
#6
SELECT CUSTOMER_NAME FROM CUSTOMER WHERE REG_DATE<'2022-01-01' AND CUSTOMER_ID NOT IN (  SELECT ISSUED_CUST FROM ISSUE_STATUS);
#7
SELECT BRANCH_NO, COUNT(EMP_ID) AS Total_Employees FROM EMPLOYEE group by  BRANCH_NO;

#8
SELECT  C.CUSTOMER_NAME
FROM ISSUE_STATUS I 
JOIN CUSTOMER C ON I.ISSUED_CUST = C.CUSTOMER_ID
WHERE MONTH(I.ISSUED_DATE) = 6 AND YEAR(I.ISSUED_DATE) = 2024;

#9
SELECT BOOK_TITLE FROM BOOKS WHERE BOOK_TITLE LIKE '%BIOLOGY%';

#10
SELECT BRANCH_NO, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY BRANCH_NO
HAVING COUNT(*) > 2;

#11

SELECT E.Emp_name, B.Branch_address,B.BRANCH_NO
FROM Employee E
INNER JOIN Branch B ON E.BRANCH_NO = B.BRANCH_NO WHERE E.POSITION='MANAGER';

#12
SELECT  C.CUSTOMER_NAME,B.RENTAL_PRICE
FROM ISSUE_STATUS I
INNER JOIN BOOKS B ON I.ISBN_BOOK = B.ISBN
JOIN CUSTOMER C ON I.ISSUED_CUST = C.CUSTOMER_ID
WHERE B.RENTAL_PRICE > 10;
