#Section 15: SQL Subqueries

#Select the first and last name from the "Employees' talbe for the same
#employee numbers that can be found in the "Department Manager" table
USE employees;

SELECT
	e.first_name, e.last_name
FROM
	employees e
WHERE
	e.emp_no IN (SELECT
					dm.emp_no
				FROM
					dept_manager dm);
                    
                    
#204. SQL Subqueries with IN nested inside WHERE - exercise
SELECT dm.*
FROM dept_manager AS dm
WHERE from_date > '1990-01-01' AND from_date < '1995-01-01';

SELECT *
FROM dept_manager
WHERE emp_no IN ( SELECT emp_no
				  FROM employees
				 WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
                 
#206. SQL Subqueries with EXISTS-NOT EXISTS nested inside WHERE
# What's the difference beween 'IN' and 'EXISTS'?
# EXISTS tests row values for existence  -> quicker in retrieving large amounts of data
# In searches among values -> faster with samller datasets

#207. SQL Subqueries with EXISTS-NOT EXISTS nested inside WHERE - exercise
SELECT *
FROM employees e
WHERE emp_no IN (SELECT emp_no
				 FROM titles
                 WHERE title = 'Assistant Engineer');
                 
SELECT *
FROM employees e
WHERE EXISTS (SELECT *
			  FROM titles t
              WHERE t.emp_no = e.emp_no 
					AND title = 'Assistant Engineer');
                    
#209. SQL Subqueries nested in SELECT and FROM
# Hard and Important!!
SELECT A.* 
FROM
	(SELECT
		e.emp_no as employee_ID,
		MIN(de.dept_no) as department_cde,
		(SELECT emp_no
			FROM dept_manager
			WHERE emp_no = 110022) AS manager_ID
	FROM employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
	WHERE e.emp_no <=10020
	GROUP BY e.emp_no
	ORDER BY e.emp_no) as A
UNION     
    SELECT B.* 
	FROM
		(SELECT
			e.emp_no as employee_ID,
			MIN(de.dept_no) as department_cde,
			(SELECT emp_no
				FROM dept_manager
				WHERE emp_no = 110039) AS manager_ID
		FROM employees e
		JOIN dept_emp de ON e.emp_no = de.emp_no
		WHERE e.emp_no >=10020
		GROUP BY e.emp_no
		ORDER BY e.emp_no
        LIMIT 20) as B;
        
#210. SQL Subqueries nested in SELECT and FROM - exercise 1

DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager
(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(4) NOT NULL
);

#212. SQL Subqueries nested in SELECT and FROM - exercise 2
INSERT INTO emp_manager SELECT
u.*
FROM
	(SELECT
		a.*
	 FROM
		(SELECT
		e.emp_no AS employee_ID,
			MIN(de.dept_no) AS department_code,
            (SELECT
				emp_no
			FROM
				dept_manager
			WHERE
				emp_no = 110022) AS manager_ID
	FROM
		employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
		e.emp_no <= 10020
	GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT
		b.*
	FROM
		(SELECT
		e.emp_no AS employee_ID,
		MIN(de.dept_no) AS department_code,
        (SELECT
			emp_no
		FROM
			dept_manager
		WHERE
			emp_no = 110039) AS manager_ID
	FROM
		employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
		e.emp_no > 10020
	GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT
		c.*
	FROM
		(SELECT
        e.emp_no AS employee_ID,
        MIN(de.dept_no) AS department_code,
        (SELECT
			emp_no
		FROM
			dept_manager
		WHERE
			emp_no = 110039) AS manager_ID
	FROM
		employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
		e.emp_no = 110022
	GROUP BY e.emp_no) AS c UNION SELECT
		d.*
	FROM
		(SELECT
		e.emp_no AS employee_ID,
			MIN(de.dept_no) AS department_code,
            (SELECT
				emp_no
			FROM
				dept_manager
			WHERE
				emp_no = 110022) AS manager_ID
	FROM
		employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
		e.emp_no = 110039
	GROUP BY e.emp_no) AS d) as u;
    
    
    
#ANSWER
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;