
-- sql/05_denial_rate_overall.sql

/*
Purpose:
Compute the national mortgage denial rate using application-weighted counts.

Definition:
- Denial rate = (Number of denied applications) / (Number of applications with a credit decision)

Methodology:
- Uses HMDA action_taken codes to define credit decisions:
    * 1 = Approved
    * 2 = Approved but not accepted
    * 3 = Denied
- Excludes withdrawn, incomplete, and purchased loans (action_taken 4–6)
- Each application contributes equally to the national rate (application-weighted)

Rationale:
Using action_taken IN (1,2,3) ensures consistency between national and state-level
denial rate calculations and avoids bias introduced by unweighted state averages.
*/


SELECT
  COUNT(*) AS total_decisions,
  SUM(CASE WHEN action_taken = 3 THEN 1 ELSE 0 END) AS denied_decisions,
  ROUND(
    1.0 * SUM(CASE WHEN action_taken = 3 THEN 1 ELSE 0 END) / COUNT(*),
    3
  ) AS denial_rate
FROM hmda_clean
WHERE action_taken IN (1,2,3);

----- verification--------
SELECT
  action_taken,
  COUNT(*) AS n
FROM hmda_clean
GROUP BY action_taken
ORDER BY action_taken;


SELECT is_decision, COUNT(*) AS n
FROM hmda_clean
GROUP BY is_decision
ORDER BY is_decision;
-----------------------------