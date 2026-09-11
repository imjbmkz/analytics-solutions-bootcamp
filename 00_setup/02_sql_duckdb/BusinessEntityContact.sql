-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: BusinessEntityContact.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.business_entity_contact AS
SELECT
    column0 AS business_entity_id,
    column1 AS person_id,
    column2 AS contact_type_id,
    column3 AS rowguid,
    regexp_replace(column4, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/BusinessEntityContact.csv',
    header = false,
    delim = '+|'
);
