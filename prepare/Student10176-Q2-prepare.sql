use data.hackaton;
-- 1. Создание отфильтрованной таблицы PART
CREATE TABLE filtered_parts_q2
WITH (
    format = 'PARQUET',
    partitioning = ARRAY['size']
) AS
SELECT partkey, mfgr,size
FROM part
WHERE part.size = 16
  AND part.type LIKE '%ANODIZED TIN';

-- 2. Создание таблицы минимальных затрат (min_supplycost)
CREATE TABLE min_supplycost_q2
WITH (
    format = 'PARQUET'
) AS
SELECT ps.partkey, MIN(ps.supplycost) AS min_cost
FROM partsupp ps
JOIN supplier s ON s.suppkey = ps.suppkey
JOIN nation n ON s.nationkey = n.nationkey
JOIN region r ON n.regionkey = r.regionkey
WHERE r.name = 'EUROPE'
GROUP BY ps.partkey;

-- 3. Создание отфильтрованной таблицы SUPPLIER
CREATE TABLE filtered_supplier_q2
WITH (
    format = 'PARQUET',
    partitioning = ARRAY['region_name']
) AS
SELECT 
    s.suppkey, 
    s.acctbal, 
    s.name, 
    s.address, 
    s.phone, 
    s.comment, 
    n.name AS nation_name,
    r.name AS region_name
FROM supplier s
JOIN nation n ON s.nationkey = n.nationkey
JOIN region r ON n.regionkey = r.regionkey
WHERE r.name = 'EUROPE';
