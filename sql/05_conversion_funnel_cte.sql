-- 5.Воронка конверсии через цепочку CTE

WITH total_users AS (
	SELECT COUNT(*) AS cnt FROM users 
),
paying_students AS (
	SELECT COUNT(DISTINCT user_id) AS cnt
	FROM enrollments
	WHERE paid_amount > 0
),
active_students AS (
	SELECT COUNT(*) AS cnt
	FROM (
		SELECT COUNT(DISTINCT user_id) AS cnt
		FROM enrollments
		WHERE paid_amount > 0
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