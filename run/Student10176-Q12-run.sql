SELECT 
  l.shipmode,
  SUM(CASE WHEN o.orderpriority IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS high_line_count,
  SUM(CASE WHEN o.orderpriority NOT IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS low_line_count
FROM orders o
JOIN lineitem_1994_receipt l ON o.orderkey = l.orderkey
GROUP BY l.shipmode
ORDER BY l.shipmode;