SELECT 
    CONCAT(LEFT(CONCAT(module_id, ' ', module_name), 16), '...') Модуль,
    CONCAT(LEFT(CONCAT(module_id, '.', lesson_position, ' ', lesson_name), 16), '...') Урок,
    CONCAT(module_id, '.', lesson_position, '.', step_position, ' ', step_name) Шаг
    FROM module
NATURAL JOIN lesson
NATURAL JOIN step
WHERE step_name LIKE '%ложенн%'
ORDER BY module_id, lesson_position, step_position;

-- с сайта
SELECT CONCAT(LEFT(CONCAT(module_id, ' ', module_name), 16), '...') AS Модуль,
       CONCAT(LEFT(CONCAT(module_id, '.', lesson_position, ' ', lesson_name), 16), '...') AS Урок,
       CONCAT(module_id, '.', lesson_position, '.', step_position, ' ', step_name) AS Шаг
FROM step 
     JOIN lesson USING(lesson_id)
     JOIN module USING(module_id)
WHERE step_name LIKE '%влож%запр%'
ORDER BY Шаг;