select 
	c.customer_id, 
	concat(c.first_name, ' ', c.last_name) as CustomerName, 
	SUM(p.amount) OVER(partition by c.customer_id) as CustomerTotalSales, 
	f.title as movietitle, 
	p.amount, 
	f.film_id 
from rental r 
join customer c 
	on c.customer_id = r.customer_id 
join inventory i 
	on i.inventory_id = r.inventory_id 
join film f 
	on f.film_id = i.film_id 
left join payment p 
	on p.rental_id = r.rental_id 
where c.customer_id = 341
order by c.customer_id; 




select r.rental_id, f.film_id, p.amount 
from rental r 
--where customer_id = 341; 
join customer c 
	on c.customer_id = r.customer_id 
join inventory i 
	on i.inventory_id = r.inventory_id 
join film f 
	on f.film_id = i.film_id 
-- to make sure all information is shown even if there is no payment
left join payment p 
	on p.rental_id = r.rental_id 
where r.rental_id = 1318;


select * 
from inventory i 
where film_id = 606; 


select * 
from rental r 
where inventory_id in (2759, 2760, 2761, 2762, 2763, 2764) and customer_id = 341; 



