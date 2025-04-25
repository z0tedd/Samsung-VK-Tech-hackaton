USE data.hackaton;
WITH filtered_region AS (
    SELECT 
        regionkey
    FROM 
        region
    WHERE 
        name = 'ASIA'
),
filtered_orders AS (
    SELECT 
        orderkey, custkey
    FROM 
        orders
    WHERE 
        orderdate >= DATE '1994-01-01'
        AND orderdate < DATE '1994-01-01' + INTERVAL '1' YEAR
),
filtered_nations AS (
    SELECT 
        n.nationkey, n.name
    FROM 
        nation n
    JOIN 
        filtered_region r ON n.regionkey = r.regionkey
),
filtered_suppliers AS (
    SELECT 
        s.suppkey, s.nationkey
    FROM 
        supplier s
    JOIN 
        filtered_nations n ON s.nationkey = n.nationkey
),
filtered_lineitems AS (
    SELECT 
        l.orderkey, l.extendedprice, l.discount, l.suppkey
    FROM 
        lineitem l
    JOIN 
        filtered_suppliers s ON l.suppkey = s.suppkey
)
SELECT 
    fn.name,
    SUM(fl.extendedprice * (1 - fl.discount)) AS revenue
FROM 
    filtered_lineitems fl
JOIN 
    filtered_orders fo ON fl.orderkey = fo.orderkey
JOIN 
    customer c ON fo.custkey = c.custkey
JOIN 
    filtered_suppliers fs ON fl.suppkey = fs.suppkey
JOIN 
    filtered_nations fn ON fs.nationkey = fn.nationkey
GROUP BY 
    fn.name
ORDER BY 
    revenue DESC;