show tables;

create table thema(
	idx int(5) not null primary key auto_increment,
	name varchar(20) not null,
	price int(10) not null,
	content text,
	hashTag varchar(50),
	display char(10) default 'NO',
	mainImg varchar(50) not null,
	images varchar(500) not null,
	imgFName varchar(500) not null,
	regDate datetime not null default now(),
	modifyDate datetime not null default now()
);

drop table thema;

desc thema;

update thema set images=concat(images,'con') where idx=9;

select * from thema where display = 'YES';