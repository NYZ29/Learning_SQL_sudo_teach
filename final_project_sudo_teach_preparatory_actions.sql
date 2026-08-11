-- Урок 8.1
/* Проектируем базу данных с нуля
Это финальный модуль курса. Мы не будем учить новые команды SQL — мы будем применять всё, что вы уже знаете. Перед нами реальное техническое задание, и мы пройдём полный путь от требований заказчика до готовой схемы базы данных: выявим сущности, найдём связи между ними, нарисуем ER-диаграмму и напишем SQL DDL-скрипт с ограничениями и индексами. */

/* С чего начинается любой проект
Когда к вам приходит задача «спроектируй базу данных», первое, что нужно сделать — это прочитать техническое задание. Причём не один раз, а несколько. При первом чтении вы воспринимаете общую картину. При втором — начинаете выписывать существительные: они станут вашими таблицами. При третьем — ищете глаголы и отношения: покупает, содержит, относится, принадлежит.

Проектирование базы данных — это не точная наука. Нет единственно правильного ответа. Есть решения лучше и хуже, и умение отличать одно от другого приходит с практикой. Сегодня мы будем проектировать вместе, и я буду объяснять каждое решение: почему выбрали именно такую структуру, какие были альтернативы и чем руководствовались.

Наш проект: платформа для продажи онлайн-курсов. Это не случайный выбор — большинство из вас уже видели подобные сайты и интуитивно понимают, как они работают. Когда домен знакомый, проектировать намного проще.

Техническое задание: читаем внимательно
Вот упрощённое ТЗ от заказчика. Читайте медленно — мы будем разбирать его буквально по предложениям.

Нам нужна платформа, на которой авторы могут публиковать курсы. Курс состоит из модулей, каждый модуль — из уроков. Студенты регистрируются на платформе и покупают курсы. После покупки студент получает доступ к урокам и может отмечать их как пройденные. Каждый урок студент может оценить и оставить комментарий. Курсы можно снабжать тегами, чтобы студенты могли их искать по теме.

Это небольшое ТЗ, но оно содержит всё необходимое для полноценной схемы. Теперь давайте выполним первый шаг — выявим сущности.

====================================================================================================

Шаг 1 — Выявляем сущности
Сущность — это объект реального мира, о котором мы хотим хранить данные. Как правило, каждая сущность становится отдельной таблицей. Выпишем все существительные из ТЗ и решим, что из этого — сущность, а что — просто атрибут.

==================================================

Сущности (станут таблицами)
users — авторы и студенты
courses — курсы
modules — модули курса
lessons — уроки
enrollments — покупки/записи
lesson_progress — прогресс
reviews — оценки и комментарии
tags — теги
course_tags — связка курс-тег

==================================================

Атрибуты (станут столбцами)
имя, email, пароль
название курса, описание
цена, статус публикации
порядковый номер урока
дата покупки
оценка (1–5)
название тега

==================================================

SELECT REPEAT('=', 50);


Важное решение: авторы и студенты — одна таблица users или две разных?

Мы объединяем их в одну таблицу users с полем role. Это разумно, потому что студент может стать автором и наоборот — одна учётная запись, разные роли. Если бы роли были принципиально разными (разные поля, разная логика), мы бы разделили таблицы.

Обратите внимание на course_tags. Это не сущность из ТЗ — мы её добавили сами. Это так называемая таблица связи, или junction table. Она нужна, потому что между курсами и тегами связь «многие ко многим»: у курса может быть много тегов, и один тег может принадлежать многим курсам. В реляционных базах данных такую связь напрямую не представить — нужна промежуточная таблица.

====================================================================================================

Шаг 2 — Определяем связи
Связи бывают трёх видов: один к одному, один ко многим и многие ко многим. Давайте разберём каждую связь в нашей схеме.

==================================================

1 ко многим (1:N)

users → courses
courses → modules
modules → lessons
users → reviews
lessons → reviews
users → enrollments
courses → enrollments

==================================================

Многие ко многим (M:N)

courses ↔ tags
через course_tags
users ↔ lessons
через lesson_progress


==================================================

Один к одному (1:1)
В нашей схеме нет явных связей 1:1. Они встречаются реже и обычно используются, когда хочется вынести редко используемые поля в отдельную таблицу для оптимизации.

==================================================

Обратите внимание на lesson_progress. По ТЗ студент «может отмечать уроки как пройденные». Один студент проходит много уроков, один урок проходят много студентов — это M:N. Таблица lesson_progress будет содержать пары (user_id, lesson_id) и дополнительные данные: дату прохождения и флаг completed.

====================================================================================================

Шаг 3 — Рисуем ER-диаграмму
ER-диаграмма (Entity-Relationship diagram) — это визуальная схема базы данных. Она помогает увидеть всю картину целиком: какие таблицы есть, как они связаны друг с другом. Прежде чем писать первую строку SQL, хороший разработчик всегда рисует ER-диаграмму — на бумаге, в специальном инструменте или даже в текстовом виде, как мы сейчас.



  ┌─────────────┐        ┌──────────────────┐        ┌─────────────┐
  │    users    │        │     courses      │        │    tags     │
  │─────────────│        │──────────────────│        │─────────────│
  │ id (PK)     │1      N│ id (PK)          │M      N│ id (PK)     │
  │ name        │────────│ author_id (FK)   │────────│ name        │
  │ email       │        │ title            │        └─────────────┘
  │ password    │        │ description      │               │
  │ role        │        │ price            │        ┌──────┴──────┐
  │ created_at  │        │ status           │        │ course_tags │
  └─────────────┘        │ created_at       │        │─────────────│
         │               └──────────────────┘        │ course_id   │
         │                        │                  │ tag_id      │
         │ 1                      │ 1                └─────────────┘
         │                        │
         │ N                      │ N
  ┌──────┴──────┐        ┌────────┴─────────┐
  │ enrollments │        │     modules      │
  │─────────────│        │──────────────────│
  │ id (PK)     │        │ id (PK)          │
  │ user_id (FK)│        │ course_id (FK)   │
  │ course_id   │        │ title            │
  │ enrolled_at │        │ position         │
  │ paid_amount │        └──────────────────┘
  └─────────────┘                 │
         │                        │ 1
         │                        │
         │                        │ N
  ┌──────┴──────┐        ┌────────┴─────────┐
  │   reviews   │        │     lessons      │
  │─────────────│        │──────────────────│
  │ id (PK)     │N      1│ id (PK)          │
  │ user_id (FK)│────────│ module_id (FK)   │
  │ lesson_id   │        │ title            │
  │ rating      │        │ content          │
  │ comment     │        │ duration_sec     │
  │ created_at  │        │ position         │
  └─────────────┘        └──────────────────┘
                                  │
                                  │ M
                                  │
                         ┌────────┴─────────┐
                         │  lesson_progress │
                         │──────────────────│
                         │ user_id (FK)     │
                         │ lesson_id (FK)   │
                         │ completed        │
                         │ completed_at     │
                         └──────────────────┘



Стрелки с цифрами 1 и N показывают тип связи. Таблица courses ссылается на users через author_id — один пользователь может создать много курсов. Таблицы course_tags и lesson_progress — это промежуточные таблицы для связей M:N, у них нет собственного суррогатного id — их первичный ключ составной.

====================================================================================================

Шаг 4 — Пишем SQL DDL-скрипт
DDL расшифровывается как Data Definition Language — язык определения данных. Это команды CREATE TABLE, ALTER TABLE, DROP TABLE. Мы создаём таблицы в правильном порядке: сначала те, на которые ссылаются другие, потом те, которые содержат внешние ключи.

Порядок создания: users → tags → courses → course_tags → modules → lessons → enrollments → lesson_progress → reviews.

 */

