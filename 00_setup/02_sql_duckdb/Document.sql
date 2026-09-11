-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: Document.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE production.document AS
WITH source_records AS (
    SELECT record
    FROM read_text('{folder_path}/Document.csv'),
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
    fields[1] AS document_node,
    fields[2] AS document_level,
    fields[3] AS title,
    fields[4] AS owner,
    fields[5] AS folder_flag,
    fields[6] AS file_name,
    fields[7] AS file_extension,
    fields[8] AS revision,
    fields[9] AS change_number,
    fields[10] AS status,
    fields[11] AS document_summary,
    fields[12] AS document,
    fields[13] AS rowguid,
    fields[14] AS modified_date
FROM parsed;
