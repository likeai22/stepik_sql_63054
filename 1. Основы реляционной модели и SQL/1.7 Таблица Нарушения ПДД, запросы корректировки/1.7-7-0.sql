DROP TABLE IF EXISTS payment;
CREATE TABLE payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    number_plate VARCHAR(10),
    violation VARCHAR(100),
    date_violation DATE,
    date_payment DATE
);

INSERT INTO payment (name, number_plate, violation, date_violation, date_payment) VALUES
('Яковлев Г.Р.', 'М701АА', 'Превышение скорости(от 20 до 40)', '2020-01-12', '2020-01-22'),
('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', '2020-02-14', '2020-03-06'),
('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', '2020-03-03', '2020-03-23')