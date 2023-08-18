select 
	c.customer_id, 
	concat(c.first_name, ' ', c.last_name), 
	SUM(p.amount) OVER(partition by c.customer_id) as CustomerTotalSales
	, 
	f.title, 
	p.amount
from rental r 
join customer c 
	on c.customer_id = r.customer_id 
join inventory i 
	on i.inventory_id = r.inventory_id 
join film f 
	on f.film_id = i.film_id 
join payment p 
	on p.rental_id = r.rental_id 
where c.customer_id = 341
order by c.customer_id 