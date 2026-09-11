CREATE OR REPLACE fact_sales_order_detail AS 
SELECT 
	sales_order_id
	, sales_order_detail_id
	, carrier_tracking_number
	, order_qty
	, product_id
	, special_offer_id
	, unit_price
	, unit_price_discount
	, line_total
	, rowguid
	, modified_date
FROM sales.sales_order_detail;