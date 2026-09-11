-- Create schemas on OLTP database
CREATE SCHEMA IF NOT EXISTS person;
CREATE SCHEMA IF NOT EXISTS sales;
CREATE SCHEMA IF NOT EXISTS human_resources;
CREATE SCHEMA IF NOT EXISTS production;
CREATE SCHEMA IF NOT EXISTS purchasing;

-- Create OLAP database
CREATE DATABASE asb_olap;

-- Create a specific user for the second databa
GRANT ALL PRIVILEGES ON DATABASE asb_olap TO db_user;
