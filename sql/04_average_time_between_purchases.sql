-- 4.Среднее время между покупками клиента

WITH enrollment_gaps AS (
	SELECT
		user_id,
		enrolled_at AS enroll_date,
		LAG(enrolled_at) OVER (
			PARTITION BY user_id
			ORDER BY enrolled_at
		) 								AS prev_enroll_date,
		enrolled_at - LAG(enrolled_at) OVER (
			PARTITION BY user_id
			ORDER BY enrolled_at
		) 								AS gap_interval
	FROM enrollments
)
SELECT
	user_id,
	AVG(EXTRACT(EPOCH FROM gap_interval) / 86400) AS avg_days_between_enrollments
FROM enrollment_gaps
WHERE gap_interval IS NOT NULL
GROUP BY user_id
ORDER BY avg_days_between_enrollments;
