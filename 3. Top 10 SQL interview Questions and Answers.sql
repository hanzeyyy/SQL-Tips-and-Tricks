---Top 10 SQL interview Questions and Answers---
select * from employee;
--1. how to find duplicates in a given table
select emp_id,
count(*) as dup
from emp_dup
group by emp_id
having count(1) > 1;


--2. how to delete duplicates
with cte as
	(select *,
	row_number() over(partition by emp_id order by emp_name) as row_num
	from emp_dup)
delete from  cte
where row_num > 1;


select * from emp_dup;
--3. difference between union and union all
--union returns common records only
--union all returns all the records present in both tables 
select manager_id from employee
union
select manager_id from emp_dup

select manager_id from employee
union all
select manager_id from emp_dup


--4. difference between row_number, rank and dense_rank



--5. employees who are not present in department table
select * from emp
where department_id not in (select dep_id from dept);
--or
select e.*, d.*
from emp e
left join dept d on e.department_id = d.dep_id
where d.dep_id is null;

--6. second highest salary in each department
with cte as
	(select *,
	rank() over(partition by dept_id order by salary desc) as rk
	from employee)
select * from cte
where rk = 2;


select * from orders_5;
--7. find all transactions done by shilpa
select * from orders_5
where upper(customer_name) = 'shilpa'; 


--8. self join, manager salary > employee salary
select e1.emp_id,e1.emp_name, e1.salary,
e2.emp_id as manager_id, e2.emp_name as manager_name, e2.salary as manager_salary
from employee e1
inner join employee e2 on e1.manager_id = e2.emp_id
where e1.salary < e2.salary;


--9. joins: left vs inner join
--inner joins common records
--left joins all records from 1st table to 2nd table
select * from employee e
inner join dept d on e.dept_id = d.dep_id;

select * from employee e
left join dept d on e.dept_id = d.dep_id;


select * from orders_5;
--10. update query to swap gender
update orders_5 set customer_gender = case when customer_gender = 'Male' then 'Female'
										   when customer_gender = 'Female' then 'Male' end;

select * from orders_5;
