-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: EmployeePayHistory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE human_resources.employee_pay_history AS
SELECT
    column0 AS business_entity_id,
    column1 AS rate_change_date,
    column2 AS rate,
    column3 AS pay_frequency,
    column4 AS modified_date
FROM read_csv(
    '{folder_path}/EmployeePayHistory.csv',
    header = false,
    delim = '\t'
);
