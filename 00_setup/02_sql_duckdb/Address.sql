-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Address.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE person.address AS
SELECT
    column0 AS address_id,
    column1 AS address_line1,
    column2 AS address_line2,
    column3 AS city,
    column4 AS state_province_id,
    column5 AS postal_code,
    column6 AS spatial_location,
    column7 AS rowguid,
    column8 AS modified_date
FROM read_csv(
    '{folder_path}/Address.csv',
    header = false,
    delim = '\t'
);
