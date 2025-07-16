SELECT s.name_student, MAX(result) result
FROM student s
JOIN attempt USING(student_id)
GROUP BY 1
HAVING result = (
    SELECT MAX(total)
    FROM (
        SELECT MAX(result) AS total
        FROM attempt a
        JOIN student USING(student_id)
        GROUP BY student_id
    ) AS subquery
)
ORDER BY 1;

SELECT name_student, result
FROM (
    SELECT 
        s.name_student, MAX(result) result,
        RANK() OVER (ORDER BY MAX(result) DESC) AS `rank`
    FROM student s
    JOIN attempt USING(student_id)
    GROUP BY student_id
) AS ranked
WHERE `rank` = 1;

WITH qq AS (
    SELECT name_student, MAX(result) result
    FROM student s
        JOIN attempt USING(student_id)
    GROUP BY student_id
)
SELECT name_student, result
FROM qq
HAVING result = (
        SELECT max(result)
        FROM qq
    )
ORDER BY 1;

SELECT name_student, MAX(result) result
FROM student 
    JOIN attempt USING(student_id)
GROUP BY student_id
HAVING result >= ALL 
    (SELECT  MAX(result) result
     FROM student JOIN attempt USING (student_id)
     GROUP BY name_student)
ORDER BY 1;