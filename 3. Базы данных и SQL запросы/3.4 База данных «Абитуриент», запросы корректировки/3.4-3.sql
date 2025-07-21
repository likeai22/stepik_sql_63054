DELETE FROM applicant
USING applicant
    JOIN program_subject ps USING(program_id)
    JOIN enrollee_subject es USING(enrollee_id, subject_id)
WHERE es.result<ps.min_result;


DELETE FROM applicant
WHERE (program_id, enrollee_id) IN( 
SELECT program_id, enrollee_id
FROM program
    JOIN program_subject ps USING(program_id)
    JOIN subject sb USING(subject_id)
    JOIN enrollee_subject es ON sb.subject_id=es.subject_id AND es.result<ps.min_result
    JOIN enrollee USING(enrollee_id)
    JOIN program_enrollee USING(enrollee_id, program_id)
GROUP BY 1, 2
ORDER BY 1, 2
);


-- с сайта
