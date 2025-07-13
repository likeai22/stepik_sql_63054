UPDATE fine, traffic_violation 
set fine.sum_fine = traffic_violation.sum_fine 
where fine.sum_fine is NULL and fine.violation = traffic_violation.violation;

-- SELECT * from fine;

-- select f.name,
--     f.violation,
--     f.sum_fine,
--     if (f.sum_fine is NULL, tv.sum_fine, "not rev") as description
-- FROM fine f, traffic_violation tv
-- WHERE tv.violation = f.violation and f.sum_fine is NULL;

-- примеры с сайта
UPDATE fine AS f, traffic_violation AS tv
SET f.sum_fine = tv.sum_fine
WHERE tv.violation = f.violation and f.sum_fine IS Null;

update fine as f 
set f.sum_fine = 
                (Select tv.sum_fine 
                 from traffic_violation as tv
                 where f.violation = tv.violation)
where f.sum_fine is null;

UPDATE fine AS f, traffic_violation AS tv
SET f.sum_fine = IF(f.sum_fine IS Null, tv.sum_fine, f.sum_fine)
WHERE tv.violation = f.violation;
SELECT * FROM fine;

UPDATE fine AS f
SET f.sum_fine = CASE 
    WHEN f.sum_fine IS NULL THEN (SELECT sum_fine
                                  FROM traffic_violation
                                  WHERE f.violation = traffic_violation.violation)
    ELSE f.sum_fine
END;
