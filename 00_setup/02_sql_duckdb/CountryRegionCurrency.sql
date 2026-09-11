-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: CountryRegionCurrency.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.country_region_currency AS
SELECT
    column0 AS country_region_code,
    column1 AS currency_code,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/CountryRegionCurrency.csv',
    header = false,
    delim = '\t'
);
