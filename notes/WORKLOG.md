## 2025-12-18
- Created project structure for mortgage risk analysis
- Downloaded HMDA modified LAR (Wells Fargo): KB1H1DSPRFMYMCUFXT09.csv
- Noted delimiter is `|`
- Identified pipe-delimited CSV format
- Built reproducible SQLite pipeline using schema-first import
- Created raw (`hmda_raw`) and cleaned (`hmda_clean`) tables


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

- Inspected HMDA action_taken codes after observing zero decision counts
- Updated hmda_clean logic to define decisions and denials using TEXT-safe comparisons


##2025-12-23

- Computed decision-only mortgage denial rates by state
- Defined decision universe as originated (1) vs denied (3) applications
- Excluded withdrawn, incomplete, and purchased loans to avoid bias


## 2026-01-28

- Began Project 3 extension focusing on age and income stratification
- Reviewed HMDA applicant_age field and documented use of HMDA-provided age bins
- Designed generation mapping consistent with HMDA reporting constraints
- Planned income binning strategy to control for income-related confounding
- Defined state × generation × income as primary analytic unit
- Prepared SQL pipeline extensions for reproducible stratified analysis
