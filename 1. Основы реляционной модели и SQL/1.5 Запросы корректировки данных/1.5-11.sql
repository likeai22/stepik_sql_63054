-- 

-- SELECT * FROM supply;
-- SELECT * FROM book;

UPDATE book b
SET b.price = b.price * IF(b.amount=(SELECT MAX(b2.amount) FROM (select * from book) b2), 0.9, 1.2);

SELECT * FROM book;