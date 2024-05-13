--- 1. Вывести компание по доставки, которыми пользовались люди
--- А также вывести самую популярную доставку
select name, count(*) as cnt
from test.delivery_company as dc
inner join test.order as ord
on dc.id = ord.delivery_company_id
group by dc.name
having count(*) > 0
order by name desc;

select name, count(*) as cnt
from test.delivery_company as dc
inner join test.order as ord
on dc.id = ord.delivery_company_id
group by dc.name
having count(*) > 0
order by cnt desc
LIMIT 1;


--- 2. Вывести топ 3 востребованных предмета
select name, count(*) as cnt
from test.goods_description as gd
inner join test.goods as g
on gd.id = g.goods_description_id
inner join test.order_goods as og
on g.id = og.goods_id
GROUP by name
HAVING count(*) > 0
Order by cnt desc
LIMIT 3;


-- 3. Вывести всех пользователей, кто хотя бы 1 раз заказывал, а также топ 3 пользователя.
SELECT DISTINCT fname || ' ' || sname as user, COUNT(*) as cnt
FROM test.user as u
inner join test.order as o
	ON u.id = o.user_id
group by fname, sname
HAVING count(*) > 0
order by cnt desc;

SELECT DISTINCT fname || ' ' || sname as user, COUNT(*) as cnt
FROM test.user as u
inner join test.order as o
	ON u.id = o.user_id
group by fname, sname
HAVING count(*) > 0
order by cnt desc
LIMIT 3;

--- 4. Вывести сколько каждая компания по доставки заработала
select dc.name, sum(p.delivery_price) as sum
from test.delivery_company dc
inner join test.order o
    on o.delivery_company_id = dc.id
inner join test.Payments p
    on p.id =  o.Payments_id
GROUP by dc.name
ORDER BY sum desc;

--- 5. вывести предметы, которы не разу не заказывали
select gd.name
	from test.goods_description gd
inner join test.goods g
	on g.goods_description_id = gd.id
where g.id not in (
    select goods_id from test.order_goods
    group by goods_id
    HAVING count(*) > 0
);

--- 6. вывести предметы, которые произовдят
select f.name as fab_name, ARRAY_AGG(gd.name) as items
from test.fabricator f
	inner join test.goods_description gd
		on gd.fabricator_id = f.id
group by f.name;

--- 7. вывести производителей внутри какой нить категории
select f.name
from test.fabricator f
inner join test.goods_description gd
	on gd.fabricator_id = f.id
inner join test.category_list cl
	on cl.goods_description_id = gd.id
inner join test.category c
	on c.id = cl.category_id
where c.name = 'category_2';

--- 8. вывести последневого человека, сделавшего заказ
select u.fname
from test.user u
inner join test.order o
    on o.user_id = u.id
where o.create_date = (
    select create_date from test.order
	order by create_date desc
	limit 1
);


--- 9. вывеести первого человека, сделавшего заказ
select u.fname
from test.user u
inner join test.order o
    on o.user_id = u.id
where o.create_date = (
    select create_date from test.order
	order by create_date
	limit 1
);


--- 10. вывести среднее время доставки заказа для каждого пользователя
select 
	u.fname,
	avg(o.arrived_date - o.create_date)
from test.user u
inner join test.order o
 on o.user_id = u.id
group by u.fname, u.id
order by avg;


--- 11. Вывести среднее время ожидания 
select 
	avg(o.arrived_date - o.create_date)
from test.order o;

--- 12.
select u.fname, c.name
from test.user u
inner join test.order o
    on o.user_id = u.id
inner join test.order_goods og
    on og.order_id = o.id
inner join test.goods g
    on g.id = og.goods_id
inner join test.goods_description gd
    on gd.id = g.goods_description_id
inner join test.category_list cl
    on cl.goods_description_id = gd.id
inner join test.category c
    on c.id = cl.category_id
group by u.fname;

--- 13. Вывести производителя, который имеет больше всего категорий, а также список этих категорий
select f.name, ARRAY_AGG(c.name) as ctgrs
from test.fabricator f
inner join test.goods_description gd
	on gd.fabricator_id = f.id
inner join test.category_list cl
	on cl.goods_description_id = gd.id
inner join test.category c
	on c.id = cl.category_id
where f.name = (
	select f.name
	from test.fabricator f
	inner join test.goods_description gd
		on gd.fabricator_id = f.id
	inner join test.category_list cl
		on cl.goods_description_id = gd.id
	inner join test.category c
		on c.id = cl.category_id
	group by f.name
	order by count(c.id) desc
	limit 1
)
group by f.name;

--- 14. Вывечсти пользователя, с самым крупным заказом
select u.fname, max(p.delivery_price + p.goods_price) as prc 
from test.user u
    inner join test.order o
        on o.user_id = u.id
    inner join test.Payments p
        on p.id = o.Payments_id
group by u.fname
order by prc desc
limit 1;

--- 15. Ввывести самую крупную доставку, а также имя компание доставки.
select dc.name, max(p.delivery_price) as avg_prc
from test.delivery_company dc
inner join test.order o
    on o.delivery_company_id = dc.id
inner join test.Payments p
    on p.id = o.Payments_id
group by dc.name
order by avg_prc desc
limit 1;
