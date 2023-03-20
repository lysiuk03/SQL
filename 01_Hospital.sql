create database Hospital


create table Departments
(
ID int primary key identity ,
Building int not null check(Building>=1 AND Building<=5) ,
Financing money not null default(0) check(Financing>=0),
Name nvarchar(100) not null unique check(Name <> '')
)

create table Diseases
(
ID int primary key identity,
Name nvarchar(100) not null unique check(Name <> ''),
Severity int not null default(1) check(Severity>=1),
)

create table Doctors
(
ID int primary key identity,
Name nvarchar(max) not null check(Name <> ''),
Phone char(10) not null,
Salary money not null check(Salary>=1),
Surname nvarchar(max) not null check(Surname <> ''),
)

create table Examinations
(
ID int primary key identity,
DayOfWeek int not null check(DayOfWeek between 1 AND 7),
EndTime time not null,
Name nvarchar(100) not null unique check(Name <> ''),
StartTime time not null check(StartTime between '8:00' AND '18:00'),
check(EndTime>StartTime)
)
