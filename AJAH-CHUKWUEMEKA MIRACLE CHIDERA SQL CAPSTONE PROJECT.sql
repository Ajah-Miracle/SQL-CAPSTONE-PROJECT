------------------- SQL CAPSTONE PROJECT(23/01/25)--------------------------------




1)------SORT CUSTOMER NAMES THAT SHARE SAME ADDRESS----

SELECT
customer.first_name, customer.last_name, address.address, count (address.address_id)
FROM
Customer 
INNER JOIN 
address
ON
customer.address_id = address.address_id
GROUP BY
customer.first_name, customer.last_name, address.address_id
HAVING
COUNT (address.address_id) >1;


2)------SORT THE NAME OF CUSTOMER WHO MADE THE HIGHEST TOTAL PAYMENT------

SELECT
customer.first_name,customer.last_name,SUM(payment.amount),payment.customer_id
FROM
customer
INNER JOIN payment
ON 
customer.customer_id=payment.customer_id
GROUP BY
customer.first_name,customer.last_name,payment.customer_id
ORDER BY
SUM(payment.amount)DESC
FETCH FIRST ROW ONLY;



3)------SORT THE MOVIE(S) THAT WAS RENTED THE MOST----

SELECT
title,rental_rate,film_id
FROM
film
GROUP BY
film_id,title,rental_rate
ORDER BY
SUM(rental_rate)DESC
LIMIT 336;



4)----SORT THE MOVIES THAT HAVE BEEN RENTED SO FAR-----

SELECT
title,rental_duration,rental_rate
FROM
film
ORDER BY
rental_duration,rental_rate ASC;



5)----SORT THE MOVIES THAT HAVE NOT BEEN RENTED SO FAR-----

SELECT
title,rental_duration,rental_rate
FROM
film
WHERE
rental_duration IS NULL
AND
rental_rate IS NULL
GROUP BY
title,rental_duration,rental_rate
ORDER BY
rental_duration,rental_rate ASC;



6)-----SORT CUSTOMERS WHO HAVE NOT RENTED ANY MOVIES SO FAR----

SELECT
customer.first_name,customer.last_name,customer.customer_id,rental.rental_date,rental.return_date
FROM
customer
INNER  JOIN
rental
ON
rental.customer_id=customer.customer_id
WHERE
rental.rental_date IS NULL
AND
rental.return_date IS NULL
GROUP BY
customer.first_name,customer.last_name,customer.customer_id,rental.rental_date,rental.return_date
ORDER BY
customer.first_name,customer.last_name,customer.customer_id,rental.rental_date,rental.return_date;




7)------SORT EACH MOVIE AND THE NUMBER OF TIMES  IT GOT RENTED---

SELECT
film.title, COUNT(rental.rental_id) AS rental_Count
FROM 
film 
INNER JOIN 
inventory 
ON 
film.film_id = inventory.film_id
LEFT JOIN 
rental  
ON 
inventory.inventory_id = rental.inventory_id
GROUP BY
film.title
ORDER BY 
rental_Count ASC;




8)----SORT THE FIRST NAME,LAST NAME AND NUMBER OF FILMS EACH ACTOR ACTED IN-----

SELECT
actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count
FROM
actor 
INNER JOIN 
film_actor
ON 
actor.actor_id = film_actor.actor_id
GROUP BY
actor.actor_id
ORDER BY 
film_count ASC;



9)-----SORT THE NAMES OF ACTORS THAT ACTED IN MORE THAN 20 MOVIES---

SELECT
actor.actor_id,actor.first_name,actor.last_name,film_actor.film_id
FROM
actor
INNER JOIN
film_actor
ON
actor.actor_id=film_actor.actor_id
GROUP BY
actor.actor_id,actor.first_name,actor.last_name,film_actor.film_id
HAVING
SUM(film_actor.film_id)>20;





10)---SORT THE MOVIES RATED ‘PG’ AND THE NUMBER OF TIMES THEY WERE RENTED----

SELECT
film.title, COUNT(rental.rental_id) AS rental_Count
FROM film 
INNER JOIN 
inventory 
ON 
film.film_id = inventory.film_id
INNER JOIN
rental 
ON
inventory.inventory_id = rental.inventory_id
WHERE
film.rating = 'PG'
GROUP BY film.title
ORDER BY rental_Count ASC;



11)….SORT MOVIES OFFERED FOR RENT IN STORE 1 AND NOT OFFERED IN STORE 2…

SELECT
film.film_id,store.store_id,title
FROM
film
JOIN
inventory
ON
inventory.film_id=film.film_id
JOIN
store
ON
inventory.store_id=store.store_id
WHERE
store.store_id=1;



12)--SORT MOVIES OFFERED FOR RENT IN ANY OF THE TWO STORES 1 OR 2-

SELECT DISTINCT
film.title
FROM
inventory 
INNER JOIN
film
ON 
inventory.film_id = film.film_id
WHERE
inventory.store_id IN (1,2);



13)--SORT MOVIE TITLES OF MOVIES OFFERED IN BOTH STORES AT THE SAME TIME--

SELECT DISTINCT
inventory.store_id,film.title
FROM
film
INNER JOIN
inventory
ON
inventory.film_id=film.film_id
ORDER BY
inventory.store_id;



14)--SORT THE MOVIE TITLE FOR THE MOST RENTED MOVIE IN STORE WITH STORE ID I--

SELECT DISTINCT
inventory.store_id,film.title,film.rental_rate
FROM
film
INNER JOIN
inventory
ON
inventory.film_id=film.film_id
WHERE
inventory.store_id=1
ORDER BY
film.rental_rate DESC;



15)---SORT MOVIES NOT OFFERED IN THE STORES (1 AND 2) YET FOR RENTAL---

SELECT DISTINCT
inventory.store_id,film.title,film.rental_rate
FROM
film
INNER JOIN
inventory
ON
inventory.film_id=film.film_id
WHERE
inventory.store_id IS NULL
ORDER BY
inventory.store_id;




16)--SORT THE NUMBER OF RENTED MOVIES UNDER EACH RATING--

SELECT  DISTINCT
rating,rental_rate,title
FROM
film
WHERE
rating IN('PG','G','PG-13','R','NC-17')
GROUP BY
rating,title,film_id
ORDER BY
rating ASC;




17)---SHOW THE PROFIT OF EACH OF THE STORES 1 AND 2----

SELECT
staff.store_id,SUM(payment.amount)
FROM
payment
INNER JOIN
staff
ON
staff.staff_id=payment.staff_id
GROUP BY
staff.store_id
ORDER BY
staff.store_id ASC;