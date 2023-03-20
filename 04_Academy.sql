create database Academy
use Academy

/*TABLES*/
create table Subjects
(
ID int primary key identity(1,1),
Name nvarchar(100) not null unique check(Name <> '')
)
create table Teachers
(
ID int primary key identity(1,1),
Name nvarchar(max) not null check(Name <> ''),
Salary money not null check(Salary>0),
Surname nvarchar(max) not null check(Surname <> '')
)
create table Curators
(
ID int primary key identity(1,1) ,
Name nvarchar(max) not null check(Name <> ''),
Surname nvarchar(max) not null check(Surname <> '')
)
create table Faculties
(
ID int primary key identity(1,1) ,
Financing money not null default(0) check(Financing>=0),
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
LectureRoom nvarchar(max) not null check(LectureRoom <> ''),
SubjectId int not null references Subjects(ID),
TeacherId int not null references Teachers(ID)
)
create table Groups
(
ID int primary key identity(1,1) ,
Name nvarchar(10) not null unique check(Name <> ''),
Year int not null check(Year BETWEEN 1 AND 5),
DepartmentId int not null references Departments(ID)
)
create table GroupsCurators
(
ID int primary key identity(1,1) ,
CuratorId int not null references Curators(ID),
GroupId int not null references Groups(ID)
)
create table GroupsLectures
(
ID int primary key identity(1,1) ,
GroupId int not null  references Groups(ID), 
LectureId int not null  references Lectures(ID)
)


/*INSERT*/
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

insert into Teachers (Name, Salary, Surname) values ('Samantha', 17234, 'Adams');
insert into Teachers (Name, Salary, Surname) values ('Micki', 9373, 'Fery');
insert into Teachers (Name, Salary, Surname) values ('Alayne', 17959, 'Dunkley');
insert into Teachers (Name, Salary, Surname) values ('Rebbecca', 17895, 'Legg');
insert into Teachers (Name, Salary, Surname) values ('Quinn', 14965, 'Keling');
insert into Teachers (Name, Salary, Surname) values ('Rita', 8483, 'Pauling');
insert into Teachers (Name, Salary, Surname) values ('Karie', 17756, 'Veldman');

insert into Curators (Name, Surname) values ('Nickie', 'Rosenstiel');
insert into Curators (Name, Surname) values ('Zachariah', 'Spyer');
insert into Curators (Name, Surname) values ('Sheri', 'Tott');
insert into Curators (Name, Surname) values ('Chanda', 'Armall');
insert into Curators (Name, Surname) values ('Janos', 'Drinkwater');
insert into Curators (Name, Surname) values ('Inez', 'Cottey');
insert into Curators (Name, Surname) values ('Tobias', 'Spurriar');
insert into Curators (Name, Surname) values ('Gabriella', 'Fussie');
insert into Curators (Name, Surname) values ('Preston', 'Danzig');
insert into Curators (Name, Surname) values ('Jessi', 'Bownass');

insert into Faculties (Financing, Name) values (4113, 'Computer Science');
insert into Faculties (Financing, Name) values (1721, 'Ecology');
insert into Faculties (Financing, Name) values (2703, 'Design');

insert into Departments (Financing, Name, FacultyId) values (2511, 'Programming', 1);
insert into Departments (Financing, Name, FacultyId) values (4693, 'Dtabases', 1);
insert into Departments (Financing, Name, FacultyId) values (2561, 'Web', 1);
insert into Departments (Financing, Name, FacultyId) values (4973, 'Water', 2);
insert into Departments (Financing, Name, FacultyId) values (4792, 'Soil', 2);
insert into Departments (Financing, Name, FacultyId) values (2092, 'Air', 2);
insert into Departments (Financing, Name, FacultyId) values (2222, 'UX', 3);
insert into Departments (Financing, Name, FacultyId) values (4275, 'CDO', 3);
insert into Departments (Financing, Name, FacultyId) values (2169, 'Graphics', 3);

insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A101', 1, 1);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A102', 2, 1);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A103', 3, 1);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A101', 4, 2);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A102', 5, 2);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A103', 6, 2);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A101', 7, 3);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A102', 8, 3);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A103', 9, 3);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A101', 10, 4);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A102', 11, 4);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A103', 12, 4);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A101', 13, 5);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A102', 14, 5);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A103', 15, 5);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A101',16, 6);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A102', 17, 6);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A103', 18, 6);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A101', 19, 7);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('A102', 20, 7);

