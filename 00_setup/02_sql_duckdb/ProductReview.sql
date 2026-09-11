-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductReview.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.product_review AS
WITH source_lines AS (
    SELECT line, line_number
    FROM read_text('{folder_path}/ProductReview.csv'),
         UNNEST(
             string_split(
                 replace(content, chr(13) || chr(10), chr(10)),
                 chr(10)
             )
         ) WITH ORDINALITY AS lines(line, line_number)
    WHERE line <> ''
),
measured_lines AS (
    SELECT
        line,
        line_number,
        length(line) - length(replace(line, chr(9), '')) AS delimiter_count
    FROM source_lines
),
grouped_lines AS (
    SELECT
        line,
        line_number,
        1 + floor(
            coalesce(
                sum(delimiter_count) OVER (
                    ORDER BY line_number
                    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
                ),
                0
            ) / 7
        ) AS record_number
    FROM measured_lines
),
source_records AS (
    SELECT string_agg(line, chr(10) ORDER BY line_number) AS record
    FROM grouped_lines
    GROUP BY record_number
),
parsed AS (
    SELECT string_split(record, chr(9)) AS fields
    FROM source_records
)
SELECT
    fields[1] AS product_review_id,
    fields[2] AS product_id,
    fields[3] AS reviewer_name,
    fields[4] AS review_date,
    fields[5] AS email_address,
    fields[6] AS rating,
    fields[7] AS comments,
    fields[8] AS modified_date
FROM parsed;
