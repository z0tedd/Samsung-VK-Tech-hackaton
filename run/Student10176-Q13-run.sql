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