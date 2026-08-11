-- 3.Доля каждой категории в общей выручке =(?) доля каждого тега, мб

SELECT
	tags.id,
	tags.name 					AS tag_name,
	SUM(e.paid_amount) 			AS tag_revenue,
	ROUND (
		100.0 * SUM(e.paid_amount) /
			SUM(SUM(e.paid_amount)) OVER(),
		2) 							AS tag_pct
FROM enrollments e
JOIN courses c ON c.id = e.course_id
JOIN course_tags ct ON ct.course_id = c.id
JOIN tags ON tags.id = ct.tag_id
WHERE c.status = 'published'
GROUP BY tags.id
ORDER BY tag_revenue DESC, tags.id ASC;

-- Проверка, что общая сумма процентов = 100

WITH sum_of_pct AS (
	SELECT
		tags.id,
		tags.name 					AS tag_name,
		SUM(e.paid_amount) 			AS tag_revenue,
		100.0 * SUM(e.paid_amount) /
			SUM(SUM(e.paid_amount)) OVER()							AS tag_pct
	FROM enrollments e
	JOIN courses c ON c.id = e.course_id
	JOIN course_tags ct ON ct.course_id = c.id
	JOIN tags ON tags.id = ct.tag_id
	WHERE c.status = 'published'
	GROUP BY tags.id
	ORDER BY tag_revenue DESC
)
SELECT
	SUM(tag_pct)
FROM sum_of_pct;
