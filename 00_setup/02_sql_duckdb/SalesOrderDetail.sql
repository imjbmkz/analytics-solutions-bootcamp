-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesOrderDetail.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_order_detail AS
SELECT
    column00 AS sales_order_id,
    column01 AS sales_order_detail_id,
    column02 AS carrier_tracking_number,
    column03 AS order_qty,
    column04 AS product_id,
    column05 AS special_offer_id,
    column06 AS unit_price,
    column07 AS unit_price_discount,
    column08 AS line_total,
    column09 AS rowguid,
    column10 AS modified_date
FROM read_csv(
    '{folder_path}/SalesOrderDetail.csv',
    header = false,
    delim = '\t'
);
