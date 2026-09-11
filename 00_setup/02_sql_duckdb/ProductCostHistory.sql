-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductCostHistory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_cost_history AS
SELECT
    column0 AS product_id,
    column1 AS start_date,
    column2 AS end_date,
    column3 AS standard_cost,
    column4 AS modified_date
FROM read_csv(
    '{folder_path}/ProductCostHistory.csv',
    header = false,
    delim = '\t'
);
