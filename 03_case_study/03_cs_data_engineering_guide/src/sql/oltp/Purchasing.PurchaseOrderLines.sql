CREATE OR REPLACE TABLE purchasing.purchase_order_lines AS 
SELECT 
    PurchaseOrderLineID
    ,PurchaseOrderID
    ,StockItemID
    ,OrderedOuters
    ,Description
    ,ReceivedOuters
    ,PackageTypeID
    ,ExpectedUnitPricePerOuter
    ,LastReceiptDate
    ,IsOrderLineFinalized
FROM read_csv(
    '{folder_path}/Purchasing.PurchaseOrderLines.csv'
    ,header = true
    ,delim = ';'
);
