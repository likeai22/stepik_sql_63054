INSERT INTO student (name_student)
VALUES ("Радунцев Максим");

INSERT INTO attempt (student_id, subject_id, date_attempt, result)
SELECT query.student_id,
    query.subject_id,
    DATE_ADD(NOW(),  INTERVAL RAND(RAND() * -10) day),
    100
FROM (
        SELECT student_id,
            subject_id
        FROM student,
            subject
        WHERE student_id = (
                SELECT student_id
                FROM student
                WHERE name_student = 'Радунцев Максим'
            )
    ) query;
