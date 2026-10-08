CREATE OR REPLACE TABLE sales.invoices AS 
SELECT 
    InvoiceID
    ,CustomerID
    ,BillToCustomerID
    ,OrderID
    ,DeliveryMethodID
    ,ContactPersonID
    ,AccountsPersonID
    ,SalespersonPersonID
    ,PackedByPersonID
    ,InvoiceDate
    ,CustomerPurchaseOrderNumber
    ,DeliveryInstructions
    ,TotalDryItems
    ,TotalChillerItems
    ,ConfirmedDeliveryTime
    ,ConfirmedReceivedBy
FROM read_csv(
    '{folder_path}/Sales.Invoices.csv'
    ,header = true
    ,delim = ';'
    ,nullstr = 'NULL'
);
