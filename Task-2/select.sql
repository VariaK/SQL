SELECT DISTINCT department from employees;

SELECT *
from employees
WHERE department = 'Engineering';

SELECT *
from employees
WHERE salary >= 70000
    AND (department = 'Engineering'
    OR department = 'Sales')
ORDER BY salary DESC;

