CREATE OR REPLACE TABLE application.delivery_methods AS 
SELECT 
    DeliveryMethodID
    ,DeliveryMethodName
FROM read_csv(
    '{folder_path}/Application.DeliveryMethods.csv'
    ,header = true
    ,delim = ';'
);
