/* Creating intital leads table */
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