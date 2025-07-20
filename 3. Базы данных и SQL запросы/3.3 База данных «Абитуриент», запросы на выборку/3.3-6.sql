SELECT name_program,
    plan
FROM program
HAVING plan >= ALL (
        SELECT MAX(plan) plan
        FROM program
    );

-- с сайта
SELECT name_program, plan 
FROM program
WHERE plan = (SELECT MAX(plan) FROM program);