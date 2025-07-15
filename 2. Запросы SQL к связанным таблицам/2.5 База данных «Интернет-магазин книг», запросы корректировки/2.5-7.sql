DROP TABLE IF EXISTS buy_pay;
CREATE TABLE buy_pay AS
SELECT buy_id,
    SUM(bb.amount) Количество,
    SUM(b.price * bb.amount) Итого
FROM book b
    JOIN buy_book bb ON bb.book_id = b.book_id
    AND bb.buy_id = 5;



-- stepik
