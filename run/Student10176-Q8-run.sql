-- Then run the analysis query on the created table
SELECT
    o_year,
    sum(CASE WHEN nation = 'GERMANY' THEN volume ELSE 0 END) / sum(volume) AS mkt_share
FROM filtered_predcalc
GROUP BY o_year
ORDER BY o_year;
