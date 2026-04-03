-- CREATE TABLE employees (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     first_name VARCHAR(50) NOT NULL,
--     last_name VARCHAR(50),
--     email VARCHAR(50) UNIQUE,
--     department VARCHAR(50) NOT NULL,
--     salary DECIMAL(10, 2) NOT NULL,
--     gender ENUM('Male', 'Female', 'Other') NOT NULL,
--     birth_date DATE NOT NULL
-- );
INSERT INTO employees (
        first_name,
        last_name,
        email,
        department,
        salary,
        gender,
        birth_date
    )
VALUES (
        'John',
        'Doe',
        'john.doe@example.com',
        'Engineering',
        75000.00,
        'Male',
        '1990-05-15'
    ),
    (
        'Jane',
        'Smith',
        'jane.smith@example.com',
        'Marketing',
        65000.00,
        'Female',
        '1992-08-22'
    ),
    (
        'Alice',
        'Johnson',
        'alice.johnson@example.com',
        'HR',
        60000.00,
        'Female',
        '1988-03-10'
    ),
    (
        'Bob',
        'Williams',
        'bob.williams@example.com',
        'Sales',
        70000.00,
        'Male',
        '1985-11-30'
    ),
    (
        'Charlie',
        'Brown',
        'charlie.brown@example.com',
        'Engineering',
        80000.00,
        'Male',
        '1993-01-12'
    ),
    (
        'Diana',
        'Prince',
        'diana.prince@example.com',
        'Legal',
        95000.00,
        'Female',
        '1987-02-25'
    ),
    (
        'Edward',
        'Norton',
        'edward.norton@example.com',
        'Marketing',
        62000.00,
        'Male',
        '1991-07-14'
    ),
    (
        'Fiona',
        'Gallagher',
        'fiona.gallagher@example.com',
        'Sales',
        68000.00,
        'Female',
        '1994-12-05'
    ),
    (
        'George',
        'Harrison',
        'george.harrison@example.com',
        'Engineering',
        78000.00,
        'Male',
        '1989-09-20'
    ),
    (
        'Hannah',
        'Abbott',
        'hannah.abbott@example.com',
        'HR',
        59000.00,
        'Female',
        '1995-04-18'
    );