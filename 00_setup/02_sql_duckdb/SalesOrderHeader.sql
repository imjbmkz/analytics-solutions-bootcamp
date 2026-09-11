-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesOrderHeader.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_order_header AS
SELECT
    column00 AS sales_order_id,
    column01 AS revision_number,
    column02 AS order_date,
    column03 AS due_date,
    column04 AS ship_date,
    column05 AS status,
    column06 AS online_order_flag,
    column07 AS sales_order_number,
    column08 AS purchase_order_number,
    column09 AS account_number,
    column10 AS customer_id,
    column11 AS sales_person_id,
    column12 AS territory_id,
    column13 AS bill_to_address_id,
    column14 AS ship_to_address_id,
    column15 AS ship_method_id,
    column16 AS credit_card_id,
    column17 AS credit_card_approval_code,
    column18 AS currency_rate_id,
    column19 AS sub_total,
    column20 AS tax_amt,
    column21 AS freight,
    column22 AS total_due,
    column23 AS comment,
    column24 AS rowguid,
    column25 AS modified_date
FROM read_csv(
    '{folder_path}/SalesOrderHeader.csv',
    header = false,
    delim = '\t'
);
