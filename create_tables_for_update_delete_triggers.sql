/* Delete schema and recreate */
drop schema if exists bi_four cascade;
create schema bi_four;

-- Department table
create table bi_four.Department (
	department_code serial primary key,
	department_name varchar(255),
	department_location varchar(255),
	last_update timestamp(0) without time zone default current_timestamp(0)
);

insert into bi_four.Department
	values (default, 'Computer Science', 'Aarhus C')
		  ,(default, 'Economics and Business Economics', 'Aarhus V')
		  ,(default, 'Law', 'Aarhus C')
		  ,(default, 'Medicine', 'Aarhus C');


-- Student table
create table bi_four.Student (
	student_number serial primary key,
	student_name varchar(255),
	department_code integer,
	last_update timestamp(0) without time zone default current_timestamp(0),
	constraint FK_department_code foreign key(department_code)
	references bi_four.Department (department_code)
);

insert into bi_four.Student
	values (default, 'Birgit', 2)
		  ,(default,'Anders', 1)
		  ,(default,'Pia', null)
		  ,(default,'Henrik', 3);

-- Course
create table bi_four.Course(
	course_id serial primary key,
	course_name varchar(250),
	course_major varchar(250),
	last_update timestamp(0) without time zone default current_timestamp(0)
);

insert into bi_four.Course 
	VALUES (default, 'Programming I', 'BSc in Computer Science')
		  ,(default, 'Principles of Economics', 'BSc in Economics')
		  ,(default, 'Distributed systems', 'BSc in Computer Science')
		  ,(default, 'Animal Law', 'Bsc in Law')
		  ,(default, 'Biochemistry', 'Bsc in Medicine');
		  
-- Student course
create table bi_four.Student_course(
	student_number integer,
	course_id integer,
	accepted varchar(50),
	last_update timestamp(0) without time zone default current_timestamp(0),
	constraint PK_student_course primary key (student_number, course_id),
	constraint FK_student_number foreign key (student_number)
	references bi_four.Student (student_number),
	constraint FK_course_id foreign key (course_id)
	references bi_four.Course (course_id)
	);

insert into bi_four.student_course
	values (1, 2, 'Accepted')
		  ,(1, 3, 'Not accepted')
		  ,(2, 1, 'Accepted')
		  ,(3, 4, 'Accepted')
		  ,(3, 3, 'Awaiting')
		  ,(4, 2, 'Not accepted');

-- Department SCD 2
create table bi_four.department_hist (
	department_hist_sk serial primary key,
	department_code_durable integer,
	department_name varchar(255),
	department_location varchar(255),
	effective_date timestamp,
	ineffective_date timestamp,
	current_indicator boolean,
	constraint fk_department_hist foreign key (department_code_durable)
	references bi_four.department (department_code));

insert into bi_four.Department_hist
	values (default, 1, 'Computer Science', 'Aarhus C', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 2, 'Economics and Business Economics', 'Aarhus V', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 3, 'Law', 'Aarhus C', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 4, 'Medicine', 'Aarhus C', current_timestamp(0), '3022-10-30 23:19:23', '1');

		 
		 
