CREATE OR REPLACE dim_product AS 
with product_cost_hist as (
	select 
		product_id
		,start_date::date as cost_valid_from
		,coalesce(end_date::date,'9999-12-31') as cost_valid_to
		,standard_cost
	from production.product_cost_history 
	order by product_id, cost_valid_from
)

,product_price_hist as (
	select 
		product_id
		,start_date::date as price_valid_from
		,coalesce(end_date::date,'9999-12-31') as price_valid_to
		,list_price
	from production.product_list_price_history 
	order by product_id, price_valid_from
)

,products as (
	SELECT 
		p.product_id
		, p."name"
		, p.product_number
		, p.make_flag
		, p.finished_goods_flag
		, p.color
		, p.safety_stock_level
		, p.reorder_point
		, p.standard_cost
		, p.list_price
		, p."size"
		, p.size_unit_measure_code
		, p.weight_unit_measure_code
		, p.weight
		, p.days_to_manufacture
		, p.product_line
		, p."class"
		, p."style"
		, pc.product_category_id as category_id
		, ps.product_subcategory_id as subcategory_id
		, pc."name" as category
		, ps."name" as subcategory
		, p.product_model_id
		, pm."name" as model_name
		, pch.cost_valid_from
		, pch.cost_valid_to
		, pch.standard_cost 
		, pph.price_valid_from
		, pph.price_valid_to
		, pph.list_price 
		, p.sell_start_date::date as sell_start_date
		, p.sell_end_date::date as sell_end_date
		, p.discontinued_date::date as discontinued_date
		
		, greatest(pch.cost_valid_from, pph.price_valid_from) as valid_from
		, least(pch.cost_valid_to, pph.price_valid_to) as valid_to
		, case 
			when least(pch.cost_valid_to, pph.price_valid_to) = '9999-12-31' then true 
			else false 
		end as is_current
		
--		, p.rowguid
--		, p.modified_date
	FROM production.product p
	left join production.product_subcategory ps on p.product_subcategory_id = ps.product_subcategory_id
	left join production.product_category pc on ps.product_category_id = pc.product_category_id 
	left join production.product_model pm on p.product_model_id = pm.product_model_id 
	join product_cost_hist pch on p.product_id = pch.product_id 
	join product_price_hist pph on p.product_id = pph.product_id 
		and pch.cost_valid_from < pph.price_valid_to
		and pph.price_valid_from < pch.cost_valid_to
	
)
select *
from products
--where product_id = 743--707