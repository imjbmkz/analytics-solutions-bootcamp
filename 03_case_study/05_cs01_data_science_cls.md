# Take-Home Case Study: Home Credit Default Risk

## Background

Home Credit is a financial institution that provides loans to people who may
have limited or no traditional credit history. Because these applicants may not
have sufficient records from conventional banks, lenders must use other
available information to assess whether a loan can be repaid.

Home Credit wants to improve its credit-risk assessment process. The company
needs a classification model that estimates the probability that an applicant
will experience difficulty repaying a loan. The prediction should help credit
teams prioritize applications for further review and design appropriate lending
conditions—not automatically reject applicants.

In this case study, you will build and evaluate a binary-classification solution
using the **Home Credit Default Risk** dataset. You will also generate
predictions for the Kaggle test data, submit them to Kaggle, and document your
score.

Competition page:
[Home Credit Default Risk](https://www.kaggle.com/competitions/home-credit-default-risk)

## Business problem

Home Credit needs to answer the following main question:

> How can available application and credit-history data be used to estimate an
> applicant's probability of repayment difficulty while supporting responsible
> and explainable lending decisions?

The `TARGET` variable is the classification outcome:

- `TARGET = 1`: The applicant experienced repayment difficulty.
- `TARGET = 0`: The applicant did not experience repayment difficulty.

This is an imbalanced classification problem. Accuracy alone must not be used
to determine whether a model performs well.

## Case-study objectives

Your team must:

1. Understand the business problem and the relationships among the supplied
   datasets.
2. Assess data quality, missingness, class imbalance, and unusual values.
3. Prepare applicant and credit-history data for machine learning.
4. Engineer useful and defensible applicant-level features.
5. Establish a simple baseline model.
6. Train and compare at least two classification models.
7. Evaluate the models using appropriate validation procedures and metrics.
8. Interpret the selected model and its most influential features.
9. Generate repayment-difficulty probabilities for `application_test.csv`.
10. Submit the predictions to Kaggle and document the resulting score.
11. Explain how the solution should—and should not—be used in lending
    operations.

## Data source

Download the files from the competition's
[Data page](https://www.kaggle.com/competitions/home-credit-default-risk/data).

The supplied files include:

| File | Description |
|---|---|
| `application_train.csv` | Current loan applications with the `TARGET` outcome |
| `application_test.csv` | Applications requiring predicted probabilities |
| `bureau.csv` | Previous credits reported by other financial institutions |
| `bureau_balance.csv` | Monthly status of credits recorded in `bureau.csv` |
| `previous_application.csv` | Previous Home Credit applications |
| `POS_CASH_balance.csv` | Monthly point-of-sale and cash-loan balances |
| `credit_card_balance.csv` | Monthly credit-card balances |
| `installments_payments.csv` | Repayment history for previous credits |
| `HomeCredit_columns_description.csv` | Dataset and column descriptions |
| `sample_submission.csv` | Required Kaggle submission structure |

The tables are connected using identifiers such as:

- `SK_ID_CURR`: current applicant or current application identifier
- `SK_ID_PREV`: previous Home Credit application identifier
- `SK_ID_BUREAU`: previous credit identifier from the credit bureau

## Minimum data requirement

You must use:

1. `application_train.csv` and `application_test.csv`; and
2. at least **one supplementary credit-history table**.

Using only the application tables does not satisfy the minimum requirement.

Supplementary tables contain multiple records for one applicant. Before joining
them to the application data, aggregate them to one row per `SK_ID_CURR`.
Careless joins may duplicate applicants and invalidate the model.

## Business questions

Your analysis must answer the following questions.

### Applicant and portfolio profile

1. What proportion of training applicants experienced repayment difficulty?
2. Which applicant characteristics are associated with higher or lower observed
   repayment-difficulty rates?
3. How do income, requested credit, annuity, employment history, age, and family
   characteristics vary across the two target classes?
4. Which variables have substantial missing data, and what might the missingness
   mean operationally?

### Credit-history behavior

5. What does the selected supplementary table reveal about an applicant's prior
   credit or repayment behavior?
6. Which applicant-level aggregates can be constructed from the selected
   history table?
7. Do the engineered credit-history features improve validation performance?

### Model performance

8. How well does a simple baseline perform?
9. Which candidate model provides the strongest validation ROC AUC?
10. How do the models compare in identifying applicants with repayment
    difficulty?
11. What types of errors does the selected model make?
12. Does model performance differ across important applicant groups?

### Operational use

13. How could predicted probabilities support application review?
14. What risks would arise if the model were used as an automatic loan-rejection
    system?
15. What additional policies, human reviews, and monitoring controls would be
    required before deployment?

## Required procedures

### 1. Understand the tables

- Identify the grain of every table used.
- Identify primary and joining keys.
- Show the relationship between the selected tables.
- Verify that the final modeling table has only one row per `SK_ID_CURR`.

### 2. Assess data quality

At minimum, investigate:

- Number of rows and columns
- Data types
- Duplicate records and duplicate identifiers
- Missing values
- Constant and near-constant variables
- Unusual or undocumented values
- Implausible values and sentinel values
- Class distribution of `TARGET`
- Differences between training and test data

Document how each material issue was treated. Do not remove observations or
variables without explaining the decision.

### 3. Perform exploratory analysis

Explore the relationship between `TARGET` and relevant variables. Your report
must contain readable visualizations and interpretations, not only code output.

Suggested areas include:

- Income and requested credit
- Credit-to-income and annuity-to-income relationships
- Age and employment history
- Contract and income type
- Housing and family characteristics
- External credit scores
- Prior loans, overdue accounts, balances, or payment behavior

Remember that association does not establish causation.

### 4. Engineer features

Create features that have a clear analytical or lending rationale. Possible
examples include:

- Credit-to-income ratio
- Annuity-to-income ratio
- Credit-to-annuity ratio
- Applicant age in years
- Employment length in years
- Number of previous credits or applications
- Number or proportion of active credits
- Average or maximum days overdue
- Total outstanding balance
- Payment-to-installment ratio
- Proportion of late payments

The appropriate features depend on the supplementary table selected. Prevent
target leakage: do not use information that would be unavailable when the
lending decision is made.

### 5. Create a validation strategy

- Separate predictors from the target and identifier.
- Create a stratified training-validation split or stratified cross-validation.
- Apply preprocessing using training data only.
- Ensure that imputation, encoding, scaling, and feature selection do not learn
  from validation or Kaggle test data.
- Set and report random seeds where applicable.

Explain why the validation design is appropriate.

### 6. Establish a baseline

Build at least one simple baseline, such as:

- A constant probability based on the training repayment-difficulty rate; or
- A simple logistic-regression model using a limited number of predictors.

The more complex models must be compared against this baseline.

### 7. Train candidate models

Train and compare at least **two classification models**, excluding the constant
baseline.

At least one model must be interpretable. Suggested models include:

- Logistic regression
- Regularized logistic regression
- Decision tree
- Random forest
- Gradient-boosted trees

Hyperparameter tuning is encouraged, but it must be performed using only the
training and validation process. Do not tune repeatedly against the Kaggle
public leaderboard.

### 8. Evaluate the models

The primary metric is **ROC AUC**, which is also used by the Kaggle competition.
See Kaggle's [Evaluation page](https://www.kaggle.com/competitions/home-credit-default-risk/overview/evaluation).

Also report:

- Confusion matrix at a stated threshold
- Recall or sensitivity
- Specificity
- Precision
- F1 score
- Precision-recall AUC, if available

Discuss why accuracy is insufficient for this dataset. Explain the business
meaning of false positives and false negatives.

### 9. Interpret the selected model

Identify the most influential features using a method appropriate to the model,
such as:

- Logistic-regression coefficients or odds ratios
- Decision-tree rules
- Permutation importance
- Model-specific feature importance
- SHAP values as an optional extension

Distinguish predictive importance from causal effect. A feature that improves
prediction is not necessarily a valid reason to deny credit.

### 10. Create and submit Kaggle predictions

Use the selected model to predict the probability of `TARGET = 1` for every row
in `application_test.csv`.

The submission must contain exactly these columns:

```text
SK_ID_CURR,TARGET
```

`TARGET` must contain probabilities between 0 and 1—not class labels.

Example structure:

```text
SK_ID_CURR,TARGET
100001,0.0724
100005,0.1841
```

Before submitting, verify that:

- Every Kaggle test applicant appears exactly once.
- The row count matches `application_test.csv`.
- `SK_ID_CURR` values and order match the required submission structure.
- No `TARGET` value is missing.
- All predictions fall between 0 and 1.
- The file is saved as CSV.

Each team must make at least **one valid Kaggle submission**.

## Required outputs

Submit the following files and evidence.

### 1. Analysis report

Submit a rendered HTML, PDF, or notebook containing:

- Business understanding
- Dataset and relationship description
- Data-quality assessment
- Exploratory analysis
- Feature engineering
- Validation strategy
- Baseline and candidate models
- Model evaluation and comparison
- Error analysis
- Model interpretation
- Operational recommendations
- Responsible-lending discussion
- Limitations

### 2. Reproducible source code

Submit the complete R Markdown, Quarto, Jupyter Notebook, R, or Python source
used to produce the results.

The code should run in the correct sequence from raw input files to final
predictions. Do not submit credentials, Kaggle API tokens, passwords, or other
secrets.

### 3. Kaggle submission file

Submit the exact CSV file uploaded to Kaggle.

### 4. Kaggle score evidence

Include:

- Team member or Kaggle username
- Submission date
- Submission description
- Kaggle public ROC AUC score
- Screenshot of the successful submission and score
- Link to the competition submission page when accessible

The screenshot must clearly display the competition name, submission status,
and public score.

### 5. Short management summary

Prepare a maximum one-page or five-slide summary covering:

- Business problem
- Most important findings
- Selected model and validation performance
- Kaggle public score
- Proposed operational use
- Major limitations and risks

## Kaggle score and academic assessment

The Kaggle public score demonstrates that the submission pipeline works and
allows comparison against a common test set. However, leaderboard performance
is only one part of the assessment.

Learners will not be rewarded for repeatedly tuning against the public
leaderboard. Strong submissions should show:

- A defensible local validation strategy
- Reproducible data preparation
- Meaningful feature engineering
- Honest comparison of models
- Clear business interpretation
- Responsible treatment of applicants

The private test labels are not available to learners, and the public
leaderboard should not replace local validation.

## Suggested scoring rubric

| Criterion | Weight |
|---|---:|
| Business understanding and problem framing | 10% |
| Data understanding, joins, and data quality | 15% |
| Exploratory analysis and feature engineering | 20% |
| Validation design and leakage prevention | 15% |
| Modeling and evaluation | 20% |
| Kaggle submission and score evidence | 10% |
| Interpretation, responsible lending, and communication | 10% |
| **Total** | **100%** |

The Kaggle component should assess successful submission, appropriate file
construction, and thoughtful comparison between the Kaggle score and local
validation—not simply reward the highest score.

## Reflection questions

Answer the following in your report:

1. Which data-quality issue had the greatest effect on your modeling workflow?
2. Which supplementary table did you use, and what new information did it add?
3. Which engineered feature contributed the most useful information, and why?
4. How did you prevent data leakage during preprocessing and validation?
5. Why did you select your final model?
6. How does its Kaggle public score compare with its local validation ROC AUC?
7. What might explain a substantial difference between the two scores?
8. Which model errors create the greatest lending risk?
9. Which variables require fairness, privacy, or regulatory review?
10. What additional evidence would be required before using this model in a real
    credit decision process?

## Important limitations and responsible-use requirements

- The data and competition are intended for analytical learning.
- A high ROC AUC does not prove that a model is fair, lawful, calibrated, or
  appropriate for deployment.
- Historical lending data may contain selection bias and past inequities.
- Removing protected variables does not automatically eliminate discrimination;
  other variables may act as proxies.
- Predictions should support qualified human review and applicant assistance,
  not fully automated adverse decisions.
- Real lending use requires governance, monitoring, explainability, security,
  fairness assessment, legal review, and an applicant appeal process.

## References

- [Home Credit Default Risk competition](https://www.kaggle.com/competitions/home-credit-default-risk)
- [Competition data](https://www.kaggle.com/competitions/home-credit-default-risk/data)
- [Kaggle evaluation and submission requirements](https://www.kaggle.com/competitions/home-credit-default-risk/overview/evaluation)
