SELECT name_step, date_step_beg, date_step_end, COUNT(buy_id) Количество
FROM buy_step bs JOIN step s ON s.step_id=bs.step_id AND date_step_beg IS NOT NULL AND date_step_end IS NULL 
GROUP BY buy_id, name_step, date_step_beg, date_step_end
ORDER BY date_step_beg;


SELECT name_step, date_step_beg, date_step_end, COUNT(buy_id) Количество
FROM buy_step bs JOIN step s ON s.step_id=bs.step_id AND date_step_beg AND date_step_end 
GROUP BY buy_id, name_step, date_step_beg, date_step_end
ORDER BY date_step_beg;




-- UPDATE buy_step AS bs
-- JOIN step AS s ON bs.step_id = s.step_id AND bs.buy_id = 5
-- SET date_step_end = if (s.name_step = 'Оплата', STR_TO_DATE('13.04.2020', '%d.%m.%Y'), null),
--  date_step_beg = if (s.name_step = 'Упаковка', STR_TO_DATE('13.04.2020', '%d.%m.%Y'), date_step_beg);


-- UPDATE buy_step AS bs
-- JOIN step AS s ON bs.step_id = s.step_id AND bs.buy_id = 5
-- SET date_step_end = if (s.name_step = 'Оплата', '2020-04-13', date_step_beg),
--  date_step_beg = if (s.name_step = 'Упаковка', '2020-04-13', date_step_beg);




-- ну а что, нигде не говорилось, что нельзя переменными пользоваться )
-- SET @need_date = DATE('2020-04-13');
-- SET @step = 1;

-- UPDATE buy_step
-- SET date_step_end = @need_date
-- WHERE buy_id = 5 AND step_id = @step;

-- UPDATE buy_step
-- SET date_step_beg = @need_date
-- WHERE buy_id = 5 AND step_id = (@step + 1);

-- SELECT * FROM buy_step WHERE buy_id = 5;
