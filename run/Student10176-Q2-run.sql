-- 4. Финальный запрос 44c->25c
SELECT 
    fs.acctbal,
    fs.name,
    fs.nation_name,
    fp.partkey,
    fp.mfgr,
    fs.address,
    fs.phone,
    fs.comment
FROM filtered_parts_q2 fp
JOIN partsupp ps ON fp.partkey = ps.partkey
JOIN min_supplycost_q2 msc ON fp.partkey = msc.partkey AND ps.supplycost = msc.min_cost
JOIN filtered_supplier_q2 fs ON ps.suppkey = fs.suppkey
ORDER BY fs.acctbal DESC, fs.nation_name, fs.name, fp.partkey
LIMIT 200
