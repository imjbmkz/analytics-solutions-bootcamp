CREATE OR REPLACE TABLE sales.orders AS 
SELECT 
    OrderID
    ,CustomerID
    ,SalespersonPersonID
    ,PickedByPersonID
    ,ContactPersonID
    ,BackorderOrderID
    ,OrderDate
    ,ExpectedDeliveryDate
    ,CustomerPurchaseOrderNumber
    ,IsUndersupplyBackordered
    ,PickingCompletedWhen
FROM read_csv(
    '{folder_path}/Sales.Orders.csv'
    ,header = true
    ,delim = ';'
);
