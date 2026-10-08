CREATE OR REPLACE TABLE purchasing.purchase_orders AS 
SELECT 
    PurchaseOrderID
    ,SupplierID
    ,OrderDate
    ,DeliveryMethodID
    ,ContactPersonID
    ,ExpectedDeliveryDate
    ,SupplierReference
    ,IsOrderFinalized
FROM read_csv(
    '{folder_path}/Purchasing.PurchaseOrders.csv'
    ,header = true
    ,delim = ';'
);
