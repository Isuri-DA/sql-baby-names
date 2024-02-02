 -- **** OBJECTIVE 1: Track changes in name popularity **** **** ****

-- * Your first objective is to see how the most popular names have changed over time, 
-- * and also to identify the names that have jumped the most in terms of popularity.

 use baby_names_db;
 
 select * from names;
 
-- Find the overall most popular girl and boy names **** ****

select  name , sum(births) as no_of_births
from names 
where gender='F' 
group by name 
order by no_of_births desc
limit 3;
-- Jessica	863121

select  name , sum(births) as no_of_births
from names 
where gender='M' 
group by name 
order by no_of_births desc
limit 3;
-- Michael	1376418

-- **** **** Show how they have changed in popularity rankings over the years **** ****
-- with CTE
select * from
(with girl_names as (select year, name , sum(births) as no_of_births
from names 
where gender='F' 
group by year,name)
select year, name , row_number() over (partition by year order by no_of_births desc) as popularity from girl_names
)girl_names_tbl 
where name='Jessica';

-- with sub-query
select * from (
select year, name , row_number() over (partition by year order by no_of_births desc) as popularity
from (
select year, name , sum(births) as no_of_births
from names 
where gender='M' 
group by year,name)boy_names
)boy_names_tbl
where name='Michael';



-- **** **** Find the names with the biggest jumps in popularity from the first year of the data set to the last year **** ****

with names_1980 as 
	( with all_1980 as (
		select  name , sum(births) as no_of_births
		from names 
		where year='1980' 
		group by name)
	select  name , row_number() over (order by no_of_births desc) as popularity from all_1980),
    names_2008 as 
	( with all_2008 as (
		select  name , sum(births) as no_of_births
		from names 
		where year='2009' 
		group by name)
	select  name , row_number() over (order by no_of_births desc) as popularity from all_2008)
    
select t1.name ,t1.popularity , t2.name ,t2.popularity,
(cast(t2.popularity as signed) - cast(t1.popularity as signed)) as diff
from names_1980 t1 INNER JOIN names_2008 t2
ON t1.name = t2.name
-- where  t1.name= 'Michael'
order by diff;

