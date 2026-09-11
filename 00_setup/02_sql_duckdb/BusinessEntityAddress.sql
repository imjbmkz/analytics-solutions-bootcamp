-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: BusinessEntityAddress.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.business_entity_address AS
SELECT
    column0 AS business_entity_id,
    column1 AS address_id,
    column2 AS address_type_id,
    column3 AS rowguid,
    regexp_replace(column4, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/BusinessEntityAddress.csv',
    header = false,
    delim = '+|'
);
