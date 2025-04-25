-- 1) Pre‐filter orders to 1994 only
USE data.hackaton;
-- Trino dialect: optimized revenue per Asian nation for Q5-like workload
WITH
  -- 1) Filter orders to the target date range up front
  filtered_orders AS (
    SELECT
      o.orderkey,
      o.custkey
    FROM orders o
    WHERE o.orderdate >= DATE '1994-01-01'
      AND o.orderdate < date_add('year', 1, DATE '1994-01-01')
  ),
  -- 2) Pre‑filter nations in the ASIA region
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
  -- join only the in‑range lineitems
  JOIN lineitem l
    ON l.orderkey = fo.orderkey
  -- bring in supplier, then immediately filter by nation
  JOIN supplier s
    ON l.suppkey = s.suppkey
  JOIN asia_nations an
    ON s.nationkey = an.nationkey
  -- ensure customer lives in the same nation
  JOIN customer c
    ON fo.custkey = c.custkey
   AND c.nationkey = an.nationkey
GROUP BY
  an.nation
ORDER BY
  revenue DESC;