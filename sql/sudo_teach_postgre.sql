CREATE TABLE products (
	id  		BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name 		VARCHAR(200) NOT NULL,
	category 	VARCHAR(100),
	price 		DECIMAL(10, 2) NOT NULL,
	stock 		INTEGER DEFAULT 0,
	created_at 	TIMESTAMP DEFAULT NOW()
);

INSERT INTO products (name, category, price, stock) VALUES 
	('Ноутбук ProBook',  'Электроника', 89900.00,  15),
	('Смартфон Galaxy',  'Электроника', 54900.00,   0),
	('Кресло офисное',    	'Мебель', 	24500.00,  42),
	('Наушники BeatMax', 'Электроника', 18500.00, 120),
	('Стол письменный',     'Мебель',	18700.00,   8); 

SELECT p.name, p.stock
FROM products p 
WHERE p.stock > 0;

SELECT name, category 
FROM products p 
WHERE p.category <> 'Мебель';

SELECT name, category, price 
FROM products p 
WHERE p.category = 'Электроника' 
	AND p.price < 60000;

SELECT name, category, price 
FROM products p 
WHERE p.category = 'Электроника' 
	OR p.category = 'Мебель';

SELECT name, category 
FROM products p 
WHERE NOT category = 'Электроника';

SELECT name, category, price 
FROM products p 
WHERE category = 'Электроника' AND p.price < 10000
	OR  p.category = 'Мебель';

SELECT name, category, price 
FROM products p 
WHERE (p.category = 'Электроника' OR category = 'Мебель') 
	AND p.price < 10000;

SELECT name, price 
FROM products p 
WHERE p.price BETWEEN 10000 AND 50000

SELECT name, price 
FROM products p 
WHERE price NOT BETWEEN 1000 AND 90000

SELECT name, category 
FROM products p 
WHERE category IN ('Электроника', 'Мебель', 'Одежда');

SELECT id, name, price 
FROM products p 
WHERE id IN (1, 3, 5);

SELECT name, category 
FROM products p 
WHERE p.category NOT IN ('Электроника', 'Мебель');

SELECT name, price 
FROM products p 
WHERE name ILIKE '%ноутбук%';

SELECT name, price 
FROM products p 
WHERE p."name" NOT LIKE '%Ноутбук%';

SELECT name, price 
FROM products p 
ORDER BY p.price;

SELECT name, price 
FROM products p 
ORDER BY p.price ASC;

SELECT name, price 
FROM products p 
ORDER BY p.price DESC;

SELECT name, price 
FROM products p 
ORDER BY p.name ASC;

SELECT name, price 
FROM products p 
ORDER BY p.name DESC;

SELECT name, category, price 
FROM products p 
ORDER BY category ASC, price DESC;

SELECT name, price 
FROM products p 
ORDER BY id 
LIMIT 2;

SELECT name, price 
FROM products p 
ORDER BY price DESC 
LIMIT 4;

SELECT name, 
	price, 
	stock, 
	price * stock AS total_value 
FROM products p 

SELECT 
	name AS "Название товара",
	price AS "Цена (руб)",
	stock AS "Остаток на складе"
FROM products p 
ORDER BY p.price DESC;

CREATE TABLE employees (
	id BIGSERIAL PRIMARY KEY,
	first_name  VARCHAR(100),
	last_name 	VARCHAR(100),
	department  VARCHAR(100),
	email 		VARCHAR(200),
	phone 		VARCHAR(50),
	salary 		NUMERIC(12,2)
)

CREATE TABLE orders (
	id BIGSERIAL PRIMARY KEY,
	customer_name VARCHAR(200),
	city VARCHAR(100),
	country VARCHAR(100),
	order_date DATE,
	status VARCHAR(50),
	total_amount NUMERIC(12, 2)
)

INSERT INTO products (name, category, price, stock, created_at) VALUES
('Ноутбук ProBook',      'Электроника', 89900.00, 15, '2024-01-10'),
('Смартфон Galaxy',      'Электроника', 54900.00,  0, '2024-01-15'),
('Кресло офисное',       'Мебель',      24500.00, 42, '2024-02-03'),
('Наушники BeatMax',     'Электроника',  8990.00,120, '2024-02-20'),
('Стол письменный',      'Мебель',      18700.00,  8, '2024-03-01'),
('Монитор UltraView',    'Электроника', 32990.00, 25, '2024-03-10'),
('Клавиатура Mechanic',  'Электроника',  7490.00, 60, '2024-03-15'),
('Стул офисный Basic',   'Мебель',      12990.00,  0, '2024-03-20'),
('Ноутбук AirLite',      'Электроника', 69900.00,  5, '2024-03-25'),
('Шкаф для документов',  'Мебель',      21500.00, 12, '2024-04-01');

INSERT INTO employees (first_name, last_name, department, email, phone, salary) VALUES
('Алексей',  'Иванов',    'Разработка', 'alexey.ivanov@example.com',   '+7-900-111-11-11', 120000.00),
('Елена',    'Петрова',   'Аналитика',  'elena.petrova@example.com',   '+7-900-222-22-22', 110000.00),
('Игорь',    'Сидоров',   'Тестирование','igor.sidorov@example.com',   NULL,                90000.00),
('Анна',     'Кузнецова', 'Маркетинг',  'anna.kuz@example.com',        '+7-900-333-33-33', 80000.00),
('Дмитрий',  'Орлов',     'Продажи',    'dmitry.orlov@example.com',    '+7-900-444-44-44', 85000.00),
('Евгений',  'Смирнов',   'Разработка', NULL,                          ' +7-900-555-55-55',130000.00),
('Алина',    'Федорова',  'Тестирование','alina.fedorova@example.com', NULL,                95000.00),
('Егор',     'Васильев',  'Аналитика',  'egor.vasiliev@example.com',   NULL,               100000.00),
('Ольга',    'Морозова',  'Разработка', 'olga.morozova@example.com',   '+7-900-666-66-66', 140000.00),
('Артём',    'Семенов',   'Тестирование',NULL,                         NULL,                70000.00);

INSERT INTO orders (customer_name, city, country, order_date, status, total_amount) VALUES
('Иван Иванов',      'Москва',      'Россия', '2024-01-05', 'Завершён',   15000.00),
('Пётр Петров',      'Санкт-Петербург','Россия','2024-01-20','Отменён',    22000.00),
('Мария Смирнова',   'Казань',      'Россия', '2024-02-10', 'Завершён',   34000.00),
('John Smith',       'London',      'UK',     '2024-03-05', 'Завершён',   58000.00),
('Alice Brown',      'Berlin',      'Germany','2024-03-12','Возврат',     12000.00),
('Игорь Сидоров',    'Екатеринбург','Россия', '2024-03-18','Завершён',   45000.00),
('Елена Ковалёва',   'Москва',      'Россия', '2024-03-25','Завершён',   90000.00),
('Tom Lee',          'Paris',       'France', '2024-04-02','В обработке', 27000.00),
('Сергей Павлов',    'Казань',      'Россия', '2024-04-10','Завершён',   31000.00),
('Anna Müller',      'Munich',      'Germany','2024-04-15','Завершён',   51000.00),
-- ещё немного для пагинации
('Клиент 11',        'Москва',      'Россия', '2024-03-02','Завершён',   10000.00),
('Клиент 12',        'Москва',      'Россия', '2024-03-03','Завершён',   20000.00),
('Клиент 13',        'Москва',      'Россия', '2024-03-04','Завершён',   30000.00),
('Клиент 14',        'Москва',      'Россия', '2024-03-06','Завершён',   40000.00),
('Клиент 15',        'Москва',      'Россия', '2024-03-08','Завершён',   50000.00);

SELECT p.name, p.price 
FROM products p 
WHERE p.stock = 0;

DROP TABLE products;

CREATE TABLE products (
	id  		BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name 		VARCHAR(200) NOT NULL,
	category 	VARCHAR(100),
	price 		DECIMAL(10, 2) NOT NULL,
	stock 		INTEGER DEFAULT 0,
	created_at 	TIMESTAMP DEFAULT NOW()
);

INSERT INTO products (name, category, price, stock, created_at) VALUES
('Ноутбук ProBook',      'Электроника', 89900.00, 15, '2024-01-10'),
('Смартфон Galaxy',      'Электроника', 54900.00,  0, '2024-01-15'),
('Кресло офисное',       'Мебель',      24500.00, 42, '2024-02-03'),
('Наушники BeatMax',     'Электроника',  8990.00,120, '2024-02-20'),
('Стол письменный',      'Мебель',      18700.00,  8, '2024-03-01'),
('Монитор UltraView',    'Электроника', 32990.00, 25, '2024-03-10'),
('Клавиатура Mechanic',  'Электроника',  7490.00, 60, '2024-03-15'),
('Стул офисный Basic',   'Мебель',      12990.00,  0, '2024-03-20'),
('Ноутбук AirLite',      'Электроника', 69900.00,  5, '2024-03-25'),
('Шкаф для документов',  'Мебель',      21500.00, 12, '2024-04-01');

SELECT p.name, p.price 
FROM products p 
WHERE p.stock = 0;

SELECT e.first_name, e.last_name, e.salary 
FROM employees e
WHERE e.salary > 80000 
ORDER BY e.last_name ASC;

SELECT DISTINCT p.category 
FROM products p 
ORDER BY p.category ASC;

SELECT
	p.name AS "Наименование товара", 
	p.category AS "Категория товара",
	p.price AS "Цена товара"
FROM products p 
WHERE p.category IN ("Мебель", "Электроника")
	AND p.price BETWEEN 10000 AND 30000;

SELECT * FROM products p ;

SELECT
	p.name AS "Наименование товара", 
	p.category AS "Категория товара",
	p.price AS "Цена товара"
FROM products p 
WHERE p.category IN ('Мебель', 'Электроника')
	AND p.price BETWEEN 10000 AND 30000;

SELECT *
FROM orders o
ORDER BY o.order_date DESC
LIMIT 5 OFFSET 10;

SELECT *
FROM employees AS e
WHERE
	e.phone IS NULL 
	AND e.email IS NOT NULL 
	AND e.department IN ('Разработка', 'Тестирование', 'Аналитика') 
	AND (e.first_name LIKE 'А%' OR e.first_name LIKE 'Е%')
ORDER BY e.salary DESC;

SELECT * FROM employees;

SELECT *
FROM employees AS e
WHERE
	e.phone IS NULL 
	AND e.email IS NOT NULL 
	AND e.department IN ('Разработка', 'Тестирование', 'Аналитика') 
	AND (e.first_name LIKE 'А%' OR e.first_name LIKE 'Е%')
ORDER BY e.salary DESC 
LIMIT 10;

DROP TABLE orders;

CREATE TABLE orders (
	id 			SERIAL PRIMARY KEY,
	customer 	TEXT,
	city 		TEXT,
	amount 		NUMERIC,
	status 		TEXT,
	created_at 	DATE
);

INSERT INTO orders (customer, city, amount, status, created_at) VALUES 
('Алексей',      'Москва',       1500,   'paid',       '2024-03-01'),
('Мария',        'Питер',         800,   'paid',       '2024-03-02'),
('Алексей',      'Москва',       3200,   'paid',       '2024-03-05'),
('Игорь',        'Казань',        450,   'cancelled',  '2024-03-07'),
('Мария',        'Питер',        2100,   'paid',       '2024-03-10'),
('Ольга',        'Москва',        990,   'pending',    '2024-03-11'),
('Алексей',      'Москва',        700,   'paid',       '2024-03-15'),
('Игорь',        'Казань',       1800,   'paid',       '2024-03-18'),
('Ольга',        'Москва',       4500,   'paid',       '2024-03-20'),
('Мария',        'Питер',         600,   'cancelled',  '2024-03-22');

SELECT COUNT(*) FROM orders;
SELECT COUNT(city) FROM orders;

SELECT COUNT(*) FROM orders 
WHERE status = 'paid';

SELECT COUNT(DISTINCT city) FROM orders;

SELECT SUM(amount) FROM orders;

SELECT SUM(amount) FROM orders 
WHERE status = 'paid';

SELECT SUM(amount) FROM orders 
WHERE status = 'cancelled';

SELECT SUM(amount * 0.10) AS total_commission 
FROM orders 
WHERE status = 'paid';

SELECT AVG(amount) FROM orders;

SELECT AVG(amount) FROM orders 
WHERE status = 'paid';

SELECT ROUND(AVG(amount), 2) AS avg_order 
FROM orders 
WHERE status = 'paid';

SELECT MIN(amount) FROM orders;

SELECT MAX(amount) FROM orders;

SELECT 
	MIN(amount) AS min_order,
	MAX(amount) AS max_order,
	AVG(amount) AS avg_order,
	SUM(amount) AS total_revenue,
	COUNT(*) 	AS total_orders
FROM orders 
WHERE status = 'paid';

SELECT
	MIN(created_at) AS first_order_date,
	MAX(created_at) AS last_order_date
FROM orders;

SELECT city, COUNT(*) AS order_count
FROM orders 
GROUP BY city;

SELECT city, SUM(amount) AS revenue 
FROM orders 
WHERE status = 'paid' 
GROUP BY city;

SELECT
	customer,
	COUNT(*) 				AS total_orders,
	SUM(amount) 			AS total_spent,
	ROUND(AVG(amount), 2) 	AS avg_order, 
	MAX(amount) 			AS biggest_order 
FROM orders 
GROUP BY customer 
ORDER BY total_spent DESC;

SELECT customer, city, COUNT(*) AS orders_count, SUM(amount) AS total 
FROM orders 
GROUP BY customer, city 
ORDER BY customer;

SELECT city, SUM(amount) AS revenue
FROM orders 
WHERE status = 'paid' 
GROUP BY city;

SELECT customer, SUM(amount) AS total_spent 
FROM orders 
GROUP BY customer 
HAVING SUM(amount) > 4000
ORDER BY total_spent DESC;

SELECT customer, COUNT(*) AS paid_orders, SUM(amount) AS total_spent 
FROM orders 
WHERE status = 'paid' 
GROUP BY customer 
HAVING COUNT(*) > 1 
ORDER BY paid_orders DESC;

SELECT 
	customer,
	COUNT(*) 				AS total_orders,
	SUM(amount) 			AS total_spent,
	ROUND(AVG(amount), 0) 	AS avg_order,
	MAX(amount) 			AS max_order
FROM orders 
WHERE status = 'paid' 
GROUP BY customer 
ORDER BY total_spent DESC 
LIMIT 5;

SELECT 
	city,
	COUNT(*) 				AS orders_count,
	ROUND(AVG(amount), 0) 	AS avg_check,
	SUM(amount) 			AS total_revenue
FROM orders 
WHERE status = 'paid'
GROUP BY city 
HAVING AVG(amount) > 2000 
ORDER BY avg_check DESC;

SELECT
	status,
	COUNT(*) 		AS orders_count,
	SUM(amount) 	AS total_amount,
	ROUND(
		COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders),
		1
	) 				AS chare_pct
FROM orders 
GROUP BY status 
ORDER BY orders_count DESC;

SELECT 
	customer, 
	COUNT(*) 		AS orders,
	SUM(amount) 	AS spent
FROM orders 
GROUP BY customer
HAVING COUNT(*) >= 2 
	AND SUM(amount) > 3000 
ORDER BY spent DESC;

SELECT city, SUM(amount) AS revenue 
FROM orders 
WHERE status = 'paid' 
GROUP BY ROLLUP(city)
ORDER BY city;
SELECT 
	COALESCE(city, '=== ИТОГО ===') 	AS city,
	SUM(amount) 						AS revenue
FROM orders 
WHERE status = 'paid' 
GROUP BY ROLLUP(city)
ORDER BY city;

SELECT
	COALESCE(city, '=== ВСЕГО ===') AS city,
	COALESCE(customer, '--- Итог ---') AS customer,
	SUM(amount) AS revenue 
FROM orders 
WHERE status = 'paid' 
GROUP BY ROLLUP(city, customer) 
ORDER BY city, customer;

SELECT 
	city,
	COUNT(*) 				AS paid_orders,
	SUM(amount) 			AS revenue,
	ROUND(AVG(amount), 0) 	AS avg_check
FROM orders 
WHERE status = 'paid' 
GROUP BY city 
HAVING COUNT(*) >= 2
ORDER BY revenue DESC 
LIMIT 3;

SELECT
	customer,
	status,
	COUNT(*) AS count
FROM orders 
GROUP BY customer, status 
ORDER BY customer, status;

SELECT 
	customer,
	ROUND(AVG(amount), 0) AS avg_amount
FROM orders 
GROUP BY customer
HAVING AVG(amount) > 1500
ORDER BY customer;

SELECT 
	city,
	SUM(amount) AS revenue
FROM orders
WHERE status = 'paid' 
GROUP BY city
ORDER BY revenue DESC
LIMIT 1;

