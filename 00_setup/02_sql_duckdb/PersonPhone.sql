-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: PersonPhone.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.person_phone AS
SELECT
    column0 AS business_entity_id,
    column1 AS phone_number,
    column2 AS phone_number_type_id,
    regexp_replace(column3, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/PersonPhone.csv',
    header = false,
    delim = '+|'
);
