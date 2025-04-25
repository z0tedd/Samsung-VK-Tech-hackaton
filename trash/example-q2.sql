USE tpch.sf1;

WITH min_supplycost AS (
SELECT ps2.partkey, MIN(ps2.supplycost) AS min_cost
FROM partsupp ps2
JOIN supplier s2 ON s2.suppkey = ps2.suppkey
JOIN nation n2 ON s2.nationkey = n2.nationkey
JOIN region r2 ON n2.regionkey = r2.regionkey
WHERE r2.name = 'EUROPE'
GROUP BY ps2.partkey
)
SELECT s.acctbal,
s.name,
n.name AS nation_name,
p.partkey,
p.mfgr,
s.address,
s.phone,
s.comment
FROM part p
JOIN partsupp ps ON p.partkey = ps.partkey
JOIN supplier s ON s.suppkey = ps.suppkey
JOIN nation n ON s.nationkey = n.nationkey
JOIN region r ON n.regionkey = r.regionkey
JOIN min_supplycost msc ON p.partkey = msc.partkey AND ps.supplycost =
msc.min_cost
WHERE p.size = 16
AND p.type LIKE '%ANODIZED TIN'
AND r.name = 'EUROPE'
ORDER BY s.acctbal DESC,
n.name,
s.name,
p.partkey
limit 200;
