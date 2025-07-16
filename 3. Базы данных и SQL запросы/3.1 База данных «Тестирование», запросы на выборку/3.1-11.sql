
-- ******************************++++

SELECT name_subject,
    CONCAT(LEFT(name_question, 30), "...") Вопрос,
    ROUND(
        100 * COUNT(IF(a.is_correct = 1, 1, NULL)) / COUNT(t.question_id), 2
    ) Сложность
FROM subject sb
    JOIN question q ON q.subject_id = sb.subject_id
    JOIN testing t ON t.question_id = q.question_id
    JOIN answer a ON a.answer_id = t.answer_id
GROUP BY 1, 2
HAVING Сложность = 
    SELECT MAX(total)
    FROM(
        SELECT name_subject,
            CONCAT(LEFT(name_question, 30), "...") Вопрос,
            ROUND(
                100 * COUNT(IF(a.is_correct = 1, 1, NULL)) / COUNT(t.question_id), 2
            ) total
        FROM subject sb
            JOIN question q ON q.subject_id = sb.subject_id
            JOIN testing t ON t.question_id = q.question_id
            JOIN answer a ON a.answer_id = t.answer_id
        GROUP BY 1, 2
    ) AS subquery
    OR Сложность = 
    SELECT MIN(total)
    FROM(
        SELECT name_subject,
            CONCAT(LEFT(name_question, 30), "...") Вопрос,
            ROUND(
                100 * COUNT(IF(a.is_correct = 1, 1, NULL)) / COUNT(t.question_id), 2
            ) total
        FROM subject sb
            JOIN question q ON q.subject_id = sb.subject_id
            JOIN testing t ON t.question_id = q.question_id
            JOIN answer a ON a.answer_id = t.answer_id
        GROUP BY 1, 2
    ) AS subquery2

-------------------------------


SELECT 
    q_data.name_subject,
    CONCAT(LEFT(q_data.name_question, 30), '...') Вопрос,
    q_data.Сложность
FROM 
    (
        SELECT 
            sb.name_subject,
            q.name_question,
            ROUND(100 * SUM(a.is_correct) / COUNT(t.question_id), 2) AS Сложность
        FROM 
            subject sb
            JOIN question q ON sb.subject_id = q.subject_id
            JOIN testing t ON t.question_id = q.question_id
            JOIN answer a ON a.answer_id = t.answer_id
        GROUP BY 
            sb.name_subject, q.name_question
    ) AS q_data
JOIN 
    (
        SELECT MAX(Сложность) AS max_val, MIN(Сложность) AS min_val
        FROM (
            SELECT 
                ROUND(100 * SUM(a.is_correct) / COUNT(t.question_id), 2) AS Сложность
            FROM 
                testing t
                JOIN answer a ON a.answer_id = t.answer_id
            GROUP BY 
                t.question_id
        ) AS agg_data
    ) AS extremes ON q_data.Сложность = extremes.max_val OR q_data.Сложность = extremes.min_val
ORDER BY 
    q_data.Сложность DESC;

-----------------------------------

SELECT 
    name_subject,
    CONCAT(LEFT(name_question, 30), '...') AS Вопрос,
    ROUND(100 * SUM(a.is_correct) / COUNT(t.question_id), 2) AS Сложность
FROM 
    subject sb
    JOIN question q ON sb.subject_id = q.subject_id
    JOIN testing t ON t.question_id = q.question_id
    JOIN answer a ON a.answer_id = t.answer_id
GROUP BY 
    name_subject, name_question
HAVING 
    Сложность = (
        SELECT ROUND(100 * SUM(a2.is_correct) / COUNT(t2.question_id), 2)
        FROM testing t2
        JOIN answer a2 ON a2.answer_id = t2.answer_id
        GROUP BY t2.question_id
        ORDER BY 1 DESC
        LIMIT 1
    ) 
    OR Сложность = (
        SELECT ROUND(100 * SUM(a3.is_correct) / COUNT(t3.question_id), 2)
        FROM testing t3
        JOIN answer a3 ON a3.answer_id = t3.answer_id
        GROUP BY t3.question_id
        ORDER BY 1 ASC
        LIMIT 1
    )
ORDER BY 
    Сложность DESC;

