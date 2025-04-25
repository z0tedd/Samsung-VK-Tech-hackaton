
-- Шаг 1: Создаем партиционированные таблицы (если их нет)
CREATE TABLE IF NOT EXISTS partsupp_partitioned (
    partkey BIGINT,
    suppkey BIGINT,
    availqty INTEGER,
    supplycost DOUBLE,
    comment VARCHAR
) WITH (
    format = 'PARQUET',
    partitioning = ARRAY['suppkey']
);

INSERT INTO partsupp_partitioned 
SELECT * FROM tpch.sf10.partsupp;

CREATE TABLE IF NOT EXISTS supplier_partitioned (
    suppkey BIGINT,
    name VARCHAR,
    address VARCHAR,
    nationkey BIGINT,
    phone VARCHAR,
    acctbal DOUBLE,
    comment VARCHAR
) WITH (
    format = 'PARQUET',
    partitioning = ARRAY['nationkey']
);

INSERT INTO supplier_partitioned 
SELECT * FROM tpch.sf10.supplier;

-- Шаг 2: Выполняем оптимизированный запрос
WITH total_germany AS (
    SELECT 
        SUM(ps.supplycost * ps.availqty) AS total 
    FROM 
        partsupp_partitioned ps
        JOIN supplier_partitioned s ON ps.suppkey = s.suppkey
    WHERE 
        s.nationkey = (SELECT nationkey FROM nation WHERE name = 'GERMANY')
)
SELECT /*+ BROADCAST(n) */
    ps.partkey, 
    SUM(ps.supplycost * ps.availqty) AS value 
FROM 
    partsupp_partitioned ps
    JOIN supplier_partitioned s ON ps.suppkey = s.suppkey
    JOIN nation n ON s.nationkey = n.nationkey
WHERE 
    n.name = 'GERMANY' 
GROUP BY 
    ps.partkey 
HAVING 
    SUM(ps.supplycost * ps.availqty) > (SELECT total * 0.0000003 FROM total_germany)
ORDER BY 
    value DESC;
