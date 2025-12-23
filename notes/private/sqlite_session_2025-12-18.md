SQLite Session Log — HMDA Import

Date: 2025-12-18
Database: mortgage_risk.db
Data file: KB1H1DSPRFMYMCUFXT09_header.csv

This document records the interactive SQLite session used to import and inspect
HMDA mortgage application data. The goal of this session was to understand the
file structure, correctly import the data, and validate the raw table before
creating cleaned analysis tables.

------------------------------------------------------------

Step 1: Create SQLite database

Command:
sqlite3 mortgage_risk.db

Description:
Started a new SQLite database to store HMDA mortgage application data.

------------------------------------------------------------

Step 2: Inspect SQLite environment

Command:
.tables

Description:
Checked existing tables in the database to confirm the environment state.

------------------------------------------------------------

Step 3: Configure CSV import settings

Commands:
.separator "|"
.mode csv

Description:
Configured SQLite to correctly parse the HMDA file, which uses a pipe (|)
delimiter instead of commas.

------------------------------------------------------------

Step 4: Import HMDA data into raw table

Command:
.import data/raw/KB1H1DSPRFMYMCUFXT09_header.csv hmda_raw

Description:
Imported the HMDA CSV file into a raw SQLite table named hmda_raw.

------------------------------------------------------------

Step 5: Validate import

Commands:
SELECT COUNT(*) FROM hmda_raw;
SELECT * FROM hmda_raw LIMIT 1;

Description:
Verified that rows were successfully imported and inspected sample records.

------------------------------------------------------------

Step 6: Inspect table structure

Command:
PRAGMA table_info(hmda_raw);

Description:
Reviewed column structure to confirm fields were parsed correctly.

------------------------------------------------------------

Step 7: Debug import issues

Observations:
- Initial import attempt treated the entire row as a single column.
- Identified that delimiter and header handling needed correction.
- Adjusted import settings and re-imported the data successfully.

------------------------------------------------------------

Step 8: Cleaned table planning

Planning notes:
- Identified numeric fields to cast (loan_amount, income).
- Identified outcome variable (action_taken) for denial analysis.
- Planned creation of a separate hmda_clean table to preserve raw data
  while enabling analytical transformations.

------------------------------------------------------------

End of session log.


PRAGMA database_list; ------gives the exacxt path of the connection 