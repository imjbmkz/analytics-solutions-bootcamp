-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesTerritory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_territory AS
SELECT
    column0 AS territory_id,
    column1 AS name,
    column2 AS country_region_code,
    column3 AS group,
    column4 AS sales_ytd,
    column5 AS sales_last_year,
    column6 AS cost_ytd,
    column7 AS cost_last_year,
    column8 AS rowguid,
    column9 AS modified_date
FROM read_csv(
    '{folder_path}/SalesTerritory.csv',
    header = false,
    delim = '\t'
);
