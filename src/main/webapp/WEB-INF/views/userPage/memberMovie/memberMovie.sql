select case
	when age < 10 then '10대'
	when age < 20 then '20대'
	when age < 30 then '30대'
	when age < 40 then '40대'
	when age < 50 then '50대'
	end as age_group,
	count(*) cnt
from (select * , floor(date_format(not(),'%Y')-substring()))

select a.*, floor(date_format(now(),'%Y')-substring(birthday,1,4)) from member2 as a, (select memberMid from reservation2 where groupId like '%_%_%_346698') as b where mid=memberMid;
	

select case
	when age < 20 then '10대'
	when age < 30 then '20대'
	when age < 40 then '30대'
	when age < 50 then '40대'
	when age >= 50 then '50대'
	end as age_group,
	count(*) cnt
from 
	(select a.*, floor(date_format(now(),'%Y')-substring(birthday,1,4)) as age from member2 as a, 
	(select memberMid from reservation2 where groupId like '%_%_%_346698') as b where mid=memberMid) as c 
group by age_group;


select 
sum(DECODE(gender, '남자', 1, 0)) ,sum(DECODE(gender, '여자', 1, 0)) 
from (select * from member2 as a, (select memberMid from reservation2 where groupId like '%_%_%_346698') as b where a.mid=b.memberMid) as test


select count(*) as total, 
sum(if(gender='남자', 1,0))as male, 
sum(if(gender='여자', 1,0))as female
from (select * from member2 as a,
(select memberMid from reservation2 where groupId like '%_%_%_346698') as b where a.mid=b.memberMid) as c;





select * from (select * from member2 as a, (select memberMid from reservation2 where groupId like '%_%_%_346698') as b where a.mid=b.memberMid) as test;

select count(*) from reservation2 where groupId like '2023-07-28_%' ;

select * from movie2 where title like concat('%','a','%') order by release_date desc;