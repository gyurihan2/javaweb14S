show tables;

create table member (
  idx      	int not null auto_increment, 	/* 회원 고유번호 */
  mid      	varchar(20) not null,					/* 회원 아이디(중복불허) */
  pwd     	varchar(100) not null,					/* 회원 비밀번호(SHA256 암호화 처리) */
  salt			char(8) not null,								/* 비밀번호 보안을 위한 해시키 */
  name     	varchar(20) not null,					/* 회원 성명 */
  birthday	varchar(15),
  nickName 	varchar(20) not null,
  identiNum varchar(20) not null,
  gender		varchar(5) not null,
  phone			varchar(15) not null,
  address		varchar(100) not null,
  email			varchar(50) not null,
  startDate	datetime not null default now(),
  lastLogin		datetime not null default now(),
  userDel		char(5) default 'NO',
  level			int(5) default 1,
  point			int(10) default 1000,
  totPoint	int(15) default 0,
  primary key (idx),									/* 주키 : idx(고유번호)*/
  unique key (mid)
);

drop table member;
desc member;

select * from member;
alter table member modify birthday date;