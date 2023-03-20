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
insert into Departments (Building, Name) values (4, 'Surgical');
insert into Departments (Building, Name) values (3, 'Radiology');
insert into Departments (Building, Name) values (2, 'ICU');
insert into Departments (Building, Name) values (1, 'ER');
insert into Departments (Building, Name) values (5, 'Labor & delivery');
insert into Departments (Building, Name) values (5, 'Lab');
insert into Departments (Building, Name) values (5, 'Pharmacy');
insert into Departments (Building, Name) values (3, 'NICU');
insert into Departments (Building, Name) values (4, 'Morgue');
insert into Departments (Building, Name) values (2, 'Pediatrics ward');

insert into Doctors (Name, Premium, Salary, Surname) values ('Sauveur', 1000, 10144, 'Kington');
insert into Doctors (Name, Premium, Salary, Surname) values ('Doug', 400, 1000, 'Aupol');
insert into Doctors (Name, Premium, Salary, Surname) values ('Lettie', 1500, 20783, 'Nerkinson');
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
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('14:45', '14:30',5, 1, 4);
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
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('14:00', '13:45',10, 1, 13);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('12:45', '12:30',6, 8, 11);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('16:15', '16:00',7, 5, 8);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('15:00', '14:45',4, 2, 5);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('8:45', '8:30',3, 4, 7);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('16:45', '16:30',6, 3, 17);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:00', '10:45',6, 8, 4);

/*Views*/
------------------------------
create view AllDoctors
as
select Name+' '+Surname as 'Doctors'
from Doctors

select * from AllDoctors

drop view AllDoctors
------------------------------
create view AllExaminations
as
select d.Name+' '+d.Surname as 'Doctor', w.Name as '№ ward', w.Places as 'Places', e.Name as 'Examination'
from Doctors as d JOIN DoctorsExaminations as de ON de.DoctorId=d.ID
					JOIN Examinations as e ON de.ExaminationId=e.ID
					JOIN Wards as w ON de.WardId=w.ID

select * from AllExaminations

drop view AllExaminations
------------------------------
create view DepartWards
as
select d.Name as 'Department', w.Name as '№ ward',w.Places as 'Places'
from Departments as d JOIN Wards as w ON w.DepartmentId=d.ID
where d.Name='Radiology'

select* from DepartWards

drop view DepartWards
------------------------------
create view CoolDoctor
as
select  d.Name+' '+d.Surname as 'Doctor', COUNT(e.Id) as 'Examination'
from Doctors as d JOIN DoctorsExaminations as de ON de.DoctorId=d.ID
					JOIN Examinations as e ON de.ExaminationId=e.ID
					group by d.Name+' '+d.Surname

select *
from CoolDoctor as cd
where cd.Examination = (SELECT MAX(cd.Examination)from CoolDoctor as cd)

drop view CoolDoctor
------------------------------
create view TopDoctors
as
select top 3 d.Name+' '+d.Surname as 'Doctors'
from Doctors as d
order by d.Premium desc

select* from TopDoctors

drop view TopDoctors
------------------------------
create view RichDoctor
as
select top 1 d.Name+' '+d.Surname as 'Doctor', d.Premium,d.Salary
from Doctors as d
order by d.Salary desc

select* from RichDoctor

drop view RichDoctor
------------------------------
