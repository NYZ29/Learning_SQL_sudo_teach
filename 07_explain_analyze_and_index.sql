-- 7.Запустите EXPLAIN ANALYZE на любом из запросов, найдите Seq Scan и добавьте индекс

EXPLAIN ANALYZE
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
ORDER BY spending_rank;

-- СНАЧАЛА
/* QUERY PLAN
Sort  (cost=13.13..13.13 rows=1 width=886) (actual time=0.409..0.410 rows=7.00 loops=1)
  Sort Key: (dense_rank() OVER w1)
  Sort Method: quicksort  Memory: 25kB
  Buffers: shared hit=2
  ->  WindowAgg  (cost=13.10..13.12 rows=1 width=886) (actual time=0.394..0.399 rows=7.00 loops=1)
        Window: w1 AS (ORDER BY (COALESCE(sum(e.paid_amount), '0'::numeric)) ROWS UNBOUNDED PRECEDING)
        Storage: Memory  Maximum Storage: 17kB
        Buffers: shared hit=2
        ->  Sort  (cost=13.10..13.10 rows=1 width=878) (actual time=0.385..0.386 rows=7.00 loops=1)
              Sort Key: (COALESCE(sum(e.paid_amount), '0'::numeric)) DESC
              Sort Method: quicksort  Memory: 25kB
              Buffers: shared hit=2
              ->  GroupAggregate  (cost=13.05..13.09 rows=1 width=878) (actual time=0.358..0.375 rows=7.00 loops=1)
                    Group Key: u.email
                    Buffers: shared hit=2
                    ->  Sort  (cost=13.05..13.05 rows=3 width=847) (actual time=0.346..0.349 rows=117.00 loops=1)
                          Sort Key: u.email
                          Sort Method: quicksort  Memory: 34kB
                          Buffers: shared hit=2
                          ->  Hash Right Join  (cost=10.51..13.02 rows=3 width=847) (actual time=0.065..0.282 rows=117.00 loops=1)
                                Hash Cond: (e.user_id = u.id)
                                Buffers: shared hit=2
                                ->  Seq Scan on enrollments e  (cost=0.00..2.17 rows=117 width=13) (actual time=0.010..0.013 rows=117.00 loops=1)
                                      Buffers: shared hit=1
                                ->  Hash  (cost=10.50..10.50 rows=1 width=838) (actual time=0.043..0.043 rows=7.00 loops=1)
                                      Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                      Buffers: shared hit=1
                                      ->  Seq Scan on users u  (cost=0.00..10.50 rows=1 width=838) (actual time=0.035..0.036 rows=7.00 loops=1)
                                            Filter: ((role)::text = 'student'::text)
                                            Rows Removed by Filter: 3
                                            Buffers: shared hit=1
Planning:
  Buffers: shared hit=3
Planning Time: 0.285 ms
Execution Time: 0.503 ms */


-- Ищем слова Seq Scan + cost + actual time
-- Здесь проблема с enrollments и users

-- Решение: индексы

CREATE INDEX idx_users_role
	ON users(role);

CREATE INDEX idx_enrollments_user
	ON enrollments(user_id);

-- анализ ТАБЛИЦ
ANALYZE users;
ANALYZE enrollments;

-- Затем возвращаемся к анализу ЗАПРОСА выше

/* Sort  (cost=4.84..4.86 rows=7 width=97) (actual time=0.105..0.105 rows=7.00 loops=1)
  Sort Key: (dense_rank() OVER w1)
  Sort Method: quicksort  Memory: 25kB
  Buffers: shared hit=2
  ->  WindowAgg  (cost=4.64..4.75 rows=7 width=97) (actual time=0.093..0.098 rows=7.00 loops=1)
        Window: w1 AS (ORDER BY (COALESCE(sum(e.paid_amount), '0'::numeric)) ROWS UNBOUNDED PRECEDING)
        Storage: Memory  Maximum Storage: 17kB
        Buffers: shared hit=2
        ->  Sort  (cost=4.62..4.64 rows=7 width=89) (actual time=0.087..0.087 rows=7.00 loops=1)
              Sort Key: (COALESCE(sum(e.paid_amount), '0'::numeric)) DESC
              Sort Method: quicksort  Memory: 25kB
              Buffers: shared hit=2
              ->  HashAggregate  (cost=4.44..4.53 rows=7 width=89) (actual time=0.078..0.080 rows=7.00 loops=1)
                    Group Key: u.email
                    Batches: 1  Memory Usage: 32kB
                    Buffers: shared hit=2
                    ->  Hash Right Join  (cost=1.21..3.82 rows=82 width=58) (actual time=0.029..0.050 rows=117.00 loops=1)
                          Hash Cond: (e.user_id = u.id)
                          Buffers: shared hit=2
                          ->  Seq Scan on enrollments e  (cost=0.00..2.17 rows=117 width=13) (actual time=0.005..0.007 rows=117.00 loops=1)
                                Buffers: shared hit=1
                          ->  Hash  (cost=1.12..1.12 rows=7 width=49) (actual time=0.016..0.016 rows=7.00 loops=1)
                                Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                Buffers: shared hit=1
                                ->  Seq Scan on users u  (cost=0.00..1.12 rows=7 width=49) (actual time=0.011..0.012 rows=7.00 loops=1)
                                      Filter: ((role)::text = 'student'::text)
                                      Rows Removed by Filter: 3
                                      Buffers: shared hit=1
Planning:
  Buffers: shared hit=50 read=1 dirtied=3
Planning Time: 0.524 ms
Execution Time: 0.148 ms */

-- Ничего не изменилось, НО
-- В плане выполнения обнаружены последовательные сканирования таблиц users и enrollments. Для ускорения фильтрации по роли создан индекс idx_users_role на столбце users.role, а для ускорения соединения пользователей с записями на курсы — индекс idx_enrollments_user на столбце enrollments.user_id. Однако из-за небольшого размера тестовых таблиц PostgreSQL может продолжить использовать Seq Scan, поскольку последовательное чтение в данном случае дешевле индексного.
