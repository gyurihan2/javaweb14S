show tables;

select * from movie2

drop table schedule2;

create table schedule2(
	idx int(10) not null primary key auto_increment,
	theaterIdx int not null,
	groupId varchar(30) not null,
	playDate date not null,
	movieIdx varchar(10) not null,
	screenOrder int(5) not null,
	playTime time not null,
	endTime time not null,
	leftSeat int(5)  not null,
	waitTime time not null default 20,
	UNIQUE KEY unique_group (theaterIdx,movieIdx,playDate,screenOrder),
	FOREIGN KEY(theaterIdx) REFERENCES theater(idx) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(movieIdx) REFERENCES movie(idx) ON UPDATE CASCADE ON DELETE RESTRICT
);

desc schedule2;

/* 달력에 표시할 스케줄 리스트*/
select a.*,(select name from theater2 where idx=a.theaterIdx) as theaterName, (select title from movie2 where idx=a.movieIdx) as movieTitle from schedule2 as a where playDate like '2023-07%' group by (theaterIdx);
select a.*,(select name from theater2 where idx=a.theaterIdx) as theaterName, (select title from movie2 where idx=a.movieIdx) as movieTitle from schedule2 as a   group by (groupId) order by playDate, a.theaterIdx ;

/* 해당 일 선택시 해당일 스케줄 리스트*/
select a.*,
(select name from theater2 where idx=a.theaterIdx) as theaterName ,
(select work from theater2 where idx=a.theaterIdx) as theaterWork ,
(select name from thema2 as b where idx=(select themaIdx from theater2 where idx=a.theaterIdx)) as test,
(select title from movie2 where idx=a.movieIdx) as movieTitle, 
(select main_poster from movie2 where idx=a.movieIdx) as main_poster 
from schedule2 as a where playDate ='2023-07-20' order by theaterName, screenOrder;

select * from theater2;
/**/
select * from movie2 as a ,(select movieIdx, theaterIdx from schedule2 where playDate ='2023-07-19' group by movieidx) as b where a.idx = b.movieIdx order by b.theaterIdx;


select * from schedule2 where movieIdx='783110' and playDate='2023-07-27' group by movieIdx

/*관리자 메인 페이지 각 상영관 상영 영화 정보*/
select movieIdx,(select title from movie2 where idx=movieIdx) as movieTitle
from schedule2 where playDate='2023-07-29' group by movieIdx order by theaterIdx

select * from reservation2
select * from schedule2


783110
2023-07-27
select 1+2 from dual;
