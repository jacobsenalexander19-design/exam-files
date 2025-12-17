-- Exercise 1
select *
from bi.Student as s 
inner join
bi.Student_course sc 
on s.student_number = sc.student_number; 

-- Exercise 2
select s.student_name,
	   sc.accepted	   
from bi.Student as s 
inner join bi.Student_course sc 
on s.student_number = sc.student_number; 

-- Exercise 3
select s.student_name,
	   c.course_name, 
	   sc.accepted	   
from bi.Student as s 
inner join
bi.Student_course sc 
on s.student_number = sc.student_number
inner join
bi.Course c  
on sc.course_id = c.course_id; 

-- Exercise 4
create view bi.vw_students_course_major as
select count(sc.student_number) as "Students applied", c.course_major 
from bi.course c 
left join bi.student_course sc 
on c.course_id = sc.course_id 
group by c.course_major;

select * from bi.vw_students_course_major;

drop view bi.vw_students_course_major;

-- Exercise 5
create view bi.vw_students_all_info as
select count(s.student_number) as "Students applied", d.department_name, c.course_name, c.course_major   
from bi.department d
left join bi.student s  
on d.department_code  = s.department_code 
left join bi.student_course sc 
on sc.student_number = s.student_number 
left join bi.course c 
on c.course_id = sc.course_id 
group by d.department_name, c.course_name, c.course_major;

select * from bi.vw_students_all_info;

-- Exercise 6
insert into bi.student 
	values (default, 'Magnus', 4);
insert into bi.student_course 
	values (5, 5, 'Accepted');

select * from bi.vw_students_all_info;

-----------------
/* The following queries is run with a connection to the dvdrental database */
-----------------

-- Exercise 7 
select count(c.customer_id) as number_rentals, c.customer_id, c.first_name  
from public.customer c 
left join public.rental r 
on c. customer_id = r.customer_id
group by c.customer_id, c.first_name 
order by number_rentals desc; 

-- Exercise 8
select count(c.customer_id), s.first_name as "Staff firstname", s.staff_id 
from public.customer c 
left join public.rental r 
on c.customer_id = r.customer_id 
left join public.staff s 
on r.staff_id = s.staff_id 
where c.customer_id = 148
group by "Staff firstname", s.staff_id;

--- Exercise 9
select avg(f.length) as "Average film length", c.customer_id, c.first_name, c.last_name
from public.customer c
left join public.rental r 
on c.customer_id = r.customer_id 
left join inventory i 
on r.inventory_id = i.inventory_id 
left join film f 
on i.film_id = f.film_id
group by c.customer_id, c.first_name, c.last_name
order by "Average film length" desc; 

--- Exercise 10
select * from public.sales_by_film_category sbfc; 
--- Shows the sales per film category. The sales is given in descending order.


-----------------
/* The following queries is run on the dim_mod schema (located in your own database) */
-----------------

--- Exercise 11
select min(dd.Date) as min_date, max(dd.Date) as max_date 
from dim_mod.Fact_OnlineSales fos 
left join dim_mod.DimDate dd 
on fos.DateKey_FK = dd.DateNum_PK; 

--- Exercise 12
select sum(UnitPrice*SalesQuantity) as "Total sales per day", dayname 
from dim_mod.Fact_OnlineSales fos 
inner join dim_mod.DimDate dd 
on fos.DateKey_FK = dd.DateNum_PK 
group by DayName
order by "Total sales per day" desc;


