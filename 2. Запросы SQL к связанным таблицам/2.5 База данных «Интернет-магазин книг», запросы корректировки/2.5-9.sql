UPDATE buy_step
SET date_step_beg = STR_TO_DATE('12.04.2020', '%d.%m.%Y')
WHERE buy_id = 5 AND step_id = 1;