CREATE TABLE IF NOT EXISTS student AS
SELECT name_program, name_enrollee, itog
FROM enrollee e
    JOIN applicant_order ao ON ao.enrollee_id=e.enrollee_id
    JOIN program p ON p.program_id=ao.program_id AND ao.str_id <= p.plan
ORDER BY 1, 3 DESC;

CREATE TABLE IF NOT EXISTS student AS
SELECT name_program, name_enrollee, itog
FROM enrollee
    NATURAL JOIN applicant_order ao
    NATURAL JOIN program p
WHERE ao.str_id <= p.plan
ORDER BY 1, 3 DESC;

