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
  │    users    │        │     courses       │       │    tags     │
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

8. Пишем первые запросы и проверяем, что схема удобна.

В следующем уроке вы сделаете всё это самостоятельно: получите ТЗ и спроектируете схему с нуля. Это ваш финальный проект — то, что вы унесёте с курса как портфолио. */



















-- Урок 8.2
/* Пишем запросы к проекту
В прошлом уроке вы спроектировали и создали базу данных реального проекта. Теперь заставим её работать на полную катушку. Сегодня мы пишем настоящие бизнес-запросы — такие, какие используют в продакшн-системах. Оконные функции, CTE, EXPLAIN и индексы. Именно то, что отличает Senior-разработчика от Junior.

📊 Оконные функции
🧩 CTE
⚡ EXPLAIN и индексы
🛍️ Бизнес-логика

С чем мы работаем
Все запросы в этом уроке написаны для двух схем: интернет-магазин и платформа курсов. Вы уже создали одну из них в прошлом уроке. Если у вас интернет-магазин — смотрите первую версию запроса. Если платформа курсов — вторую. Принципы одинаковые, только названия таблиц и столбцов разные.

Краткая структура интернет-магазина: customers, products, categories, orders, order_items, reviews.

Краткая структура платформы курсов: users, instructors, courses, enrollments, lessons, lesson_progress, reviews.

Каждый из семи запросов ниже решает конкретную бизнес-задачу. Сначала я формулирую задачу словами — так, как её мог бы поставить менеджер или аналитик. Потом показываю SQL. Потом разбираю каждый блок запроса по частям. Читайте внимательно: именно этот формат вы будете использовать на собеседованиях, когда вас спросят «объясни свой запрос». */


/* Запрос 1. Рейтинг покупателей по сумме заказов
Бизнес-задача: отдел маркетинга хочет знать, кто из покупателей потратил больше всего денег. Нужен список всех клиентов с указанием их суммарных трат, количества заказов и порядкового номера в рейтинге. Топовым покупателям отправим персональные скидки. */

SELECT
	u.id,
	u.first_name || ' ' || u.last_name 	AS student_name,
	u.email,
	COUNT(e.id) 						AS courses_bought,
	COALESCE(SUM(e.paid_amount), 0) 	AS total_spent,
	RANK() OVER (
		ORDER BY COALESCE(SUM(e.paid_amount), 0) DESC
	) 									AS spending_rank
FROM users u
LEFT JOIN enrollments e
	ON e.user_id = u.id
	AND e.payment_status = 'paid'
GROUP BY u.id, u.first_name, u.last_name, u.email
ORDER BY spending_rank;

/* Разберём по частям. LEFT JOIN — берём всех клиентов, даже тех, кто ни разу не покупал. Для них SUM вернёт NULL, поэтому оборачиваем в COALESCE(..., 0), чтобы получить ноль вместо NULL.

Главная часть — RANK() OVER (ORDER BY ... DESC). Это оконная функция. Она вычисляет ранг каждой строки относительно всех остальных строк результата. Ключевое отличие от обычной агрегации: оконная функция не сворачивает строки. Каждый клиент остаётся отдельной строкой, и к каждой добавляется её ранг.

RANK vs DENSE_RANK: если два клиента потратили одинаково, RANK даст им оба первое место, а следующий получит третье (пропустив второе). DENSE_RANK в такой же ситуации следующему дал бы второе место. Для маркетинговых рейтингов обычно используют DENSE_RANK. */



/* Запрос 2. Скользящая выручка за последние 7 дней
Бизнес-задача: финансовый директор хочет видеть дашборд с выручкой по дням, но не просто столбики за каждый день, а скользящее среднее за 7 дней. Это сглаживает случайные пики и провалы и показывает реальный тренд. */

WITH daily_revenue AS (
	SELECT
		DATE(enrolled_at) AS sale_date,
		SUM(paid_amount) AS revenue
	FROM enrollments
	WHERE payment_status = 'paid'
	GROUP BY DATE(enrolled_at)
)
SELECT
	sale_date,
	revenue,
	ROUND(
		AVG(revenue) OVER (
			ORDER BY sale_date
			ROWS BETWEEN 6 PRECEDING AND CURRENT ROW 
		), 2
	) 							AS moving_avg_7d
