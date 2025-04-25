CREATE TABLE data.hackaton.supplier_partitioned (
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

INSERT INTO data.hackaton.supplier_partitioned 
SELECT * FROM data.hackaton.supplier;


