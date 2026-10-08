CREATE OR REPLACE TABLE warehouse.colors AS 
SELECT 
    ColorID
    ,ColorName
FROM read_csv(
    '{folder_path}/Warehouse.Colors.csv'
    ,header = true
    ,delim = ';'
);