-- Таблица users 
CREATE TABLE users (
	id 			SERIAL 			PRIMARY KEY,
	name 		VARCHAR(150) 	NOT NULL,
	email 		VARCHAR(254) 	NOT NULL UNIQUE,
	password 	VARCHAR(255) 	NOT NULL,
	role 		VARCHAR(20) 	NOT NULL DEFAULT 'student'
					CHECK (role IN ('student', 'author', 'admin')),
	bio 		TEXT,
	avatar_url 	VARCHAR(500),
	created_at 	TIMESTAMPTZ 	NOT NULL DEFAULT NOW(),
	updated_at 	TIMESTAMPTZ 	NOT NULL DEFAULT NOW()
);

-- Почему SERIAL, а не INTEGER? SERIAL — это сокращение PostgreSQL: он автоматически создаёт последовательность и устанавливает DEFAULT. В современном PostgreSQL лучше писать GENERATED ALWAYS AS IDENTITY, но SERIAL понятнее и встречается чаще в примерах. CHECK для role — это ограничение на уровне базы: никакое приложение не сможет записать недопустимое значение.

-- Таблица tags
CREATE TABLE tags (
	id 		SERIAL 			PRIMARY KEY,
	name 	VARCHAR(80) 	NOT NULL UNIQUE
);

