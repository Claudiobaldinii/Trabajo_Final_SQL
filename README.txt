# Proyecto Final - Consultas SQL (Base de datos tipo videoclub)

## 📌 Descripción

Este proyecto forma parte del trabajo final del máster de Análisis de Datos. Consiste en resolver una serie de ejercicios SQL usando una base de datos similar a Sakila, donde se gestionan películas, actores, clientes, alquileres, etc.

El objetivo principal era aplicar lo aprendido durante el máster y trabajar de forma ordenada con consultas SQL reales.

---

## 🗂️ Esquema de la base de datos

La base de datos incluye varias tablas relacionadas entre sí. Algunas de las más importantes son:

- `film`, `actor`, `category`
- `film_actor`, `film_category`
- `inventory`, `rental`, `customer`, `staff`, `store`, `payment`

Todas están conectadas por claves foráneas, así que para obtener la información completa en la mayoría de casos ha sido necesario combinar varias tablas con `JOIN`.

---

## 🧠 ¿Qué se ha hecho?

Se han resuelto **64 ejercicios SQL**, y todos están en el archivo `Trabajo final.sql`.  
Cada uno tiene su número y su enunciado como comentario, seguido de la consulta correspondiente.

El tipo de consultas varía bastante:

- **Simples**: selección de columnas, filtros y ordenamientos.
- **Con `JOIN`**: para conectar varias tablas.
- **Agregaciones y agrupaciones**: usando `GROUP BY`, `HAVING`, `COUNT`, `SUM`, etc.
- **Subconsultas**: en los ejercicios más complejos.
- **Tablas temporales y vistas**: creación de estructuras auxiliares.

Todo se ha hecho paso a paso, comprobando los resultados, y organizando el trabajo para que se entienda fácilmente.

---

## 🔧 Archivos incluidos

- Trabajo final.sql`: contiene las 64 consultas bien comentadas.
- BBDD_Proyecto
- README.txt: este es el archivo explicativo.

---

## ✅ Conclusión

Este proyecto ha servido como cierre perfecto para poner en práctica la parte de SQL del máster. He repasado desde lo básico hasta lo más complejo (subconsultas, tablas temporales, vistas…), y al final he conseguido resolver todo de forma estructurada y clara.

