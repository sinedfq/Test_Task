CREATE DATABASE IF NOT EXISTS my_database;
USE my_database;

-- Таблица customers
CREATE TABLE customers (
    cus_id INT PRIMARY KEY,
    name VARCHAR(255),
    mail VARCHAR(255),
    inn VARCHAR(255), -- предположительно исправлено с "in"
    address VARCHAR(255)
);

-- Таблица employees
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(500),
    phone VARCHAR(25),
    email VARCHAR(255), -- увеличено до 255 для email
    hired_at TIMESTAMP,
    position VARCHAR(255)
);

-- Таблица categories
CREATE TABLE categories (
    cat_id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Таблица products
CREATE TABLE products (
    prod_id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    cat_id INT,
    price DOUBLE PRECISION,
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id)
);

-- Таблица orders
CREATE TABLE orders (
    ord_id INT PRIMARY KEY,
    cus_id INT, -- исправлено с "ous_id" на "cus_id"
    status VARCHAR(255),
    emp_id INT,
    ordered_at TIMESTAMP,
    FOREIGN KEY (cus_id) REFERENCES customers(cus_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Таблица order_items (составной первичный ключ)
CREATE TABLE order_items (
    ord_id INT,
    item_id INT,
    quantity INT,
    product_id INT,
    PRIMARY KEY (ord_id, item_id),
    FOREIGN KEY (ord_id) REFERENCES orders(ord_id),
    FOREIGN KEY (product_id) REFERENCES products(prod_id)
);