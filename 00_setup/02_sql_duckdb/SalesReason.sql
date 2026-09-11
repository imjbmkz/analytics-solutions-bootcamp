-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesReason.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_reason AS
SELECT
    column0 AS sales_reason_id,
    column1 AS name,
    column2 AS reason_type,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/SalesReason.csv',
    header = false,
    delim = '\t'
);
