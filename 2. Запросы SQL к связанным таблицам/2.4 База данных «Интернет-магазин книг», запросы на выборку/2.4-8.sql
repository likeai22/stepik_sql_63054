SELECT buy_id, date_step_end
FROM step
JOIN buy_step USING(step_id)
WHERE step_id = 1 AND date_step_end;


-- с сайта
SELECT buy_id, date_step_end FROM buy_step
WHERE step_id IN (SELECT step_id FROM step
WHERE name_step LIKE "Оплата") AND date_step_end
