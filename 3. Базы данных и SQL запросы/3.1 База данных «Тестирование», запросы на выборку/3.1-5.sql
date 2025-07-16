SELECT name_student, name_subject, 
DATEDIFF(MAX(date_attempt), MIN(date_attempt)) Интервал
FROM 
    student 
    JOIN attempt a USING(student_id)
    JOIN subject USING(subject_id)
GROUP BY name_student, name_subject
HAVING Интервал > 0
ORDER BY Интервал;

WITH student_intervals AS (
    SELECT 
        s.name_student,
        sb.name_subject,
        DATEDIFF(MAX(a.date_attempt), MIN(a.date_attempt)) AS Интервал
    FROM student s
    JOIN attempt a ON s.student_id = a.student_id
    JOIN subject sb ON a.subject_id = sb.subject_id
    GROUP BY s.student_id, sb.subject_id, s.name_student, sb.name_subject
    HAVING DATEDIFF(MAX(a.date_attempt), MIN(a.date_attempt)) > 0
)
SELECT name_student, name_subject, Интервал
FROM 
    student_intervals
ORDER BY 
    Интервал;

WITH intervals AS (
    SELECT 
        s.name_student,
        sub.name_subject,
        DATEDIFF(MAX(a.date_attempt), MIN(a.date_attempt)) AS Интервал
    FROM 
        student s
        JOIN attempt a ON s.student_id = a.student_id
        JOIN subject sub ON a.subject_id = sub.subject_id
    GROUP BY 
        s.student_id, sub.subject_id, s.name_student, sub.name_subject
    HAVING 
        DATEDIFF(MAX(a.date_attempt), MIN(a.date_attempt)) > 0
)
SELECT 
    name_student,
    name_subject,
    Интервал,
    RANK() OVER (ORDER BY Интервал) AS Ранг
FROM 
    intervals
ORDER BY 
    Интервал;

SELECT i.name_student, i.name_subject, i.Интервал
FROM (
    SELECT 
        s.name_student,
        sb.name_subject, 
        DATEDIFF(MAX(a.date_attempt), MIN(a.date_attempt)) AS Интервал
    FROM student s
    JOIN attempt a USING(student_id)
    JOIN subject sb USING(subject_id)
    GROUP BY name_student, name_subject
    HAVING DATEDIFF(MAX(a.date_attempt), MIN(a.date_attempt)) > 0
) AS i
ORDER BY i.Интервал;

