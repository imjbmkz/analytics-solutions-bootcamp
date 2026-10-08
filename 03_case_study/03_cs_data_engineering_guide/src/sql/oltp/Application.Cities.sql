CREATE OR REPLACE TABLE application.cities AS 
SELECT 
    CityID
    ,CityName
    ,StateProvinceID
    ,Latitude
    ,Longitude
    ,LatestRecordedPopulation
FROM read_csv(
    '{folder_path}/Application.Cities.csv'
    ,header = true
    ,delim = ';'
);
