SELECT name_enrollee
FROM program_enrollee
    JOIN enrollee ON program_enrollee.enrollee_id = enrollee.enrollee_id
    JOIN program ON program_enrollee.program_id = program.program_id
    AND name_program = 'Мехатроника и робототехника'
ORDER BY name_enrollee;