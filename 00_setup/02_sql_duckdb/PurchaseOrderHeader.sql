-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: PurchaseOrderHeader.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE purchasing.purchase_order_header AS
SELECT
    column00 AS purchase_order_id,
    column01 AS revision_number,
    column02 AS status,
    column03 AS employee_id,
    column04 AS vendor_id,
    column05 AS ship_method_id,
    column06 AS order_date,
    column07 AS ship_date,
    column08 AS sub_total,
    column09 AS tax_amt,
    column10 AS freight,
    column11 AS total_due,
    column12 AS modified_date
FROM read_csv(
    '{folder_path}/PurchaseOrderHeader.csv',
    header = false,
    delim = '\t'
);
