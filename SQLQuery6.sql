use db;

CREATE TABLE SALE(

salesman_id int primary key,
name varchar(20),
city varchar(20),
commission float,
sales_done int
);

INSERT INTO SALE VALUES(1,'jameshong','Newyork',0.15,200),
(2,'Nail hong','Paris',0.13,300),
(3,'Pit Alex','London',0.11,400),
(4,'Mc Lyon','Paris',0.14,100),
(5,'Paul Adam','Rome',0.13,230),
(6,'Lauson Hen','San Jose',0.12,450);

select * from sale

create function grossing(@salesman_id int,@pname varchar(20))
returns float
as
begin
declare @basic int,@com float,@grossed float
select @basic=sales_done, @com=commission from SALE where salesman_id=@salesman_id and name = @pname
set @grossed = @basic * @com
return @grossed
end

select dbo.grossing(1,'jameshong');
select dbo.grossing(2,'Nail hong');


select * from SALE

create procedure count_higher_sale
as
Begin
	select * from SALE where sales_done >150;
end


exec count_higher_sale;

create procedure total_emp(@totalemp int OUTPUT)
as
Begin
	Select @totalemp=count(salesman_id) from SALE
End

Declare @Result int
exec total_emp @Result OUTPUT 
Print @Result


create trigger restrict_dml_time
on SALE
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	if((DATEPART(HOUR,GETDATE()) between 18 and 24)
	  or
	  (DATEPART(HOUR,GETDATE()) between 0 and 9)
	  )
	  begin 
	  print 'You cannot insert into the demo table'
	  rollback
	  end
end

drop trigger restrict_dml_time

delete from SALE where salesman_id=4

create trigger trg_DDL_AllDB
on ALL Server
For Create_Table,Alter_Table,Drop_Table
as
Begin
	Print 'You cannot perform DDL on any Database'
	Rollback Transaction
End

drop trigger trg_DDL_AllDB

create table new_tab(
id int );


disable trigger restrict_dml_time on SALE;


use ORG;



BEGIN TRANSACTION
	insert into students values (3,' HenRY');
	delete from students where ID=1;
COMMIT TRANSACTION


BEGIN TRANSACTION
	insert into students values(4 ,'Anna'),(6 ,'Haye'),(1 ,'Siye');
	SAVE TRANSACTION insert_stmt
	delete from students where ID=2;
	ROLLBACK TRANSACTION insert_stmt
COMMIT TRANSACTION

create procedure DivideByZero
@num1 int,
@num2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	IF(@num2=0)
	BEGIN
		RAISERROR('Cannot Divide By Zero',16,127)
	END
	ELSE
	BEGIN
		SET @Result=@num1/@num2
		PRINT 'Value is:' + CAST(@Result as varchar)
	END
END

EXEC DivideByZero 10,5 

EXEC DivideByZero 10,0

drop procedure DivideByZeroTryCatch

create procedure DivideByZeroTryCatch
@num1 int,
@num2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	BEGIN TRY
		BEGIN
			IF(@num2=0)
			THROW 11500 ,'Cannot Divide By Zero',1 
			SET @Result=@num1/@num2
			PRINT 'Value is:' + CAST(@Result as varchar)
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
		PRINT ERROR_SEVERITY()
		PRINT ERROR_STATE()		
	END CATCH
END

EXEC DivideByZeroTryCatch 10,5 

EXEC DivideByZeroTryCatch 10,0

select * from students