SELECT SUM(l.extendedprice) / 7.0 AS avg_yearly
FROM lineitem l
JOIN part_brand23_medbox p ON p.partkey = l.partkey
JOIN lineitem_avg_qty la ON la.partkey = l.partkey
WHERE l.quantity < la.avg_q;