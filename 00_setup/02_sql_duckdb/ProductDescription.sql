-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductDescription.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_description AS
SELECT
    column0 AS product_description_id,
    column1 AS description,
    column2 AS rowguid,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/ProductDescription.csv',
    header = false,
    delim = '\t'
);
