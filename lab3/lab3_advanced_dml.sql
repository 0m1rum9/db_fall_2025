-- PART A:
CREATE DATABASE advanced_lab;
CREATE TABLE employees(
     emp_id SERIAL PRIMARY KEY,
     first_name VARCHAR(100),
     last_name VARCHAR(100),
     department VARCHAR(100),
     salary INT,
     hire_date DATE,
     status VARCHAR(30) DEFAULT('ACTIVE')
);
CREATE TABLE departments(
     dept_id SERIAL PRIMARY KEY,
     dept_name VARCHAR(100),
     budget INT,
     manager_id INT
);
CREATE TABLE projects(
     project_id SERIAL PRIMARY KEY,
     project_name VARCHAR(100),
     dept_id INT,
     start_date DATE,
     end_date DATE,
     budget INT
);



-- PART B;
INSERT INTO employees(
     emp_id,
     first_name,
     last_name,
     department)
VALUES(
     10,
     'Linus',
     'Torvalds',
     'Linux'
);
-- Would be useful to alter table before inserting with DEFAULT for salary which was not specified
ALTER TABLE employees
     ALTER COLUMN salary SET DEFAULT 1000;
--
INSERT INTO employees(
     emp_id,
     first_name,
     last_name,
     department)
VALUES(
     12,
     'Robert',
     'Martin',
     'Cleaner'
);
INSERT INTO employees
  VALUES(144, 'Dijkstra', 'Edsger', 'Graph Design', 33, CURRENT_DATE, 'ACTIVE'),
  (145, 'Bjarne', 'Stroustrup', 'PlusMan', 123453, CURRENT_DATE, 'ACTIVE'),
  (146, 'Alan', 'Turing', 'Machine?', 50000 * 1.1, CURRENT_DATE, 'ACTIVE');
INSERT INTO temp_employees
 SELECT * FROM employees WHERE department = 'IT';



-- Part C
UPDATE employees
 SET salary = salary * 1.1;
UPDATE employees
 SET status = 'Senior' WHERE salary > 60000 AND hire_date < '2020-01-01';

UPDATE employees
SET department = CASE
    WHEN salary > 80000 THEN 'Management'
    WHEN salary BETWEEN 50000 AND 80000 THEN 'Senior'
    ELSE 'Junior'
END;
UPDATE employees
 SET department = DEFAULT WHERE department = 'Inactive';
UPDATE departments
 SET budget = (SELECT AVG(salary) FROM employees WHERE employees.department = dept_name);
UPDATE employees
 SET salary = salary * 1.15 ,
 status = 'Promoted' WHERE department = 'Sales';


-- Part D
DELETE FROM employees WHERE status = 'Terminated';
DELETE FROM employees WHERE
 salary < 40000 AND
 hire_date > '2023-01-01' AND
 department IS NULL;
DELETE FROM departments WHERE dept_name NOT IN(SELECT DISTINCT
  department FROM employees WHERE employees.department IS NOT NULL);
DELETE FROM projects WHERE end_date < '2023-01-01' RETURNING *;


-- Part D
INSERT INTO employees(
 salary, department) VALUES(NULL, NULL);
UPDATE employees
 SET department = 'Unassigned' WHERE department IS NULL;
DELETE FROM employees WHERE salary IS NOT NULL OR department IS NULL;


-- Part F
INSERT INTO employees(emp_id, first_name, last_name)
 VALUES(333, 'Vito', 'Scaletta') RETURNING emp_id, first_name || ' ' || last_name AS full_name;
UPDATE employees
 SET salary = salary + 5000 RETURNING emp_id, salary, salary - 5000 AS old_salary;
DELETE FROM employees WHERE hire_date < '2020-01-01' RETURNING *;


-- Part G
INSERT INTO employees(emp_id, first_name, last_name)
 SELECT 123, 'Linus', 'Torvalds' WHERE NOT EXISTS(SELECT 1 FROM employees WHERE first_name = 'Linus' AND last_name = 'Torvalds');
UPDATE employees e
 SET salary = CASE
     WHEN d.budget > 100000 THEN e.salary * 1.1
     ELSE e.salary * 1.05
 END
 FROM departments d
 WHERE e.department = d.dept_name;
CREATE TABLE employee_archive(
     emp_id SERIAL PRIMARY KEY,
     first_name VARCHAR(100),
     last_name VARCHAR(100),
     department VARCHAR(100),
     salary INT,
     hire_date DATE,
     status VARCHAR(30) DEFAULT('ACTIVE')
);
INSERT INTO employee_archive
 SELECT * FROM employees WHERE status = 'Inactive';
DELETE FROM employees WHERE status = 'Inactive';
UPDATE projects
 SET end_date = end_date + INTERVAL '30 days' FROM departments
 WHERE projects.budget > 50000 AND (SELECT COUNT(*) FROM employees WHERE departments.dept_name = employees.department) > 3;
