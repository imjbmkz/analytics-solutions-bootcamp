-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: JobCandidate.csv (UTF-8, +|-delimited, no header row)

CREATE OR REPLACE TABLE human_resources.job_candidate AS
WITH source_records AS (
    SELECT record
    FROM read_text('{folder_path}/JobCandidate.csv'),
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
    fields[1] AS job_candidate_id,
    fields[2] AS business_entity_id,
    fields[3] AS resume,
    fields[4] AS modified_date
FROM parsed;
