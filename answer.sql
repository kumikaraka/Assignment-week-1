-- Week 1 Database Assignment
-- Topic: Online Shop

-- Create the database and select it for use.
CREATE DATABASE IF NOT EXISTS online_shop;
USE online_shop;

-- Customers who place orders.
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products available in the shop.
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0
);

-- Orders placed by customers.
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Products included in each order.
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Add sample customers.
INSERT INTO customers (first_name, last_name, email)
VALUES
    ('Amina', 'Khan', 'amina.khan@example.com'),
    ('Daniel', 'Mensah', 'daniel.mensah@example.com');

-- Add sample products.
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
    ('Wireless Keyboard', 'Electronics', 45.99, 25),
    ('Water Bottle', 'Home and Lifestyle', 18.50, 40),
    ('Notebook', 'Stationery', 6.99, 100);

-- Add a sample order and its items.
INSERT INTO orders (customer_id, status)
VALUES (1, 'Paid');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 45.99),
    (1, 3, 2, 6.99);

-- Verify the database and view an order summary.
SHOW TABLES;

SELECT
    orders.order_id,
    CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name,
    orders.status,
    SUM(order_items.quantity * order_items.unit_price) AS order_total
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY orders.order_id, customer_name, orders.status;
