SELECT name_subject, COUNT(DISTINCT a.student_id ) Количество
FROM 
    subject sb
    LEFT JOIN attempt a USING(subject_id)
GROUP BY name_subject
ORDER BY Количество DESC, name_subject;

SELECT i.name_subject, i.Количество
FROM (
    SELECT 
        sb.name_subject, 
        COUNT(DISTINCT student_id ) Количество
    FROM subject sb
    LEFT JOIN attempt a USING(subject_id)
    GROUP BY name_subject
) AS i
ORDER BY i.Количество DESC, name_subject;

WITH student_count AS (
    SELECT 
        name_subject,
        COUNT(DISTINCT student_id) Количество
    FROM subject sb
    LEFT JOIN attempt a USING(subject_id)
    GROUP BY sb.name_subject
)
SELECT name_subject, Количество
FROM 
    student_count
ORDER BY Количество DESC, name_subject;