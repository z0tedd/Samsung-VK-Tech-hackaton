use data.hackaton;
-- Create filtered_predcalc_q19 table with staged filtering
CREATE TABLE filtered_predcalc_q19 AS
WITH 
-- First stage: Filter parts by brand and container criteria
filtered_parts AS (
  SELECT 
    partkey,
    brand,
    size
  FROM part
  WHERE 
    (brand = 'Brand#23' AND container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND size BETWEEN 1 AND 5)
    OR (brand = 'Brand#24' AND container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND size BETWEEN 1 AND 10)
    OR (brand = 'Brand#25' AND container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND size BETWEEN 1 AND 15)
),
-- Second stage: Filter lineitems by shipping criteria
filtered_lineitems AS (
  SELECT 
    l.partkey,
    l.extendedprice,
    l.discount,
    l.quantity,
    p.brand,
    p.size
  FROM lineitem l
  JOIN filtered_parts p ON l.partkey = p.partkey
  WHERE 
    l.shipmode IN ('AIR', 'AIR REG')
    AND l.shipinstruct = 'DELIVER IN PERSON'
)

