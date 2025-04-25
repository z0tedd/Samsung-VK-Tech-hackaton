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
JOIN customer c 
  ON o.custkey = c.custkey 
  AND c.nationkey = s.nationkey
GROUP BY n.name
ORDER BY revenue DESC;
