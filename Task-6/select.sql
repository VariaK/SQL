-- Date & Time functions

-- employees who were hired in the last 30 years
SELECT e.employee_id, e.first_name, e.hire_date
FROM employees e
WHERE e.hire_date >= DATE_SUB(CURDATE(), INTERVAL 30 YEAR);

-- employees along with the number of days since they were hired (use DATEDIFF or equivalent)
SELECT e.employee_id, e.first_name, e.hire_date, DATEDIFF(CURDATE(), e.hire_date) AS days_since_hire
FROM employees e
ORDER BY days_since_hire DESC;

-- employees hired before 1995-01-01
SELECT e.employee_id,e.first_name,e.hire_date
FROM employees e
where e.hire_date < '1995-01-01'
ORDER BY e.hire_date DESC;

-- employees who were hired between two dates ('1995-01-01' and '1998-12-31')
SELECT e.employee_id, e.first_name, e.hire_date
FROM employees e
WHERE e.hire_date BETWEEN '1995-01-01' AND '1998-12-31'
ORDER BY e.hire_date DESC;

-- hire_date in a dd Month, YYYY format
SELECT e.employee_id, e.first_name, DATE_FORMAT(e.hire_date, '%d %M %Y'
) AS formatted_hire_date
FROM employees e
ORDER BY e.hire_date DESC;

-- employees hired in the same month as today (any year).
SELECT e.employee_id, e.first_name, e.hire_date
FROM employees e
WHERE MONTH(e.hire_date) = MONTH(CURDATE())
ORDER BY e.hire_date DESC;

-- employees along with the number of years since they were hired (use DATEDIFF or equivalent) in integers
SELECT e.employee_id, e.first_name, e.hire_date, 
    FLOOR(DATEDIFF(CURDATE(), e.hire_date) / 365)
    AS years_since_hire
FROM employees e
ORDER BY years_since_hire DESC;