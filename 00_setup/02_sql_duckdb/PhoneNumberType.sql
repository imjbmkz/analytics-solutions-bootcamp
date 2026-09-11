-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: PhoneNumberType.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.phone_number_type AS
SELECT
    column0 AS phone_number_type_id,
    column1 AS name,
    regexp_replace(column2, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/PhoneNumberType.csv',
    header = false,
    delim = '+|'
);
