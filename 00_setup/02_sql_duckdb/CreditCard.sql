-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: CreditCard.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.credit_card AS
SELECT
    column0 AS credit_card_id,
    column1 AS card_type,
    column2 AS card_number,
    column3 AS exp_month,
    column4 AS exp_year,
    column5 AS modified_date
FROM read_csv(
    '{folder_path}/CreditCard.csv',
    header = false,
    delim = '\t'
);
