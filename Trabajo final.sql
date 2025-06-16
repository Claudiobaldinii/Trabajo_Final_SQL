-- Proyecto Final: Consultas SQL
-- Autor: Claudio
-- Base de datos: Trabajo_Final
-- Máster en Análisis de Datos - ThePower School
-- ------------------------------------------------------
-- Cada consulta está numerada y precedida de su enunciado como comentario.
-- Escribe tu código SQL debajo de cada bloque.
-- ------------------------------------------------------


-- 1. Crea el esquema de la BBDD.

-- Creado correctamente 


-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

select distinct rating --Para saber las clasificaciones que hay--
from film f ;

select title , rating 
from film f 
where rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select concat(first_name ,' ', last_name) as Nombre_Apellido, actor_id 
from actor a 
where actor_id between 30 and 40;

SELECT CONCAT(first_name, ' ', last_name) AS Nombre_Apellido, actor_id
FROM actor a
WHERE actor_id >= 30 AND actor_id <= 40;



-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT title
FROM film
WHERE language_id = original_language_id; --El columna del lenguaje original solo tiene valors null--


-- 5. Ordena las películas por duración de forma ascendente.

select title, length 
from film f 
order by length asc;


-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

SELECT first_name, last_name
FROM actor
WHERE last_name ILIKE '%Allen%'; --Usaría esta ya que hace que no importen las mayusculas o minusculas--

SELECT first_name, last_name 
FROM actor
where last_name = 'ALLEN'; --Esta funciona tambien pero es mas probable que de error--



-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film”.

select count(title) as Cantidad_Peliculas , rating 
from film f 
group by f.rating 
order by Cantidad_Peliculas desc


-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas.

select title , rating, length 
from film f 
where rating = 'PG-13' or length > 180 --Por si acaso se que puedo omitir el seleccionar Rating o Length pero me gusta incluir para verificar que se hace la consulta correctamente--

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select variance(replacement_cost) as varianza
from film f 


-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select MIN(length ) as duracion_minima , MAX(length ) as duracion_maxima
from film f;


-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select rental_date , amount 
from rental r 
JOIN payment p ON r.rental_id = p.rental_id
order by r.rental_date desc --Ordemanos de forma descendente para que al marcar el offset nos salte el ultimo y antepenultimo
offset 2 limit 1


-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’.

select title , rating
from film f 
where rating not in ('NC-17', 'G')


-- 13. Encuentra el promedio de duración de las películas para cada clasificación.

select avg(length) as promedio_duracion, rating 
from film f 
group by f.rating 


-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select title 
from film f 
where length > 180


-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM(amount)
FROM payment p;


-- 16. Muestra los 10 clientes con mayor valor de id.

select concat(first_name , ' ', last_name) as clientes_mayor_valor_id
from customer c  
order by customer_id desc
limit 10

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor
from actor a 
JOIN film_actor fa   ON a.actor_id  = fa.actor_id
join film f    ON f.film_id   = fa.film_id 
WHERE title ILIKE '%Egg Igby%';

-- 18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT title
from film f;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos.

SELECT f.title, f.length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;



-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos.

SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110;


-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT AVG(rental_duration) AS promedio_dias_alquiler
FROM film;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM actor;


-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT DATE(rental_date) AS fecha, COUNT(*) AS cantidad_alquileres
FROM rental
GROUP BY DATE(rental_date)
ORDER BY cantidad_alquileres DESC;

-- 24. Encuentra las películas con una duración superior al promedio.

SELECT length , title 
from film f
WHERE length > (SELECT AVG(length) FROM film);

-- 25. Averigua el número de alquileres registrados por mes.

SELECT date_trunc('month', rental_date) as mes, count(rental_id)
FROM rental r 
GROUP BY date_trunc('month', rental_date)
order by mes asc;


-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select avg (amount) , stddev (amount) , variance (amount )
from payment p 



