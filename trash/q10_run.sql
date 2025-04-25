USE data.hackaton;
-- Step 1: Create a temporary table for filtered orders
CREATE TEMP TABLE temp_filtered_orders AS
SELECT *
FROM orders
WHERE orderdate >= DATE '1993-10-01'
  AND orderdate < DATE '1993-10-01' + INTERVAL '3' MONTH;
-- 1. Сначала создадим таблицу с отфильтрованными данными
CREATE TABLE temp.filtered_lineitems_by_flag_and_shipdate AS
SELECT 
    orderkey,
    extendedprice,
    discount
FROM lineitem
WHERE returnflag = 'R' and shipdate >= DATE '1993-10-01'
  AND shipdate < DATE '1993-10-01' + INTERVAL '3' MONTH;

CREATE TABLE temp_aggregated_lineitems AS
SELECT orderkey,
       SUM(extendedprice * (1 - discount)) AS total_revenue
FROM temp.filtered_lineitems_by_flag_and_shipdate
GROUP BY orderkey;

SELECT c.custkey,
       c.name,
       SUM(al.total_revenue) AS revenue,
       c.acctbal,
       n.name AS nation_name,
       c.address,
       c.phone,
       c.comment
FROM customer c
JOIN temp.filtered_orders o ON c.custkey = o.custkey
JOIN temp_aggregated_lineitems al ON al.orderkey = o.orderkey
JOIN nation n ON c.nationkey = n.nationkey
GROUP BY c.custkey, c.name, c.acctbal, c.phone, n.name, c.address, c.comment
ORDER BY revenue DESC;
