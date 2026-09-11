-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Currency.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.currency AS
SELECT
    column0 AS currency_code,
    column1 AS name,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/Currency.csv',
    header = false,
    delim = '\t'
);
