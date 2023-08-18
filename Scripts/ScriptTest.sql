-- TOP 5 DEALERSHIPS 
with TopDealerships as 
( 
	select 
		d.dealership_id,
		d.business_name, 
		sum(s.price) as DealershipTotalSales, 
		s.sale_id, 
		s.employee_id 
	from dealerships d 
	join sales s 
	on d.dealership_id = s.dealership_id 
	group by d.business_name, d.dealership_id, s.sale_id, s.employee_id 
	order by DealershipTotalSales desc
	limit 5
),

--employees made the most sales
TopEmployeesPerDealership AS (
	SELECT 
		td.dealership_id, 

		e.employee_id, 
		e.first_name || ' ' || e.last_name AS Employee, 
--		SUM(td.DealershipTotalSales) AS EmployeeTotalSales
	FROM TopDealerships td 
	join sales s 
		on s.employee_id = td.employee_id 
	JOIN employees e
		on td.employee_id = e.employee_id
	GROUP BY td.dealership_id, td.business_name, e.employee_id
	ORDER BY td.dealership_id, EmployeeTotalSales desc
)

SELECT * from TopEmployeesPerDealership




-- vehicle models were the most popular in sales
with TopDealerships as 
( 
	select 
		d.dealership_id,
		d.business_name, 
		sum(s.price) as DealershipTotalSales, 
		s.sale_id 
	from dealerships d 
	join sales s 
	on d.dealership_id = s.dealership_id 
	group by d.business_name, d.dealership_id, s.sale_id 
	order by DealershipTotalSales desc
	limit 5
), 
TopModelsPerDealership as (
	select 
		td.dealership_id, 
		td.business_name, 
		vt.model, 
		COUNT(*) as ModelSalesCount
	from TopDealerships td 
	join sales s 
		on td.sale_id = s.sale_id 
	join vehicles v 
		on s.vehicle_id = v.vehicle_id 
	join vehicletypes vt
		on v.vehicle_type_id = vt.vehicle_type_id 
	group by 
		td.dealership_id, td.business_name, vt.model
	order by 
		td.dealership_id, ModelSalesCount desc
	
)
SELECT
    td.business_name,
    td.dealership_id,
    td.DealershipTotalSales,
    tmd.model,
    tmd.ModelSalesCount
FROM
    TopDealerships td
    
-- finds max sales count for each dealership 
JOIN (
    SELECT
        dealership_id,
        MAX(ModelSalesCount) AS MaxModelSalesCount
    FROM
        TopModelsPerDealership
    GROUP BY
        dealership_id
) maxSalesPerDealership ON td.dealership_id = maxSalesPerDealership.dealership_id
-- joins TopDealerships with topmodelsperdealership
JOIN
    TopModelsPerDealership tmd ON td.dealership_id = tmd.dealership_id AND tmd.ModelSalesCount = maxSalesPerDealership.MaxModelSalesCount
ORDER BY
    td.dealership_id;



-- more sales or leases - need to work on SalesVsLease
with TopDealerships as 
( 
	select 
		d.dealership_id,
		d.business_name, 
		sum(s.price) as DealershipTotalSales,  
		s.sales_type_id 
	from dealerships d 
	join sales s 
	on d.dealership_id = s.dealership_id 
	group by d.business_name, d.dealership_id, s.sale_id, s.sales_type_id 
	order by DealershipTotalSales desc
	limit 5
), 
SalesVsLease as (
	select 
		td.business_name, 
		CASE WHEN st.sales_type_name = 'Lease' THEN 1 ELSE 0 END AS lease_count,
        CASE WHEN st.sales_type_name = 'Purchase' THEN 1 ELSE 0 END AS purchase_count
	from TopDealerships td 
	join salestypes st 
		on td.sales_type_id = st.sales_type_id 
	group by business_name, st.sales_type_name
)

select * from SalesVsLease svl


 
--USED CARS

with UsedCars as (
	select 
		v.vehicle_id, 
		v.is_new
	from vehicles v 
	where v.is_new = false
)

-- which states sold the most? The least? 

-- model with greated inventory

-- made with greatest inventory


