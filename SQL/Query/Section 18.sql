#Section 18. Stored routines

#220. Stored procedures - Example - Part I
USE employees;

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN

	SELECT * FROM employees
    LIMIT 1000;
END$$
DELIMITER ;

#221. Stored procedures - Example - Part II

call employees.select_employees();

call select_employees();

#222. Stored procedures - Example - Part II -exercise
DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
	SELECT AVG(s.salary)
    FROM salaries s;
END$$
DELIMITER ;

call avg_salary();

#224. Another way to create a procedure

DROP PROCEDURE average_salary_employees;

#225. Stored procedures with an input parameter

DROP procedure IF EXISTS emp_salary;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
	e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$

DELIMITER ;



DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
	e.first_name, e.last_name, AVG(s.salary)
FROM employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$

DELIMITER ;

call emp_avg_salary(11300);

#226. Stored procedures with an output parameter

USE employees;
DROP procedure IF EXISTS emp_avg_salary_out;

USE employees;
DROP procedure IF EXISTS emp_avg_salary_out;
#The output will be stored in p_avg_salary parameter
DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(in p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN
SELECT
	AVG(s.salary)
INTO p_avg_salary FROM
	employees e
    JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$

DELIMITER ;

#227. Stored procedures with an output parameter - exercise
DROP procedure IF EXISTS emp_info;
DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name VARCHAR(255), in p_last_name VARCHAR(255), out p_emp_no INTEGER)
BEGIN
SELECT
	e.emp_no
INTO p_emp_no
FROM
	employees e
WHERE
	e.first_name = p_first_name AND e.last_name = p_last_name;
END$$

DELIMITER ;

#229. Variables
USE employees;
DROP procedure IF EXISTS emp_avg_salary_out;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(in p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN
SELECT
	ACG(s.salary)
INTO p_avg_salary FROm
	employees e
    JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$

DELIMITER ;


SET @v_avg_salary = 0;
CALL employees.emp_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

SET @v_emp_no = 0;
CALL emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

#232. User-defined functions in MySQL
USE employees;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
#If Error happens, add either DETERMINISTIC, NO SQL, or READS SQL DATA
NO SQL
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

SELECT
	AVG(s.salary)
INTO v_avg_salary FROM
	employees e
	JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
RETURN v_avg_salary;
END$$

DELIMITER ;

SELECT f_emp_avg_salary(11300);

#234. User-defined functions in MySQL - exercise

DELIMITER $$

CREATE FUNCTIOn EMP_INFO(p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS decimal(10,2)
DETERMINISTIC

BEGIN
	DECLARE v_max_from_date date;
    DECLARE v_salary decimal(10,2);
SELECT
	MAX(from_date)
INTO v_max_from_date 
FROM employees e
	JOIN 
    salaries s ON e.emp_no = s.emp_no
WHERE
	e.first_name = p_first_name
    AND e.last_name = p_last_name;
    
SELECT
	s.salary
INTO v_salary 
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name
	 AND e.last_name = p_last_name
     AND s.from_date = v_max_from_date;

RETURN v_salary;
END$$

DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');