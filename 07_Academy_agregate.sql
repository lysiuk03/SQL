create database Academy
use Academy
drop database Academy

/*TABLES*/
create table Faculties
(
ID int primary key identity(1,1) ,
Name nvarchar(100) not null unique check(Name <> '')
)

create table Teachers
(
ID int primary key identity(1,1),
Name nvarchar(max) not null check(Name <> ''),
Salary money not null check(Salary>0),
Surname nvarchar(max) not null check(Surname <> '')
)

create table Subjects
(
ID int primary key identity(1,1),
Name nvarchar(100) not null unique check(Name <> '')
)

create table Departments
(
ID int primary key identity(1,1) ,
Financing money not null default(0) check(Financing>=0),
Name nvarchar(100) not null unique check(Name <> ''),
FacultyId int not null references Faculties(ID)
)

create table Lectures
(
ID int primary key identity(1,1) ,
DayOfWeek int not null check(DayOfWeek between 1 AND 7),
LectureRoom nvarchar(max) not null check(LectureRoom <> ''),
SubjectId int not null references Subjects(ID),
TeacherId int not null references Teachers(ID)
)

create table Groups
(
ID int primary key identity(1,1) ,
Name nvarchar(10) not null unique check(Name <> ''),
Year int not null check(Year BETWEEN 1 AND 5),
Student int not null check(Student>0),
DepartmentId int not null references Departments(ID)
)

create table GroupsLectures
(
ID int primary key identity(1,1) ,
GroupId int not null  references Groups(ID), 
LectureId int not null  references Lectures(ID)
)

/*INSERT*/
insert into Faculties ( Name) values ('Computer Science');
insert into Faculties (Name) values ('Ecology');
insert into Faculties (Name) values ('Design');

insert into Teachers (Name, Salary, Surname) values ('Dave', 17234, 'McQueen');
insert into Teachers (Name, Salary, Surname) values ('Micki', 9373, 'Fery');
insert into Teachers (Name, Salary, Surname) values ('Alayne', 17959, 'Dunkley');
insert into Teachers (Name, Salary, Surname) values ('Rebbecca', 17895, 'Legg');
insert into Teachers (Name, Salary, Surname) values ('Quinn', 14965, 'Keling');
insert into Teachers (Name, Salary, Surname) values ('Rita', 8483, 'Pauling');
insert into Teachers (Name, Salary, Surname) values ('Karie', 17756, 'Veldman');

insert into Subjects (Name) values ('Database Theory');
insert into Subjects (Name) values ('Astronomy');
insert into Subjects (Name) values ('Chemistry');
insert into Subjects (Name) values ('Physics');
insert into Subjects (Name) values ('Geometry');
insert into Subjects (Name) values ('Algebra');
insert into Subjects (Name) values ('Geography');
insert into Subjects (Name) values ('Biology');
insert into Subjects (Name) values ('Technologies');
insert into Subjects (Name) values ('History');
insert into Subjects (Name) values ('Literature');
insert into Subjects (Name) values ('Polish');
insert into Subjects (Name) values ('French');
insert into Subjects (Name) values ('Computer');
insert into Subjects (Name) values ('Math');
insert into Subjects (Name) values ('Design');
insert into Subjects (Name) values ('Art');
insert into Subjects (Name) values ('Music');
insert into Subjects (Name) values ('English');
insert into Subjects (Name) values ('Ukrainian');

insert into Departments (Financing, Name, FacultyId) values (2511, 'Programming', 1);
insert into Departments (Financing, Name, FacultyId) values (4693, 'Dtabases', 1);
insert into Departments (Financing, Name, FacultyId) values (2561, 'Software Development', 1);
insert into Departments (Financing, Name, FacultyId) values (4973, 'Water', 2);
insert into Departments (Financing, Name, FacultyId) values (4792, 'Soil', 2);
insert into Departments (Financing, Name, FacultyId) values (2092, 'Air', 2);
insert into Departments (Financing, Name, FacultyId) values (2222, 'UX', 3);
insert into Departments (Financing, Name, FacultyId) values (4275, 'CDO', 3);
insert into Departments (Financing, Name, FacultyId) values (2169, 'Graphics', 3);

insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (1,'D201', 1, 1);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (2,'A102', 2, 1);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (3,'A103', 3, 1);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (4,'D201', 4, 2);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (5,'A102', 5, 2);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (1,'A103', 6, 2);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (2,'D201', 7, 3);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (3,'A102', 8, 3);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (4,'A103', 9, 3);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (5,'D201', 10, 4);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (1,'A102', 11, 4);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (2,'A103', 12, 4);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (3,'D201', 13, 5);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (4,'A102', 14, 5);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (5,'A103', 15, 5);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (1,'D201',16, 6);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (2,'A102', 17, 6);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (3,'D201', 18, 6);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (4,'D201', 19, 7);
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values (5,'D201', 20, 7);

