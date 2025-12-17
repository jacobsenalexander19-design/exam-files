-----------------
/* Like */ -- Use dvdrental database
-----------------
-- Upper case vs. lower case. match beginning of string
select *  
from bi_five.training t  
where t.text like 'Whi%';  

select *  
from bi_five.training t  
where t.text like 'whi%';  

-- Match end of string
select *  
from bi_five.training t  
where t.text like '%Dashwood';  

-- Match anywhere in the string
select *  
from bi_five.training t  
where t.text like '%Dashwood%';  

-- Match on any one character. Beginning of string
select *  
from bi_five.training t  
where t.text like '_s%';

-- Match on any one character. End of string
select *  
from bi_five.training t  
where t.text like '%_s';

-- Use escape character to match e.g. % and _
-- Match %
select *  
from bi_five.training t  
where t.text like '%\%';

-- Match _
select *  
from bi_five.training t  
where t.text like '\_%';

-- Match \
select *  
from bi_five.training t  
where t.text like '%\\%';

-----------------
/* Indexes */
-----------------
--if you want to delete schema: drop schema bi cascade;
--Recreating bi schema: create schema bi;
-- Create a table
create table bi.department (
	department_code serial primary key,
	department_name varchar(255),
	department_location varchar(255)
);
-- Insert into table
insert into bi.Department
	values (default, 'Computer Science', 'Aarhus C')
		  ,(default, 'Economics and Business Economics', 'Aarhus V')
		  ,(default, 'Law', 'Aarhus C');
-- Create index		 
create index idx_department_name   
on bi.department(department_name);
-- Drop index
drop index bi.idx_department_name;

-- Use the bi_five schema in the dvdrental database
-- testing on id column - already indexes as it is primary key
explain analyze select *  
from bi_five.training t  
where t.text_sk > 132 and t.text_sk < 52000
order by t.text_sk;

explain analyze select *  
from bi_five.training_indexes ti
where ti.text_sk > 132 and ti.text_sk < 52000
order by ti.text_sk;

-- Testing on text column
explain analyze select *  
from bi_five.training t  
order by t.text;

explain analyze select *  
from bi_five.training_indexes ti
order by ti.text;
