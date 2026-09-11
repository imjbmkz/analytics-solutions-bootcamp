-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductCategory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_category AS
SELECT
    column0 AS product_category_id,
    column1 AS name,
    column2 AS rowguid,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/ProductCategory.csv',
    header = false,
    delim = '\t'
);
