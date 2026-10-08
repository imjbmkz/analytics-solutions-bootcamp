CREATE OR REPLACE TABLE purchasing.supplier_transactions AS 
SELECT 
    SupplierTransactionID
    ,SupplierID
    ,TransactionTypeID
    ,PurchaseOrderID
    ,PaymentMethodID
    ,SupplierInvoiceNumber
    ,TransactionDate
    ,AmountExcludingTax
    ,TaxAmount
    ,TransactionAmount
    ,OutstandingBalance
    ,FinalizationDate
    ,IsFinalized
FROM read_csv(
    '{folder_path}/Purchasing.SupplierTransactions.csv'
    ,header = true
    ,delim = ';'
);
