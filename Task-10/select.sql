
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);


CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);


CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE INDEX idx_customer_email ON customers(email);
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_product_name ON products(product_name);
CREATE INDEX idx_order_details_order ON order_details(order_id);

DELIMITER //

CREATE TRIGGER update_stock_after_order
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;

CREATE TABLE product_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    old_stock INT,
    new_stock INT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER log_stock_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.stock <> NEW.stock THEN
        INSERT INTO product_logs(product_id, old_stock, new_stock)
        VALUES (OLD.product_id, OLD.stock, NEW.stock);
    END IF;
END //

DELIMITER ;

START TRANSACTION;


INSERT INTO orders(customer_id) VALUES (1);


SET @order_id = LAST_INSERT_ID();


INSERT INTO order_details(order_id, product_id, quantity, price)
VALUES (@order_id, 1, 2, 500);

INSERT INTO order_details(order_id, product_id, quantity, price)
VALUES (@order_id, 2, 1, 300);


COMMIT;


CREATE VIEW order_summary AS
SELECT o.order_id, c.name, p.product_name, od.quantity, od.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id;

CREATE TABLE sales_summary AS
SELECT product_id, SUM(quantity) AS total_sold
FROM order_details
GROUP BY product_id;

SELECT * FROM products;
SELECT * FROM product_logs;
SELECT * FROM order_summary;
SELECT * FROM sales_summary;