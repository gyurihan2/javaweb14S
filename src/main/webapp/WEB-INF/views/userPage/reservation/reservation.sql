show tables;

drop table reservation2;

create table reservation2(
idx varchar(50) not null primary key,
groupId varchar(50) not null,
scheduleIdx int not null,
memberMid varchar(20) not null,
seatInfo varchar(50) not null unique,
adultCnt int not null,
childCnt int not null,
reserDate datetime not null default now(),
FOREIGN KEY(scheduleIdx) REFERENCES schedule(idx) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY(memberMid) REFERENCES member(mid) ON UPDATE CASCADE ON DELETE RESTRICT
);

desc reservation2;


select seatInfo from reservation2 where groupId='aa';

/*myPage에 표시할 예약 목록 */
select a.*, b.* from reservation as a, schedule as b where memberMid='admin' and b.idx=a.scheduleIdx;

select a.*, b.screenOrder,b.playDate, b.playTime, b.endTime, b.movieIdx,
(select name from theater2 where idx=b.theaterIdx) as theaterName,
(select name from thema2 where idx=(select themaIdx from theater2 where idx=b.theaterIdx)) as themaName,
(select title from movie2 where idx=b.movieIdx) as movieName,
(select main_poster from movie2 where idx=b.movieIdx) as moviePoster
from reservation2 as a, schedule2 as b where memberMid='admin' and b.idx=a.scheduleIdx order by b.playDate desc, b.playTime;

(select name from thema2 where idx=(select themaIdx from theater2 where idx=5));

/* 예약 상세 보기*/
select a.*, b.screenOrder,b.playDate, b.playTime, b.endTime, b.movieIdx,
(select name from theater2 where idx=b.theaterIdx) as theaterName,
(select name from thema2 where idx=(select themaIdx from theater2 where idx=b.theaterIdx)) as themaName,
(select title from movie2 where idx=b.movieIdx) as movieName,
(select main_poster from movie2 where idx=b.movieIdx) as moviePoster
from reservation2 as a, schedule2 as b where a.idx='admin_6aa72_661' and b.idx=a.scheduleIdx ;











