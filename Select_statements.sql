-- Select all columns from table
select * 
from public.example_table; 
-- Select values over two columns
select first_name, last_name  
from public.example_table;
-- Select top 3 row
select * 
from public.example_table
limit 3;

-- Select distinct values from one column
select distinct first_name 
from public.example_table;
-- Select distinct values over two columns
select distinct first_name, last_name  
from public.example_table;

/* WHERE */
select first_name, last_name, weight 
from public.example_table
where first_name = 'Anders';

select first_name, height, weight 
from public.example_table
where height > 169;

select first_name, height, weight 
from public.example_table
where (height > 170) and (first_name = 'Anders');

select first_name, height, weight 
from public.example_table
where (height > 170) or (first_name = 'Anders');

select first_name, height, date_birth 
from public.example_table
where date_birth between '1989-06-21' and '2001-06-22';

select first_name, height, date_birth 
from public.example_table
where date_birth not between '1989-06-21' and '2001-06-22';

/*ORDER BY */
select first_name, date_birth 
from public.example_table
order by date_birth;

select first_name, date_birth 
from public.example_table
order by date_birth desc;

select first_name, height 
from public.example_table
order by first_name, height;

select first_name, height
from public.example_table
order by height, first_name;

/* Group BY*/
select first_name, max(height)
from public.example_table
group by first_name;

select first_name, min(height) 
from public.example_table
group by first_name;

select first_name, sum(height) 
from public.example_table
group by first_name;

select first_name, last_name, sum(height) 
from public.example_table
group by first_name, last_name;

select first_name, count(first_name) 
from public.example_table
group by first_name;

select first_name, count(height) 
from public.example_table
group by first_name;

/* HAVING */
select first_name, count(height) 
from public.example_table
group by first_name
having count(height) > 1;

select first_name, sum(height) 
from public.example_table
group by first_name
having sum(height) < 200;

/* Case when */
select first_name, gender, 
	case gender
		when '0' then 'Male'
		when '1' then 'Female'
	end	as gender_new
from public.example_table;

-- Find average
select avg(height) from public.example_table;
-- Classify in terms of average using case when
select first_name, last_name, height, 
	case
		when height > 175 then 'Higher'
		when height = 175 then 'Average'
		when height < 175 then 'Lower'
		else 'No data'
	end as in_relation_to_average
from public.example_table;

/* MATH */
select first_name, last_name, height, 
height/100 as height_meters
from public.example_table;

select first_name, last_name, height, weight, 
(weight/(power(height/100, 2))) as bmi 
from public.example_table;
 
/* Aliases */
select first_name as fi, last_name as la
 from public.example_table; 

select *, 
	case
		when p.bmi > 25 then 'Above 25'
		when p.bmi <= 25 and p.bmi >=20 then 'Normal'
		when p.bmi < 20 then 'Under 20'
		else 'No data'
	end	bmi_classification
from (select first_name, last_name, height, weight, (weight/(power(height/100, 2))) as bmi 
	  from public.example_table) as p  