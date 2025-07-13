
DROP TABLE IF EXISTS back_payment;
CREATE TABLE back_payment (
    SELECT name,
        number_plate,
        violation,
        sum_fine,
        date_violation
    FROM fine
    WHERE date_payment is NULL
);

-- второй способ
DROP TABLE IF EXISTS back_payment;
CREATE TABLE back_payment AS
SELECT name,
    number_plate,
    violation,
    sum_fine,
    date_violation
FROM fine
WHERE date_payment is NULL;

-- примеры с сайта
