-- bài 1
create index idx_customer_firstname on customer(firstname);

select * from customer where last_name = "WILLIAMS";

EXPLAIN SELECT * FROM customer WHERE last_name = 'WILLIAMS';

-- bài 2
create index idx_customer_store_lastname on customer(store_id,last_name);

select * from customer where store_id = 1 and last_name = "WILLIAMS";

-- BÀI 3
select * from customer order by last_name asc;

create index idx_customer_lastname on customer(last_name);

-- bài 4
 DELIMITER //
 create procedure sp_list_actors()
 begin
	select * from actor;
	end //
 CALL sp_list_actors();

-- bài 5 
DELIMITER //
	create procedure sp_rental_by_customer(IN p_customer_id INT)
    begin
		select * from rental where customer_id = p_customer_id;
        end //
 CALL sp_rental_by_customer(1);

 -- bài 6
	DELIMITER //
    CREATE procedure sp_total_payment(IN p_customer_id INT, OUT total_amount decimal(10,2))
    begin
		SELECT SUM(amount)
        into total_amount
        FROM payment
        where customer_id = p_customer_id;
        end//
CALL sp_total_payment(1, @total);
SELECT @total;

-- bài 7
	CREATE VIEW v_film_short_info AS
	SELECT title, description, release_year
	FROM film;
-- bài 8
	CREATE VIEW v_customer_payment AS
	SELECT c.customer_id, c.first_name, c.last_name, p.amount, p.payment_date
	FROM customer c
	JOIN payment p ON c.customer_id = p.customer_id;
-- bài 9
	CREATE VIEW v_active_customers AS
	SELECT * 
	FROM customer
	WHERE active = 1
	WITH CHECK OPTION;

 