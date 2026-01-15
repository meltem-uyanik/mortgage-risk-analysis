-- sql/04_denial_rate_by_state.sql
-- Purpose: Compute decision-only mortgage denial rates by U.S. state.
--
-- Definition:
-- - Decision-only applications are those with action_taken = 1 (originated)
--   or action_taken = 3 (denied).
-- - Denial rate = denied / (denied + originated).
-- - Other outcomes (withdrawn, incomplete, purchased) are excluded.




--Among applications where the lender made a true credit decision (approve or deny), 
--what fraction were denied?

SELECT 
  state_code,
  COUNT(*) AS n_decisions,
  SUM(is_denied) AS n_denied,
  ROUND(
    1.0 * SUM(is_denied) / COUNT(*),
    3
  ) AS denial_rate
FROM hmda_clean
WHERE is_decision = 1
  AND state_code IS NOT NULL
GROUP BY state_code
ORDER BY denial_rate DESC;




--SUM(is_denied) : Total number of denied applications in that group (state).

--1.0 * SUM(is_denied) / COUNT(*) : The 1.0 * is just to force decimal division (otherwise SQLite might do integer math).

--ROUND( ..., 3 ): keep 3 decimal places. e.g. 0.237 → 23.7% denial rate

--ROUND(
--  1.0 * SUM(is_denied) / COUNT(*),
--  3
--) AS denial_rate : For each state, take the number of denied mortgage applications and 
--divide it by the total number of applications where a credit decision was made.”
--numerator = all denied cases
--denominator = all decision cases
