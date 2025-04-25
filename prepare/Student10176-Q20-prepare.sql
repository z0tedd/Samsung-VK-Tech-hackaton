USE data.hackaton;
-- Create initial table
CREATE TABLE IF NOT EXISTS filtered_predcalc_q20 (
    partkey bigint,
    suppkey bigint,
    availqty integer,
    threshold double,
    meets_threshold boolean
);

-- Process in explicit batches (adjust ranges as needed)
-- Batch 1: First million
INSERT INTO filtered_predcalc_q20
WITH batch_lineitems AS (
    SELECT 
        partkey,
        suppkey,
        0.5 * SUM(quantity) AS batch_threshold
    FROM (
        SELECT 
            partkey,
            suppkey,
            quantity
        FROM lineitem
        WHERE shipdate >= DATE '1994-01-01'
          AND shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
        ORDER BY partkey, suppkey
        OFFSET 0 ROWS FETCH NEXT 1000000 ROWS ONLY
    ) t
    GROUP BY partkey, suppkey
),
forest_parts AS (
    SELECT partkey FROM part WHERE name LIKE 'forest%'
)
SELECT 
    ps.partkey,
    ps.suppkey,
    ps.availqty,
    COALESCE(bl.batch_threshold, 0) AS threshold,
    (ps.availqty > COALESCE(bl.batch_threshold, 0)) AS meets_threshold
FROM partsupp ps
JOIN forest_parts fp ON ps.partkey = fp.partkey
LEFT JOIN batch_lineitems bl ON ps.partkey = bl.partkey AND ps.suppkey = bl.suppkey
WHERE bl.partkey IS NOT NULL;

-- Batch 2: Next million
INSERT INTO filtered_predcalc_q20
WITH batch_lineitems AS (
    SELECT 
        partkey,
        suppkey,
        0.5 * SUM(quantity) AS batch_threshold
    FROM (
        SELECT 
            partkey,
            suppkey,
            quantity
        FROM lineitem
        WHERE shipdate >= DATE '1994-01-01'
          AND shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
        ORDER BY partkey, suppkey
        OFFSET 2000000 ROWS FETCH NEXT 1000000 ROWS ONLY
    )
    GROUP BY partkey, suppkey
),
forest_parts AS (
    SELECT partkey FROM part WHERE name LIKE 'forest%'
)
SELECT 
    ps.partkey,
    ps.suppkey,
    ps.availqty,
    COALESCE(bl.batch_threshold, 0) AS threshold,
    (ps.availqty > COALESCE(bl.batch_threshold, 0)) AS meets_threshold
FROM partsupp ps
JOIN forest_parts fp ON ps.partkey = fp.partkey
LEFT JOIN batch_lineitems bl ON ps.partkey = bl.partkey AND ps.suppkey = bl.suppkey
WHERE bl.partkey IS NOT NULL;

INSERT INTO filtered_predcalc_q20
WITH batch_lineitems AS (
    SELECT 
        partkey,
        suppkey,
        0.5 * SUM(quantity) AS batch_threshold
    FROM (
        SELECT 
            partkey,
            suppkey,
            quantity
        FROM lineitem
        WHERE shipdate >= DATE '1994-01-01'
          AND shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
        ORDER BY partkey, suppkey
        OFFSET 3000000 ROWS FETCH NEXT 1000000 ROWS ONLY
    ) t
    GROUP BY partkey, suppkey
),
forest_parts AS (
    SELECT partkey FROM part WHERE name LIKE 'forest%'
)
SELECT 
    ps.partkey,
    ps.suppkey,
    ps.availqty,
    COALESCE(bl.batch_threshold, 0) AS threshold,
    (ps.availqty > COALESCE(bl.batch_threshold, 0)) AS meets_threshold
FROM partsupp ps
JOIN forest_parts fp ON ps.partkey = fp.partkey
LEFT JOIN batch_lineitems bl ON ps.partkey = bl.partkey AND ps.suppkey = bl.suppkey
WHERE bl.partkey IS NOT NULL;
-- Continue with additional batches as needed...
-- OFFSET 2000000 ROWS FETCH NEXT 1000000 ROWS ONLY
-- OFFSET 3000000 ROWS FETCH NEXT 1000000 ROWS ONLY
-- etc.


