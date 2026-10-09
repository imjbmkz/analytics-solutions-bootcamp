# Take-Home Case Study: Exploratory Data Analysis

## Background
You are a Data Analyst at an automotive consultancy. A client, a car manufacturer planning its next line-up, wants to better understand how vehicle design choices relate to fuel efficiency and performance, and how its potential competitors are positioned.

Using historical vehicle specification data, conduct exploratory data analysis (EDA) and translate your findings into insights that can support product-planning decisions.

## Objectives
- Assess and understand the available data.
- Identify important fuel-efficiency, performance, design, and manufacturer patterns.
- Detect unusual observations and potential data-quality or data-limitation concerns.
- Use appropriate visualizations and descriptive statistics.
- Apply statistical tests where appropriate.
- Communicate actionable business insights and recommendations.

## Data Source
Use the **`mtcars`** dataset, which is built into R:

```r
data(mtcars)
?mtcars
```

The data was extracted from the 1974 *Motor Trend* US magazine and covers fuel consumption and 10 aspects of design and performance for 32 automobiles (1973–74 models). Car model names are stored as **row names**, not as a column.

| Variable | Description |
|---|---|
| `mpg` | Miles per (US) gallon |
| `cyl` | Number of cylinders |
| `disp` | Displacement (cubic inches) |
| `hp` | Gross horsepower |
| `drat` | Rear axle ratio |
| `wt` | Weight (1,000 lbs) |
| `qsec` | 1/4 mile time (seconds) |
| `vs` | Engine shape (0 = V-shaped, 1 = straight) |
| `am` | Transmission (0 = automatic, 1 = manual) |
| `gear` | Number of forward gears |
| `carb` | Number of carburetors |

## Business Questions

### Fuel Efficiency
1. What does the distribution of fuel efficiency (`mpg`) look like across the vehicles? What does a typical car look like?
2. Which vehicles are unusually efficient or inefficient, and what do they have in common?
3. How is fuel efficiency related to weight, horsepower, and displacement? Which relationships are strongest?
4. Are there vehicles whose fuel efficiency is surprising given their size or power that management should look at more closely?

### Performance and Design
5. Which vehicles are the most powerful (`hp`) and the quickest (`qsec`)? Are these the same vehicles?
6. How strong is the trade-off between performance and fuel efficiency? Is it possible to have both?
7. Which vehicles appear to be underperforming? Define and justify how you measure underperformance (for example, fuel efficiency relative to weight or power).
8. Are there vehicles with unusual combinations of weight, power, efficiency, or acceleration?

### Vehicle Segments
9. How do vehicles differ across cylinder groups (4, 6, 8)? Are the differences in fuel efficiency statistically and practically meaningful?
10. Do manual and automatic vehicles differ in fuel efficiency? Is the difference explained by other factors such as weight or engine size?
11. How do V-shaped and straight engines differ in efficiency and performance?
12. Are there identifiable groups of vehicles with substantially different design and performance profiles (for example, using clustering or principal component analysis)?

### Manufacturer and Origin
13. Derive the manufacturer (brand) and region of origin (e.g., US, Europe, Japan) from the car names. Which brands and regions are represented, and how evenly?
14. How do vehicle specifications differ across regions of origin?
15. Are there regions or brands whose positioning appears particularly strong or weak for a fuel-conscious market? Support your conclusion with evidence.

### Data Issues and Limitations
16. How are categorical attributes (`cyl`, `vs`, `am`, `gear`, `carb`) encoded, and how should they be treated in analysis?
17. How strongly are the design variables correlated with each other, and how does this affect interpretation of any single variable's relationship with `mpg`?
18. What limitations (sample size, age of the data, how the vehicles were selected, units of measure, influential observations) could affect management's interpretation?

### Management Summary
19. What are the **three most important findings** management should know?
20. What **three actions** would you recommend management consider for its next vehicle line-up? Connect each recommendation to evidence from your analysis.

## Analysis Requirements
At minimum:
- Perform data inspection and profiling.
- Investigate missing, invalid, duplicate, miscoded, or unusual observations.
- Use appropriate univariate, bivariate, and multivariate analysis.
- Provide meaningful visualizations.
- Calculate appropriate descriptive statistics.
- Perform statistical tests where they add value, and check whether their assumptions are reasonable given the small sample.
- Clearly distinguish observations supported by data from assumptions or interpretations.

Do not simply produce charts and statistical outputs. Explain what important results mean in the context of the business.

## Required Outputs
Submit an **R Markdown (`.Rmd`) analysis** and its rendered **HTML report**.

The report should contain:

1. **Data Overview and Preparation**
   - Dataset description
   - Data profiling
   - Data-quality issues and limitations
   - Cleaning or transformations performed (e.g., moving row names into a column, converting coded variables to factors, deriving brand and origin)

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
- With only 32 observations, a single vehicle can strongly influence results; check for influential points.
- Statistical significance does not automatically imply business significance.
- Association or correlation should not be presented as evidence of causation.
- The data reflects 1970s vehicles; be explicit about how far conclusions can be generalized to today's market.
- Document important assumptions made during the analysis, including how brand and origin were assigned.