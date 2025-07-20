SELECT name_program,
    name_enrollee,
    SUM(result) itog
FROM program
    JOIN program_subject USING(program_id)
    JOIN subject USING(subject_id)
    JOIN enrollee_subject USING(subject_id)
    JOIN enrollee USING(enrollee_id)
    JOIN program_enrollee USING(enrollee_id, program_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- с сайта
-- natural join делает присоединение по всем столбцам с одинаковым именем, поэтому последний join присоединяется по enrollee_id и subject_id автоматом
-- Natural Join: Guidelines:

-- The associated tables have one or more pairs of identically named columns.
-- The columns must be the same data type.
-- Don’t use ON clause in a NATURAL JOIN.
-- NATURAL — сокращённая форма USING: она образует список USING из всех имён столбцов, существующих в обеих входных таблицах. Как и с USING, эти столбцы оказываются в выходной таблице в единственном экземпляре. Если столбцов с одинаковыми именами не находится, NATURAL JOIN действует как JOIN ... ON TRUE и выдаёт декартово произведение строк.


select name_program, name_enrollee, sum(result) as itog
from program_enrollee
natural join program
natural join program_subject
natural join enrollee
natural join enrollee_subject
group by name_enrollee, name_program
order by name_program, itog desc; 

-- 2
select name_program, name_enrollee, sum(result) as itog
from program
join program_enrollee using(program_id)
join program_subject using(program_id)
join enrollee using(enrollee_id)
join enrollee_subject using(subject_id, enrollee_id)
group by name_program, name_enrollee
order by name_program asc, itog desc;
