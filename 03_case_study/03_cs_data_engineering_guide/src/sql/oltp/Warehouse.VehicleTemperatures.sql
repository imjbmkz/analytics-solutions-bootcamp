

CREATE OR REPLACE TABLE warehouse.vehicle_temperatures AS 
SELECT 
    VehicleTemperatureID
    ,VehicleRegistration
    ,ChillerSensorNumber
    ,RecordedWhen
    ,Temperature
    ,FullSensorData
FROM read_csv(
    '{folder_path}/Warehouse.VehicleTemperatures.csv'
    ,header = true
    ,delim = ';'
);
