show tables;

drop table reservation;

create table reservation(
idx int not null primary key auto_increment,
groupId varchar(50) not null,
scheduleIdx int not null,
memberMid varchar(20) not null,
seatInfo varchar(50) not null,
seatCnt int not null,
reserDate datetime not null default now(),
FOREIGN KEY(scheduleIdx) REFERENCES schedule(idx) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY(memberMid) REFERENCES member(mid) ON UPDATE CASCADE ON DELETE RESTRICT
);

desc reservation;