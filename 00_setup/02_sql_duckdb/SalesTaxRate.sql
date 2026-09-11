-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesTaxRate.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_tax_rate AS
SELECT
    column0 AS sales_tax_rate_id,
    column1 AS state_province_id,
    column2 AS tax_type,
    column3 AS tax_rate,
    column4 AS name,
    column5 AS rowguid,
    column6 AS modified_date
FROM read_csv(
    '{folder_path}/SalesTaxRate.csv',
    header = false,
    delim = '\t'
);
