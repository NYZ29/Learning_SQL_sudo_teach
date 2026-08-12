select sqlite_version();
select date('now');
select 2 + 2 as result, 'Hello, SQLite!' as greeting;
select name from sqlite_master where type='table';


-- Урок 6.1
-- SQLite — AUTOINCREMENT
-- SQLite: используй INTEGER PRIMARY KEY (AUTOINCREMENT необязателен)
CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	name TEXT NOT NULL
);
-- SQLite автоматически заполняет id при вставке

-- Явный AUTOINCREMENT — только если нужна гарантия уникальности
-- даже после удаления строк
CREATE TABLE sessions (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	token TEXT
);


/* FULL OUTER JOIN
FULL OUTER JOIN возвращает все строки из обеих таблиц, подставляя NULL там, где нет совпадений. Это удобно, когда нужно найти записи, у которых нет пары ни в одной таблице. */

-- SQLite: не поддерживает FULL OUTER JOIN!
-- Приходится эмулировать через UNION:
SELECT u.name, o.amount
FROM users u LEFT JOIN orders o ON u.id = o.user_id
UNION
SELECT u.name, o.amount
FROM orders o LEFT JOIN users u ON o.user_id = u.id
WHERE u.id IS NULL;




PRAGMA table_info(users);
PRAGMA table_info(orders);



CREATE TABLE orders (
	id 				NUMERIC,
	customer_id 	NUMERIC,
	user_id			NUMERIC,
	product_id 		NUMERIC,
	quantity 		NUMERIC NOT NULL,
	amount			NUMERIC NOT NULL,
	order_date 		DATE
);


DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id 		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name 	VARCHAR(100) NOT NULL
);




PRAGMA table_info(products);

CREATE TABLE products (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(200) NOT NULL,
	price DECIMAL(10, 2) NOT NULL,
	category_id INTEGER NOT NULL,
	created_at DATE NOT NULL
);



/* LIMIT и OFFSET
Пагинация — ограничение количества строк в результате — в PostgreSQL и MySQL работает одинаково: */
-- PostgreSQL, MySQL, SQLite — всё одинаково ✅
SELECT * FROM products
ORDER BY created_at DESC
LIMIT 10 OFFSET 20; -- взять 10 строк, пропустить первые 20



/* Строковые функции
Здесь различий больше всего. Казалось бы, «склеить две строки» — простая задача, но в MySQL и PostgreSQL/SQLite это делается по-разному: */

-- Конкатенация строк
-- PostgreSQL и SQLite: оператор ||
SELECT 'Привет, ' || name || '!' AS greeting FROM users;


-- Длина строки (количество символов)
-- SQLite:
SELECT LENGTH('Привет'); -- 6 (символов)


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