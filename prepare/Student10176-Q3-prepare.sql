use data.hackaton;
-- Create the filtered_predcalc_q3 table using CTEs for staged filtering
CREATE TABLE filtered_predcalc_q3 AS
WITH 
-- First filter: customers in BUILDING segment
filtered_customers AS (
    SELECT custkey
    FROM data.hackaton.customer
    WHERE mktsegment = 'BUILDING'
),
-- Second filter: orders before 1995-03-11 from filtered customers
filtered_orders AS (
    SELECT 
        o.orderkey,
        o.custkey,
        o.orderdate,
        o.shippriority
    FROM data.hackaton.orders o
    JOIN filtered_customers c ON o.custkey = c.custkey
    WHERE o.orderdate < DATE '1995-03-11'
),
-- Third filter: lineitems with shipdate after 1995-03-11 from filtered orders
filtered_lineitems AS (
    SELECT 
        l.orderkey,
        l.extendedprice,
        l.discount
    FROM data.hackaton.lineitem l
    JOIN filtered_orders o ON l.orderkey = o.orderkey
    WHERE l.shipdate > DATE '1995-03-11'
)
-- Final join of all filtered data
SELECT 
    fo.orderkey,
    SUM(fl.extendedprice * (1 - fl.discount)) AS revenue,
    fo.orderdate,
    fo.shippriority
FROM filtered_orders fo
JOIN filtered_lineitems fl ON fo.orderkey = fl.orderkey
GROUP BY 
    fo.orderkey,
    fo.orderdate,
    fo.shippriority;

