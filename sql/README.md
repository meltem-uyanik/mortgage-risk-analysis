# Mortgage Risk Analysis (HMDA)

This project analyzes U.S. mortgage application outcomes using HMDA Modified LAR data.
The goal is to quantify mortgage denial rates and explore how they vary by geography
and applicant characteristics.

## Data
- Source: HMDA 2024 Modified Loan/Application Register (LAR)
- Unit of analysis: individual mortgage applications
- Data is not included in this repository due to size; all steps are reproducible.

## Project Structure
- `sql/` — schema creation, data cleaning, and analysis queries
- `notes/` — worklog, modeling decisions, and open questions
- `data/raw/` — placeholder for raw data (not committed)

## Pipeline Overview
1. Create raw schema from CSV header (`01_create_hmda_raw.sql`)
2. Import pipe-delimited HMDA data via SQLite CLI (`02_import_hmda_raw.sql`)
3. Build analysis-ready table (`hmda_clean`)
4. Compute decision-only denial rates by state

## Key Metric
Denial rate is defined as:

Denied / (Denied + Originated)

using HMDA action_taken codes:
- 1 = originated
- 3 = denied

Other outcomes (withdrawn, incomplete, purchased) are excluded.

## Current Analyses
- Decision-only mortgage denial rate by U.S. state

## Next Steps
- Denial rates by income and loan amount
- BI dashboard (Tableau / Power BI)
- Short written interpretation of findings
