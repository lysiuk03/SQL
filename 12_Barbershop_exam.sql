--drop database Barber_shop
create database Barber_shop
go
use  Barber_shop
go
/*TABLES*/--можна запускати одразу всі
create table  Positions 
(
ID int primary key identity ,
Name nvarchar(100) not null unique check(Name <> '')
)
go
create table Rating
(
ID int primary key identity ,
Mark nvarchar(100) not null unique check(Mark <> '')
)
go
create table Services 
(
ID int primary key identity , 
Name nvarchar(100) not null unique check(Name <> ''),
Price money not null check(Price>0),
Duration time not null  check(Duration between '00:00' AND '4:00'),
)
go
create table Barbers 
(
ID int primary key identity , 
Name nvarchar(100) not null check(Name <> ''),
Surname nvarchar(100) not null check(Surname <> ''),
Lastname nvarchar(100) not null check(Lastname <> ''),
Gender nvarchar(10) not null check(Gender <> ''),
Phone nvarchar(16) not null unique check(Phone <> ''),
Email nvarchar(50) not null unique check(Email <> ''),
Datebirthday datetime not null check(Datebirthday<GetDate()),
HireDate datetime not null default(GetDate()) check(HireDate<=GetDate()),
PositionId int not null references Positions(Id)
)
go
create table ServicesBarbers 
(
--ID int primary key identity ,
BarberId int not null references Barbers(Id),
ServiceId int not null references Services(Id),
primary key(BarberId,ServiceId)
)
go
create table Clients 
(
ID int primary key identity ,
Name nvarchar(100) not null check(Name <> ''),
Surname nvarchar(100) not null check(Surname <> ''),
Lastname nvarchar(100) not null check(Lastname <> ''),
Phone nvarchar(16) not null unique check(Phone <> ''),
Email nvarchar(50) not null unique check(Email <> '')
)
go
create table Feedbacks 
(
ID int primary key identity ,
Message nvarchar(300) null,
RatingId int not null references Rating(Id),
BarberId int not null references Barbers(Id),
ClientId int not null references Clients(Id),
)
go
create table Shedule --Розклад ВІЛЬНО-ЗАЙНЯТО
(
ID int primary key identity ,
BarberId int not null references Barbers(Id),
DayOfWeek int not null check(DayOfWeek between 1 AND 7),
StartTime time not null check(StartTime between '8:00' AND '18:00'),
EndTime time not null,
Free nvarchar(3) not null default('Yes'),
check(EndTime>StartTime)
)
go
create table Orders --Запис на дату та час конкретного клієнта
(
ID int primary key identity ,
BarberId int not null references Barbers(Id),
ClientId int not null references Clients(Id),
DayOfWeek int not null check(DayOfWeek between 1 AND 7),
StartTime time not null check(StartTime between '8:00' AND '18:00'),
EndTime time not null,
check(EndTime>StartTime)
)
go

create table Archive 
(
ID int primary key identity ,
ClientId int not null references Clients(Id),
BarberId int not null references Barbers(Id),
ServiceId int not null references Services(Id),
Dates date not null default(GetDate()) check(Dates<=GetDate()),
FeedbackId int  null default(Null)  references Feedbacks(Id),
RatingId int  null  default(Null) references  Rating(Id)
)
go

/*РОЗКЛАД ТА ЗАПИС*/
create trigger shedule_add_order --Бронює місце в розкладі
on Orders
after insert
as
UPDATE Shedule
SET Free='No'
WHERE ID=(select top 1 S.ID
		from inserted as i JOIN Barbers as b ON i.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where i.DayOfWeek=s.DayOfWeek and i.StartTime=s.StartTime);
UPDATE Shedule
SET Free='No'
WHERE ID=(select top 1 s.ID
		from inserted as i JOIN Barbers as b ON i.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where i.DayOfWeek=s.DayOfWeek and i.EndTime=s.EndTime) ;
UPDATE Shedule
SET Free='No'
WHERE Id >(select top 1 S.ID
		from inserted as i JOIN Barbers as b ON i.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where i.DayOfWeek=s.DayOfWeek and i.StartTime=s.StartTime) and Id<(select top 1 s.ID
		from inserted as i JOIN Barbers as b ON i.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where i.DayOfWeek=s.DayOfWeek and i.EndTime=s.EndTime)
--drop trigger shedule_add_order 
create trigger shedule_del_order --Звільняє місце в розкладі
on Orders
after delete
as
UPDATE Shedule
SET Free='Yes'
WHERE ID=(select top 1 S.ID
		from deleted as d JOIN Barbers as b ON d.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where d.DayOfWeek=s.DayOfWeek and d.StartTime=s.StartTime);