-- Таблица courses
CREATE TABLE courses (
	id 			SERIAL 			PRIMARY KEY,
	author_id 	INTEGER 		NOT NULL
					REFERENCES users(id) ON DELETE RESTRICT,
	title 		VARCHAR(300) 	NOT NULL,
	description TEXT,
	price 		NUMERIC(10, 2) 	NOT NULL DEFAULT 0
					CHECK (price >= 0),
	status 		VARCHAR(20) 	NOT NULL DEFAULT 'draft'
					CHECK (status IN ('draft', 'published', 'archived')),
	cover_url 	VARCHAR(500),
	created_at 	TIMESTAMPTZ 	NOT NULL DEFAULT NOW(),
	updated_at 	TIMESTAMPTZ 	NOT NULL DEFAULT NOW()
);

-- Индекс для быстрого поиска курсов конкретного автора
CREATE INDEX idx_courses_author ON courses(author_id);

-- Индекс для выборки только опубликованных курсов
CREATE INDEX idx_courses_status ON courses(status);

-- ON DELETE RESTRICT — мы запрещаем удалять автора, если у него есть курсы. Это осознанное решение: лучше выдать ошибку, чем случайно осиротить курс. Альтернатива — SET NULL, но тогда нам пришлось бы разрешить NULL в author_id.

-- Таблица course_tags (связь M:N)
CREATE TABLE course_tags (
	course_id 	INTEGER NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
	tag_id 		INTEGER NOT NULL REFERENCES tags(id) 	ON DELETE CASCADE,
	
	PRIMARY KEY (course_id, tag_id)
);

-- Здесь первичный ключ составной — пара (course_id, tag_id). Одна и та же комбинация не может встречаться дважды. ON DELETE CASCADE означает: если удалили курс — автоматически удаляются все его записи в course_tags. Логично, потому что тег, привязанный к несуществующему курсу — бессмысленный мусор.

-- Таблица modules
CREATE TABLE modules (
	id SERIAL PRIMARY KEY,
	course_id INTEGER NOT NULL
		REFERENCES courses(id) ON DELETE CASCADE,
	title VARCHAR(300) NOT NULL,
	position SMALLINT NOT NULL DEFAULT 1
		CHECK (position > 0),
		
	UNIQUE (course_id, position)
);

CREATE INDEX idx_modules_course ON modules(course_id);

-- Таблица lessons
CREATE TABLE lessons (
	id 				SERIAL 			PRIMARY KEY,
	module_id 		INTEGER 		NOT NULL
						REFERENCES modules(id) ON DELETE CASCADE,
	title 			VARCHAR(300) 	NOT NULL,
	content 		TEXT,
	video_url 		VARCHAR(500),
	duration_sec 	INTEGER 		CHECK (duration_sec >= 0),
	position 		SMALLINT 		NOT NULL DEFAULT 1
						CHECK (position > 0),

	UNIQUE (module_id, position)
);

CREATE INDEX idx_lessons_module ON lessons(module_id);

-- Таблица enrollments (покупки курсов)
CREATE TABLE enrollments (
	id 				SERIAL 			PRIMARY KEY,
	user_id 		INTEGER 		NOT NULL
						REFERENCES users(id) ON DELETE RESTRICT,
	course_id 		INTEGER 		NOT NULL
		REFERENCES courses(id) ON DELETE RESTRICT,
	paid_amount 	NUMERIC(10,2) 	NOT NULL DEFAULT 0
						CHECK (paid_amount >= 0),
	enrolled_at 	TIMESTAMPTZ 	NOT NULL DEFAULT NOW(),

	UNIQUE (user_id, course_id) -- студент покупает курс не более одного раза
);

CREATE INDEX idx_enrollments_user 	ON enrollments(user_id);
CREATE INDEX idx_enrollments_course ON enrollments(course_id);

