-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ShoppingCartItem.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.shopping_cart_item AS
SELECT
    column0 AS shopping_cart_item_id,
    column1 AS shopping_cart_id,
    column2 AS quantity,
    column3 AS product_id,
    column4 AS date_created,
    column5 AS modified_date
FROM read_csv(
    '{folder_path}/ShoppingCartItem.csv',
    header = false,
    delim = '\t'
);
