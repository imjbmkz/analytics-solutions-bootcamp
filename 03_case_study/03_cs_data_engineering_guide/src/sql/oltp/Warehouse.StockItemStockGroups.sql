CREATE OR REPLACE TABLE warehouse.stock_item_stock_groups AS 
SELECT 
    StockItemStockGroupID
    ,StockItemID
    ,StockGroupID
FROM read_csv(
    '{folder_path}/Warehouse.StockItemStockGroups.csv'
    ,header = true
    ,delim = ';'
);