-- Таблица lesson_progress (прогресс по урокам)
CREATE TABLE lesson_progress (
	user_id 		INTEGER 	NOT NULL REFERENCES users(id) 	ON DELETE CASCADE,
	lesson_id 		INTEGER 	NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
	completed 		BOOLEAN 	NOT NULL DEFAULT FALSE,
	completed_at 	TIMESTAMPTZ,
	
	PRIMARY KEY (user_id, lesson_id)
);

-- Таблица reviews (оценки и комментарии)
CREATE TABLE reviews (
	id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL
		REFERENCES users(id) ON DELETE CASCADE,
	lesson_id INTEGER NOT NULL
		REFERENCES lessons(id) ON DELETE CASCADE,
	rating SMALLINT NOT NULL
		CHECK (rating BETWEEN 1 AND 5),
	comment TEXT,
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	
	UNIQUE (user_id, lesson_id) -- один отзыв на урок от одного студента
);

CREATE INDEX idx_reviews_lesson ON reviews(lesson_id);


/* Анатомия ограничений: почему каждое из них важно
Ограничения — это не бюрократия. Это защита целостности данных. Давайте пройдёмся по каждому типу ограничений, которые мы использовали в схеме.

==================================================

NOT NULL
Поле обязательно для заполнения. Без этого ограничения в таблице могут появиться строки без имени пользователя или без названия курса — это бессмысленные данные.

UNIQUE
Значение уникально в таблице. Email пользователя должен быть уникальным — иначе двое могут зарегистрироваться с одним адресом и не смогут войти нормально.

CHECK
Пользовательское условие. Цена не может быть отрицательной. Рейтинг — только от 1 до 5. Роль — только из заданного набора. База проверяет это при каждом INSERT и UPDATE.

FOREIGN KEY
Ссылочная целостность. Гарантирует, что урок всегда принадлежит существующему модулю. Без FK в базе появятся «висячие» записи, которые ссылаются в никуда.

==================================================

Отдельно стоит поговорить о поведении при удалении: ON DELETE. У нас три варианта.

RESTRICT (или NO ACTION) — запретить удаление, если есть зависимые строки. Используем для автора курса и для студента в enrollments: нельзя просто удалить человека, не разобравшись сначала с его данными.

CASCADE — удалить все зависимые строки автоматически. Используем там, где зависимые строки теряют смысл без родителя: удалили курс — удалились все его модули, уроки, теги, прогресс.

SET NULL — установить NULL в дочерней таблице. В нашей схеме не используется, но полезно знать.

==================================================

Проверяем схему: пишем первые запросы
Схема готова. Теперь напишем несколько запросов, которые убедят нас, что всё спроектировано правильно. Если запросы выглядят естественно — схема хорошая. Если приходится делать пять JOIN-ов для простой выборки — стоит пересмотреть структуру. */

-- Получить все курсы с именем автора и количеством студентов

SELECT
	c.title 		AS courses_title,
	u.name 			AS author_name,
	COUNT(e.id) 	AS students_count
FROM courses c
JOIN users u 			ON u.id = c.author_id
LEFT JOIN enrollments e ON e.course_id = c.id
WHERE c.status = 'published'
GROUP BY c.id, u.name
ORDER BY students_count DESC;


-- Прогресс конкретного студента по курсу

SELECT
	m.title 						AS module_title,
	l.title 						AS lesson_title,
	COALESCE(lp.completed, FALSE) 	AS is_completed,
	lp.completed_at
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
LEFT JOIN lesson_progress lp
	ON lp.lesson_id = l.id AND lp.user_id = 42 -- id студента
WHERE c.id = 7 -- id курса
ORDER BY m.position, l.position;


-- Средний рейтинг уроков в курсе
SELECT
	l.title,
	ROUND(AVG(r.rating), 2) AS avg_rating,
	COUNT(r.id) AS reviews_count
FROM lessons l
JOIN modules m ON m.id = l.module_id
LEFT JOIN reviews r ON r.lesson_id = l.id
WHERE m.course_id = 7
GROUP BY l.id, l.title
HAVING COUNT(r.id) > 0
ORDER BY avg_rating DESC;


