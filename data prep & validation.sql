use baby_names_db;


select * from names;

select * from regions;

-- ***** Check for null values and data ranges (not the best way, but it works with this data set).
-- No 'null' values are present in the data set.
-- The variation in birth count is alarming; there might be some outliers that need further investigation.

select 
min(state) , max(state),
min(gender), max(gender),
min(year) , max(year),
min(name), max(name),
min(births) , max(births), avg(births)
 from names;
 
 -- ***** Check 'state' column
 -- The state of MI is missing in the regions table,it should be in the Midwest region
select state , count(*) from names where state not in (select state from regions) group by state;

-- Data colleced from 51 states
-- Still pops out -- > CA	178427	5	8240	78.8914 , but the total recod count is also high ,so it might not be a outlier
select state , count(*) ,min(births) , max(births), avg(births)
from names 
group by state 
order by state;

 -- ***** Check 'gender' column
 -- We only have two gender values 
 -- Female count is larger than Male count , and Female name has more variations 
 -- Male birth count is larger than Female birth count
select gender , count(*) ,min(births) , max(births), avg(births) , sum(births)
from names 
group by gender 
order by gender;

 -- ***** Check 'year' column
 -- Data in 30 years without missing any years in between
 -- Recode count was incremented over time , tells us mare variations in names
 -- No of births are around 3200000, slight incremant between 89 - 90
select year , count(*) ,min(births) , max(births), avg(births) , sum(births)
from names 
group by year 
order by year;

 -- ***** Check 'name' column
 -- Most popular name is Alexander
 -- Most spread name in Alexis
 -- Some unusual names are in data set that has single entry , might be a data entry issue -- > Alsexander	1 entry	5 births , Alessandria	1	5 ,Alexandera	1	6
select name , count(*) , sum(births)
from names 
group by name 
order by name;


-- - *** reginos table
--  duplicate names New England * New_England
select region, count(*) from regions group by region;