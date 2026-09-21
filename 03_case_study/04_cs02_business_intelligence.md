# Take-Home Case Study 4

## Building an End-to-End E-Commerce Dashboard

### 1. Study Overview

In this case study, you will build an end-to-end business intelligence dashboard using the **Brazilian E-Commerce Public Dataset by Olist**.

You will begin with multiple raw datasets representing different parts of an e-commerce marketplace, prepare and model the data for analysis, define relevant business metrics, and build an interactive dashboard that supports business decision-making.

Your solution should demonstrate the following flow:

```text
Raw datasets → data preparation → semantic / analytical model → business metrics → dashboard → insights
```

You may use **Power BI**, **Tableau**, or another appropriate business intelligence tool. You may use SQL, Python, R, Power Query, Tableau Prep, or another justified approach for data preparation.

---

### 2. Business Background

**Olist** is a Brazilian e-commerce marketplace that connects small businesses and sellers to online marketplaces. Sellers offer their products through Olist, while customers place orders that are fulfilled by the respective sellers and delivered through logistics partners.

The available data covers approximately **100,000 anonymized orders from 2016 to 2018** and provides information across different parts of the order lifecycle, including:

- Customers and their locations
- Orders and order status
- Products and product categories
- Sellers
- Order items, prices, and freight values
- Payment methods and installments
- Delivery dates and estimated delivery dates
- Customer review scores and comments

Management currently has access to transactional data but needs a consolidated dashboard to better understand the performance of the marketplace.

Your team has been asked to develop an analytics solution that allows management to monitor **sales performance, customer behavior, product performance, and order fulfillment** and identify areas where the business can improve.

---

### 3. Data Sources and References

#### 3.1. Raw datasets

Download the Brazilian E-Commerce Public Dataset by Olist from:

