-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: TransactionHistoryArchive.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.transaction_history_archive AS
SELECT
    column0 AS transaction_id,
    column1 AS product_id,
    column2 AS reference_order_id,
    column3 AS reference_order_line_id,
    column4 AS transaction_date,
    column5 AS transaction_type,
    column6 AS quantity,
    column7 AS actual_cost,
    column8 AS modified_date
FROM read_csv(
    '{folder_path}/TransactionHistoryArchive.csv',
    header = false,
    delim = '\t'
);
