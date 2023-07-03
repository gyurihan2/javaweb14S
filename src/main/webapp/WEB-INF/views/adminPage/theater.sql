show tables;

/* 상영관 테이블*/
create table theater(
	idx int not null auto_increment primary key,
	name int(5) not null,
	thema varchar(10) not null,
	work char(5) not null default 'NO',
	price int(10) not null,
	seat int(5) not null,
	regDate datetime not null default now(),
	modifyDate datetime not null default now(),
	UNIQUE KEY unique_name (name)
);


desc theater;