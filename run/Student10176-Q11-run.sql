WITH germany_nation AS (
    SELECT nationkey 
    FROM data.hackaton.nation 
    WHERE name = 'GERMANY'
),
total_germany AS (
    SELECT 
        SUM(ps.supplycost * ps.availqty) * 0.0000003 AS threshold
    FROM data.hackaton.optimized_partsupp ps
    WHERE ps.nationkey = (SELECT nationkey FROM germany_nation)
)
SELECT 
    ps.partkey, 
    SUM(ps.supplycost * ps.availqty) AS value 
FROM data.hackaton.optimized_partsupp ps
WHERE ps.nationkey = (SELECT nationkey FROM germany_nation)
GROUP BY ps.partkey
HAVING SUM(ps.supplycost * ps.availqty) > (SELECT threshold FROM total_germany)
ORDER BY value DESC;
