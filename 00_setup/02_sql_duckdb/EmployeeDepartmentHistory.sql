-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: EmployeeDepartmentHistory.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE human_resources.employee_department_history AS
SELECT
    column0 AS business_entity_id,
    column1 AS department_id,
    column2 AS shift_id,
    column3 AS start_date,
    column4 AS end_date,
    column5 AS modified_date
FROM read_csv(
    '{folder_path}/EmployeeDepartmentHistory.csv',
    header = false,
    delim = '\t'
);