UPDATE Shedule
SET Free='Yes'
WHERE ID=(select top 1 s.ID
		from deleted as d JOIN Barbers as b ON d.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where d.DayOfWeek=s.DayOfWeek and d.EndTime=s.EndTime);
UPDATE Shedule
SET Free='Yes'
WHERE id>(select top 1 S.ID
		from deleted as d JOIN Barbers as b ON d.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where d.DayOfWeek=s.DayOfWeek and d.StartTime=s.StartTime) and id<(select top 1 s.ID
		from deleted as d JOIN Barbers as b ON d.BarberId=b.ID
		JOIN Shedule as s ON s.BarberId=b.ID
		where d.DayOfWeek=s.DayOfWeek and d.EndTime=s.EndTime)
--drop trigger shedule_del_order

--Подивитись розклад певного барбера в певний день--
create function BarbDayShedule(@id int, @day int)
 returns table
 as  
 return select StartTime,EndTime,Free from Shedule
	   where BarberId=@id and DayOfWeek=@day

select * from BarbDayShedule(1, 1)    
select * from BarbDayShedule(1, 2)
select * from BarbDayShedule(1, 3)
select * from BarbDayShedule(1, 4)
select * from BarbDayShedule(1, 5)

select* from orders

insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (2, 25,1, '10:00', '11:30');
select * from BarbDayShedule(2, 1)  

delete from Orders where Id=1
select * from orders


--drop function dbo.BarbDayShedule
/*FUNCTIONALITY*/--Завдання 2

--Повернути ПІБ всіх барберів салону--    
 create view AllBarbers
 as
 select b.Name+' '+b.Surname+' '+b.Lastname as 'ПІБ'
 from Barbers as b 

 select* from AllBarbers
--drop view AllBarbers

--Повернути інформацію про всіх синьйор-барберів--      
 create view SeniorBarbers
 as
 select b.Name+' '+b.Surname+' '+b.Lastname as 'Синьйор-барбери', b.Gender,b.Email,b.Phone
 from Barbers as b JOIN Positions as p ON b.PositionId=p.ID
 where p.Name='Синьйор-барбер'

 select* from SeniorBarbers
--drop view SeniorBarbers

--Повернути інформацію про всіх барберів, які можуть надати послугу гоління бороди--     
 create view ShavBarbers
 as
 select b.Name+' '+b.Surname+' '+b.Lastname as 'ПІБ', b.Gender,b.Email,b.Phone
 from Barbers as b JOIN ServicesBarbers as sb ON sb.BarberId=b.ID
				  JOIN Services as s ON sb.ServiceId=s.ID
 where s.Name='Королівське гоління'

 select* from ShavBarbers
--drop view ShavBarbers

--Повернути інформацію про всіх барберів, які можуть надати конкретну послугу. Інформація про потрібну послугу надається як параметр.--  
 create function AllServBarbers(@name nvarchar(100))
 returns table
 as  
 return select b.Name+' '+b.Surname+' '+b.Lastname as 'ПІБ', b.Gender,b.Email,b.Phone
		from Barbers as b JOIN ServicesBarbers as sb ON sb.BarberId=b.ID
						  JOIN Services as s ON sb.ServiceId=s.ID
		where s.Name=@name

 select * from dbo.AllServBarbers('Чоловіча стрижка')
 select * from dbo.AllServBarbers('Камуфляж')
--drop function dbo.AllServBarbers

--Повернути інформацію про всіх барберів, які працюють понад зазначену кількість років. Кількість років передається як параметр--     
 create function ExperienceBarbers(@years int)
 returns table
 as  
 return select b.Name+' '+b.Surname+' '+b.Lastname as 'ПІБ', b.Gender,b.Email,b.Phone
		from Barbers as b 
		where (select DATEDIFF(year, b.HireDate, GETDATE()))>@years
	
 select * from dbo.ExperienceBarbers(5)	
 select * from dbo.ExperienceBarbers(3)
 --drop function dbo.ExperienceBarbers

--Повернути кількість синьйор-барберів та кількість джуніор-барберів.--
 create function CountJunSen()
 returns table 
 as  
 return select   (select COUNT(p.Name) 
				  from Barbers as b JOIN Positions as p ON b.PositionId=p.ID
				  where p.Name='Джуніор-барбер') AS 'Джуніор-барберів', 
				 (SELECT COUNT(p.Name) 
				  from Barbers as b JOIN Positions as p ON b.PositionId=p.ID
				  where p.Name='Синьйор-барбер') AS 'Синьйор-барберів'

