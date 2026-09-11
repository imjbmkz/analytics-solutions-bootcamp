-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: StateProvince.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE person.state_province AS
SELECT
    column0 AS state_province_id,
    column1 AS state_province_code,
    column2 AS country_region_code,
    column3 AS is_only_state_province_flag,
    column4 AS name,
    column5 AS territory_id,
    column6 AS rowguid,
    column7 AS modified_date
FROM read_csv(
    '{folder_path}/StateProvince.csv',
    header = false,
    delim = '\t'
);
