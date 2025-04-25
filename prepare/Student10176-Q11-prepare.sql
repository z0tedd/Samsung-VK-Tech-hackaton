USE data.hackaton;
CREATE TABLE data.hackaton.optimized_partsupp
WITH (
    format = 'PARQUET',
    partitioning = ARRAY['nationkey']
)
AS 
SELECT 
    ps.partkey, 
    ps.suppkey, 
    ps.availqty, 
    ps.supplycost,
    s.nationkey
FROM data.hackaton.partsupp ps
JOIN data.hackaton.supplier s ON ps.suppkey = s.suppkey;
