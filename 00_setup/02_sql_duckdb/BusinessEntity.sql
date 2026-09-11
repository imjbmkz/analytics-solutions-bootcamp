-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: BusinessEntity.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.business_entity AS
SELECT
    column0 AS business_entity_id,
    column1 AS rowguid,
    regexp_replace(column2, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/BusinessEntity.csv',
    header = false,
    delim = '+|'
);
