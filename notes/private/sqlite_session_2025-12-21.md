## 2025-12-21

- Restarted SQLite setup from scratch to avoid path and schema confusion
- Deleted previous SQLite connections and database file
- Verified presence of HMDA CSV file in data/raw directory
- Created new SQLite database (mortgage_risk.db)
- Created raw table schema for HMDA data (hmda_raw)
- Imported HMDA CSV using pipe (`|`) delimiter and skipped header row
- Verified successful import (89,959 rows)
- Confirmed columns were parsed correctly (no pipe-delimited strings in a single column)
- Connected database to VS Code using SQLTools

Step 1 — Create the database + table schema

sqlite3 "/Users/meltemuyanik/Desktop/mortgage-risk-analysis/data/raw/mortgage_risk.db"

--------------------
DROP TABLE IF EXISTS hmda_raw;

CREATE TABLE hmda_raw (
  activity_year TEXT,
  lei TEXT,
  loan_type TEXT,
  loan_purpose TEXT,
  preapproval TEXT,
  construction_method TEXT,
  occupancy_type TEXT,
  loan_amount TEXT,
  action_taken TEXT,
  state_code TEXT,
  county_code TEXT,
  census_tract TEXT,
  applicant_ethnicity_1 TEXT,
  applicant_ethnicity_2 TEXT,
  applicant_ethnicity_3 TEXT,
  applicant_ethnicity_4 TEXT,
  applicant_ethnicity_5 TEXT,
  co_applicant_ethnicity_1 TEXT,
  co_applicant_ethnicity_2 TEXT,
  co_applicant_ethnicity_3 TEXT,
  co_applicant_ethnicity_4 TEXT,
  co_applicant_ethnicity_5 TEXT,
  applicant_ethnicity_observed TEXT,
  co_applicant_ethnicity_observed TEXT,
  applicant_race_1 TEXT,
  applicant_race_2 TEXT,
  applicant_race_3 TEXT,
  applicant_race_4 TEXT,
  applicant_race_5 TEXT,
  co_applicant_race_1 TEXT,
  co_applicant_race_2 TEXT,
  co_applicant_race_3 TEXT,
  co_applicant_race_4 TEXT,
  co_applicant_race_5 TEXT,
  applicant_race_observed TEXT,
  co_applicant_race_observed TEXT,
  applicant_sex TEXT,
  co_applicant_sex TEXT,
  applicant_sex_observed TEXT,
  co_applicant_sex_observed TEXT,
  applicant_age TEXT,
  applicant_age_above_62 TEXT,
  co_applicant_age TEXT,
  co_applicant_age_above_62 TEXT,
  income TEXT,
  purchaser_type TEXT,
  rate_spread TEXT,
  hoepa_status TEXT,
  lien_status TEXT,
  applicant_credit_scoring_model TEXT,
  co_applicant_credit_scoring_model TEXT,
  denial_reason_1 TEXT,
  denial_reason_2 TEXT,
  denial_reason_3 TEXT,
  denial_reason_4 TEXT,
  total_loan_costs TEXT,
  total_points_and_fees TEXT,
  origination_charges TEXT,
  discount_points TEXT,
  lender_credits TEXT,
  interest_rate TEXT,
  prepayment_penalty_term TEXT,
  debt_to_income_ratio TEXT,
  combined_loan_to_value_ratio TEXT,
  loan_term TEXT,
  intro_rate_period TEXT,
  balloon_payment TEXT,
  interest_only_payment TEXT,
  negative_amortization TEXT,
  other_non_amortizing_features TEXT,
  property_value TEXT,
  manufactured_home_secured_property_type TEXT,
  manufactured_home_land_property_interest TEXT,
  total_units TEXT,
  multifamily_affordable_units TEXT,
  submission_of_application TEXT,
  initially_payable_to_institution TEXT,
  aus_1 TEXT,
  aus_2 TEXT,
  aus_3 TEXT,
  aus_4 TEXT,
  aus_5 TEXT,
  reverse_mortgage TEXT,
  open_end_line_of_credit TEXT,
  business_or_commercial_purpose TEXT
);
--------------------

Step 2 — Import the CSV (pipe-delimited, skip header)


.separator "|"
.mode csv
.import --skip 1 "/Users/meltemuyanik/Desktop/mortgage-risk-analysis/data/raw/KB1H1DSPRFMYMCUFXT09_header.csv" hmda_raw

Step 3 — Verify (this is the key check)

SELECT COUNT(*) AS n_rows FROM hmda_raw;
SELECT activity_year, lei, state_code, loan_amount, income, action_taken
FROM hmda_raw
LIMIT 5;


Step 4 — Reconnect VS Code SQLTools
in VS Code:
Create SQLite connection to

/Users/meltemuyanik/Desktop/mortgage-risk-analysis/data/raw/mortgage_risk.db

SELECT COUNT(*) FROM hmda_raw;

- Inspected HMDA action_taken codes after observing zero decision counts
- Updated hmda_clean logic to define decisions and denials using TEXT-safe comparisons
