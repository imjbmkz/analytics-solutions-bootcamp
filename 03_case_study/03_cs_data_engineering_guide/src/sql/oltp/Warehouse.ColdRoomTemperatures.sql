CREATE OR REPLACE TABLE warehouse.cold_room_temperatures AS 
SELECT 
    ColdRoomTemperatureID
    ,ColdRoomSensorNumber
    ,RecordedWhen
    ,Temperature
FROM read_csv(
    '{folder_path}/Warehouse.ColdRoomTemperatures.csv'
    ,header = true
    ,delim = ';'
);
