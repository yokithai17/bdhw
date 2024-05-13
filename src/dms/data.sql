--- добавление людей к системе
SELECT users_create(15);

--- добавление Производителей
SELECT fabricator_create(15);


--- Добавление Доставщиков
SELECT delivery_create(15);


--- Добавление категорий
SELECT category_create(15);


-- Добавление Описаний
SELECT description_create(15);


-- Добавление предметов
SELECT goods_create(15);


-- Добавление Листа категорий
SELECT goods_list_create(15);


--- Добавление Заказ И оплата
SELECT order_create(30);


--- Добавление в список, того что было в заказе
SELECT order_goods_create(30);
