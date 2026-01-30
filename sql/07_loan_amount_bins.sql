
-- sql/07_loan_amount_bins.sql
-- Purpose:
-- Create loan amount bins based on predefined, business-meaningful ranges.
-- These bins were chosen after examining the empirical distribution of loan amounts.
-- No aggregation or outcome logic is applied in this step.

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
  AND loan_amount IS NOT NULL;


-- Given a loan amount, assign it to a predefined bin