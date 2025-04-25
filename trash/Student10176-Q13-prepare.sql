WITH customer_order_counts AS (
    SELECT 
        c.custkey,
        COUNT(o.orderkey) AS c_count
    FROM 
        customer c
    LEFT OUTER JOIN 
        orders_optimized_q13 o ON c.custkey = o.custkey AND o.comment_filtered = true
    GROUP BY 
        c.custkey
)
SELECT 
    c_count,
    COUNT(*) AS custdist
FROM 
    customer_order_counts
GROUP BY 
    c_count
ORDER BY 
    custdist DESC,
    c_count DESC;

SELECT 
    order_count AS c_count,
    COUNT(*) AS custdist
FROM 
    customer_order_summary
GROUP BY 
    order_count
ORDER BY 
    custdist DESC,
    order_count DESC;