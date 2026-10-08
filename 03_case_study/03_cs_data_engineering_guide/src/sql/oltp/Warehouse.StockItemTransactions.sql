CREATE OR REPLACE TABLE warehouse.stock_item_transactions AS 
SELECT 
    StockItemTransactionID
    ,StockItemID
    ,TransactionTypeID
    ,CustomerID
    ,InvoiceID
    ,SupplierID
    ,PurchaseOrderID
    ,TransactionOccurredWhen
    ,Quantity
FROM read_csv(
    '{folder_path}/Warehouse.StockItemTransactions.csv'
    ,header = true
    ,delim = ';'
);
