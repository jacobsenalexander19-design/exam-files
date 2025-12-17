-- Create a schema called BI
create schema BI;

-- Data types
create table BI.books (
	ID serial primary key,
	Title char(250),
	Description varchar(250),
	price decimal(5,2), 
	register_time timestamp,
	publish_date date,
	hardback boolean,
	own_ranking integer,
	own_notes text);
-- Insert into table
insert into BI.books
	values (default, 'SQL cookbook', 'Interesting read', 100.32, '2015-09-10 00:00:00', '2014-02-01', '0', 3, 'Possibly long note 1' )
	,(default, 'SQL for beginners', 'Nice introduction',  13.475, '2001-02-04 00:00:00', '1999-12-01', '1', 5, null)
	,(default, 'Advanced SQL', 'Good for the experienced user', 15, '2019-11-01 00:00:00', '2018-11-15', null, 8, 'Possibly long note 3');
-- View table
select *
from BI.books;

-- Drop table and schema
drop table BI.books;
drop schema BI;


