CREATE OR REPLACE TABLE sales.customer_transactions AS 
SELECT 
    CustomerTransactionID
    ,CustomerID
    ,TransactionTypeID
    ,InvoiceID
    ,PaymentMethodID
    ,TransactionDate
    ,AmountExcludingTax
    ,TaxAmount
    ,TransactionAmount
    ,OutstandingBalance
    ,FinalizationDate
    ,IsFinalized
FROM read_csv(
    '{folder_path}/Sales.CustomerTransactions.csv'
    ,header = true
    ,delim = ';'
    ,nullstr = 'NULL'
);
