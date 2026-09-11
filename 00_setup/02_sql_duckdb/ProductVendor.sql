-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductVendor.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE purchasing.product_vendor AS
SELECT
    column00 AS product_id,
    column01 AS business_entity_id,
    column02 AS average_lead_time,
    column03 AS standard_price,
    column04 AS last_receipt_cost,
    column05 AS last_receipt_date,
    column06 AS min_order_qty,
    column07 AS max_order_qty,
    column08 AS on_order_qty,
    column09 AS unit_measure_code,
    column10 AS modified_date
FROM read_csv(
    '{folder_path}/ProductVendor.csv',
    header = false,
    delim = '\t'
);
