use data.hackaton;
-- Create the filtered table using staged CTEs
CREATE TABLE temp.filtered_lineitem_q6 AS
WITH 
-- First stage: filter by shipdate range
shipdate_filtered AS (
    SELECT extendedprice,discount,quantity
    FROM lineitem
    WHERE shipdate >= DATE '1996-01-01'
    AND shipdate < DATE '1996-01-01' + INTERVAL '1' YEAR
),
-- Second stage: apply discount range filter
discount_filtered AS (
    SELECT extendedprice,discount,quantity
    FROM shipdate_filtered
    WHERE discount BETWEEN 0.04 AND 0.06  -- 0.05 - 0.01 to 0.05 + 0.01
),
-- Third stage: apply quantity filter
quantity_filtered AS (
    SELECT extendedprice,discount,quantity
    FROM discount_filtered
    WHERE quantity < 25
)
-- Final select with all columns
SELECT 
    extendedprice,discount,quantity
FROM quantity_filtered;
