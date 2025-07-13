UPDATE fine fn,
    (
        SELECT name,
            violation
        FROM fine
        GROUP BY name,
            number_plate,
            violation
        HAVING count(*) > 1
    ) as f
SET fn.sum_fine = 2 * fn.sum_fine
where fn.date_payment is NULL
    AND fn.name = f.name
    AND f.violation = fn.violation;

-- второй способ
DROP TABLE IF EXISTS query_in;
CREATE TEMPORARY TABLE query_in (
    SELECT name,
        violation
    FROM fine
    GROUP BY name,
        number_plate,
        violation
    HAVING count(*) > 1
);
UPDATE fine f,
    query_in q
SET f.sum_fine = 2 * f.sum_fine
WHERE f.date_payment is NULL
    AND f.name = q.name
    AND f.violation = q.violation;

-- третий способ
DROP TABLE IF EXISTS query_in;
CREATE TEMPORARY TABLE query_in AS
SELECT name,
    violation
FROM fine
GROUP BY name,
    number_plate,
    violation
HAVING COUNT(*) > 1;
UPDATE fine f
    JOIN query_in t ON f.name = t.name
    AND f.violation = t.violation
SET f.sum_fine = 2 * f.sum_fine
WHERE f.date_payment is NULL
    AND f.name = t.name
    AND f.violation = t.violation;

-- примеры с сайта

