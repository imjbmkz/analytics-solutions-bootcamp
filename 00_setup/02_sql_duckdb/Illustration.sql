-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Illustration.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE production.illustration AS
SELECT
    column0 AS illustration_id,
    column1 AS diagram,
    regexp_replace(column2, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/Illustration.csv',
    header = false,
    delim = '+|'
);
