#Section 13: MySQL - Aggregate functions
USE employees;

select *
from salaries
order by salary desc
limit 10;

select
	count(distinct from_date)
from 
	salaries;
    
select
	count(*)
from 
	salaries;
    
#count exercise
select count(distinct dept_no)
from dept_emp;

#SUM()
select sum(salary)
from salaries;

#SUM exercise
select sum(salary)
from salaries
where from_date > '1997-01-01';

#MIN and MAX
select MAX(salary)
FROM salaries;

select MIN(salary)
from salaries;

#MIN and MAX exercise
select MIN(emp_no)
from salaries;

select MAX(emp_no)
from salaries;

#AVG
select AVG(salary)
from salaries;

#AVG exercise
select AVG(salary)
from salaries
where from_date > '1997-01-01';

#ROUND
select ROUND(AVG(salary),2)
from salaries;

#157. ROUND() - exercise
select ROUND(AVG(salary), 2)
from salaries
where from_date > '1997-01-01';

#160. IFNULL() and COALESCE()
SELECT
	dept_no,
    IFNULL(dept_name, 'Department name not provided') as dept_name
FROM
	departments_dup;
    
#IF COALESCE() has two arguments, it will work as IFNULL
SELECT
	dept_no,
    COALESCE(dept_name, 'Department name not provided') as dept_name
FROM
	departments_dup;
    
#161. Another Example of Using COALESCE()
-- SELECT
-- 	dept_no,
--     dept_name,
--     COALESCE('department manager name') AS fake_col
-- FROM
-- 	departments_dup;
    
#162. Another example of using COALESCE() - exercise 1
select dept_no, 
		dept_name,
        COALESCE(dept_no, dept_name) as dept_info
from
	departments_dup
ORDER BY dept_no ASC;

#163. Another example of using COALESCE() -solution 1
select 
	IFNULL(dept_no, 'N/A') as dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name,
COALESCE(dept_no, dept_name) AS dept_info;