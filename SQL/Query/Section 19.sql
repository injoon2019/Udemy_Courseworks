#Section 19: Advanced SQL Topics

#Session Variable
SET @s_var1 = 3;
SELECT @s_var1;

#Global Variables
#Not more then 1000 sessions will start at the server
SET GLOBAL max_connections = 1000;

SET @@global.max_connections = 1;

#241. MySQL Triggers

# By definition, a MySQL trigger is a type of stored program, associated with a table, 
# that will be activated automatically once a specific event related to the table of association occurs
# This event must be related to one of the following three DML statements: INSERT, UPDATE, or DELETE. 

# In other words, a trigger is a MySQL object that can “trigger” a specific action or calculation ‘before’ or ‘after’ an INSERT, 
# UPDATE, or DELETE statement has been executed. For instance, a trigger can be activated before a new record is inserted into a table, 
# or after a record has been updated.

USE employees;
COMMIT;

DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary<0 THEN
					SET NEW.salary = 0;
	END IF;
END $$

DELIMITER ;

# Then, an interesting phrase follows – “for each row”. It designates that before the trigger is activated, MySQL will perform a #
# check for a change of the state of the data on all rows.

#BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN
		SET NEW.salary = 0;
	END IF;
END $$

DELIMITER ;

# Let’s check the values of the “Salaries” table for employee 10001.
SELECT *
FROM salaries
WHERE emp_no = '10001';

INSERT INTO salaries
VALUES
(
	'10001',
    -92891,
    '2010-06-22',
    '9999-01-01'
);

#BEFORE UPDATE
DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN
	IF NEW.salary<0 THEN
		SET NEW.salary=OLD.salary;
	END IF;
END $$

DELIMITER ;

#
UPDATE salaries
SET
	salary = 98765
WHERE
	emp_no = '10001'
    AND from_date = '2010-06-22';
    
#
SELECT *
FROM salaries
WHERE emp_no = '10001'
	 AND from_date = '2010-06-22';
     
#UPDATE
UPDATE salaries

# System functions
#SYSDATE() delivers the date and time of the moment at which you have invoked this function.


SET
	salary = -50000
WHERE
	emp_no = '10001'
    AND from_date = '2010-06-22';


#“Date Format”, assigns a specific format to a given date
## could extract the current date, quoting the year, the month, and the day. 
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;

#Exercise
DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
	SELECT MAX(salary)
    INTO v_curr_salary
    FROM salaries
    WHERE emp_no = NEW.emp_no;
    
    IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries
        SET to_date = SYSDATE()
        WHERE emp_no = NEW.emp_no AND to_date = NEW.to_date;
        INSERT INTO salaries
			VALUES (new.emp_no, v_curr_salary+20000, NEW.from_Date, NEW.to_date);
	END IF;
END $$


DELIMITER ;

# Conceptually, this was an ‘after’ trigger that automatically added $20,000 to the salary of the employee who was just promoted as a manager. 
INSERT INTO dept_manager 
VALUES
(
	'111534',
    'd009',
    date_format(sysdate(), '%y-%m-%d'), 
    '9999-01-01'
);


SELECT *
FROM dept_manager
WHERE emp_no = 111534;

SELECT *
FROM salaries
WHERE emp_no = 111534;


#242. MySQL Triggers - exercise
DELIMITER $$
CREATE TRIGGER trig_hire_date
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN
		SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');
	END IF;
END $$
DELIMITER ;

INSERT employees 
VALUES
(
	'999904',
    '1970-01-31',
    'John',
    'Johnson',
    'M',
    '2025-01-01'
);

SELECT *
FROM employees
ORDER BY emp_no DESC;

ROLLBACK;
#244. MySQL Indexes
SELECT *
FROM employees
WHERE hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

#SELECT all employees bearing the name "Georgi Facello"
SELECT *
FROM employees
WHERE first_name = 'Georgi'
		AND last_name = 'Facello';

CREATE INDEX i_composite ON employees(first_name, last_name);

SHOW INDEX FROM  employees FROM employees;

#245. MySQL Indexes - exercise 1
ALTER TABLE employees
DROP INDEX i_hire_date;

#247. MySQL Indexes - exercise 2
SELECT *
FROM salaries s
WHERE salary > 89000;

CREATE INDEX i_salary ON salaries(salary);

#249. The CASE Statement
SELECT emp_no, first_name, last_name,
		CASE
			WHEN gender = 'M' THEN 'Male'
            ELSE 'Female'
		END AS gender
FROM employees;

SELECT e.emp_no, e.first_name, e.last_name,
		CASE
			WHEN dm.emp_no IS NOT NULL THEN 'Manager'
            ELSE 'Employee'
		END AS is_manager
FROM
	employees e
    LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
	e.emp_no > 109900;
    
    
SELECT emp_no, first_name, last_name,
		IF(gender = 'M', 'Male', 'Female') AS gender
FROM employees;

#250. The CASE Statement - exercise 1
SELECT e.emp_no, e.first_name, e.last_name, 
		CASE
			WHEN dm.emp_no IS NOT NULL THEN 'Manager'
            ELSE 'Employee'
		END AS is_manager
FROM employees e
	LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
	e.emp_no > 109990;
    
#252. The CASE Statement - exercise 2
SELECT dm.emp_no, e.first_name, e.last_name, MAX(s.salary)-MIN(s.salary) AS salary_difference,
		CASE
			WHEN MAX(s.salary)-MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
            ELSE 'NOT'
		END AS salary_raise
FROM employees e
	JOIN
	dept_manager dm ON dm.emp_no = e.emp_no
    JOIN salaries s on s.emp_no = e.emp_no
GROUP BY s.emp_no;

#254. The CASE Statement - exercise 3
SELECT e.emp_no, e.first_name, e.last_name,
		CASE
			WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
            ELSE 'Not an employee anymore'
		END AS current_employee
FROM
	employees e
	JOIN
	dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;