- [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains the following files:

- `olist_customers_dataset.csv`
- `olist_geolocation_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_order_payments_dataset.csv`
- `olist_order_reviews_dataset.csv`
- `olist_orders_dataset.csv`
- `olist_products_dataset.csv`
- `olist_sellers_dataset.csv`
- `product_category_name_translation.csv`

Treat these files as the raw source data for the analytics solution. You are not required to use every dataset. Select the datasets necessary to support your analysis and explain your decisions.

#### 3.2. Dataset documentation

Refer to the dataset page and its data schema to understand the tables, relationships, and available attributes.

Pay particular attention to the grain of each dataset. For example, an order may contain multiple items, and each item may be fulfilled by a different seller.

---

### 4. Analytics Objectives

Your solution must accomplish the following objectives:

1. Understand and profile the available Olist datasets.
2. Identify the tables and fields needed to answer the business questions.
3. Clean and transform the raw data as necessary.
4. Define the appropriate grain and relationships between datasets.
5. Create an analytics-ready semantic model for the dashboard.
6. Define relevant business metrics and calculated measures.
7. Perform descriptive analysis to understand what happened in the business.
8. Perform diagnostic analysis to identify possible reasons behind important trends or problems.
9. Build an interactive dashboard that communicates the results effectively.
10. Identify meaningful business insights and provide recommendations supported by the data.

---

### 5. Business Questions

Management wants the dashboard and supporting analysis to help answer the following questions.

#### 5.1. Overall business performance

1. How are orders and sales changing over time?
2. Which months or periods generate the highest and lowest business activity?
3. What is the average value of an order?
4. How many unique customers are purchasing through the marketplace?
5. What proportion of orders are delivered, canceled, unavailable, or in another order status?

#### 5.2. Customer analysis

1. Where are the customers located?
2. Which states or cities generate the highest number of customers, orders, and sales?
3. How many customers have made repeat purchases?
4. How does the behavior of repeat customers differ from customers who purchased only once?

#### 5.3. Product and seller performance

1. Which product categories generate the highest sales and order volume?
2. Which product categories have the highest and lowest average order values?
3. Which sellers contribute the most to marketplace sales?
4. Are sales concentrated among a small number of products, categories, or sellers?

#### 5.4. Order fulfillment and delivery

1. How long does it typically take for an order to reach the customer?
2. What proportion of orders are delivered later than their estimated delivery date?
3. Which customer locations, sellers, or product categories experience the most delivery delays?
4. Are there particular periods when delivery performance becomes worse?

#### 5.5. Customer experience

1. What is the overall distribution of customer review scores?
2. Which product categories or sellers receive the highest and lowest review scores?
3. Do orders delivered late receive lower review scores than orders delivered on time?
4. What other factors appear to be associated with poor customer reviews?

You may investigate additional business questions when they provide useful insights.

---

### 6. Data Preparation and Modeling Requirements

#### 6.1. Data preparation

Profile and prepare the source data before building the dashboard.

At minimum:

- Identify missing and duplicate values.
- Validate key fields and table relationships.
- Convert dates and numerical fields to appropriate data types.
- Standardize categorical fields where necessary.
- Translate product category names where appropriate.
- Create derived fields needed for analysis.

Examples of useful derived fields include:

- Order year and month
- Order value
- Delivery duration
- Estimated delivery duration
- Delivery delay in days
- On-time / late delivery indicator
- Customer purchase frequency
- Customer type, such as one-time or repeat customer

Document any assumptions or data-quality issues that materially affect your analysis.

#### 6.2. Semantic / analytical model

Create an analytics-ready model that supports the required dashboard.

You may use:

- A flattened analytical table
- A star schema
- A snowflake schema
- Another justified analytical model

Your model should avoid unintended duplication of measures when combining datasets with different grains.

For example, consider carefully how order items, payments, and reviews relate to an order before aggregating sales or payment values.

Document:

- The grain of the major analytical tables
- Table relationships
- Key calculated fields or measures
- Important modeling decisions

---

### 7. Dashboard Requirements

Build an interactive dashboard intended for business users and management.

The dashboard should:

- Present the most important business KPIs clearly.
- Show trends over time.
- Allow users to analyze performance across relevant dimensions.
- Support drill-down or filtering where useful.
- Include both descriptive and diagnostic analysis.
- Follow appropriate data-visualization and dashboard-design principles.
- Avoid unnecessary visuals that do not contribute to answering a business question.

You are free to determine the number of dashboard pages, layout, visualizations, filters, and calculated measures.

The dashboard should prioritize **business usability and insight** rather than the number of charts created.

---

### 8. Required Output

Submit a GitHub repository containing the following:

#### 8.1. Dashboard

Submit the dashboard file created using your selected BI tool.

Examples include:

- Power BI `.pbix`
- Tableau workbook
- Another documented dashboard format

Include screenshots or an exported version of the dashboard in the repository when practical.

#### 8.2. Data preparation and analysis

Include the scripts, queries, notebooks, or transformation files used to:

- Load the raw data
- Clean and transform the datasets
- Create derived fields
- Build the analytical dataset or semantic model
- Calculate relevant business metrics

#### 8.3. Documentation

Your `README.md` must include:

- Business problem
- Analytics objectives
- Data sources used
- Technology stack
- Data preparation approach
- Description of the analytical / semantic model
- Key business metrics
- Dashboard overview
- Assumptions and limitations

#### 8.4. Business insights and recommendations

Document at least **three meaningful business insights** identified from your analysis.

For each insight:

1. Describe what you observed.
2. Support the observation using data from the analysis or dashboard.
3. Explain why the finding matters to the business.

Based on your findings, provide at least **two actionable business recommendations**.

Recommendations must be supported by the analysis rather than being generic recommendations that could apply to any e-commerce business.

---

### 9. Solution Questions

Answer the following questions in your `README.md` or in a separate Markdown document:

1. What are the most important KPIs you selected for the dashboard, and why are they important to management?
2. How did you combine datasets with different grains without creating duplicate or incorrect measures?
3. What are the most important trends or patterns you discovered from the data?
4. What factors appear to contribute to poor delivery performance or low customer review scores?
5. What business actions would you recommend based on your findings?

---

### 10. Important Notes

- You are not required to use every table or field in the Olist dataset.
- Do not build the dashboard by simply joining all raw tables into one table without first understanding their grain and relationships.
- Business metrics must be clearly defined and calculated consistently.
- Visualizations should be selected based on the business question being answered.
- Use appropriate filters and interactions to make the dashboard useful for exploration.
- You may create additional derived metrics when they improve the analysis.
- Clearly state assumptions made during data preparation or analysis.
- Do not modify raw source files manually to produce desired results.
- Do not commit passwords, credentials, or other sensitive configuration values to GitHub.
- Cite Olist and Kaggle as the source of the dataset.
