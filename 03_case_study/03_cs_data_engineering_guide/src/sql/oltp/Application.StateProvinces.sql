CREATE OR REPLACE TABLE application.state_provinces AS 
SELECT 
    StateProvinceID
    ,StateProvinceCode
    ,StateProvinceName
    ,CountryID
    ,SalesTerritory
    ,LatestRecordedPopulation
FROM read_csv(
    '{folder_path}/Application.StateProvinces.csv'
    ,header = true
    ,delim = ';'
);
