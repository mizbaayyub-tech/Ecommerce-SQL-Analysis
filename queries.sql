-- Database Setup
CREATE DATABASE Ecommerce_SQL_Database;
USE Ecommerce_SQL_Database;

-- Tables Creation
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Mock Data Insertion
INSERT INTO users (name, email, join_date) VALUES
('Alice Smith', 'alice@email.com', '2026-01-15'),
('Bob Jones', 'bob@email.com', '2026-02-20'),
('Charlie Brown', 'charlie@email.com', '2026-03-05'),
('Diana Prince', 'diana@email.com', '2026-04-12');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 999.99),
('Smartphone', 'Electronics', 699.99),
('Coffee Maker', 'Appliances', 89.99),
('Desk Chair', 'Furniture', 150.00);

INSERT INTO orders (user_id, order_date, total_amount) VALUES
(1, '2026-05-01', 999.99),
(1, '2026-05-15', 89.99),
(2, '2026-05-16', 699.99),
(3, '2026-06-01', 150.00);

-- Analytics Queries
-- A. Avg Revenue Per User
SELECT SUM(total_amount) / COUNT(DISTINCT user_id) AS avg_revenue_per_user FROM orders;

-- B. Inner Join
SELECT u.name, o.order_id, o.order_date, o.total_amount FROM users u INNER JOIN orders o ON u.user_id = o.user_id;

-- C. Left Join
SELECT u.name, o.order_id, o.total_amount FROM users u LEFT JOIN orders o ON u.user_id = o.user_id;

-- D. Subquery
SELECT product_name, price FROM products WHERE price > (SELECT AVG(price) FROM products);

-- E. Create and Test View
CREATE VIEW high_value_orders AS SELECT order_id, user_id, total_amount FROM orders WHERE total_amount > 200.00;
SELECT * FROM high_value_orders;

-- F. Optimization Index
CREATE INDEX idx_order_user ON orders(user_id);
