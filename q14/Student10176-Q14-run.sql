SELECT 
  100.00 * SUM(CASE WHEN p.type LIKE 'PROMO%' THEN l.extendedprice * (1 - l.discount) ELSE 0 END) / 
  SUM(l.extendedprice * (1 - l.discount)) AS promo_revenue
FROM lineitem_sept_1995 l
JOIN part p ON l.partkey = p.partkey;