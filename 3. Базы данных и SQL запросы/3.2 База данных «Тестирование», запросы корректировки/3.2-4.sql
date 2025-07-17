UPDATE attempt a
SET result = (
    SELECT ROUND(SUM(a.is_correct) * 100 / 3, 2)
    FROM testing t
        JOIN answer a ON a.answer_id = t.answer_id
        WHERE attempt_id = a.attempt_id
)
WHERE a.attempt_id = 8;

-- с сайта Stepik
SET @last_attempt = (SELECT MAX(attempt_id) FROM attempt);

SET @last_result = (
        SELECT ROUND(AVG(is_correct)*100, 0) AS result
        FROM testing
        JOIN answer USING(answer_id)
        WHERE attempt_id = @last_attempt);

UPDATE attempt
SET result = @last_result
WHERE attempt_id = @last_attempt