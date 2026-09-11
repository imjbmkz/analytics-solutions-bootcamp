-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: WorkOrder.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.work_order AS
SELECT
    column0 AS work_order_id,
    column1 AS product_id,
    column2 AS order_qty,
    column3 AS stocked_qty,
    column4 AS scrapped_qty,
    column5 AS start_date,
    column6 AS end_date,
    column7 AS due_date,
    column8 AS scrap_reason_id,
    column9 AS modified_date
FROM read_csv(
    '{folder_path}/WorkOrder.csv',
    header = false,
    delim = '\t'
);
