SELECT name_question, name_answer, IF(is_correct > 0, 'Верно', 'Неверно') Результат
FROM question q
    JOIN testing t ON q.question_id = t.question_id AND attempt_id = 7
    JOIN answer a ON a.answer_id = t.answer_id
