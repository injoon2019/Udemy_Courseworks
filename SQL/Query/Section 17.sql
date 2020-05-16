#Section 17. SQL Views
USE employees;

SELECT *
FROM dept_emp;

SELECT emp_no, from_date, to_date, COUNT(emp_no) AS Num
FROM dept_emp
GROUP BY emp_no
HAVING Num>1;

#Above has more than 331 thousand entries
#Some employees have been inserted mroe than once
#Because a new entry about the same employee has been recorded
#every time the employee changede departments

#Visualize only the period encompassing the last contract of each employee

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
	SELECT
		emp_no, MAX(from_date) AS from_Date, MAX(to_date) AS to_date
	FROM
		dept_emp
	GROUP BY emp_no;
    
    
    
SELECT
	emp_no, MAX(from_date) AS from_Date, MAX(to_date) AS to_date
FROM
	dept_emp
GROUP BY emp_no
LIMIT 10000;

#216. Views - exercise
CREATE OR REPLACE VIEW v_average_salary_of_manager AS
	SELECT ROUND(AVG(s.salary),2)v_average_salary_of_manager
    FROM dept_manager m
    JOIN salaries s ON m.emp_no = s.emp_no;
    
    