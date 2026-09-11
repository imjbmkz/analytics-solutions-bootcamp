-- Generated from Microsoft AdventureWorks instawdb.sql.
-- Source: BillOfMaterials.csv (UTF-8, tab-delimited, no header row)

CREATE OR REPLACE TABLE production.bill_of_materials AS
SELECT
    column0 AS bill_of_materials_id,
    column1 AS product_assembly_id,
    column2 AS component_id,
    column3 AS start_date,
    column4 AS end_date,
    column5 AS unit_measure_code,
    column6 AS bom_level,
    column7 AS per_assembly_qty,
    column8 AS modified_date
FROM read_csv(
    '{folder_path}/BillOfMaterials.csv',
    header = false,
    delim = '\t'
);
