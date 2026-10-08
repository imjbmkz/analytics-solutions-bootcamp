CREATE OR REPLACE TABLE dim_date AS

SELECT
    CAST(STRFTIME(datum, '%Y%m%d') AS INTEGER) AS date_key,
    datum AS full_date,

    YEAR(datum) AS year,
    QUARTER(datum) AS quarter,
    MONTH(datum) AS month,
    DAY(datum) AS day_of_month,

    -- DuckDB: Sunday = 0 and Saturday = 6
    DAYOFWEEK(datum) AS day_of_week,

    STRFTIME(datum, '%A') AS day_name,
    STRFTIME(datum, '%B') AS month_name,
    STRFTIME(datum, '%Y-%m') AS year_month,

    CASE
        WHEN DAYOFWEEK(datum) IN (0, 6) THEN TRUE
        ELSE FALSE
    END AS is_weekend

FROM GENERATE_SERIES(
    DATE '2020-01-01',
    DATE '2030-12-31',
    INTERVAL '1 day'
) AS generated_dates(datum);