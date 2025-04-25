use data.hackaton;
-- Create the filtered_predcalc_q7 table using CTEs for staged filtering
CREATE TABLE filtered_predcalc_q7 AS
WITH filtered_lineitem AS (
  SELECT 
    orderkey,
    suppkey,
    shipdate,
    extendedprice,
    discount
  FROM lineitem
  WHERE 
    shipdate >= DATE '1995-01-01'
    AND shipdate < DATE '1997-01-01'   -- half-open for better pruning
),
filtered_supplier AS (
  SELECT 
    s.suppkey,
    s_n.name AS supp_nation
  FROM supplier s
  JOIN nation s_n ON s.nationkey = s_n.nationkey
  WHERE s_n.name IN ('FRANCE', 'GERMANY')
),
filtered_customer AS (
  SELECT 
    c.custkey,
    c_n.name AS cust_nation
  FROM customer c
  JOIN nation c_n ON c.nationkey = c_n.nationkey
  WHERE c_n.name IN ('FRANCE', 'GERMANY')
),
joined_data AS (
  SELECT
    fs.supp_nation,
    fc.cust_nation,
    year(fl.shipdate) AS l_year,
    fl.extendedprice * (1 - fl.discount) AS revenue_item
  FROM filtered_lineitem fl
  JOIN filtered_supplier fs ON fl.suppkey = fs.suppkey
  JOIN orders o ON fl.orderkey = o.orderkey
  JOIN filtered_customer fc ON o.custkey = fc.custkey
  WHERE fs.supp_nation <> fc.cust_nation  -- only cross-nation shipments
)
SELECT
  supp_nation,
  cust_nation,
  l_year,
  SUM(revenue_item) AS revenue
FROM joined_data
GROUP BY
  supp_nation,
  cust_nation,
  l_year
ORDER BY
  supp_nation,
  cust_nation,
  l_year
LIMIT 200;


