-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Location.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.location AS
SELECT
    column0 AS location_id,
    column1 AS name,
    column2 AS cost_rate,
    column3 AS availability,
    column4 AS modified_date
FROM read_csv(
    '{folder_path}/Location.csv',
    header = false,
    delim = '\t'
);
