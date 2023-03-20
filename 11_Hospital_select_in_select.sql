create database Hospital
use Hospital
drop database Hospital

/*TABLES*/
create table Departments
(
ID int primary key identity ,
Building int not null check(Building>=1 AND Building<=5) ,
Name nvarchar(100) not null unique check(Name <> '')
)

create table Doctors
(
ID int primary key identity,
Name nvarchar(max) not null check(Name <> ''),
Premium money not null default(0) check(Premium>=0),
Salary money not null check(Salary>=1),
Surname nvarchar(max) not null check(Surname <> ''),
)

create table Examinations
(
ID int primary key identity,
Name nvarchar(100) not null unique check(Name <> ''),
)

create table Sponsors
(
ID int primary key identity,
Name nvarchar(100) not null unique check(Name <> '')
)

create table Donations
(
ID int primary key identity,
Amount money not null check(Amount>0),
Dates datetime not null DEFAULT (getdate()) check(Dates<=GetDate()),
DepartmentId int not null references Departments(ID),
SponsorId int not null references Sponsors(ID)
)

create table Wards
(
ID int primary key identity,
Name nvarchar(20) not null unique check(Name <> ''),
Places int not null check(Places>0),
DepartmentId int not null references Departments(ID)
)

create table DoctorsExaminations
(
ID int primary key identity,
EndTime time not null,
StartTime time not null check(StartTime between '8:00' AND '18:00'),
DoctorId int not null references Doctors(ID),
ExaminationId int not null references Examinations(ID),
WardId int not null references Wards(ID),
check(EndTime>StartTime)
)

/*INSERT*/
insert into Departments (Building, Name) values (4, 'General Surgery');
insert into Departments (Building, Name) values (3, 'Radiology');
insert into Departments (Building, Name) values (2, 'Gastroenterolog');
insert into Departments (Building, Name) values (1, 'Microbiology');
insert into Departments (Building, Name) values (5, 'Cardiology');
insert into Departments (Building, Name) values (5, 'Neurology');
insert into Departments (Building, Name) values (5, 'Pharmacy');
insert into Departments (Building, Name) values (3, 'Oncology');
insert into Departments (Building, Name) values (4, 'Morgue');
insert into Departments (Building, Name) values (2, 'Pediatrics ward');

insert into Doctors (Name, Premium, Salary, Surname) values ('Thomas', 1000, 10144, 'Gerada');
insert into Doctors (Name, Premium, Salary, Surname) values ('Anthony', 400, 1000, 'Davis');
insert into Doctors (Name, Premium, Salary, Surname) values ('Joshua', 1500, 20783, 'Bell');
insert into Doctors (Name, Premium, Salary, Surname) values ('Sigvard', 500, 10496, 'Dannett');
insert into Doctors (Name, Premium, Salary, Surname) values ('Miquela', 400, 7472, 'Gravestone');
insert into Doctors (Name, Premium, Salary, Surname) values ('Selia', 3000, 22961, 'Munnion');
insert into Doctors (Name, Premium, Salary, Surname) values ('Kalvin', 2300, 21260, 'Naust');
insert into Doctors (Name, Premium, Salary, Surname) values ('Frankie', 2200, 19055, 'Obington');
insert into Doctors (Name, Premium, Salary, Surname) values ('Jeanie', 3000, 6769, 'Mattessen');
insert into Doctors (Name, Premium, Salary, Surname) values ('Reube', 850, 22060, 'Sallarie');

insert into Examinations (Name) values ('Ultrasound');
insert into Examinations (Name) values ('Cycle ergometry');
insert into Examinations (Name) values ('Bronchospirometry');
insert into Examinations (Name) values ('Electroencephalography');
insert into Examinations (Name) values ('Electromyography');
insert into Examinations (Name) values ('Capillaroscopy');
insert into Examinations (Name) values ('Rheoencephalography');
insert into Examinations (Name) values ('EKG');
insert into Examinations (Name) values ('Tomography');
insert into Examinations (Name) values ('Palpation');

