# Take-Home Case Study: Exploratory Data Analysis

## Background
You are a Data Analyst supporting a UK-based online retailer that sells gift items to customers across multiple countries. Management wants to better understand the company's sales performance, product portfolio, customers, and international markets.

Using historical transaction data, conduct exploratory data analysis (EDA) and translate your findings into insights that can support business decisions.

## Objectives
- Assess and understand the available data.
- Identify important sales, product, customer, and geographic patterns.
- Detect unusual observations and potential data-quality concerns.
- Use appropriate visualizations and descriptive statistics.
- Apply statistical tests where appropriate.
- Communicate actionable business insights and recommendations.

## Data Source
Use the **UCI Online Retail** dataset:

https://archive.ics.uci.edu/dataset/352/online+retail

The transaction-level data includes invoice number, product code and description, quantity, invoice date, unit price, customer ID, and country.

## Business Questions

### Sales Performance
1. How is the business performing over time? Identify important trends, patterns, or unusual periods.
2. Are there periods when sales are consistently stronger or weaker? What might these patterns imply?
3. What does a typical transaction look like in terms of order value and quantity purchased?
4. Are there unusually large or small transactions that management should investigate?

### Product Performance
5. Which products contribute the most revenue, and which contribute the most units sold?
6. How concentrated are sales among products? Does the business depend heavily on a small number of products?
7. Which products appear to be underperforming? Define and justify how you measure underperformance.
8. Are there products with unusual combinations of price, quantity sold, or revenue?

### Customer Analysis
9. How concentrated is revenue among customers? Is the company dependent on a small group of high-value customers?
10. Who are the company's most valuable customers? Define customer value using appropriate business measures.
11. How does purchasing behavior differ between high-value and typical customers?
12. Are there identifiable groups of customers with substantially different purchasing behaviors?

### Geographic Performance
13. Which countries or markets contribute the most to the company's business?
14. How does purchasing behavior differ across the company's major markets?
15. Are there markets that appear particularly promising or concerning? Support your conclusion with evidence.

### Cancellations and Data Issues
16. How significant are cancelled transactions? Investigate their frequency and potential financial impact.
17. Are cancellations concentrated among particular products, customers, markets, or periods?
18. What unusual patterns or potential data-quality issues could affect management's interpretation?

### Management Summary
19. What are the **three most important findings** management should know?
20. What **three actions** would you recommend management consider? Connect each recommendation to evidence from your analysis.

## Analysis Requirements
At minimum:
- Perform data inspection and profiling.
- Investigate missing, invalid, duplicate, or unusual observations.
- Use appropriate univariate, bivariate, and multivariate analysis.
- Provide meaningful visualizations.
- Calculate appropriate descriptive statistics.
- Perform statistical tests where they add value.
- Clearly distinguish observations supported by data from assumptions or interpretations.

Do not simply produce charts and statistical outputs. Explain what important results mean in the context of the business.

## Required Outputs
Submit an **R Markdown (`.Rmd`) analysis** and its rendered **HTML report**.

The report should contain:

1. **Data Overview and Preparation**
   - Dataset description
   - Data profiling
   - Data-quality issues
   - Cleaning or transformations performed

2. **Exploratory Analysis**
   - Analysis addressing the business questions
   - Descriptive statistics
   - Relevant visualizations
   - Statistical tests where appropriate

3. **Key Findings**
   - Three most important findings
   - Evidence supporting each finding

4. **Recommendations**
   - Three business recommendations
   - Explanation connecting each recommendation to the findings

5. **Additional Exploration**
   - Formulate and investigate at least **two additional business questions** not explicitly listed above.

## Notes
- There is no single correct approach.
- Choose methods and visualizations based on the business question.
- Not every question requires a statistical test.
- Statistical significance does not automatically imply business significance.
- Association or correlation should not be presented as evidence of causation.
- Document important assumptions made during the analysis.
