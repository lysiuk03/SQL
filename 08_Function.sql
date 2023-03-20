------------------------------
create function Hello(@name varchar(max))
returns varchar(max)
as
begin
  return 'Hello, '+@name+'!';
end

print dbo.Hello('Vika')

drop function dbo.Hello
------------------------------
create function GetCurrentMinutes()
returns int
as
begin 
     return DATEPART(mi, GETDATE())
end

print dbo.GetCurrentMinutes()

drop function dbo.GetCurrentMinutes
------------------------------
create function GetCurrentYear()
returns int
as
begin
     return YEAR(GETDATE());
end

print dbo.GetCurrentYear()

drop function dbo.GetCurrentYear
------------------------------
create function EvenCurrentYear()
returns varchar(max)
as
begin
declare @year int=YEAR(GETDATE());
if(@year%2=0)
     return 'Year is even!';
if(@year%2<>0)
	 return 'Year is not even!';
return 'Eror!';
end

print dbo.EvenCurrentYear()

drop function dbo.EvenCurrentYear
------------------------------
create function PrimeNumber(@number int)
returns varchar(3)
as
begin
declare @n int;
set @n=@number-1;
	while(@n>1)
	begin
	if(@number%@n=0)
		return 'No'
	set @n=@n-1;
	end
	return 'Yes'
end

print dbo.PrimeNumber(37)
print dbo.PrimeNumber(36)

drop function dbo.PrimeNumber
------------------------------
create function SumMinMux(@n1 int,@n2 int,@n3 int,@n4 int,@n5 int)
returns int
as
begin
 declare @tab table
 (
 Id int primary key identity,
 Numbers int not null
 )
 insert into @tab(Numbers)
 values(@n1),(@n2),(@n3),(@n4),(@n5)
 declare @min int;
 select @min=MIN(Numbers)from @tab;
 declare @max int;
 select @max=MAX(Numbers)from @tab;
 return @min+@max
end

print dbo.SumMinMux(1,2,3,4,5)

drop function dbo.SumMinMux
------------------------------
create function EvenOrNot(@start int,@finish int, @ev bit)
returns varchar(max)
as
begin
declare @str varchar(max)=' ';
if(@ev=1)
begin
while(@start<=@finish)
begin
if(@start%2=0)
set @str=@str+convert(varchar(max),@start)+' ';
set @start+=1
end
end
else
begin
while(@start<=@finish)
begin
if(@start%2<>0)
set @str=@str+convert(varchar(max),@start)+' ';
set @start+=1
end
end
return @str
end

print dbo.EvenOrNot(3,13,1)
print dbo.EvenOrNot(3,13,0)

drop function dbo.EvenOrNot
------------------------------
