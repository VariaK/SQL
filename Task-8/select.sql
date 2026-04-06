-- Use a CTE to calculate average salary per department, then select employees earning above that average.
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.employee_id, e.first_name, e.salary, d.avg_salary
FROM employees e
JOIN dept_avg d ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;

-- Use a CTE to find total salary per department, then display departments with total salary > 50,000.

WITH dept_total AS (
    SELECT department_id, SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM dept_total
WHERE total_salary > 50000;

-- Create a CTE to list employees with their department names, then filter only those with salary > 10,000.

WITH emp_dept AS (
    SELECT e.employee_id, e.first_name, e.salary, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT *
FROM emp_dept
WHERE salary > 10000;

-- Use a CTE to calculate employee count per department, then show only departments with more than 3 employees.

WITH dept_count AS (
    SELECT department_id, COUNT(*) AS emp_count
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM dept_count
WHERE emp_count > 3;

-- Break a query into CTEs to show top 3 highest-paid employees per department.

WITH ranked AS (
    SELECT employee_id, first_name, department_id, salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees
)
SELECT *
FROM ranked
WHERE rnk <= 3;

-- Display employee hierarchy (manager → employee) starting from top-level managers (manager_id IS NULL).

WITH RECURSIVE emp_hierarchy AS (
    SELECT employee_id, first_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.first_name, e.manager_id, h.level + 1
    FROM employees e
    JOIN emp_hierarchy h ON e.manager_id = h.employee_id
)
SELECT *
FROM emp_hierarchy;

-- Show the full reporting chain for a specific employee (all managers above them).

WITH RECURSIVE chain AS (
    SELECT employee_id, first_name, manager_id
    FROM employees
    WHERE employee_id = 123   -- change ID

    UNION ALL

    SELECT e.employee_id, e.first_name, e.manager_id
    FROM employees e
    JOIN chain c ON e.employee_id = c.manager_id
)
SELECT *
FROM chain;
-- Count how many employees are under each manager (direct + indirect).
WITH RECURSIVE hierarchy AS (
    SELECT employee_id, manager_id
    FROM employees

    UNION ALL

    SELECT e.employee_id, h.manager_id
    FROM employees e
    JOIN hierarchy h ON e.manager_id = h.employee_id
)
SELECT manager_id, COUNT(*) AS total_subordinates
FROM hierarchy
WHERE manager_id IS NOT NULL
GROUP BY manager_id;
-- Display hierarchy with level/depth column (CEO = level 1, subordinates = level 2, etc.).
WITH RECURSIVE emp_tree AS (
    SELECT employee_id, first_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.first_name, e.manager_id, t.level + 1
    FROM employees e
    JOIN emp_tree t ON e.manager_id = t.employee_id
)
SELECT *
FROM emp_tree;
-- Show employees along with their path
WITH RECURSIVE emp_path AS (
    SELECT employee_id, first_name, manager_id,
           CAST(first_name AS CHAR(255)) AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.first_name, e.manager_id,
           CONCAT(p.path, ' -> ', e.first_name)
    FROM employees e
    JOIN emp_path p ON e.manager_id = p.employee_id
)
SELECT *
FROM emp_path;