select * from dbo.CountJunSen()
--drop function dbo.CountJunSen  

--Повернути інформацію про постійних клієнтів. Критерій постійного клієнта: був у салоні задану кількість разів. Кількість передається як параметр.--
 create function RegularClients(@n int)
 returns table  
 as 
 return select c.Name+' '+c.Surname+' '+c.Surname as 'FullName', count(a.ClientId) as 'Count'
		from Archive as a JOIN Clients as c ON c.ID=a.ClientId
	    group by c.Name+' '+c.Surname+' '+c.Surname
	    having count(a.ClientId)>@n

 select * from dbo.RegularClients(5)		
--drop function RegularClients
 
--Заборонити можливість видалення інформації про чиф-барбер, якщо не додано другий чиф-барбер.--
create  trigger check_chief
on Barbers
FOR delete 
as
if exists (select PositionId from deleted except select PositionId from Barbers)
			
    begin
		raiserror('The Chief-barber is a must have!', 12, 1)
		rollback transaction;
	end;
  
insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Sheley', 'Jason', 'Floes', 'Female', '+380 37 7650008', 'sfloes0@wufoo.com', '8/25/1996', '3/30/2017', 1);

delete 
from Barbers 
where ID=6

delete 
from Barbers   /*Перевірити можна до створення references з 1 барбером*/
where ID=1

--drop trigger check_chief

--Заборонити додавати барберів молодше 21 року.--
create  trigger verif_age
on Barbers
after insert
as
if exists (select *
		   from inserted as i 
		   where (select DATEDIFF(year, i.Datebirthday, GETDATE()))<21)
    begin
		raiserror('Barber must be 21 years old!', 12, 1)
		rollback transaction;
	end;

insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Adamo', 'Capelen', 'Giorgini', 'Male', '+380 46 5364644', 'agiorgini0@com.com', '8/25/2003', '3/30/2017', 2);
insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Elmo', 'Enright', 'Veighey', 'Male', '+380 64 4745445', 'eveighey1@microsoft.com', '8/25/1996', '3/30/2017', 3);
--drop trigger verif_age

/*INSERT*/--можна запускати одразу всі
insert into Positions (Name) values ('Чиф-барбер'); 
insert into Positions (Name) values ('Синьйор-барбер');
insert into Positions (Name) values ('Джуніор-барбер');

insert into Rating (Mark) values ('Дуже погано');
insert into Rating (Mark) values ('Погано');
insert into Rating (Mark) values ('Нормально');
insert into Rating (Mark) values ('Добре');
insert into Rating (Mark) values ('Чудово');

insert into Services (Name, Price, Duration) values ('Чоловіча стрижка', 500, '1:00');
insert into Services (Name, Price, Duration) values ('Воскове видалення волосся', 200, '00:30');
insert into Services (Name, Price, Duration) values ('Корекція брів', 150, '00:30');
insert into Services (Name, Price, Duration) values ('Стрижка бороди та вус', 400, '00:30');
insert into Services (Name, Price, Duration) values ('Стрижка та стрижка бороди', 820, '01:30');
insert into Services (Name, Price, Duration) values ('Батько та син', 850, '01:30');
insert into Services (Name, Price, Duration) values ('Дитяча стрижка', 450, '00:30');
insert into Services (Name, Price, Duration) values ('Королівське гоління', 400, '00:30');
insert into Services (Name, Price, Duration) values ('Стрижка та гоління', 820, '01:30');
insert into Services (Name, Price, Duration) values ('Стрижка під насадку', 200, '00:30');
insert into Services (Name, Price, Duration) values ('Укладання волосся', 100, '01:00');
insert into Services (Name, Price, Duration) values ('Гоління голови та стрижка бороди', 720, '01:30');
insert into Services (Name, Price, Duration) values ('Камуфляж', 350, '00:30');
insert into Services (Name, Price, Duration) values ('Корекція стрижки', 300, '00:30');
insert into Services (Name, Price, Duration) values ('Корекція бороди', 300, '00:30');

insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Shelley', 'Jamson', 'Flores', 'Female', '+380 39 7655548', 'sflores0@wufoo.com', '8/25/1996', '3/30/2017', 1);
insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Stearne', 'Spinnace', 'Pavelka', 'Male', '+380 37 3685965', 'spavelka1@linkedin.com', '10/3/1998', '6/6/2019', 2);
insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Uriah', 'Daud', 'Tissell', 'Male', '+380 49 7567557', 'utissell2@whitehouse.gov', '11/2/2000', '8/23/2019', 2);
insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Caprice', 'Saxby', 'Cleare', 'Female', '+380 56 5840987', 'ccleare3@is.gd', '1/3/1999', '5/26/2020', 3);
insert into Barbers (Name, Surname, Lastname, Gender, Phone, Email, Datebirthday, HireDate, PositionId ) values ('Reggie', 'Ortells', 'Fullun', 'Female', '+380 45 8754754', 'rfullun4@tamu.edu', '1/4/2003', '1/01/2021', 3);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 1);
insert into ServicesBarbers (BarberId, ServiceId) values (2, 1);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 1);
insert into ServicesBarbers (BarberId, ServiceId) values (4, 1);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 1);

insert into ServicesBarbers (BarberId, ServiceId) values (4, 2);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 2);

insert into ServicesBarbers (BarberId, ServiceId) values (3, 3);
insert into ServicesBarbers (BarberId, ServiceId) values (4, 3);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 4);
insert into ServicesBarbers (BarberId, ServiceId) values (2, 4);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 4);
insert into ServicesBarbers (BarberId, ServiceId) values (4, 4);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 4);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 5);
insert into ServicesBarbers (BarberId, ServiceId) values (2, 5);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 5);
insert into ServicesBarbers (BarberId, ServiceId) values (4, 5);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 5);

insert into ServicesBarbers (BarberId, ServiceId) values (3, 6);
insert into ServicesBarbers (BarberId, ServiceId) values (4, 6);

insert into ServicesBarbers (BarberId, ServiceId) values (2, 7);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 7);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 8);
insert into ServicesBarbers (BarberId, ServiceId) values (2, 8);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 8);

insert into ServicesBarbers (BarberId, ServiceId) values (1,9);
insert into ServicesBarbers (BarberId, ServiceId) values (2,9);
insert into ServicesBarbers (BarberId, ServiceId) values (3,9);
insert into ServicesBarbers (BarberId, ServiceId) values (4,9);

insert into ServicesBarbers (BarberId, ServiceId) values (4, 10);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 10);

insert into ServicesBarbers (BarberId, ServiceId) values (2, 11);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 11);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 12);
insert into ServicesBarbers (BarberId, ServiceId) values (2, 12);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 12);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 13);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 14);
insert into ServicesBarbers (BarberId, ServiceId) values (2, 14);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 14);
insert into ServicesBarbers (BarberId, ServiceId) values (4, 14);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 14);

insert into ServicesBarbers (BarberId, ServiceId) values (1, 15);
insert into ServicesBarbers (BarberId, ServiceId) values (2, 15);
insert into ServicesBarbers (BarberId, ServiceId) values (3, 15);
insert into ServicesBarbers (BarberId, ServiceId) values (4, 15);
insert into ServicesBarbers (BarberId, ServiceId) values (5, 15);

insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Cherilynn', 'Ferby', 'Avieson', '+7 629 332 8102', 'cavieson5@bluehost.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Delmore', 'Johananoff', 'Matzel', '+94 793 679 9721', 'dmatzel6@hp.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Iseabal', 'Alishoner', 'Syrie', '+63 298 166 5337', 'isyrie7@mac.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Bart', 'Albrighton', 'Poncet', '+21 827 732 6537', 'bponcet8@webmd.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Norina', 'Tiptaft', 'Fry', '+86 390 618 0389', 'nfry9@blinklist.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Lynn', 'Percy', 'Brusby', '+63 783 145 1477', 'lbrusbya@intel.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Morey', 'Greensmith', 'Sagg', '+86 396 186 7526', 'msaggb@businessinsider.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Jamie', 'Yvens', 'Koppes', '+81 272 185 3014', 'jkoppesc@auda.org.au');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Forester', 'Stoyell', 'Mulliner', '+33 182 806 9579', 'fmullinerd@ameblo.jp');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Zelig', 'Darmody', 'Hallard', '+86 669 656 0946', 'zhallarde@godaddy.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Benita', 'Donizeau', 'Barrowclough', '+86 861 489 2713', 'bbarrowcloughf@samsung.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Fancy', 'Sor', 'Anstie', '+97 551 358 7128', 'fanstieg@photobucket.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Ozzie', 'McGilvary', 'Dowbekin', '+50 843 454 7283', 'odowbekinh@ucla.edu');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Loreen', 'Mioni', 'Welsby', '+22 587 802 3525', 'lwelsbyi@pbs.org');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Elston', 'Wooland', 'Ondrich', '+35 817 317 9975', 'eondrichj@cnn.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Gael', 'Considine', 'Tribbeck', '+97 597 260 8696', 'gtribbeckk@si.edu');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Elladine', 'Molden', 'Goby', '+86 962 105 8411', 'egobyl@noaa.gov');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Morley', 'Tolumello', 'Cockney', '+62 115 451 8213', 'mcockneym@tuttocitta.it');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Marianna', 'Whorf', 'Ciccarelli', '+86 795 728 0125', 'mciccarellin@alibaba.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Glynn', 'Splaven', 'Collimore', '+22 114 753 9606', 'gcollimoreo@ning.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Hersh', 'Maudsley', 'Byford', '+62 166 647 4425', 'hbyfordp@bloglines.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Dilly', 'Tupman', 'Arnhold', '+86 350 933 0266', 'darnholdq@jiathis.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Sarina', 'Ollington', 'Caneo', '+86 657 197 1856', 'scaneor@netscape.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Drusy', 'Phebey', 'Dudden', '+95 827 890 9185', 'dduddens@vistaprint.com');
insert into Clients (Name, Surname, Lastname, Phone, Email) values ('Marya', 'Wesker', 'Botton', '+60 369 577 1554', 'mbottont@reddit.com');

insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Good!', 5, 1, 1);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Not bad!', 3, 2, 2);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('OK!', 4, 3, 3);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Ok!', 3, 4, 4);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('WOW!', 5, 5, 5);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Super!', 5, 1,6);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 2, 7);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Wow!', 5,3,8);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Realy good!', 5, 4, 9);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Bed!', 3, 5, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Not bed!', 4, 1, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Not good!', 3, 2, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Like!', 5, 3, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Pretty!', 5, 4, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 5, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Good!', 5,1, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Like!', 5, 2, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Best!', 5, 3, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Realy like !', 5, 4, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Love!', 5, 5, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Love!', 5, 1, 11);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 2, 12);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Bed!', 3, 3, 13);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Oh!', 2, 4, 13);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Angry!', 3, 5, 13);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Cool!', 5, 1, 13);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Pretty!', 5, 2, 13);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 3, 13);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 4, 14);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Pretty!', 5, 5, 15);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 1, 16);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Cool!', 5, 2, 17);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 5, 3, 18);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 5,4, 19);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Angry!', 1, 5, 20);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 1, 20);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Cool!', 5, 2,20);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 5, 4, 20);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 5, 20);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 5, 1, 20);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Cool!', 5, 2, 20);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Pretty!', 5, 3, 21);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 4, 22);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Cool!', 5, 5, 23);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Bed!', 3, 1, 24);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Pretty!', 5, 2, 25);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Realy good!', 5, 3, 1);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 4, 1);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 5, 5, 2);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Pretty!', 5, 1, 3);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 4, 2, 4);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 4, 3, 5);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 4, 4,6);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 4, 5, 7);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Pretty!', 4, 1, 8);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values (' ', 4, 2, 9);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Great!', 5, 3, 10);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Realy good!', 5, 4, 11);
insert into Feedbacks (Message, RatingId, BarberId, ClientId) values ('Realy good!', 5, 5, 12);


insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 1, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 2, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 3, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 4, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (1, 5, '13:30', '14:00');

insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 1, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 2, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 3, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 4, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (2, 5, '13:30', '14:00');

insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 1, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 2, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 3, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 4, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (3, 5, '13:30', '14:00');

insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 1, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 2, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 3, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 4, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (4, 5, '13:30', '14:00');

insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 1, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 2, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 3, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 4, '13:30', '14:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '10:00', '10:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '10:30', '11:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '11:00', '11:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '11:30', '12:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '12:00', '12:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '12:30', '13:00');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '13:00', '13:30');
insert into Shedule (BarberId, DayOfWeek, StartTime, EndTime) values (5, 5, '13:30', '14:00');

insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1, 1,1, '10:00', '11:30');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,2,1, '12:00', '13:00');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,3,1, '13:30', '14:00');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,4,2, '10:30', '11:30');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,5,2, '12:00', '13:30');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,6,3, '11:00', '12:30');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,7,4, '12:30', '14:00');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,8,4, '10:00', '10:30');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,9,4, '11:00', '12:30');
insert into Orders (BarberId,ClientId,DayOfWeek,StartTime,EndTime) values (1,10,5, '12:00', '12:30');

insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (1, 1, 1, '3/14/2021', 1, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (2, 2,2, '4/12/2021',2, 3);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (3, 3, 1, '10/15/2021', 3, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (4, 4, 1, '2/18/2022', 4, 3);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (5, 5, 1, '1/5/2023', 5, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (6, 1, 1, '4/5/2022', 6, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (7, 2, 1, '7/30/2022', 7, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (8, 3, 1, '7/11/2022', 8, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (9, 4, 2, '6/3/2021', 9, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 5, 2, '10/24/2021', 10, 3);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10,1, 1, '5/23/2021', 11, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 2, 1, '8/3/2022', 12, 3);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 3, 3, '5/21/2022', 13, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 4, 3, '4/2/2021', 14, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 5, 2, '5/29/2022', 15, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10,1, 4, '6/3/2021', 16, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 2, 4, '6/16/2021', 17, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 3, 4, '11/12/2022', 18, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 4, 4, '4/9/2021', 19, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 5, 4, '6/5/2021', 20, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (11, 1, 4, '11/5/2021', 21, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (12, 2, 4, '10/16/2021', 22, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (13, 3, 4, '6/9/2022', 23, 3);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (13, 4, 4, '8/18/2021', 24, 2);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (13, 5, 4, '7/2/2022', 25, 3);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (13, 1, 5, '12/18/2021', 26, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (13, 2, 5, '4/5/2021', 27, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (13, 3, 5, '5/8/2022', 28,5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (14, 4, 5, '3/11/2022', 29, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (15, 5, 5, '1/15/2023', 30, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (16, 1, 5, '8/24/2021', 31, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (17, 2, 5, '5/3/2022', 32, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (18, 3, 5, '6/15/2022', 33, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (19, 4, 5, '1/6/2021', 34, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 5, 5, '3/22/2021', 35, 1);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 1, 1, '2/15/2021', 36, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 2, 1, '5/28/2021', 37, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 4, 6, '10/15/2022', 38, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 5, 1, '9/14/2022', 39, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 1, 1, '2/26/2022', 40, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 2, 7, '1/28/2022', 41, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (21, 3, 1, '5/25/2022', 42, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (22, 4, 1, '10/1/2021', 43, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (23, 5, 7, '8/21/2022', 44, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (24, 1, 8, '9/3/2022', 45, 3);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (25, 2, 8, '4/1/2022', 46, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (1, 3, 8, '2/7/2021', 47, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (1, 4, 5, '10/25/2021',48, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (2, 5, 5, '10/5/2021', 49, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (3, 1, 8, '8/13/2022', 50, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (4, 2, 8, '8/5/2022', 51, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (5, 3, 8, '7/18/2022', 52, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (6, 4, 1, '4/9/2022', 53, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (7, 5, 1, '6/10/2021', 54, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (8, 1, 9, '6/12/2021', 55, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (9, 2, 9, '11/24/2022', 56, 4);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (10, 3, 9, '10/12/2022',57, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (11, 4, 9, '12/23/2021', 58, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (12, 5, 10, '5/2/2022', 59, 5);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (13, 1, 1, '1/20/2023', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (14, 2, 11, '5/13/2021',  NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (15, 3, 11, '1/25/2021', NULL, NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (16, 4, 10, '4/2/2021',  NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (17, 5, 10, '6/18/2022',  NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (18, 1, 12, '9/6/2021',  NULL, NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (19, 2, 12, '5/30/2021',  NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (20, 3, 12, '1/16/2023',  NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (21, 4, 14, '3/26/2022',  NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (22, 5, 14, '5/3/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (23, 1, 13, '7/13/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (24, 2, 14, '5/28/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (25, 3, 14, '5/22/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (1, 4, 14, '8/12/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (2, 5, 14, '6/17/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (3, 1, 15, '9/19/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (4, 2, 15, '2/19/2022',  NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (5, 3, 15, '10/29/2022', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (6, 4, 15, '1/25/2021', NULL,  NULL);
insert into Archive (ClientId, BarberId, ServiceId, Dates, FeedbackId, RatingId) values (7, 5, 15, '3/30/2021',  NULL,  NULL);

/*SELECT*/

select * from Positions
select * from Rating
select * from Services
select * from Barbers
select * from ServicesBarbers
select * from Clients
SELECT * from Feedbacks
select * from Orders
select * from Shedule
select * from Archive
