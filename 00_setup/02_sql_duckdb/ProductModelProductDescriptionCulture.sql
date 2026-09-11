-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductModelProductDescriptionCulture.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_model_product_description_culture AS
SELECT
    column0 AS product_model_id,
    column1 AS product_description_id,
    column2 AS culture_id,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/ProductModelProductDescriptionCulture.csv',
    header = false,
    delim = '\t'
);
