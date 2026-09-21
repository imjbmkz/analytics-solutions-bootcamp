# Analytics Solutions Bootcamp

## Take-Home Case Study: Data Governance and Analytics on Databricks

### Case Study: Olist Brazilian E-Commerce

------------------------------------------------------------------------

## Background

Olist is a Brazilian e-commerce marketplace that connects small
businesses with customers through online marketplaces. The dataset
contains information about orders, customers, products, sellers,
payments, reviews, and deliveries.

You previously used the Olist dataset to build an end-to-end dashboard
solution. For this case study, you will revisit that solution and
rebuild the data pipeline and dashboard in **Databricks**, while
introducing **data governance and data quality controls**.

The objective is not only to produce analytics, but to ensure that the
data used by the analytical solution is trustworthy. Your pipeline must
identify records that satisfy your data quality requirements, isolate
records that fail those requirements, and ensure that only valid records
are propagated to the analytical layer.

------------------------------------------------------------------------

## Objectives

By completing this case study, you should be able to:

1.  Rebuild your Olist data pipeline in Databricks.
2.  Organize raw, processed, and analytical data into appropriate
    layers.
3.  Profile the source datasets and identify relevant data quality
    risks.
4.  Define and implement data quality rules.
5.  Separate valid and failed records.
6.  Quarantine records that fail data quality checks while retaining
    information about the reason for failure.
7.  Build fact and dimension tables using valid records only.
8.  Create a semantic layer for business intelligence.
9.  Rebuild your Olist operational dashboard using Databricks.
10. Build a separate data quality dashboard for monitoring the
    reliability of the data.

------------------------------------------------------------------------

## Dataset

Use the same **Olist Brazilian E-Commerce dataset** used in the previous
dashboard case study.

The dataset contains multiple related files, including information
about:

-   Orders
-   Order items
-   Customers
-   Products
-   Sellers
-   Payments
-   Reviews
-   Product categories
-   Geolocation

You may reuse the business questions, metrics, and dashboard
requirements from the previous Olist dashboard case study. However, the
underlying pipeline and analytical solution must now be implemented in
Databricks.

------------------------------------------------------------------------

## Business Scenario

The business already uses its e-commerce data to monitor sales and
operational performance. Management, however, wants greater confidence
that the information shown in its dashboards is based on reliable data.

Before records are allowed into the analytical layer, the organization
wants appropriate data quality controls to identify incomplete, invalid,
inconsistent, unreasonable, duplicate, or otherwise unreliable records.

Records that satisfy the required data quality checks should continue
through the analytical pipeline. Records that fail should be retained
separately for investigation rather than silently discarded.

Management also wants visibility into the quality of its data through a
dedicated data quality dashboard.

------------------------------------------------------------------------

## Case Study Requirements

### 1. Rebuild the Data Pipeline in Databricks

Rebuild your existing Olist pipeline using Databricks.

Your solution should ingest the required Olist source files into a raw
data layer and transform the data through the appropriate downstream
layers.

At minimum, your architecture should demonstrate the following flow:

``` text
Olist Source Data
       |
       v
   Raw Layer
       |
       v
Data Quality Checks
    /       \
   v         v
Valid     Quarantine
   |
   v
Facts and Dimensions
   |
   v
Semantic Layer
   |
   v
Operational Dashboard
```

You may reuse logic from your previous case study where appropriate, but
it must be adapted to run as an end-to-end Databricks solution.

------------------------------------------------------------------------

### 2. Perform Data Profiling

Before defining your data quality rules, profile the relevant source
tables.

Investigate characteristics such as:

-   Record counts
-   Missing values
-   Duplicate records or duplicate business keys
-   Distinct values for categorical fields
-   Minimum and maximum values
-   Date ranges
-   Referential relationships between tables
-   Unusual or unreasonable values

Your profiling should help justify the data quality rules you implement.

------------------------------------------------------------------------

### 3. Define Data Quality Rules

Identify and implement appropriate data quality rules for the Olist
datasets.

Your rules should cover multiple data quality dimensions where
applicable, such as:

-   **Completeness** --- required values are present.
-   **Validity** --- values follow expected formats, domains, or allowed
    values.
-   **Consistency** --- related values and dates do not contradict one
    another.
-   **Integrity** --- relationships between tables are maintained.
-   **Reasonability** --- numerical or business values fall within
    reasonable ranges.
-   **Uniqueness** --- records or business keys that should be unique
    are not duplicated.

You are expected to determine the appropriate rules based on your
understanding of the data and the business process.

For every implemented rule, document:

  -----------------------------------------------------------------------
  Field                               Description
  ----------------------------------- -----------------------------------
  Rule ID                             Unique identifier for the rule

  Data Quality Dimension              Completeness, validity,
                                      consistency, integrity,
                                      reasonability, uniqueness, etc.

  Table / Field                       Data element being evaluated

  Rule                                Condition that must be satisfied

  Business Rationale                  Why the rule matters

  Failure Action                      How a failed record is handled
  -----------------------------------------------------------------------

Do **not** automatically correct questionable records unless there is a
clear and defensible business rule for doing so.

------------------------------------------------------------------------

### 4. Implement Valid and Quarantine Records

Apply your data quality rules to the appropriate datasets.

Records that pass the required checks should be made available as
**valid records**.

Records that fail the required checks should be retained in a
**quarantine layer or table** for investigation.

The quarantine data should contain enough information to determine:

-   Which record failed
-   Which rule or rules failed
-   How many rules failed, where applicable
-   Relevant source information needed for investigation

Failed records must not simply be deleted.

------------------------------------------------------------------------

### 5. Build the Analytical Data Model

Rebuild the analytical data model from your previous Olist dashboard
case study in Databricks.

