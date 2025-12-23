-- sql/02_import_hmda_raw.sql
-- Purpose: Import HMDA pipe-delimited CSV into hmda_raw using sqlite3 CLI dot-commands.
--
-- IMPORTANT:
--   The commands below (.mode/.separator/.import/.headers) are SQLITE3 CLI dot-commands.
--   Run them in Terminal using sqlite3 (NOT inside SQLTools).
--
-- How to run (recommended, atomic + reproducible) from project root:
--
--   sqlite3 "data/raw/mortgage_risk.db" <<'SQL'
--   .read sql/01_create_hmda_raw.sql
--   DELETE FROM hmda_raw;
--   .mode csv
--   .separator "|"
--   .import --skip 1 "data/raw/KB1H1DSPRFMYMCUFXT09_header.csv" hmda_raw
--   .headers on
--   .mode column
--   SELECT COUNT(*) AS n_rows FROM hmda_raw;
--   SELECT activity_year, lei, loan_amount, state_code, action_taken FROM hmda_raw LIMIT 5;
--   SELECT
--     SUM(CASE WHEN lei IS NULL OR lei = '' THEN 1 ELSE 0 END) AS lei_missing,
--     SUM(CASE WHEN state_code IS NULL OR state_code = '' THEN 1 ELSE 0 END) AS state_missing,
--     SUM(CASE WHEN action_taken IS NULL OR action_taken = '' THEN 1 ELSE 0 END) AS action_taken_missing
--   FROM hmda_raw;
--   SELECT
--     COUNT(*) AS rows_with_pipes_in_activity_year
--   FROM hmda_raw
--   WHERE activity_year LIKE '%|%';
--   SQL
--
-- Notes:
-- - DELETE FROM hmda_raw; keeps the schema but removes any previously imported data.
-- - --skip 1 prevents the header row from being imported as data.
-- - The "pipes in activity_year" check catches the classic “delimiter not applied” problem.

-- (This file is primarily documentation; use the block above to run the import.)



----------------------------------
--------------------------------------------

sqlite3 "data/raw/mortgage_risk.db" <<'SQL'
DELETE FROM hmda_raw;

.mode csv
.separator "|"
.import --skip 1 "data/raw/KB1H1DSPRFMYMCUFXT09_header.csv" hmda_raw
SQL

------------------

--.mode csv
--Tells SQLite: “I’m about to import structured text data.”
--.separator "|"
--Tells SQLite: “Split each row on | instead of comma.”
--This is stateful — SQLite remembers this only inside the current session.
--.import --skip 1 ...
--Uses the current mode and separator
--Skips the header row
--Inserts values position-by-position into the 85 columns

-------------------------------------------------------
----------------------------------------------------