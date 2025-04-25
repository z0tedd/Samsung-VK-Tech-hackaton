USE data.hackaton;
-- Step 1: Create a temporary table for filtered orders
create schema data.tempor;
CREATE TABLE data.tempor.filtered_orders AS
SELECT *
from orders
WHERE orderdate >= DATE '1993-10-01'
  AND orderdate < DATE '1993-10-01' + INTERVAL '3' MONTH;
-- 2. Сначала создадим таблицу с отфильтрованными данными
CREATE TABLE data.tempor.filtered_lineitems_by_flag_and_shipdate AS
SELECT 
    orderkey,
    extendedprice,
    discount
FROM lineitem
WHERE returnflag = 'R' and shipdate >= DATE '1993-10-01'
  AND shipdate < DATE '1993-10-01' + INTERVAL '3' MONTH;

CREATE TABLE data.tempor.aggregated_lineitems AS
SELECT orderkey,
       SUM(extendedprice * (1 - discount)) AS total_revenue
FROM data.tempor.filtered_lineitems_by_flag_and_shipdate
GROUP BY orderkey;