FROM daily_revenue
ORDER BY sale_date;

/* Здесь сразу два новых инструмента. Первый — CTE (Common Table Expression). Блок WITH daily_revenue AS (...) создаёт временную именованную таблицу, которая существует только внутри этого запроса. Это как переменная в программировании: записали промежуточный результат, а потом использовали его в основном запросе.

Второй инструмент — оконный фрейм. Конструкция ROWS BETWEEN 6 PRECEDING AND CURRENT ROW говорит: для каждой строки бери её саму и шесть предыдущих строк. Итого семь строк. Вычисляй среднее по ним. Двигайся на следующую строку — снова семь строк. Отсюда и название «скользящее среднее».

Важно: CTE не всегда быстрее подзапроса. В PostgreSQL CTE по умолчанию материализуется — результат сохраняется во временной памяти. Для небольших промежуточных результатов это отлично. Для многократно повторяющихся сложных CTE может быть медленнее. */



/* Запрос 3. Доля каждой категории в общей выручке
Бизнес-задача: продуктовый менеджер просит разбивку: какая категория товаров (или курсов) приносит больше всего денег? Нужна абсолютная сумма и процент от общей выручки. Это позволит понять, на что делать ставку. */

SELECT
	c.category AS category_name,
	SUM(e.paid_amount) AS category_revenue,
	ROUND(
		100.0 * SUM(e.paid_amount)
			/ SUM(SUM(e.paid_amount)) OVER ()
	, 2) AS revenue_pct
FROM enrollments e
JOIN courses c ON c.id = e.course_id
WHERE e.payment_status = 'paid'
GROUP BY c.category
ORDER BY category_revenue DESC;

/* Посмотрите на хитрый трюк: SUM(SUM(oi.quantity * oi.unit_price)) OVER (). Вложенный SUM внутри — это обычная агрегация по группам. А SUM(...) OVER () снаружи — это оконная функция без секции PARTITION BY, то есть она суммирует все строки результата. Так мы в одном запросе получаем и выручку по каждой категории, и общую выручку по всем категориям сразу.

Умножение на 100.0 (не на 100) важно: если делить целое на целое, PostgreSQL и SQLite вернут целочисленный результат. Символ точки превращает число в вещественное, и деление даст дробь. */



/* Запрос 4. Время между покупками одного клиента
Бизнес-задача: команда роста хочет узнать, как быстро клиент делает повторную покупку после первой. Это помогает настроить триггерные письма: если клиент обычно возвращается через 14 дней — напомним ему на 12-й день. */

WITH enrollment_gaps AS (
	SELECT
		user_id,
		enrolled_at AS enroll_date,
		LAG(enrolled_at) OVER (
			PARTITION BY user_id
			ORDER BY enrolled_at
		) AS prev_enroll_date,
		enrolled_at - LAG(enrolled_at) OVER (
			PARTITION BY user_id
			ORDER BY enrolled_at
		) AS gap_interval
	FROM enrollments
	WHERE payment_status = 'paid'
)
SELECT
	user_id,
	AVG(EXTRACT(EPOCH FROM gap_interval) / 86400) AS avg_days_between_enrollments
FROM enrollment_gaps
WHERE gap_interval IS NOT NULL
GROUP BY user_id
ORDER BY avg_days_between_enrollments;

/* Здесь ключевая функция — LAG(). Она возвращает значение из предыдущей строки в окне. PARTITION BY customer_id говорит: разбей все заказы по клиентам, и для каждого клиента считай своё окно отдельно. ORDER BY created_at задаёт порядок внутри окна. В итоге каждая строка знает дату своего заказа и дату предыдущего заказа этого же клиента.

EXTRACT(EPOCH FROM gap_interval) переводит интервал PostgreSQL в секунды. Делим на 86400 (секунд в сутках) и получаем дни. Первый заказ клиента даст NULL для prev_order_date — его отфильтровываем через WHERE gap_interval IS NOT NULL. */




/* Запрос 5. Воронка продаж через цепочку CTE
Бизнес-задача: руководитель хочет воронку конверсии. Сколько человек зарегистрировалось? Сколько сделало хотя бы одну покупку? Сколько сделало три и более покупки? Какой процент на каждом шаге? Это классический отчёт для любого бизнеса. */

