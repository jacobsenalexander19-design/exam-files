-- Exercise 1
update bi_four.department    
set department_name = 'Computer and Data Science'
where department_code = 1; 
-- Exercise 2
update bi_four.student  
set department_code = (select d.department_code from bi_four.department d
				       where d.department_name  = 'Computer and Data Science')
where  
student_name  = 'Pia'; 

-- Exercise 3
delete 
from bi_four.student_course sc   
where  
sc.student_number  = 
		(select s.student_number 
		from bi_four.student s 
		where s.student_name = 'Pia');  

delete
from bi_four.student s
where s.student_name = 'Pia'

--- Exercise 4
create table bi_four.course_hist(
	course_hist_sk serial primary key,
	course_code_durable integer, 
	course_name varchar(250),
	course_major varchar(250),
	effective_date timestamp,
	ineffective_date timestamp,
	current_indicator boolean,
	constraint fk_course_hist foreign key (course_code_durable)
	references bi_four.course (course_id));

insert into bi_four.course_hist 
	VALUES (default, 1, 'Programming I', 'BSc in Computer Science', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 2, 'Principles of Economics', 'BSc in Economics', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 3, 'Distributed systems', 'BSc in Computer Science', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 4, 'Animal Law', 'Bsc in Law', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 5, 'Biochemistry', 'Bsc in Medicine', current_timestamp(0), '3022-10-30 23:19:23', '1');
		 
--- Create function to be used in trigger
create or replace function log_course_changes()  
  returns trigger   
  language PLPGSQL  
  as  
$$  
begin  
    if new.course_name <> old.course_name then  
    	 --- Update ineffective date and current indicator on old row
         update bi_four.course_hist    
		 set ineffective_date = now(),
		 	 current_indicator = '0'
         where course_hist_sk = (select max(course_hist_sk) 
		                             from bi_four.course_hist  ch 
                                	 where (ch.course_code_durable = old.course_id));
    	 --- Insert new values in new row
    	 insert into bi_four.course_hist(course_hist_sk, course_code_durable,
         							 course_name, course_major, 
         							 effective_date, ineffective_date, current_indicator)  
         values(default, old.course_id, new.course_name, 
                old.course_major, now(), '3022-10-30 23:19:23', '1');           
    end if;  
return new;  
end;  
$$ 

--- Create trigger
create or replace trigger log_course_changes
 before update  
 on bi_four.course  
 for each row  
 execute procedure log_course_changes();  
		 

update bi_four.course    
set course_name= 'Programming 1.01'
where course_id = 1;
		 
--- Exercise 5
select *  
from bi_five.training t  
where t.text like '%Henry%'; 

--- Exercise 6
select *  
from bi_five.training t  
where t.text like '%p_';

--- Exercise 7
explain analyze select *  
from bi_five.turkers t
order by t.phone;

explain analyze select *  
from bi_five.turkers_indexes ti
order by ti.phone;

--- Exercise 8
explain analyze select *  
from bi_five.training t  
order by t.line, t.chapter;

explain analyze select *  
from bi_five.training_indexes ti
order by ti.line, ti.chapter;
/*The line and chapter columns together hold the index*/

--- Exercise 9
explain analyze select *
from bi_five.training t
left join bi_five.turkers ts 
on t.turk_fk = ts.turk_pk
order by ts.phone;

explain analyze select *
from bi_five.training_indexes ti 
left join bi_five.turkers_indexes ti2 
on ti.turk_fk = ti2.turk_pk
order by ti2.phone;
/*After the join operation the index on the phone column is no longer used.
We cannot say that one query is in general faster than another */

--- Exercise 10
create table bi_four.Department_index (
	department_code serial primary key,
	department_name varchar(255),
	department_location varchar(255),
	last_update timestamp(0) without time zone default current_timestamp(0)
);

insert into bi_four.Department_index
	values (default, 'Computer Science', 'Aarhus C')
		  ,(default, 'Economics and Business Economics', 'Aarhus V')
		  ,(default, 'Law', 'Aarhus C')
		  ,(default, 'Medicine', 'Aarhus C');
		 
create index idx_department_name   
ON bi_four.department_index(department_name);	