/* Запросы получились читаемыми и логичными — это хороший знак. Каждый JOIN следует по цепочке связей, которую мы заложили в схему. Именно для этого мы так тщательно проектировали структуру: хорошая схема делает запросы простыми.

==================================================

Что можно улучшить в реальном проекте
Схема, которую мы спроектировали, достаточна для учебного проекта. Но в продакшне её нужно было бы доработать. Вот типичные направления развития.

Полнотекстовый поиск
Индекс GIN на поля title и description в таблице courses. Студенты смогут искать курсы по ключевым словам без LIKE и без внешнего поиска.

Мягкое удаление
Поле deleted_at вместо физического DELETE. Удалённые записи скрываются из выдачи, но хранятся в базе. Полезно для восстановления и аналитики.

Партиционирование
Если enrollments будет содержать миллионы строк, таблицу можно партиционировать по месяцам. Запросы за конкретный период будут работать в разы быстрее.

Аудит изменений
Таблица audit_log с триггерами: кто, когда и что изменил. Критично для финансовых данных — например, истории цен на курсы. 

====================================================================================================

Итог урока: весь процесс за одну минуту

1. Читаем ТЗ — ищем существительные (сущности) и глаголы (связи).

2. Решаем, что станет таблицей, а что — столбцом. Добавляем junction tables для M:N.

3. Определяем тип каждой связи: 1:1, 1:N или M:N.

4. Рисуем ER-диаграмму — видим всю схему целиком до написания кода.

5. Пишем DDL в правильном порядке: сначала родители, потом дети.

6. Добавляем ограничения: NOT NULL, UNIQUE, CHECK, FOREIGN KEY с нужным ON DELETE.

7. Создаём индексы на внешние ключи и часто используемые в WHERE столбцы.

8. Пишем первые запросы и проверяем, что схема удобна. */


























ROLLBACK;


/* ====================================================================================================
Подготовка базы данных для проверки запросов
 */

BEGIN;

-- =========================================================
-- 1. Очистка таблиц
-- =========================================================
-- Выполняй этот блок только в учебной базе.
-- Он удаляет все существующие данные и сбрасывает счётчики ID.

TRUNCATE TABLE
	lesson_progress,
	reviews,
	enrollments,
	lessons,
	modules,
	course_tags,
	courses,
	tags,
	users
RESTART IDENTITY CASCADE;


-- =========================================================
-- 2. Заполнение таблицы users
-- =========================================================
-- Создаём 10 пользователей:
-- 1 администратор, 2 автора и 7 студентов.
-- Пароли являются условными учебными значениями.

INSERT INTO users (
	name,
	email,
	password,
	role,
	bio,
	avatar_url
)
SELECT
	CASE user_number
		WHEN 1 THEN 'Алексей Иванов'
		WHEN 2 THEN 'Мария Петрова'
		WHEN 3 THEN 'Дмитрий Сидоров'
		WHEN 4 THEN 'Иван Смирнов'
		WHEN 5 THEN 'Анна Кузнецова'
		WHEN 6 THEN 'Олег Попов'
		WHEN 7 THEN 'Елена Васильева'
		WHEN 8 THEN 'Рустам Хабибуллин'
		WHEN 9 THEN 'Никита Морозов'
		WHEN 10 THEN 'София Волкова'
	END,
	'user' || user_number || '@example.com',
	'hashed_password_' || user_number,
	CASE
		WHEN user_number = 1 THEN 'admin'
		WHEN user_number IN (2, 3) THEN 'author'
		ELSE 'student'
	END,
	'Тестовое описание пользователя ' || user_number,
	'https://example.com/avatars/avatar' || user_number || '.png'
FROM generate_series(1, 10) AS generated_users(user_number);



-- =========================================================
-- 3. Заполнение таблицы tags
-- =========================================================

INSERT INTO tags (name)
VALUES
	('SQL'),
	('PostgreSQL'),
	('Python'),
	('Программирование'),
	('Аналитика данных'),
	('Веб-разработка'),
	('Базы данных');


-- =========================================================
-- 4. Заполнение таблицы courses
-- =========================================================
-- Создаём 25 курсов.
-- Авторы назначаются по кругу: пользователи с ID 2, 3 и 1.
-- Цена курса зависит от его номера.
-- Каждый пятый курс будет черновиком,
-- каждый седьмой — архивным, остальные опубликованы.

