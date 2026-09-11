-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesOrderHeaderSalesReason.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_order_header_sales_reason AS
SELECT
    column0 AS sales_order_id,
    column1 AS sales_reason_id,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/SalesOrderHeaderSalesReason.csv',
    header = false,
    delim = '\t'
);
