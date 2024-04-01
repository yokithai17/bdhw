CREATE SCHEMA IF NOT EXISTS test;

/*
CREATE TABLE test.tst (id INTEGER);
CREATE TABLE test.DELIVERY_COMPANY (
    id INTEGER  NOT NULL,
    name INTEGER  NOT NULL,
    CONSTRAINT pk_delivery_company PRIMARY KEY (id);
);
*/

CREATE TABLE IF NOT EXISTS test.DELIVERY_COMPANY (
    id SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    CONSTRAINT pk_delivery_company PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS test.ORDER (
    id SERIAL  NOT NULL,
    arrived_date date  NOT NULL,
    create_date date  NOT NULL,
    user_id INTEGER  NOT NULL,
    delivery_company_id INTEGER  NOT NULL,
    Payments_id INTEGER  NOT NULL,
    CONSTRAINT pk_order PRIMARY KEY (Id)
);

--- набор таваров для заказа
CREATE TABLE IF NOT EXISTS test.ORDER_GOODS (
    order_Id INTEGER  NOT NULL,
    goods_id INTEGER  NOT NULL
);


CREATE TABLE IF NOT EXISTS test.PAYMENTS (
    id SERIAL  NOT NULL,
    delivery_price INTEGER  NOT NULL,
    goods_price INTEGER  NOT NULL,
    CONSTRAINT pk_payments PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS test.USER (
    id SERIAL  NOT NULL,
    fname Varchar  NOT NULL,
    sname Varchar  NOT NULL,
    CONSTRAINT pk_user PRIMARY KEY (id)
);

--- описание категорий
CREATE TABLE IF NOT EXISTS test.CATEGORY (
    id SERIAL  NOT NULL,
    name VARCHAR  NOT NULL,
    CONSTRAINT pk_category PRIMARY KEY (id)
);


--- набор категорий
CREATE TABLE IF NOT EXISTS test.CATEGORY_LIST (
    goods_description_id INTEGER  NOT NULL,
    category_id INTEGER  NOT NULL
);


CREATE TABLE IF NOT EXISTS test.FABRICATOR (
    Id SERIAL  NOT NULL,
    name VARCHAR  NOT NULL,
    CONSTRAINT pk_fabricator PRIMARY KEY (Id)
);


CREATE TABLE IF NOT EXISTS test.GOODS (
    id SERIAL  NOT NULL,
    goods_description_id INTEGER  NOT NULL,
    CONSTRAINT pk_goods PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS test.GOODS_DESCRIPTION (
    id SERIAL  NOT NULL,
    name VARCHAR  NOT NULL,
    fabricator_Id INTEGER  NOT NULL,
    CONSTRAINT pk_desription PRIMARY KEY (id)
);

/************************** CREATE FOREIGN KEYS ***************************************/

ALTER TABLE test.ORDER ADD CONSTRAINT fk_older_delivery_company
    FOREIGN KEY (delivery_company_id)
    REFERENCES test.DELIVERY_COMPANY(id)
;

ALTER TABLE test.ORDER ADD CONSTRAINT fk_order_paymnets
    FOREIGN KEY (Payments_id)
    REFERENCES  test.PAYMENTS(id)
;

ALTER TABLE test.ORDER ADD CONSTRAINT fk_order_user
    FOREIGN KEY (user_id)
    REFERENCES test.USER(id)
;

ALTER TABLE test.CATEGORY_LIST ADD CONSTRAINT fk_category_in_list_category
    FOREIGN KEY (category_id)
    REFERENCES test.CATEGORY(id)
;

ALTER TABLE test.GOODS_DESCRIPTION ADD CONSTRAINT fk_fabricator_goods
    FOREIGN KEY (fabricator_Id)
    REFERENCES test.FABRICATOR(Id)
;

ALTER TABLE test.GOODS ADD CONSTRAINT fk_goods_description
    FOREIGN KEY (goods_description_id)
    REFERENCES test.GOODS_DESCRIPTION(id)
;

ALTER TABLE test.ORDER_GOODS ADD CONSTRAINT fk_goods_in_order
    FOREIGN KEY (order_Id)
    REFERENCES test.Order(Id)
;

ALTER TABLE test.ORDER_GOODS ADD CONSTRAINT fk_goods_in_order_goods
    FOREIGN KEY (goods_id)
    REFERENCES test.GOODS(id)
;

ALTER TABLE test.CATEGORY_LIST ADD CONSTRAINT fk_list_category
    FOREIGN KEY (goods_description_id)
    REFERENCES test.goods_description (id)
;