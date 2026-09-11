-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: SpecialOffer.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.special_offer AS
SELECT
    column00 AS special_offer_id,
    column01 AS description,
    column02 AS discount_pct,
    column03 AS type,
    column04 AS category,
    column05 AS start_date,
    column06 AS end_date,
    column07 AS min_qty,
    column08 AS max_qty,
    column09 AS rowguid,
    column10 AS modified_date
FROM read_csv(
    '{folder_path}/SpecialOffer.csv',
    header = false,
    delim = '\t'
);
