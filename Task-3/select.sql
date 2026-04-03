--number of employees per department
SELECT department, count(*) as number_of_employees
from employees GROUP BY department;


-- using aggrivation functions: count, sum, avg, min, max

SELECT * FROM employees;

-- number of male and female
SELECT gender,count(*) as count_of_employees
from employees GROUP BY gender; 

-- average salary per department
SELECT department, AVG(salary) as average_salary_per_department
from employees GROUP BY department; 

-- avg salary of employees born after 1990 per department

SELECT department, AVG(salary) as average_salary_per_department
from employees WHERE birth_date > '1990-01-01' GROUP BY department;

-- Find departments with an average salary greater than 65,000
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 65000.00;