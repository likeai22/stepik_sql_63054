DROP TABLE IF EXISTS buy_pay;
CREATE TABLE buy_pay AS
SELECT title,
    name_author,
    price,
    bb.amount,
    b.price * bb.amount Стоимость
FROM book b
    JOIN author USING(author_id)
    JOIN buy_book bb ON bb.book_id = b.book_id
    AND bb.buy_id = 5
ORDER BY title;



-- stepik