Create the necessary:

-   Fact table(s)
-   Dimension table(s)

Clearly define the **grain** of each fact table.

**Only valid records should be used to build the analytical data
model.**

Your model should support the business questions and metrics required by
your operational dashboard. Dimensional modeling is intended to organize
measurements as facts and their business context as dimensions.

------------------------------------------------------------------------

### 6. Build the Semantic Layer

Create a semantic table or view that prepares the analytical data for
dashboard consumption.

The semantic layer should:

-   Join the required facts and dimensions where appropriate.
-   Provide business-friendly field names.
-   Contain the dimensions and measures required by the dashboard.
-   Hide unnecessary implementation complexity from dashboard users.
-   Be based only on data that passed the required data quality
    controls.

The bootcamp BI module treats the semantic layer as the design of tables
used for reports and dashboards.

------------------------------------------------------------------------

### 7. Rebuild the Operational Dashboard

Rebuild your previous Olist dashboard using **Databricks AI/BI
Dashboards** and the semantic layer created in this case study.

The dashboard should continue to address the business questions from the
previous dashboard case study.

Examples of relevant areas include:

-   Sales and revenue performance
-   Order performance
-   Product or category performance
-   Customer performance
-   Seller performance
-   Delivery performance
-   Customer reviews or satisfaction

You do not need to reproduce your previous dashboard exactly. You may
improve its design, metrics, visualizations, or analytical questions
based on what you have learned since the previous case study.

The dashboard should primarily consume your **semantic layer**, rather
than querying raw source tables directly.

------------------------------------------------------------------------

### 8. Build a Data Quality Dashboard

Create a separate dashboard or dashboard page dedicated to monitoring
data quality.

At minimum, the dashboard should allow users to understand:

-   Number of records evaluated
-   Number of valid records
-   Number of quarantined records
-   Overall data quality pass rate
-   Overall data quality failure rate
-   Number of failures by data quality rule
-   Number of failures by data quality dimension
-   Number of failures by source table, where applicable
-   Most frequently failing data quality rules

You are encouraged to include additional metrics or visualizations that
would help a Data Steward, Data Owner, or Data Engineer monitor the
reliability of the data.

The dashboard should make it possible to answer:

> **Can we trust the data being used by the operational dashboard?**

------------------------------------------------------------------------

## Required Outputs

Submit the following:

### 1. Databricks Pipeline

A working Databricks implementation containing:

-   Raw data ingestion
-   Data profiling
-   Data quality checks
-   Valid record processing
-   Quarantine processing
-   Fact table(s)
-   Dimension table(s)
-   Semantic layer

Your notebooks, SQL scripts, or other Databricks assets should be
organized and understandable.

### 2. Data Quality Rules

Provide documentation of the data quality rules you implemented,
including:

-   Rule ID
-   Data quality dimension
-   Source table and field
-   Rule definition
-   Business rationale
-   Failure handling

### 3. Data Model

Provide a diagram showing the analytical model, including:

-   Fact table(s)
-   Dimension table(s)
-   Primary or business keys
-   Relationships between the tables
-   Grain of each fact table

### 4. Data Quality Dashboard

Provide a Databricks dashboard that monitors valid and quarantined
records and summarizes the results of your data quality checks.

### 5. Operational Dashboard

Provide the rebuilt Olist operational dashboard in Databricks using the
analytical/semantic layer.

### 6. Architecture Diagram

Provide a simple diagram showing the end-to-end flow of your solution.

For example:

``` text
Source
  |
  v
Raw
  |
  v
Data Quality
 /       \
Valid   Quarantine
  |         |
  |         +----> Data Quality Dashboard
  v
Facts + Dimensions
  |
  v
Semantic Layer
  |
  v
Operational Dashboard
```

### 7. Documentation

Provide a short README or equivalent documentation explaining:

-   Your pipeline architecture
-   Data quality approach
-   Important assumptions
-   How quarantined records are handled
-   Fact table grain
-   Semantic layer design
-   Key dashboard metrics
-   Known limitations of your solution

------------------------------------------------------------------------

## Key Constraints

1.  The solution must be implemented in **Databricks**.
2.  Data quality rules must be justified by the data or business
    context.
3.  Failed records must be retained in quarantine rather than silently
    deleted.
4.  Quarantined records must retain information explaining why they
    failed.
5.  Fact tables, dimension tables, and the semantic layer must be
    created using **valid records only**.
6.  The operational dashboard should primarily use the semantic layer.
7.  A separate data quality dashboard must be created.
8.  Learners may reuse concepts, business questions, and selected
    transformation logic from the previous Olist dashboard case study,
    but the pipeline must be rebuilt and governed in Databricks.

------------------------------------------------------------------------

## Evaluation Focus

Your submission will be evaluated based on the following areas:

-   Correctness and completeness of the Databricks pipeline
-   Appropriateness of the data quality rules
-   Quality of the valid/quarantine implementation
-   Traceability of failed records and failed rules
-   Correct use of valid records in downstream analytical tables
-   Quality of the dimensional model
-   Usefulness and usability of the semantic layer
-   Quality and relevance of the data quality dashboard
-   Quality and relevance of the operational dashboard
-   Organization, documentation, and clarity of the overall solution

The goal is not to create the largest number of data quality rules.
Focus on rules that are **meaningful, defensible, and relevant to the
reliability of the analytical solution**.

------------------------------------------------------------------------

## Expected Outcome

At the end of the case study, you should have an end-to-end governed
analytics solution in Databricks that demonstrates the following
principle:

> **Raw data should not automatically become trusted analytical data.
> Data must be validated, failures must be observable, and only trusted
> records should be propagated to business-facing analytical products.**
