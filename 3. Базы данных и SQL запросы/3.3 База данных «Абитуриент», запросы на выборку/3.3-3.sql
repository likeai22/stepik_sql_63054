SELECT name_program
FROM program_subject
    JOIN subject ON program_subject.subject_id = subject.subject_id AND name_subject = 'Информатика'
    JOIN program ON program_subject.program_id = program.program_id
ORDER BY 1 DESC;
