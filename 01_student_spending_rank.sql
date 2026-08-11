-- 1.Рейтинг покупателей или студентов по потраченным деньгам

SELECT
	u.id,
	u.name 										AS student_name,
	u.email,
	COUNT(e.id) 								AS courses_bought,
	COALESCE(SUM(e.paid_amount), 0) 			AS total_spent, 
	DENSE_RANK () OVER (
		ORDER BY COALESCE(SUM(e.paid_amount), 0) DESC
	) 											AS spending_rank
FROM users u
LEFT JOIN enrollments e ON e.user_id = u.id
WHERE u.role = 'student'
GROUP BY u.id, u.name, u.email
ORDER BY spending_rank, u.id;