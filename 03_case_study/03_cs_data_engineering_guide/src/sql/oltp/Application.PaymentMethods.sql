CREATE OR REPLACE TABLE application.payment_methods AS 
SELECT 
    PaymentMethodID
    ,PaymentMethodName
FROM read_csv(
    '{folder_path}/Application.PaymentMethods.csv'
    ,header = true
    ,delim = ';'
);
