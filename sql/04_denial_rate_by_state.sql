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

-- sql/04_denial_rate_by_state.sql
-- Purpose: Compute decision-only mortgage denial rates by U.S. state.
--
-- Definition:
-- - Includes only applications with a true credit decision using HMDA action_taken codes:
--     * 1 = Approved / originated
--     * 2 = Approved but not accepted
--     * 3 = Denied
-- - Denial rate = denied / (approved + approved_not_accepted + denied)
-- - Excludes withdrawn, incomplete, and purchased loans (action_taken 4–6).
-- - Records with missing state codes are excluded.

SELECT
  state_code,
  COUNT(*) AS n_decisions,
  SUM(CASE WHEN action_taken = 3 THEN 1 ELSE 0 END) AS n_denied,
  ROUND(
    1.0 * SUM(CASE WHEN action_taken = 3 THEN 1 ELSE 0 END) / COUNT(*),
    3
  ) AS denial_rate
FROM hmda_clean
WHERE action_taken IN (1,2,3)
  AND state_code IS NOT NULL
GROUP BY state_code
ORDER BY denial_rate DESC;



