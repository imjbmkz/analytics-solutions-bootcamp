-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Person.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.person AS
SELECT
    column00 AS business_entity_id,
    column01 AS person_type,
    column02 AS name_style,
    column03 AS title,
    column04 AS first_name,
    column05 AS middle_name,
    column06 AS last_name,
    column07 AS suffix,
    column08 AS email_promotion,
    column09 AS additional_contact_info,
    column10 AS demographics,
    column11 AS rowguid,
    regexp_replace(column12, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/Person.csv',
    header = false,
    delim = '+|'
);
