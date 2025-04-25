USE data.hackaton;

WITH asian_nations AS (
    SELECT n.nationkey, n.name
    FROM nation n
    JOIN region r ON n.regionkey = r.regionkey
    WHERE r.name = 'ASIA'
),
asian_suppliers AS (
    SELECT s.suppkey, s.nationkey
    FROM supplier s
    WHERE s.nationkey IN (SELECT nationkey FROM asian_nations)
),
filtered_lineitems AS (
    SELECT l.orderkey, l.suppkey, 
           SUM(l.extendedprice * (1 - l.discount)) AS revenue
    FROM lineitem l
    JOIN orders o ON l.orderkey = o.orderkey
    WHERE o.orderdate >= DATE '1994-01-01'
      AND o.orderdate < DATE '1995-01-01'
    GROUP BY l.orderkey, l.suppkey
),
filtered_orders AS (
    SELECT o.orderkey, o.custkey
    FROM orders o
    WHERE o.orderdate >= DATE '1994-01-01'
      AND o.orderdate < DATE '1995-01-01'
)
SELECT an.name,
       SUM(fl.revenue) AS revenue
FROM filtered_orders o
JOIN customer c ON o.custkey = c.custkey
JOIN filtered_lineitems fl ON o.orderkey = fl.orderkey
JOIN asian_suppliers s ON fl.suppkey = s.suppkey
JOIN asian_nations an ON s.nationkey = an.nationkey
WHERE c.nationkey = s.nationkey
GROUP BY an.name
ORDER BY revenue DESC;