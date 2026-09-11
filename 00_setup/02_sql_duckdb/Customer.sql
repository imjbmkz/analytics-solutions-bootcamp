-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Customer.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.customer AS
SELECT
    column0 AS customer_id,
    column1 AS person_id,
    column2 AS store_id,
    column3 AS territory_id,
    column4 AS account_number,
    column5 AS rowguid,
    column6 AS modified_date
FROM read_csv(
    '{folder_path}/Customer.csv',
    header = false,
    delim = '\t'
);