WITH
total_users AS (
	SELECT COUNT(*) AS cnt FROM users
),
paying_students AS (
	SELECT COUNT(DISTINCT user_id) AS cnt
	FROM enrollments
	WHERE payment_status = 'paid'
),
active_students AS (
	SELECT COUNT(*) AS cnt
	FROM (
		SELECT user_id
		FROM enrollments
		WHERE payment_status = 'paid'
		GROUP BY user_id
		HAVING COUNT(*) >= 3
	) sub
)
SELECT
	'Зарегистрировались' 	AS funnel_step,
	total_users.cnt 		AS users,
	100.0 					AS conversion_pct
FROM total_users

UNION ALL

SELECT
	'Купили хотя бы 1 курс',
	paying_students.cnt,
	ROUND(100.0 * paying_students.cnt / NULLIF(total_users.cnt, 0), 1)
FROM paying_students, total_users

UNION ALL

SELECT
	'Купили 3+ курса (лояльные)',
	active_students.cnt,
	ROUND(100.0 * active_students.cnt / NULLIF(total_users.cnt, 0), 1)
FROM active_students, total_users;

/* Это пример цепочки CTE. После ключевого слова WITH можно перечислить несколько блоков через запятую. Каждый последующий блок может использовать предыдущие. Это позволяет разбить сложную логику на маленькие читаемые шаги, как функции в коде.

UNION ALL склеивает несколько результатов в одну таблицу. В отличие от UNION, UNION ALL не удаляет дубликаты — это быстрее. Защита от деления на ноль — NULLIF(total, 0): если общее количество равно нулю, функция вернёт NULL, и деление не упадёт с ошибкой. */




/* Запрос 6. Топ-3 товара в каждой категории
Бизнес-задача: отдел закупок хочет видеть три самых продаваемых товара в каждой категории отдельно. Это не общий топ — нужно по три победителя в каждой категории. Такой запрос часто встречается на секции «featured» на главной странице магазина. */

WITH course_sales AS (
	SELECT
		c.id,
		c.title 			AS course_name,
		c.category,
		COUNT(e.id) 		AS enrollments_count,
		SUM(e.paid_amount) 	AS revenue
	FROM enrollments e
	JOIN courses c ON c.id = e.course_id
	WHERE e.payment_status = 'paid'
	GROUP BY c.id, c.title, c.category
),
ranked AS (
	SELECT
		*,
		ROW_NUMBER() OVER (
			PARTITION BY category
			ORDER BY enrollmets_count DESC
		) AS rank_in_category
	FROM course_sales
)
SELECT
	category,
	rank_in_category,
	course_name,
	enrollments_count,
	revenue
FROM ranked
WHERE rank_in_category <= 3
ORDER BY category, rank_in_category;

/* Это классический паттерн «топ N в каждой группе». Трюк в том, что оконную функцию нельзя использовать прямо в WHERE. База выполняет запрос в таком порядке: FROM → WHERE → GROUP BY → оконные функции → SELECT → ORDER BY. То есть когда выполняется WHERE, значения оконных функций ещё не вычислены.

Решение — вынести ранжирование в CTE (блок ranked), а фильтр WHERE rank_in_category <= 3 написать в основном запросе, который читает уже готовый CTE. К тому моменту все ранги уже вычислены.

ROW_NUMBER vs RANK: ROW_NUMBER всегда даёт уникальные числа — даже при одинаковых значениях. Это удобно для «ровно N строк». Если хочется включить все товары с одинаковым количеством продаж — используйте RANK или DENSE_RANK. */




/* Запрос 7. Оптимизация через EXPLAIN и индексы
Бизнес-задача: ваш аналитический запрос работает, но медленно. Таблица заказов выросла до миллиона строк, и каждый запрос занимает 3 секунды. Нужно найти узкое место и исправить его с помощью индексов. 

Начнём с того, что у нас есть медленный запрос. Возьмём запрос из нашего проекта и добавим перед ним слово EXPLAIN ANALYZE: */

-- Смотрим план выполнения запроса
EXPLAIN ANALYZE
SELECT
	c.first_name || ' ' || c.last_name AS customer_name,
	COUNT(o.id) AS total_orders,
	SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.id
WHERE o.status = 'completed'
	AND o.created_at >= '2024-01-01'
GROUP BY c.id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 20;

