-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductDocument.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_document AS
SELECT
    column0 AS product_id,
    column1 AS document_node,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/ProductDocument.csv',
    header = false,
    delim = '\t'
);
