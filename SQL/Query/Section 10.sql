#Section 10: SQL INSERT statement
Use employees;

select *
from employees
ORDER BY emp_no DESC
limit 10;

INSERT INTO employees
(
	emp_no,
    birth_Date,
    first_name,
    last_name,
    gender,
    hire_date
)VALUES
(
	999901,
    '1986-04-21',
    'John',
    'Smith',
    'M',
    '2011-01-01'
);

INSERT INTO employees
(
	birth_Date,
    emp_no,
	first_name,
    last_name,
    gender,
    hire_date
)VALUES
(	
	'1973-3-26',
	999902,
	'Patricia',
	'Lawrence',
	'F',
	'2005-01-01'
);

INSERT INTO employees
VALUES
(
	999903,
    '1977-09-14',
	'Johnathan',
	'Creek',
    'M',
    '1999-01-01'
);

#127 solution
select *
from titles
LIMIT 10;


INSERT INTO titles
(
	emp_no,
	title,
	from_date
)
VALUES
(
	999903,
	'Senior Engineer',
    '1997-10-01'
);

select *
from titles
order by emp_no DESC
limit 10;


#128
select *
from dept_emp
order by emp_no desc
limit 10;

INSERT INTO dept_emp
(
	emp_no,
    dept_no,
    from_date,
	to_date
)VALUES
(	
	999903,
	'd005',
    '1997-10-01',
    '9999-01-01'
);


#130 Inserting data INTO a new table
select *
from departments
limit 10;

CREATE TABLE departments_dup
(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

select *
from departments_dup;


INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
select *
from departments;



#Inserting Data INTO a new table
select *
from departments;

INSERT INTO departments
VALUES
(
	'd010',
    'Business Analysis'
);