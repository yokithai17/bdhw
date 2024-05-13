--- При добавление товара в лист товаров для заказа
CREATE OR REPLACE FUNCTION payments_goods_price_trigger_func()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE test.payments p
    set goods_price = (
        select SUM(gd.price)
        FROM test.goods_description gd
        inner join test.goods g
            on g.goods_description_id = gd.id
        inner join test.order_goods og
            on og.goods_id = g.id
        where og.order_id = NEW.order_id
        )
    where p.id = (
        select pp.id from test.payments pp
        inner join test.order o
            on pp.id = o.payments_id
        where o.id = NEW.order_id
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER payments_goods_price_trigger
    AFTER INSERT OR UPDATE ON test.order_goods
    FOR EACH ROW
EXECUTE FUNCTION payments_goods_price_trigger_func();


--- Добавление цены доставки при добавление заказа.
CREATE OR REPLACE FUNCTION payments_delivery_price_trigger_func()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE test.payments p
    SET delivery_price = (
        SELECT dc.delivery_price
        FROM test.delivery_company dc
        WHERE dc.id = NEW.delivery_company_id
    )
    WHERE p.id = NEW.payments_id;

    RETURN NEW;
END;
$$ LANGUAGE  plpgsql;

CREATE OR REPLACE TRIGGER  payments_delivery_price_trigger
    AFTER INSERT ON test.order
    FOR EACH ROW
EXECUTE FUNCTION  payments_delivery_price_trigger_func();

--Изменение компание по доставки
CREATE OR REPLACE FUNCTION payments_delivery_change_trigger_func()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE test.payments p
    SET delivery_price = (
        SELECT dc.delivery_price
        FROM test.delivery_company dc
        WHERE dc.id = NEW.delivery_company_id
    )
    WHERE p.id = NEW.payments_id;
    RETURN NEW;
END;
$$ LANGUAGE  plpgsql;

CREATE OR REPLACE TRIGGER  payments_delivery_change_trigger
    AFTER UPDATE OF delivery_company_id ON test.order
    FOR EACH ROW
EXECUTE FUNCTION  payments_delivery_change_trigger_func();