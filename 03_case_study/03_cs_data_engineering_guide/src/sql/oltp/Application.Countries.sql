CREATE OR REPLACE TABLE application.countries AS 
SELECT 
    CountryID
    ,CountryName
    ,FormalName
    ,LatestRecordedPopulation
    ,Continent
    ,Region
    ,Subregion
FROM read_csv(
    '{folder_path}/Application.Countries.csv'
    ,header = true
    ,delim = ';'
);
