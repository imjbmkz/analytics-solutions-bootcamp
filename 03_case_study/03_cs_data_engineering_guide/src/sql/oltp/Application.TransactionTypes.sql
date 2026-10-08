CREATE OR REPLACE TABLE application.transaction_types AS 
SELECT 
    TransactionTypeID
    ,TransactionTypeName
FROM read_csv(
    '{folder_path}/Application.TransactionTypes.csv'
    ,header = true
    ,delim = ';'
);
