-- 6.Топ-3 товара или курса в каждой категории

WITH course_sales AS (
	SELECT
		c.id,
		c.title 			AS course_name,
		tags.name 			AS tag_name,
		COUNT(e.id) 		AS enrollments_count,
		SUM(e.paid_amount) 	AS revenue
	FROM enrollments e
	JOIN courses c ON e.course_id = c.id
	JOIN course_tags ct ON ct.course_id = c.id
	JOIN tags ON tags.id = ct.tag_id
	WHERE c.status = 'published'
	GROUP BY c.id, c.title, tags.name
),
ranked AS (
	SELECT
		*,
		ROW_NUMBER() OVER (
			PARTITION BY tag_name
			ORDER BY enrollments_count DESC, revenue DESC, id ASC
		) AS rank_in_tags
	FROM course_sales
)
SELECT
	tag_name,
	rank_in_tags,
	course_name,
	enrollments_count,
	revenue
FROM ranked
WHERE rank_in_tags <= 3
ORDER BY tag_name, rank_in_tags;
