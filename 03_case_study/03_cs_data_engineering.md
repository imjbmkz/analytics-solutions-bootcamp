# Take-Home Case Study 3

## Building an End-to-End Data Engineering Pipeline

### 1. Study Overview

In this case study, you will build an end-to-end data pipeline using the **Wide World Importers (WWI)** dataset. You will begin with raw CSV files representing an operational system, load them into a normalized OLTP database, and transform the operational data into an analytics-ready dimensional model.

Your solution must demonstrate the following flow:

```text
Raw CSV files → OLTP database → OLAP staging tables → dimensions and facts
```

You may use **DuckDB** or **PostgreSQL running in Docker**. You may select any appropriate orchestration approach, provided that the complete pipeline can be executed through one documented entry point.

---

### 2. Business Background

[Wide World Importers](https://learn.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-ver15) is a fictional wholesale importer and distributor of novelty goods based in the San Francisco Bay Area.

WWI purchases products from suppliers, stores them in its warehouse, and sells them to retailers across the United States. Its customers include specialty stores, supermarkets, computing stores, tourist-attraction shops, other wholesalers, and some individuals.

The company's operational database supports day-to-day activities such as:

- Maintaining customers, employees, products, and suppliers
- Receiving and processing customer orders
- Creating invoices and recording payments
- Purchasing and receiving inventory
- Monitoring stock movements and stock levels
- Delivering orders through different delivery methods

Although the operational database is suitable for recording individual transactions, management needs a separate analytical database for historical reporting and decision-making. Your team has been asked to build the first version of this data pipeline and warehouse.

For this activity, the minimum required scope is **sales analytics**. Purchasing and inventory analytics may be added as optional extensions.

---

### 3. Data Sources and References

#### 3.1. Raw CSV files

Download the Wide World Importers CSV dataset from:

- [Wide World Importers CSV dataset](https://www.kaggle.com/datasets/pauloviniciusornelas/wwimporters)

Treat the downloaded CSV files as extracts from WWI's source operational system. Preserve the original files without modifying them.

#### 3.2. Source-system reference

Use Microsoft's OLTP catalog to understand the source tables, relationships, and business purposes:

- [WideWorldImporters OLTP database catalog](https://learn.microsoft.com/en-us/sql/samples/wide-world-importers-oltp-database-catalog?view=sql-server-ver15)

#### 3.3. Target-model reference

Use Microsoft's data-warehouse catalog as a reference for the dimensional model:

- [WideWorldImportersDW OLAP database catalog](https://learn.microsoft.com/en-us/sql/samples/wide-world-importers-dw-database-catalog?view=sql-server-ver15)

You do not need to reproduce every table in the official warehouse. You may simplify the model provided that it satisfies the minimum requirements and that you explain your decisions.

---

### 4. Data Engineering Objectives

Your solution must accomplish the following objectives:

1. Ingest the raw OLTP CSV files into an OLTP database.
2. Preserve the source structure and relationships as closely as reasonably possible.
3. Apply appropriate data types, primary keys, foreign keys, and other constraints in the OLTP database.
4. Create staging or transformation queries that convert normalized OLTP data into an OLAP model.
5. Create analytics-ready dimension and fact tables.
6. Implement a slowly changing dimension strategy and demonstrate that it works.
7. Make pipeline runs repeatable without creating unintended duplicate records.
8. Orchestrate the complete workflow from CSV ingestion through the loading of dimensions and facts.
9. Add basic data-quality checks and pipeline logging.
10. Document the solution and justify the selected stack, data model, loading patterns, and orchestration approach.

---

### 5. Minimum Data Scope

At minimum, use the source tables needed to create the following sales dimensions and facts. Exact CSV filenames may differ from the original SQL Server table names, so inspect the supplied dataset and document your mapping.

#### 5.1. Required dimensions

| Target table | Suggested OLTP sources | Minimum contents |
| --- | --- | --- |
| `dim_date` | Generated calendar | Date, day, month, quarter, calendar year, fiscal year, and weekday |
| `dim_city` | Cities, StateProvinces, Countries | City, state or province, country, region or territory, and location attributes |
| `dim_customer` | Customers, CustomerCategories, BuyingGroups | Customer, category, buying group, delivery city, and account attributes |
| `dim_employee` | People | Employee or salesperson information |
| `dim_stock_item` | StockItems, Colors, PackageTypes | Product, color, brand, package, supplier, and product attributes available in the source |

WWI's financial year begins on **November 1**. Your date dimension must assign the appropriate fiscal month, quarter, and year.

#### 5.2. Required facts

| Target table | Suggested OLTP sources | Required grain |
| --- | --- | --- |
| `fact_order` | Orders and OrderLines | One row per customer order line |
| `fact_sale` | Invoices and InvoiceLines | One row per customer invoice line |

Suggested measures include:

- Ordered quantity
- Invoiced quantity
- Unit price
- Tax rate and tax amount
- Extended amount excluding tax
- Extended amount including tax
- Profit, where the required source values are available
- Days from order to invoice
- Days from invoice to delivery, where applicable

You may introduce additional dimensions or facts when they improve the model. Examples include delivery method, payment method, customer transaction, supplier, purchase, inventory movement, and stock holding.

---

### 6. Pipeline Requirements

#### 6.1. Raw-to-OLTP ingestion

- Load the required CSV files into the OLTP database.
- Create the tables through scripts rather than manual database actions.
- Assign suitable data types and keys.
- Handle empty strings, null values, invalid dates, and duplicate rows.
- Preserve the original source values whenever practical.
- Record basic ingestion metadata, such as source filename, ingestion timestamp, pipeline run identifier, and number of records loaded.

#### 6.2. OLTP-to-OLAP transformation

- Read the source data from the OLTP database rather than directly from the CSV files.
- Use SQL queries to join, clean, derive, and reshape the source data.
- Load dimensions before loading related facts.
- Use surrogate keys in the dimensions.
- Resolve fact-table foreign keys using the dimension tables.
- Define and document the grain of every fact table.
- Identify how unknown or unmatched dimension values are handled.

#### 6.3. Slowly changing dimensions

Implement **SCD Type 2** for at least one dimension, such as `dim_customer` or `dim_stock_item`.

The dimension should contain fields equivalent to:

- Surrogate key
- Business or natural key
- Effective start date
- Effective end date
- Current-record indicator

You must demonstrate the SCD process using two loads. If the supplied files contain only one usable snapshot, create a small second input batch that changes selected descriptive attributes, such as a customer's category or a product's brand. Do not change the business key.

After the second load:

- The previous dimension record must remain available as history.
- The previous record must be closed using an effective end date.
- A new current record must be inserted with a new surrogate key.
- Facts must resolve to the dimension version that was valid on the relevant transaction date.

You may use SCD Type 1 for other attributes when historical tracking is unnecessary, but you must explain the decision.

#### 6.4. Orchestration

Create an orchestrated workflow with the following dependency order:

1. Validate that the required source files are available.
2. Create or prepare the OLTP database.
3. Ingest CSV files into the OLTP tables.
4. Validate the OLTP load.
5. Create or prepare the OLAP schemas and staging tables.
6. Load dimensions, including SCD processing.
7. Load facts after their required dimensions succeed.
8. Run final data-quality checks.
9. Record the pipeline result.

The orchestration may be implemented using a Python script, shell script, Makefile, Airflow, Dagster, Prefect, or another justified tool. Regardless of the tool, the entire workflow must be executable through one documented command or entry point.

---

### 7. Business Questions

Your final dimension and fact tables must support SQL queries that answer the following questions:

1. What are total sales, quantity sold, and profit by month and fiscal year?
2. Which products and product categories generate the highest sales and profit?
3. Which customers and customer categories contribute the most revenue?
4. How do sales and profit vary by city, state or province, and sales territory?
5. Which employees or salespeople manage the highest-value orders and sales?
6. What proportion of ordered quantities is later invoiced?
7. How long does it take, on average, for an order to be invoiced?
8. Which orders contain backordered items, and what is their business impact?
9. How have tracked customer or product attributes changed over time?
10. What were the correct historical dimension attributes associated with transactions before and after an SCD change?

Submit the SQL queries and their results. You are not required to build a dashboard.

---

### 8. Required Output

Submit a GitHub repository containing the following:

#### 8.1. Source code

- Database creation scripts
- CSV ingestion code
- OLTP table definitions
- OLAP staging and transformation queries
- Dimension and fact loading queries
- SCD implementation
- Data-quality checks
- Orchestration code

#### 8.2. Documentation

Your `README.md` must include:

- Solution overview
- Technology stack and prerequisites
- Setup instructions
- Instructions for downloading or placing the raw files
- One command or entry point for running the complete pipeline
- Source-to-target table mapping
- Fact-table grain definitions
- Explanation of the dimensional model
- Explanation of the SCD approach
- Known assumptions and limitations

#### 8.3. Diagrams

Include:

- A pipeline architecture diagram
- An OLTP entity-relationship diagram
- An OLAP star-schema or dimensional-model diagram

#### 8.4. Evidence of execution

Include evidence that shows:

- Successful CSV-to-OLTP ingestion
- Successful OLTP-to-OLAP transformation
- Row counts for major source and target tables
- Results of data-quality tests
- Successful SCD Type 2 processing across two loads
- Successful completion of the orchestrated workflow
- Results of the required business queries

Evidence may be provided through saved logs, query-result files, screenshots, or generated reports.

---

### 9. Minimum Data-Quality Checks

At minimum, validate the following:

- Required primary keys are not null.
- Business keys expected to be unique do not contain duplicates.
- Required foreign-key relationships are valid.
- Quantities and monetary values meet reasonable validity rules.
- Transaction dates are valid and occur in a reasonable sequence.
- Every fact record resolves to the required dimensions.
- Only one current SCD Type 2 record exists for each business key.
- SCD effective-date ranges do not overlap.
- Re-running the same input does not create duplicate facts or unnecessary dimension versions.

The pipeline should fail clearly, quarantine invalid records, or report exceptions when a critical test is not satisfied. Explain the behavior you selected.

---

### 10. Solution Questions

Answer the following questions in your `README.md` or in a separate Markdown document:

1. Why did you choose your database, ingestion, transformation, and orchestration tools?
2. How did you translate the normalized OLTP structure into your dimensional model, and what is the grain of each fact table?
3. Which dimension and attributes use SCD Type 2, which use SCD Type 1, and why?
4. How does your pipeline prevent duplicates and produce consistent results when the same input is processed more than once?
5. What would you change if the source produced millions of records per day and the business required hourly warehouse updates?

---

### 11. Important Notes

- You may simplify the official WWI warehouse, but the required sales scope must be completed.
- Do not load the facts directly from the raw CSV files. They must be produced from the OLTP database.
- Do not manually edit target tables to demonstrate SCD behavior. The change must be processed through the pipeline.
- Do not commit passwords or other credentials to GitHub. Use environment variables or a local configuration file excluded through `.gitignore`.
- Generated database files and large raw datasets do not need to be committed when they can be reproduced using the documented setup process.
- Cite Microsoft and Kaggle as the sources of the dataset and schema documentation.