insert into Sponsors (Name) values ('Sauer, Gutkowski and Leannon');
insert into Sponsors (Name) values ('Mann-Runte');
insert into Sponsors (Name) values ('Will Inc');
insert into Sponsors (Name) values ('Larson, Kuphal and Williamson');
insert into Sponsors (Name) values ('Murray-Homenick');
insert into Sponsors (Name) values ('Streich-Leuschke');
insert into Sponsors (Name) values ('D''Amore-Labadie');
insert into Sponsors (Name) values ('Williamson-Reynolds');
insert into Sponsors (Name) values ('Terry, Grant and Cummings');
insert into Sponsors (Name) values ('Lemke, Gusikowski and Bartoletti');
insert into Sponsors (Name) values ('Kling-Rowe');
insert into Sponsors (Name) values ('Schimmel-Carter');
insert into Sponsors (Name) values ('Hills LLC');
insert into Sponsors (Name) values ('Hessel-Conroy');
insert into Sponsors (Name) values ('Tremblay-Runolfsdottir');
insert into Sponsors (Name) values ('McGlynn Inc');
insert into Sponsors (Name) values ('Osinski Inc');
insert into Sponsors (Name) values ('Borer Group');
insert into Sponsors (Name) values ('Gutmann-Torp');
insert into Sponsors (Name) values ('Lang-Heaney');
insert into Sponsors (Name) values ('Schroeder, Becker and Rohan');
insert into Sponsors (Name) values ('White and Sons');
insert into Sponsors (Name) values ('Harris-Cummerata');
insert into Sponsors (Name) values ('Cormier and Sons');
insert into Sponsors (Name) values ('Rosenbaum-McCullough');

insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (2972, '12/20/2022', 10, 2);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (9535, '9/3/2022', 2, 11);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (2670, '2/2/2022', 7, 21);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (8074, '12/22/2022', 2, 17);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (7775, '3/4/2022', 3, 24);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (7037, '5/26/2022', 7, 25);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (6280, '12/24/2022', 4, 2);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (551, '12/14/2021', 9, 18);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (7013, '2/17/2022', 9, 12);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (8672, '6/2/2022', 6, 11);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (3399, '12/13/2021', 10, 10);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (7833, '6/18/2022', 9, 18);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (6415, '6/9/2022', 3, 8);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (9809, '7/30/2022', 6, 11);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (2386, '9/13/2022', 4, 7);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (8909, '3/2/2022', 8, 22);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (2640, '2/1/2022', 2, 24);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (9699, '2/15/2022', 3, 3);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (9658, '4/8/2022', 3, 16);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (5630, '11/29/2022', 10, 15);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (209, '8/24/2022', 4, 21);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (3990, '10/27/2022', 8, 6);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (6405, '3/22/2022', 3, 5);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (5857, '9/26/2022', 7, 22);
insert into Donations (Amount, Dates, DepartmentId, SponsorId) values (749, '4/9/2022', 9, 6);


insert into Wards (Name, Places, DepartmentId) values ('№217',2,1);
insert into Wards (Name, Places, DepartmentId) values ('№132',3,2);
insert into Wards (Name, Places, DepartmentId) values ('№530',4,3);
insert into Wards (Name, Places, DepartmentId) values ('№511',3,4);
insert into Wards (Name, Places, DepartmentId) values ('№221',2,5);
insert into Wards (Name, Places, DepartmentId) values ('№414',1,6);
insert into Wards (Name, Places, DepartmentId) values ('№216',4,7);
insert into Wards (Name, Places, DepartmentId) values ('№442',2,8);
insert into Wards (Name, Places, DepartmentId) values ('№255',3,9);
insert into Wards (Name, Places, DepartmentId) values ('№522',5,10);
insert into Wards (Name, Places, DepartmentId) values ('№218',2,1);
insert into Wards (Name, Places, DepartmentId) values ('№133',3,2);
insert into Wards (Name, Places, DepartmentId) values ('№531',4,3);
insert into Wards (Name, Places, DepartmentId) values ('№512',3,4);
insert into Wards (Name, Places, DepartmentId) values ('№222',2,5);
insert into Wards (Name, Places, DepartmentId) values ('№413',1,6);
insert into Wards (Name, Places, DepartmentId) values ('№217',4,7);
insert into Wards (Name, Places, DepartmentId) values ('№443',2,8);
insert into Wards (Name, Places, DepartmentId) values ('№256',3,9);
insert into Wards (Name, Places, DepartmentId) values ('№523',5,10);

insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:45', '17:30',8, 4, 11);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('15:00', '14:45',3, 7, 1);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('13:00', '12:45',4, 6, 9);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('14:45', '14:30',10, 4, 18);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('13:30', '13:15',2, 3, 4);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:00', '16:45',7, 5, 11);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('15:45', '15:30',2, 2, 6);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('9:30', '9:15',8, 4, 18);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:30', '17:15',10, 7, 2);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:30', '11:15',7, 8, 3);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:30', '17:15',3, 5, 6);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:45', '17:30',5, 1, 4);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('12:45', '12:30',2, 10, 18);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('14:30', '14:15',4, 7, 1);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('13:15', '13:00',3, 8, 18);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('16:45', '16:30',6, 10, 12);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('15:30', '15:15',4, 3, 7);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('9:15', '9:00',5, 8, 7);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:15', '17:00',6, 2, 14);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:15', '11:15',1, 8, 9);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:15', '17:00',3, 10, 17);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ( '14:30', '14:15',2, 3, 16);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('12:30', '12:15',9, 2, 16);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('14:15', '14:00',3, 6, 3);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('13:00', '12:45',6, 8, 1);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('16:30', '16:15',9, 6, 20);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('15:15', '15:00',8, 5, 10);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('9:00', '8:45',10, 9, 20);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:00', '16:45',4, 9, 4);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:15', '11:00',8, 2, 19);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:00', '16:45',3, 7, 8);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ( '14:15', '14:00',5, 2, 4);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('12:15', '12:00',7, 9, 13);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('17:00', '17:45',10, 1, 13);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('12:45', '12:30',6, 8, 11);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('16:15', '16:00',7, 5, 8);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('15:00', '14:45',4, 2, 5);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('8:45', '8:30',3, 4, 7);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('16:45', '16:30',6, 3, 17);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:00', '10:45',6, 8, 4);
/*Підзапити*/
-----------------------------------
select Name
from Departments 
where (select de.Building
		from Departments AS de
		where de.Name='Cardiology')=Building and  Name<>'Cardiology'
-----------------------------------
select Name
from Departments 
where (select de.Building
		from Departments AS de
		where de.Name='Gastroenterolog' )=Building and  Name<>'Gastroenterolog' or (select de.Building
																					from Departments AS de
																					where de.Name='General Surgery' )=Building and Name<>'General Surgery'
-----------------------------------
select Name
from Departments 
where (select top 1 DepartmentId
		from Donations 
		group by DepartmentId
		order by SUM(Amount))=Id
-----------------------------------
select Surname
from Doctors
where(select d.Salary
	from Doctors as d
	where d.Name+' '+d.Surname ='Thomas Gerada')<Salary
-----------------------------------
select Name 
from Wards
where(select Avg(w.Places)
	  from Wards as w JOIN Departments as d ON w.DepartmentId=d.Id
	  where d.Name='Microbiology')<Places
-----------------------------------
select Name+' '+Surname as 'FullName'
from Doctors 
where(select d.Salary+d.Premium+100
      from Doctors as d
	  where d.Name+' '+d.Surname='Anthony Davis')<Salary+Premium
-----------------------------------
select d.Name 
from Departments as d JOIN Wards as w ON w.DepartmentId=d.ID
					JOIN DoctorsExaminations as de ON w.ID=de.WardId
					JOIN Doctors as doc ON doc.ID=de.DoctorId
					where doc.Name+' '+doc.Surname='Joshua Bell'
-----------------------------------
select s.Name
from Sponsors as s JOIN Donations as don ON don.SponsorId=s.ID
					JOIN Departments as dep ON dep.ID=don.DepartmentId
					where dep.Name<>'Neurology' and dep.Name<>'Oncology'
-----------------------------------
select  Surname
from Doctors as d JOIN DoctorsExaminations as de ON de.DoctorId=d.ID
where de.StartTime>='12:00' and de.EndTime<='15:00'
group by Surname
-----------------------------------
