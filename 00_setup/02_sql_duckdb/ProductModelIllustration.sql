-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductModelIllustration.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_model_illustration AS
SELECT
    column0 AS product_model_id,
    column1 AS illustration_id,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/ProductModelIllustration.csv',
    header = false,
    delim = '\t'
);
