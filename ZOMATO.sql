create database zomato;
use zomato;

select * from food; -- f_id , f_name, type
select * from menu;  -- menu_id, r_id, f_id, price
select * from order_details; -- id , order_id, fid
select * from orders; -- order_id,user_id,r_id,amount,date,partner_id,delivery_time,delivery_rating,resturant_rating 
select * from restaurants; -- rid , r_name , cuisine
select * from users;  -- user_id, name , email, password


--  1) find customers who have nevwe ordered

-- persons who ordered the items 
select distinct(user_id) from orders;

-- main query
select name from users where user_id not in 
        (select distinct(user_id) from orders);

-- 2) Average price per dish
select * from menu limit 5;

select f_id,avg(price) as 'avg_price_per' from menu
  group by f_id;

-- perform the join operations -- main query 
SELECT f.f_name, AVG(price) AS avg_price
FROM menu m
JOIN food f ON m.f_id = f.f_id
GROUP BY m.f_id, f.f_name;


-- 3) find top ressturants in terms of the number of orders for a given month

-- give the detail of the junes 
select * from orders where MONTHNAME(date) like 'JUNE';

-- for understandings 
select r.r_name,count(*) as 'month'
from orders o
join restaurants r
on o.r_id=r.r_id
where MONTHNAME(date) like 'may'
group by o.r_id,r.r_name
ORDER BY month desc;

-- 4) resturants with monthly sales>x for 

select * from orders limit 5;
select o.r_id,r.r_name ,sum(o.amount) as 'avgs' from orders o
join restaurants r on o.r_id=r.r_id
where monthname(date) like 'june'
group by o.r_id,r.r_name  having avgs>500 order by avgs desc;

-- 5) show all the orders details for a particular customers in a particular 
-- date range 

select * from users;  -- user_id ,name
select * from orders; -- order_id,user_id, date
select * from order_details; -- order_id, f_id
select * from food; -- f_id, f_name

SELECT o.order_id,r.r_name ,f.f_name 
FROM orders o 
JOIN restaurants r 
ON o.r_id=r.r_id
JOIN order_details od
ON o.order_id =od.order_id
JOIN food f 
ON f.f_id=od.f_id
WHERE user_id=(SELECT user_id FROM users WHERE name LIKE 'Vartika') 
AND date>'2022-06-10' AND date<'2022-07-10';

select * from users;





