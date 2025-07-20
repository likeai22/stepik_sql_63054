SELECT name_department,
    name_program,
    plan,
    IF(COUNT(enrollee_id), COUNT(enrollee_id), 0) Количество,
    ROUND(COUNT(enrollee_id) / plan, 2) Конкурс
FROM program
    LEFT JOIN program_enrollee USING(program_id)
    LEFT JOIN department USING(department_id)
GROUP BY 1, 2, 3
ORDER BY 5 DESC;

-- с сайта
