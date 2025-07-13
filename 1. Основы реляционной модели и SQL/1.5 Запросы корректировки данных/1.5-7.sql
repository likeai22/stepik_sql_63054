-- В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, чтобы оно не превышало количество экземпляров книг, указанных в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%.


-- ALTER TABLE book
-- ADD buy INT NOT NULL DEFAULT 0;

-- UPDATE book
-- SET buy = CASE book_id
--     WHEN 1 THEN 0
--     WHEN 2 THEN 3
--     WHEN 3 THEN 8
--     WHEN 4 THEN 0    
--     WHEN 5 THEN 18
--     ELSE buy
-- END;



UPDATE book
SET buy = IF(buy > amount, amount, buy),
    price = IF(buy = 0, price * 0.9, price);

SELECT * FROM book;


-- примеры с сайта:
UPDATE book
SET buy = buy - (buy *(buy > amount) - amount *(buy > amount)),
    price = price - (0.1 * price *(buy = 0));


UPDATE book SET buy = amount WHERE (amount - buy) < 0;
UPDATE book SET price = ROUND(price * 0.9, 2) WHERE buy = 0;
SELECT * from book;

UPDATE book SET buy = (
  CASE
    WHEN buy > amount
    THEN amount
    ELSE buy
  END),
price = (
  CASE
    WHEN buy = 0
    THEN round((price * 0.9), 2)
    ELSE price
  END);

SELECT * FROM book;