use ORG;

create synonym work for Worker



CREATE VIEW Work_View 
as 
select * from Worker where SALARY>80000;





create view bonused 
as
select * from Worker as wo inner join Bonus as b on wo.WORKER_ID = b.WORKER_REF_ID;



CREATE SEQUENCE sequence_1
start with 1
increment by 1
minvalue 0
maxvalue 100
cycle;

CREATE TABLE students
( 
ID int,
NAME char(20)
);

INSERT into students VALUES(NEXT VALUE FOR sequence_1,'Ramesh');
INSERT into students VALUES(NEXT VALUE FOR sequence_1,'Suresh');



create clustered index ind_Named on students(NAME);

select * from work;
SELECT * FROM students;

select * from Worker

SELECT * FROM Worker where LEN(FIRST_NAME)> 6;


SELECT SUM(SALARY) AS Total FROM Worker;


select * from bonused;
SELECT MAX(SALARY) as maxi from Worker;
SELECT * FROM Work_View;

 SELECT DAY(JOINING_DATE) AS DayOfMonth from Worker;