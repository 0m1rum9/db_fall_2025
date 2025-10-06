	
													-- Part 1
-- Task 1.1
SELECT first_name || ' ' || last_name as full_name, department, salary FROM employees;
-- Task 1.2
SELECT DISTINCT department FROM employees;
-- Task 1.3
SELECT project_name, budget FROM projects;
ALTER TABLE projects
  ADD COLUMN budget_category VARCHAR(100);
UPDATE projects
   SET budget_category = CASE
                             WHEN budget > 150000 THEN 'Large'
                             WHEN budget between 100000 AND 150000 THEN 'Medium'
                             ELSE 'Small'
END;
-- Task 1.4
SELECT first_name || ' ' || last_name as full_name, COALESCE(email, 'NO EMAIL PROVIDED') FROM employees;



													-- Part 2
-- Task 2.1
SELECT * FROM employees WHERE hire_date > '2020-01-01';
-- Task 2.2
SELECT * FROM employees WHERE salary BETWEEN 60000 AND 70000;
-- Task 2.3
SELECT * FROM employees WHERE last_name LIKE 'S%' OR last_name LIKE 'J%';
-- Task 2.4
SELECT * FROM employees WHERE manager_id IS NOT NULL AND department = 'IT';



													-- Part 3
-- Task 3.1
SELECT UPPER(first_name || ' ' || last_name) as full_name, LENGTH(last_name) as length_of_last_name, SUBSTRING(email, 0, 4) as first_three FROM employees;
-- Task 3.2
SELECT salary * 12 as annual_salary, salary as monthly_salary, salary * 0.1 as ten_percent_raise FROM employees;
-- Task 3.3
SELECT FORMAT('Project: %I - Budget: %I$ - Status: %I', project_name, budget, status) FROM projects;
-- Task 3.4
SELECT DATE_PART('year', CURRENT_DATE) - DATE_PART('year', hire_date) as years_been FROM employees;



													-- Part 4
-- Task 4.1
SELECT department, AVG(salary) FROM employees GROUP BY department;
-- Task 4.2
SELECT project_name, hours_worked FROM projects JOIN assignments ON assignments.project_id = projects.project_id;
-- Task 4.3
SELECT COUNT(*), department FROM employees GROUP BY department HAVING COUNT(*) > 1;
-- Task 4.4
SELECT MAX(salary), MIN(salary), SUM(salary) FROM employees;



													-- Part 5
-- Task 5.1
SELECT employees.employee_id, (first_name || ' ' || last_name) AS full_name, salary FROM employees WHERE salary > 65000 UNION SELECT employee_id, (first_name || ' ' |
 | last_name) full_name, salary FROM employees WHERE hire_date > '2020-01-01';	
-- Task 5.2
SELECT * FROM employees WHERE department = 'IT' INTERSECT SELECT * FROM employees WHERE salary > 65000;
-- Task 5.3
SELECT employees.employee_id FROM employees EXCEPT SELECT employee_id FROM assignments;



													-- Part 6
-- Task 6.1
SELECT employee_id FROM employees WHERE EXISTS(SELECT employee_id FROM assignments WHERE employee_id = employees.employee_id);
-- Task 6.2
SELECT * FROM employees e WHERE e.employee_id IN(SELECT employee_id FROM assignments a JOIN projects p ON a.project_id = p.project_id WHERE p.status = 'Active');
-- Task 6.3
SELECT * FROM employees WHERE salary > ANY(SELECT salary FROM employees WHERE employees.department = 'Sales');



													-- Part 7
-- Task 7.1
SELECT employees.first_name || ' ' || employees.last_name AS full_name,
	   AVG(assignments.hours_worked) AS average_worked_hours,
	   employees.salary, employees.department
  FROM employees 
  JOIN assignments ON assignments.employee_id = employees.employee_id 
  GROUP BY employees.employee_id 
  ORDER BY employees.salary DESC;

-- Task 7.2
SELECT project_name, SUM(hours_worked), COUNT(a.employee_id) AS total FROM projects p JOIN assignments a ON a.project_id = p.project_id GROUP BY p.project_id HAVING S
 UM(a.hours_worked)> 150;
-- Task 7.3
SELECT COUNT(employee_id) AS total_number_of_employees, department, AVG(salary) AS average_salary, MAX(salary) AS highest_paid,
		 (SELECT first_name || ' ' || last_name  FROM employees e2 WHERE e1.department = e2.department ORDER BY salary DESC LIMIT 1) 
		 AS highest_paid_employee_name,
		 GREATEST(AVG(salary), 30000)  AS adj_avg
		 FROM employees e1 GROUP BY department;




