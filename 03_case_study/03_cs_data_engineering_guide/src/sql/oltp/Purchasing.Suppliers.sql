

CREATE OR REPLACE TABLE purchasing.suppliers AS 
SELECT 
    SupplierID
    ,SupplierName
    ,SupplierCategoryID
    ,PrimaryContactPersonID
    ,AlternateContactPersonID
    ,DeliveryMethodID
    ,DeliveryCityID
    ,PostalCityID
    ,SupplierReference
    ,PaymentDays
    ,PhoneNumber
    ,WebsiteURL
    ,DeliveryAddressLine
    ,DeliveryLocationLat
    ,DeliveryLocationLong
FROM read_csv(
    '{folder_path}/Purchasing.Suppliers.csv'
    ,header = true
    ,delim = ';'
);
