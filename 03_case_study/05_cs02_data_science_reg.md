# Take-Home Case Study: NYC Taxi Trip Duration

## Background

New York City taxi operators handle a large number of trips across different
locations, times of day, traffic conditions, and passenger demands. Before a
trip begins, passengers and dispatch teams need a reasonable estimate of how
long the journey may take.

Accurate trip-duration estimates can support:

- More reliable passenger arrival-time estimates
- Better driver and vehicle allocation
- Improved dispatch planning
- Identification of locations and periods with unusually long travel times
- Better monitoring of model reliability during congestion and unusual events

In this case study, you will build and evaluate a regression solution using the
**New York City Taxi Trip Duration** dataset. You will predict the duration of
each trip in seconds, submit your predictions to Kaggle, and document your
score.

Competition page:
[New York City Taxi Trip Duration](https://www.kaggle.com/competitions/nyc-taxi-trip-duration)

## Business problem

The taxi operator needs to answer the following main question:

> How can pickup information, passenger count, geographic coordinates, and
> temporal patterns be used to estimate a taxi trip's duration before the trip
> is completed?

The regression target is:

- `trip_duration`: duration of the trip in seconds

The prediction must be made using only information that would reasonably be
available at or before pickup.

## Case-study objectives

Your team must:

1. Understand the taxi trip data and the operational prediction problem.
2. Assess data quality and identify implausible or unusual trips.
3. Explore spatial, temporal, and passenger-related travel patterns.
4. Engineer meaningful time and geographic features.
5. Establish a simple regression baseline.
6. Train and compare at least two regression models.
7. Use a validation strategy that respects the temporal nature of the data.
8. Evaluate the models using Kaggle's metric and other regression metrics.
9. Analyze when and where the selected model produces large errors.
10. Generate trip-duration predictions for Kaggle's test data.
11. Submit the predictions to Kaggle and document the resulting score.
12. Translate the results into operational recommendations and limitations.

## Data source

Download the files from the competition's
[Data page](https://www.kaggle.com/competitions/nyc-taxi-trip-duration/data).

The main files are:

| File | Description |
|---|---|
| `train.csv` | Historical taxi trips containing the target `trip_duration` |
| `test.csv` | Taxi trips requiring predicted durations |
| `sample_submission.csv` | Required Kaggle submission structure |

Important variables include:

| Variable | Description |
|---|---|
| `id` | Unique trip identifier |
| `vendor_id` | Identifier for the taxi provider |
| `pickup_datetime` | Date and time when the meter was activated |
| `dropoff_datetime` | Date and time when the meter was deactivated; training data only |
| `passenger_count` | Number of passengers entered by the driver |
| `pickup_longitude`, `pickup_latitude` | Pickup coordinates |
| `dropoff_longitude`, `dropoff_latitude` | Drop-off coordinates |
| `store_and_fwd_flag` | Whether trip data were temporarily stored before transmission |
| `trip_duration` | Trip duration in seconds; training target only |

> **Target leakage warning:** Do not use `dropoff_datetime` as a predictor. It
> directly reveals the target when combined with `pickup_datetime`, and it is
> unavailable in `test.csv`.

## Business questions

Your report must answer the following questions.

### Trip and demand patterns

1. How are trip durations distributed?
2. How do trip volume and duration vary by hour, weekday, and month?
3. Which pickup periods are associated with longer or more variable trips?
4. How does passenger count relate to trip duration?
5. Are there differences between vendors or store-and-forward categories?

### Geographic patterns

6. Which pickup and drop-off areas have the greatest trip volumes?
7. How strongly is geographic distance related to trip duration?
8. Which origin–destination patterns have unusually long travel times?
9. Are there coordinate values that appear outside a reasonable New York City
   area?
10. Does the same approximate distance produce different durations at different
    times of day?

### Model performance

11. How well does a simple baseline predict trip duration?
12. How much improvement comes from time-based features?
13. How much additional improvement comes from geographic features?
14. Which candidate model performs best on the chronological validation set?
15. During which hours, weekdays, trip distances, or locations does the model
    make its largest errors?

### Operational use

16. How could predicted durations support passengers, drivers, and dispatchers?
17. When should the system communicate a wider uncertainty range instead of a
    single estimate?
18. What conditions not represented in the supplied data could cause the model
    to fail?

## Required procedures

### 1. Understand the data

- Identify the grain of the dataset.
- Confirm that `id` uniquely identifies each trip.
- Compare the columns and data types in `train.csv` and `test.csv`.
- Identify which columns are unavailable when the prediction must be made.
- Confirm that `trip_duration` is measured in seconds.

### 2. Assess data quality

At minimum, investigate:

- Number of rows and columns
- Data types and timestamp parsing
- Duplicate rows and duplicate trip identifiers
- Missing values
- Zero or negative trip durations
- Extremely short or long trips
- Zero-distance trips
- Implausible passenger counts
- Invalid or unusual coordinates
- Trips with unrealistic implied speeds
- Differences between training and Kaggle test data

Document how each material issue was treated. Do not remove records only because
they are inconvenient to model. Define and justify any filtering or capping
rules.

### 3. Perform exploratory analysis

Your report must contain readable visualizations and written interpretations.
Suggested analyses include:

- Histogram or density plot of raw `trip_duration`
- Distribution of `log1p(trip_duration)`
- Trip volume and median duration by pickup hour
- Trip duration by weekday and month
- Duration versus geographic distance
- Duration by passenger count and vendor
- Pickup or drop-off coordinate plots
- Trip speed and possible outliers

Because trip duration is typically right-skewed, compare the raw and
log-transformed target distributions.

### 4. Engineer temporal features

Extract useful information from `pickup_datetime`. Required features include:

- Pickup year
- Pickup month
- Pickup day of month
- Pickup weekday
- Pickup hour
- Weekend indicator
- Rush-hour indicator

You may also create:

- Week of year
- Day of year
- Minutes since midnight
- Cyclical encodings for hour or weekday
- Holiday indicator

Explain the operational reasoning for every engineered feature.

### 5. Engineer geographic features

Coordinates should be transformed into features that better describe the trip.
At minimum, create one valid distance measure, such as Haversine distance.

Additional possible features include:

- Manhattan-style distance
- Latitude difference
- Longitude difference
- Trip direction or bearing
- Pickup-location cluster
- Drop-off-location cluster
- Origin–destination cluster pair
- Approximate airport-trip indicator

Do not use actual trip speed as a predictor because calculating it requires the
target `trip_duration`. Speed may be used only for data-quality analysis on the
training data.

### 6. Prevent target leakage

The following must not be used as predictors:

- `trip_duration`
- `dropoff_datetime`
- Any feature calculated using `trip_duration`
- Any information that becomes available only after the trip ends

All learned preprocessing—including imputation, scaling, encoding, clustering,
and feature selection—must be fitted using training data only.

### 7. Create a validation strategy

Use a **chronological validation split**:

1. Sort the training observations by `pickup_datetime`.
2. Use earlier trips for model training.
3. Use a later period for validation.

For example, the earliest 80% of trips may be used for training and the latest
20% for validation. You may use another temporal boundary if it is clearly
explained.

Do not rely only on a random split. A chronological split better represents the
operational task of learning from earlier trips and predicting later trips.

### 8. Establish a baseline

Create at least one simple benchmark, such as:

- Overall median trip duration
- Median trip duration by pickup hour
- Median duration for a geographic-distance band

All candidate models must be compared against the same baseline and validation
observations.

### 9. Train candidate models

Train and compare at least **two regression models**, excluding the baseline.

Required model categories:

1. A linear model, such as multiple linear regression or regularized regression
2. A tree-based model, such as a regression tree, random forest, or
   gradient-boosted trees

You may train the model using `log1p(trip_duration)` as the response. If you do,
convert predictions back to seconds using `expm1()` before creating the Kaggle
submission.

Hyperparameter tuning must be performed within the training-validation process.
Do not repeatedly tune the model against the Kaggle public leaderboard.

If computing resources are limited, you may use a representative sample during
development. The sampling method must be documented. The final selected model
should use as much training data as is reasonably possible.

### 10. Evaluate the models

The Kaggle competition uses **root mean squared logarithmic error (RMSLE)**:

\[
\text{RMSLE} =
\sqrt{
\frac{1}{n}
\sum_{i=1}^{n}
\left[
\log(\hat{y}_i + 1) - \log(y_i + 1)
\right]^2
}
\]

where:

- \(y_i\) is the actual trip duration in seconds; and
- \(\hat{y}_i\) is the predicted trip duration in seconds.

Lower RMSLE values indicate better performance.

Also report:

- Mean absolute error (MAE)
- Root mean squared error (RMSE)
- Median absolute error
- Validation RMSLE
- Residual summaries or plots

Evaluate errors by operationally meaningful groups, including:

- Pickup hour
- Weekday versus weekend
- Distance band
- Short, medium, and long trips
- Vendor

Explain why one overall score is insufficient for deciding whether the model is
operationally reliable.

### 11. Interpret the selected model

Identify the most influential features using a method appropriate to the model,
such as:

- Linear-model coefficients
- Regression-tree rules
- Permutation importance
- Model-specific feature importance
- Partial-dependence plots as an optional extension

Discuss whether the learned relationships are operationally sensible. Feature
importance indicates predictive usefulness, not causality.

### 12. Retrain and generate Kaggle predictions

After selecting the model using local validation:

1. Apply the same feature-engineering logic to `train.csv` and `test.csv`.
2. Fit preprocessing using the full eligible training data.
3. Retrain the selected model.
4. Predict `trip_duration` for every row in `test.csv`.
5. Convert transformed predictions back to seconds if necessary.
6. Ensure that every prediction is finite and nonnegative.

Do not use Kaggle leaderboard results to select among many repeatedly adjusted
models. Model selection should be based primarily on local validation.

### 13. Create and submit the Kaggle file

The submission must contain exactly these columns:

```text
id,trip_duration
```

`trip_duration` must contain predicted durations in seconds—not log-duration
values.

Example structure:

```text
id,trip_duration
id3004672,845.2
id3505355,612.8
```

Before submitting, verify that:

- Every test trip appears exactly once.
- The row count matches `test.csv`.
- The `id` values and their order match `sample_submission.csv`.
- No predicted duration is missing, infinite, or negative.
- Log-transformed predictions have been converted back to seconds.
- The file is saved as CSV without an extra index column.

Each team must make at least **one valid Kaggle submission** when late
submissions remain available for the competition.

## Required outputs

Submit the following files and evidence.

### 1. Analysis report

Submit a rendered HTML, PDF, or notebook containing:

- Business understanding
- Dataset description
- Data-quality assessment
- Exploratory analysis
- Feature engineering
- Leakage controls
- Validation strategy
- Baseline and candidate models
- Model evaluation and comparison
- Error analysis by operational segment
- Model interpretation
- Operational recommendations
- Limitations

### 2. Reproducible source code

Submit the complete R Markdown, Quarto, Jupyter Notebook, R, or Python source
used to produce the analysis and predictions.

The code should run in the correct sequence from the raw files to the final
submission. Do not submit Kaggle API tokens, passwords, credentials, or other
secrets.

### 3. Kaggle submission file

Submit the exact CSV file uploaded to Kaggle.

### 4. Kaggle score evidence

Include:

- Team member or Kaggle username
- Submission date
- Submission description
- Kaggle public RMSLE score
- Screenshot of the successful submission and score
- Link to the competition submission page when accessible

The screenshot must clearly display the competition name, submission status,
and public score.

If Kaggle no longer accepts late submissions, include evidence of the platform
restriction and calculate the required RMSLE on the local chronological
validation set instead. Confirm this with the instructor before using the
alternative.

### 5. Short management summary

Prepare a maximum one-page or five-slide summary covering:

- Business problem
- Important trip-duration patterns
- Selected model and validation performance
- Kaggle public score
- Proposed operational use
- Conditions in which the estimates are least reliable
- Major limitations

## Kaggle score and academic assessment

The Kaggle public score demonstrates that the submission pipeline works and
allows models to be evaluated against a common hidden test set. Leaderboard
performance is only one part of the assessment.

Learners will not be rewarded for repeatedly tuning against the public
leaderboard. Strong submissions should demonstrate:

- A defensible chronological validation design
- Leakage-free and reproducible feature engineering
- Meaningful geographic and temporal features
- Honest comparison against a baseline
- Clear operational interpretation
- Thoughtful error and limitation analysis

The public leaderboard must not replace local validation.

## Suggested scoring rubric

| Criterion | Weight |
|---|---:|
| Business understanding and problem framing | 10% |
| Data understanding and data quality | 10% |
| Exploratory analysis | 10% |
| Temporal and geographic feature engineering | 20% |
| Validation design and leakage prevention | 15% |
| Modeling, evaluation, and error analysis | 20% |
| Kaggle submission and score evidence | 10% |
| Operational interpretation and communication | 5% |
| **Total** | **100%** |

The Kaggle component should assess successful submission, correct prediction
format, and thoughtful comparison between the Kaggle score and local validation
performance—not simply reward the best leaderboard position.

## Reflection questions

Answer the following in your report:

1. Which data-quality issue had the greatest effect on your workflow?
2. Which rules did you use to identify implausible trips, and why?
3. Which temporal feature contributed the most useful information?
4. Which geographic feature contributed the most useful information?
5. How did you prevent target leakage?
6. Why is chronological validation preferable to a purely random split for this
   problem?
7. Why did you select your final model?
8. How does the Kaggle public RMSLE compare with your local validation RMSLE?
9. What might explain a substantial difference between the two scores?
10. For which trip types does the model make its largest errors?
11. What important predictors—such as traffic, weather, road closures, or route
    choice—are missing from the supplied data?
12. How should uncertainty be communicated to passengers and dispatchers?

## Important limitations and responsible-use requirements

- Geographic distance is not the same as actual road distance or chosen route.
- The supplied data do not fully represent traffic, weather, construction,
  accidents, road closures, or special events.
- Historical travel patterns may change over time.
- Extreme trips can materially affect model training and evaluation.
- A point prediction does not communicate uncertainty; real systems should
  consider prediction intervals or ranges.
- Trip estimates should support passengers and drivers, not be used as the sole
  basis for punitive driver-performance decisions.
- A production solution requires monitoring for data drift, performance drift,
  geographic bias, and recurring high-error conditions.

## References

- [NYC Taxi Trip Duration competition](https://www.kaggle.com/competitions/nyc-taxi-trip-duration)
- [Competition data](https://www.kaggle.com/competitions/nyc-taxi-trip-duration/data)
- [Kaggle evaluation requirements](https://www.kaggle.com/competitions/nyc-taxi-trip-duration/overview/evaluation)

