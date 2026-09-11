-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: CountryRegion.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE person.country_region AS
SELECT
    column0 AS country_region_code,
    column1 AS name,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/CountryRegion.csv',
    header = false,
    delim = '\t'
);
