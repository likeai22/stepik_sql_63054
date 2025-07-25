SELECT CONCAT(
        module_id,
        '.',
        lesson_position,
        '.',
        CONCAT(LPAD(step_position, 2, '0'), ' '),
        step_name
    ) Шаг
FROM module
    JOIN lesson USING(module_id)
    JOIN step USING(lesson_id)
    JOIN step_keyword sk USING(step_id)
    JOIN keyword k ON sk.keyword_id=k.keyword_id AND keyword_name IN ('MAX', 'AVG')
GROUP BY 1
HAVING COUNT(*) = 2
ORDER BY 1;

-- с сайта
WITH 
CTE_max AS  -- ищем, где есть MAX
(SELECT step_id
FROM step_keyword  INNER JOIN keyword USING (keyword_id)
WHERE keyword_name = 'MAX'),

CTE_avg AS -- ищем где есть AVG
(SELECT step_id
FROM step_keyword  INNER JOIN keyword USING (keyword_id)
WHERE keyword_name = 'AVG'),

steps AS  -- Здесь есть и MAX и AVG
( SELECT * FROM CTE_max NATURAL JOIN CTE_avg
)

-- Делаем как просят в ответе
SELECT CONCAT(module_id, '.', lesson_position, '.', LPAD(step_position,2,'0'), ' ' , step_name) as Шаг
FROM steps 
    INNER JOIN step USING (step_id)
    INNER JOIN lesson USING (lesson_id)
    INNER JOIN module USING (module_id)
ORDER BY 1;

