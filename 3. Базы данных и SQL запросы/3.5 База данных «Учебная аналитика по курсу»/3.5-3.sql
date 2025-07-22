INSERT INTO step_keyword (step_id, keyword_id)
SELECT step_id,
    keyword_id
FROM keyword,
    step
WHERE POSITION(
        CONCAT(' ', keyword_name, ' ') IN CONCAT(' ', step_name, ' ')
    ) <> 0
    OR POSITION(
        CONCAT(' ', keyword_name, ',') IN CONCAT(' ', step_name, ' ')
    ) <> 0
    OR POSITION(
        CONCAT(' ', keyword_name, '(') IN CONCAT(' ', step_name, ' ')
    ) <> 0;


INSERT INTO step_keyword (step_id, keyword_id)
SELECT step_id,
    keyword_id
FROM keyword,
    step
WHERE step_name REGEXP CONCAT('\\b', keyword_name, '\\b');

-- SELECT POSITION('bar' IN 'foobar');
-- SELECT LOCATE('bar', 'foobar');
-- SELECT INSTR('foobar', 'bar');
