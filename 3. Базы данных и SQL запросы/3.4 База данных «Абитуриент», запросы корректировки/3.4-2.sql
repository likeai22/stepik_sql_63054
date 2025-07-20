CREATE TABLE applicant AS
SELECT program_id, enrollee_id, SUM(result) itog
FROM program
    JOIN program_subject USING(program_id)
    JOIN subject USING(subject_id)
    JOIN enrollee_subject USING(subject_id)
    JOIN enrollee USING(enrollee_id)
    JOIN program_enrollee USING(enrollee_id, program_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC;




-- с сайта
