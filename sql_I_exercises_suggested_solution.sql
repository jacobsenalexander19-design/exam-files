-- Exercise 1
select *
from customer
limit 10;
-- Exercise 2
select distinct postal_code
from address;
-- Exercise 3
select title
from film
where length > 90;
-- Exercise 4
select title, length, rental_rate
from film
where length < 90 and rental_rate > 4;
-- Exercise 5
select payment_id, payment_date, amount
from payment
where payment_date between '2007-02-19 19:00:00' and '2007-02-20 19:00:00';
-- Exercise 6
select payment_id, payment_date, amount
from payment
where (payment_date between '2007-02-19 19:00:00' and '2007-02-20 19:00:00') and amount > 7;
-- Exercise 7
select * 
from rental
order by rental_date;

select * 
from rental
order by rental_date desc;
-- Exercise 8
select customer_id, amount, payment_id 
from payment
order by customer_id, amount;
/* First order in terms of customer_id, and then for each uniqe value of
 * customer_id, payment_id is ordered. Both ordering is ascending by default.
 * */
-- Exercise 9
select customer_id, count(payment_id) as n_pay_customer
from payment
group by customer_id
order by n_pay_customer desc 
limit 10;
-- Exercise 10
select customer_id, count(payment_id) as n_pay_customer
from payment
group by customer_id
having count(payment_id) >= 15 and count(payment_id) <= 17;
-- Exercise 11
select avg(amount)
from payment;
-- Exercise 12
select amount,  
	case
		when amount > 4.2 then 'Above average'
		when amount = 4.2 then 'At the average'
		when amount < 4.2 then 'Below the average'
		else 'No data available'
	end as in_relation_to_average
from payment;



-- Exercise 13
select sum(amount*0.8) as after_vat
from payment;

-- Exercise 14
select count(a.postal_code)
from (select distinct postal_code
	  from address) as a;
-- Exercise 15
-- Create table in public schema (you must be connected to your own database to create a table)
create table public.my_shopping_list (
	id serial,
	item varchar(200),
	quantity integer,
	price decimal(10, 3),
	expected_buy_date timestamp,
	is_bought boolean
);

-- Insert values into the table (rowwise insertion)
insert into public.my_shopping_list(item, quantity, price, expected_buy_date, is_bought) 
	values ('Banana', '5', 3.5, '2022-10-05', '0')
           ,('House', '1', 3500000.532, '2030-01-15', '0');





