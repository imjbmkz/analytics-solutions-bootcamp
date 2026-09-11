-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Store.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE sales.store AS
SELECT
    column0 AS business_entity_id,
    column1 AS name,
    column2 AS sales_person_id,
    column3 AS demographics,
    column4 AS rowguid,
    regexp_replace(column5, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/Store.csv',
    header = false,
    delim = '+|'
);
