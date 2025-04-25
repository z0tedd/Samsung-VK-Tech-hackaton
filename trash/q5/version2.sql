-- 5.59
USE data.hackaton;
SELECT 
  n.name AS nation_name,
  SUM(l.extendedprice * (1 - l.discount)) AS revenue
FROM region r
JOIN nation n 
  ON r.regionkey = n.regionkey 
  AND r.name = 'ASIA'
JOIN supplier s 
  ON n.nationkey = s.nationkey
JOIN lineitem l 
  ON s.suppkey = l.suppkey
JOIN orders o 
  ON l.orderkey = o.orderkey 
  AND o.orderdate >= DATE '1994-01-01' 
  AND o.orderdate < DATE '1994-01-01' + INTERVAL '1' YEAR
JOIN customer c 
  ON o.custkey = c.custkey 
  AND c.nationkey = s.nationkey
GROUP BY n.name
ORDER BY revenue DESC;
