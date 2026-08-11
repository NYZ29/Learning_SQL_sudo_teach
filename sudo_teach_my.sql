CREATE DATABASE shop_db;

USE shop_db;

CREATE TABLE products (
	id  		SERIAL PRIMARY KEY,
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

SELECT name, price 
FROM products
WHERE name LIKE '%ноутбук%';

SELECT name, price 
FROM products 
WHERE name NOT LIKE '%Ноутбук%';

--Урок 2.3

DROP TABLE products ;
DROP TABLE employees ;
DROP TABLE orders ;
DROP TABLE customers;

CREATE TABLE customers (
	id NUMERIC,
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
	id 				NUMERIC,
	customer_id 	NUMERIC,
	product_id 		NUMERIC,
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

SELECT c.name, o.id AS order_id
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id

UNION

SELECT c.name, o.id AS order_id
FROM customers c
RIGHT JOIN orders o ON c.id = o.customer_id
WHERE c.id IS NULL;

-- LEFT JOIN
SELECT c.name, o.id AS order_id
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id

UNION

-- RIGHT JOIN (добавит строки только из orders, которых нет в LEFT JOIN)
SELECT c.name, o.id AS order_id
FROM customers c
RIGHT JOIN orders o ON c.id = o.customer_id
WHERE c.id IS NULL;



-- Урок 4.1
SELECT table_schema, table_name 
FROM information_schema.tables AS t 
WHERE t.table_schema = 'public' AND t.table_type = 'BASE TABLE' 
ORDER BY t.table_schema, t.table_name;


/* В MySQL синтаксис немного другой — здесь JOIN прописывается явно в теле UPDATE: */
-- MySQL
UPDATE customers c
JOIN orders o ON o.customer_id = c.id
SET c.is_vip = TRUE
WHERE o.amount > 50000;



/* ⚡ UPSERT — вставить или обновить */
/* ON DUPLICATE KEY UPDATE в MySQL
В MySQL та же идея реализована через конструкцию ON DUPLICATE KEY UPDATE. Она срабатывает, если INSERT нарушает уникальный индекс или первичный ключ: */
-- MySQL: то же самое, другой синтаксис
INSERT INTO user_settings (user_id, theme, language, updated_at)
VALUES (123, 'light', 'ru', NOW())
ON DUPLICATE KEY UPDATE
	theme = VALUES(theme),
	language = VALUES(language),
	updated_at = VALUES(updated_at);


-- MySQL: счётчик просмотров страниц
INSERT INTO page_views (page_url, view_count, lat_viewed)
VALUES ('/products/laptop-dell', 1, NOW())
ON DUPLICATE KEY UPDATE
	view_count = view_count + 1,
	last_viewed = NOW();



-- Урок 6.1
-- MySQL: автоинкремент через AUTO_INCREMENT
CREATE TABLE users (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	PRIMARY KEY(id)
);

-- Вставляем пользователя без указания id
INSERT INTO users (name) VALUES ('Иван');
INSERT INTO users (name) VALUES ('Мария');

SELECT * FROM users;



SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'orders';

DESCRIBE orders;
SHOW COLUMNS FROM orders;

SELECT * FROM orders;

ALTER TABLE orders
	ADD COLUMN user_id INT,
	ADD CONSTRAINT CHECK (user_id > 0);
ALTER TABLE orders
	ADD COLUMN amount INT CHECK (amount > 0);

DESCRIBE users;

/* 🔗 Различия в JOIN, LIMIT и строковых функциях
Базовый синтаксис JOIN одинаков везде: INNER JOIN, LEFT JOIN, RIGHT JOIN работают во всех трёх СУБД. Но в деталях есть различия.

FULL OUTER JOIN
FULL OUTER JOIN возвращает все строки из обеих таблиц, подставляя NULL там, где нет совпадений. Это удобно, когда нужно найти записи, у которых нет пары ни в одной таблице. */
-- PostgreSQL и MySQL 8.0+: FULL OUTER JOIN работает нативно
SELECT u.name, o.amount
FROM users u
FULL OUTER JOIN orders o ON u.id = o.user_id;


SELECT u.name, o.amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
UNION
SELECT u.name, o.amount
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id
WHERE u.id IS NULL;



DESCRIBE products;

ALTER TABLE products
	ADD COLUMN created_at DATE;

/* LIMIT и OFFSET
Пагинация — ограничение количества строк в результате — в PostgreSQL и MySQL работает одинаково: */
-- PostgreSQL, MySQL, SQLite — всё одинаково ✅
SELECT * FROM products
ORDER BY created_at DESC
LIMIT 10 OFFSET 20; -- взять 10 строк, пропустить первые 20



/* Строковые функции
Здесь различий больше всего. Казалось бы, «склеить две строки» — простая задача, но в MySQL и PostgreSQL/SQLite это делается по-разному: */

-- Конкатенация строк
-- MySQL: функция CONCAT()
SELECT CONCAT('Привет, ', name, '!') AS greeting FROM users;


-- Длина строки (количество символов)
-- MySQL:
SELECT LENGTH('Привет'); 		-- 12 (байт! для UTF-8 кириллица = 2 байта/символ)
SELECT CHAR_LENGTH('Привет'); 	-- 6 (символов) — используй это!
/* Важная ловушка MySQL! Функция LENGTH() в MySQL возвращает длину в байтах, а не в символах. Для кириллицы, китайских иероглифов и других многобайтовых символов это даст неправильный результат. Всегда используйте CHAR_LENGTH() в MySQL для подсчёта символов. */


-- Регистр строк — работает одинаково везде
SELECT UPPER('hello'); -- 'HELLO'
SELECT LOWER('WORLD'); -- 'world'

-- Обрезка пробелов
SELECT TRIM('  пробелы   ');		-- 'пробелы' (везде)
SELECT LTRIM('    слева');			-- 'слева'   (везде)
SELECT RTRIM('справа     ');		-- 'справа'  (везде)

-- Подстрока — немного отличается
-- MySQL — SUBSTR() или SUBSTRING(), синтаксис тот же:
SELECT SUBSTRING('Привет мир', 1, 6); -- 'Привет'

