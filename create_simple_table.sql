-- Create table in public schema
create table public.example_table (
	id serial primary key,
	first_name varchar(255),
	last_name varchar(255),
	height numeric(10),
	weight numeric(10),
	gender boolean,
	date_birth date
);

-- Insert values into the public schema (rowwise insertion)
insert into public.example_table(first_name, last_name, height, weight, gender, date_birth) 
	values ('Anders', 'Madsen', 187, 90, '0', '1984-02-15')
		   ,('Birgit', 'Hansen', 187, 78, '1', '1992-02-16')
		   ,('Birgit', 'Kristiansen', 169, 50, '1', '1979-02-15')
		   ,('Anders', 'Madsen', 175, 72, '0', '1995-08-25')
		   ,('Anders', 'Madsen', 170, 55, '0', '2001-06-21')
		   ,('Anne', 'Madsen', 170, 52, '1', '1997-06-21')
		   ,('Pia', 'Henriksen', 168, 75, '1', '1989-06-21')
           ,('Pia', 'Henriksen', null, null, '1', '2021-06-21');

select * from public.example_table;



-- If you want to delete the table:
drop table public.example_table; 



