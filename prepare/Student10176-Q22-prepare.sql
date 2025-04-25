USE data.hackaton;

CREATE TABLE optimized_customer
WITH (
    format = 'PARQUET',
    partitioning = ARRAY['cntrycode']
)
AS 
SELECT 
    *,
    substring(phone from 1 for 2) AS cntrycode
FROM data.hackaton.customer;

CREATE TABLE customers_without_orders
WITH (
    format = 'PARQUET'
)
AS 
SELECT c.custkey
FROM data.hackaton.customer c
LEFT JOIN data.hackaton.orders o ON c.custkey = o.custkey
WHERE o.custkey IS NULL;
