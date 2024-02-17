-- CODING TEMPLE MODULE 4 - Joing and SubQuery Homework


-- USED TO FIND WHICH TABLES CONTAIN A SPECIFIC COLUMN NAME
--SELECT Table_Name, 
--    Column_Name
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_CATALOG = 'test_db'
--   AND COLUMN_NAME LIKE '%staff_id%';


-- Q1. List all customers who live in Texas (use JOINs)
select dif_join_customer.first_name, dif_join_customer.last_name, dif_join_customer.customer_state
from dif_join_customer
full outer join join_customer
on dif_join_customer.customer_state = join_customer.customer_state 
where dif_join_customer.customer_state = 'TX';

-- Q2. Get all payments above $6.99 with the Customer's Full Name 
select first_name, last_name, amount
from customer
inner join payment
on customer.customer_id = payment.customer_id
where amount > 6.99
and first_name IS not null
and last_name is not NULL;

-- Q3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name
from customer
where customer_id in (
		select  customer_id 
		from payment
		WHERE amount > 175
);

-- Q4. List all customers that live in Nepal (use the city table)
select first_name, last_name
from customer
where address_id in(
	select address_id 
	from address
	where city_id in (
		select city_id
		from city
		where country_id in (
			select country_id
			from country
			where country='Nepal'
		)
	)
);

-- Q5. Which staff member had the most transactions?
select staff.staff_id, first_name, last_name, count(staff.staff_id)
from staff
inner join rental
on staff.staff_id = rental.staff_id 
group by staff.staff_id;

-- Q6. How many movies of each rating are there?
select rating, count (rating)
from film
group by rating;

-- Q7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer_id, first_name, last_name from customer
where customer_id in (
	select customer_id 
	from payment
	where amount > 6.99
);

-- Q8. How many free rentals did our store give away?
select count(amount)
from payment
where amount = 0;