INSERT INTO filtered_predcalc_q20
WITH batch_lineitems AS (
    SELECT 
        partkey,
        suppkey,
        0.5 * SUM(quantity) AS batch_threshold
    FROM (
        SELECT 
            partkey,
            suppkey,
            quantity
        FROM lineitem
        WHERE shipdate >= DATE '1994-01-01'
          AND shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
        ORDER BY partkey, suppkey
        OFFSET 4000000 ROWS FETCH NEXT 1000000 ROWS ONLY
    ) t
    GROUP BY partkey, suppkey
),
forest_parts AS (
    SELECT partkey FROM part WHERE name LIKE 'forest%'
)
SELECT 
    ps.partkey,
    ps.suppkey,
    ps.availqty,
    COALESCE(bl.batch_threshold, 0) AS threshold,
    (ps.availqty > COALESCE(bl.batch_threshold, 0)) AS meets_threshold
FROM partsupp ps
JOIN forest_parts fp ON ps.partkey = fp.partkey
LEFT JOIN batch_lineitems bl ON ps.partkey = bl.partkey AND ps.suppkey = bl.suppkey
WHERE bl.partkey IS NOT NULL;
INSERT INTO filtered_predcalc_q20
WITH batch_lineitems AS (
    SELECT 
        partkey,
        suppkey,
        0.5 * SUM(quantity) AS batch_threshold
    FROM (
        SELECT 
            partkey,
            suppkey,
            quantity
        FROM lineitem
        WHERE shipdate >= DATE '1994-01-01'
          AND shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
        ORDER BY partkey, suppkey
        OFFSET 5000000 ROWS FETCH NEXT 1000000 ROWS ONLY
    ) t
    GROUP BY partkey, suppkey
),
forest_parts AS (
    SELECT partkey FROM part WHERE name LIKE 'forest%'
)
SELECT 
    ps.partkey,
    ps.suppkey,
    ps.availqty,
    COALESCE(bl.batch_threshold, 0) AS threshold,
    (ps.availqty > COALESCE(bl.batch_threshold, 0)) AS meets_threshold
FROM partsupp ps
JOIN forest_parts fp ON ps.partkey = fp.partkey
LEFT JOIN batch_lineitems bl ON ps.partkey = bl.partkey AND ps.suppkey = bl.suppkey
WHERE bl.partkey IS NOT NULL;
INSERT INTO filtered_predcalc_q20
WITH batch_lineitems AS (
    SELECT 
        partkey,
        suppkey,
        0.5 * SUM(quantity) AS batch_threshold
    FROM (
        SELECT 
            partkey,
            suppkey,
            quantity
        FROM lineitem
        WHERE shipdate >= DATE '1994-01-01'
          AND shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
        ORDER BY partkey, suppkey
        OFFSET 6000000 ROWS FETCH NEXT 1000000 ROWS ONLY
    ) t
    GROUP BY partkey, suppkey
),
forest_parts AS (
    SELECT partkey FROM part WHERE name LIKE 'forest%'
)
SELECT 
    ps.partkey,
    ps.suppkey,
    ps.availqty,
    COALESCE(bl.batch_threshold, 0) AS threshold,
    (ps.availqty > COALESCE(bl.batch_threshold, 0)) AS meets_threshold
FROM partsupp ps
JOIN forest_parts fp ON ps.partkey = fp.partkey
LEFT JOIN batch_lineitems bl ON ps.partkey = bl.partkey AND ps.suppkey = bl.suppkey
WHERE bl.partkey IS NOT NULL;

-- Merge duplicates and create final table
CREATE TABLE filtered_predcalc_q20_final AS
SELECT 
    partkey,
    suppkey,
    arbitrary(availqty) AS availqty,
    sum(threshold) AS threshold,
    (arbitrary(availqty) > sum(threshold)) AS meets_threshold
FROM filtered_predcalc_q20
GROUP BY partkey, suppkey