insert into Groups (Name, Year,Student, DepartmentId) values ('P107', 1,30, 1);
insert into Groups (Name, Year,Student, DepartmentId) values ('P108', 1,14, 2);
insert into Groups (Name, Year,Student, DepartmentId) values ('P109', 1,13, 3);
insert into Groups (Name, Year,Student, DepartmentId) values ('E107', 2,11, 4);
insert into Groups (Name, Year,Student, DepartmentId) values ('E108', 2,20, 5);
insert into Groups (Name, Year,Student, DepartmentId) values ('E109', 2,10, 6);
insert into Groups (Name, Year,Student, DepartmentId) values ('D107', 3,29, 7);
insert into Groups (Name, Year,Student, DepartmentId) values ('D108', 3,28, 8);
insert into Groups (Name, Year,Student, DepartmentId) values ('D109', 3,27, 9);
insert into Groups (Name, Year,Student, DepartmentId) values ('P110', 4,22, 1);
insert into Groups (Name, Year,Student, DepartmentId) values ('P111', 4,23, 2);
insert into Groups (Name, Year,Student, DepartmentId) values ('P112', 4,24, 3);
insert into Groups (Name, Year,Student, DepartmentId) values ('E110', 5,23, 4);
insert into Groups (Name, Year,Student, DepartmentId) values ('E111', 5,22, 5);
insert into Groups (Name, Year,Student, DepartmentId) values ('E112', 5,21, 6);

insert into GroupsLectures (GroupId, LectureId) values (7, 4);
insert into GroupsLectures (GroupId, LectureId) values (6, 15);
insert into GroupsLectures (GroupId, LectureId) values (11, 4);
insert into GroupsLectures (GroupId, LectureId) values (4, 6);
insert into GroupsLectures (GroupId, LectureId) values (3, 18);
insert into GroupsLectures (GroupId, LectureId) values (14, 14);
insert into GroupsLectures (GroupId, LectureId) values (5, 16);
insert into GroupsLectures (GroupId, LectureId) values (2, 14);
insert into GroupsLectures (GroupId, LectureId) values (6, 11);
insert into GroupsLectures (GroupId, LectureId) values (3, 20);
insert into GroupsLectures (GroupId, LectureId) values (15, 7);
insert into GroupsLectures (GroupId, LectureId) values (4, 16);
insert into GroupsLectures (GroupId, LectureId) values (4, 12);
insert into GroupsLectures (GroupId, LectureId) values (11, 10);
insert into GroupsLectures (GroupId, LectureId) values (6, 18);
insert into GroupsLectures (GroupId, LectureId) values (15, 7);
insert into GroupsLectures (GroupId, LectureId) values (12, 2);
insert into GroupsLectures (GroupId, LectureId) values (1, 2);
insert into GroupsLectures (GroupId, LectureId) values (12, 14);
insert into GroupsLectures (GroupId, LectureId) values (11, 14);
insert into GroupsLectures (GroupId, LectureId) values (4, 11);
insert into GroupsLectures (GroupId, LectureId) values (9, 7);
insert into GroupsLectures (GroupId, LectureId) values (14, 10);
insert into GroupsLectures (GroupId, LectureId) values (13, 18);
insert into GroupsLectures (GroupId, LectureId) values (6, 10);
insert into GroupsLectures (GroupId, LectureId) values (7, 16);
insert into GroupsLectures (GroupId, LectureId) values (7, 3);
insert into GroupsLectures (GroupId, LectureId) values (11, 8);
insert into GroupsLectures (GroupId, LectureId) values (12, 20);
insert into GroupsLectures (GroupId, LectureId) values (12, 19);
insert into GroupsLectures (GroupId, LectureId) values (12, 4);
insert into GroupsLectures (GroupId, LectureId) values (6, 12);
insert into GroupsLectures (GroupId, LectureId) values (9, 1);
insert into GroupsLectures (GroupId, LectureId) values (13, 15);
insert into GroupsLectures (GroupId, LectureId) values (14, 12);
insert into GroupsLectures (GroupId, LectureId) values (2, 16);
insert into GroupsLectures (GroupId, LectureId) values (14, 8);
insert into GroupsLectures (GroupId, LectureId) values (7, 15);
insert into GroupsLectures (GroupId, LectureId) values (7, 17);
insert into GroupsLectures (GroupId, LectureId) values (10, 6);
insert into GroupsLectures (GroupId, LectureId) values (3, 17);
insert into GroupsLectures (GroupId, LectureId) values (7, 9);
insert into GroupsLectures (GroupId, LectureId) values (1, 18);
insert into GroupsLectures (GroupId, LectureId) values (12, 15);
insert into GroupsLectures (GroupId, LectureId) values (4, 15);
insert into GroupsLectures (GroupId, LectureId) values (15, 14);
insert into GroupsLectures (GroupId, LectureId) values (10, 9);
insert into GroupsLectures (GroupId, LectureId) values (9, 3);
insert into GroupsLectures (GroupId, LectureId) values (1, 1);
insert into GroupsLectures (GroupId, LectureId) values (13, 16);

