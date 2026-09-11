-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Employee.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE human_resources.employee AS
SELECT
    column00 AS business_entity_id,
    column01 AS national_id_number,
    column02 AS login_id,
    column03 AS organization_node,
    column04 AS organization_level,
    column05 AS job_title,
    column06 AS birth_date,
    column07 AS marital_status,
    column08 AS gender,
    column09 AS hire_date,
    column10 AS salaried_flag,
    column11 AS vacation_hours,
    column12 AS sick_leave_hours,
    column13 AS current_flag,
    column14 AS rowguid,
    column15 AS modified_date
FROM read_csv(
    '{folder_path}/Employee.csv',
    header = false,
    delim = '\t'
);
