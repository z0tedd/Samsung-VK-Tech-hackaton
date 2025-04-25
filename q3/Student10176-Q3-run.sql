-- Query to get the same data as the original script using the new table
SELECT 
    orderkey,
    revenue,
    orderdate,
    shippriority
FROM filtered_predcalc_q3
ORDER BY 
    revenue DESC,
    orderdate
LIMIT 200;
