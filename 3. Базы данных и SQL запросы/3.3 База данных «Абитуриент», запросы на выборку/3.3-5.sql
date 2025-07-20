SELECT name_program
FROM program p
    JOIN program_subject pb ON p.program_id = pb.program_id
GROUP BY name_program
HAVING MIN(pb.min_result) >= 40
ORDER BY 1;

-- с сайта
SELECT DISTINCT(name_program)
FROM program_subject
    INNER JOIN program USING (program_id)
WHERE program_id NOT IN(
        SELECT program_id
        FROM program_subject
        WHERE min_result < 40
    )
ORDER BY name_program;
