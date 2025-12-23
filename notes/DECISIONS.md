## Data Scope
- Used single institution (Wells Fargo) to keep dataset manageable
- Focused on 2024 only for recency

## Outcome Definition
- Used "action_taken = 3" as denial proxy
- Excluded purchased loans from decision analysis

## Missing Data
- Retained NULL income values rather than dropping records
- Avoided imputing income to prevent bias


###2025-12-21

## Data Preparation Strategy

- Kept HMDA data in a raw table exactly as imported
- Planned creation of a separate cleaned table to handle type casting and analysis logic
- Avoided modifying raw data to preserve reproducibility
