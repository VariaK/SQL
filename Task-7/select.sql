-- Window Functions & Ranking

-- Assign a row number to each employee ordered by salary (highest first)
SELECT ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_num,
    employee_id,
    first_name,
    last_name,
    salary
FROM employees;


-- Rank employees using DENSE_RANK() and compare with RANK()
SELECT 
    e.employee_id,
    DENSE_RANK() OVER (ORDER BY e.salary DESC) AS dense_ranking,
    RANK() OVER (ORDER BY e.salary DESC) AS ranking,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id;

-- Rank employees within each department based on salary (PARTITION BY department_id)
SELECT e.employee_id, e.first_name, e.salary, d.department_name,
    RANK() OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS salary_rank
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id
  ORDER BY d.department_id, salary_rank;

-- top 3 highest-paid employees in each department
SELECT *
FROM (
    SELECT employee_id, first_name, department_name, salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees JOIN departments USING (department_id)
) t
WHERE rnk <= 3;

-- Display each employee’s salary along with the previous employee’s salary

SELECT employee_id, first_name, salary,
       LAG(salary) OVER (ORDER BY salary DESC) AS prev_salary
FROM employees;

-- Display each employee’s salary along with the next employee’s salary (use LEAD())

SELECT employee_id, first_name, salary,
       LEAD(salary) OVER (ORDER BY salary DESC) AS next_salary
FROM employees;

-- Calculate the difference between an employee’s salary and the previous salary in the same department.

SELECT employee_id, first_name, department_id, salary,
       salary - LAG(salary) OVER (PARTITION BY department_id ORDER BY salary DESC) AS diff
FROM employees;