USE tpch.sf10;
SELECT 
    n.name,
    SUM(l.extendedprice * (1 - l.discount)) AS revenue
FROM 
    region r
JOIN 
    nation n ON r.regionkey = n.regionkey
JOIN 
    supplier s ON s.nationkey = n.nationkey
JOIN 
    lineitem l ON l.suppkey = s.suppkey
JOIN 
    orders o ON l.orderkey = o.orderkey
JOIN 
    customer c ON o.custkey = c.custkey AND c.nationkey = s.nationkey
WHERE 
    r.name = 'ASIA'
    AND o.orderdate >= DATE '1994-01-01'
    AND o.orderdate < DATE '1995-01-01'
GROUP BY 
    n.name
ORDER BY 
    revenue DESC;