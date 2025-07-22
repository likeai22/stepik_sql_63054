SELECT name_enrollee, itog
FROM applicant_order
    NATURAL JOIN program_subject ps
    NATURAL JOIN enrollee_subject es
    NATURAL JOIN enrollee
WHERE es.result<ps.min_result
GROUP BY name_enrollee, itog;


