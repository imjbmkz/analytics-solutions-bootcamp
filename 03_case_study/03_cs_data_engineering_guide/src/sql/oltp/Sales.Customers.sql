CREATE OR REPLACE TABLE sales.customers AS 
SELECT 
    CustomerID
    ,CustomerName
    ,BillToCustomerID
    ,CustomerCategoryID
    ,BuyingGroupID
    ,PrimaryContactPersonID
    ,AlternateContactPersonID
    ,DeliveryMethodID
    ,DeliveryCityID
    ,CreditLimit
    ,AccountOpenedDate
    ,StandardDiscountPercentage
    ,IsStatementSent
    ,IsOnCreditHold
    ,PaymentDays
    ,PhoneNumber
    ,WebsiteURL
    ,DeliveryAddressLine
    ,DeliveryLocationLat
    ,DeliveryLocationLong
FROM read_csv(
    '{folder_path}/Sales.Customers.csv'
    ,header = true
    ,delim = ';'
);
