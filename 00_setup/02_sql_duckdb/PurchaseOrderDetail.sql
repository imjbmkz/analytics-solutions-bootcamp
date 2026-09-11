-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: PurchaseOrderDetail.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE purchasing.purchase_order_detail AS
SELECT
    column00 AS purchase_order_id,
    column01 AS purchase_order_detail_id,
    column02 AS due_date,
    column03 AS order_qty,
    column04 AS product_id,
    column05 AS unit_price,
    column06 AS line_total,
    column07 AS received_qty,
    column08 AS rejected_qty,
    column09 AS stocked_qty,
    column10 AS modified_date
FROM read_csv(
    '{folder_path}/PurchaseOrderDetail.csv',
    header = false,
    delim = '\t'
);
