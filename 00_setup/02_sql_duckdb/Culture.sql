-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Culture.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.culture AS
SELECT
    column0 AS culture_id,
    column1 AS name,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/Culture.csv',
    header = false,
    delim = '\t'
);
