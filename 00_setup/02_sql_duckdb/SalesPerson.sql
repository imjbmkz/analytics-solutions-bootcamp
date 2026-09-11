-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesPerson.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_person AS
SELECT
    column0 AS business_entity_id,
    column1 AS territory_id,
    column2 AS sales_quota,
    column3 AS bonus,
    column4 AS commission_pct,
    column5 AS sales_ytd,
    column6 AS sales_last_year,
    column7 AS rowguid,
    column8 AS modified_date
FROM read_csv(
    '{folder_path}/SalesPerson.csv',
    header = false,
    delim = '\t'
);
