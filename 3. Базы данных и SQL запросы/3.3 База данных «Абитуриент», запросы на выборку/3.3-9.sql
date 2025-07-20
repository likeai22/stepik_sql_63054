SELECT name_program
FROM program_subject pb
    JOIN program USING(program_id)
    JOIN subject sb ON sb.subject_id=pb.subject_id AND  name_subject IN ('Информатика', 'Математика')
GROUP BY 1
HAVING COUNT(pb.subject_id) = 2
ORDER BY 1;

-- с сайта
select name_program
from subject inner join program_subject using (subject_id)
             inner join program using (program_id)
group by name_program 
having sum(name_subject = 'Информатика' or name_subject = 'Математика') = 2
order by name_program;


SELECT name_program
FROM program
WHERE program_id IN (SELECT program_id
                     FROM program_subject
                     WHERE subject_id IN (SELECT subject_id
                                          FROM subject
                                          WHERE name_subject IN ('Информатика', 'Математика'))
                                          GROUP BY 1
                                          HAVING COUNT(subject_id) > 1)
ORDER BY 1;