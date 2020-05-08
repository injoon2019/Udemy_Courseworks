#Section 12: SQL DELETE Statement

USE employees;

COMMIT;

select *
from employees
where emp_no = 999903;

select *
from titles
where emp_no = 999903;

DELETE FROM employees
WHERE
	emp_no = 999903;
    
ROLLBACK;

#140. The DELETE Statement - Part II
select *
from departments_dup
order by dept_no;

delete from departments_dup;

ROLLBACK;

#141. The DELETE Statement – Part II - exercise
DELETE FROM departments
WHERE
	dept_no = 'd010';

#143. DROP vs TRUNCATE vs DELETE
 