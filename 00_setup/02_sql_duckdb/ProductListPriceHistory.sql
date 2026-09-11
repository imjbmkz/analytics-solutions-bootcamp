-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductListPriceHistory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_list_price_history AS
SELECT
    column0 AS product_id,
    column1 AS start_date,
    column2 AS end_date,
    column3 AS list_price,
    column4 AS modified_date
FROM read_csv(
    '{folder_path}/ProductListPriceHistory.csv',
    header = false,
    delim = '\t'
);
