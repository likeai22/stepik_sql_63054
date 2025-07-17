INSERT INTO attempt (student_id, subject_id, date_attempt)
SELECT student_id, subject_id, NOW()
FROM student JOIN attempt USING(student_id)
JOIN subject USING(subject_id)
WHERE name_subject = 'Основы баз данных' AND name_student = 'Баранов Павел';

INSERT INTO attempt (student_id, subject_id, date_attempt)
SELECT s.student_id,
    sb.subject_id,
    CURDATE()
FROM student s
    JOIN attempt a ON s.student_id = a.student_id
    AND name_student = 'Баранов Павел'
    JOIN subject sb ON sb.subject_id = a.subject_id
    AND name_subject = 'Основы баз данных';


INSERT INTO attempt (student_id, subject_id, date_attempt)
SELECT student_id, subject_id, CURDATE()
FROM student, subject
WHERE name_subject = 'Основы баз данных' AND name_student = 'Баранов Павел';

-- с сайта Stepik
INSERT INTO attempt(student_id, subject_id, date_attempt)
SELECT student_id, subject_id, NOW()
FROM  student, subject
WHERE name_student = 'Баранов Павел' and name_subject = 'Основы баз данных';
SELECT * FROM attempt;