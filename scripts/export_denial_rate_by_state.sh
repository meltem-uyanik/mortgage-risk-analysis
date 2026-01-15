#!/usr/bin/env bash

# Export denial rate by state for visualization
# Source: SQLite hmda_clean table
# Output: CSV for Tableau / Power BI

sqlite3 -header -csv data/raw/mortgage_risk.db \
< sql/04_denial_rate_by_state.sql \
> data/derived/denial_rate_by_state.csv


# Then make it executable (one-time):
# chmod +x scripts/export_denial_rate_by_state.sh

# Then make it executable (one-time):
#./scripts/export_denial_rate_by_state.sh

# Verify:
# ls -lh data/derived/denial_rate_by_state.csv
# head data/derived/denial_rate_by_state.csv

# standardize all exports like:
# scripts/export_*.sh
# sql/0*_*.sql
# data/derived/
