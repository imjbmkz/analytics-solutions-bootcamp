-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductInventory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_inventory AS
SELECT
    column0 AS product_id,
    column1 AS location_id,
    column2 AS shelf,
    column3 AS bin,
    column4 AS quantity,
    column5 AS rowguid,
    column6 AS modified_date
FROM read_csv(
    '{folder_path}/ProductInventory.csv',
    header = false,
    delim = '\t'
);