/* В выводе EXPLAIN ANALYZE вы увидите план выполнения — дерево шагов, которые база выполняет для получения результата. Ищите слова Seq Scan (Sequential Scan — последовательное чтение всей таблицы) и большие значения cost и actual time. Это проблемные места. */

-- Типичный вывод EXPLAIN ANALYZE (упрощённо):
--
-- Limit  (cost=12450.00..12450.05 rows=20)
--   -> Sort  (cost=12450.00..12480.00 rows=12000)
--       -> HashAggregate  (cost=11200.00..11800.00 rows=12000)
--           -> Hash Join  (cost=340.00..8900.00 rows=92000)
--               -> Seq Scan on orders   <-- ПРОБЛЕМА!
--                   Filter: (status = 'completed' AND created_at >= '2024-01-01')
--                   Rows Removed by Filter: 750000
--               -> Seq Scan on customers

-- Решение: создать составной индекс на часто используемые условия WHERE и JOIN
CREATE INDEX idx_orders_status_date
	ON orders (status, created_at DESC);

-- И отдельный индекс на внешний ключ (если его ещё нет)
CREATE INDEX idx_orders_cutomer_id
	ON orders (customer_id);

/* После создания индексов снова запускаем EXPLAIN ANALYZE. Теперь вместо Seq Scan on orders вы должны увидеть Index Scan using idx_orders_status_date. Это означает, что база больше не читает миллион строк, а сразу прыгает к нужным через индекс — как по оглавлению книги.

==================================================

Индексировать стоит:

Столбцы в WHERE
Столбцы в JOIN ON
Столбцы в ORDER BY
Внешние ключи

==================================================

Индекс НЕ поможет если:
Фильтр возвращает >15% строк
Таблица маленькая (<1000 строк)
Условие с LIKE '%text%'
Функция над столбцом: LOWER(name)

*/

-- Если применяете функцию к столбцу в WHERE:
-- ПЛОХО (индекс по email не работает):
SELECT * FROM customers WHERE LOWER(email) = 'ivan@example.com';

-- ХОРОШО вариант 1 - функциональный индекс:
CREATE INDEX idx_customers_email_lower
	ON customers (LOWER(email));

-- ХОРОШО вариант 2 - хранить email уже в нижнем регистре:
SELECT * FROM customers WEHRE email = 'ivan@example.com';



/* Финальный запрос. Сводный отчёт по курсам
Последний запрос — это финальный аккорд. Объединяем CTE, оконные функции и бизнес-логику в один большой сводный отчёт. Для платформы курсов: по каждому курсу видим выручку, количество студентов, средний рейтинг, долю от общей выручки и ранг внутри своей категории. */

WITH course_stats AS (
	SELECT
		c.id,
		c.title,
		c.category,
		COUNT(DISTINCT e.user_id) 			AS students_count,
		COALESCE(SUM(e.paid_amount), 0) 	AS revenue,
		ROUND(AVG(r.rating), 2) 			AS avg_rating
		COUNT(r.id) 						AS reviews_count
	FROM courses c
	LEFT JOIN enrollments e ON e.course_id = c.id
							AND e.payment_status = 'paid'
	LEF JOIN reviews r		ON r.course_id = c.id
	GROUP BY c.id, c.title, c.category
)
SELECT
	title,
	category,
	students_count,
	revenue,
	avg_rating,
	reviews_count,
	
	 -- Доля от общей выручки
	ROUND (
		100.0 * revenue / NULLIF(SUM(revenue) OVER (), 0)
	, 2) 										AS revenue_share_pct,
	
	-- Ранг внутри категории по выручке
	DENSE_RANK() OVER (
		PARTITION BY category
		ORDER BY revenue DESC
	) 											AS rank_in_category,
	
	-- Ранг по рейтингу среди всех курсов
	DENSE_RANK() OVER (
		ORDER BY avg_rating DESC NULLS LAST
	) 											AS rating_rank

FROM course_stats
ORDER BY revenue DESC;

/* Обратите внимание на NULLS LAST в последней оконной функции. Курсы без отзывов имеют avg_rating = NULL. По умолчанию в PostgreSQL NULL считается «больше любого значения» при сортировке по возрастанию — и такие курсы уйдут вниз. При сортировке по убыванию (как у нас) они по умолчанию встанут вверху. NULLS LAST явно отправляет их в конец списка. */