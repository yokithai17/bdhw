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
              where gd.name == goods_name)
           );
END;
$$ LANGUAGE plpgsql;