WITH funnel AS (
	select 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
		,'VIEWED_PRODUCT' AS event_name
		,count(1) AS n
		,sum(order_value) AS order_value
		,sum(revenue) AS revenue
	from public.d2c_marketing_funnel_data dcmfd
	where dcmfd.viewed_product = TRUE
	group by 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
	union all 
	select 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
		,'ADDED_TO_CART' AS event_name
		,count(1) AS n
		,sum(order_value) AS order_value
		,sum(revenue) AS revenue
	from public.d2c_marketing_funnel_data dcmfd
	where dcmfd.added_to_cart = TRUE
	group by 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
	union all 
	select 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
		,'CHECKOUT_STARTED' AS event_name
		,count(1) AS n
		,sum(order_value) AS order_value
		,sum(revenue) AS revenue
	from public.d2c_marketing_funnel_data dcmfd
	where dcmfd.checkout_started = TRUE
	group by 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
	union all 
	select 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
		,'PURCHASE_COMPLETED' AS event_name
		,count(1) AS n
		,sum(order_value) AS order_value
		,sum(revenue) AS revenue
	from public.d2c_marketing_funnel_data dcmfd
	where dcmfd.purchase_completed = TRUE
	group by 
		dcmfd."date"
		,dcmfd."month"
		,dcmfd.channel
		,dcmfd.campaign_type
		,dcmfd.device
		,dcmfd.user_type
		,dcmfd.region
		,dcmfd.discount_applied
)
select event_name, sum(n) AS nm, sum(order_value) as order_value
from funnel
group by event_name
;