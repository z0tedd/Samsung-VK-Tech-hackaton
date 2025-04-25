SELECT c.custkey,
       c.name,
       SUM(al.total_revenue) AS revenue,
       c.acctbal,
       n.name AS nation_name,
       c.address,
       c.phone,
       c.comment
FROM customer c
JOIN data.tempor.filtered_orders o ON c.custkey = o.custkey
JOIN data.tempor.aggregated_lineitems al ON al.orderkey = o.orderkey
JOIN nation n ON c.nationkey = n.nationkey
GROUP BY c.custkey, c.name, c.acctbal, c.phone, n.name, c.address, c.comment
ORDER BY revenue DESC;


