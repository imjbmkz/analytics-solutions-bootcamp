-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ScrapReason.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.scrap_reason AS
SELECT
    column0 AS scrap_reason_id,
    column1 AS name,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/ScrapReason.csv',
    header = false,
    delim = '\t'
);
