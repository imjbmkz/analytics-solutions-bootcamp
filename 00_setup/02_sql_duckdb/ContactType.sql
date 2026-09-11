-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ContactType.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE person.contact_type AS
SELECT
    column0 AS contact_type_id,
    column1 AS name,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/ContactType.csv',
    header = false,
    delim = '\t'
);
