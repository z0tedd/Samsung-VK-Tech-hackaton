-- Calculate the revenue to 5s
SELECT SUM(extendedprice * discount) AS revenue
FROM temp.filtered_lineitem_q6;
