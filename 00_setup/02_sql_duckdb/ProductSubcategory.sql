-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductSubcategory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_subcategory AS
SELECT
    column0 AS product_subcategory_id,
    column1 AS product_category_id,
    column2 AS name,
    column3 AS rowguid,
    column4 AS modified_date
FROM read_csv(
    '{folder_path}/ProductSubcategory.csv',
    header = false,
    delim = '\t'
);
