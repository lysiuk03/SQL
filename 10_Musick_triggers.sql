create database [MusicCollection]
go
use [MusicCollection]
go

create table [Styles]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(50) not null check ([Name] <> N'')
);
go
create table [Performers]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(50) not null check ([Name] <> N'')
);
go
create table [Publishers]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Country] nvarchar(max) not null check ([Country] <> N'')
);
go

insert into Styles ([Name]) values ('Dark Power Pop');
insert into Styles ([Name]) values ('Small-spotted genet');
insert into Styles ([Name]) values ('Stone sheep');
insert into Styles ([Name]) values ('Zebra, common');
insert into Styles ([Name]) values ('Ibis, puna');
insert into Styles ([Name]) values ('Marten, american');
insert into Styles ([Name]) values ('Swallow (unidentified)');
insert into Styles ([Name]) values ('Mynah, common');
insert into Styles ([Name]) values ('White-fronted bee-eater');
insert into Styles ([Name]) values ('Black-backed magpie');
go


insert into [Performers] ([Name]) values ('The Beatles');
insert into [Performers] ([Name]) values ('Lexis Chell');
insert into [Performers] ([Name]) values ('Alena Giorgeschi');
insert into [Performers] ([Name]) values ('Trstram Willan');
insert into [Performers] ([Name]) values ('Rob Jore');
insert into [Performers] ([Name]) values ('Carr Fetherston');
insert into [Performers] ([Name]) values ('Nannette Bealing');
insert into [Performers] ([Name]) values ('Gustavo Nell');
insert into [Performers] ([Name]) values ('Fernande Harrie');
insert into [Performers] ([Name]) values ('Wynne Firebrace');
go

insert into [Publishers] ([Name], [Country]) values ('Pixope', 'China');
insert into [Publishers] ([Name], [Country]) values ('Dynava', 'South Africa');
insert into [Publishers] ([Name], [Country]) values ('Yakidoo', 'Iran');
insert into [Publishers] ([Name], [Country]) values ('Thoughtblab', 'China');
insert into [Publishers] ([Name], [Country]) values ('Tagcat', 'Burkina Faso');
insert into [Publishers] ([Name], [Country]) values ('Bluejam', 'Poland');
insert into [Publishers] ([Name], [Country]) values ('Linkbridge', 'Honduras');
insert into [Publishers] ([Name], [Country]) values ('Yacero', 'China');
insert into [Publishers] ([Name], [Country]) values ('Feedfire', 'Sierra Leone');
insert into [Publishers] ([Name], [Country]) values ('BlogXS', 'United States');
go

create table [MusicDiscs]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(50) not null check ([Name] <> N''),
	[PerformerId] int not null references [Performers]([Id]),
	[ReleaseDate] date not null check ([ReleaseDate] <= GETDATE()),
	[StyleId] int not null references [Styles]([Id]),
	[PublisherId] int not null references [Publishers]([Id]),
);
go
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('Beeep', 1, '2022-05-30', 9, 1);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('Zyclara', 6, '2019-04-03', 9, 2);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('Golden Pear Antibacterial Foaming Hand Wash', 5, '2020-08-09', 10, 8);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('GENOTROPIN', 1, '2019-06-20', 3, 8);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('Venlafaxine hydrochloride', 8, '2020-12-31', 10, 2);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('SHISEIDO URBAN ENVIRONMENT', 4, '2021-04-12', 9, 2);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('Treatment Set TS346963', 10, '2019-10-23', 5, 1);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('good neighbor pharmacy pain relief pm', 2, '2020-02-15', 9, 5);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('WHP Be gone Hot Flashes', 9, '2019-03-19', 8, 1);
insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('CALCAREA FLUORICA', 7, '2019-10-17', 1, 8);


create table [Songs]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(50) not null check ([Name] <> N''),
	[Duration] time not null check ([Duration] > '00:01'),
	[Rating] float null check([Rating] BETWEEN 1 AND 10),
	[MusicDiscId] int not null references [MusicDiscs]([Id])
);
go
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Paleface', '1:06', 6.5, 2);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Snow Lichen', '1:07', 9.2, 8);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Polkadots', '1:02', 9.7, 5);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Hester''s Foxtail Cactus', '1:02', 5.5, 9);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Entelea', '1:02', 4.6, 2);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Stinging Serpent', '1:04', 8, 4);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Pauper''s-tea', '1:05', 9, 6);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Honeysuckle', '1:05', 7.7, 10);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('Eggbract Sedge', '1:08', 9.9, 5);
insert into [Songs] ([Name], [Duration], [Rating], [MusicDiscId]) values ('James'' Buckwheat', '1:05', 9.9, 7);
go

select *
from [Styles];

select *
from [Publishers]

select *
from [Performers];

select *
from [MusicDiscs];

select *
from [Songs]

/*Triggers*/
-------------------------------
create trigger tg_existing_album
on MusicDiscs
after insert
as
if exists (select i.Id
			   from MusicDiscs as md,inserted as i 
			   where md.Name = i.Name AND md.Id <> i.Id)
	begin
		raiserror('Dont insert disc twice!', 12, 1)
		rollback transaction;
	end;

insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('Zyclara', 6, '2019-04-03', 9, 2);
-------------------------------
create trigger tg_no_del_beatles
on MusicDiscs
after delete
as
if exists (select *
			   from deleted as d JOIN  Performers as p ON d.PerformerId=p.Id
			   where p.Name='The Beatles')
	begin
		raiserror('Dont delete the Beatles!', 12, 1)
		rollback transaction;
	end;

delete
from MusicDiscs 
where (select top 1 md.Id 
		from MusicDiscs as md JOIN Performers as p ON md.PerformerId=p.Id
		where p.Name='The Beatles')=MusicDiscs.Id

-------------------------------
create table Archive
(
	Id int identity primary key,
	Message nvarchar(100) NOT NULL,
	Date datetime default(getdate()) NOT NULL
)

select * from Archive

create trigger tg_discs_archive
on MusicDiscs
after delete
as
insert into Archive (Message)
	select 'Disc ' + Name + ' was deleted!'
	from deleted

delete
from MusicDiscs 
where Id=3;
-------------------------------
create trigger tg_nostyle_dark
on MusicDiscs
after insert
as
if exists (	select *
			from inserted as i JOIN  Styles as s ON i.StyleId=s.Id
			where  s.Name='Dark Power Pop')
begin
	raiserror('Dont add style Dark Power Pop!', 12, 1)
	rollback transaction;
end;

insert into [MusicDiscs] ([Name], [PerformerId], [ReleaseDate], [StyleId], [PublisherId]) values ('FLUORICA', 7, '2019-10-17', 1, 8);
-------------------------------
