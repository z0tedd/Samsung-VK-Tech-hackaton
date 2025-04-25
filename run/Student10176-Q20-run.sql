WITH qualified_suppliers AS (
    SELECT DISTINCT suppkey
    FROM filtered_predcalc_q20
    WHERE meets_threshold = true
)
SELECT 
    s.name,
    s.address
FROM supplier s
JOIN nation n ON s.nationkey = n.nationkey
JOIN qualified_suppliers qs ON s.suppkey = qs.suppkey
WHERE n.name = 'CANADA'
ORDER BY s.name
LIMIT 20;
