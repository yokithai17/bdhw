CREATE OR REPLACE FUNCTION delivery_company_change(dc_name VARCHAR, order_id INTEGER) RETURNS VOID as
$$
BEGIN
    UPDATE test.order
    SET delivery_company_id = (SELECT id
                               from test.delivery_company
                               where name == dc_name)
    WHERE id = order_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION order_goods_add(goods_name VARCHAR, order_id_ INTEGER) RETURNS VOID AS
$$
BEGIN
    INSERT INTO test.order_goods (order_id, goods_id)
    VALUES ( order_id_
           , (select g.id
              from test.goods g
                       inner join test.goods_description gd
                                  on gd.id = g.goods_description_id
              where gd.name == goods_name));
END;
$$ LANGUAGE plpgsql;

/********************************** ORDER *****************************************/

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
DECLARE
    i int;
    sum int;
BEGIN
    for i in 1..N LOOP
            sum = 0;
            INSERT INTO test.ORDER
            (arrived_date, create_date, user_id, delivery_company_id, Payments_id)
            VALUES
                (
                    (SELECT TO_DATE('2000/01/' || i,'YYYY/MM/DD')),
                    (SELECT TO_DATE('2000/01/' || (i - 1), 'YYYY/MM/DD')),
                    (SELECT floor(random()*14 + 1)),
                    (SELECT floor(random()*14 + 1)),
                    (pay_ins(-1, -1))
                );
        END LOOP;
END;
$$ LANGUAGE plpgsql;

/************************************ ORDERS_GOODS_CREATE *************************************/

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

/************************************ GOODS_LIST_CATEGORY_CREATE *******************************/

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

/************************************ GOODS_CREATE *******************************/

CREATE OR REPLACE FUNCTION goods_create(N integer) RETURNS VOID as $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
            INSERT INTO test.GOODS (goods_description_id)
            VALUES (i);
        END LOOP;
END;
$$ LANGUAGE plpgsql;

/********************************* GOODS_DESCRIPTIONS_CREATE *******************************/

CREATE OR REPLACE FUNCTION description_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
            INSERT INTO test.GOODS_DESCRIPTION (name, fabricator_Id, price)
            VALUES (
                       'item_' || i,
                       (SELECT floor(random()*(14)+1)),
                       (SELECT floor(random()*(100)+1))
                   );
        END LOOP;
END;
$$ LANGUAGE plpgsql;

/********************************* CATEGORY_CREATE *******************************/
CREATE OR REPLACE FUNCTION category_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
            INSERT INTO test.CATEGORY (name) VALUES ('category_' || i );
        END LOOP;
END;
$$ LANGUAGE plpgsql;


/********************************* DELIVERY_CREATE *******************************/
CREATE OR REPLACE FUNCTION delivery_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
            INSERT INTO test.DELIVERY_COMPANY (name, delivery_price)
            VALUES (
                       'delivery_' || i ,
                       (SELECT floor(random()*14 + 1))
                   );
        END LOOP;
END;
$$ LANGUAGE plpgsql;


/********************************* FABRICATOR_CREATE *******************************/
CREATE OR REPLACE FUNCTION fabricator_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
            INSERT INTO test.FABRICATOR (name) VALUES ('cool_fbrc_' || i);
        END LOOP;
END;
$$ LANGUAGE plpgsql;


/********************************* USERS_CREATE *******************************/
CREATE OR REPLACE FUNCTION users_create(N integer) RETURNS VOID AS $$
DECLARE i int;
BEGIN
    for i in 1..N LOOP
            INSERT INTO test.user (fname, sname) VALUES ('fname_' || i, 'sname_' || i);
        END LOOP;
END;
$$ LANGUAGE plpgsql;