use data.hakaton;

create table data.temp.filtered_data
with(
format = 'PARQUET'
)
AS 
  SELECT 
    returnflag,
    linestatus,
    quantity,
    extendedprice,
    discount,
    tax
  FROM lineitem
  WHERE shipdate <= DATE '1997-12-01' and extendedprice  > 0 and discount > 0 and quantity >0