-- 27. ¿Qué películas se alquilan por encima del precio medio?

select rental_rate , title 
from film
where rental_rate > (
select avg (rental_rate)
from film
);

select avg(rental_rate)
from film --para verificar que esta por encima del promedio lo que la consulta anterior me obtiene--



-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

select actor_id , count(film_id) as Numero_de_peliculas
from film_actor fa 
group by actor_id
having count(film_id) > 40;




-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select title, count (inventory_id ) as Copias_disponibles
from film f 
left join inventory i  ON f.film_id = i.film_id 
group by f.title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

select first_name , last_name , count(film_id ) as Numero_De_Peliculas
from actor a 
join film_actor fa on fa.actor_id = a.actor_id
group by a.actor_id, a.first_name, a.last_name
order by numero_de_peliculas Desc


-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.title;


-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
ORDER BY a.last_name, a.first_name;


-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f.title, r.rental_date
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title;


-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT f.title, r.rental_date
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title;


-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT first_name , last_name as Actores_Primer_Nombre_Jhonny
FROM actor
where first_name = 'JOHNNY'


-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select first_name as Nombre, last_name as Apellido
from actor a 


-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select Min (actor_id) as Id_Mas_Bajo , max (actor_id ) as Id_Mas_Alto
from actor a 


-- 38. Cuenta cuántos actores hay en la tabla “actor”.

select COUNT(actor_id )
from actor a 


-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select Concat(first_name, ' ', last_name ) as Actores
from actor a 
order by a.last_name asc;


-- 40. Selecciona las primeras 5 películas de la tabla “film”.

select title 
from film f 
order by f.title asc
limit 5


-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre.

select first_name , count(first_name )
from actor a 
group by a.first_name 
order by a.first_name asc


-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT c.first_name, c.last_name, r.rental_date
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
ORDER BY r.rental_date;


-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT c.first_name, c.last_name, r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
ORDER BY c.last_name, c.first_name;



-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué?

select * 
from film f 
cross join category c 

-- Esta consulta genera todas las combinaciones posibles entre películas y categorías,
-- pero no aporta valor en este caso, porque no refleja relaciones reales.
-- Las asociaciones válidas entre películas y categorías deben hacerse con la tabla film_category.


-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select first_name , last_name , "name" 
from actor a 
join film_actor fa on fa.actor_id = a.actor_id
join film on film.film_id = fa.film_id
join film_category fc on fc.film_id = film.film_id
join category c on c.category_id = fc.category_id
where name = 'Action'

-- 46. Encuentra todos los actores que no han participado en películas.

select first_name , last_name 
from actor a 
left join film_actor fa on fa.actor_id = a.actor_id
where film_id is null;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select first_name , last_name , count(title) as Numero_de_peliculas
from actor a 
join film_actor fa on fa.actor_id = a.actor_id
join film on film.film_id = fa.film_id
group by first_name , last_name , fa.actor_id 
order by numero_de_peliculas desc;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;



-- 49. Calcula el número total de alquileres realizados por cada cliente.

create view Numero_total_de_alquileres as
select Customer_id, Count (rental_id) as numero_de_alquileres
from rental
group by customer_id

select * 
from Numero_total_de_alquileres

DROP VIEW IF exists Numero_total_de_alquileres --para eliminar si quiero modificarlo--

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT SUM(f.length) AS duracion_total_action
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action';

SELECT c.name, SUM(f.length) AS duracion_total_action
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

create temporary table cliente_rentas_temporal AS
select customer_id, count(rental_id) as Numero_de_alquileres
from rental
group by customer_id

select *
from cliente_rentas_temporal

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

create temporary table peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS num_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10; --recordamos que el having va antes del as, o sea, el alias, por lo que ponemos el count completo--

select *
from peliculas_alquiladas

DROP table IF exists peliculas_alquiladas


-- 53. Encuentra el título de las películas alquiladas por ‘Tammy Sanders’ que aún no se han devuelto.

SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name ILIKE 'Tammy' AND last_name ILIKE 'Sanders';

SELECT *
FROM rental r2 
JOIN inventory i  on i.inventory_id = r2.inventory_id
join film f  on f.film_id = i.film_id
JOIN customer c on c.customer_id = r2.customer_id
where first_name = 'TAMMY' and last_name = 'SANDERS'
AND r2.return_date IS NULL
ORDER BY f.title;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película de la categoría ‘Sci-Fi’.

select first_name , last_name 
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
where "name" = 'Sci-Fi'


-- 55. Encuentra actores que han actuado en películas alquiladas después que ‘Spartacus Cheaper’.

SELECT MIN(r.rental_date)
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE f.title = 'SPARTACUS CHEAPER';

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
  SELECT MIN(r2.rental_date)
  FROM film f2
  JOIN inventory i2 ON f2.film_id = i2.film_id
  JOIN rental r2 ON r2.inventory_id = i2.inventory_id
  WHERE f2.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name;



-- 56. Encuentra actores que no han actuado en ninguna película de la categoría ‘Music’.

SELECT first_name , last_name 
FROM actor a 
join film_actor fa on fa.actor_id = a.actor_id
join film f on f.film_id = fa.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
where "name" = 'Music'; --Lo hice para saber lo que me debe quitar, en si esta es la sub consulta, los nombres en esta lista no deben aparecer--

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
  SELECT fa.actor_id
  FROM film_actor fa
  JOIN film f ON fa.film_id = f.film_id
  JOIN film_category fc ON fc.film_id = f.film_id
  JOIN category c ON c.category_id = fc.category_id
  WHERE c.name = 'Music'
)
ORDER BY a.last_name;


-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT distinct title --Para que no se repitan las peliculas que se alquilen mas de 8 dias--
FROM rental r 
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
WHERE r.return_date - r.rental_date > INTERVAL '8 days'; -- mayor a un intervalo de 8 dias--

-- 58. Encuentra películas que sean de la misma categoría que ‘Animation’.

SELECT distinct title 
from film f 
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
where "name" = 'Animation'

-- 59. Encuentra películas que tienen la misma duración que ‘Dancing Fever’.

SELECT distinct title 
from film f 
where length = (
SELECT length 
from film 
where title = 'DANCING FEVER'
)
order by f.title;

-- 60. Encuentra clientes que han alquilado al menos 7 películas distintas.

select first_name , last_name , count (distinct f.film_id ) as Peliculas_Alquiladas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
group by c.first_name , c.last_name 
having count(f.film_id ) >= 7
order by count(f.film_id) asc;


-- 61. Encuentra cantidad total de películas alquiladas por categoría.

SELECT "name" , COUNT (rental_id ) as CANTIDAD_DE_PELICULAS_POR_GENERO
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
group by "name" 
order by COUNT (rental_id ) asc;

-- 62. Encuentra número de películas por categoría estrenadas en 2006.

select "name" , count (distinct title ) as Cantidad_peliculas_estrenadas_en_2006
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
where release_year = 2006
group by "name" , f.release_year 
order by count (distinct title ) desc


-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas.

select first_name , last_name , s2.store_id as Combinaciones_tiendas
from staff s 
cross join store s2 

-- Esta consulta genera un producto cartesiano entre todos los empleados y todas las tiendas,
-- mostrando todas las combinaciones posibles aunque no tengan relación real.
-- En este caso, no aporta valor práctico, ya que no refleja relaciones reales entre empleados y tiendas.
-- Podría ser útil solo en casos muy específicos como simulaciones o análisis hipotéticos.


-- 64. Total de películas alquiladas por cada cliente (ID, nombre, apellido, total).

select first_name , last_name , c.customer_id, count (rental_id ) as cantidad_alquiler
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
group by c.first_name , c.last_name , c.customer_id 
order by c.first_name 