SELECT
	COALESCE(city, '=== ИТОГО ===') AS city,
	SUM(amount) AS revenue
FROM orders 
WHERE status = 'paid' 
GROUP BY ROLLUP(city)
ORDER BY revenue;

SELECT 
	customer,
	COUNT(*) AS count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders WHERE status = 'paid'), 1)
FROM orders
WHERE status = 'paid'
GROUP BY customer 
ORDER BY customer;

SELECT 
	customer, 
	city, 
	COUNT(*) AS total_orders,
	COUNT(*) FILTER(WHERE status = 'paid') AS paid_orders,
	ROUND(
		COUNT(*) FILTER(WHERE status = 'paid') * 100.0 / COUNT(*),
		1
	) AS paid_percent 
FROM orders 
GROUP BY customer, city 
ORDER BY city, customer;

SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name 

SELECT * FROM products p ;


--Урок 2.3

DROP TABLE products ;
DROP TABLE employees ;
DROP TABLE orders ;

CREATE TABLE customers (
	id NUMERIC NOT NULL,
	name VARCHAR(200) NOT NULL,
	city VARCHAR(100) NOT NULL
);

INSERT INTO customers (id, name, city) VALUES
(1, 'Алексей Иванов', 	'Москва'),
(2, 'Мария Петрова', 	'Питер'),
(3, 'Дмитрий Сидоров', 	'Москва'),
(4, 'Ольга Козлова', 	'Казань'),
(5, 'Николай Фомин', 	'Екатеринбург');

CREATE TABLE orders (
	id 				NUMERIC NOT NULL,
	customer_id 	NUMERIC NOT NULL,
	product_id 		NUMERIC NOT NULL,
	quantity 		NUMERIC NOT NULL,
	order_date 		DATE
);

INSERT INTO orders (id, customer_id, product_id, quantity, order_date) VALUES 
(101, 1, 10, 2, '2024-01-05'),
(102, 1, 11, 1, '2024-01-10'),
(103, 2, 10, 3, '2024-01-12'),
(104, 3, 12, 1, '2024-01-15'),
(105, 1, 13, 5, '2024-01-20');

CREATE TABLE products (
	id NUMERIC NOT NULL,
	name VARCHAR(200) NOT NULL,
	price NUMERIC NOT NULL, 
	category_id NUMERIC NOT NULL 
);

INSERT INTO products (id, name, price, category_id) VALUES 
(10, 'Ноутбук', 	75000, 	1),
(11, 'Мышь', 		1500, 	1),
(12, 'Стол', 		12000, 	2),
(13, 'Кресло', 		18000, 	2),
(14, 'Наушники', 	5000, 	1);

CREATE TABLE categories ( 
	id NUMERIC NOT NULL, 
	name VARCHAR(200) NOT NULL 
);

INSERT INTO categories (id, name) VALUES 
(1, 'Электроника'),
(2, 'Мебель');

SELECT 
	c.name 	AS customer_name,
	c.city,
	o.id 	AS order_id,
	o.order_date 
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id;

SELECT
	c.name 	AS customer_name,
	p.name 	AS product_name,
	p.price,
	o.quantity,
	(p.price * o.quantity) AS total_sum
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
INNER JOIN products p ON p.id = o.product_id
ORDER BY c.name;

SELECT 
	c.name 	AS customer_name,
	c.city,
	o.id 	AS order_id,
	o.order_date
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
ORDER BY c.name;

SELECT
	c.name AS customer_name,
	c.city
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.id IS NULL
ORDER BY c.name;

SELECT
	p.name AS product_name,
	p.price
FROM products p
LEFT JOIN orders o ON p.id = o.product_id
WHERE o.id IS NULL
ORDER BY p.name;

SELECT
	c.name AS customer_name,
	o.id AS order_id,
	o.order_date
FROM customers c
FULL OUTER JOIN orders o ON c.id = o.customer_id
ORDER BY c.id, o.id;

SELECT
	c.name AS customer_name,
	p.name AS product_name,
	p.price
FROM customers c
CROSS JOIN products p
ORDER BY c.name, p.name;

DROP TABLE customers;

CREATE TABLE customers (
	id NUMERIC,
	name VARCHAR(200),
	city VARCHAR(100),
	referred_by NUMERIC
);

INSERT INTO customers (id, name, city, referred_by) VALUES
(1, 'Алексей Иванов', 	'Москва', NULL),
(2, 'Мария Петрова', 	'Питер', 1),
(3, 'Дмитрий Сидоров', 	'Москва', 1),
(4, 'Ольга Козлова', 	'Казань', 2),
(5, 'Николай Фомин', 	'Екатеринбург', NULL);

SELECT
	c.name AS customer_name,
	r.name AS referred_by_name
FROM customers c
LEFT JOIN customers r ON c.referred_by = r.id
ORDER BY c.name;

SELECT
	a.name AS customer_1,
	b.name AS customer_2,
	a.city
FROM customers a
INNER JOIN customers b ON a.city = b.city AND a.id < b.id
ORDER BY customer_1;

SELECT
	c.name 					AS customer_name,
	c.city,
	o.id AS order_id,
	o.order_date,
	p.name 					AS product_name,
	p.price,
	o.quantity,
	(p.price * o.quantity) 	AS line_total,
	cat.name 				AS category_name
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
INNER JOIN products p ON p.id = o.product_id
INNER JOIN categories cat ON cat.id = p.category_id
ORDER BY o.order_date;

SELECT
	cat.name 		AS category_name,
	COUNT(o.id) 	AS order_count,
	SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p ON p.id = o.product_id
INNER JOIN categories cat ON cat.id = p.category_id
GROUP BY cat.name
ORDER BY total_revenue DESC;

SELECT
	c.name 						AS customer_name,
	SUM(p.price * o.quantity) 	AS total_spent
FROM customers c
INNER JOIN orders o 		ON c.id 	= o.customer_id
INNER JOIN products p 		ON p.id 	= o.product_id
INNER JOIN categories cat 	ON cat.id 	= p.category_id
WHERE c.city = 'Москва'
	AND cat.name = 'Электроника'
GROUP BY c.name
ORDER BY total_spent DESC;

SELECT 
	c.name 		AS customer_name,
	o.id 		AS order_id,
	p.name 		AS product_name
FROM customers c
LEFT JOIN orders o 		ON c.id = o.customer_id
INNER JOIN products p 	ON p.id = o.product_id;

SELECT 
	c.name 		AS customer_name,
	o.id 		AS order_id,
	p.name 		AS product_name
FROM customers c
LEFT JOIN orders o 		ON c.id = o.customer_id
LEFT JOIN products p 	ON p.id = o.product_id;

-- НЕПРАВИЛЬНО: пытаемся получить всех клиентов,
-- но WHERE убивает строки с NULL
SELECT c.name, o.order_date
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.order_date > '2024-01-01';  -- NULL > '...' = FALSE → строка исчезает!

-- Ольга и Николай (у которых o.order_date = NULL) не попадут в результат

-- ПРАВИЛЬНО: условие на правую таблицу переносим в ON
SELECT c.name, o.order_date
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
                  AND o.order_date > '2024-01-01';
-- Теперь Ольга и Николай будут в результате с NULL в order_date

SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

SELECT 
	p.name AS product_name,
	p.price,
	cat.name AS category_name
FROM products p
INNER JOIN categories cat ON p.category_id = cat.id
ORDER BY p.name;

SELECT
	p.name AS product_name,
	p.price
FROM products p
LEFT JOIN orders o ON p.id = o.product_id
WHERE o.order_date IS NULL
ORDER BY p.name;

SELECT
	c.name AS customer_name,
	SUM(o.quantity * p.price) AS total_spent
FROM customers c
LEFT JOIN orders o 		ON c.id = o.customer_id
LEFT JOIN products p 	ON p.id = o.product_id
GROUP BY c.name
ORDER BY total_spent;

SELECT
	c.name AS customer_name,
	c.city,
	SUM(o.quantity * p.price) AS total_spent
FROM customers c
INNER JOIN orders o 		ON c.id = o.customer_id
INNER JOIN products p 	ON p.id = o.product_id
GROUP BY c.name, c.city
ORDER BY total_spent DESC
LIMIT 2;

SELECT AVG(price) FROM products;

SELECT name, price FROM products 
WHERE price < 22300;

SELECT name, price FROM products 
WHERE price < (SELECT AVG(price) FROM products);



--Урок 2.4
SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

DROP TABLE categories;
DROP TABLE customers;
DROP TABLE orders;
DROP TABLE products;

CREATE TABLE products ( 
	id SERIAL PRIMARY KEY,
	name VARCHAR(200),
	category VARCHAR(100),
	price NUMERIC
);

INSERT INTO products (name, category, price) VALUES
('Смартфон Samsung', 		'Электроника', 	45000),
('Ноутбук ASUS', 			'Электроника', 	75000),
('Наушники Sony', 			'Электроника', 	8000),
('Футболка Nike', 			'Одежда', 		3000),
('Джинсы Levi''s', 			'Одежда', 		7500),
('Кроссовки Adidas', 		'Одежда', 		12000),
('Книга "SQL для всех"', 	'Книги', 		1500),
('Книга "Python с нуля"', 	'Книги', 		1200);

CREATE TABLE customers ( 
	id SERIAL PRIMARY KEY,
	name VARCHAR(200),
	city VARCHAR(100)
);

INSERT INTO customers (name, city) VALUES 
('Алексей Иванов', 	'Москва'),
('Мария Петрова', 	'Питер'),
('Дмитрий Сидоров', 'Москва'),
('Ольга Козлова', 	'Казань'),
('Николай Фомин', 	'Екатеринбург');

CREATE TABLE orders ( 
	id SERIAL PRIMARY KEY,
	customer_id NUMERIC NOT NULL,
	product_id NUMERIC NOT NULL,
	quantity NUMERIC,
	amount NUMERIC
);

INSERT INTO orders (customer_id, product_id, quantity, amount) VALUES
(1, 1, 1, 45000),
(1, 7, 2, 3000),
(2, 2, 1, 75000),
(3, 4, 3, 9000),
(3, 5, 1, 7500),
(1, 3, 1, 8000);

SELECT name, price 
FROM products
WHERE price > (SELECT AVG(price) FROM products);

SELECT name, price
FROM products
WHERE price = (SELECT MIN(price) FROM products);

SELECT name 
FROM customers 
WHERE id IN (SELECT customer_id FROM orders);

SELECT name
FROM customers 
WHERE id NOT IN (SELECT customer_id FROM orders);

SELECT category, avg_price 
FROM ( 
	SELECT category, AVG(price) AS avg_price 
	FROM products
	GROUP BY category
) AS category_stats
WHERE avg_price > 10000;

SELECT c.name, order_totals.total 
FROM customers AS c 
JOIN ( 
	SELECT customer_id, SUM(amount) AS total 
	FROM orders 
	GROUP BY customer_id
) AS order_totals ON c.id = order_totals.customer_id 
WHERE order_totals.total > 10000
ORDER BY order_totals.total DESC;

SELECT 
	name,
	price,
	(SELECT AVG(price) FROM products) AS avg_price,
	price - (SELECT AVG(price) FROM products) AS diff_from_avg
FROM products 
ORDER BY diff_from_avg DESC;

SELECT 
	name,
	(SELECT COUNT(*) FROM orders WHERE orders.customer_id = customers.id) AS order_count
FROM customers;

SELECT p1.name, p1.category, p1.price 
FROM products AS p1
WHERE p1.price > (
	SELECT AVG(p2.price)
	FROM products AS p2
	WHERE p2.category = p1.category
)

SELECT name
FROM customers AS c
WHERE (
	SELECT MAX(amount)
	FROM orders AS o
	WHERE o.customer_id = c.id
) > 10000;

SELECT name
FROM customers AS c
WHERE EXISTS (
	SELECT 1
	FROM orders AS o
	WHERE o.customer_id = c.id
);

SELECT name 
FROM customers AS c
WHERE NOT EXISTS (
	SELECT 1
	FROM orders AS o
	WHERE o.customer_id = c.id
);

SELECT name
FROM customers AS c
WHERE EXISTS (
	SELECT 1
	FROM orders AS o
	WHERE o.customer_id = c.id
		AND o.product_id = 2
);

SELECT * FROM customers;

SELECT name FROM customers 
WHERE id IN (SELECT customer_id FROM orders);

SELECT name FROM customers AS c
WHERE EXISTS (
	SELECT 1 FROM orders AS o
	WHERE o.customer_id = c.id
);

SELECT name FROM customers
WHERE id NOT IN (1, 2, 3, NULL);

SELECT name FROM customers AS c
WHERE NOT EXISTS (
	SELECT 1 FROM orders AS o
	WHERE o.customer_id = c.id
);

SELECT name, price
FROM products
WHERE id IN (
	SELECT product_id
	FROM orders
	WHERE customer_id IN (
		SELECT id
		FROM customers
		WHERE city = 'Москва'
	)
);



--Урок 3.1
SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

CREATE TABLE sales (
	id SERIAL PRIMARY KEY,
	manager VARCHAR(100),
	department VARCHAR(20),
	amount NUMERIC
);

INSERT INTO sales (manager, department, amount) VALUES
('Алексей', 	'Север', 	5000),
('Борис', 		'Север', 	8000),
('Вера', 		'Север', 	8000),
('Григорий', 	'Юг', 		3000),
('Дарья', 		'Юг', 		7000),
('Елена', 		'Юг', 		7000),
('Жанна', 		'Юг', 		2000);

SELECT
	manager,
	department,
	amount,
	SUM(amount) OVER() AS total_sum
FROM sales;

SELECT
	manager,
	department,
	amount,
	SUM(amount) OVER (PARTITION BY department) AS dept_sum
FROM sales;

SELECT 
	manager,
	department,
	amount,
	ROW_NUMBER() OVER (PARTITION BY department ORDER BY amount DESC) AS rn
FROM sales;

SELECT
	manager,
	department,
	amount,
	ROW_NUMBER() 	OVER (PARTITION BY department ORDER BY amount DESC) 	AS row_num,
	RANK() 			OVER (PARTITION BY department ORDER BY amount DESC) 	AS rnk,
	DENSE_RANK() 	OVER (PARTITION BY department ORDER BY amount DESC)		AS dense_rnk
FROM sales;

SELECT
	manager,
	department,
	amount,
	NTILE(2) OVER (ORDER BY amount DESC) AS half
FROM sales;

SELECT
	manager,
	amount,
	NTILE(4) OVER (ORDER BY amount DESC) AS quartile
FROM sales;

SELECT
	manager,
	department,
	amount,
	ROW_NUMBER() 	OVER (PARTITION BY department ORDER BY amount DESC) AS row_num,
	RANK() 			OVER (PARTITION BY department ORDER BY amount DESC) AS rnk,
	DENSE_RANK() 	OVER (PARTITION BY department ORDER BY amount DESC) AS dense_rnk,
	NTILE(2) 		OVER (PARTITION BY department ORDER BY amount DESC) AS half,
	SUM(amount) 	OVER (PARTITION BY department) 						AS dept_total
FROM sales;




--Урок 3.2
DROP TABLE sales;

CREATE TABLE sales (
	id			INT,
	sale_date 	DATE,
	category 	VARCHAR(50),
	product 	VARCHAR(100),
	amount 		NUMERIC(10, 2)
);

INSERT INTO sales (id, sale_date, category, product, amount) VALUES
(1,  '2024-01-01', 'Электроника', 	'Наушники Sony', 	5900),
(2,  '2024-01-01', 'Электроника', 	'Клавиатура', 		3200),
(3,  '2024-01-01', 'Одежда', 		'Куртка зимняя', 	8500),
(4,  '2024-01-02', 'Электроника', 	'Мышь беспровод.', 	2100),
(5,  '2024-01-02', 'Одежда', 		'Джинсы', 			4300),
(6,  '2024-01-03', 'Электроника', 	'Наушники Sony', 	5900),
(7,  '2024-01-03', 'Электроника', 	'Монитор 27" ', 	28000),
(8,  '2024-01-03', 'Одежда', 		'Пуховик', 			12000),
(9,  '2024-01-04', 'Электроника', 	'Клавиатура', 		3200),
(10, '2024-01-04', 'Книги', 		'Clean Code', 		1200);

SELECT
	sale_date,
	SUM(amount) 												AS today_total,
	LAG(SUM(amount)) OVER (ORDER BY sale_date) 					AS yesterday_total,
	SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY sale_date) 	AS diff
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

SELECT
	sale_date,
	SUM(amount) 										AS today,
	LAG(SUM(amount), 2, 0) OVER (ORDER BY sale_date) 	AS two_days_ago,
	LEAD(SUM(amount), 1, 0) OVER (ORDER BY sale_date) 	AS tomorrow_forecast
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

