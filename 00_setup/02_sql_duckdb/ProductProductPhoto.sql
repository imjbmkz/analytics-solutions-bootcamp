-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductProductPhoto.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_product_photo AS
SELECT
    column0 AS product_id,
    column1 AS product_photo_id,
    column2 AS primary,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/ProductProductPhoto.csv',
    header = false,
    delim = '\t'
);
