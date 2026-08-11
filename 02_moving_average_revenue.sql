-- 2.Скользящее среднее выручки за 7 дней

WITH daily_revenue AS (
	SELECT
		DATE(enrolled_at) AS sale_date,
		SUM(paid_amount) AS revenue
	FROM enrollments
	GROUP BY sale_date
)
SELECT
	sale_date,
	revenue,
	ROUND (
		AVG(revenue) OVER (
			ORDER BY sale_date
			ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
		), 2
	) 											AS moving_avg_7d
FROM daily_revenue
ORDER BY sale_date;
-- Это правильно синтаксически, но есть нюанс: это работает в случае, если продажи были все дни подряд, начиная с первого (т.к. по факту программа смотрит на строки, а не на реальные календарные даты)

-- Вот более точное решение:
WITH date_range AS (
	SELECT generate_series(
		MIN(DATE(enrolled_at)),
		MAX(DATE(enrolled_at)),
		INTERVAL '1 day'
	)::DATE AS sale_date
	FROM enrollments
),
daily_revenue AS (
	SELECT
		DATE(enrolled_at) AS sale_date,
		SUM(paid_amount) AS revenue
	FROM enrollments
	GROUP BY DATE(enrolled_at)
),
calendar_revenue AS (
	SELECT
		date_range.sale_date,
		COALESCE(daily_revenue.revenue, 0) AS revenue
	FROM date_range
	LEFT JOIN daily_revenue
		ON daily_revenue.sale_date = date_range.sale_date
)
SELECT
	sale_date,
	revenue,
	ROUND(
		AVG(revenue) OVER (
			ORDER BY sale_date
			ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
		),
		2
	) 											AS moving_avg_7d
FROM calendar_revenue
ORDER BY sale_date;
/* Здесь generate_series() создаёт все календарные даты между первой и последней продажей, а дни без продаж получают revenue = 0.

Также стоит учитывать, что в первые шесть дней среднее будет рассчитано по доступному количеству дней, а не всегда по полным семи дням. */
-- Да, в данном конкретном случае, в некоторые даты выручка = 0
