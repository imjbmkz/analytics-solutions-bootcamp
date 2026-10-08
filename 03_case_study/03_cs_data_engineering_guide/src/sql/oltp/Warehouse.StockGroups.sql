CREATE OR REPLACE TABLE warehouse.stock_groups AS 
SELECT 
    StockGroupID
    ,StockGroupName
FROM read_csv(
    '{folder_path}/Warehouse.StockGroups.csv'
    ,header = true
    ,delim = ';'
);
