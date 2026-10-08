CREATE OR REPLACE TABLE warehouse.stock_item_holdings AS 
SELECT 
    StockItemID
    ,QuantityOnHand
    ,BinLocation
    ,LastStocktakeQuantity
    ,LastCostPrice
    ,ReorderLevel
    ,TargetStockLevel
FROM read_csv(
    '{folder_path}/Warehouse.StockItemHoldings.csv'
    ,header = true
    ,delim = ';'
);
