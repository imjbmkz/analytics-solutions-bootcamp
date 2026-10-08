CREATE OR REPLACE TABLE warehouse.stock_items AS 
SELECT 
    StockItemID
    ,StockItemName
    ,SupplierID
    ,ColorID
    ,UnitPackageID
    ,OuterPackageID
    ,Brand
    ,Size
    ,LeadTimeDays
    ,QuantityPerOuter
    ,IsChillerStock
    ,Barcode
    ,TaxRate
    ,UnitPrice
    ,RecommendedRetailPrice
    ,TypicalWeightPerUnit
FROM read_csv(
    '{folder_path}/Warehouse.StockItems.csv'
    ,header = true
    ,delim = ';'
);
