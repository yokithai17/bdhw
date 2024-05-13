SELECT 'DROP VIEW ' || table_name || ';'
FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND table_name !~ '^pg_';

SELECT Concat('DROP TRIGGER ', Trigger_Name, ';')
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'your_schema';

ALTER TABLE test.ORDER
    DROP CONSTRAINT fk_older_delivery_company;

ALTER TABLE test.ORDER
    DROP CONSTRAINT fk_order_paymnets;

ALTER TABLE test.ORDER
    DROP CONSTRAINT fk_order_user;

ALTER TABLE test.CATEGORY_LIST
    DROP CONSTRAINT fk_category_in_list_category;

ALTER TABLE test.GOODS_DESCRIPTION
    DROP CONSTRAINT fk_fabricator_goods;

ALTER TABLE test.GOODS
    DROP CONSTRAINT fk_goods_description;

ALTER TABLE test.ORDER_GOODS
    DROP CONSTRAINT fk_goods_in_order;

ALTER TABLE test.ORDER_GOODS
    DROP CONSTRAINT fk_goods_in_order_goods;

ALTER TABLE test.CATEGORY_LIST
    DROP CONSTRAINT fk_list_category;

/*******************  DROPS  TABLES  *******************/

DROP TABLE IF EXISTS test.DELIVERY_COMPANY CASCADE;

DROP TABLE IF EXISTS test.ORDER ;

DROP TABLE IF EXISTS test.ORDER_GOODS;

DROP TABLE IF EXISTS test.PAYMENTS;

DROP TABLE IF EXISTS test.USER;

DROP TABLE IF EXISTS test.CATEGORY;

DROP TABLE IF EXISTS test.CATEGORY_LIST;

DROP TABLE IF EXISTS test.FABRICATOR;

DROP TABLE IF EXISTS test.GOODS;

DROP TABLE IF EXISTS test.GOODS_DESCRIPTION;
