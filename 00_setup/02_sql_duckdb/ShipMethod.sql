-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: ShipMethod.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE purchasing.ship_method AS
SELECT
    column0 AS ship_method_id,
    column1 AS name,
    column2 AS ship_base,
    column3 AS ship_rate,
    column4 AS rowguid,
    column5 AS modified_date
FROM read_csv(
    '{folder_path}/ShipMethod.csv',
    header = false,
    delim = '\t'
);
