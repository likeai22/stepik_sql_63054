SELECT buy_id, name_step
FROM step
JOIN buy_step USING(step_id)
WHERE date_step_beg IS NOT NULL AND date_step_end IS NULL
-- GROUP BY buy_id, name_step
ORDER BY buy_id;


-- с сайта
