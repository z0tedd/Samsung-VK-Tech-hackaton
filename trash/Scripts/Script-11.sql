-- https://ui.dgkmbsfx.data.bizmrg.com/ui/query.html?20250419_130640_00439_bdrja
USE data.hackaton;
WITH filtered_lineitem AS (
  SELECT 
    orderkey,
    suppkey,
    shipdate,
    extendedprice,
    discount
  FROM lineitem
  WHERE 
    shipdate >= DATE '1995-01-01'
    AND shipdate <  DATE '1997-01-01'   -- half‑open for better pruning
)
SELECT
  s_n.name       AS supp_nation,
  c_n.name       AS cust_nation,
  year(l.shipdate) AS l_year,
  SUM(l.extendedprice * (1 - l.discount)) AS revenue
FROM filtered_lineitem l
  JOIN supplier     s  ON l.suppkey = s.suppkey
  JOIN nation       s_n ON s.nationkey = s_n.nationkey
                          AND s_n.name IN ('FRANCE','GERMANY')
  JOIN orders       o  ON l.orderkey = o.orderkey
  JOIN customer     c  ON o.custkey = c.custkey
  JOIN nation       c_n ON c.nationkey = c_n.nationkey
                          AND c_n.name IN ('FRANCE','GERMANY')
WHERE 
  s_n.name <> c_n.name   -- only cross‑nation shipm ents
GROUP BY
  s_n.name,
  c_n.name,
  year(l.shipdate)
ORDER BY
  s_n.name,
  c_n.name,
  year(l.shipdate);
