/* Delete tables if they already exist */
drop table if exists bi.left_table;
drop table if exists bi.right_table;
drop table if exists bi.Student_course cascade;
drop table if exists bi.Student;
drop view bi.vw_department;
drop table if exists bi.Department;
drop table if exists bi.course;
drop table if exists bi.Student_1;
drop table if exists bi.Department_1;

/* Create tables for joins */
-- Left table
create table bi.left_table( 
	ID integer,
	val varchar(10));
insert into bi.left_table
	values (1, 'L1')
		  ,(2, 'L2')
		  ,(3, 'L3')
		  ,(4, 'L4');
		 
-- Left table
create table bi.right_table( 
	ID integer,
	val varchar(10));

insert into bi.right_table
	values (5, 'R1')
		  ,(3, 'R2')
		  ,(6, 'R3')
		  ,(1, 'R4');

-- Department table
create table bi.Department (
	department_code serial primary key,
	department_name varchar(255),
	department_location varchar(255)
);

insert into bi.Department
	values (default, 'Computer Science', 'Aarhus C')
		  ,(default, 'Economics and Business Economics', 'Aarhus V')
		  ,(default, 'Law', 'Aarhus C')
		  ,(default, 'Medicine', 'Aarhus C');


-- Student table
create table bi.Student (
	student_number serial primary key,
	student_name varchar(255),
	department_code integer,
	constraint FK_department_code foreign key(department_code)
	references bi.Department (department_code)
);

insert into bi.Student
	values (default, 'Birgit', 2)
		  ,(default,'Anders', 1)
		  ,(default,'Pia', 3)
		  ,(default,'Henrik', 3);

-- Course
create table bi.Course(
	course_id serial primary key,
	course_name varchar(250),
	course_major varchar(250)
);

insert into bi.Course 
	VALUES (default, 'Programming I', 'BSc in Computer Science')
		  ,(default, 'Principles of Economics', 'BSc in Economics')
		  ,(default, 'Distributed systems', 'BSc in Computer Science')
		  ,(default, 'Animal Law', 'Bsc in Law')
		  ,(default, 'Biochemistry', 'Bsc in Medicine');
		  
-- Student course
create table bi.Student_course(
	student_number integer,
	course_id integer,
	accepted varchar(50),
	constraint PK_student_course primary key (student_number, course_id),
	constraint FK_student_number foreign key (student_number)
	references bi.Student (student_number),
	constraint FK_course_id foreign key (course_id)
	references bi.Course (course_id)
	);

insert into bi.student_course
	values (1, 2, 'Accepted')
		  ,(1, 3, 'Not accepted')
		  ,(2, 1, 'Accepted')
		  ,(3, 4, 'Accepted')
		  ,(3, 3, 'Awaiting')
		  ,(4, 2, 'Not accepted');


/* Tables for full join */
-- Department table
create table bi.Department_1 (
	department_code serial primary key,
	department_name varchar(255),
	department_location varchar(255)
);

insert into bi.Department_1
	values (default, 'Computer Science', 'Aarhus C')
		  ,(default, 'Economics and Business Economics', 'Aarhus V')
		  ,(default, 'Law', 'Aarhus C')
		  ,(default, 'Medicine', 'Aarhus C');


-- Student table
create table bi.Student_1 (
	student_number serial primary key,
	student_name varchar(255),
	department_code integer,
	constraint FK_department1_code foreign key(department_code)
	references bi.Department_1 (department_code)
);

insert into bi.Student_1
	values (default, 'Birgit', 2)
		  ,(default, 'Anders', 1)
		  ,(default, 'Pia', 3)
		  ,(default, 'Henrik', 3)
		  ,(default, 'Per', NULL);		 
		 
		 
