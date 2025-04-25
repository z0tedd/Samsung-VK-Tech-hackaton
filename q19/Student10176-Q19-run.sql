-- Final calculation with all conditions applied
SELECT 
  partkey,
  extendedprice,
  discount,
  quantity,
  brand,
  size,
  extendedprice * (1 - discount) AS calculated_revenue
FROM filtered_lineitems;
-- Query using filtered_predcalc_q19 to get same results as original
SELECT SUM(calculated_revenue) AS revenue
FROM filtered_predcalc_q19
WHERE 
  (
    (brand = 'Brand#23' AND size BETWEEN 1 AND 5 AND quantity BETWEEN 5 AND 15)
    OR
    (brand = 'Brand#24' AND size BETWEEN 1 AND 10 AND quantity BETWEEN 15 AND 25)
    OR
    (brand = 'Brand#25' AND size BETWEEN 1 AND 15 AND quantity BETWEEN 25 AND 35)
  );
