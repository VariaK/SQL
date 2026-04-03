SHOW tables;

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM regions;
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM dependents;

-- average salary per department
SELECT departments.department_id, department_name, AVG(salary)
FROM employees 
JOIN departments ON employees.department_id = departments.department_id
GROUP BY departments.department_id
ORDER BY departments.department_id;

-- employees whose salary is greater than the overall average salary.
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > 
    (SELECT AVG(salary) 
    FROM employees)
ORDER BY salary DESC;

-- employees whose salary is greater than the average salary of their department.
SELECT employee_id, first_name, salary, department_name
FROM employees e
join departments d
on e.department_id = d.department_id
WHERE salary>
    ( SELECT AVG(salary) FROM employees
    where department_id = e.department_id)
ORDER BY e.department_id;

-- employees who earn the highest salary in their department.

SELECT e.employee_id, e.first_name, e.salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE salary =
    (SELECT MAX(salary) FROM employees
    WHERE department_id = e.department_id)
ORDER BY e.salary DESC;

-- employees who have at least one dependent

 SELECT e.employee_id, e.first_name
 FROM employees e
 WHERE EXISTS(
    SELECT 1 FROM dependents d
    WHERE e.employee_id = d.employee_id);

-- employees who do not have dependents (use NOT EXISTS)
SELECT e.employee_id, e.first_name
FROM employees e
WHERE NOT EXISTS(
    SELECT 1 FROM dependents d
    WHERE e.employee_id = d.employee_id);
    
-- each employee along with the average salary of their department (subquery in SELECT)
SELECT e.employee_id, e.first_name, e.salary, 
    (SELECT AVG(salary) FROM employees
    WHERE department_id = e.department_id) AS avg_department_salary, 
    d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- each employee with the number of dependents they have (subquery in SELECT)

SELECT e.employee_id, e.first_name, (
    SELECT COUNT(*) FROM dependents d
    WHERE e.employee_id = d.employee_id) AS num_dependents
FROM employees e 
ORDER BY num_dependents DESC;


