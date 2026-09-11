-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesTerritoryHistory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_territory_history AS
SELECT
    column0 AS business_entity_id,
    column1 AS territory_id,
    column2 AS start_date,
    column3 AS end_date,
    column4 AS rowguid,
    column5 AS modified_date
FROM read_csv(
    '{folder_path}/SalesTerritoryHistory.csv',
    header = false,
    delim = '\t'
);
