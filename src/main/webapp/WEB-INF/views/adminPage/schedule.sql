show tables;

select * from movie

drop table schedule;

create table schedule(
	idx varchar(10) not null primary key,
	theaterIdx int not null,
	groupId varchar(30) not null,
	playDate date not null,
	movieIdx varchar(10) not null,
	screenOreder int(5) not null,
	playTime time not null,
	title varchar(100) not null,
	leftSeat int(5)  not null,
	waitTime time not null,
	UNIQUE KEY unique_group (groupId,movieIdx,playDate,screenOreder),
	FOREIGN KEY(theaterIdx) REFERENCES theater(idx) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(movieIdx) REFERENCES movie(idx) ON UPDATE CASCADE ON DELETE RESTRICT
);

desc schedule;
