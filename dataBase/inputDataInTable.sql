-- Вставка тестовых данных для таблицы customers
INSERT INTO customers (cus_id, name, mail, inn, address) VALUES
(1, 'Иван Петров', 'ivan@mail.com', '1234567890', 'Москва, ул. Ленина 1'),
(2, 'Мария Сидорова', 'maria@mail.com', '0987654321', 'Санкт-Петербург, Невский пр. 10'),
(3, 'Алексей Иванов', 'alex@mail.com', '1122334455', 'Казань, ул. Пушкина 5');

-- Вставка данных для таблицы employees
INSERT INTO employees (emp_id, full_name, phone, email, hired_at, position) VALUES
(101, 'Ольга Смирнова', '+79161234567', 'olga@company.com', '2020-05-15 09:00:00', 'Менеджер'),
(102, 'Дмитрий Козлов', '+79031112233', 'dmitry@company.com', '2021-08-20 10:30:00', 'Аналитик'),
(103, 'Екатерина Волкова', '+79265554433', 'ekaterina@company.com', '2022-01-10 08:45:00', 'Курьер');

-- Вставка данных для таблицы categories
INSERT INTO categories (cat_id, name) VALUES
(1, 'Электроника'),
(2, 'Одежда'),
(3, 'Книги');

-- Вставка данных для таблицы products
INSERT INTO products (prod_id, name, description, cat_id, price) VALUES
(1001, 'Смартфон', 'Смартфон с OLED-экраном', 1, 29999.99),
(1002, 'Футболка', 'Хлопковая футболка', 2, 1499.99),
(1003, 'Роман "Война и мир"', 'Классическое издание', 3, 899.99),
(1004, 'Ноутбук', 'Игровой ноутбук', 1, 75999.99);

-- Вставка данных для таблицы orders
INSERT INTO orders (ord_id, cus_id, status, emp_id, ordered_at) VALUES
(5001, 1, 'Обработка', 101, '2023-10-01 14:20:00'),
(5002, 2, 'Доставлен', 103, '2023-10-02 10:15:00'),
(5003, 3, 'Отменен', 102, '2023-10-03 16:45:00');

-- Вставка данных для таблицы order_items
INSERT INTO order_items (ord_id, item_id, quantity, product_id) VALUES
(5001, 1, 1, 1001),   -- Заказ 5001: 1 смартфон
(5001, 2, 2, 1002),   -- Заказ 5001: 2 футболки
(5002, 1, 1, 1003),   -- Заказ 5002: 1 книга
(5002, 4, 3, 1003),   -- Заказ 5002: 1 книга
(5003, 1, 1, 1004);   -- Заказ 5003: 1 ноутбук (отменен)

-- Проверка данных (опционально)
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;