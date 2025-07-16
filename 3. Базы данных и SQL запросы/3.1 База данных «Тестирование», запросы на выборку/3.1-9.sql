SELECT name_student,
    name_subject,
    date_attempt,
    ROUND(SUM(is_correct) * 100 / 3, 2) Результат
FROM student s
    JOIN attempt ae USING(student_id)
    JOIN subject sb ON sb.subject_id = ae.subject_id
    JOIN testing t ON t.attempt_id = ae.attempt_id
    JOIN answer a ON a.answer_id = t.answer_id
GROUP BY name_student, name_subject, date_attempt
ORDER BY name_student, date_attempt DESC;


-- 2 сайт
SELECT name_student, name_subject, date_attempt, ROUND(100*AVG(is_correct),2) AS Результат
FROM testing 
INNER JOIN answer USING(answer_id)
INNER JOIN attempt USING(attempt_id)
INNER JOIN subject USING(subject_id)
INNER JOIN student USING(student_id)
GROUP BY 1, 2, 3
ORDER BY 1, 3 DESC;
