--use db;

--CREATE TABLE SALES(

--salesman_id int primary key,
--name varchar(20),
--city varchar(20),
--commission float
--);

--INSERT INTO SALES VALUES(1,'jameshong','Newyork',0.15),
--(2,'Nail hong','Paris',0.13),
--(3,'Pit Alex','London',0.11),
--(4,'Mc Lyon','Paris',0.14),
--(5,'Paul Adam','Rome',0.13),
--(6,'Lauson Hen','San Jose',0.12);

--Select * from SALES;

create view Newyorker 
as
select * from SALES where city='Newyork'

select * from Newyorker;


create view AllSales 
as
select * from SALES;

select * from AllSales;

select name,city from SALES;
select * from citynum;

CREATE VIEW citynum
AS SELECT city, COUNT (DISTINCT salesman_id) as counted
FROM SALES
GROUP BY city;



CREATE TABLE Customer(
cust_id int primary key,
name varchar(20),
city varchar(20),
grade int,
salesman_id int
FOREIGN KEY (salesman_id) REFERENCES SALES(salesman_id) 
);

INSERT INTO Customer VALUES(1,'jameshong','Newyork',100,2),
(2,'Nail hong','Paris',200,4),
(3,'Pit Alex','London',100,3),
(4,'Mc Lyon','Paris',300,5),
(5,'Paul Adam','Rome',200,6),
(6,'Lauson Hen','San Jose',100,1);

select * from Customer

CREATE VIEW gradecount (grade, number)
AS SELECT grade, COUNT(*)
FROM customer
GROUP BY grade;
select * from gradecount;


CREATE TABLE Orders(
ord_no int primary key,
amount float,
ord_date date,
cust_id int,
salesman_id int
FOREIGN KEY (cust_id) REFERENCES Customer(cust_id) 
);

INSERT INTO Orders VALUES
(2,300,'2012-12-12',3,2),
(3,1300,'2012-12-12',4,3),
(4,4300,'2012-12-12',5,4),
(5,5300,'2012-12-12',6,5),
(6,5360,'2012-12-12',1,6);

CREATE VIEW ordering
AS SELECT ord_no, amount, o.salesman_id, c.name
FROM Orders o, Customer c, SALES s
WHERE o.cust_id = c.cust_id
AND o.salesman_id = s.salesman_id;

select * from ordering;