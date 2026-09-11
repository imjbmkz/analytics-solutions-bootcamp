-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: WorkOrderRouting.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.work_order_routing AS
SELECT
    column00 AS work_order_id,
    column01 AS product_id,
    column02 AS operation_sequence,
    column03 AS location_id,
    column04 AS scheduled_start_date,
    column05 AS scheduled_end_date,
    column06 AS actual_start_date,
    column07 AS actual_end_date,
    column08 AS actual_resource_hrs,
    column09 AS planned_cost,
    column10 AS actual_cost,
    column11 AS modified_date
FROM read_csv(
    '{folder_path}/WorkOrderRouting.csv',
    header = false,
    delim = '\t'
);
