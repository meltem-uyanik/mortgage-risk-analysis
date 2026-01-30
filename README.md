# Mortgage Risk Analysis (HMDA 2024)
_Last updated: 2026-01-30_

This project analyzes U.S. mortgage application outcomes using the **HMDA 2024 Modified Loan/Application Register (LAR)** data.  
The goal is to **describe mortgage denial rates** and examine how they vary across **states** and **loan amount ranges**, using transparent, reproducible SQL-based analysis and clear visualizations.

The analysis is **descriptive**, focuses on reported application outcomes, and avoids causal claims.

---

## Project Overview

Mortgage lending data are central to understanding credit access, risk patterns, and geographic variation in application outcomes.  
In this project, I use HMDA 2024 data to:

- Compute mortgage denial rates at the **state level**
- Examine how denial rates vary across **loan amount bins**
- Present results through **interactive Tableau dashboards**
- Emphasize reproducibility, documentation, and careful interpretation

This project was developed as part of a data analytics portfolio with a focus on **lending and mortgage analytics**.

---

## Key Findings (Summary)

- Mortgage denial rates vary across U.S. states in the 2024 HMDA records.
- Denial rates are generally higher for lower loan amount ranges and decrease as loan amounts increase.
- Observed patterns reflect **reported application outcomes** and should be interpreted as descriptive summaries rather than causal relationships.

---

## Data

- **Source:** HMDA 2024 Modified Loan/Application Register (LAR)
- **Unit of analysis:** Individual mortgage applications
- **Data format:** Pipe-delimited text file (raw data not included in this repository)

Raw HMDA data are not committed due to size and licensing considerations.  
All results in this project are generated through SQL scripts that can be re-run locally using the original HMDA files.

---

## Analysis Pipeline

1. Import HMDA 2024 Modified LAR data into a SQLite database.
2. Filter records to include applications with a lender credit decision.
3. Define mortgage denial rates as:
   
   > **Denial rate = denied applications / total applications**
4. Aggregate denial rates by:
   - U.S. state  
   - Loan amount bins
5. Export aggregated results for visualization.
6. Create interactive dashboards using Tableau Public.

All transformations and aggregations are implemented in SQL for transparency and reproducibility.

---

## Visualizations

Interactive dashboards are published on Tableau Public:

- **Mortgage Denial Rates by State (HMDA 2024)**  
  https://public.tableau.com/app/profile/meltem.uyanik/viz/MortgageDenialRatesbyStateHMDA2024/MortgageDenialRatesHMDA2024

- **Mortgage Denial Rates by Loan Amount (HMDA 2024)**  
  https://public.tableau.com/app/profile/meltem.uyanik/viz/MortgageDenialRatesbyLoanAmountHMDA2024/MortgageDenialRatesbyLoanAmountHMDA2024

These dashboards allow users to explore geographic and loan-size-based patterns in denial rates interactively.

---

## Repository Structure

```text
mortgage-risk-analysis/
├── sql/            # SQL scripts for data preparation and aggregation
├── notes/          # Project notes, decisions, and workflow documentation
├── images/         # Dashboard screenshots for README preview
├── data/            # (empty placeholders; raw and derived data are ignored)
└── README.md
