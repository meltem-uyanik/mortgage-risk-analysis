

PRAGMA table_info(hmda_clean);


DROP TABLE IF EXISTS hmda_p3;

CREATE TABLE hmda_p3 AS
SELECT
    *,
    -- Generation from HMDA age bins
    CASE
        WHEN applicant_age = '<25' THEN 'Gen Z'
        WHEN applicant_age IN ('25-34', '35-44') THEN 'Millennial'
        WHEN applicant_age IN ('45-54', '55-64') THEN 'Gen X'
        WHEN applicant_age IN ('65-74', '>74') THEN 'Baby Boomer'
        ELSE NULL
    END AS generation,

    -- Income bins (HMDA income is in thousands of dollars)
    CASE
        WHEN income IS NULL THEN NULL
        WHEN income < 50 THEN '<50k'
        WHEN income >= 50 AND income < 75 THEN '50–75k'
        WHEN income >= 75 AND income < 100 THEN '75–100k'
        WHEN income >= 100 AND income < 150 THEN '100–150k'
        ELSE '>150k'
    END AS income_bin
FROM hmda_clean;




SELECT COUNT(*) FROM hmda_p3;


PRAGMA table_info(hmda_p3);
