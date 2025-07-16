SELECT name_subject,
    CONCAT(LEFT(name_question, 30),"...") Вопрос,
    COUNT(t.question_id) Всего_ответов,
    -- COUNT(CASE WHEN a.is_correct = 1 THEN 1 END) Успешность
    ROUND(100 * COUNT(IF(a.is_correct = 1, 1, NULL)) / COUNT(t.question_id), 2) Успешность
FROM subject sb
    JOIN question q ON q.subject_id = sb.subject_id
    -- JOIN attempt ae USING(subject_id)
    JOIN testing t ON t.question_id = q.question_id    
    JOIN answer a ON a.answer_id = t.answer_id
GROUP BY 1, 2
ORDER BY 1, 4 DESC, 2;

