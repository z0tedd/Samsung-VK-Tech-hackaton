USE data.hackaton;
select ps.partkey,
sum(ps.supplycost * ps.availqty) as value
from partsupp ps,
supplier s,
nation n
where ps.suppkey = s.suppkey
and s.nationkey = n.nationkey
and n.name = 'GERMANY'
group by ps.partkey
having sum(ps.supplycost * ps.availqty) >
(select sum(ps1.supplycost * ps1.availqty) * 0.0000003
from partsupp ps1,
supplier s1,
nation n1
where ps1.suppkey = s1.suppkey
and s1.nationkey = n1.nationkey
and n1.name = 'GERMANY' )
order by value desc;
