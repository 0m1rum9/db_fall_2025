
-- Part 1
CREATE TABLE employees (
                           emp_id INT PRIMARY KEY,
                           emp_name VARCHAR(50),
                           dept_id INT,
                           salary DECIMAL(10, 2)
);
CREATE TABLE departments (
                             dept_id INT PRIMARY KEY,
                             dept_name VARCHAR(50),
                             location VARCHAR(50)
);
CREATE TABLE projects (
                          project_id INT PRIMARY KEY,
                          project_name VARCHAR(50),
                          dept_id INT,
                          budget DECIMAL(10, 2)
);

INSERT INTO employees (emp_id, emp_name, dept_id, salary)
VALUES
    (1, 'John Smith', 101, 50000),
    (2, 'Jane Doe', 102, 60000),
    (3, 'Mike Johnson', 101, 55000),
    (4, 'Sarah Williams', 103, 65000),
    (5, 'Tom Brown', NULL, 45000);

INSERT INTO departments (dept_id, dept_name, location) VALUES
                                                           (101, 'IT', 'Building A'),
                                                           (102, 'HR', 'Building B'),
                                                           (103, 'Finance', 'Building C'),
                                                           (104, 'Marketing', 'Building D');

INSERT INTO projects (project_id, project_name, dept_id,
                      budget) VALUES
                                  (1, 'Website Redesign', 101, 100000),
                                  (2, 'Employee Training', 102, 50000),
                                  (3, 'Budget Analysis', 103, 75000),
                                  (4, 'Cloud Migration', 101, 150000),
                                  (5, 'AI Research', NULL, 200000);



-- 2.1
CREATE INDEX salary_index ON employees(salary);

-- 2.2
CREATE INDEX dept_id_index ON employees(dept_id);

-- 2.3
SELECT * FROM pg_indexes;

-- Part 3
-- 3.1
CREATE INDEX dept_id_salary_index ON employees(salary, dept_id);

-- 3.2
CREATE INDEX salary_dept_id_index ON employees(dept_id, salary);

-- Part 4
ALTER TABLE employees
ADD COLUMN email TEXT;
UPDATE employees SET email = 'foijre@gmail.com' WHERE emp_id = 1;
UPDATE employees SET email = 'linus@mail.ru' WHERE emp_id = 2;
UPDATE employees SET email = 'tannenbaum@yahoo.com' WHERE emp_id = 3;
UPDATE employees SET email = 'pascal@email.com' WHERE emp_id = 4;
UPDATE employees SET email = 'doggy@gmail.com' WHERE emp_id = 5;
CREATE UNIQUE INDEX emp_email_unique_idx ON employees(email);

-- 4.2
ALTER TABLE employees ADD COLUMN iin VARCHAR(20) UNIQUE;

SELECT *
FROM pg_indexes
WHERE tablename = 'employees' AND indexname LIKE '%iin%';

-- Part 5
CREATE INDEX desc_salary_idx ON employees(salary DESC);

CREATE INDEX dept_id_null_idx ON employees(dept_id NULLS FIRST);

-- Part 6
CREATE INDEX emp_name_idx_caseless ON employees(LOWER(emp_name));

-- 6.2
ALTER TABLE employees
ADD COLUMN hire_date DATE;
UPDATE employees SET hire_date = '2000-03-04' WHERE emp_id = 1;
UPDATE employees SET hire_date = '2001-01-21' WHERE emp_id = 2;
UPDATE employees SET hire_date = '2002-03-03' WHERE emp_id = 3;
UPDATE employees SET hire_date = '2003-01-06' WHERE emp_id = 4;
UPDATE employees SET hire_date = '2004-03-02' WHERE emp_id = 5;

CREATE INDEX emp_year_idx ON employees(EXTRACT(YEAR FROM employees.hire_date));

-- Part 7
ALTER INDEX salary_index RENAME TO employees_salary_index;

-- 7.2
DROP INDEX employees_salary_index;

-- 7.3
REINDEX INDEX emp_year_idx;

-- Part 8
CREATE INDEX emp_salary_idx ON employees(salary) WHERE salary > 50000;

-- 8.2
CREATE INDEX proj_budget_idx ON projects(budget)
    WHERE budget > 80000;

-- 8.3
EXPLAIN SELECT * FROM employees WHERE salary > 50000;

-- Part 9
CREATE INDEX dept_name_idx ON departments USING HASH (dept_name);

-- 9.2
CREATE INDEX proj_name_btree_idx ON projects USING btree(project_name);
CREATE INDEX proj_name_hash_idx ON projects USING HASH(project_name);

-- Part 10
SELECT
    schemaname,
    tablename,
    indexname,
    pg_size_pretty(pg_relation_size(indexname::regclass)) as index_size
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


-- 10.3
CREATE VIEW index_documentation AS
SELECT
    tablename,
    indexname,
    indexdef,
    'Improves salary-based queries' as purpose
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname LIKE '%salary%';