INSERT INTO courses (
	author_id,
	title,
	description,
	price,
	status,
	cover_url
)
SELECT
	(
		SELECT ID
		FROM users
		WHERE email = 'user' || (((course_number - 1) % 3) + 1) || '@example.com'
	),
	'Курс по программированию № ' || LPAD(course_number::TEXT, 2, '0'),
	'Описание учебного курса номер ' || course_number,
	(500 + course_number * 100)::NUMERIC(10, 2),
	CASE
		WHEN course_number % 5 = 0 THEN 'draft'
		WHEN course_number % 7 = 0 THEN 'archived'
		ELSE 'published'
	END,
	'https://example.com/courses/course' || course_number || '.png'
FROM generate_series(1, 25) AS generated_courses(course_number);



-- =========================================================
-- 5. Связи между курсами и тегами
-- =========================================================
-- Один курс может иметь несколько тегов.
-- Один тег может быть связан с несколькими курсами.
-- Поэтому используется промежуточная таблица course_tags.

INSERT INTO course_tags (
	course_id,
	tag_id
)
SELECT
	courses.id,
	tags.id
FROM courses
CROSS JOIN tags
WHERE (
	courses.id + tags.id
) % 3 = 0;




-- =========================================================
-- 6. Заполнение таблицы modules
-- =========================================================
-- Для каждого курса создаём от 3 до 5 модулей.
-- Количество модулей меняется циклически:
-- 1-й курс — 3 модуля,
-- 2-й курс — 4 модуля,
-- 3-й курс — 5 модулей,
-- затем последовательность повторяется.

INSERT INTO modules (
	course_id,
	title,
	position
)
SELECT
	courses.id,
	'Модуль ' || LPAD(module_number::TEXT, 2, '0')
		|| ' курса № ' || courses.id,
	module_number
FROM courses
CROSS JOIN LATERAL generate_series (
	1,
	3 + ((courses.id - 1) % 3)
) AS generated_modules(module_number);



-- =========================================================
-- 7. Заполнение таблицы lessons
-- =========================================================
-- Для каждого модуля создаём от 3 до 8 уроков.
-- Количество уроков зависит от ID модуля.

INSERT INTO lessons (
	module_id,
	title,
	content,
	video_url,
	duration_sec,
	position
)
SELECT
	modules.id,
	'Урок ' || LPAD(lesson_number::TEXT, 2, '0')
		|| ' – ' || modules.title,
	'Учебный материал урока ' || lesson_number
		|| '. Здесь находится подробное содержание урока.',
	'https://example.com/videos/'
		|| modules.id || '_' || lesson_number || '.mp4',
	300 + lesson_number * 60,
	lesson_number
FROM modules
CROSS JOIN LATERAL generate_series(
	1,
	3 + ((modules.id - 1) % 6)
) AS generated_lessons(lesson_number);



-- =========================================================
-- 8. Заполнение таблицы enrollments
-- =========================================================
-- Пользователи с ролью student записываются на разные курсы.
-- Условие NOT EXISTS дополнительно защищает от дубликатов.

INSERT INTO enrollments (
	user_id,
	course_id,
	paid_amount,
	enrolled_at
)
SELECT
	students.id,
	courses.id,
	(
		500 + courses.id * 100
	)::NUMERIC(10, 2),
	NOW() - ((students.id + courses.id) % 90)
		* INTERVAL '1 day'
FROM users AS students
CROSS JOIN courses
WHERE students.role = 'student'
	AND (students.id + courses.id) % 3 <> 0
	AND NOT EXISTS (
		SELECT 1
		FROM enrollments existing_enrollment
		WHERE existing_enrollment.user_id = students.id
			AND existing_enrollment.course_id = courses.id
	);



-- =========================================================
-- 9. Заполнение таблицы lesson_progress
-- =========================================================
-- Прогресс создаётся только для студентов,
-- которые записаны на соответствующий курс.
-- Часть уроков завершена, часть ещё не пройдена.

INSERT INTO lesson_progress (
	user_id,
	lesson_id,
	completed,
	completed_at
)
SELECT
	enrollments.user_id,
	lessons.id,
	CASE
		WHEN (enrollments.user_id + lessons.id) % 3 <> 0
			THEN TRUE
		ELSE FALSE
	END,
	CASE
		WHEN (enrollments.user_id + lessons.id) % 3 <> 0
			THEN NOW()
				- ((enrollments.user_id + lessons.id) % 30)
				* INTERVAL '1 day'
			ELSE NULL
	END
