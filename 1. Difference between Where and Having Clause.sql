---Difference between Where and Having Clause in SQL---
select * from employee;
---where---
--where clause is a row by row filter
--this runs on individual rows
select * from employee
where salary > 10000;

---having---
--having clause runs for aggregated values
select dept_id,
avg(salary) as avg_sal
from employee
group by dept_id
having avg(salary) > 9000;

--using both where and having clause
select dept_id,
avg(salary) as avg_sal
from employee
where salary > 10000
group by dept_id
having avg(salary) > 12000;
