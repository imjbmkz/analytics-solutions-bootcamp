-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SalesPersonQuotaHistory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.sales_person_quota_history AS
SELECT
    column0 AS business_entity_id,
    column1 AS quota_date,
    column2 AS sales_quota,
    column3 AS rowguid,
    column4 AS modified_date
FROM read_csv(
    '{folder_path}/SalesPersonQuotaHistory.csv',
    header = false,
    delim = '\t'
);
