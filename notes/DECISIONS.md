## Data Scope
- Used single institution (Wells Fargo) to keep dataset manageable
- Focused on 2024 only for recency

## Outcome Definition
- Used "action_taken = 3" as denial proxy
- Excluded purchased loans from decision analysis

## Missing Data
- Retained NULL income values rather than dropping records
- Avoided imputing income to prevent bias


### 2025-12-21

## Data Preparation Strategy
- Kept HMDA data in a raw table exactly as imported
- Planned creation of a separate cleaned table to handle type casting and analysis logic
- Avoided modifying raw data to preserve reproducibility


### 2026-01-18

## Loan Amount Binning (HMDA)
Loan amount bins were defined after examining the empirical distribution of loan sizes.
Because the variable is highly right-skewed, business-meaningful dollar ranges were used
to preserve interpretability while ensuring each bin had sufficient sample size for
stable denial rate estimates.


### 2026-01-28

## Age and Income Stratification (Project 3)

- Extended analysis to include applicant age groups using HMDA-provided age bins
- Mapped age bins to broad generational cohorts (Gen Z, Millennial, Gen X, Baby Boomer)
- Used age bins as provided by HMDA rather than attempting to infer exact age

- Introduced income bins to stratify denial rates within comparable income ranges
- Income bins were defined using policy-relevant thresholds to balance interpretability
  and sample size stability

- Combined state, generation, and income bin dimensions to examine conditional
  differences in mortgage denial rates while avoiding causal claims

- Retained NULL income values in the cleaned dataset to preserve the full application universe
- Analyses involving income stratification explicitly exclude records with missing income

Rationale:
Stratifying by income addresses a key confounding factor when comparing denial
rates across age groups, allowing for more interpretable comparisons without
asserting causality or discrimination.



- Avoided using derived decision flags due to inconsistent encoding across action_taken values;
  explicitly restricted analysis to action_taken ∈ {1,2,3} for transparency.
