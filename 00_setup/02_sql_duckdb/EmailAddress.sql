-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: EmailAddress.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.email_address AS
SELECT
    column0 AS business_entity_id,
    column1 AS email_address_id,
    column2 AS email_address,
    column3 AS rowguid,
    regexp_replace(column4, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/EmailAddress.csv',
    header = false,
    delim = '+|'
);
