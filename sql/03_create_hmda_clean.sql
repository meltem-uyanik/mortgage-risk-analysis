-- sql/03_create_hmda_clean.sql
-- Purpose: Create an analysis-ready table (hmda_clean) from hmda_raw.
-- Raw table notes:
-- - hmda_raw mirrors the CSV and stores everything as TEXT.
-- - hmda_clean standardizes missing values and casts key numeric fields.
--
-- Outcome definition (initial):
-- - action_taken codes are HMDA outcomes. We treat 1-8 as "a decision recorded".
-- - Denied is action_taken = 3 (standard HMDA meaning).
--   We'll validate distribution after creation.




DROP TABLE IF EXISTS hmda_clean;

CREATE TABLE hmda_clean AS
SELECT
  -- IDs / geography
  activity_year,
  lei,
  state_code,
  county_code,
  census_tract,

  -- Loan / application
  loan_type,
  loan_purpose,
  occupancy_type,
  construction_method,
  preapproval,
  lien_status,

  -- Amounts (keep raw + numeric)
  NULLIF(loan_amount, '') AS loan_amount_raw,
  CAST(NULLIF(loan_amount, '') AS INTEGER) AS loan_amount,

  NULLIF(income, 'NA') AS income_raw,
  CAST(NULLIF(income, 'NA') AS REAL) AS income,

  -- Pricing / risk-related
  NULLIF(interest_rate, 'NA') AS interest_rate_raw,
  CAST(NULLIF(interest_rate, 'NA') AS REAL) AS interest_rate,

  NULLIF(rate_spread, 'NA') AS rate_spread_raw,
  CAST(NULLIF(rate_spread, 'NA') AS REAL) AS rate_spread,

  debt_to_income_ratio,
  combined_loan_to_value_ratio,
  loan_term,

  NULLIF(property_value, 'NA') AS property_value_raw,
  CAST(NULLIF(property_value, 'NA') AS REAL) AS property_value,

  -- Borrower demographics (keep as text categories for now)
  applicant_age,
  applicant_age_above_62,
  co_applicant_age,
  co_applicant_age_above_62,

  applicant_sex,
  co_applicant_sex,
  applicant_ethnicity_1,
  applicant_race_1,

  -- Outcome
  action_taken,

  CASE
    WHEN action_taken IN ('1','2','3','4','5','6','7','8') THEN 1
    ELSE 0
  END AS is_decision,

  CASE
    WHEN action_taken = '3' THEN 1
    ELSE 0
  END AS is_denied

FROM hmda_raw;



----sqlite3 "data/raw/mortgage_risk.db" < "sql/03_create_hmda_clean.sql"


----sqlite3 -header -column "data/raw/mortgage_risk.db" \
----"SELECT COUNT(*) AS n_rows, SUM(is_decision) AS decisions, SUM(is_denied) AS denied FROM hmda_clean;"
----

----sqlite3 -header -column "data/raw/mortgage_risk.db" \
----"SELECT action_taken, COUNT(*) AS n FROM hmda_clean GROUP BY action_taken ORDER BY n DESC;"



--1 → Loan originated ✅ (accepted)
--2 → Application approved but not accepted
--3 → Application denied ❌
--4 → Application withdrawn by applicant
--5 → File closed for incompleteness
--6 → Purchased loan