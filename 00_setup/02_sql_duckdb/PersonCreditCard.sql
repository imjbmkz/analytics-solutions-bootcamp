-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: PersonCreditCard.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE sales.person_credit_card AS
SELECT
    column0 AS business_entity_id,
    column1 AS credit_card_id,
    column2 AS modified_date
FROM read_csv(
    '{folder_path}/PersonCreditCard.csv',
    header = false,
    delim = '\t'
);
