select sum(amount) sum_amount, customer_id
from public.payment 
where amount > 1
group by customer_id 
having sum(amount) > 90
order by sum_amount
limit 3;





