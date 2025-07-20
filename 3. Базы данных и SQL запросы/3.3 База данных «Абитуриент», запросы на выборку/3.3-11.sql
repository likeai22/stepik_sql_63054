SELECT name_program,
    name_enrollee
FROM program
    JOIN program_subject ps USING(program_id)
    JOIN subject sb USING(subject_id)
    JOIN enrollee_subject es ON sb.subject_id=es.subject_id AND es.result<ps.min_result
    JOIN enrollee USING(enrollee_id)
    JOIN program_enrollee USING(enrollee_id, program_id)
GROUP BY 1, 2
ORDER BY 1, 2;








-- с сайта
