-- Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create the orders table with a foreign key referencing customers
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
);

-- Insert sample data into customers (20 rows)
INSERT INTO customers (first_name, last_name, email) VALUES
    ('Alice', 'Johnson', 'alice.j@example.com'),
    ('Bob', 'Williams', 'bob.w@example.com'),
    ('Charlie', 'Brown', 'charlie.b@example.com'),
    ('Diana', 'Prince', 'diana.p@example.com'),
    ('Edward', 'Miller', 'edward.m@example.com'),
    ('Fiona', 'Davis', 'fiona.d@example.com'),
    ('George', 'Garcia', 'george.g@example.com'),
    ('Hannah', 'Rodriguez', 'hannah.r@example.com'),
    ('Ian', 'Wilson', 'ian.w@example.com'),
    ('Jane', 'Martinez', 'jane.m@example.com'),
    ('Kevin', 'Anderson', 'kevin.a@example.com'),
    ('Laura', 'Taylor', 'laura.t@example.com'),
    ('Michael', 'Thomas', 'michael.t@example.com'),
    ('Nancy', 'Hernandez', 'nancy.h@example.com'),
    ('Oscar', 'Moore', 'oscar.m@example.com'),
    ('Patricia', 'Martin', 'patricia.m@example.com'),
    ('Quentin', 'Jackson', 'quentin.j@example.com'),
    ('Rachel', 'Lee', 'rachel.l@example.com'),
    ('Samuel', 'Perez', 'samuel.p@example.com'),
    ('Tina', 'Thompson', 'tina.t@example.com');

-- Insert sample data into orders (20 rows)
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
    (1, '2023-10-01', 150.50),
    (1, '2023-10-05', 200.00),
    (2, '2023-10-02', 99.99),
    (3, '2023-10-03', 45.00),
    (4, '2023-10-04', 120.75),
    (5, '2023-10-05', 300.00),
    (6, '2023-10-06', 75.20),
    (7, '2023-10-07', 50.00),
    (8, '2023-10-08', 250.00),
    (9, '2023-10-09', 180.40),
    (10, '2023-10-10', 65.50),
    (11, '2023-10-11', 220.00),
    (12, '2023-10-12', 110.00),
    (13, '2023-10-13', 88.88),
    (14, '2023-10-14', 199.99),
    (15, '2023-10-15', 35.70),
    (1, '2023-10-16', 49.99),
    (2, '2023-10-17', 79.99),
    (18, '2023-10-18', 500.00),
    (19, '2023-10-19', 12.00);