/*Aggregate Functions*/
select  d.Name 'Cafedra', COUNT(DISTINCT t.Id) as 'Teachers Count'
from Teachers as t JOIN Lectures as l ON l.TeacherId = t.ID
					JOIN GroupsLectures as gl ON gl.LectureId= l.ID
					JOIN Groups as g ON gl.GroupId= g.ID
					JOIN Departments as d ON g.DepartmentId= d.ID
					where d.Name='Software Development'
					group by d.Name

select  t.Name+' '+t.Surname as 'Teacher', COUNT(l.Id) as 'Lectures'
from Teachers as t JOIN Lectures as l ON l.TeacherId = t.ID
where t.Name+' '+t.Surname='Dave McQueen'
				group by t.Name+' '+t.Surname

select  l.LectureRoom '№room', COUNT(l.Id) as 'Lectures'
from Lectures as l
where l.LectureRoom='D201'
				group by l.LectureRoom

select  l.LectureRoom '№room', COUNT(l.Id) as 'Lectures'
from Lectures as l
				group by l.LectureRoom

select  t.Name+' '+t.Surname as 'Teacher', COUNT(g.Id) as 'Groups'
from Teachers as t JOIN Lectures as l ON l.TeacherId = t.ID
				JOIN GroupsLectures as gl ON gl.LectureId= l.ID
				JOIN Groups as g ON gl.GroupId= g.ID
				where t.Name+' '+t.Surname='Micki Fery'
				group by t.Name+' '+t.Surname 

select  f.Name 'Faculties', AVG(DISTINCT t.Salary) as 'Avg teachers salary'
from Faculties as f JOIN Departments as d ON d.FacultyId = f.ID
				JOIN Groups as g ON g.DepartmentId= d.ID
				JOIN GroupsLectures as gl ON gl.GroupId= g.ID
				JOIN Lectures as l ON gl.LectureId= l.ID
				JOIN Teachers as t ON l.TeacherId= t.ID
				where f.Name='Computer Science'
				group by f.Name

select  MAX(Student) as 'MAX',MIN(Student) as 'MIN'
from Groups

select  Avg(Financing) as'Avg Financing'
from Departments 

select t.Name+' '+t.Surname as 'Teacher', COUNT(s.Name) as'Subjects'
from Teachers as t  JOIN Lectures as l ON l.TeacherId= t.ID
					JOIN Subjects as s ON l.SubjectId= s.ID
					group by t.Name+' '+t.Surname

select DayOfWeek as 'Day', COUNT(LectureRoom) as'Lectures'
from Lectures 
group by DayOfWeek

select  l.LectureRoom as 'Lecture Room', COUNT(DISTINCT d.ID) as'Departmens'
from Lectures as l JOIN GroupsLectures as gl ON gl.LectureId= l.ID
					JOIN Groups as g ON gl.GroupId= g.ID
					JOIN Departments as d ON g.DepartmentId= d.ID
group by l.LectureRoom 

select  f.Name 'Faculties', COUNT(DISTINCT s.ID) as'Subjects'
from Faculties as f JOIN Departments as d ON d.FacultyId = f.ID
					JOIN Groups as g ON g.DepartmentId= d.ID
					JOIN GroupsLectures as gl ON gl.GroupId= g.ID
					JOIN Lectures as l ON gl.LectureId= l.ID
					JOIN Subjects as s ON l.SubjectId= s.ID
					group by f.Name

select t.Name as 'Teachers', l.LectureRoom as 'Lecture Room', COUNT(l.Id) as 'Teacher-Room'
from Teachers as t JOIN Lectures as l ON l.TeacherId = t.ID
group by t.Name, l.LectureRoom
