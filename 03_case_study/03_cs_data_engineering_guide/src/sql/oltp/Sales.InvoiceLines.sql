CREATE OR REPLACE TABLE sales.invoice_lines AS 
SELECT 
    InvoiceLineID
    ,InvoiceID
    ,StockItemID
    ,Description
    ,PackageTypeID
    ,Quantity
    ,UnitPrice
    ,TaxRate
    ,TaxAmount
    ,LineProfit
    ,ExtendedPrice
FROM read_csv(
    '{folder_path}/Sales.InvoiceLines.csv'
    ,header = true
    ,delim = ';'
);
