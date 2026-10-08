CREATE OR REPLACE TABLE purchasing.supplier_categories AS 
SELECT 
    SupplierCategoryID
    ,SupplierCategoryName
FROM read_csv(
    '{folder_path}/Purchasing.SupplierCategories.csv'
    ,header = true
    ,delim = ';'
);
