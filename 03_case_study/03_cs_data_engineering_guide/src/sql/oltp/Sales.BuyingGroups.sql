CREATE OR REPLACE TABLE sales.buying_groups AS 
SELECT 
    BuyingGroupID
    ,BuyingGroupName
FROM read_csv(
    '{folder_path}/Sales.BuyingGroups.csv'
    ,header = true
    ,delim = ';'
);
