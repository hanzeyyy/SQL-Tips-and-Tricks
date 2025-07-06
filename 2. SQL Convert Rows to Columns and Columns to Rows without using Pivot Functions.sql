---SQL Convert Rows to Columns and Columns to Rows without using Pivot Functions---
create table emp_compensation 
(
	emp_id int,
	salary_component_type varchar(20),
	val int
);

insert into emp_compensation values 
(1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);

select * from emp_compensation;
--write a query to print emp_id, salary, bonus and hike_percentage
select emp_id,
case when salary_component_type = 'salary' then val end as salary,
case when salary_component_type = 'bonus' then val end as bonus,
case when salary_component_type = 'hike_percent' then val end as hike_percentage
from emp_compensation
--we are getting one column value for corresponding emp_id, so we can sum it up

select emp_id,
sum(case when salary_component_type = 'salary' then val end) as salary,
sum(case when salary_component_type = 'bonus' then val end) as bonus,
sum(case when salary_component_type = 'hike_percent' then val end) as hike_percentage
from emp_compensation
group by emp_id;

--how to change it back
--we use the concept of views
select emp_id,
sum(case when salary_component_type = 'salary' then val end) as salary,
sum(case when salary_component_type = 'bonus' then val end) as bonus,
sum(case when salary_component_type = 'hike_percent' then val end) as hike_percentage
into emp_compensation_pivot
from emp_compensation
group by emp_id;

select emp_id, 
'salary' as salary_component_type,
salary as val
from emp_compensation_pivot
--similarly we can create for bonus and hike_percentage
select emp_id, 
'salary' as salary_component_type,
salary as val
from emp_compensation_pivot
union all
select emp_id, 
'bonus' as salary_component_type,
bonus as val
from emp_compensation_pivot
union all
select emp_id, 
'hike_percent' as salary_component_type,
hike_percentage as val
from emp_compensation_pivot;

--we need to get it order by emp_id
select * from 
(
	select emp_id, 
	'salary' as salary_component_type,
	salary as val
	from emp_compensation_pivot
	union all
	select emp_id, 
	'bonus' as salary_component_type,
	bonus as val
	from emp_compensation_pivot
	union all
	select emp_id, 
	'hike_percent' as salary_component_type,
	hike_percentage as val
	from emp_compensation_pivot) a
order by emp_id;
	
