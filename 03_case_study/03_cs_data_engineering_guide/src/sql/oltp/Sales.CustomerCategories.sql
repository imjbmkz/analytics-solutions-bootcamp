CREATE OR REPLACE TABLE sales.customer_categories AS 
SELECT 
    CustomerCategoryID
    ,CustomerCategoryName
FROM read_csv(
    '{folder_path}/Sales.CustomerCategories.csv'
    ,header = true
    ,delim = ';'
);
