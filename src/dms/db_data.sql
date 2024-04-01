--- добавление людей к системе
CREATE OR REPLACE FUNCTION users_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
        INSERT INTO test.user (fname, sname) VALUES ('fname_' || i, 'sname_' || i);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT users_create(15);

--- добавление Производителей
CREATE OR REPLACE FUNCTION fabricator_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
        INSERT INTO test.FABRICATOR (name) VALUES ('cool_fbrc_' || i);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT fabricator_create(15);


--- Добавление Доставщиков
CREATE OR REPLACE FUNCTION delivery_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
        INSERT INTO test.DELIVERY_COMPANY (name) VALUES ('delivery_' || i);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT delivery_create(15);


--- Добавление категорий
CREATE OR REPLACE FUNCTION category_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
        INSERT INTO test.CATEGORY (name) VALUES ('category_' || i );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT category_create(15);

-- Добавление Описаний
CREATE OR REPLACE FUNCTION description_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
        INSERT INTO test.GOODS_DESCRIPTION (name, fabricator_Id)
        VALUES (
            'item_' || i, 
            (SELECT floor(random()*(14)+1))
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT description_create(15);


-- Добавление предметов
CREATE OR REPLACE FUNCTION goods_create(N integer) RETURNS VOID as $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
        INSERT INTO test.GOODS (goods_description_id)
        VALUES (i);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT goods_create(15);


-- Добавление Листа категорий
CREATE OR REPLACE FUNCTION goods_list_create(N integer) RETURNS VOID as $$
DECLARE
    arr int[];
    i int;
    j int;
BEGIN
    for i in 1..N LOOP
        select array(
                SELECT * FROM generate_series(1, 14)
                ORDER BY RANDOM()
            ) into arr;
        for j in 1..(SELECT floor(random()*3)+1) LOOP
            INSERT INTO test.CATEGORY_LIST (goods_description_id, category_id)
            VALUES 
            (
                i,
                arr[j]
            );
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT goods_list_create(15);

--- Добавление Заказ И оплата 
CREATE OR REPLACE FUNCTION pay_ins(x integer, y integer) RETURNS integer as $$
BEGIN
    INSERT INTO test.PAYMENTS (delivery_price, goods_price)
    VALUES (x, y);

    return (SELECT id FROM test.PAYMENTS
    ORDER BY id DESC
    LIMIT 1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION order_create(N integer) RETURNS VOID as $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
        INSERT INTO test.ORDER
        (arrived_date, create_date, user_id, delivery_company_id, Payments_id)
        VALUES
        (
            (SELECT TO_DATE('2000/01/' || i,'YYYY/MM/DD')),
            (SELECT TO_DATE('2000/01/' || (i - 1), 'YYYY/MM/DD')),
            (SELECT floor(random()*14 + 1)),
            (SELECT floor(random()*14 + 1)),
            pay_ins(
                (SELECT (CAST ((SELECT floor(random()*100)+1) as int))),
                (SELECT (CAST ((SELECT floor(random()*25 + 1)) as int)))
            )
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT order_create(30);


--- Добавление в список, того что было в заказе
CREATE OR REPLACE FUNCTION order_goods_create(N integer) RETURNS VOID as $$
DECLARE
    arr int[];
    i int;
    j int;
BEGIN

    for i in 1..N LOOP
        select array(
        SELECT * FROM generate_series(1, 14)
        ORDER BY RANDOM()
        )
        into arr;
        for j in 1..3 LOOP
            INSERT INTO test.ORDER_GOODS
            (order_Id, goods_id)
            VALUES (
                i,
                arr[j]
                );
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT order_goods_create(30);