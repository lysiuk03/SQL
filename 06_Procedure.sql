
------------------------------
create procedure Hello
as
	print 'Hello World!';

execute Hello;

drop procedure Hello;
------------------------------
create proc GetTimeNow
@time varchar(5) output
as
 select @time=convert(varchar(5),CONVERT (time, GETDATE()))

 declare @time varchar(5);
 exec GetTimeNow @time output
 select @time as 'Time now'

 drop procedure GetTimeNow;
------------------------------
create proc GetDateNow
@date varchar(10) output
as
	select @date=convert(varchar(10),CONVERT (date, GETDATE()))

 declare @date varchar(10);
 exec GetDateNow @date output
 select @date as 'Date now'

 drop procedure GetDateNow;
------------------------------
create proc NumbSum
@n1 int,
@n2 int,
@n3 int,
@sum int output
as
	set @sum = @n1+ @n2+ @n3;

 declare @sum int;
 exec NumbSum 3,3,3, @sum output;
 select @sum as 'Sum of numbers'

 drop procedure NumbSum;
------------------------------
create proc NumbAvg
@n1 float,
@n2 float,
@n3 float,
@avg float output
as
	set @avg = (@n1+ @n2+ @n3)/3;
	
 declare @avg float;
 exec NumbAvg 3,1,1, @avg output;
 select @avg as 'Avg of numbers'

 drop procedure NumbAvg;
------------------------------
create proc NumbMax
@n1 int,
@n2 int,
@n3 int,
@max int output
as
if(@n1>@n2 and @n1>@n3)
	set @max = @n1;
if(@n2>@n1 and @n2>@n3)
	set @max = @n2;
if(@n3>@n2 and @n3>@n1)
	set @max = @n3;
	
 declare @max int;
 exec NumbMax 3,4,8, @max output;
 select @max as 'Max of numbers'

 drop procedure NumbMax;
------------------------------
create proc NumbMin
@n1 int,
@n2 int,
@n3 int,
@min int output
as
if(@n1<@n2 and @n1<@n3)
	set @min = @n1;
if(@n2<@n1 and @n2<@n3)
	set @min = @n2;
if(@n3<@n2 and @n3<@n1)
	set @min = @n3;
	
 declare @min int;
 exec NumbMin 3,4,8, @min output;
 select @min as 'Min of numbers'

 drop procedure NumbMin;
------------------------------
create proc PrintLine
@number int,
@sumbol char,
@res varchar(max)=''
as
while(@number>0)
begin
set @res= @res+@sumbol;
set @number-=1;
end
print @res;
 
exec PrintLine 6,'#';

drop procedure PrintLine;
------------------------------
create proc Factoryal
@number int,
@res int output
as
if(@number>=1)
set @res=1;
while(@number>1)
begin
set @res=@res*@number;
set @number-=1;
end

declare @res int;
exec Factoryal 3, @res output;
select @res as 'Factoryal'

drop procedure Factoryal;
------------------------------
create proc PowerNumb 
@a int,
@b int,
@res int output
as
set @res=power(@a,@b);

declare @res int;
exec PowerNumb 3,2, @res output;
select @res as 'Power number'

drop procedure PowerNumb;
------------------------------
