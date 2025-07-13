DELETE FROM fine
WHERE DATEDIFF("2020-02-01", date_violation) > 0;

-- примеры с сайта
DELETE FROM fine 
WHERE (date_violation<'2020-02-01');

DELETE FROM fine 
    WHERE date_violation < 20200201;