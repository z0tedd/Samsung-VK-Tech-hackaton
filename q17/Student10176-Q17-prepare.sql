USE data.hackaton;
CREATE TABLE lineitem_avg_qty AS
SELECT 
  partkey,
  0.2 * AVG(quantity) AS avg_q
FROM lineitem
GROUP BY partkey

CREATE TABLE part_brand23_medbox AS
SELECT * FROM part
WHERE brand = 'Brand#23' AND container = 'MED BOX'