SELECT
	sale_date,
	category,
	SUM(amount) 														AS today_amt,
	LAG(SUM(amount)) OVER (PARTITION BY category ORDER BY sale_date) 	AS prev_amt,
	ROUND(
		100.0 * (SUM(amount) - LAG(SUM(amount)) OVER (PARTITION BY category ORDER BY sale_date)) 
		/ NULLIF(LAG(SUM(amount)) OVER (PARTITION BY category ORDER BY sale_date), 0),
		1
	) 																	AS pct_change
FROM sales
GROUP BY sale_date, category
ORDER BY category DESC, sale_date;

SELECT
	sale_date,
	category,
	SUM(amount) 																AS daily_total,
	FIRST_VALUE(SUM(amount)) OVER (PARTITION BY category ORDER BY sale_date) 	AS first_day_total,
	ROUND(
		100.0 * SUM(amount)
		/ FIRST_VALUE(SUM(amount)) OVER (PARTITION BY category ORDER BY sale_date),
		1
	) 																			AS pct_of_first
FROM sales
GROUP BY sale_date, category
ORDER BY category DESC, sale_date;

-- НЕВЕРНО: last_value всегда равен current row
SELECT
	sale_date,
	category,
	SUM(amount) 															AS daily_total,
	LAST_VALUE(SUM(amount)) OVER (PARTITION BY category ORDER BY sale_date) AS wrong_last
FROM sales
GROUP BY sale_date, category;

-- ВЕРНО: явно расширяем фрейм до конца партиции
SELECT
	sale_date,
	category,
	SUM(amount) 	AS daily_total,
	LAST_VALUE(SUM(amount)) OVER (
		PARTITION BY category
		ORDER BY sale_date
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING -- весь диапазон!
	) 				AS true_last
FROM sales
GROUP BY sale_date, category;

SELECT
	sale_date,
	category,
	amount,
	SUM(amount) OVER (PARTITION BY category) AS category_total,
	ROUND(100.0 * amount / SUM(amount) OVER (PARTITION BY category), 2) AS pct_of_category
FROM sales
ORDER BY category DESC, sale_date;

SELECT
	sale_date,
	amount,
	SUM(amount) 	OVER (ORDER BY sale_date, id) 	AS running_total,
	COUNT(*) 		OVER (ORDER BY sale_date, id) 	AS running_count,
	AVG(amount) 	OVER (ORDER BY sale_date, id) 	AS running_avg
FROM sales
ORDER BY sale_date, id;

SELECT 
	sale_date,
	category,
	product,
	amount,
	ROUND(AVG(amount) OVER (PARTITION BY category), 2) 		AS avg_in_category,
	amount - AVG(amount) OVER (PARTITION BY category) 		AS diff_from_avg,
	CASE
		WHEN amount > AVG(amount) OVER (PARTITION BY category) THEN 'выше среднего'
		WHEN amount < AVG(amount) OVER (PARTITION BY category) THEN 'ниже среднего'
		ELSE 'равно среднему'
	END 													AS vs_avg
FROM sales
ORDER BY category, amount DESC;

