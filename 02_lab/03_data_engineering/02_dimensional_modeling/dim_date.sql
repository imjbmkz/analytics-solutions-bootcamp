CREATE TABLE dim_date AS 
SELECT 
    -- date_key as YYYYMMDD
    TO_CHAR(datum, 'YYYYMMDD')::INT AS date_key,
    datum AS full_date,
    EXTRACT(YEAR FROM datum)::INT AS year,
    EXTRACT(QUARTER FROM datum)::INT AS quarter,
    EXTRACT(MONTH FROM datum)::INT AS month,
    EXTRACT(DAY FROM datum)::INT AS day_of_month,
    -- PostgreSQL DOW is 0 (Sunday) to 6 (Saturday)
    EXTRACT(DOW FROM datum)::INT AS day_of_week,
    TO_CHAR(datum, 'FMDay') AS day_name,
    TO_CHAR(datum, 'FMMonth') AS month_name,
    TO_CHAR(datum, 'YYYY-MM') AS year_month,
    CASE 
        WHEN EXTRACT(DOW FROM datum) IN (0, 6) THEN TRUE 
        ELSE FALSE 
    END AS is_weekend
FROM 
    -- Generates a series of days between the start and end dates
    GENERATE_SERIES('2020-01-01'::DATE, '2030-12-31'::DATE, '1 day'::INTERVAL) AS datum;

