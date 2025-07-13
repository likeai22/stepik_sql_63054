drop table if exists fine;
create table fine(
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8,2),
    date_violation DATE,
    date_payment  DATE
);

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES
('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', 500.00, '2020-01-12', '2020-01-17'),
('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', 1000.00, '2020-01-14', '2020-02-27'),
('Яковлев Г.Р.', 'Т330ТТ', 'Превышение скорости(от 20 до 40)', 500.00, '2020-01-23', '2020-02-23'),
('Яковлев Г.Р.', 'М701АА', 'Превышение скорости(от 20 до 40)', NULL, '2020-01-12', NULL),
('Колесов С.П.', 'К892АХ', 'Превышение скорости(от 20 до 40)', NULL, '2020-02-01', NULL),
('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);

drop table if exists traffic_violation;
create table traffic_violation (
    violation_id INT PRIMARY KEY AUTO_INCREMENT,
    violation VARCHAR(50),
    sum_fine DECIMAL(8,2)
);

insert into traffic_violation (violation, sum_fine)
VALUES
('Превышение скорости(от 20 до 40)', 500.00),
('Превышение скорости(от 40 до 60)', 1000.00),
('Проезд на запрещающий сигнал', 1000.00);


-- UPDATE fine, traffic_violation
UPDATE fine, traffic_violation 
set fine.sum_fine = traffic_violation.sum_fine 
where fine.sum_fine is NULL and fine.violation = traffic_violation.violation;


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


UPDATE fine f,
    payment p
SET f.date_payment = p.date_payment,
    f.sum_fine = IF(
        DATEDIFF(f.date_payment, f.date_violation) <= 20,
        f.sum_fine / 2,
        f.sum_fine
    )
WHERE f.number_plate = p.number_plate
    AND f.violation = p.violation
    AND f.date_violation = p.date_violation
    AND f.date_payment IS NULL;