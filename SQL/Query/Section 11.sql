#Section 11: SQL UPDATE Statement
USE employees;

SELECT *
FROM employees
WHERE emp_no = 999901;

UPDATE employees
SET
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
	gender = 'F'
WHERE
	emp_no = 999901;
    
#The UPDATE Statement - Part II
SELECT *
FROM departments_dup
ORDER BY dept_no;

COMMIT;

UPDATE departments_dup
SET 
	dept_no = 'd011',
    dept_name = 'Quality Control';
    
ROLLBACK;

COMMIT;

#137. The UPDATE Statement – Part II - exercise
select *
from departments;

UPDATE departments
SET
	dept_name = 'Data Analysis'
WHERE
	dept_name = 'Business Analysis';