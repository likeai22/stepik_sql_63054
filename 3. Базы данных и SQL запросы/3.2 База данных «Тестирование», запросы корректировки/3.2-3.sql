INSERT INTO testing (attempt_id, question_id)
SELECT attempt_id,
    question_id
FROM attempt a
    JOIN question q ON q.subject_id = a.subject_id
WHERE attempt_id =(
        SELECT MAX(attempt_id)
        FROM attempt
    )
ORDER BY RAND()
LIMIT 3;

INSERT INTO testing (attempt_id, question_id)
SELECT attempt_id,
    question_id
FROM question q
    JOIN attempt a ON q.subject_id = a.subject_id
WHERE attempt_id =(
        SELECT MAX(attempt_id)
        FROM attempt
    )
ORDER BY RAND()
LIMIT 3;

-- с сайта Stepik
SET @attempt_id = (SELECT MAX(attempt_id) FROM attempt);
SET @subject_id = (SELECT subject_id FROM attempt WHERE attempt_id = @attempt_id);

INSERT INTO testing (attempt_id, question_id)
SELECT
    @attempt_id,
    question_id
FROM
    question
WHERE
    subject_id = @subject_id
ORDER BY
    RAND()
LIMIT
    3;