CREATE SCHEMA bi;
/*    Check   */
-- Sale table with check constraint
create table bi.sale (
    sale_id integer,
    sale_person_id integer,
    price numeric constraint positive_price check (price >= 0)
);

insert into bi.sale
	values(1, 1, 100);

insert into bi.sale
	values(2, 1, 0);

drop table bi.sale;

/*    PRIMARY KEY   */
-- Student table with primary key
create table bi.Student (
	student_id serial primary key,
	student_name varchar(255),
	department_code int);

insert into bi.Student
	values (default, 'Birgit', 2)
		  ,(default, 'Anders', 1)
		  ,(default, 'Pia', 3)
		  ,(default, 'Henrik', 3);

drop table bi.Student;

-- Composite PRIMARY KEY
create table bi.Student_course(
	student_number int,
	course_id int,
	accepted varchar(50),
	constraint PK_student_course primary key (student_number, course_id)
	);

insert into bi.student_course
	values (1, 2, 'Accepted')
		  ,(1, 3, 'Not accepted')
		  ,(2, 1, 'Accepted')
		  ,(3, 4, 'Accepted')
		  ,(3, 3, 'Awaiting')
		  ,(4, 2, 'Not accepted');
		 
drop table bi.Student_course; 
		
/*   ALTERNATE KEY   */
create table bi.app_logins (
	employee_ID serial primary key,
	username varchar(100) not null,
	password varchar(100) not null,
	constraint AK_password unique(password));

insert into bi.app_logins
	values (default, 'Simon', 'sms123#dd')
          ,(default, 'Mette', 'myunbreakablepassword123')
          ,(default, 'Christian', 'mysecretpassword11$');
       
drop table bi.app_logins;

/*   FOREIGN KEY   */

-- Student table
create table bi.Student (
	student_id serial primary key,
	student_name varchar(255),
	department_code int);

insert into bi.Student
	values (default, 'Birgit', 2)
		  ,(default,'Anders', 1)
		  ,(default, 'Pia', 3)
		  ,(default, 'Henrik', 3);
 
-- Student contact information table
 create table bi.student_contact (
	student_id int primary key,
	City varchar(100),
	Phone varchar(100),
	constraint FK_student foreign key (student_id)
	references bi.Student(student_id));


insert into bi.student_contact
   values (2,'Aarhus', '61818192')
       	  ,(3,'Vejle', '51729824')
	      ,(1,'Aarhus N', '31838102')
	      ,(4,'Aarhus V', '55018190');     
  
-- DELETE a row
delete from bi.student_contact
where student_id = 1;
	     
-- Drop tables
DROP TABLE bi.student_contact;
DROP TABLE bi.Student;



