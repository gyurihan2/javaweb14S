show tables;

select * from movie

drop table movie;

create table movie(
	idx varchar(10) not null primary key,
	title varchar(50) not null,
	main_poster varchar(50),
	poster_path varchar(500),
	tagline varchar(50),
	original_title varchar(100) not null,
	original_language varchar(10) not null,
	production_companies varchar(200),
	videos varchar(500),
	genres varchar(50),
	runtime int,
	release_date date,
	actor varchar(500),
	overview text,
	vote_average float,
	vote_count int(10),
	totalView int(10) default 0,
	rating float default 0
);

desc movie;
