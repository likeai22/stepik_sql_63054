SELECT name_subject,
    MIN(result),
    MAX(result),
    ROUND(AVG(result), 0),
    COUNT(result)
FROM subject JOIN enrollee_subject USING(subject_id)
GROUP BY 1
ORDER BY 4 DESC;








-- с сайта
