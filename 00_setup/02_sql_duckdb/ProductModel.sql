-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ProductModel.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE production.product_model AS
WITH source_records AS (
    SELECT record
    FROM read_text('{folder_path}/ProductModel.csv'),
         UNNEST(
             string_split(
                 replace(content, chr(13) || chr(10), chr(10)),
                 '&|' || chr(10)
             )
         ) AS records(record)
    WHERE record <> ''
),
parsed AS (
    SELECT string_split(record, '+|') AS fields
    FROM source_records
)
SELECT
    CAST(fields[1] AS int) AS product_model_id,
    fields[2] AS name,
    fields[3] AS catalog_description,
    fields[4] AS instructions,
    fields[5] AS rowguid,
    fields[6] AS modified_date
FROM parsed;
