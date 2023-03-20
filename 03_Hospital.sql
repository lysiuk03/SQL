create database Hospital
use Hospital

create table Departments
(
ID int primary key identity ,
Building int not null check(Building>=1 AND Building<=5) ,
Financing money not null default(0) check(Financing>=0),
Floor int not null check(Floor>=1) ,
Name nvarchar(100) not null unique check(Name <> '')
)
insert into Departments (Building, Financing, Floor, Name) values (4, 29376, 1, 'Surgical');
insert into Departments (Building, Financing, Floor, Name) values (3, 13176, 1, 'Radiology');
insert into Departments (Building, Financing, Floor, Name) values (2, 10630, 1, 'ICU');
insert into Departments (Building, Financing, Floor, Name) values (1, 47363, 4, 'ER');
insert into Departments (Building, Financing, Floor, Name) values (5, 19689, 5, 'Labor & delivery');
insert into Departments (Building, Financing, Floor, Name) values (5, 21210, 3, 'Lab');
insert into Departments (Building, Financing, Floor, Name) values (5, 46158, 1, 'Pharmacy');
insert into Departments (Building, Financing, Floor, Name) values (3, 38411, 4, 'NICU');
insert into Departments (Building, Financing, Floor, Name) values (4, 43314, 1, 'Morgue');
insert into Departments (Building, Financing, Floor, Name) values (2, 24553, 5, 'Pediatrics ward');
select * from Departments
select dep.Building, dep.Floor, dep.Name  from Departments as dep
select Name 'Building 5 (financing<30000)'  from Departments where Building=5 and Financing<30000
select Name 'Building 3 (12000<financing<15000)'  from Departments where Building=3 and Financing>12000 and Financing<15000
select Name 'Building 4 and 5 (floor 1)'  from Departments where (Building=5 or Building=4) and Floor=1
select Name, Building, Financing  from Departments where (Building=3 or Building=6) and (Financing<11000 or Financing>25000)
select Building, Name from Departments where Building in (1,3,8,10)
select Name from Departments where Building<>1 and Building<>3
select Name from Departments where Building in (1,3)


create table Diseases
(
ID int primary key identity,
Name nvarchar(100) not null unique check(Name <> ''),
Severity int not null default(1) check(Severity>=1),
)
insert into Diseases (Name, Severity) values ('Cold', 1);
insert into Diseases (Name, Severity) values ('Sinusitis', 3);
insert into Diseases (Name, Severity) values ('Diabetes', 3);
insert into Diseases (Name, Severity) values ('Leukemia', 2);
insert into Diseases (Name, Severity) values ('Otitis', 3);
insert into Diseases (Name, Severity) values ('Leprosy', 2);
insert into Diseases (Name, Severity) values ('Syphilis', 2);
insert into Diseases (Name, Severity) values ('Rabies', 2);
insert into Diseases (Name, Severity) values ('Cholera', 3);
insert into Diseases (Name, Severity) values ('AIDS', 4);
select * from Diseases
select Name as 'Name of Disease',Severity as 'Severity of Disease' from Diseases
select Name from Diseases where Severity<>1 and Severity<>2


create table Doctors
(
ID int primary key identity,
Name nvarchar(max) not null check(Name <> ''),
Phone char(10) not null,
Premium money not null default(0) check(Premium>=0),
Salary money not null check(Salary>=1),
Surname nvarchar(max) not null check(Surname <> ''),
)
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Sauveur', '6066952777',1000, 10144, 'Kington');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Doug', '8858233328',400, 1000, 'Aupol');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Lettie', '4769187769',1500, 20783, 'Nerkinson');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Sigvard', '8375844623',500, 10496, 'Dannett');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Miquela', '2087201478',400, 7472, 'Gravestone');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Selia', '1702348864',3000, 22961, 'Munnion');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Kalvin', '7384399296',2300, 21260, 'Naust');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Frankie', '3343584544',2200, 19055, 'Obington');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Jeanie', '1396840500',3000, 6769, 'Mattessen');
insert into Doctors (Name, Phone,Premium, Salary, Surname) values ('Reube', '9931698348',850, 22060, 'Sallarie');
select * from Doctors
select Name, Phone from Doctors
select doc.Name+' '+doc.Surname 'Doctors' from Doctors as doc
select Surname from Doctors where Premium+Salary>1500
select Surname from Doctors where Salary/2>Premium*3
select Surname from Doctors where Surname like 'N%'

create table Examinations
(
ID int primary key identity,
DayOfWeek int not null check(DayOfWeek between 1 AND 7),
EndTime time not null,
Name nvarchar(100) not null unique check(Name <> ''),
StartTime time not null check(StartTime between '8:00' AND '18:00'),
check(EndTime>StartTime)
)
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (2, '17:45', 'Ultrasound', '17:30');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (1, '15:00', 'Cycle ergometry', '14:45');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (2, '13:00', 'Bronchospirometry', '12:45');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (4, '14:45', 'Electroencephalography', '14:30');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (3, '13:30', 'Electromyography', '13:15');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (1, '17:00', 'Capillaroscopy', '16:45');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (4, '15:45', 'Rheoencephalography', '15:30');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (2, '9:30', 'EKG', '9:15');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (3, '17:30', 'Tomography', '17:15');
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values (1, '11:30', 'Palpation', '11:15');
select * from Examinations
select distinct Name from Examinations where (DayOfWeek<4 and DayOfWeek>0) and (EndTime<'15:00' and StartTime>'12:00')

create table Wards
(
ID int primary key identity,
Building int not null check(Building>=1 AND Building<=5) ,
Floor int not null check(Floor>=1) ,
Name nvarchar(20) not null unique check(Name <> '')
)
insert into Wards (Building, Floor, Name) values (2, 1, '№217');
insert into Wards (Building, Floor, Name) values (1, 3, '№132');
insert into Wards (Building, Floor, Name) values (5, 3, '№530');
insert into Wards (Building, Floor, Name) values (5, 1, '№511');
insert into Wards (Building, Floor, Name) values (2, 2, '№221');
insert into Wards (Building, Floor, Name) values (4, 1, '№414');
insert into Wards (Building, Floor, Name) values (2, 1, '№216');
insert into Wards (Building, Floor, Name) values (4, 4, '№442');
insert into Wards (Building, Floor, Name) values (2, 5, '№255');
insert into Wards (Building, Floor, Name) values (5, 2, '№522');
select * from Wards
select distinct Floor 'Floors' from Wards
select  w.Floor, w.Name 'Number' from Wards as w