SELECT
	id,
	sale_date,
	amount,
	SUM(amount) OVER (ORDER BY sale_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rows_sum
FROM sales ORDER BY sale_date, id;

SELECT
	sale_date,
	amount,
	ROUND(
		AVG(amount) OVER (
			ORDER BY sale_date
			ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		),
		2
	) AS moving_3
FROM sales
ORDER BY sale_date, id;

SELECT
	sale_date,
	amount,
	AVG(amount) OVER (
		ORDER BY sale_date, id
		ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
	) AS centered_avg
FROM sales
ORDER BY sale_date, id;

SELECT
	sale_date,
	amount,
	ROUND(
		AVG(amount) OVER (
			ORDER BY sale_date
			ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		),
		2
	) AS moving_3,
	ROUND(
		AVG(amount) OVER (
			ORDER BY sale_date, id
			ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
		),
		2
	) AS centered_avg
FROM sales
ORDER BY sale_date, id;

SELECT
	sale_date,
	product,
	amount,
	MAX(amount) OVER (
		ORDER BY sale_date, id
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS running_max
FROM sales
ORDER BY sale_date, id;

--Задача: построить дашборд продаж по дням: ежедневная выручка, скользящее среднее за 7 дней, накопительная выручка с начала периода, сравнение с предыдущим днём.

WITH daily AS (
	SELECT
		sale_date,
		SUM(amount) 	AS daily_total,
		COUNT(*) 		AS num_transactions
	FROM sales
	GROUP BY sale_date
)
SELECT
	sale_date,
	daily_total,
	num_transactions,
	
	-- Скользящее среднее за 7 дней (текущий + 6 предыдущих)
	ROUND(
		AVG(daily_total) OVER (
			ORDER BY sale_date
			ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
		),
		2
	)	AS ma_7d,
	
	-- Скользящее среднее за 30 дней
	ROUND(
		AVG(daily_total) OVER (
			ORDER BY sale_date
			ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
		),
		2
	) 															AS ma_30d,
	
	-- Накопительная выручка с начала периода
	SUM(daily_total) OVER (
		ORDER BY sale_date
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	)															AS cumulative_total,
	
	-- Изменение относительно вчера
	daily_total - LAG(daily_total) OVER (ORDER BY sale_date) 	AS day_over_day,
	
	-- процентное изменение
	ROUND(
		100.0 * (daily_total - LAG(daily_total) OVER (ORDER BY sale_date))
		/ NULLIF(CAST(LAG(daily_total) OVER (PARTITION BY sale_date) AS NUMERIC), 0),
		1
	)															AS pct_change
FROM daily
ORDER BY sale_date;



WITH daily AS (
	SELECT
		sale_date,
		SUM(amount)::NUMERIC AS daily_total, -- Явное приведение к NUMERIC
		COUNT(*) AS num_transactions
	FROM sales
	GROUP BY sale_date
)
SELECT
	sale_date,
	daily_total,
	num_transactions,
	ROUND(AVG(daily_total) OVER (ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS ma_7d,
	SUM(daily_total) OVER (ORDER BY sale_date) AS cumulative_total,
	daily_total - LAG(daily_total) OVER (ORDER BY sale_date) AS day_over_day,
	ROUND(
		(100.0 * (daily_total - LAG(daily_total) OVER (ORDER BY sale_date)))
		/ NULLIF(LAG(daily_total) OVER (ORDER BY sale_date), 0),
		1
	) AS pct_change
FROM daily
ORDER BY sale_date;



WITH daily AS (
    -- Шаг 1: агрегируем до дневного уровня
    SELECT
        sale_date,
        SUM(amount) AS daily_total,
        COUNT(*)    AS num_transactions
    FROM sales
    GROUP BY sale_date
)
SELECT
    sale_date,
    daily_total,
    num_transactions,

    -- Скользящее среднее за 7 дней (текущий + 6 предыдущих)
    ROUND(
        AVG(daily_total) OVER (
            ORDER BY sale_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    )                                                                   AS ma_7d,

    -- Скользящее среднее за 30 дней
    ROUND(
        AVG(daily_total) OVER (
            ORDER BY sale_date
            ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
        ),
        2
    )                                                                   AS ma_30d,

    -- Накопительная выручка с начала периода
    SUM(daily_total) OVER (
        ORDER BY sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                                                   AS cumulative_total,

    -- Изменение относительно вчера
    daily_total - LAG(daily_total) OVER (ORDER BY sale_date)           AS day_over_day,

    -- Процентное изменение
    ROUND(
        100.0 * (daily_total - LAG(daily_total) OVER (ORDER BY sale_date))
        / NULLIF(LAG(daily_total) OVER (ORDER BY sale_date), 0),
        1
    )                                                                   AS pct_change

FROM daily
ORDER BY sale_date;



WITH product_totals AS (
	SELECT
		category,
		product,
		SUM(amount) AS total_sales,
		DENSE_RANK() OVER (
			PARTITION BY category
			ORDER BY SUM(amount) DESC
		) AS rank_in_category
	FROM sales
	GROUP BY category, product
)
SELECT
	category,
	rank_in_category,
	product,
	total_sales
FROM product_totals
WHERE rank_in_category <= 3
ORDER BY category, rank_in_category;




WITH product_totals AS (
	SELECT
		category,
		product,
		SUM(amount) AS total_sales,
		DENSE_RANK() OVER (PARTITION BY category ORDER BY SUM(amount) DESC) AS rnk,
		SUM(SUM(amount)) OVER (PARTITION BY category) AS cat_total
	FROM sales
	GROUP BY category, product
)
SELECT
	category,
	rnk,
	product,
	total_sales,
	ROUND(100.0 * total_sales / cat_total, 1) AS pct_of_category,
	-- Сравниваем с продажами предыдущего места в том же рйтинге 
	LAG(total_sales) OVER (PARTITION BY category ORDER BY rnk) AS prev_rank_sales,
	total_sales - LAG(total_sales) OVER (PARTITION BY category ORDER BY rnk) AS gap_to_prev
FROM product_totals
WHERE rnk <= 3
ORDER BY category, rnk;




/* Продвинутые кейсы
Кейс 1: посик пропусков в датах (gaps)
Задача: найти дни, когда не было ни одной продажи. */
WITH daily AS (
	SELECT DISTINCT sale_date FROM sales
),
with_next AS (
	SELECT
		sale_date,
		LEAD(sale_date) OVER (ORDER BY sale_date) AS next_date
	FROM daily
)
SELECT
	sale_date AS last_sale_day,
	next_date AS next_sale_day,
	next_date - sale_date - 1 AS missing_days
FROM with_next
WHERE next_date - sale_date > 1; -- есть пропуск
-- Результат: покажет все "дыры" в продажах и их  длительность



-- Кейс 2: нарастающий процент (cumulative distribution вручную)
-- Какой процент продаж составляют наши топ-20% продуктов?
WITH product_sales AS (
	SELECT
		product,
		SUM(amount) AS total,
		SUM(SUM(amount)) OVER () AS grand_total,
		PERCENT_RANK() OVER (ORDER BY SUM(amount)) AS pct_rank
	FROM sales
	GROUP BY product
)
SELECT
	product,
	total,
	ROUND(100.0 * total / grand_total, 2) AS pct_of_revenue,
	ROUND(100.0 * SUM(total) OVER (ORDER BY total DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) / grand_total, 2) AS cumulative_pct
FROM product_sales
ORDER BY total DESC;
/* С помощью cumulative_pct можно найти точку, после которой накоплено 80% выручки (принцип Парето) */



-- Кейс 3: сессионный анализ (sessionization)
-- Группируем события пользователя в "сессии".
-- Новая сессия начинается, если пауза > 30 минут.
WITH events AS (
	SELECT
		uder_id,
		event_time,
		LAG(event_time) OVER (PARTITION BY user_id ORDER BY event_time) AS prev_time
	FROM user_events
),
with_session_flag AS (
	SELECT
		user_id,
		event_time,
		CASE
			WHEN prev_time IS NULL
				OR event_time - prev_time > INTERVAL '30 minutes' THEN 1
			ELSE 0
		END AS is_new_session
	FROM events
)
SELECT
	user_id,
	event_time,
	SUM(is_new_session) OVER (PARTITION BY user_id ORDER BY event_time) AS session_id
FROM with_session_flag
ORDER BY user_id, event_time;













-- Урок 3.3
SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;
-- CTE (Common Table Expressions, "обощённое табличное выражение") и рекурсия
/*Что такое CTE и зачем они нужны?
Представьте ситуацию: вы хотите найти клиентов, которые сделали больше заказов, чем в среднем по базе. Один из способов — вложенный подзапрос:*/

SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (
	SELECT AVG(cnt)
	FROM (
		SELECT COUNT(*) AS cnt
		FROM orders
		GROUP BY customer_id
	) AS sub
);


WITH order_counts AS (
	SELECT customer_id, COUNT(*) AS order_count
	FROM orders
	GROUP BY customer_id
),
avg_orders AS (
	SELECT AVG(order_count) AS avg_count
	FROM order_counts
)
SELECT customer_id, order_count
FROM order_counts
WHERE order_count > (SELECT avg_count FROM avg_orders);



-- Ещё один простой пример. Допустим, нужно найти все товары дороже средней цены:
WITH avg_price AS (
	SELECT AVG(price) AS avg_p
	FROM products
)
SELECT name, price
FROM products, avg_price
WHERE price > avg_p;



/* Разберём реальный пример. Допустим, у нас есть таблица orders с колонками customer_id, product_id, quantity и таблица products с id, name, price. Мы хотим найти клиентов, которые потратили больше 50 000 рублей суммарно: */
WITH
-- Шаг 1: считаем сумму каждого заказа
order_totals AS (
	SELECT
		o.customer_id,
		o.product_id,
		o.quantity * p.price AS total
	FROM orders o
	JOIN products p ON o.product_id = p.id
),
-- Шаг 2: суммируем по каждому клиенту
customer_spend AS (
	SELECT customer_id, SUM(total) AS total_spent
	FROM order_totals
	GROUP BY customer_id
)
-- Шаг 3: выбираем нужных клиентов
SELECT c.name, cs.total_spent
FROM customer_spend cs
JOIN customers c ON cs.customer_id = c.id
WHERE cs.total_spent > 50000
ORDER BY cs.total_spent DESC;




CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
	name		VARCHAR(100),
	POSITION	VARCHAR(100),
	manager_id	INT  -- NULL у самого главного
);

-- Заполняем данными
INSERT INTO employees VALUES
(1,  'Алексей Смирнов',   'CEO',             NULL),
(2,  'Мария Иванова',     'CTO',             1),
(3,  'Дмитрий Козлов',    'CFO',             1),
(4,  'Анна Петрова',      'Team Lead',       2),
(5,  'Игорь Сидоров',     'Team Lead',       2),
(6,  'Екатерина Новова',  'Senior Dev',      4),
(7,  'Павел Морозов',     'Junior Dev',      4),
(8,  'Светлана Орлова',   'Senior Dev',      5),
(9,  'Николай Фомин',     'Accountant',      3),
(10, 'Ольга Белова',      'Junior Dev',      5);



/* Вот как выглядит иерархия визуально:
Алексей Смирнов (CEO)
├── Мария Иванова (CTO)
│   ├── Анна Петрова (Team Lead)
│   │   ├── Екатерина Новова (Senior Dev)
│   │   └── Павел Морозов (Junior Dev)
│   └── Игорь Сидоров (Team Lead)
│       ├── Светлана Орлова (Senior Dev)
│       └── Ольга Белова (Junior Dev)
└── Дмитрий Козлов (CFO)
    └── Николай Фомин (Accountant)
*/


/*Пример 1: все подчинённые CEO
Напишем запрос, который начнёт с CEO и пройдёт вниз по всей иерархии, найдя каждого сотрудника вместе с его уровнем в компании:*/
WITH RECURSIVE org_chart AS (
	
	-- ЯКОРЬ: берём только CEO (у него нет руководителя)
	SELECT
		employee_id,
		name,
		position,
		manager_id,
		0 AS level,		-- CEO на уровне 0
		name::TEXT AS path	-- путь в иерархии
	FROM employees
	WHERE manager_id IS NULL
	
	UNION ALL
	
	-- РЕКУРСИВНЫЙ ШАГ: берём подчинённых каждого найденного сотрудника	
	SELECT
		e.employee_id,
		e.name,
		e.position,
		e.manager_id,
		org_chart.level + 1,				-- уровень увеличивется
		org_chart.path || ' → ' || e.name	-- добавляем к пути
	FROM employees e
	JOIN org_chart ON e.manager_id = org_chart.employee_id
	-- берём сотрудников, чей manager_id совпадает с ID из предыдущего шага
)
SELECT
	employee_id,
	level,
	REPEAT('  ', level) || name AS name_indent, -- отступ по уровню
	position,
	path
FROM org_chart
ORDER BY path;




-- Проверьте сами:
SELECT pg_typeof(name::varchar(100)) AS anchor_type  -- varchar(100)
FROM employees 
WHERE manager_id IS NULL;

SELECT pg_typeof('path' || ' → ' || 'name') AS recursive_type  -- varchar (без лимита)

-- Проверьте типы:
SELECT pg_typeof('test'::varchar(100));  -- → character varying(100)
SELECT pg_typeof('test'::varchar(500));  -- → character varying(500)

-- Они разные!
SELECT typname FROM pg_type 
WHERE oid IN (
  (SELECT oid FROM pg_type WHERE typname = 'varchar'),
  (SELECT oid FROM pg_type WHERE typname = 'varchar') -- тот же OID
);
-- Но длина фиксирована в каталоге типов




WITH RECURSIVE boss_chain AS (

    -- ЯКОРЬ: начинаем с самого Павла
	SELECT employee_id, name, position, manager_id, 0 AS level
	FROM employees
	WHERE employee_id = 7
	
	UNION ALL
	
    -- РЕКУРСИВНЫЙ ШАГ: поднимаемся вверх к руководителю
	SELECT e.employee_id, e.name, e.position, e.manager_id, boss_chain.level + 1
	FROM employees e
	JOIN boss_chain ON e.employee_id = boss_chain.manager_id
    -- берём запись, чей ID совпадает с manager_id текущей строки

)
SELECT level, name, position
FROM boss_chain
ORDER BY level;





/* Пример 3: подсчёт подчинённых
Комбинируем рекурсивный CTE с агрегацией: найдём количество всех подчинённых (прямых и косвенных) для каждого менеджера: */
WITH RECURSIVE all_subordinates AS (
    -- Для каждого сотрудника-менеджера находим всех его подчинённых
	SELECT manager_id, employee_id
	FROM employees
	WHERE manager_id IS NOT NULL
	
	UNION ALL
	
	SELECT s.manager_id, e.employee_id
	FROM all_subordinates s
	JOIN employees e ON e.manager_id = s.employee_id
)
SELECT
	m.name AS manager_name,
	m.position,
	COUNT(s.employee_id) AS total_subordinates
FROM employees m
LEFT JOIN all_subordinates s ON m.employee_id = s.manager_id
GROUP BY m.employee_id, m.name, m.position
HAVING COUNT(s.employee_id) > 0
ORDER BY total_subordinates DESC;









-- Урок 3.4
SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;


SELECT * FROM orders;
-- Пример 1: Категория покупки по сумме заказа
SELECT
	id,
	amount,
	CASE
		WHEN amount < 1000 THEN 'Малая покупка'
		WHEN amount < 5000 THEN 'Средняя покупка'
		WHEN amount >= 5000 THEN 'Крупная покупка'
		ELSE 'Неизвестно'
	END AS category
FROM orders;



/* Пример 2: Статус доставки */
SELECT
	id,
	status,
	CASE status
		WHEN 'new' 		THEN '🆕 Новый'
		WHEN 'shipping' THEN '🚚 В пути'
		WHEN 'done' 	THEN '✅ Выполнен'
		WHEN 'cancel' 	THEN '❌ Отменён'
		ELSE '❓ Неизвестен'
	END AS status_label
FROM orders;


/* Пример 3: CASE внутри агрегации — считаем только нужные строки */
-- Сколько заказов в каждой категории?
SELECT
	CASE
		WHEN amount < 1000 THEN 'Малая'
		WHEN amount < 5000 THEN 'Средняя'
		ELSE 'Крупная'
	END AS category,
	COUNT(*) AS orders_count,
	SUM(amount) AS total_amount
FROM orders
GROUP BY 1; -- GROUP BY по первому столбцу в SELECT



/* Пример 4: Условная сумма — «сколько потратили только активные клиенты» */
SELECT
	SUM(CASE WHEN status = 'active' THEN amount ELSE 0 END) AS active_revenue,
	SUM(CASE WHEN status != 'active' THEN amount ELSE 0 END) AS other_revenue
FROM orders;



/* COALESCE — первое ненулевое значение

Принимает несколько аргументов и возвращает первый, который не равен NULL. Идеально для подстановки значений по умолчанию. */
SELECT * FROM customers;

-- Если phone равен NULL, вернуть email; если и email NULL — вернуть 'нет контакта'
SELECT
	name,
	COALESCE(phone, email, 'нет контакта') AS contact
FROM customers;


SELECT * FROM products;
-- Заменить NULL в скидке на 0
SELECT
	product_name,
	price,
	COALESCE(discount, 0) AS discount,
	price - COALESCE(discount, 0) AS final_price
FROM products;



/* NULLIF — превратить значение в NULL

NULLIF(a, b) возвращает NULL, если a = b, иначе возвращает a. Часто используется, чтобы избежать деления на ноль. */

-- Защита от деления на ноль
SELECT
	category,
	total_sales,
	total_cost,
	total_sales / NULLIF(total_cast, 0) AS ratio  -- не упадёт с ошибкой
FROM category_stats;

-- Заменить пустую строку '' на NULL
SELECT
	name,
	NULLIF(description, '') AS description
FROM products;



/* CAST — преобразование типов

CAST(значение AS тип) явно преобразует данные из одного типа в другой. В PostgreSQL также можно использовать сокращённую запись через ::. */

-- Строку в число
SELECT CAST('42' AS INTEGER);
SELECT '42'::INTEGER; -- PostgreSQL синтаксис

-- Число в строку (для конкатенации)
SELECT 'Возраст: ' || CAST(age AS TEXT) FROM users;
SELECT 'Возраст: ' || age::TEXT FROM users;

-- Дробное число в целое
SELECT CAST(3.99 AS INTEGER); -- вернёт 3
SELECT 3.99::INTEGER;
SELECT TRUNC(3.99)::INTEGER;

-- Строку в дату
SELECT CAST('2024-01-15' AS DATE);

-- Реальный пример: в колонке price хранятся строки '1500.00'
SELECT
	name,
	CAST(price AS NUMERIC) * 1.2 AS prcie_with_vat
FROM products;
/* Запомните три функции одной фразой: COALESCE — замена NULL на значение, NULLIF — замена значения на NULL, CAST — смена типа данных. */



/* 🔡 Строковые функции
Строки — один из самых частых типов данных. SQL предоставляет богатый набор функций для работы с ними: склейки, обрезки пробелов, замены, извлечения подстрок и смены регистра. 

CONCAT — склейка строк */
SELECT * FROM customers;
-- Склеить имя и фамилию
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM users;

-- Альтернативный синтаксис через ||
SELECT first_name || ' ' || last_name AS full_name
FROM users;

-- CONCAT игнорирует NULL, а || нет (возвращает NULL при любом NULL)
SELECT CONCAT('Hello', NULL, ' World'); -- 'Hello World'
SELECT 'Hello' || NULL || 'World'; -- NULL


/* TRIM / LTRIM / RTRIM — удаление пробелов */
-- Убрать пробелы с обоих концов (самое частое использование)
SELECT TRIM('    Привет, мир!     '); -- 'Приветб мир!'

-- Только слева
SELECT LTRIM('    текст') -- 'текст'

-- Только справа
SELECT RTRIM('текст    '); -- 'текст'

-- Реальный пример: данные пришли с пробелами из формы
SELECT *
FROM users
WHERE TRIM(email) = 'user@example.com';



/* SUBSTRING — извлечение части строки

SUBSTRING(строка FROM начало FOR длина) — вырезает подстроку. Счёт начинается с 1, не с 0! */

-- Взять первые 3 символа
SELECT SUBSTRING('Привет' FROM 1 FOR 3); -- 'При'

-- Сокращённый синтаксис (в большинстве СУБД)
SELECT SUBSTR('Привет', 1, 3); -- 'При'

SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

SELECT * FROM sales;
-- Реальный пример: извлечь год из строки '2024-03-15'
SELECT SUBSTRING(sale_date::TEXT FROM 1 FOR 4) AS year
FROM sales;

-- Извлечь домен из email
SELECT
	email,
	SUBSTRING(email FROM POSITION('@' IN email) + 1) AS domain
FROM users;



/* REPLACE — замена подстроки */
-- Базовый синтаксис: REPLACE(строка, что_найти, на_что_заменить)
SELECT REPLACE('Привет, мир!', 'мир', 'SQL'); -- 'Привет, SQL!'

-- Реальный пример: убрать дефисы из телефонного номера
SELECT REPLACE(REPLACE(phone, '-', ''), ' ', '') AS clean_phone
FROM users;
-- '+7 900 123-45-67' → '+79001234567'

-- Удалить лишние символы из цены ('$1,500.00' → '1500.00')
SELECT CAST(REPLACE(REPLACE(price::TEXT, '$', ''), ',', '') AS NUMERIC)
FROM products;



/* UPPER / LOWER — регистр */
SELECT UPPER('привет'); -- 'ПРИВЕТ'
SELECT LOWER('ПРИВЕТ'); -- 'привет'

-- Реальный пример: поиск без учёта регистра
SELECT *
FROM users
WHERE LOWER(email) = LOWER('User@Example.COM');

-- Приведение имени к стандартному виду
SELECT
	UPPER(SUBSTRING(first_name FROM 1 FOR 1)) ||
	LOWER(SUBSTRING(first_name FROM 2)) AS proper_name
FROM users;

SELECT
	TRIM(CONCAT(
		UPPER(SUBSTRING(first_name FROM 1 FOR 1)),
		LOWER(SUBSTRING(first_name FROM 2)),
		' ',
		UPPER(SUBSTRING(last_name FROM 1 FOR 1)),
		LOWER(SUBSTRING(last_name FROM 2))
	)) AS full_name,
	LOWER(TRIM(email)) AS clean_email,
	REPLACE(REPLACE(phone, '-', ''), ' ', '') AS clean_phone
FROM users;



/* 🔢 Числовые функции
Финансовые расчёты, статистика, вычисление остатков — для всего этого нужны числовые функции. Разберём четыре самые важные. */
SELECT ROUND(3.7); -- 4
SELECT ROUND(3.141592, 2); -- 3.14
SELECT ROUND(1567, -2); -- 1600

SELECT CEIL(3.1); -- 4
SELECT CEIL(3.9); -- 4
SELECT CEIL(-3.1); -- -3

SELECT FLOOR(3.9); -- 3
SELECT FLOOR(3.1); -- 3
SELECT FLOOR(-3.1); -- -4

SELECT MOD(10, 3); -- 1
SELECT MOD(10, 2); -- 0
SELECT 10 % 3; -- 1

-- Пример 1: Финансовый отчёт с корректным форматом цен
SELECT
	name,
	price,
	ROUND(price * 0.2, 2) AS vat, -- НДС 20%
	ROUND(price * 1.2, 2) AS price_with_vat,
	CEIL(price / 1000) * 1000 AS price_rounded -- Округлить до 1000 вверх
FROM products;

-- Пример 2: Найти каждый второй заказ (нечётные ID)
SELECT id, customer_id, amount
FROM orders
WHERE MOD(id, 2) != 0; -- нечётные ID

-- Пример 3: Разбить данные на страницы вручную (пагинация)
SELECT
	id,
	name,
	CEIL(ROW_NUMBER() OVER (ORDER BY id) / 5.0) AS page_number
FROM products;




/* 📅 Функции дат
Даты и время — это особый тип данных, который требует специальных инструментов. Когда был сделан заказ? Сколько дней прошло с регистрации? Сколько заказов было в каждом месяце? Всё это решается функциями дат.

Примечание: примеры ниже написаны для PostgreSQL. MySQL и SQLite имеют похожий, но немного отличающийся синтаксис (например, в MySQL вместо DATE_PART используется YEAR(), MONTH()). */

-- NOW() — текущая дата и время
SELECT NOW(); -- 2026-04-30 14:22:10.648 +0300
SELECT CURRENT_DATE; -- 2026-04-30
SELECT CURRENT_TIME; -- 15:40:53 +0300


SELECT * FROM sales;
-- Заказы за последние 2 года и 120 дней
SELECT * FROM sales
WHERE sale_date >= NOW() - INTERVAL '2 years 120 days';

-- Пользователи, зарегистрированные сегодня
SELECT * FROM users
WHERE DATE(created_at) = CURRENT_DATE;



/* EXTRACT и DATE_PART — извлечь часть даты

Обе функции делают одно и то же — возвращают нужную «часть» даты (год, месяц, день, час и т.д.). EXTRACT — стандарт SQL, DATE_PART — PostgreSQL-специфичный синтаксис. */

SELECT EXTRACT(YEAR FROM NOW()); 	-- 2026
SELECT EXTRACT(MONTH FROM NOW()); 	-- 4
SELECT EXTRACT(DAY FROM NOW()); 	-- 30
SELECT EXTRACT(HOUR FROM NOW()); 	-- 15
SELECT EXTRACT(DOW FROM NOW()); 	-- 4 (четврег, 0=воскресенье)

-- Эквивалент через DATE_PART
SELECT DATE_PART('year', NOW()); -- 2026
SELECT DATE_PART('month', NOW()); -- 4

-- Реальный пример: продажи по месяцам
SELECT
	EXTRACT(YEAR FROM sale_date) 	AS year,
	EXTRACT(MONTH FROM sale_date) 	AS month,
	COUNT(*)						AS orders_count,
	SUM(amount) 					AS total_reveneue
FROM sales
GROUP BY 1, 2
ORDER BY 1, 2;



/* DATE_TRUNC — «срезать» дату до нужной точности

DATE_TRUNC обрезает дату до нужного «уровня»: год, месяц, неделя, день. Это особенно удобно при группировке — не нужно отдельно указывать YEAR и MONTH. */
SELECT DATE_TRUNC('month', '2024-03-15'::DATE);
-- 2024-03-01 00:00:00.000 +0300 (первый день месяца)

SELECT DATE_TRUNC('year', '2024-03-15'::DATE);
-- 2024-01-01 00:00:00.000 +0300 (первый день года)

SELECT DATE_TRUNC('week', '2024-03-15'::DATE);
-- 2024-03-11 00:00:00.000 +0300 (понедельник той недели)

-- Группировка заказов по дням (удобнее, чем EXTRACT по year+month+day)
SELECT
	DATE_TRUNC('day', sale_date) AS month_start,
	COUNT(*) 						AS orders_count,
	SUM(amount)						AS revenue
FROM sales
GROUP BY 1
ORDER BY 1;



/* Арифметика с датами — интервалы

К датам можно прибавлять и вычитать интервалы с помощью ключевого слова INTERVAL. */

-- Прибавить 30 дней к дате
SELECT '2024-01-01'::DATE + INTERVAL '30 days'; -- 2024-01-31 00:00:00.000

-- Вычесть 3 месяца
SELECT NOW() - INTERVAL '3 months'; -- 2026-01-30 16:13:16.364 +0300

-- Разница между датами в днях
WITH randomized_days AS (
	SELECT
		id,
		sale_date,
		(FLOOR(RANDOM() * 30) + 1) * '1 day'::INTERVAL AS days_to_deliver
	FROM sales
)
SELECT
	id,
	sale_date,
	sale_date + days_to_deliver AS delivery_date,
	days_to_deliver
FROM randomized_days;

-- Разница в часах/минутах через EXTRACT
SELECT
	EXTRACT(EPOCH FROM (ended_at - strarted_at)) / 3600 AS hour_spent
FROM sessions;

-- Заказы старше 2 лет и 120 дней
SELECT * FROM sales
WHERE sale_date < NOW() - INTERVAL '2 years 120 days';



SELECT * FROM sales;
-- Практический пример: дашборд продаж
SELECT 
	DATE_TRUNC('week', sale_date) 	AS week_start,
	COUNT(*) 						AS orders,
	SUM(amount)						AS revenue,
	ROUND(AVG(amount), 2) 			AS avg_order,
	COUNT(DISTINCT category)		AS unique_category
FROM sales
WHERE sale_date >= NOW() - INTERVAL '2 years 120 days'
GROUP BY 1
ORDER BY 1 DESC;



-- Пример 1: Отчёт по клиентам с категориями и форматированием
SELECT
	-- Форматируем имя
	TRIM(CONCAT(
		UPPER(SUBSTRING(first_name FROM 1 FOR 1)),
		LOWER(SUBSTRING(first_name FROM 2)),
		' ',
		UPPER(last_name)
	)) AS customer_name,
	
	-- Подставляем значение по умолчанию
	COALESCE(phone, email, 'нет контакта') AS contact,
	
	-- Считаем сумму заказов
	COALESCE(SUM(o.amount), 0) AS total_spent,
	
	-- Категория клиента
	CASE
		WHEN COALESCE(SUM(o.amount), 0) = 0 THEN 'Нет заказов'
		WHEN COALESCE(SUM(o.amount), 0) < 5000 THEN 'Обычный'
		WHEN COALESCE(SUM(o.amount), 0) < 20000 THEN 'Активный'
		ELSE 'VIP'
	END AS customer_tier,
	
	-- Дата последнего заказа
	MAX(o.order_date) AS last_order_date,
	
	-- Сколько дней с последнего заказа
	COALESCE(
		EXTRACT(DAY FROM NOW() - MAX(o.order_date))::INT,
		NULL,
	) AS days_since_last_order
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name, c.phone, c.email
ORDER BY total_spent DESC;



-- Пример 2: Еженедельный отчёт по продажам с прогрессом
SELECT
	DATE_TRUNC('week', order_date) 	AS week,
	COUNT(*) 						AS total_orders,
	SUM(amount)						AS revenue,
	ROUND(AVG(amount), 0) 			AS avg_check,
	
	-- Кол-во крупных заказов через CASE внутри SUM
	SUM(CASE WHEN amount >= 5000 THEN 1 ELSE 0 END) AS big_orders,
	
	-- Доля крупных заказов
	ROUND(
		100.0 * SUM(CASE WHEN amount >= 5000 THEN 1 ELSE 0 END) 
		/ NULLIF(COUNT(*), 0),
		1
	) AS bif_orders_pct
FROM orders
WHERE order_date >= DATE_TRUNC('year', NOW()) -- с начала года
GROUP BY 1
ORDER BY 1 DESC;








-- Урок 4.1
/* DML — изменяем данные
До этого момента мы только читали данные — SELECT, JOIN, агрегации. Теперь пришло время научиться данные создавать, изменять и удалять. Это четыре главных команды языка DML: INSERT, UPDATE, DELETE — и специальная конструкция UPSERT для тех случаев, когда нужно обновить или вставить сразу. */

SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM sales;



-- ✍️ INSERT — добавляем строки
/* Представьте реальную задачу: у нас есть таблица vip_customers, и мы хотим скопировать туда всех клиентов, чьи расходы превысили 100 000 рублей: */
INSERT INTO vip_customers (customer_id, name, email, total_spent)
SELECT
	c.id,
	c.name,
	c.email
	SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.id, c.name, c.email
HAVING SUM(o.amount) > 100000;



/* Другой популярный случай — создание архивных таблиц. Например, раз в месяц переносим выполненные заказы из основной таблицы в архив: */
-- Сначала вставляем в архив
INSERT INTO orders_archive
SELECT * FROM orders
WHERE status = 'completed'
	AND created_at < '2026-01-01';



-- 🔄 UPDATE — изменяем данные
/* Безопасный способ проверить UPDATE перед выполнением
Есть хорошая профессиональная привычка: прежде чем выполнить UPDATE, запустить SELECT с тем же WHERE. Так вы убедитесь, что обновите именно те строки, которые нужно: */
-- Сначала проверяем, кого затронет UPDATE
SELECT id, name, city
FROM customers
WHERE city = 'Москва' AND created_at < '2025-01-01';

-- Убедились, что всё верно? Теперь обновляем
UPDATE customers
SET is_verified = TRUE
WHERE city = 'Москва' AND created_at < '2025-01-01';



/* UPDATE с JOIN — обновляем по связанной таблице
Иногда условие обновления зависит от данных из другой таблицы. Например, мы хотим пометить клиентов как VIP, если у них есть хотя бы один заказ на сумму больше 50 000 рублей. Данные о заказах — в таблице orders, а обновить нужно таблицу customers. */
-- PostgreSQL
UPDATE customers c
SET is_vip = TRUE
FROM orders o
WHERE o.customer_id = c.id
	AND o.amount > 50000;



/* Ещё один практический пример — обновить количество товара на складе после обработки поставки. Есть таблица supply_items с новыми поступлениями, и мы хотим прибавить их к текущему остатку в products: */
-- PostgreSQL: обновляем остаток товаров по данным поставки
UPDATE products p
SET stock = p.stock + si.quantity
FROM supply_items si
WHERE si.product_id = p.id
	AND si.supply_id = 101;
	-- конкретная поставка



/* 🗑️ DELETE и TRUNCATE — удаляем данные */
-- DELETE — удаляем выборочно

-- Например, удалить клиента с конкретным ID:
DELETE FROM customers
WHERE id = 42;

-- Или удалить все заказы старше двух лет:
DELETE FROM orders
WHERE created_at < NOW() - INTERVAL '2 years';

/* 🚨 ВНИМАНИЕ: DELETE без WHERE удалит ВСЕ данные

Запрос без WHERE — это полное уничтожение содержимого таблицы:

DELETE FROM orders;  -- удалит АБСОЛЮТНО ВСЕ заказы!Скопировать
Это одна из самых дорогостоящих ошибок в работе с базами данных. Всегда проверяйте наличие WHERE. Перед выполнением запустите SELECT с тем же условием и посмотрите, сколько строк будет затронуто. */ 

/* TRUNCATE — очищаем таблицу полностью
TRUNCATE делает только одно — удаляет все строки из таблицы. Никакого WHERE у неё нет. Синтаксис: */
TRUNCATE TABLE orders;



-- ⚡ UPSERT — вставить или обновить
/* ON CONFLICT в PostgreSQL
В PostgreSQL UPSERT реализован через конструкцию ON CONFLICT, добавляемую в конец INSERT. Синтаксис: 
INSERT INTO имя_таблицы (столбцы...)
VALUES (значения...)
ON CONFLICT (столбец_с_уникальным_ключом) DO UPDATE
SET столбец = EXCLUDED.столбец; */

/* Вернёмся к нашему примеру с настройками пользователя: */
-- PostgreSQL: сохранить настройку, обновить если уже есть
INSERT INTO user_settings (user_id, theme, language, updated_at)
VALUES (123, 'light', 'ru', NOW())
ON CONFLICT (user_id) DO UPDATE
SET
	theme = EXCLUDED.theme,
	language = EXCLUDED.language,
	updated_at = EXCLUDED.updated_at;


/* Иногда при конфликте не нужно ничего обновлять — просто проигнорировать дубликат. Для этого есть DO NOTHING: */
-- Если запись уже есть - просто пропустить, не ругаться
INSERT INTO email_subscribers (email, subscribed_at)
VALUES ('user@example.com', NOW())
ON CONFLICT (email) DO NOTHING;



-- PostgreSQL: счётчик просмотров страниц
INSERT INTO page_views (page_url, view_count, lat_viewed)
VALUES ('/products/laptop-dell', 1, NOW())
ON CONFLICT (page_url) DO UPDATE
SET
	view_count = page_views.view_count + 1
	last_viewed = NOW();


/* 🧪 Практические задания
Закрепим всё, что узнали. Попробуйте выполнить следующие задания самостоятельно, прежде чем смотреть на решение. */
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM sales;

DROP TABLE products;

CREATE TABLE products (
	id  		SERIAL PRIMARY KEY,
	name 		VARCHAR(200) NOT NULL,
	category 	VARCHAR(100),
	price 		DECIMAL(10, 2) NOT NULL,
	stock 		INTEGER DEFAULT 0,
	created_at 	TIMESTAMP DEFAULT NOW()
);

INSERT INTO products (id, name, category, price, stock) VALUES 
	(1, 'Ноутбук ProBook',  'Электроника', 89900.00,  15),
	(2, 'Смартфон Galaxy',  'Электроника', 54900.00,   0),
	(3, 'Кресло офисное',    	'Мебель', 	24500.00,  42),
	(4, 'Наушники BeatMax', 'Электроника', 18500.00, 120),
	(5, 'Стол письменный',     'Мебель',	18700.00,   8);
/* Задание 1 — INSERT
Добавьте нового товара в таблицу products: название «USB-хаб», цена 1800, категория «Аксессуары», количество на складе 200. */
INSERT INTO products (name, price, category, stock) 
VALUES ('USB-хаб', 1800, 'Аксессуары', 200);



/* Задание 2 — UPDATE
Снизьте цену всех товаров категории «Аксессуары» на 5%. Сначала проверьте SELECT-запросом, какие строки будут затронуты. */
SELECT * FROM products
WHERE category = 'Аксессуары';

UPDATE products p
SET price = price * 0.95
WHERE category = 'Аксессуары';



/* Задание 3 — DELETE
Удалите все заказы со статусом «cancelled», созданные более года назад. Перед удалением проверьте их количество. */
SELECT COUNT(*) FROM orders
WHERE status = 'cancelled' AND created_at < NOW() - INTERVAL '1 year';

DELETE FROM orders
WHERE status = 'cancelled' AND created_at < NOW() - INTERVAL '1 year';



/* Задание 4 — UPSERT
Напишите запрос, который добавляет пользователя в таблицу newsletter (столбец email уникальный). Если email уже есть — обновить поле subscribed_at. */
INSERT INTO newsletter (email, subscribed_at)
VALUES ('user@example.com', NOW())
ON CONFLICT (email) DO UPDATE
SET subscribed_at = EXCLUDED.subscribed_at;









-- Урок 4.2
/* DDL — проектируем таблицы
До сих пор мы читали данные из готовых таблиц. Но кто эти таблицы создал? Как задать правильные типы данных, запретить мусорные значения и связать таблицы между собой? Всё это — DDL, язык определения данных. Именно с него начинается любая база данных, и сегодня вы научитесь проектировать таблицы с нуля — грамотно, надёжно и по-настоящему. */

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

DROP TABLE products;

/* 🏗️ CREATE TABLE — создаём таблицу */
CREATE TABLE products (
	id 		SERIAL 		PRIMARY KEY,	-- автоматически 1, 2, 3, 4...
	stock 	SMALLINT,					-- количество на складе
	views 	BIGINT DEFAULT 0			-- счётчик просмотров
);

CREATE TABLE users (
	id 			INTEGER 		PRIMARY KEY,
	username 	VARCHAR(50) 	NOT NULL,
	email	 	VARCHAR(100) 	NOT NULL UNIQUE,
	age 		INTEGER,
	created_at 	DATE 			DEFAULT CURRENT_DATE
);

DROP TABLE users;

CREATE TABLE articles (
	id		SERIAL 		 PRIMARY KEY,
	title 	VARCHAR(200) NOT NULL,		-- заголовок, не длиннее 200 символов
	slug 	VARCHAR(250) UNIQUE,		-- URL-адрес статьи, уникальный
	body	TEXT,						-- основной текст, без ограничений
	country CHAR(2)						-- код страны: 'RU', 'US', 'DE'
);

CREATE TABLE events (
	id 			SERIAL 			PRIMARY KEY,
	title 		VARCHAR(200) 	NOT NULL,
	event_date 	DATE 			NOT NULL,			-- дата события
	created_at 	TIMESTAMPTZ 	DEFAULT NOW()		-- момент создания записи
);

CREATE TABLE users (
	id 			UUID 			PRIMARY KEY DEFAULT gen_random_uuid(),
	email 		VARCHAR(100) 	NOT NULL UNIQUE,
	is_active 	BOOLEAN 		DEFAULT TRUE,
	settings 	JSONB 			DEFAULT '{}'::JSONB
);



/* 🔒 Ограничения — защищаем данные от мусора */
/* NOT NULL — поле обязательно */
CREATE TABLE orders (
	id 			SERIAL 			PRIMARY KEY,
	customer_id INTEGER 		NOT NULL,	-- заказ без покупателя невозможен
	total_price NUMERIC(12,2) 	NOT NULL,	-- сумма должна быть указана
	comment 	TEXT						-- комментарий необязателен (NULL разрешён)
);

DROP TABLE users;

/* UNIQUE — только уникальные значения */
CREATE TABLE users (
	id 			SERIAL 			PRIMARY KEY,
	email 		VARCHAR(100) 	NOT NULL UNIQUE,	-- два пользователя с одним email невозможны
	username 	VARCHAR(50) 	NOT NULL UNIQUE		-- и ник тоже уникальный
);

-- UNIQUE также можно задать для комбинации столбцов:
CREATE TABLE course_enrollments (
	user_id 	INTEGER NOT NULL,
	course_id 	INTEGER NOT NULL,
	enrolled_at TIMESTAMP DEFAULT NOW(),
	UNIQUE (user_id, course_id)		-- один пользователь не может записаться на курс дважды
);


/* DEFAULT — значение по умолчанию */
CREATE TABLE posts (
	id 				SERIAL 		 PRIMARY KEY,
	title 			VARCHAR(200) NOT NULL,
	is_published 	BOOLEAN 	 DEFAULT FALSE, 	-- черновик по умолчанию
	views 			INTEGER 	 DEFAULT 0,			-- 0 просмотров при создании
	created_at 		TIMESTAMP 	 DEFAULT NOW(),		-- текущее время
	updated_at 		TIMESTAMP 	 DEFAULT NOW()
);

-- При вставке можно не указывать поля с DEFAULT:
INSERT INTO posts (title) VALUES ('Мой первый пост');

SELECT * FROM posts;

DROP TABLE products;
/* CHECK — собственное правило проверки 
Самое гибкое ограничение. Вы пишете любое логическое выражение, и СУБД проверяет его при каждом добавлении и изменении строки. Если выражение вернёт FALSE — операция отклоняется с ошибкой. */

CREATE TABLE products (
	id 	SERIAL PRIMARY KEY,
	name 		VARCHAR(200) 	NOT NULL,
	price		NUMERIC(12,2) 	NOT NULL 	CHECK (price >= 0),	-- цена не может быть отрицательной
	discount 	NUMERIC(5,2) 				CHECK (discount BETWEEN 0 AND 100), -- скидка 0-100%
	rating		SMALLINT 					CHECK (rating >= 1 AND rating <= 5) -- оценка 1-5
);


/* Ограничению можно дать имя — это очень удобно, потому что ошибки тогда становятся понятными: */
CREATE TABLE employees (
	id 			SERIAL 			PRIMARY KEY,
	name 		VARCHAR(100) 	NOT NULL,
	salary 		NUMERIC(12,2) 	NOT NULL,
	hire_date 	DATE 			NOT NULL,
	CONSTRAINT salary_positive 	CHECK (salary > 0),
	CONSTRAINT hire_date_valid 	CHECK (hire_date >= '2000-01-01')
);


DROP TABLE categories;
/* 🔑 PRIMARY KEY — главный идентификатор строки */
-- Вариант 1: ограничение прямо у столбца (один столбец)
CREATE TABLE categories (
	id 		SERIAL 			PRIMARY KEY,
	name 	VARCHAR(100) 	NOT NULL
);


DROP TABLE order_items;
-- Вариант 2: ограничение в конце таблицы (явно, или для составного ключа)
CREATE TABLE order_items (
	order_id 	INTEGER NOT NULL,
	product_id 	INTEGER NOT NULL,
	quantity 	INTEGER NOT NULL CHECK (quantity > 0),
	PRIMARY KEY (order_id, product_id) 	-- составной ключ: пара (заказ + товар) уникальна
);

DROP TABLE users;
DROP TABLE orders;
/* 🔗 FOREIGN KEY — связываем таблицы */
/* Пример: пользователи и их заказы */
-- Сначала создаём «родительскую» таблицу
CREATE TABLE users (
	id 		SERIAL 		PRIMARY KEY,
	name 	VARCHAR(100) NOT NULL,
	email 	VARCHAR(100) NOT NULL UNIQUE
);

-- Теперь таблица заказов ссылается на пользователей
CREATE TABLE orders (
	id 				SERIAL 			PRIMARY KEY,
	customer_id 	INTEGER 		NOT NULL,
	total_price 	NUMERIC(12,2) 	NOT NULL,
	created_at 		TIMESTAMP 		DEFAULT NOW(),
	FOREIGN KEY (customer_id) REFERENCES users(id)
);

-- Пробуем вставить заказ для несуществующего пользователя:
INSERT INTO orders (customer_id, total_price) VALUES (9999, 500.00);
/* SQL Error [23503]: ОШИБКА: INSERT или UPDATE в таблице "orders" нарушает ограничение внешнего ключа "orders_customer_id_fkey"
  Подробности: Ключ (customer_id)=(9999) отсутствует в таблице "users".

Позиция ошибки: */


DROP TABLE orders;
/* Можно также записать коротче — прямо у столбца: */
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL REFERENCES users(id),
	total_price NUMERIC(12,2) NOT NULL
);



DROP TABLE orders;
/* ON DELETE — что делать при удалении родителя */
-- Пример 1: каскадное удаление (удали пользователя — удалятся все его заказы)
CREATE TABLE orders (
	id 			SERIAL 			PRIMARY KEY,
	customer_id INTEGER 		NOT NULL REFERENCES users(id) ON DELETE CASCADE,
	total_price NUMERIC(12,2) 	NOT NULL
);

DROP TABLE products;
-- Пример 2: обнуление (удали категорию — товары останутся, но без категории)
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL
);


SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

DROP TABLE users CASCADE;
DROP TABLE orders;
DROP TABLE categories CASCADE;
DROP TABLE products;
DROP TABLE order_items;

/* Аналогично существует ON UPDATE — действие при обновлении родительского ключа. Синтаксис такой же, используется реже. */
-- Полный пример: интернет-магазин
CREATE TABLE categories (
	id 		SERIAL 		PRIMARY KEY,
	name 	VARCHAR(100) NOT NULL
);


CREATE TABLE products (
	id 			SERIAL 			PRIMARY KEY,
	name 		VARCHAR(200) 	NOT NULL,
	price 		NUMERIC(12,2) 	NOT NULL CHECK (price >= 0),
	category_id INTEGER 		REFERENCES categories(id) ON DELETE SET NULL
);


CREATE TABLE users (
	id 			SERIAL 			PRIMARY KEY,
	email 		VARCHAR(100) 	NOT NULL UNIQUE,
	name 		VARCHAR(100) 	NOT NULL,
	is_active 	BOOLEAN 		DEFAULT TRUE
);

CREATE TABLE orders (
	id 			SERIAL 		PRIMARY KEY,
	customer_id INTEGER 	NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
	created_at 	TIMESTAMP 	DEFAULT NOW()
);

CREATE TABLE order_items (
	order_id	INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
	product_id	INTEGER NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
	quantity	INTEGER NOT NULL CHECK (quantity > 0),
	unit_price	NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0),
	PRIMARY KEY (order_id, product_id)
);


/* ✏️ ALTER TABLE — изменяем структуру таблицы
Таблицы редко остаются неизменными. Требования растут, появляются новые поля, старые переименовываются, нужно добавить ограничения. Команда ALTER TABLE позволяет изменять структуру уже существующей таблицы, не удаляя её и не трогая данные. */
-- Добавить столбец
-- Добавить поле "телефон" в таблицу пользователей
ALTER TABLE users
	ADD COLUMN phone VARCHAR(20);

-- Добавить с ограничением и значением по умолчанию
ALTER TABLE products
	ADD COLUMN is_active BOOLEAN DEFAULT TRUE NOT NULL;

-- Удалить поле (данные в нём будут потеряны безвозвратно!)
ALTER TABLE users
	DROP COLUMN phone;

-- Удалить вместе со всеми зависящими от него объектами (индексами, ограничениями)
ALTER TABLE users
	DROP COLUMN phone CASCADE;


SELECT * FROM users;
-- Переименовать столбец
ALTER TABLE users
	RENAME COLUMN username TO login;


-- Изменить тип (работает, если данные совместимы)
ALTER TABLE products
	ALTER COLUMN price TYPE NUMERIC(14, 2);

-- Изменить тип с преобразованием
ALTER TABLE orders
	ALTER COLUMN created_at TYPE TIMESTAMPTZ
	USING created_at AT TIME ZONE 'UTC';


-- Добавить NOT NULL
ALTER TABLE users
	ALTER COLUMN email SET NOT NULL;

-- Убрать NOT NULL
ALTER TABLE users
	ALTER COLUMN phone DROP NOT NULL;

-- Добавить CHECK с именем
ALTER TABLE products
	ADD CONSTRAINT chk_price_positive CHECK (price >= 0);

-- Удалить ограничение по имени
ALTER TABLE products
	DROP CONSTRAINT chk_price_positive;

-- Добавить UNIQUE
ALTER TABLE users
	ADD CONSTRAINT uq_users_phone UNIQUE (phone);

-- Добавить FOREIGN KEY
ALTER TABLE orders
	ADD CONSTRAINT fk_orders_customer
	FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE RESTRICT;


-- Переименовать таблицу
ALTER TABLE orders RENAME TO purchases;



/* 🗑️ DROP TABLE — удаляем таблицу
DROP TABLE полностью удаляет таблицу вместе со всеми данными. Это необратимо. Никаких подтверждений, никакой корзины — таблица просто исчезает. */
-- Удалить таблицу
DROP TABLE old_logs;

-- Удалить только если существует (не вызовет ошибку, если таблицы нет)
DROP TABLE IF EXISTS old_logs;

-- Удалить вместе со всеми зависящими объектами (внешними ключами других таблиц)
DROP TABLE users CASCADE;


-- Правильный порядок удаления (от дочерних к родительским)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS articles;



/* 🧩 Собираем всё вместе — проектируем реальную БД
Давайте спроектируем небольшую базу данных для блог-платформы. У нас будут пользователи, статьи, теги и комментарии. Применим всё, что изучили в этом уроке. */

-- 1. Пользователи
CREATE TABLE users (
	id 				SERIAL 			PRIMARY KEY,
	email 			VARCHAR(100) 	NOT NULL UNIQUE,
	display_name 	VARCHAR(80) 	NOT NULL,
	bio 			TEXT,
	is_active 		BOOLEAN 		DEFAULT TRUE,
	created_at 		TIMESTAMPTZ 	DEFAULT NOW()
);

-- 2. Статьи
CREATE TABLE articles (
	id 				SERIAL 			PRIMARY KEY,
	author_id 		INTEGER 		NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
	title 			VARCHAR(255) 	NOT NULL,
	slug 			VARCHAR(280) 	NOT NULL UNIQUE,
	body 			TEXT 			NOT NULL,
	is_published 	BOOLEAN 		DEFAULT FALSE,
	published_at 	TIMESTAMPTZ,
	created_at 		TIMESTAMPTZ 	DEFAULT NOW(),
	updated_at 		TIMESTAMPTZ 	DEFAULT NOW()
);

-- 3. Теги
CREATE TABLE tags (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

-- 4. Связь статья–тег (многие ко многим)
CREATE TABLE article_tags (
	article_id 	INTEGER NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
	tag_id		INTEGER NOT NULL REFERENCES tags(id)	 ON DELETE CASCADE,
	PRIMARY KEY (article_id, tag_id)
);

-- 5. Комментарии
CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
	article_id 	INTEGER NOT NULL REFERENCES articles(id) 	ON DELETE CASCADE,
	author_id 	INTEGER NOT NULL REFERENCES users(id) 		ON DELETE RESTRICT,
	body 		TEXT	NOT NULL CHECK (LENGTH(body) >= 1),
	created_at	TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Реакции (лайки)
CREATE TABLE reactions (
	user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
	article_id INTEGER NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
	reaction VARCHAR(20) NOT NULL CHECK (reaction IN ('like', 'dislike', 'fire')),
	PRIMARY KEY (user_id, article_id)	 -- один пользователь — одна реакция на статью
);

/* Что мы использовали:
• SERIAL PRIMARY KEY — автоинкрементные идентификаторы
• NOT NULL — обязательные поля
• UNIQUE — уникальный email и slug
• DEFAULT — автоматические значения для дат и флагов
• CHECK — валидация реакции и длины комментария
• FOREIGN KEY — связи между таблицами
• ON DELETE CASCADE / RESTRICT — каскадное поведение
• Составной PRIMARY KEY — для связующих таблиц */






-- Урок 4.3
/* Нормализация и проектирование баз данных
Хорошая база данных — это не просто набор таблиц. Это продуманная архитектура, в которой каждый факт хранится ровно один раз, данные не противоречат друг другу, и любое изменение не ломает остальное. Именно этому учит нормализация — одна из фундаментальных концепций реляционных баз данных. */

/* 📐 Требования 1NF:

Каждая ячейка содержит одно единственное, неделимое значение (атомарность).
В таблице нет повторяющихся групп столбцов.
Каждая строка уникально идентифицируется (есть первичный ключ). */

/* 📐 Вторая нормальная форма (2NF)
Для 2NF таблица уже должна находиться в 1NF. Это важный принцип: каждая последующая нормальная форма включает в себя предыдущую. Дополнительное требование 2NF звучит так: каждый неключевой столбец должен зависеть от всего первичного ключа, а не от его части.

Простыми словами: если у нас составной первичный ключ (состоит из нескольких столбцов), то все остальные столбцы должны зависеть от обоих частей ключа. Нельзя, чтобы какой-то столбец зависел только от одной части. Это называется частичной зависимостью. */

/* 📐 Третья нормальная форма (3NF)
3NF строится поверх 2NF. Дополнительное требование: ни один неключевой столбец не должен зависеть от другого неключевого столбца. Такая зависимость называется транзитивной. */

/* Вот как выглядит ER-диаграмма нашей финальной схемы в нотации «воронья лапка» (Crow's Foot Notation) — стандарт для реальных проектов: 
┌──────────────────┐         ┌──────────────────┐
│    customers     │         │      orders      │
├──────────────────┤         ├──────────────────┤
│ 🔑 customer_id   │ 1     N │ 🔑 order_id      │
│    name          ├────────►│ 🔗 customer_id   │
│    email         │         │    order_date    │
│    city          │         │                  │
└──────────────────┘         └────────┬─────────┘
                                      │ 1
                                      │
                                      │ N
                             ┌────────▼─────────┐
                             │   order_items    │
                             ├──────────────────┤
                             │ 🔑🔗 order_id    │
                             │ 🔑🔗 product_id  │
                             │     quantity     │
                             └────────┬─────────┘
                                      │ N
                                      │
                                      │ 1
┌──────────────────┐         ┌────────▼─────────┐
│    categories    │         │     products     │
├──────────────────┤         ├──────────────────┤
│ 🔑 category_id   │ 1     N │ 🔑 product_id    │
│    name          │◄────────┤ 🔗 category_id   │
│                  │         │    name          │
│                  │         │    price         │
└──────────────────┘         └──────────────────┘

Обозначения:
  🔑  — первичный ключ (Primary Key)
  🔗  — внешний ключ (Foreign Key)
  1   — сторона «один» в связи 1:N
  N   — сторона «многие» в связи 1:N
  ──► — направление внешнего ключа (многие → один) */


/* 💻 Создаём нормализованную схему в SQL
Теперь запишем нашу финальную 3NF-схему на SQL. Обратите внимание на порядок создания таблиц: сначала те, на которые ссылаются другие, потом те, которые ссылаются. */
-- 1. Сначала создаём таблицы без зависимостей
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	name 		VARCHAR(100) NOT NULL,
	email		VARCHAR(150) UNIQUE NOT NULL,
	city 		VARCHAR(100)
);

CREATE TABLE categories (
	category_id SERIAL PRIMARY KEY,
	name		VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Затем таблицы, зависящие от первых
CREATE TABLE products (
	product_id 	SERIAL PRIMARY KEY,
	name		VARCHAR(200) NOT NULL,
	category_id	INT REFERENCES categories(category_id),
	price		NUMERIC(10, 2) NOT NULL
);

CREATE TABLE orders (
	order_id 	SERIAL PRIMARY KEY,
	customer_id INT NOT NULL REFERENCES customers(customer_id),
	order_date	DATE NOT NULL DEFAULT CURRENT_DATE
);

-- 3. В последнюю очередь — таблица-связка
CREATE TABLE order_items (
	order_id 	INT NOT NULL REFERENCES orders(order_id),
	product_id 	INT NOT NULL REFERENCES products(product_id),
	quantity	INT NOT NULL CHECK(quantity > 0),
	PRIMARY KEY (order_id, product_id)
);


-- А вот запрос, который соединяет все таблицы и возвращает полную информацию о заказах:
SELECT
	o.order_id,
	o.order_date,
	c.name 			AS customer_name,
	c.city,
	p.name 			AS product_name,
	cat.name 		AS category,
	oi.quantity,
	p.price,
	(oi.quantity * p.price) AS line_total
FROM orders o
JOIN customers 	 c 	 ON o.customer_id = c.customer_id
JOIN order_items oi  ON o.order_id 	  = oi.order_id
JOIN products 	 p 	 ON oi.product_id = p.product_id
JOIN categories  cat ON p.category_id = cat.category_id
ORDER BY o.order_date DESC, o.order_id, p.name;







-- Урок 5.1
SELECT * FROM orders WHERE customer_id = 42;


ALTER TABLE orders
	ADD COLUMN status VARCHAR(100);

ALTER TABLE orders
	ALTER COLUMN status SET NOT NULL;
/* Простой индекс */
CREATE INDEX idx_orders_customer_id ON orders (customer_id);
CREATE INDEX idx_orders_customer_status ON orders (customer_id, status);


ALTER TABLE orders
	ADD COLUMN created_at DATE NOT NULL;
/* Partial Index (частичный индекс) */
-- Индексируем только неоплаченные заказы
CREATE INDEX idx_orders_unpaid ON orders (created_at)
WHERE status = 'pending';


/* Unique Index (уникальный индекс) */
CREATE UNIQUE INDEX idx_users_email ON users (email);




SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

SELECT * FROM users;
ALTER TABLE users
	ADD COLUMN name VARCHAR(100);

/* ⚠️ Когда индекс не работает */
/* 1. Функция на столбце */
-- Индекс на name НЕ будет использован:
SELECT * FROM users WHERE LOWER(name) = 'john';

-- Решение: создать функциональный индекс
CREATE INDEX idx_users_name_lower ON users (LOWER(name));


/* 2. Оператор LIKE с процентом в начале */
-- Индекс НЕ поможет:
SELECT * FROM products WHERE name LIKE '%phone%';

-- Индекс ПОМОЖЕТ (процент только в конце):
SELECT * FROM products WHERE name LIKE 'phone%';


SELECT * FROM orders;
ALTER TABLE orders
	ADD COLUMN user_id INTEGER;
/* 3. Неявное приведение типов */
-- Столбец user_id имеет тип INTEGER, а мы передаём TEXT — индекс не используется:
SELECT * FROM orders WHERE user_id = '42';

-- Правильно:
SELECT * FROM orders WHERE user_id = 42;


/* 4. Слишком мало данных в таблице
Если таблица небольшая — скажем, несколько сотен строк — PostgreSQL может решить, что последовательное сканирование быстрее, чем сначала лазить по индексу, а потом прыгать по файлу таблицы. Это нормальное поведение. Оптимизатор умный. */

/* 5. Слишком много совпадений (низкая селективность) */
-- В таблице пользователей поле is_active = true у 95% строк.
-- Индекс по is_active не поможет — выгоднее прочитать всё подряд:
SELECT * FROM users WHERE is_active = true;
/* Если индекс находит 80% строк таблицы, смысла в нём нет — разбросанные по диску чтения через индекс окажутся медленнее, чем один последовательный проход. Индексы хорошо работают по «редким» значениям. */



/* 🔬 EXPLAIN ANALYZE — читаем план запроса */
/* Давайте посмотрим на реальный пример. Таблица orders, 5 миллионов строк. Запрос без индекса: */
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id = 42;

/* Seq Scan on orders  (cost=0.00..98765.00 rows=12 width=120)
                    (actual time=0.042..1843.211 rows=12 loops=1)
  Filter: (customer_id = 42)
  Rows Removed by Filter: 4999988
Planning Time: 0.112 ms
Execution Time: 1843.289 ms */

DROP INDEX idx_orders_customer_id;
-- Теперь создадим индекс и повторим:
CREATE INDEX idx_orders_customer_id ON orders (customer_id);

EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id = 42;



/* 🚨 Типичные антипаттерны медленных запросов */
/* Антипаттерн 1: SELECT * вместо конкретных колонок */
-- Плохо: читаем все 30 колонок, хотя нужны только 2
SELECT * FROM users WHERE id = 5;

-- Хорошо:
SELECT id, email FROM users WHERE id = 5;


/* Антипаттерн 2: Вычисления в WHERE на колонке с индексом */
-- Плохо: PostgreSQL не может использовать индекс на created_at
SELECT * FROM orders WHERE DATE(created_at) = '2024-01-15';

-- Хорошо: перепиши условие так, чтобы колонка была «голой»
SELECT * FROM orders
WHERE created_at >= '2024-01-15'
	AND created_at = '2024-01-16';
-- Правило простое: не трогайте колонку в условии WHERE. Все преобразования переносите на другую сторону условия.


/* Антипаттерн 3: OR разрушает индексы */
-- Плохо: может не использовать индекс эффективно
SELECT * FROM orders WHERE customer_id = 5 OR customer_id = 10;

-- Хорошо: используй IN
SELECT * FROM orders WHERE customer_id IN (5, 10);


SELECT * FROM users;
ALTER TABLE users
	ADD COLUMN phone VARCHAR(50);
-- Ещё хуже: OR по разным колонкам
SELECT * FROM users WHERE email = 'a@b.com' OR phone = '123';
-- Для такого нужны отдельные индексы на каждую колонку


/* Антипаттерн 4: N+1 запросов */
/* -- В коде приложения: сначала получаем список заказов
orders = db.query("SELECT id FROM orders WHERE status = 'paid'")

-- Затем для каждого заказа делаем отдельный запрос — N+1!
for order in orders:
    customer = db.query(f"SELECT * FROM customers WHERE id = {order.customer_id}")

-- В коде приложения: сначала получаем список заказов
SELECT customer_id FROM orders WHERE status = 'paid';

-- Затем для каждого заказа делаем отдельный запрос — N+1!
FOR customer_id IN (SELECT customer_id FROM orders WHERE status = 'paid'):
	db.execute(f"SELECT * FROM customers c WHERE c.id = {customer_id}") */

SELECT * FROM customers;
SELECT * FROM orders;
-- Хорошо: один запрос с JOIN
SELECT o.order_id, c.name, c.email
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status = 'paid';


/* Антипаттерн 5: OFFSET для пагинации на больших таблицах */
-- Плохо: при OFFSET 100000 PostgreSQL всё равно читает 100000 строк, чтобы их пропустить
SELECT * FROM posts ORDER BY id LIMIT 20 OFFSET 100000;

-- Хорошо: keyset-пагинация (cursor-based)
-- Клиент передаёт last_id из предыдущей страницы
SELECT * FROM posts WHERE id > 100000 ORDER BY id LIMIT 20;


/* Антипаттерн 6: Слишком много индексов 
Индексы ускоряют чтение, но замедляют запись. При каждом INSERT, UPDATE или DELETE PostgreSQL должен обновить все индексы на таблице. Если у таблицы 15 индексов, каждая вставка — это 15 дополнительных операций. Создавайте индексы осмысленно, под конкретные медленные запросы. Проверяйте неиспользуемые индексы: */
-- Найти индексы, которые PostgreSQL не использует
SELECT schemaname, relname, indexrelname, idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY schemaname, relname;


SELECT * FROM products;
ALTER TABLE products
	ADD COLUMN created_at DATE;
/* 🛠 Практика: диагностируем медленный запрос
Давайте пройдём типичный процесс оптимизации от начала до конца. Есть таблица products с миллионом товаров и такой запрос: */
SELECT product_id, name, price
FROM products
WHERE category_id = 5
	AND price < 1000
ORDER BY created_at DESC
LIMIT 20;


/* Шаг 1: смотрим план */
EXPLAIN (ANALYZE, BUFFERS) SELECT product_id, name, price
FROM products
WHERE category_id = 5 AND price < 1000
ORDER BY created_at DESC LIMIT 20;

/* Limit  (cost=12.56..12.57 rows=1 width=442) (actual time=0.015..0.015 rows=0.00 loops=1)
  ->  Sort  (cost=12.56..12.57 rows=1 width=442) (actual time=0.014..0.015 rows=0.00 loops=1)
        Sort Key: created_at DESC
        Sort Method: quicksort  Memory: 25kB
        ->  Seq Scan on products  (cost=0.00..12.55 rows=1 width=442) (actual time=0.008..0.008 rows=0.00 loops=1)
              Filter: ((price < '1000'::numeric) AND (category_id = 5))
Planning:
  Buffers: shared hit=1
Planning Time: 0.127 ms
Execution Time: 0.039 ms -- у меня

Limit  (cost=23451.00..23451.05 rows=20 width=48)
       (actual time=1240.341..1240.347 rows=20 loops=1)
  ->  Sort  (cost=23451.00..23576.00 rows=50000 width=48)
            (actual time=1240.339..1240.342 rows=20 loops=1)
        Sort Key: created_at DESC
        Sort Method: external merge  Disk: 7824kB
        ->  Seq Scan on products  (cost=0.00..22000.00 rows=50000 width=48)
                                  (actual time=0.021..1100.211 rows=50000 loops=1)
              Filter: ((category_id = 5) AND (price < 1000))
              Rows Removed by Filter: 950000
Execution Time: 1241.509 ms */


/* Шаг 2: создаём индекс */
CREATE INDEX idx_products_cat_price_date
ON products (category_id, price, created_at DESC);


/* Шаг 3: проверяем результат */
EXPLAIN (ANALYZE, BUFFERS) SELECT product_id, name, price
FROM products
WHERE category_id = 5 AND price < 1000
ORDER BY created_at DESC LIMIT 20;

/* Limit  (cost=8.17..8.18 rows=1 width=442) (actual time=0.010..0.011 rows=0.00 loops=1)
  Buffers: shared hit=2
  ->  Sort  (cost=8.17..8.18 rows=1 width=442) (actual time=0.009..0.010 rows=0.00 loops=1)
        Sort Key: created_at DESC
        Sort Method: quicksort  Memory: 25kB
        Buffers: shared hit=2
        ->  Index Scan using idx_products_cat_price_date on products  (cost=0.14..8.16 rows=1 width=442) (actual time=0.003..0.003 rows=0.00 loops=1)
              Index Cond: ((category_id = 5) AND (price < '1000'::numeric))
              Index Searches: 1
              Buffers: shared hit=2
Planning:
  Buffers: shared hit=36 read=2 dirtied=2
Planning Time: 0.426 ms
Execution Time: 0.033 ms -- у меня

Index Scan using idx_products_cat_price_date on products
             (cost=0.42..98.30 rows=20 width=48)
             (actual time=0.043..0.112 rows=20 loops=1)
  Index Cond: ((category_id = 5) AND (price < 1000))
Execution Time: 0.189 ms */














CREATE TABLE accounts (
	user_id SERIAL PRIMARY KEY,
	balance NUMERIC(12, 2)
);

ALTER TABLE accounts
	ADD CONSTRAINT balance_non_negative CHECK (balance >= 0);

-- Урок 5.2
-- Транзакции

/* 🔬 ACID — четыре свойства надёжной транзакции
В теории баз данных есть аббревиатура ACID. Она описывает четыре свойства, которыми должна обладать каждая транзакция, чтобы данные оставались надёжными. Разберём каждое свойство на нашем примере с банковским переводом.

A
Atomicity — Атомарность
Слово «атом» в переводе с греческого означает «неделимый». Атомарность означает, что транзакция неделима: либо выполняются все операции внутри неё, либо ни одна. В нашем примере: либо деньги и списались, и зачислились, либо счета обоих людей остались без изменений. Не бывает ситуации, когда выполнилась только половина.

C
Consistency — Согласованность
До начала транзакции база данных находится в корректном состоянии. После завершения транзакции — тоже в корректном состоянии. Никакие правила и ограничения не нарушаются. В нашем примере: у клиента не может стать отрицательный баланс (если банк запрещает уход в минус). Если транзакция нарушила бы это правило — она просто не выполнится.

I
Isolation — Изолированность
Когда несколько транзакций выполняются одновременно, каждая из них «не видит» незавершённые изменения других. Представьте: в тот момент, когда вы переводите деньги, ваш друг одновременно тоже делает перевод. Изолированность гарантирует, что эти две операции не перемешаются и не испортят данные друг друга. О том, насколько «строго» транзакции изолированы друг от друга, мы поговорим отдельно — это называется уровнями изоляции.

D
Durability — Долговечность
Если транзакция успешно завершилась, её результат сохраняется навсегда. Даже если прямо сейчас упадёт сервер, отключится свет или рухнёт операционная система — данные не потеряются. База данных записывает подтверждённые транзакции в специальный журнал на диске, и при перезапуске восстанавливает состояние из него.

Запомните так: ACID — это четыре обещания, которые база данных даёт вашим данным. Атомарность: «всё или ничего». Согласованность: «правила всегда соблюдаются». Изолированность: «транзакции не мешают друг другу». Долговечность: «подтверждённое — навсегда». */


/* ⚙️ Управление транзакциями: BEGIN, COMMIT, ROLLBACK
Теперь посмотрим, как транзакции выглядят в SQL-коде. Для управления транзакциями есть три основные команды. Давайте разберём их на том же примере с банковским переводом.

BEGIN — начать транзакцию. Всё, что вы делаете после этой команды, является частью транзакции и не сохраняется в базу автоматически.
COMMIT — зафиксировать транзакцию. Все изменения сохраняются в базу данных окончательно. Назад дороги нет.
ROLLBACK — откатить транзакцию. Все изменения, сделанные с момента BEGIN, отменяются. База данных возвращается в то состояние, которое было до начала транзакции.
Вот как выглядит банковский перевод в коде: */

-- Начинаем транзакцию
BEGIN;

-- Шаг 1: списать деньги с отправителя
UPDATE accounts
SET balance = balance - 5000
WHERE user_id = 1;

-- Шаг 2: зачислить деньги получателю
UPDATE accounts
SET balance = balance + 5000
WHERE user_id = 2;

-- Всё прошло успешно — фиксируем
COMMIT;


/* Теперь представим, что во время выполнения что-то пошло не так. Например, у отправителя не хватает денег, или произошла ошибка подключения. В таком случае мы делаем откат: */
BEGIN;

UPDATE accounts
SET balance = balance - 5000
WHERE user_id = 1;

-- Допустим, здесь мы проверили баланс и увидели, что ушёл в минус
-- Откатываем всё назад

ROLLBACK;

-- Теперь баланс первого пользователя не изменился
-- Второй пользователь тоже ничего не получил


/* 🏷️ SAVEPOINT — точки сохранения внутри транзакции */
BEGIN;

-- Обработали первую группу платежей
UPDATE accounts SET balance = balance - 1000 WHERE user_id = 10;
UPDATE accounts SET balance = balance + 1000 WHERE user_id = 11;

-- Ставим точку сохранения
SAVEPOINT after_first_batch;

-- Обрабатываем вторую группу
UPDATE accounts SET balance = balance - 2000 WHERE user_id = 12;

-- Что-то пошло не так только во второй группе
-- Откатываемся до точки, не трогая первую группу
ROLLBACK TO SAVEPOINT after_first_batch;

-- Первая группа платежей в порядке — фиксируем её
COMMIT;


/* 💥 Deadlock — взаимная блокировка */
/* Deadlock — это ситуация, когда две (или более) транзакции бесконечно ждут друг друга, каждая удерживая блокировку, которая нужна другой. Ни одна из них не может продолжиться.

В коде это выглядит так: */
-- Транзакция 1 (выполняется в одном соединении)
BEGIN;
UPDATE accounts SET balance = balance - 5000 WHERE id = 1; -- блокирует строку id=1
-- ← здесь пауза, транзакция 2 успела заблокировать id=2
UPDATE accounts SET balance = balance + 5000 WHERE id = 2; -- ждёт, id=2 занят!

-- Транзакция 2 (выполняется в другом соединении, одновременно)
BEGIN;
UPDATE accounts SET balance = balance - 3000 WHERE id = 2; -- блокирует строку id=2
-- ← здесь пауза, транзакция 1 уже заблокировала id=1
UPDATE accounts SET balance = balance + 3000 WHERE id = 1; -- ждёт, id=1 занят!
-- Результат: обе транзакции зависли навсегда






CREATE TABLE number_of_times_I_was_distracted (
	id SERIAL PRIMARY KEY,
	by_mother BOOLEAN,
	by_father BOOLEAN,
	by_sister BOOLEAN,
	date DATE,
	time TIME
);

DROP TABLE number_of_times_I_was_distracted;

INSERT INTO number_of_times_I_was_distracted (by_mother, by_father, by_sister, date, time)
VALUES (TRUE, FALSE, FALSE, CURRENT_DATE, CURRENT_TIME);

SELECT * FROM number_of_times_I_was_distracted;

SELECT COUNT(*)
FROM number_of_times_I_was_distracted
WHERE by_mother IS TRUE;

DELETE FROM number_of_times_I_was_distracted
WHERE by_mother IS FALSE
  AND by_father IS FALSE
  AND by_sister IS FALSE;

ALTER TABLE number_of_times_I_was_distracted
ADD CONSTRAINT al_least_one_not_false
CHECK (by_mother IS TRUE OR by_father IS TRUE OR by_sister IS TRUE);









-- Урок 5.3
/* VIEW и материализованные VIEW */
/* VIEW — это не таблица с данными. Это сохранённый SQL-запрос. Каждый раз, когда вы обращаетесь к VIEW, база данных выполняет этот запрос заново и возвращает свежий результат. */

SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;

SELECT * FROM employees;

ALTER TABLE employees
	ADD COLUMN department VARCHAR(50); 


/* Создать VIEW очень просто. Вы пишете CREATE VIEW имя AS, а дальше — обычный SELECT-запрос. Вот базовый пример: у нас есть таблица employees с сотрудниками. Хотим создать представление только с теми, кто работает в отделе продаж. */
-- Создаём VIEW
CREATE VIEW sales_team AS
SELECT
	id,
	name,
	salary,
	hire_date
FROM employees
WHERE department = 'sales';

-- Теперь можем использовать как обычную таблицу
SELECT * FROM sales_team;

-- Можно фильтровать и сортировать
SELECT name, salary
FROM sales_team
WHERE salary > 80000
ORDER BY salary DESC;



SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'VIEW' 
ORDER BY t.table_schema, t.table_name;

CREATE TABLE orders_new (
	order_id 	SERIAL PRIMARY KEY,
	customer_id INT,
	user_id 	INT,
	product_id 	INT,
	city 		VARCHAR(100),
	amount 		NUMERIC,
	status 		TEXT,
	created_at 	DATE,
	order_date 	DATE
);

ALTER TABLE orders RENAME TO orders_old;
ALTER TABLE orders_new RENAME TO orders;

DROP TABLE orders;
ALTER TABLE orders_old RENAME TO orders;

ALTER TABLE orders
	ADD COLUMN product_id INT;

SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM products;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = ''
ORDER BY ordinal_position;

ALTER TABLE orders
	ADD COLUMN quantity INT CHECK (quantity > 0);

/* Попробуем сложнее. Допустим, у нас есть три таблицы: orders, customers и products. Создадим VIEW с полной информацией по активным заказам: */
CREATE VIEW active_orders AS
SELECT
	o.order_id 					AS order_id,
	c.name 					AS customer_name,
	c.email 				AS customer_email,
	p.name 				AS product,
	o.quantity,
	o.quantity * p.price 	AS total_price,
	o.created_at
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'active'
ORDER BY o.created_at DESC;


-- Теперь вместо этого монстра пишем просто:
SELECT * FROM active_orders;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'active_orders';




SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'employees';

ALTER TABLE employees
	ADD COLUMN phone VARCHAR(20);

/* Чтобы изменить VIEW, используйте CREATE OR REPLACE VIEW. Чтобы удалить — DROP VIEW: */
-- Обновить VIEW (заменить запрос внутри)
CREATE OR REPLACE VIEW sales_team AS
SELECT id, name, salary, hire_date, phone
FROM employees
WHERE department = 'sales';

-- Удалить VIEW
DROP VIEW sales_team;

-- Удалить, если существует (без ошибки)
DROP VIEW IF EXISTS sales_team;




/* ✏️ Обновляемые VIEW
В некоторых случаях через VIEW можно не только читать данные, но и изменять их: выполнять INSERT, UPDATE и DELETE. Такие VIEW называются обновляемыми.

Чтобы VIEW был обновляемым, он должен соответствовать нескольким условиям. Если хотя бы одно нарушено — VIEW становится только для чтения:

Запрос обращается ровно к одной таблице
Нет GROUP BY, HAVING, DISTINCT
Нет агрегатных функций (SUM, COUNT, MAX...)
Нет подзапросов в списке SELECT
Нет операций UNION
Пример. Создаём VIEW для активных пользователей — и он будет обновляемым, потому что запрос простой: */
-- Простой VIEW — одна таблица, никакой агрегации
CREATE VIEW active_users AS
SELECT id, name, email, created_at
FROM users
WHERE is_active = TRUE;

-- Читаем — всё как обычно
SELECT * FROM active_users;

-- Обновляем через VIEW — изменится в таблице users!
UPDATE active_users
SET name = 'Иван Иванов'
WHERE id = 7;

-- Вставляем через VIEW
INSERT INTO active_users (name, email)
VALUES ('Мария Петрова', 'maria@example.com');
-- Внимание: is_active для этой строки будет NULL,
-- а не TRUE — VIEW не подставляет значения автоматически

-- Ловушка при INSERT: если вы вставляете строку через VIEW и это поле не попадает в условие WHERE внутри VIEW — строка появится в таблице, но будет невидима через этот же VIEW. Например, вставили пользователя без is_active = TRUE — он есть в users, но active_users его не покажет.

DROP VIEW IF EXISTS active_users;

-- Чтобы защититься от таких ситуаций, в PostgreSQL есть опция WITH CHECK OPTION. Она запрещает вставлять или обновлять строки, которые не попадают под условие WHERE:
CREATE VIEW active_users AS
SELECT id, name, email
FROM users
WHERE is_active = TRUE
WITH CHECK OPTION;

-- Теперь эта вставка вызовет ОШИБКУ —
-- строка не удовлетворяет условию WHERE
INSERT INTO active_users (name, email)
VALUES ('Петр Сидоров', 'petr@example.com');
-- ERROR: new row violates check option for view "active_users"




/* ⚡ MATERIALIZED VIEW — кэш результата
Обычный VIEW пересчитывается каждый раз при обращении. Если запрос внутри сложный — JOIN на миллион строк с агрегацией — это медленно. Особенно если одни и те же данные запрашивают сотни раз в день, а они меняются редко.

MATERIALIZED VIEW решает эту проблему. Он работает иначе: при создании база данных выполняет запрос и физически сохраняет результат на диске. Дальнейшие обращения читают уже готовые данные — быстро, без повторных вычислений.

Обычный VIEW
Данные не хранятся
Запрос выполняется каждый раз
Всегда актуальные данные
Медленно на сложных запросах

MATERIALIZED VIEW
Данные сохранены на диске
Читает готовый результат
Данные устаревают до REFRESH
Быстро даже для тяжёлых запросов

Создаётся так же, как обычный VIEW, но с ключевым словом MATERIALIZED. Допустим, нам нужна ежедневная статистика продаж по категориям: */
CREATE MATERIALIZED VIEW sales_by_category AS
SELECT
	c.name 			AS category,
	COUNT(o.order_id) 	AS category_count,
	SUM(o.total) 	AS revenue,
	AVG(o.total) 	AS avg_order
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE o.status = 'completed'
GROUP BY c.name
ORDER BY revenue DESC;



SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'orders';

ALTER TABLE orders
	ADD COLUMN total INT CHECK (total >= 0);




-- Теперь этот тяжёлый запрос выполнился один раз.
-- Все последующие обращения — мгновенные:
SELECT * FROM sales_by_category;
SELECT * FROM sales_by_category WHERE revenue > 100000;


-- На материализованный VIEW можно создавать индексы — это ещё больше ускоряет поиск:
-- Индекс по категории для быстрого поиска
CREATE INDEX idx_sales_category
	ON sales_by_category (category);

-- Теперь WHERE category = '...' будет работать
-- через индекс, почти мгновенно
SELECT * FROM sales_by_category
WHERE category = 'Электроника';



/* 🔄 REFRESH MATERIALIZED VIEW — обновляем данные
Главный минус материализованного VIEW — данные в нём не обновляются автоматически. Если в таблице orders появились новые заказы, sales_by_category об этом не знает. Нужно вручную запустить обновление командой REFRESH. */ 
-- Обновить данные в материализованном VIEW
REFRESH MATERIALIZED VIEW sales_by_category;

-- Во время обычного REFRESH таблица блокируется —
-- другие запросы ждут. Если VIEW большой, это заметно.

-- Чтобы не блокировать таблицу при обновлении —
-- используйте CONCURRENTLY (нужен уникальный индекс!)
REFRESH MATERIALIZED VIEW CONCURRENTLY sales_by_category;


/* CONCURRENTLY — что это значит: при обычном REFRESH таблица полностью блокируется на время обновления. С ключом CONCURRENTLY база обновляет VIEW «в фоне», не мешая другим запросам. Но для этого на VIEW должен существовать хотя бы один уникальный индекс. */
-- Для CONCURRENTLY нужен уникальный индекс
CREATE UNIQUE INDEX idx_sales_category_unique
	ON sales_by_category (category);

-- Теперь можно обновлять без блокировки
REFRESH MATERIALIZED VIEW CONCURRENTLY sales_by_category;


/* Когда запускать REFRESH? Всё зависит от того, как часто меняются исходные данные и насколько актуальными должны быть данные в VIEW. Вот типовые стратегии:

⏰ По расписанию (cron)
Самый частый подход. Раз в час, раз в сутки — в зависимости от задачи. Идеально для отчётов и дашбордов: 0 * * * * psql -c "REFRESH MATERIALIZED VIEW sales_by_category"

🔔 После загрузки данных
Если данные загружаются пачками (например, импорт раз в день), обновляйте VIEW сразу после загрузки в конце скрипта импорта.

⚡ Через триггер
Можно настроить триггер на изменение исходной таблицы, который автоматически вызывает REFRESH. Удобно, но осторожно: если таблица меняется часто — REFRESH будет запускаться слишком часто и нагружать базу. */


/* Практический пример. У нас интернет-магазин с миллионом заказов. Пользователи на главной странице видят блок «Топ-10 товаров этого месяца». Посчитать его — тяжело: агрегация, фильтрация по датам, сортировка. Страница открывается тысячи раз в день. Данные меняются несколько раз в сутки (когда добавляются новые заказы).

Идеальное решение: MATERIALIZED VIEW + обновление по расписанию раз в час. */

CREATE MATERIALIZED VIEW top_products_this_month AS
SELECT
	p.id,
	p.title,
	p.image_url,
	COUNT(o.id) 	AS orders_count,
	SUM(o.total) 	AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.id
WHERE o.created_at >= date_trunc('month', NOW())
	AND o.status = 'completed'
GROUP BY p.id, p.title, p.image_url
ORDER BY orders_count DESC
LIMIT 10;


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'orders';

ALTER TABLE products
	RENAME COLUMN name TO title;
ALTER TABLE products
	RENAME COLUMN product_id TO id;
ALTER TABLE products
	ADD COLUMN image_url TEXT,
	ADD CONSTRAINT image_url_check CHECK (image_url ~ '^https?://');
ALTER TABLE orders
	RENAME COLUMN order_id TO id;


-- Добавить в cron — выполнять каждый час:
-- 0 * * * * psql -d mydb -c "REFRESH MATERIALIZED VIEW top_products_this_month"

-- В приложении просто:
SELECT * FROM top_products_this_month;








-- Урок 6.1
/* PostgreSQL vs MySQL vs SQLite — в чём разница
Когда вы начинаете работать с SQL, рано или поздно встаёт вопрос: а какую базу данных выбрать? PostgreSQL, MySQL, SQLite — все они говорят на SQL, но под капотом очень разные. В этом уроке разберём их архитектуру, лицензии, области применения, различия в синтаксисе и уникальные возможности каждой системы. */

/* Главное правило: SQL — это стандарт (ISO), но каждая СУБД реализует его по-своему и добавляет собственные расширения. Это называется диалектом SQL. */

/* PostgreSQL — SERIAL и SEQUENCE
В PostgreSQL автоинкремент устроен по-другому и значительно мощнее. В основе лежит объект SEQUENCE — это специальный генератор числовой последовательности, который живёт отдельно от таблицы.

Есть два способа создать автоинкремент в PostgreSQL: */
-- PostgreSQL: способ 1 — тип SERIAL (устаревший, но популярный)
-- SERIAL — это просто сокращение, которое автоматически создаёт SEQUENCE

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

-- PostgreSQL: способ 2 — GENERATED ALWAYS AS IDENTITY (современный стандарт SQL)
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	title VARCHAR(200) NOT NULL
);

-- PostgreSQL: создание SEQUENCE вручную (для нестандартных нужд)
CREATE SEQUENCE order_number_seq
	START WITH 1000
	INCREMENT BY 10
	NO MAXVALUE;

DROP TABLE IF EXISTS orders CASCADE;

CREATE TABLE orders (
	id 			INTEGER DEFAULT nextval('order_number_seq') PRIMARY KEY,
	customer 	VARCHAR(100)
);
-- Первый заказ получит id = 1000, второй = 1010, третий = 1020 и т.д.



ALTER TABLE orders
	ADD COLUMN user_id INT NOT NULL CHECK (user_id > 0);
ALTER TABLE orders
	ADD COLUMN amount INT NOT NULL CHECK (amount > 0);

/* 🔗 Различия в JOIN, LIMIT и строковых функциях
Базовый синтаксис JOIN одинаков везде: INNER JOIN, LEFT JOIN, RIGHT JOIN работают во всех трёх СУБД. Но в деталях есть различия.

FULL OUTER JOIN
FULL OUTER JOIN возвращает все строки из обеих таблиц, подставляя NULL там, где нет совпадений. Это удобно, когда нужно найти записи, у которых нет пары ни в одной таблице. */
-- PostgreSQL и MySQL 8.0+: FULL OUTER JOIN работает нативно
SELECT u.name, o.amount
FROM users u
FULL OUTER JOIN orders o ON u.id = o.user_id;



SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'products';

ALTER TABLE products
	ADD COLUMN created_at DATE;


/* LIMIT и OFFSET
Пагинация — ограничение количества строк в результате — в PostgreSQL и MySQL работает одинаково: */
-- PostgreSQL, MySQL, SQLite — всё одинаково ✅
SELECT * FROM products
ORDER BY created_at DESC
LIMIT 10 OFFSET 20; -- взять 10 строк, пропустить первые 20

-- Только в PostgreSQL также работает стандартный SQL:2008 синтаксис
SELECT * FROM products
ORDER BY created_at DESC
FETCH FIRST 10 ROWS ONLY;

-- С пропуском строк:
SELECT * FROM products
ORDER BY created_at DESC
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;




/* Строковые функции
Здесь различий больше всего. Казалось бы, «склеить две строки» — простая задача, но в MySQL и PostgreSQL/SQLite это делается по-разному: */

-- Конкатенация строк
-- PostgreSQL и SQLite: оператор ||
SELECT 'Привет, ' || name || '!' AS greeting FROM users;

-- PostgreSQL тоже поддерживает CONCAT() — лучше для переносимости
SELECT CONCAT('Привет, ', name, '!') AS greeting FROM users;


-- Длина строки (количество символов)
-- PostgreSQL:
SELECT LENGTH('Привет'); 		-- 6 (символов)
SELECT CHAR_LENGTH('Привет'); 	-- тоже 6


-- Регистр строк — работает одинаково везде
SELECT UPPER('hello'); -- 'HELLO'
SELECT LOWER('WORLD'); -- 'world'

-- Обрезка пробелов
SELECT TRIM('  пробелы   ');		-- 'пробелы' (везде)
SELECT LTRIM('    слева');			-- 'слева'   (везде)
SELECT RTRIM('справа     ');		-- 'справа'  (везде)


-- Подстрока — немного отличается
-- PostgreSQL и SQLite:
SELECT SUBSTRING('Привет мир', 1, 6); -- 'Привет'

-- PostgreSQL дополнительно поддерживает синтаксис с FROM/FOR:
SELECT SUBSTRING('Привет мир' FROM 1 FOR 6); -- 'Привет'



ALTER TABLE users
	RENAME TO users_old_version;



/* ✨ Уникальные возможности PostgreSQL
PostgreSQL часто называют «самой продвинутой open-source СУБД в мире» — и не без причины. В нём есть возможности, которых нет в MySQL или SQLite вообще, либо они там значительно слабее. */

/* 1. JSONB — мощная работа с JSON
В современных приложениях часто нужно хранить гибкие, нестандартизированные данные — настройки пользователя, дополнительные поля, метаданные. Классически для этого использовали отдельные таблицы, но PostgreSQL предлагает элегантный способ: хранить JSON прямо в столбце и делать по нему быстрые запросы.

В PostgreSQL есть два JSON-типа: JSON и JSONB. Тип JSON хранит данные как есть в виде текста. Тип JSONB («Binary JSON») хранит разобранный JSON в бинарном формате, что позволяет создавать по нему индексы и делать быстрые запросы. Всегда используйте JSONB — он быстрее при чтении. */

-- PostgreSQL: создаём таблицу с JSONB столбцом
CREATE TABLE users (
	id 			SERIAL PRIMARY KEY,
	name 		VARCHAR(100),
	settings 	JSONB
);

-- Вставляем данные с JSON
INSERT INTO users (name, settings) VALUES
	('Иван', '{"theme": "dark", "lang": "ru", "notifications": true}'),
	('Мария', '{"theme": "light", "lang": "en", "notifications": false}');

-- Извлечь значение по ключу (оператор ->)
SELECT name, settings -> 'theme' AS theme FROM users;
-- Результат: "dark", "light" (с кавычками, как JSON)

-- Извлечь как текст (оператор ->>)
SELECT name, settings ->> 'theme' AS theme FROM users;
-- Результат: dark, light (без кавычек)

-- Фильтрация по значению внутри JSON
SELECT name FROM users
WHERE settings ->> 'theme' = 'dark';

-- Проверить наличие ключа (оператор ?)
SELECT name FROM users
WHERE settings ? 'notifications';

-- Обновить одно поле внутри JSON без перезаписи всего объекта
UPDATE users
SET settings = settings || '{"lang": "de"}'
WHERE name = 'Иван';

-- Создать GIN индекс для быстрых запросов по всему JSONB
CREATE INDEX idx_users_settings ON users USING GIN (settings);

SELECT * FROM users;




SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'articles';

/* 2. Массивы (Array Types)
PostgreSQL позволяет хранить в одном столбце массив значений. Представьте: пользователь выбирает несколько любимых жанров музыки, или у товара несколько тегов. В обычной реляционной схеме нужно создавать отдельную таблицу. В PostgreSQL можно хранить прямо в строке. */
-- PostgreSQL: столбец-массив
CREATE TABLE articles2 (
	id 		SERIAL PRIMARY KEY,
	title 	TEXT,
	tags 	TEXT[]  -- массив строк
);

-- Вставка с массивом
INSERT INTO articles2 (title, tags) VALUES
	('Введение в SQL', ARRAY['sql', 'базы-данных', 'обучение']),
	('PostgreSQL для профи', ARRAY['postgresql', 'advanced', 'sql']);


-- Найти статьи с конкретным тегом (оператор @>)
SELECT title FROM articles2
WHERE tags @> ARRAY['sql'];
-- Вернёт обе статьи — у обеих есть тег 'sql'


-- Доступ к элементу массива по индексу (нумерация с 1!)
SELECT tags[1] AS first_tag FROM articles2;
-- 'sql', 'postgresql'


-- Длина массива
SELECT title, array_length(tags, 1) AS tags_count FROM articles2;

-- Развернуть массив в строки
SELECT title, unnest(tags) AS tag FROM articles2;
-- Каждый тег — отдельная строка результата

/* MySQL и SQLite не поддерживают массивы как тип данных. В MySQL для этого нужно создавать дочерние таблицы или хранить массив как строку с разделителями — что гораздо неудобнее. */



/* 3. Оконные функции (Window Functions)
Оконные функции — это одна из самых мощных возможностей SQL для аналитических запросов. Они позволяют делать вычисления по группам строк, не сворачивая их в одну строку, как это делает GROUP BY.

Разберём на примере: у нас есть таблица продаж по менеджерам. Мы хотим увидеть для каждого менеджера его продажи и его рейтинг среди всех менеджеров. С обычным GROUP BY это сделать очень сложно. С оконными функциями — просто. */

-- Оконные функции в PostgreSQL (и MySQL 8.0+, SQLite 3.25+)
-- Таблица: sales(id, manager_name, department, amount)


CREATE TABLE sales (
	id 				SERIAL PRIMARY KEY,
	manager_name 	VARCHAR(100),
	department 		INT,
	amount 			INT
);

-- RANK() — ранг менеджера по сумме продаж среди всех
SELECT
	manager_name,
	department,
	amount,
	RANK() OVER (ORDER BY amount DESC) AS overall_rank
FROM sales;


-- RANK() с PARTITION BY — ранг внутри каждого отдела
SELECT
	manager_name,
	department,
	amount,
	RANK() OVER (PARTITION BY department ORDER BY amount DESC) AS dept_rank
FROM sales;


-- ROW_NUMBER() — просто порядковый номер строки
SELECT
	ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_num,
	manager_name,
	amount
FROM sales;


-- SUM() как оконная функция — накопительная сумма
SELECT
	manager_name,
	amount,
	SUM(amount) OVER (ORDER BY id) AS running_total
FROM sales;


-- LAG() — получить значение предыдущей строки
-- Полезно для сравнения с предыдущим периодом
SELECT
	manager_name,
	amount,
	LAG(amount) OVER (ORDER BY id) 			AS prev_amount,
	amount - LAG(amount) OVER (ORDER BY id) AS diff
FROM sales;

/* Оконные функции появились в PostgreSQL в версии 8.4 (2009 год). MySQL добавил их только в версии 8.0 (2018 год). SQLite — в версии 3.25 (2018 год). Так что если вы работаете со старым MySQL или старым SQLite, оконных функций там нет.

Ключевое слово OVER — вот что отличает оконную функцию:

RANK() OVER (...) — оконная функция, каждая строка остаётся в результате, но получает рассчитанное значение. GROUP BY — обычная агрегация, строки схлопываются в группы. Это принципиальное различие. */









SELECT table_name
FROM information_schema.columns
WHERE table_schema = 'public'
GROUP BY table_name;



SELECT 'DROP TABLE IF EXISTS "' || table_name || '" CASCADE;'
FROM information_schema.columns
WHERE table_schema = 'public'
GROUP BY table_name;



DROP TABLE IF EXISTS "comments" CASCADE;
DROP TABLE IF EXISTS "articles" CASCADE;
DROP TABLE IF EXISTS "article_tags" CASCADE;
DROP TABLE IF EXISTS "order_items" CASCADE;
DROP TABLE IF EXISTS "accounts" CASCADE;
DROP TABLE IF EXISTS "number_of_times_i_was_distracted" CASCADE;
DROP TABLE IF EXISTS "users_old_version" CASCADE;
DROP TABLE IF EXISTS "events" CASCADE;
DROP TABLE IF EXISTS "purchases" CASCADE;
DROP TABLE IF EXISTS "reactions" CASCADE;
DROP TABLE IF EXISTS "articles2" CASCADE;
DROP TABLE IF EXISTS "tags" CASCADE;
DROP TABLE IF EXISTS "orders" CASCADE;
DROP TABLE IF EXISTS "employees" CASCADE;
DROP TABLE IF EXISTS "users" CASCADE;
DROP TABLE IF EXISTS "categories" CASCADE;
DROP TABLE IF EXISTS "sales" CASCADE;
DROP TABLE IF EXISTS "customers" CASCADE;
DROP TABLE IF EXISTS "posts" CASCADE;
DROP TABLE IF EXISTS "course_enrollments" CASCADE;
DROP TABLE IF EXISTS "products" CASCADE;



SELECT table_name
FROM information_schema.columns
WHERE table_schema = 'public'
GROUP BY table_name;






