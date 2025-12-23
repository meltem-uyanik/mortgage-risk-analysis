-- sql/01_create_hmda_raw.sql
-- Auto-generated from CSV header
-- Source: /Users/meltemuyanik/Desktop/mortgage-risk-analysis/data/raw/KB1H1DSPRFMYMCUFXT09_header.csv

DROP TABLE IF EXISTS hmda_raw;

CREATE TABLE hmda_raw (
  "activity_year" TEXT,
  "lei" TEXT,
  "loan_type" TEXT,
  "loan_purpose" TEXT,
  "preapproval" TEXT,
  "construction_method" TEXT,
  "occupancy_type" TEXT,
  "loan_amount" TEXT,
  "action_taken" TEXT,
  "state_code" TEXT,
  "county_code" TEXT,
  "census_tract" TEXT,
  "applicant_ethnicity_1" TEXT,
  "applicant_ethnicity_2" TEXT,
  "applicant_ethnicity_3" TEXT,
  "applicant_ethnicity_4" TEXT,
  "applicant_ethnicity_5" TEXT,
  "co_applicant_ethnicity_1" TEXT,
  "co_applicant_ethnicity_2" TEXT,
  "co_applicant_ethnicity_3" TEXT,
  "co_applicant_ethnicity_4" TEXT,
  "co_applicant_ethnicity_5" TEXT,
  "applicant_ethnicity_observed" TEXT,
  "co_applicant_ethnicity_observed" TEXT,
  "applicant_race_1" TEXT,
  "applicant_race_2" TEXT,
  "applicant_race_3" TEXT,
  "applicant_race_4" TEXT,
  "applicant_race_5" TEXT,
  "co_applicant_race_1" TEXT,
  "co_applicant_race_2" TEXT,
  "co_applicant_race_3" TEXT,
  "co_applicant_race_4" TEXT,
  "co_applicant_race_5" TEXT,
  "applicant_race_observed" TEXT,
  "co_applicant_race_observed" TEXT,
  "applicant_sex" TEXT,
  "co_applicant_sex" TEXT,
  "applicant_sex_observed" TEXT,
  "co_applicant_sex_observed" TEXT,
  "applicant_age" TEXT,
  "applicant_age_above_62" TEXT,
  "co_applicant_age" TEXT,
  "co_applicant_age_above_62" TEXT,
  "income" TEXT,
  "purchaser_type" TEXT,
  "rate_spread" TEXT,
  "hoepa_status" TEXT,
  "lien_status" TEXT,
  "applicant_credit_scoring_model" TEXT,
  "co_applicant_credit_scoring_model" TEXT,
  "denial_reason_1" TEXT,
  "denial_reason_2" TEXT,
  "denial_reason_3" TEXT,
  "denial_reason_4" TEXT,
  "total_loan_costs" TEXT,
  "total_points_and_fees" TEXT,
  "origination_charges" TEXT,
  "discount_points" TEXT,
  "lender_credits" TEXT,
  "interest_rate" TEXT,
  "prepayment_penalty_term" TEXT,
  "debt_to_income_ratio" TEXT,
  "combined_loan_to_value_ratio" TEXT,
  "loan_term" TEXT,
  "intro_rate_period" TEXT,
  "balloon_payment" TEXT,
  "interest_only_payment" TEXT,
  "negative_amortization" TEXT,
  "other_non_amortizing_features" TEXT,
  "property_value" TEXT,
  "manufactured_home_secured_property_type" TEXT,
  "manufactured_home_land_property_interest" TEXT,
  "total_units" TEXT,
  "multifamily_affordable_units" TEXT,
  "submission_of_application" TEXT,
  "initially_payable_to_institution" TEXT,
  "aus_1" TEXT,
  "aus_2" TEXT,
  "aus_3" TEXT,
  "aus_4" TEXT,
  "aus_5" TEXT,
  "reverse_mortgage" TEXT,
  "open_end_line_of_credit" TEXT,
  "business_or_commercial_purpose" TEXT
);





SELECT COUNT(*) AS n_cols
FROM pragma_table_info('hmda_raw');


SELECT name
FROM pragma_table_info('hmda_raw')
LIMIT 10;
