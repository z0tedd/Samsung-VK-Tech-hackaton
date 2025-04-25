WITH avg_balance AS (
    SELECT AVG(c.acctbal) AS avg_bal
    FROM optimized_customer c
    WHERE 
        c.acctbal > 0.00
        AND c.cntrycode IN ('13','31','23','29','30','18','17')
)
SELECT 
    c.cntrycode,
    COUNT(*) AS numcust,
    SUM(c.acctbal) AS totacctbal
FROM optimized_customer c
JOIN customers_without_orders cwo 
    ON c.custkey = cwo.custkey
WHERE 
    c.cntrycode IN ('13','31','23','29','30','18','17')
    AND c.acctbal > (SELECT avg_bal FROM avg_balance)
GROUP BY c.cntrycode
ORDER BY c.cntrycode;
