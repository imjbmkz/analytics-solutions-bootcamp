-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: AddressType.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE person.address_type AS
SELECT
    column0 AS address_type_id,
    column1 AS name,
    column2 AS rowguid,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/AddressType.csv',
    header = false,
    delim = '\t'
);
