-- 6.20
USE data.hackaton;
WITH
  filtered_orders AS (
    SELECT
      o.orderkey,
      o.custkey
    FROM orders o
    WHERE o.orderdate >= DATE '1994-01-01'
      AND o.orderdate < date_add('year', 1, DATE '1994-01-01')
  ),
  asia_nations AS (
    SELECT
      n.nationkey,
      n.name       AS nation
    FROM nation n
    JOIN region r
      ON n.regionkey = r.regionkey
    WHERE r.name = 'ASIA'
  )
SELECT
  an.nation,
  sum(l.extendedprice * (1 - l.discount)) AS revenue
FROM filtered_orders fo
  JOIN lineitem l
    ON l.orderkey = fo.orderkey
  JOIN supplier s
    ON l.suppkey = s.suppkey
  JOIN asia_nations an
    ON s.nationkey = an.nationkey
  JOIN customer c
    ON fo.custkey = c.custkey
   AND c.nationkey = an.nationkey
GROUP BY
  an.nation
ORDER BY
  revenue DESC;
