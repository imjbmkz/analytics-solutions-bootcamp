-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductPhoto.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE production.product_photo AS
SELECT
    column0 AS product_photo_id,
    column1 AS thumb_nail_photo,
    column2 AS thumbnail_photo_file_name,
    column3 AS large_photo,
    column4 AS large_photo_file_name,
    regexp_replace(column5, '&\|$', '') AS modified_date
FROM read_csv(
    '{folder_path}/ProductPhoto.csv',
    header = false,
    delim = '+|'
);