FROM enrollments
JOIN courses
	ON courses.id = enrollments.course_id
JOIN modules
	ON modules.course_id = courses.id
JOIN lessons
	ON lessons.module_id = modules.id
WHERE (enrollments.user_id + lessons.id) % 2 = 0
	AND NOT EXISTS (
		SELECT 1
		FROM lesson_progress existing_progress
		WHERE existing_progress.user_id = enrollments.user_id
			AND existing_progress.lesson_id = lessons.id
	);



-- =========================================================
-- 10. Заполнение таблицы reviews
-- =========================================================
-- Для каждого урока создаётся от 0 до 5 отзывов.
-- Количество отзывов определяется выражением lesson_id % 6.
-- Поэтому возможны значения от 0 до 5.
-- Некоторые отзывы намеренно создаются без комментария.

INSERT INTO reviews (
	user_id,
	lesson_id,
	rating,
	comment,
	created_at
)
SELECT
	4 + ((review_number - 1) % 7),
	lessons.id,
	1 + ((lessons.id + review_number) % 5),
	CASE
		WHEN review_number % 3 = 0 THEN NULL
		ELSE 'Полезный урок, материал объяснён понятно.'
	END,
	NOW() - ((lessons.id + review_number) % 60)
		* INTERVAL '1 day'
FROM lessons
CROSS JOIN LATERAL generate_series (
	1,
	lessons.id % 6
) AS generated_reviews(review_number)
WHERE NOT EXISTS (
	SELECT 1
	FROM reviews existing_review
	WHERE existing_review.user_id =
		4 + ((review_number - 1) % 7)
		AND existing_review.lesson_id = lessons.id
);



COMMIT;













-- =========================================================
-- Проверка результата
-- =========================================================

-- Количество записей в основных таблицах

SELECT 'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL
SELECT 'tags', COUNT(*) FROM tags
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'course_tags', COUNT(*) FROM course_tags
UNION ALL
SELECT 'modules', COUNT(*) FROM modules
UNION ALL
SELECT 'lessons', COUNT(*) FROM lessons
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments
UNION ALL
SELECT 'lesson_progress', COUNT(*) FROM lesson_progress
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;



-- Количество модулей в каждом курсе
SELECT
	courses.id AS course_id,
	courses.title AS course_title,
	COUNT(modules.id) AS modules_count
FROM courses
JOIN modules ON modules.course_id = courses.id
GROUP BY courses.id, courses.title
ORDER BY courses.id;



-- Количество уроков в каждом модуле
SELECT
	modules.id AS module_id,
	modules.title AS module_title,
	COUNT(lessons.id) AS lessons_count
FROM modules
LEFT JOIN lessons ON lessons.module_id = modules.id
GROUP BY modules.id, modules.title
ORDER BY modules.id;




-- Количество отзывов для каждого урока

SELECT
	lessons.id AS lesson_id,
	lessons.title AS lesson_title,
	COUNT(reviews.id) AS reviews_count
FROM lessons
LEFT JOIN reviews
	ON reviews.lesson_id = lessons.id
GROUP BY lessons.id, lessons.title
ORDER BY lessons.id;









/* Ваше задание

Выполните все семь запросов на своей базе данных:

1.Рейтинг покупателей или студентов по потраченным деньгам

2.Скользящее среднее выручки за 7 дней

3.Доля каждой категории в общей выручке

4.Среднее время между покупками клиента

5.Воронка конверсии через цепочку CTE

6.Топ-3 товара или курса в каждой категории

7.Запустите EXPLAIN ANALYZE на любом из запросов, найдите Seq Scan и добавьте индекс

Для каждого запроса добавьте в репозиторий файл с самим SQL и скриншот вывода. В следующем уроке мы разберём ваши решения и поговорим о том, как оформить финальный проект: структура репозитория, README, схема базы данных в виде ERD-диаграммы.

Сохраните результаты. На защите проекта вас могут попросить объяснить любой из этих запросов вслух. Прочитайте каждый запрос ещё раз и проговорите своими словами: что он делает, зачем нужна каждая часть. Это лучшая подготовка к собеседованиям. */
