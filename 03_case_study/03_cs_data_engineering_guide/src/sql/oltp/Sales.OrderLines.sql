CREATE OR REPLACE TABLE sales.order_lines AS 
SELECT 
    OrderLineID
    ,OrderID
    ,StockItemID
    ,Description
    ,PackageTypeID
    ,Quantity
    ,UnitPrice
    ,TaxRate
    ,PickedQuantity
    ,PickingCompletedWhen
FROM read_csv(
    '{folder_path}/Sales.OrderLines.csv'
    ,header = true
    ,delim = ';'
);
