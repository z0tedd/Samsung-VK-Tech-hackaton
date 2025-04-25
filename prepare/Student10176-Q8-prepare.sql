use data.hackaton;
-- First, create the filtered_predcalc table
CREATE TABLE filtered_predcalc AS
WITH 
-- Stage 1: Filter European region (smallest dimension first)
europe AS (
    SELECT regionkey 
    FROM region 
    WHERE name = 'EUROPE'
),
-- Stage 2: Get European nations
europe_nations AS (
    SELECT nationkey
    FROM nation
    WHERE regionkey IN (SELECT regionkey FROM europe)
),
-- Stage 3: Filter European customers
europe_customers AS (
    SELECT custkey
    FROM customer
    WHERE nationkey IN (SELECT nationkey FROM europe_nations)
),
-- Stage 4: Filter economy parts (highly selective)
economy_parts AS (
    SELECT partkey
    FROM part
    WHERE type = 'ECONOMY ANODIZED STEEL'
),
-- Stage 5: Filter orders by date range and European customers
filtered_orders AS (
    SELECT 
        o.orderkey,
        year(o.orderdate) AS o_year
    FROM orders o
    WHERE o.orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
    AND o.custkey IN (SELECT custkey FROM europe_customers)
),
-- Stage 6: Join with lineitems and apply part filter
filtered_lineitems AS (
    SELECT
        fo.o_year,
        l.extendedprice * (1 - l.discount) AS volume,
        s.nationkey AS supplier_nationkey
    FROM filtered_orders fo
    JOIN lineitem l ON fo.orderkey = l.orderkey
    JOIN economy_parts ep ON l.partkey = ep.partkey
    JOIN supplier s ON l.suppkey = s.suppkey
)
-- Populate the filtered_predcalc table
SELECT
    fl.o_year,
    fl.volume,
    n.name AS nation
FROM filtered_lineitems fl
JOIN nation n ON fl.supplier_nationkey = n.nationkey;
