-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Department.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE human_resources.department AS
SELECT
    column0 AS department_id,
    column1 AS name,
    column2 AS group_name,
    column3 AS modified_date
FROM read_csv(
    '{folder_path}/Department.csv',
    header = false,
    delim = '\t'
);
