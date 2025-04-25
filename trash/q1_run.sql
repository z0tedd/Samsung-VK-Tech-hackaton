--2.40-> 1.48
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
  
 select returnflag,
linestatus,
sum(quantity) as sum_qty,
sum(extendedprice) as sum_base_price,
sum(extendedprice*(1-discount)) as sum_disc_price,
sum(extendedprice*(1-discount)*(1+tax)) as sum_charge,
avg(quantity) as avg_qty,
avg(extendedprice) as avg_price,
avg(discount) as avg_disc,
count(*) as count_order
from data.temp.filtered_data
group by returnflag,
linestatus
order by returnflag,
linestatus;
