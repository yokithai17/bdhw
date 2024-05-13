CREATE VIEW ViewGoods AS
Select gd.name           as goods
     , f.name            as fabricator
     , ARRAY_AGG(c.name) as ctgr
FROM test.goods g
         inner join test.goods_description gd
                    on gd.id = g.goods_description_id
         inner join test.category_list cl
                    on cl.goods_description_id = gd.id
         inner join test.category c
                    on c.id = cl.category_id
         inner join test.fabricator f
                    on f.id = gd.fabricator_id
group by gd.name, f.name;


CREATE VIEW ViewOrdersFULL AS
SELECT o.arrived_date as arrived_date
     , o.create_date as create_date
     , dc.name as delivery_company
     , p.delivery_price as delivery_price
     , p.goods_price as goods_price
     , ARRAY_AGG(gd.name) as items
FROM test.order o
         INNER JOIN test.delivery_company dc
                    on dc.id = o.delivery_company_id
         INNER JOIN test.payments p
                    on p.id = o.Payments_id
         INNER JOIN test.order_goods og
                    on og.order_id = o.id
         INNER JOIN test.goods g
                    on g.id = og.goods_id
         INNER JOIN test.goods_description gd
                    on gd.id = g.goods_description_id
        GROUP BY o.arrived_date, o.create_date, dc.name, p.delivery_price, p.goods_price;

CREATE VIEW ViewOrdersMINI AS
SELECT o.arrived_date as arrived_date
     , p.goods_price + p.goods_price as order_price
     , ARRAY_AGG(gd.name) as items
FROM test.order o
         INNER JOIN test.delivery_company dc
                    on dc.id = o.delivery_company_id
         INNER JOIN test.payments p
                    on p.id = o.Payments_id
         INNER JOIN test.order_goods og
                    on og.order_id = o.id
         INNER JOIN test.goods g
                    on g.id = og.goods_id
         INNER JOIN test.goods_description gd
                    on gd.id = g.goods_description_id
GROUP BY o.arrived_date, o.create_date, dc.name, p.delivery_price, p.goods_price;

CREATE VIEW viewFabricator AS
SELECT f.name as fabricator
        , ARRAY_AGG(gd.name)
FROM test.fabricator f
        inner join test.goods_description gd on f.id = gd.fabricator_id
GROUP BY f.name;

SELECT * FROM viewFabricator;

SELECT * FROM ViewGoods;

SELECT * FROM  ViewOrdersFULL;

SELECT * FROM  ViewOrdersMINI;