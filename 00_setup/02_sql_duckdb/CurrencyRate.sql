-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: CurrencyRate.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.currency_rate AS
SELECT
    column0 AS currency_rate_id,
    column1 AS currency_rate_date,
    column2 AS from_currency_code,
    column3 AS to_currency_code,
    column4 AS average_rate,
    column5 AS end_of_day_rate,
    column6 AS modified_date
FROM read_csv(
    '{folder_path}/CurrencyRate.csv',
    header = false,
    delim = '\t'
);
