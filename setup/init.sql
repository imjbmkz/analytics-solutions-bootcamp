-- Create schemas on OLTP AdventureWorks database
CREATE SCHEMA IF NOT EXISTS person;
CREATE SCHEMA IF NOT EXISTS sales;
CREATE SCHEMA IF NOT EXISTS human_resources;
CREATE SCHEMA IF NOT EXISTS production;
CREATE SCHEMA IF NOT EXISTS purchasing;
CREATE SCHEMA IF NOT EXISTS kaggle;

-- Create other databases
CREATE DATABASE asb_olap; -- OLAP/DW database
CREATE DATABASE airflow; -- airflow metadata
CREATE DATABASE metabase; -- metabase metadata

-- Create a specific user for the second databa
GRANT ALL PRIVILEGES ON DATABASE asb_olap TO db_user;
GRANT ALL PRIVILEGES ON DATABASE airflow TO db_user;
GRANT ALL PRIVILEGES ON DATABASE metabase TO db_user;
