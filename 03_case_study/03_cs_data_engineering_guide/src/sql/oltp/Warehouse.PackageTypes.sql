CREATE OR REPLACE TABLE warehouse.package_types AS 
SELECT 
    PackageTypeID
    ,PackageTypeName
FROM read_csv(
    '{folder_path}/Warehouse.PackageTypes.csv'
    ,header = true
    ,delim = ';'
);
