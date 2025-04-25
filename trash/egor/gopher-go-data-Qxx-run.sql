USE data.hackaton

WITH total_germany AS (
    SELECT 
        SUM(ps.supplycost * ps.availqty) AS total 
    FROM 
        data.hackaton.partsupp_partitioned_1 ps
    WHERE 
        ps.nationkey = (SELECT nationkey FROM nation WHERE name = 'GERMANY')
)
SELECT /*+ BROADCAST(n) */
    ps.partkey, 
    SUM(ps.supplycost * ps.availqty) AS value 
FROM 
    data.hackaton.partsupp_partitioned_1 ps
    JOIN data.hackaton.supplier_partitioned s ON ps.suppkey = s.suppkey
    JOIN nation n ON s.nationkey = n.nationkey
WHERE 
    ps.nationkey = (SELECT nationkey FROM nation WHERE name = 'GERMANY')
GROUP BY 
    ps.partkey 
HAVING 
    SUM(ps.supplycost * ps.availqty) > (SELECT total * 0.0000003 FROM total_germany)
ORDER BY 
    value DESC;
