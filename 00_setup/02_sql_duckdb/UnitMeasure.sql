-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: UnitMeasure.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.unit_measure AS
SELECT
    column0 AS unit_measure_code,
    column1 AS name,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/UnitMeasure.csv',
    header = false,
    delim = '\t'
);
