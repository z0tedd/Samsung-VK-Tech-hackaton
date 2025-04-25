-- 6.20
WITH
  asia_nations AS (
    SELECT n.nationkey, n.name AS nation
    FROM nation n
    JOIN region r ON n.regionkey = r.regionkey
    WHERE r.name = 'ASIA'
  ),
  filtered_orders AS (
    SELECT o.orderkey, o.custkey
    FROM orders o
    WHERE o.orderdate BETWEEN DATE '1994-01-01' AND DATE '1994-12-31'
  ),
  asia_customers AS (
    SELECT c.custkey
    FROM customer c
    WHERE c.nationkey IN (SELECT nationkey FROM asia_nations)
  )
SELECT
  an.nation,
  SUM(l.extendedprice * (1 - l.discount)) AS revenue
FROM filtered_orders fo
JOIN asia_customers ac ON fo.custkey = ac.custkey
JOIN lineitem_1994_receipt l ON l.orderkey = fo.orderkey
JOIN supplier s ON l.suppkey = s.suppkey
JOIN asia_nations an ON s.nationkey = an.nationkey
GROUP BY an.nation
ORDER BY revenue DESC;
