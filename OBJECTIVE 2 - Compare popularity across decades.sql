-- **** OBJECTIVE 2 : Compare popularity across decades **** **** ****
 
-- * Second objective is to find the top 3 girl names and top 3 boy names for each year,
-- * and also for each decade.
 
use baby_names_db;
 
select * from names;

-- For each year, return the 3 most popular girl names and 3 most popular boy names
select * from
(with all_names as (select year , gender , name, sum(births) no_of_births 
from names
group by year , gender , name)
	select year , gender , name,  row_number() over (partition by year , gender order by no_of_births desc) as popularity
	from all_names
)all_names_ranked
where popularity <=3;


-- For each decade, return the 3 most popular girl names and 3 most popular boy names
select * from
(with all_names as (select case when year between '1980' and '1989' then '1980s' 
								when year between '1990' and '1999' then '1990s' 
                                when year between '2000' and '2009' then '2000s' 
                                else 'None' end as decade,
							gender , name, sum(births) no_of_births 
					from names
					group by decade , gender , name)
	select decade , gender , name,  row_number() over (partition by decade , gender order by no_of_births desc) as popularity
	from all_names
)all_names_ranked
where popularity <=3;