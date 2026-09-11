-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Product.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product AS
SELECT
    column00 AS product_id,
    column01 AS name,
    column02 AS product_number,
    column03 AS make_flag,
    column04 AS finished_goods_flag,
    column05 AS color,
    column06 AS safety_stock_level,
    column07 AS reorder_point,
    column08 AS standard_cost,
    column09 AS list_price,
    column10 AS size,
    column11 AS size_unit_measure_code,
    column12 AS weight_unit_measure_code,
    column13 AS weight,
    column14 AS days_to_manufacture,
    column15 AS product_line,
    column16 AS class,
    column17 AS style,
    column18 AS product_subcategory_id,
    column19 AS product_model_id,
    column20 AS sell_start_date,
    column21 AS sell_end_date,
    column22 AS discontinued_date,
    column23 AS rowguid,
    column24 AS modified_date
FROM read_csv(
    '{folder_path}/Product.csv',
    header = false,
    delim = '\t'
);
