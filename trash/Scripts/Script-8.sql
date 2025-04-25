CREATE TABLE IF NOT EXISTS data.hackaton.orders_partitioned (
    orderkey BIGINT,
    custkey BIGINT,
    orderstatus VARCHAR(1),
    totalprice DOUBLE,
    orderdate DATE,
    orderpriority VARCHAR(15),
    clerk VARCHAR(15),
    shippriority INTEGER,
    comment VARCHAR(79)
)
WITH (
    format = '', -- or another format like Parquet
    partitioning = ARRAY['orderdate'] -- partition by orderdate
);

CREATE TABLE IF NOT EXISTS data.hackaton.lineitem_partitioned (
    orderkey BIGINT,
    partkey BIGINT,
    suppkey BIGINT,
    linenumber INTEGER,
    quantity DOUBLE,
    extendedprice DOUBLE,
    discount DOUBLE,
    tax DOUBLE,
    returnflag VARCHAR(1),
    linestatus VARCHAR(1),
    shipdate DATE,
    commitdate DATE,
    receiptdate DATE,
    shipinstruct VARCHAR(25),
    shipmode VARCHAR(10),
    comment VARCHAR(44)
)
WITH (
    format = 'OCR', -- or another format like Parquet
    partitioning = ARRAY['shipdate'] -- partition by shipdate
);

INSERT INTO data.hackaton.orders_partitioned
SELECT 
    orderkey,
    custkey,
    orderstatus,
    totalprice,
    orderdate,
    orderpriority,
    clerk,
    shippriority,
    comment
FROM data.hackaton.orders
where hackaton.orders.orderdate >= DATE '1994-01-01' and hackaton.orders.orderdate < DATE '1994-01-01' + INTERVAL '1' YEAR;

