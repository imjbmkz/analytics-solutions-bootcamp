# Guiding script for Module 3 - Fundamentals of Data Engineering Case Study
This directory consists of boilerplate codes for you to complete the take-home module 3 case study. You don't need to setup Docker and run compose services as we will use DuckDB as database. 

## Setup needed
1. Change your working directory to this folder. `cd 03_case_study/03_cs_data_engineering_guide`. We will run the scripts with `03_cs_data_engineering_guide` as our root folder.
2. Make sure that you have Python 3.11 or newer versions installed.
3. Create your virtual environment. `python -m venv env` or `python3 -m venv env` for Linux/Mac.
4. Activate virtual environment `env/Scripts/activate` or `source env/bin/activate` for Linux/Mac.
5. Install the dependencies. `pip install -r requirements.txt`
6. Run the following scripts in exact order to ingest data into `asb_oltp.duckdb`.
```
python src/00_download_csv.py
python src/01_ingest_csv.py
```

## What you need to accomplish. 
1. For data modeling case study, write your SQL scripts on the following files. Use this reference to build the dimension and fact tables. [WideWorldImportersDW database catalog
](https://learn.microsoft.com/en-us/sql/samples/wide-world-importers-dw-database-catalog?view=sql-server-ver17)
    - `/src/sql/olap/dim_city.sql`
    - `/src/sql/olap/dim_customer.sql`
    - `/src/sql/olap/dim_employee.sql`
    - `/src/sql/olap/dim_stock_item.sql`
    - `/src/sql/olap/fact_order.sql`
    - `/src/sql/olap/fact_sale.sql`
2. For orchestration case study, write your Python script on the following file. 
    - `/run_pipe.py`
3. When everything is done, you may run your script. `python run_pipe.py`
