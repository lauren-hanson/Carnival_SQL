select * from dealerships d 

-- total purchase sales income per dealership 
select 
	distinct d.business_name, 
	SUM(s.price) OVER(partition by d.business_name) as SalesIncome
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
order by d.business_name 


-- purchase sales income per dealership for July of 2020
select 
	distinct d.business_name,
	s.purchase_date,
	SUM(s.price) OVER(partition by s.purchase_date)
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
where s.purchase_date >= '2020-07-01' and s.purchase_date < '2020-08-01'
order by d.business_name 


-- purchase sales income per dealership for all of 2020 



-- total lease income for dealership 

-- lease income per dealership for Jan of 2020 

-- lease income per dealership for all of 2019 

-- total income(purchase & lease) per employee