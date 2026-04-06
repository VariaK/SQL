-- Create a procedure that takes department_id and returns all employees in that department.

DELIMITER //

CREATE PROCEDURE get_employees_by_dept(IN dept_id INT)
BEGIN
    SELECT *
    FROM employees
    WHERE department_id = dept_id;
END //

DELIMITER ;

-- Create a procedure that accepts a date range and returns employees hired within that range.

DELIMITER //

CREATE PROCEDURE get_employees_by_date(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT *
    FROM employees
    WHERE hire_date BETWEEN start_date AND end_date;
END //

DELIMITER ;
-- Write a procedure to increase salary by a given percentage for a specific department.

DELIMITER //

CREATE PROCEDURE increase_salary(IN dept_id INT, IN percent DECIMAL(5,2))
BEGIN
    UPDATE employees
    SET salary = salary + (salary * percent / 100)
    WHERE department_id = dept_id;
END //

DELIMITER ;
-- Create a procedure that returns the total salary expense of a department.

DELIMITER //

CREATE PROCEDURE dept_total_salary(IN dept_id INT)
BEGIN
    SELECT SUM(salary) AS total_salary
    FROM employees
    WHERE department_id = dept_id;
END //

DELIMITER ;

-- Write a procedure to insert a new employee with given details.

DELIMITER //

CREATE PROCEDURE add_employee(
    IN fname VARCHAR(20),
    IN lname VARCHAR(25),
    IN email VARCHAR(100),
    IN hire DATE,
    IN job INT,
    IN sal DECIMAL(8,2),
    IN dept INT
)
BEGIN
    INSERT INTO employees(first_name, last_name, email, hire_date, job_id, salary, department_id)
    VALUES (fname, lname, email, hire, job, sal, dept);
END //

DELIMITER ;

-- Create a function to calculate annual salary (monthly salary × 12).

DELIMITER //

CREATE FUNCTION annual_salary(monthly DECIMAL(8,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly * 12;
END //

DELIMITER ;

-- Write a function that returns bonus amount based on salary:

-- 20000 → 20%

-- 10000 → 10%

-- else → 5%

DELIMITER //

CREATE FUNCTION calculate_bonus(sal DECIMAL(8,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);

    IF sal > 20000 THEN
        SET bonus = sal * 0.20;
    ELSEIF sal > 10000 THEN
        SET bonus = sal * 0.10;
    ELSE
        SET bonus = sal * 0.05;
    END IF;

    RETURN bonus;
END //

DELIMITER ;

-- Create a function to return years of experience from hire_date.

DELIMITER //

CREATE FUNCTION experience_years(hire DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, hire, CURDATE());
END //

DELIMITER ;

-- Write a function that returns employee full name (first + last name).
DELIMITER //

CREATE FUNCTION full_name(fname VARCHAR(20), lname VARCHAR(25))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    RETURN CONCAT(fname, ' ', lname);
END //

DELIMITER ;

-- Create a function that categorizes salary:
-- High (>20000)
-- Medium (10000–20000)
-- Low (<10000)
DELIMITER //

CREATE FUNCTION salary_category(sal DECIMAL(8,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(10);

    IF sal > 20000 THEN
        SET category = 'High';
    ELSEIF sal >= 10000 THEN
        SET category = 'Medium';
    ELSE
        SET category = 'Low';
    END IF;

    RETURN category;
END //

DELIMITER ;