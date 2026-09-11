-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Shift.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE human_resources.shift AS
SELECT
    column0 AS shift_id,
    column1 AS name,
    column2 AS start_time,
    column3 AS end_time,
    column4 AS modified_date
FROM read_csv(
    '{folder_path}/Shift.csv',
    header = false,
    delim = '\t'
);
