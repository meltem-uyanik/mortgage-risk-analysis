-- sql/06_loan_amount_distribution_counts.sql
-- Purpose:
-- Exploratory analysis of loan amount distribution (counts only).
-- This step examines the scale and skew of loan amounts prior to bin definition.
-- No outcome variables (e.g., denial) are used here.

SELECT
  CASE
    WHEN loan_amount < 100000 THEN '<100k'
    WHEN loan_amount < 250000 THEN '100k–250k'
    WHEN loan_amount < 500000 THEN '250k–500k'
    WHEN loan_amount < 750000 THEN '500k–750k'
    WHEN loan_amount < 1000000 THEN '750k–1M'
    WHEN loan_amount < 2000000 THEN '1M–2M'
    ELSE '2M+'
  END AS loan_amount_range,
  COUNT(*) AS n_applications
FROM hmda_clean
WHERE action_taken IN (1,2,3)
  AND loan_amount IS NOT NULL
GROUP BY loan_amount_range
ORDER BY
  CASE loan_amount_range
    WHEN '<100k' THEN 1
    WHEN '100k–250k' THEN 2
    WHEN '250k–500k' THEN 3
    WHEN '500k–750k' THEN 4
    WHEN '750k–1M' THEN 5
    WHEN '1M–2M' THEN 6
    ELSE 7
  END;
