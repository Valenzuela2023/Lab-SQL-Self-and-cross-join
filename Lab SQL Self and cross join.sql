-- Lab | SQL Self and cross join
-- 1. Get all pairs of actors that worked together.
USE sakila;
SELECT DISTINCT a1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
                a2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id;


-- 2. Get all pairs of customers that have rented the same film more than 3 times
SELECT film_id, customer_id
FROM rental r 
INNER JOIN inventory i
ON r.inventory_id=i.inventory_id
GROUP BY film_id, customer_id
HAVING COUNT(*)>=3;

-- OTRO METODO (igual resultado):
USE sakila;
WITH table_rental AS (
SELECT r.customer_id, i.film_id, r.rental_id
FROM rental r 
INNER JOIN inventory i
ON r.inventory_id=i.inventory_id
)
SELECT t1.customer_id, t1.film_id, COUNT(DISTINCT t1.rental_id) AS conteo_alquileres
FROM table_rental t1
INNER JOIN table_rental t2
ON t1.customer_id=t2.customer_id AND t1.film_id=t2.film_id AND t1.rental_id <> t2.rental_id
GROUP BY t1.customer_id, t1.film_id
HAVING COUNT(DISTINCT t1.rental_id)>=3;

SELECT * FROM table_rental;

-- 3. Get all possible pairs of actors and films.
SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM actor a 
CROSS JOIN film f;