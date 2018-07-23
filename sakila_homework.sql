-- 1a.
SELECT first_name, last_name
FROM actor;

-- 1b.
SELECT CONCAT_WS(" ", `first_name`, `last_name`) AS Actor_Name
FROM actor;

-- 2a.
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE ('Joe%');

-- 2b.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE ('%GEN%');

-- 2c.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE ('%LI%')
ORDER BY 3,2;

-- 2d. 
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China' );

-- 3a.
ALTER TABLE actor
ADD column middle_name VARCHAR(30)
AFTER first_name;
SELECT * FROM actor

-- 3b.
ALTER TABLE actor
ALTER COLUMN middle_name blobs;

-- 3c.
ALTER TABLE actor
DROP COLUMN middle_name;

-- 4a.
SELECT last_name, COUNT(last_name) num_actors_with_name
FROM actor
GROUP BY 1
ORDER BY 2 DESC;

-- 4b. 
SELECT last_name, COUNT(last_name) num_actors_with_name
FROM actor
GROUP BY 1
HAVING num_actors_with_name > 1
ORDER BY 2 DESC;

-- 4c.
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172

-- 4d.
UPDATE actor
SET first_name = CASE
   WHEN first_name = 'HARPO'
   THEN 'GROUCHO'
   ELSE 'MUCHO GROUCHO'
END
WHERE actor_id = 172;

-- 5a.
SHOW CREATE TABLE sakila.address;

-- 6a. 
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a
ON s.address_id =   a.address_id;

-- 6b.
SELECT s.first_name, s.last_name, SUM(p.amount) total_payments
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
WHERE p.payment_date >='2005-08-01 00:00:00'
AND p.payment_date <'2005-09-01 00:00:00'
GROUP BY 1,2

-- 6c. 
SELECT f.title, COUNT(a.film_id) number_of_actors
FROM film f
JOIN film_actor a
ON f.film_id = a.film_id
GROUP BY 1
ORDER BY 2 DESC;

-- 6d. 
SELECT f.title, COUNT(*) 
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY 1;

-- 6e.
SELECT c.first_name, c.last_name, SUM(p.amount) total_spend
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY 1, 2
ORDER BY 2

-- 7a.
SELECT title FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%");

-- 7b. 
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
        
-- 7c. 
SELECT c.country, cu.last_name, cu.first_name, cu.email
FROM country c
JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';
 
 -- 7d.
 SELECT title, category
 from film_list
 WHERE category = 'Family'
 
 -- 7e.
 SELECT f.title, COUNT(r.inventory_id) num_rentals
 FROM rental r
 JOIN inventory i
 ON r.inventory_id = i.inventory_id
 JOIN film f
 ON i.film_id = f.film_id
 GROUP BY 1
 ORDER BY 2 DESC
 
 -- 7f.
SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);

-- 7g.
SELECT s.store_id, a.city_id, 

SELECT s.store_id, city, country
FROM store s
INNER JOIN customer cu
ON s.store_id = cu.store_id
INNER JOIN staff st
ON s.store_id = st.store_id
INNER JOIN address a
ON cu.address_id = a.address_id
INNER JOIN city ci
ON a.city_id = ci.city_id
INNER JOIN country coun
ON ci.country_id = coun.country_id;
WHERE country = 'CANADA' AND country = 'AUSTRAILA';

 -- 7h. 
SELECT name, SUM(p.amount)
FROM category c
JOIN film_category fc
JOIN inventory i
ON i.film_id = fc.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
JOIN payment p
GROUP BY name
LIMIT 5;

-- 8a.
CREATE VIEW top_five_grossing_genres AS

SELECT name, SUM(p.amount)
FROM category c
JOIN film_category fc
JOIN inventory i
ON i.film_id = fc.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
JOIN payment p
GROUP BY name
LIMIT 5;

-- 8b.
SELECT * FROM top_five_grossing_genres;

-- 8c.
DROP VIEW top_five_grossing_genres;