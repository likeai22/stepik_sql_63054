SELECT name_subject,
    COUNT(eb.enrollee_id) Количество,
    MAX(eb.result) Максимум,
    MIN(eb.result) Минимум,
    ROUND(AVG(eb.result), 1) Среднее
FROM subject sb
    JOIN enrollee_subject eb ON eb.subject_id = sb.subject_id
GROUP BY name_subject
ORDER BY 1;
