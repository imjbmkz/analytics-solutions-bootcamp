-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SpecialOfferProduct.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.special_offer_product AS
SELECT
    column0 AS special_offer_id,
    column1 AS product_id,
    column2 AS rowguid,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/SpecialOfferProduct.csv',
    header = false,
    delim = '\t'
);
