use sakila;

-- bài 1
select title from film where length >= 120;
-- bài 2
SELECT title, `length`,rating FROM film WHERE `length` BETWEEN 90 AND 120 AND rating IN ('PG', 'G');
-- bài 3
select title, length from film order by length desc limit 10;
-- bài 4
SELECT customer.first_name,customer.last_name,cty.city FROM customer
JOIN address AS a ON customer.address_id = a.address_id
JOIN city AS cty ON a.city_id = cty.city_id;
-- bài 5 
SELECT co.country, COUNT(*) AS so_khach_hang FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country
HAVING COUNT(*) > 10
ORDER BY so_khach_hang DESC;
-- bài 6
SELECT category.name AS ten_the_loai, COUNT(film.film_id) AS so_luong_phim
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY so_luong_phim DESC;
-- bài 7
select customer.first_name,customer.last_name,count(rental.rental_id) as so_luong_thue
from customer
join rental on customer.customer_id = rental.customer_id
group by customer.customer_id,customer.first_name,customer.last_name
having count(rental.rental_id) >=30
order by so_luong_thue desc;
-- bài 8
-- cách 1
SELECT film_id, title, special_features
FROM film
WHERE special_features NOT LIKE '%English%';
-- cách 2 (các phim đều có ngôn ngữ tiếng anh nên sẽ không dùng cách này được )
SELECT f.film_id, f.title, l.name AS language_name
FROM film f
JOIN language l ON f.language_id = l.language_id
WHERE l.name != 'English';
-- bài 9
select city.city,sum(payment.amount) as tong_doanh_thu
from payment
join rental on payment.rental_id = rental.rental_id
join customer on rental.customer_id = customer.customer_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
group by city
having sum(payment.amount) > 500
order by tong_doanh_thu desc;
-- bài 10
select film.title as ten_phim,count(film_actor.actor_id) as so_luong_dien_vien
from film
join film_actor on film.film_id = film_actor.film_id
join actor on film_actor.actor_id = actor.actor_id
group by film.film_id, film.title
order by so_luong_dien_vien desc
limit 5;
-- bài 11
SELECT 
    c.name AS category_name,
    ci.city AS city_name,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN customer cu ON r.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name, ci.city
HAVING total_revenue > 10
ORDER BY total_revenue DESC;
-- buổi 4
-- bài 1
SELECT payment.staff_id,case 
	when hour(payment.payment_date) between 6 and 11  then 'Sáng'
    when hour(payment.payment_date) between 12 and 13  then 'Trưa'
    when hour(payment.payment_date) between 14 and 17  then 'Chiều'
    when hour(payment.payment_date) between 18 and 23  then 'Tối'
    else 'Khác'
    end as time_slot,
    sum(payment.amount) as total_revenue
    from payment
    group by payment.staff_id,time_slot
    having total_revenue > 200
    order by payment.staff_id, total_revenue desc;
    -- bài 2
    SELECT customer.customer_id,concat(customer.first_name,' ',customer.last_name) as full_name,sum(payment.amount) as total_payment,
			case
				when sum(payment.amount) > 200 then 'VIP'
                when sum(payment.amount) <= 200 and sum(payment.amount) > 100 then 'Tiềm năng'
                when sum(payment.amount) <= 100 then 'Mới'
			end as status
            from customer
		join payment on customer.customer_id = payment.customer_id
        group by customer.customer_id,full_name
        having total_payment > 0
        order by total_payment desc;
-- bài 3
	select inventory.store_id,film.film_id,film.title,
        case 
            when rental.inventory_id is not null and rental.return_date is null then 'Đang cho Thuê'
            else 'Có sẵn'
            end as stock_status
            from inventory
            join film on inventory.film_id = film.film_id
            left join rental on inventory.inventory_id = rental.inventory_id
            order by inventory.store_id,film.film_id;
            -- cách 2
SELECT 
    i.store_id,
    f.film_id,
    f.title,
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM rental r 
            WHERE r.inventory_id = i.inventory_id 
            AND r.return_date IS NULL
        ) THEN 'Đang cho thuê'
        ELSE 'Có sẵn'
    END AS stock_status
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
GROUP BY 
    i.store_id, f.film_id, f.title, i.inventory_id
ORDER BY 
    i.store_id, f.film_id;
            