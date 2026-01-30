DROP TABLE IF EXISTS state_generation_income;

CREATE TABLE state_generation_income AS
SELECT
    state_code,
    generation,
    income_bin,
    COUNT(*) AS total_apps,
    SUM(CASE WHEN action_taken = '3' THEN 1 ELSE 0 END) AS denied_apps,
    ROUND(
        1.0 * SUM(CASE WHEN action_taken = '3' THEN 1 ELSE 0 END) / COUNT(*),
        3
    ) AS denial_rate
FROM hmda_p3
WHERE
    action_taken IN ('1','2','3')
    AND state_code IS NOT NULL
    AND generation IS NOT NULL
    AND income_bin IS NOT NULL
GROUP BY
    state_code, generation, income_bin
HAVING
    COUNT(*) >= 100;



-----------------------------

SELECT
    action_taken,
    COUNT(*) AS n,
    SUM(is_decision) AS decision_flag_sum
FROM hmda_p3
GROUP BY action_taken
ORDER BY action_taken;

---------------------------



SELECT COUNT(*) FROM state_generation_income;


--Check distribution by generation
SELECT generation, COUNT(*) AS n
FROM state_generation_income
GROUP BY generation;


--Check distribution by income bin
SELECT income_bin, COUNT(*) AS n
FROM state_generation_income
GROUP BY income_bin
ORDER BY income_bin;

--Quick eyeball on denial rates
SELECT
    generation,
    income_bin,
    ROUND(AVG(denial_rate), 3) AS avg_rate
FROM state_generation_income
GROUP BY generation, income_bin
ORDER BY generation, income_bin;



---------
--create new table as .csv

--sqlite3 data/raw/mortgage_risk.db \
--  -header -csv \
--  "SELECT * FROM state_generation_income;" \
--  > data/derived/project3_age_income/state_generation_income.csv
------------


