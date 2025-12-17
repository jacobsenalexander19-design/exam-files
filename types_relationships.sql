/*-- One-to-one Identifying relationship */
-- Student table
create table bi.Student (
	student_id serial primary key,
	student_name varchar(255),
	department_code int);

insert into bi.Student
	values (default, 'Birgit', 2)
		  ,(default, 'Anders', 1)
		  ,(default, 'Pia', 3)
		  ,(default, 'Henrik', 3);
 
-- Student contact information table
create table bi.student_contact (
	student_id serial primary key,
	City varchar(100),
	Phone varchar(100),
	constraint FK_student foreign key (student_id)
	references bi.Student(student_id));

insert into bi.student_contact
   values (2,'Aarhus', '61818192')
       	  ,(3,'Vejle', '51729824')
	      ,(1,'Aarhus N', '31838102')
	      ,(4,'Aarhus V', '55018190');     

-- Drop tables
drop table bi.student_contact;
drop table bi.Student;
	     
/*-- One-to-many nonidentifying mandatory relationship */

-- Student table
create table bi.Student (
	student_id serial primary key,
	student_name varchar(255),
	department_code int);

insert into bi.Student
	values (default, 'Birgit', 2),
		  (default, 'Anders', 1),
		  (default, 'Pia', 3),
		  (default, 'Henrik', 3);
		 
-- Student book order table     
create table bi.book_sales_order (
	book_sales_id serial primary key,
	student_id int not null,
	constraint FK_book_student_id foreign key (student_id)
	references bi.Student(student_id));

insert into bi.book_sales_order 
   values (default, 2), 
  		  (default, 2),
  		  (default, 1), 
  		  (default, 2),
  		  (default, 3),
  		  (default, 4), 
  		  (default, 3);

-- Drop tables
drop table bi.book_sales_order;
drop table bi.Student;

/*-- One-to-many nonidentifying optional relationship */
-- Department table 
create table bi.Department (
	department_code serial primary key,
	deparment_name varchar(255));
	
insert into BI.Department
	values (default, 'Computer Science'),
		  (default, 'Economics and Business Economics'),
		  (default, 'Law'),
		  (default, 'Medicine');
		 
-- Student table 
create table bi.Student (
	student_id serial primary key,
	student_name varchar(255),
	department_code int,
	constraint FK_department foreign key (department_code)
	references bi.department(department_code));

insert into BI.Student
	values (default, 'Birgit', 2)
		  ,(default, 'Anders', 1)
		  ,(default, 'Pia', 3)
		  ,(default, 'Henrik', null);

-- Drop tables
drop table bi.Student;
drop table bi.Department; 

/* Many-to-many relationship */
-- Books table
create table bi.books (
	ID serial primary key,
	Title char(250),
	Description varchar(250));

insert into bi.books
	values (default, 'SQL cookbook', 'Interesting read')
	,(default, 'SQL for beginners', 'Nice introduction')
	,(default, 'Advanced SQL', 'Good for the experienced user');

-- Author table
create table bi.authors (
	ID serial primary key,
	Name varchar(250));

insert into bi.authors
	values (default, 'Lynn Beighley')
		  ,(default, 'Anthony DeBarros')
		  ,(default, 'Thomas Nield');

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
	,(3,1);

select * from bi.books_authors;
select * from bi.authors;
select * from bi.books;

-- Drop tables
drop table bi.books_authors;
drop table bi.authors;
drop table bi.books;



	      