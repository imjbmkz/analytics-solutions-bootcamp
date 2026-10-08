
CREATE OR REPLACE TABLE application.people AS 
SELECT 
    PersonID
    ,FullName
    ,PreferredName
    ,SearchName
    ,IsEmployee
    ,IsSalesperson
FROM read_csv(
    '{folder_path}/Application.People.csv'
    ,header = true
    ,delim = ';'
);
