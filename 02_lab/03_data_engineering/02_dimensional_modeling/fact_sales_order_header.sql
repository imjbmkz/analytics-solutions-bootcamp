CREATE OR REPLACE fact_sales_order_header AS 
SELECT 
	sales_order_id
	, revision_number
	, order_date
	, due_date
	, ship_date
	, status
	, online_order_flag
	, sales_order_number
	, purchase_order_number
	, account_number
	, customer_id
	, sales_person_id
	, territory_id
	, bill_to_address_id
	, ship_to_address_id
	, ship_method_id
	, credit_card_id
	, credit_card_approval_code
	, currency_rate_id
	, sub_total
	, tax_amt
	, freight
	, total_due
	, "comment"
	, rowguid
	, modified_date
FROM sales.sales_order_header