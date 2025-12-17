/* Exercise 1*/
create table bi.Employee (
	id serial primary key,
	name varchar(255),
	business_unit varchar(255));

insert into bi.Employee
	values (default, 'John', 'HR'),
		  (default, 'Michelle', 'HR'),
		  (default, 'Eric', 'R&D'),
		  (default, 'Rebecca', 'R&D');
/* Exercise 2 */
create table bi.Employee_contact (
	employee_id integer PRIMARY KEY,
	phone varchar(255),
	mail varchar(255),
	constraint FK_employee_id foreign key (employee_id)
	references bi.Employee (id)
	);
/* Exercise 3 */
insert into bi.Employee_contact
	values (1, '317-417-1320', 'mailtoJohn934@hotmail.com');
-- Any value not present in the bi.employee.id column cannot be inserted
-- in the bi.employee_contact.employee_id column.

drop table BI.Employee_contact;
drop table BI.Employee;

/* Exercise 4 */
-- Tables with composite primary keys: film_actor, film_category

/* Exercise 5 */
-- Identifying relation 1: film_actor.film_id --> film.film_id
-- Identifying relation 2: film_category.category_id --> category.category_id
-- Non-identifying mandatory relation: payment.staff_id --> staff.staff_id

/* Exercise 6 */
-- Non-identifying optional relation

/* Exercise 7 */
-- Books table
create table bi.books (
	ID serial primary key,
	Title char(250),
	Description varchar(250));

insert into bi.books
	values (default, 'SQL cookbook', 'Interesting read'),
	(default, 'SQL for beginners', 'Nice introduction'),
	(default, 'Advanced SQL', 'Good for the experienced user'),
	(default, 'Database Systems for real', 'Very detailed and good');

-- Author table
create table bi.authors (
	ID serial primary key,
	Name varchar(250));

insert into bi.authors
	values (default, 'Lynn Beighley'),
		  (default, 'Anthony DeBarros'),
		  (default, 'Thomas Nield'),
		  (default, 'Ramez Elmasri');

-- Junction table (book_author)
create table bi.books_authors (
	book_ID int,
	author_ID int,
constraint pk_books_authors primary key (book_ID, author_ID),	
constraint fk_authors foreign key (author_ID)
references bi.authors(ID),
constraint fk_book foreign key (book_ID)
references bi.books(ID)
);

insert into BI.books_authors
	values (1, 2)
	,(1,3)
	,(2,2)
	,(3,1)
	,(4,3)
	,(4,4);

select * from bi.books_authors;
select * from bi.authors;
select * from bi.books;

-- Drop tables
drop table bi.books_authors;
drop table bi.authors;
drop table bi.books;



/* Exercise 8*/

-- Department table
create table bi.Department (
	department_code serial primary key,
	deparment_name varchar(255),
	department_location varchar(255)
);

insert into BI.Department
	values (default, 'Computer Science', 'Aarhus C'),
		  (default, 'Economics and Business Economics', 'Aarhus V'),
		  (default, 'Law', 'Aarhus C'),
		  (default, 'Medicine', 'Aarhus C');


-- Student table
create table bi.Student (
	student_number serial primary key,
	student_name varchar(255),
	department_code integer,
	constraint FK_department_code foreign key(department_code)
	references BI.Department (department_code)
);

insert into BI.Student
	values (default, 'Birgit', 2),
		  (default, 'Anders', 1),
		  (default, 'Pia', 3),
		  (default, 'Henrik', 3);

-- Course
create table BI.Course(
	course_id serial primary key,
	course_name varchar(250),
	course_major varchar(250)
);

insert into bi.Course 
	values (default, 'Programming I', 'BSc in Computer Science')
		  ,(default, 'Principles of Economics', 'BSc in Economics')
		  ,(default, 'Distributed systems', 'BSc in Computer Science')
		  ,(default, 'Animal Law', 'Bsc in Law')
		  ,(default, 'Biochemistry', 'Bsc in Medicine')
		  
-- Student course
create table BI.Student_course(
	student_number integer,
	course_id integer,
	accepted varchar(50),
	constraint PK_student_course primary key (student_number, course_id),
	constraint FK_student_number foreign key (student_number)
	references BI.Student (student_number),
	constraint FK_course_id foreign key (course_id)	
	references BI.Course (course_id)
	);

insert into BI.student_course
	values (1, 2, 'Accepted')
		  ,(1, 3, 'Not accepted')
		  ,(2, 1, 'Accepted')
		  ,(3, 4, 'Accepted')
		  ,(3, 3, 'Awaiting')
		  ,(4, 2, 'Not accepted');
-- Drop tables
drop table BI.Student_course;
drop table BI.course;
drop table BI.Student;
drop table BI.Department;

/* Exercise 9 */
/* Creating intital table */
create table bi.leads(
	employee_id integer primary key,
	employee_name varchar(250),
	lead_responsible boolean,
	unit_name varchar(250),
	unit_city varchar(250),
	customer_id1 integer,
	customer_name1 varchar(250),
	customer_id2 integer,
	customer_name2 varchar(250),
	customer_id3 integer,
	customer_name3 varchar(250)
);

insert into bi.leads 
	values (1, 'John Smith', 'TRUE', 'Sales', 'Aarhus', 1, 'Danske Commodities', null, null, null, null),
		   (2, 'Vicki Adams', 'TRUE', 'Marketing', 'Copenhagen', null, null, 2, 'Copenhagen Economics', null, null),
		   (3, 'Jane Morgan', 'FALSE', 'Marketing', 'Copenhagen', null, null, 2, 'Copenhagen Economics', null, null),
           (4, 'Dennis Shoemaker', 'TRUE', 'Business Intelligence', 'Aalborg', null, null, null, null, 3, 'Aalborg Portland');

select * from bi.leads;
drop table bi.leads;	

/* In 3NF */
-- Unit
create table bi.unit(
	unit_id integer primary key,
	unit_name varchar(250),
	unit_city varchar(250));
	
insert into bi.unit
values (1, 'Sales', 'Aarhus'),
	   (2, 'Marketing', 'Copenhagen'),
	   (3, 'Business Intelligence', 'Aalborg');


-- Customers
create table bi.potential_customers(
	customer_id integer primary key,
	customer_name varchar(250));
	
insert into bi.potential_customers
values (1, 'Danske Commodities'),
	   (2, 'Copenhagen Economics'),
	   (3, 'Aalborg Portland');
	  
-- Employee
create table bi.employee(
	employee_id integer primary key,
	employee_name varchar(250),
	unit_id integer,
	constraint FK_unit_id foreign key (unit_id)
	references bi.unit (unit_id)
);

insert into bi.employee
values (1, 'John Smith', 1),
	   (2, 'Vicki Adams', 2),
	   (3, 'Jane Morgan', 2),
       (4, 'Dennis Shoemaker', 3);
	  
-- Leads
create table bi.leads_junction(
	employee_id integer,
	customer_id integer,
	lead_responsible boolean,
	constraint PK_leads primary key (employee_id, customer_id),
	constraint FK_employee_id foreign key (employee_id)
	references bi.employee (employee_id),
	constraint FK_customer_id foreign key (customer_id)
	references bi.potential_customers (customer_id)
);

insert into bi.leads_junction
values (1, 1, 'TRUE'),
	   (2, 2, 'TRUE'),
	   (3, 2, 'FALSE'),
	   (4, 3, 'TRUE');

drop table bi.leads_junction;
drop table bi.potential_customers;
drop table bi.employee;
drop table bi.unit;


