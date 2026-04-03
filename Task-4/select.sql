SELECT * FROM customers;

SELECT * FROM orders;

-- number of orders per customer
SELECT first_name, last_name, count(order_id) as number_of_orders
from customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY orders.customer_id;

-- all customers and their orders, even if they haven't placed any orders yet
SELECT customers.customer_id,customers.first_name, customers.last_name,orders.order_id
from customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;

-- customers who haven't placed any orders
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- total spending per customer
SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spending
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id ORDER BY total_spending DESC;