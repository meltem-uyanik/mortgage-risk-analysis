
-- sql/08_denial_rate_by_loan_amount.sql
-- Purpose:
-- Compute mortgage denial rates by loan amount bin.
-- Uses decision-only applications and pre-defined loan amount bins.

SELECT
  loan_amount_bin,
  COUNT(*) AS n_decisions,
  SUM(CASE WHEN action_taken = 3 THEN 1 ELSE 0 END) AS n_denied,
  ROUND(
    1.0 * SUM(CASE WHEN action_taken = 3 THEN 1 ELSE 0 END) / COUNT(*),
    3
  ) AS denial_rate
FROM (
  SELECT
    *,
    CASE
      WHEN loan_amount < 100000 THEN '<100k'
      WHEN loan_amount < 250000 THEN '100k–250k'
      WHEN loan_amount < 500000 THEN '250k–500k'
      WHEN loan_amount < 750000 THEN '500k–750k'
      WHEN loan_amount < 1000000 THEN '750k–1M'
      WHEN loan_amount < 2000000 THEN '1M–2M'
      ELSE '2M+'
    END AS loan_amount_bin
  FROM hmda_clean
  WHERE action_taken IN (1,2,3)
    AND loan_amount IS NOT NULL
) binned
GROUP BY loan_amount_bin
ORDER BY
  CASE loan_amount_bin
    WHEN '<100k' THEN 1
    WHEN '100k–250k' THEN 2
    WHEN '250k–500k' THEN 3
    WHEN '500k–750k' THEN 4
    WHEN '750k–1M' THEN 5
    WHEN '1M–2M' THEN 6
    ELSE 7
  END;




--sqlite3 -header -csv data/raw/mortgage_risk.db \
--< sql/08_denial_rate_by_loan_amount.sql \
--> data/derived/hmda_denial_rate_by_loan_amount.csv
--