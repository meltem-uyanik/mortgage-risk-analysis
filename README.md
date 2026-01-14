# Mortgage Risk Analysis (HMDA)

This project analyzes U.S. mortgage application outcomes using HMDA Modified LAR data.
The goal is to quantify mortgage denial rates and examine how they vary geographically.

## Data
- Source: HMDA 2024 Modified Loan/Application Register (LAR)
- Unit of analysis: individual mortgage applications
- Raw data is not included due to size; all steps are fully reproducible

## Project Structure
- `sql/` — schema creation, data cleaning, and analysis queries
- `notes/` — worklog, modeling decisions, and open questions
- `data/raw/` — placeholder for raw data (not committed)

## Pipeline Overview
1. Create raw schema from CSV header (`01_create_hmda_raw.sql`)
2. Import pipe-delimited HMDA data via SQLite CLI (`02_import_hmda_raw.sql`)
3. Build analysis-ready table (`hmda_clean`)
4. Compute decision-only denial rates by state

## Key Metric: Mortgage Denial Rate

Denial rate is defined as: denied/(denied+originated)

using HMDA `action_taken` codes:
- 1 = originated
- 3 = denied

Other outcomes (withdrawn, incomplete, purchased) are excluded.

## Mortgage Denial Rates by State (HMDA 2024)

This analysis examines mortgage denial rates across U.S. states using 2024 HMDA data.
Only applications where a lender made a credit decision (approved or denied) are included.
Records with missing state codes are excluded from state-level analysis.

The analysis includes:
- A bar chart ranking states by denial rate
- A U.S. choropleth map showing geographic patterns
- A national benchmark denial rate (19.3%) for context

All data transformations were performed in SQL and visualized in Tableau.

## Next Steps
- Denial rates by income and loan amount
- Additional BI dashboards (Tableau / Power BI)
- Short written interpretation of findings


## Interactive Dashboard

Explore the mortgage denial rate dashboard:

👉 https://public.tableau.com/app/profile/meltem.uyanik/viz/MortgageDenialRatesbyStateHMDA2024/MortgageDenialRatesHMDA2024?publish=yes

![Mortgage Denial Rates Dashboard](images/denial_rate_dashboard.png)

The interactive dashboard allows you to:
- View mortgage denial rates by U.S. state
- Compare states against the national average
- Click a state on the map to filter the bar chart


Denial rates vary substantially across states, with several states exceeding the national average, indicating meaningful geographic variation in mortgage lending outcomes.
