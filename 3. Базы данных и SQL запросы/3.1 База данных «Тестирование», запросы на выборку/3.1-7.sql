SELECT question_id,
    name_question
FROM subject sb
    JOIN question q ON q.subject_id = sb.subject_id AND sb.subject_id = 2
ORDER BY RAND()
LIMIT 3;