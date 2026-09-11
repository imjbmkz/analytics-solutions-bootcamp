-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Password.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE person.password AS
SELECT
    column0 AS business_entity_id,
    column1 AS password_hash,
    column2 AS password_salt,
    column3 AS rowguid,
    regexp_replace(column4, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/Password.csv',
    header = false,
    delim = '+|'
);
