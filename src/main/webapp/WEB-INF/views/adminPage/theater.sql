show tables;

drop table theater;

/* 상영관 테이블*/
create table theater(
	idx int not null auto_increment primary key,
	name varchar(20) not null,
	themaIdx int,
	seat int(5) not null,
	work char(5) not null default 'NO',
	regDate datetime not null default now(),
	modifyDate datetime not null default now(),
	UNIQUE KEY unique_name (name),
	FOREIGN KEY(themaIdx) REFERENCES thema(idx) ON UPDATE CASCADE ON DELETE RESTRICT
);


desc theater; 

select a.*, b.name as themaName, b.price as themaPrice from theater a, thema b where a.themaIdx = b.idx;

/* 설정한 기간의 사용 가능한 상영관 */
select *,(select name from thema where idx=a.themaidx) as themaName from theater as a where idx not in
(select theaterIdx from schedule where playDate between '2023-05-26' and '2023-06-07' group by theaterIdx);


select *, (select price from thema where idx=themaIdx) as themaPrice from theater;
