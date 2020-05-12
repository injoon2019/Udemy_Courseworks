#Section 14: SQL Joins
# 167. Intro to JOINs - exercise 1

ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup
(
	dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);
    
INSERT INTO departments_dup
(
	dept_no,
	dept_name
)SELECT
	*
FROM
	departments;
    
INSERT INTO departments_dup (dept_name)
VALUES	('Public Relations');

DELETE FROM departments_dup
WHERE
	dept_no = 'd002';
    
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

#169. Intro to JOINs - exercise 2
select *
from departments_dup; 

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup(
	emp_no int(11) NOT NULL,
	dept_no char(4) NULL,
    from_date date NOT NULL,
    to_date date NULL
);

INSERT INTO dept_manager_dup
select* 
from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES
	(999904, '2017-01-01'),
	(999905, '2017-01-01'),
	(999906, '2017-01-01'),
	(999907, '2017-01-01');
    
DELETE FROM dept_manager_dup
WHERE
	dept_no= 'd001';

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE
	dept_no =  'd002';
    
#171. INNER JOIN - Part II
#공통 키 값 중 양쪽이 가지고 있는 것에 대해서만 JOIN
#Only non-null matching values are in play
select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
INNER JOIN
	departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

select *
from departments_dup
ORDER BY dept_no;

select *
from dept_manager_dup
ORDER BY dept_no;

#172. INNER JOIN - Part II - exercise
select M.emp_no, M.dept_no, E.first_name, E.last_name, M.from_date
from dept_manager M
INNER JOIN 
	employees E ON M.emp_no = E.emp_no;

#175. Duplicate Records
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES  ('d009', 'Customer Service');

#Check 'dept_manager_dup' and 'departments_dup'
SELECT *
FROM dept_manager_dup
ORDER BY dept_no ASC;

SELECT *
FROM departments_dup
ORDER BY dept_no ASC;

select *
from departments_dup;

DELETE FROM departments_dup WHERE dept_name = 'Customer Service';

SELECT * 
from departments_dup;


#To remove duplicated records, USE 'GROUP BY'
SELECT  m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
JOIN departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;

#176. LEFT JOIN - Part I
#Left joins can deliver a list with all records 
#from the left table that do not match any rows from the right table

#178. LEFT JOIN - Part II - exercise
select E.emp_no, E.first_name, E.last_name, M.dept_no, M.from_date
from employees E
LEFT JOIN dept_manager M ON E.emp_no = M.emp_no
WHERE E.last_name = 'Markovitch'
ORDER BY M.dept_no, M.emp_no;

#182. The new and the old join syntax - exercise
SELECT 
	e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
	employees e,
	dept_manager dm
WHERE
	e.emp_no = dm.emp_no;
    
#184. JOIN and WHERE Used Together
SELECT
	e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
where s.salary > 145000;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

# 186. JOIN and WHERE Used Together - exercise
select e.first_name, e.last_name, e.hire_date, t.title
from employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE e.first_name='Margareta' AND e.last_name = 'Markovitch';

#188. CROSS JOIN
# a cross join will take the values from a certain table and connect them with all the values
#from the tables we want to join it with
# connect 'all' the values, not just those that match 
#Cartesian product of the values of two or more

USE employees;

SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY dm.emp_no, d.dept_no;

#Below is same as above
SELECT dm.*, d.*
FROM dept_manager dm,
	 departments d
ORDER BY dm.emp_no, d.dept_no;

#Below is same as above
#Join without ON =not considered best practice
#CROSS JOIN = best practice
SELECT dm.*, d.*
FROM
	dept_manager dm
JOIN	departments d
ORDER BY dm.emp_no, d.dept_no;

SELECT dm.*, d.*
FROM departments d
CROSS JOIN dept_manager dm
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

SELECT e.*, d.*
FROM departments d
	CROSS JOIN	dept_manager dm
	JOIN employees e ON dm.emp_no = e.emp_no
WHERE
	d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

#189. CROSS JOIN - exercise 1
select dm.*, d.*
FROM departments d
CROSS JOIN dept_manager dm
WHERE d.dept_no = 'd009'
ORDER BY d.dept_name;

#191. CROSS JOIN - exercise 2
SELECT e.*, d.*
FROM employees e 
CROSS JOIN departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

#*193. Using Aggregate Functions with Joins
SELECT
	e.gender, AVG(s.salary) AS average_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

#194. JOIN more than two tables in SQL
SELECT e.first_name,
		e.last_name,
        e.hire_date,
        m.from_date,
        d.dept_name
FROM
	employees e
    JOIN
    dept_manager m ON e.emp_no = m.emp_no
    JOIN
    departments d  ON m.dept_no = d.dept_no;
    
# 195. Join more than two tables in SQL - exercise
SELECT e.first_name, e.last_name, e.hire_date, t.title, t.from_date, d.dept_name
FROM employees e
	JOIN 
    titles t ON e.emp_no =  t.emp_no
    JOIN
    dept_emp de ON e.emp_no  = de.emp_no
    JOIN
		departments d ON de.dept_no = d.dept_no;
        
SELECT e.first_name, e.last_name, e.hire_date, t.title, m.from_date, d.dept_name
FROM employees e
	JOIN dept_manager m ON e.emp_no = m.emp_no
    JOIN departments d ON m.dept_no = d.dept_no
    JOIN titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

#197. Tips and tricks for joins
SELECT d.dept_name, AVG(salary) AS average_salary
FROM departments d
	JOIN dept_manager m ON d.dept_no = m.dept_no
    JOIN salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY AVG(salary) DESC;

#198. Tips and tricks for joins - exercise
SELECT e.gender, COUNT(e.emp_no)
FROM employees e
	JOIN dept_manager dm ON dm.emp_no = e.emp_no
GROUP BY e.gender;

#200. UNION vs UNION ALL

DROP TABLE IF EXISTS employee_dup;
CREATE TABLE employees_dup (
	emp_no int(11),
	birth_Date date,
    first_name varchar(14),
	last_name varchar(16),
	gender enum('M', 'F'),
    hire_date date
);

#duplicate the structure of the 'employees' table
INSERT INTO employees_dup
SELECT
	e.*
FROM 
	employees e
LIMIT 20;

#Insert a duplicate of the first row
INSERT INTO employees_dup VALUES
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

#Check
SELECT *
FROM employees_dup;

-- UNION vs UNION ALL
#UNION displays only distinct values in the output
#UNION ALL retrieved the duplicates as well
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
	employees_dup e
WHERE
	e.emp_no = 10001
UNION ALL SELECT
	NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
	dept_manager m;
	
#201. UNION vs UNION ALL - exercise
SELECT *
FROM
	(SELECT e.emp_no, e.first_name, NULL AS dept_no, NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis'
    UNION
    SELECT 
		NULL AS first_name,
        NULL AS last_name,
        dm.dept_no,
        dm.from_date
	FROM dept_manager dm) as a
    ORDER BY -a.emp_no DESC;