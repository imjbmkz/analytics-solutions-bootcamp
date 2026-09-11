-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Vendor.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE purchasing.vendor AS
SELECT
    column0 AS business_entity_id,
    column1 AS account_number,
    column2 AS name,
    column3 AS credit_rating,
    column4 AS preferred_vendor_status,
    column5 AS active_flag,
    column6 AS purchasing_web_service_url,
    column7 AS modified_date
FROM read_csv(
    '{folder_path}/Vendor.csv',
    header = false,
    delim = '\t'
);