insert into Groups (Name, Year, DepartmentId) values ('P107', 1, 1);
insert into Groups (Name, Year, DepartmentId) values ('P108', 1, 2);
insert into Groups (Name, Year, DepartmentId) values ('P109', 1, 3);
insert into Groups (Name, Year, DepartmentId) values ('E107', 2, 4);
insert into Groups (Name, Year, DepartmentId) values ('E108', 2, 5);
insert into Groups (Name, Year, DepartmentId) values ('E109', 2, 6);
insert into Groups (Name, Year, DepartmentId) values ('D107', 3, 7);
insert into Groups (Name, Year, DepartmentId) values ('D108', 3, 8);
insert into Groups (Name, Year, DepartmentId) values ('D109', 3, 9);
insert into Groups (Name, Year, DepartmentId) values ('P110', 4, 1);
insert into Groups (Name, Year, DepartmentId) values ('P111', 4, 2);
insert into Groups (Name, Year, DepartmentId) values ('P112', 4, 3);
insert into Groups (Name, Year, DepartmentId) values ('E110', 5, 4);
insert into Groups (Name, Year, DepartmentId) values ('E111', 5, 5);
insert into Groups (Name, Year, DepartmentId) values ('E112', 5, 6);

insert into GroupsCurators (CuratorId, GroupId) values (1, 1);
insert into GroupsCurators (CuratorId, GroupId) values (2, 2);
insert into GroupsCurators (CuratorId, GroupId) values (3, 3);
insert into GroupsCurators (CuratorId, GroupId) values (4, 4);
insert into GroupsCurators (CuratorId, GroupId) values (5, 5);
insert into GroupsCurators (CuratorId, GroupId) values (6, 6);
insert into GroupsCurators (CuratorId, GroupId) values (7, 7);
insert into GroupsCurators (CuratorId, GroupId) values (8, 8);
insert into GroupsCurators (CuratorId, GroupId) values (9, 9);
insert into GroupsCurators (CuratorId, GroupId) values (10, 10);
insert into GroupsCurators (CuratorId, GroupId) values (1, 11);
insert into GroupsCurators (CuratorId, GroupId) values (2, 12);
insert into GroupsCurators (CuratorId, GroupId) values (3, 13);
insert into GroupsCurators (CuratorId, GroupId) values (4, 14);
insert into GroupsCurators (CuratorId, GroupId) values (5, 15);

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


/*SELECT*/

select * from Subjects
select * from Teachers
select * from Curators
select * from Faculties
select * from Departments
select * from Lectures
select * from Groups
select * from GroupsCurators
select * from GroupsLectures

select t.Name+' '+t.Surname as 'Teachers', g.Name
from Teachers as t , Groups as g 

select  f.Name, d.Name
from Departments as d  JOIN Faculties as f ON FacultyId = f.Id
where  d.Financing > f.Financing

select g.Name, c.Surname 
from Curators as c, GroupsCurators as gc, Groups as g
where gc.CuratorId = c.Id AND gc.GroupId = g.Id

select distinct t.Name, t.Surname
from GroupsLectures as gl   JOIN Lectures as l ON gl.LectureId = l.ID
							JOIN Groups as g ON gl.GroupId = g.ID
							JOIN Teachers as t ON l.TeacherId = t.ID
							where g.Name = 'P107' 

select distinct  t.Surname, f. Name as 'Faculteties'
from GroupsLectures as gl   JOIN Lectures as l ON gl.LectureId = l.ID
							JOIN Groups as g ON gl.GroupId = g.ID
							JOIN Teachers as t ON l.TeacherId = t.ID
							JOIN Departments as d ON g.DepartmentId = d.ID
							JOIN Faculties as f ON d.FacultyId = f.ID

select g.Name 'Groups', d.Name 'Cafedrs'
from Groups as g JOIN Departments d ON g.DepartmentId = d.ID

select s.Name
from Subjects as s  JOIN  Lectures as l ON l.SubjectId = s.ID
					JOIN Teachers as t ON l.TeacherId = t.ID
					where t.Name+' '+t.Surname='Samantha Adams'

select d.Name
from Departments as d  JOIN  Groups as g ON g.DepartmentId= d.ID
					JOIN GroupsLectures as gl ON gl.GroupId = g.ID
					JOIN Lectures as l ON gl.LectureId = l.ID
					JOIN Subjects as s ON l.SubjectId = s.ID
					where s.Name='Database Theory'

select g.Name
from Groups as g JOIN  Departments as d ON g.DepartmentId= d.ID
					JOIN  Faculties as f ON d.FacultyId= f.ID
					where f.Name='Computer Science'

select g.Name, f.Name
from Groups as g  JOIN  Departments as d ON g.DepartmentId= d.ID
						JOIN  Faculties as f ON d.FacultyId= f.ID
						where g.Year=5

select t.Name+' '+t.Surname as 'Names', g.Name, s.Name
from GroupsLectures as gl JOIN  Groups as g ON gl.GroupId= g.ID
								JOIN  Lectures as l ON gl.LectureId= l.ID
								JOIN  Subjects as s ON l.SubjectId= s.ID
								JOIN  Teachers as t ON l.TeacherId= t.ID
								where l.LectureRoom='A103'
