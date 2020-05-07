SELECT 
    first_name, last_name
FROM
    employees;
    
    
SELECT 
    *
FROM
    employees;
    
#SELECT FROM exercise
select *
from departments;

#WHERE
select *
from employees
where first_name = 'Denis';

#Where Exercise
select *
from employees
where first_name = 'Elvis';

#AND
select *
from employees
where first_name = 'Denis' AND gender='M';

select *
from employees
where first_name = 'Kellie' AND gender = 'F';

#OR exercise
select *
from employees
where first_name='Kellie' OR first_name='Aruna';

# AND > OR
SELECT *
FROM employees
WHERE last_name = 'Denis' AND (gender = 'M' OR gender='F');

#Operator precedence
select *
from employees
where gender = 'F' AND (first_name='Kellie' OR first_name='Aruna');

#IN-NOT IN
select *
from employees
where first_name = 'Cathie'
		OR first_name = 'Mark'
		OR first_name = 'Nathan';
        
select *
from employees
where first_name IN ('Cathie', 'Mark', 'Nathan');

select *
from employees
where first_name NOT IN ('Cathie', 'Mark', 'Nathan');

#IN - NOT IN exercise 1
select *
from employees
where first_name IN ('Denis', 'Elvis');

#IN - NOT IN exercise 2
select *
from employees
where first_name NOT IN ('John', 'Mark', 'Jacob');

#86 LIKE - NOT LIKE
# % represents zero or more leters 
# %ar will get all the names ending with 'ar'
# %ar% 'ar' will be found next to each other somewhere in fist name
# % substitute for a sequence of characters
# _ helps you matching a single character
select *
from employees
where first_name LIKE ('ar%');

select *
from employees
where first_name LIKE ('Mar_');

#Like - NOT LIKE exercise
select *
from employees
where first_name LIKE 'Mark%';

select *
from employees
where hire_date LIKE ('%2000%');

select *
from employees
where emp_no LIKE ('1000_');

#Wildcard characters - exercise
select *
from employees
where first_name LIKE ('%JACK%');

select *
from employees
where first_name NOT LIKE ('%JACK%');

#92 BETWEEN - AND
#'1990-01-01' AND '2000-01-01' are contined
select *
from employees
where hire_date BETWEEn '1990-01-01' AND '2000-01-01';

#'1990-01-01' AND '2000-01-01' are not included in the interval
select *
from employees
where hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

#93.BETWEEN-AND exercise
select *
from salaries
where salary BETWEEN '66000' AND '70000';

select *
from employees
where emp_no NOT BETWEEN '10004' AND '10012';

select dept_name
from departments
where dept_no BETWEEN 'd003' AND 'd006';

USE employees;
select *
from employees
where first_name IS NULL;

select dept_name
from departments
where dept_name IS NOT NULL;

#other comparison operators
select *
from employees
where first_name !='Mark';

select *
from employees
where hire_date < '1985-02-01';

#Other comparison operators - exercise
select *
from employees
where hire_date >= '2000-01-01' AND gender='F';

select *
from salaries
where salary >'150000';

#101.select distinct
select DISTINCT gender
FROM employees;

#102
select DISTINCT hire_date
from employees;

#Introduction to aggregate functions 
select count(emp_no)
from employees;

select *
from employees
where first_name IS NULL;

select COUNT(DISTINCT first_name)
from employees;

#Introduction to aggregate functions - exercise
select COUNT(*)
from salaries
where salary >= 100000;

select COUNT(emp_no)
from dept_manager;

#Order by
select *
from employees
ORDER BY first_name;

#Ascending order
select *
from employees
ORDER BY first_name ASC;

#Descending order
select *
from employees
ORDER BY first_name DESC;

select *
from employees
ORDER BY emp_no DESC;

select *
from employees
ORDER BY first_name, last_name ASC; 

#Exercise
select *
from employees
ORDER BY hire_date DESC;

#GROUP BY

select first_name
from employees
GROUP BY first_name;

select first_name, count(first_name)
from employees
group by first_name
order by first_name DESC;

#Using Aliases
select first_name, count(first_name) AS names_count
from employees
group by first_name
order by first_name DESC;

##Using Aliases (AS) - exrecise
select salary, COUNT(emp_no) AS emps_with_same_salary
from salaries
where salary > 80000
group by salary
ORDER BY salary;

#114 Having
#where clause cannot use aggregate functions but having can
#extract a list with all first names that appear more than 250 times

#Wrong example
select first_name, count(first_name) as names_count
from employees
where count(first_name)>250
group by first_name
order by first_name;

#Correct example
select first_name, count(first_name) as names_count
from employees
group by first_name
Having count(first_name)>250
order by first_name;

#Having exercise
#wrong 
select *, AVG(salary)
from salaries
where salary>120000
group by emp_no
order by emp_no;

#correct
select *, AVG(salary)
from salaries
group by emp_no
having AVG(salary) > 120000
ORDER BY emp_no;

#WHERE VS HAVING 1
select first_name, count(first_name) as names_count
from employees
where hire_date > '1999-01-01'
group by first_name
having count(first_name) <200
order by first_name DESC;

#WHERE VS HAVING 2 exercise
select emp_no, count(from_date) AS contract_times
from dept_emp
where from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date)>1
ORDER BY contract_times;

#120 Limit
select *
from salaries
order by salary DESC
limit 10;

#Limit exercise
select *
from dept_emp
limit 100;
