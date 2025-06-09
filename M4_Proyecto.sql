/*El esquema lo visualizo -> Base de datos "M4_ProyectoBBDD" > Esquemas > public
 * Si no me llevara directamente, lo seleccionaria en la barra superior. */
 

E2_ /* Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ

Analizamos la base de datos y vemos que la columna que necesitamos es "rating" de la tabla "film"*/

select "title" as "Título_Película", "rating" as "Clasificación_Edad"
from "film"

/*Solo necesitamos las que tengan una clasificación "R"*/

select "title" as "Título_Película", "rating" as "Clasificación_Edad"
from "film"
where "rating" = 'R'

/*Ahora ya no necesitamos ver la clasificación, así que solo nos quedamos con el nombre de la película*/

select "title" as "Título_Película"
from "film"
where "rating" = 'R'


/* E3_ Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40*/

select concat("first_name" , ' ' , "last_name") as "Nombre_Actor_Actriz"
from "actor"
where "actor_id" >= 30 and "actor_id" <= 40

select concat("first_name" , ' ' , "last_name") as "Nombre_Actor_Actriz"
from "actor"
where "actor_id" between '30' and '40'


/* E4_ Obtén las películas cuyo idioma coincide con el idioma original.
 Sale NULL porque la columna ""original_language_id" tiene todos sus valores "NULL"*/

select "title" as "Películas"
from "film"
where "original_language_id" = "language_id"


/* E5_ Ordena las películas por duración de forma ascendente
 Esa forma de ordenación es la que se ejecuta por defecto, aunque lo especificaré 
 para una mayor claridad y facilidad de entendimiento de futuros lectores*/

select "title" as "Título_Película" , "length" as "Minutos_Duración"
from "film"
order by "length" asc


/* E6_ Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su 
apellido.*/

select CONCAT("first_name" , ' ' , "last_name") as "Nombre_Actor_Actriz"
from "actor"
where "last_name" = 'ALLEN'


/* E7_ Encuentra la cantidad total de películas en cada clasificación de la tabla 
“filmˮ y muestra la clasificación junto con el recuento.*/

select "category_id" as "Género_Película", count("film_id") as "N_Película"
from "film_category"
group by "category_id"
order by "category_id" asc


/* E8_ Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una 
duración mayor a 3 horas en la tabla film. Tomo "Mayor a 3h como extrictamente, si hubiera 
incluir tres horas, se sustituiría por ""length" >= '180'"*/

SELECT "title" as "Título_Película" , "rating" as "Clasificación_Edad" , "length" as "Duración"
from "film"
where "length" > '180' or "rating" = 'PG-13'


/* E9_  Encuentra la variabilidad de lo que costaría reemplazar las películas.*/

select AVG("replacement_cost") as "CosteMedio_Reemplazamiento" , 
variance("replacement_cost") as "Varianza_CosteMedio_Reemplazamiento", 
stddev("replacement_cost") as "DesviaciónEstándar_CosteMedio"
from "film"


/* E10_ Encuentra la mayor y menor duración de una película de nuestra BBDD*/

select MIN("length") as "MÍNIMA_Duración" , MAX("length") as "MÁXIMA_Duración"
from "film"


/* E11_ Encuentra lo que costó el antepenúltimo alquiler ordenado por día. */

select "payment_id" as "Identificador_Alquiler" , "amount" as "Precio_Alquiler"
from "payment"
order by "payment_date" desc
offset 1
limit 1


/* E12_ Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC
17ʼ ni ‘Gʼ en cuanto a su clasificación.
El "order by" está porque me parece más cómodo que las películas estén agrupadas en función
de su clasificaciión por edad*/

SELECT "title" as "Título_Película" , "rating" as "Clasificación_Edad" 
from "film"
where "rating" <> 'NC-17' and "rating" <> 'G'
order by "rating"

SELECT "title" as "Título_Película" , "rating" as "Clasificación_Edad" 
from "film"
where "rating" not in ('NC-17' , 'G')
order by "rating"


/* E13_ Encuentra el promedio de duración de las películas para cada 
clasificación de la tabla film y muestra la clasificación junto con el 
promedio de duración. 
Entiendo que la categoría mencionada es la que se hace por edad (ej:PG-13) */

SELECT "rating" as "Clasificación_Edad" , AVG("length") as "Duración" 
from "film"
group by "rating"
order by "Duración" desc


/* E14_ Encuentra el título de todas las películas que tengan una duración mayor 
a 180 minutos. estrictamente mayor a 2h. */

SELECT "title" as "Nombre_Película" , "length" as "Duración"
from "film"
where "length" > '180'
order by "Duración" asc 


/* E15_ ¿Cuánto dinero ha generado en total la empresa? 
El dinero generado es el equivalente a la suma de todos los alquileres de todos clientes. */

select SUM("amount") as "Total_Ingresos"
from "payment"


/* E16_ Muestra a los 10 clientes con mayor valor de id*/

select distinct("customer_id")
from "payment"
order by "customer_id" desc
limit 10


/* E17_  Encuentra el nombre y apellido de los actores que aparecen en la 
película con título ‘Egg Igbyʼ */

/*select "film"."title" , "film"."film_id" , "film_actor"."actor_id"
from "film"
left join "film_actor"
on "film"."film_id" = "film_actor"."film_id"*/

select concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_Completo"
	from (select "film"."title" , "film"."film_id" , "film_actor"."actor_id"
	from "film"
	left join "film_actor"
	on "film"."film_id" = "film_actor"."film_id") as "title/film_id/actor_id"
left join "actor"
on "actor"."actor_id" = "title/film_id/actor_id"."actor_id"
where "title/film_id/actor_id"."film_id" = '274'


/*E17 II_ No sé seguir esta forma, pero se me ocurre una "alegal"
Como estamos buscando una película en concreto, podemos buscar en la tabla "film"
el "film_id" que le pertenece. Una vez hecho eso -> */

select concat("actor"."first_name" , ' ' , "actor"."last_name") as "Actores/Actrices_Egg Igby"
from "film_actor"
inner join "actor"
on "actor"."actor_id" = "film_actor"."actor_id"
where "film_id" = '274'


/* E18_ Selecciona todos los nombres de las películas únicos. */

select distinct("title") as "Nombre_Único_Película"
from "film"
order by "Nombre_Único_Película"


/* E19_ Encuentra el título de las películas que son comedias y tienen una 
duración mayor a 180 minutos en la tabla “filmˮ. */

/*Voy a tener que trabajar con tres tablas: "film", "film_category" y "category". Por ello, antes de nada,
 uno dos tablas con left join para mantener todos los regstron de la que contiene la identificación de tipo de película
 Una vez hecha la tabla auxiliar, se repite el proceso */

/* select "film"."film_id" , "film"."title" , "film_category"."category_id" , "film"."length"
from "film"
left join "film_category"
on "film"."film_id" = "film_category"."film_id" */

-- Sólo hay que ejecutar esto de abajo, lo de arriba lo dejé como parte del proceso

select "film_id/title/category_id"."title" , "category"."name" , "film_id/title/category_id"."length"
from (select "film"."film_id" , "film"."title" , "film_category"."category_id" , "film"."length"
	from "film"
	left join "film_category"
	on "film"."film_id" = "film_category"."film_id") as "film_id/title/category_id"
left join "category"
on "film_id/title/category_id"."category_id" = "category"."category_id"
where "film_id/title/category_id"."length" > '180' and "category"."name" = 'Comedy'


/* E20_ Encuentra las categorías de películas que tienen un promedio de 
duración superior a 110 minutos y muestra el nombre de la categoría 
junto con el promedio de duración. */





/* E21_ ¿Cuál es la media de duración del alquiler de las películas? */

select (avg("rental_date" - "return_date") - 2*avg("rental_date" - "return_date")) as "Duración_Media_Alquiler"
from "rental" 


/* E22_ Crea una columna con el nombre y apellidos de todos los actores y actrices. */

select concat("first_name", ' ' , "last_name") as "Nombre_Completo"
from actor


/* E23_ Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente 
He encontrado esa función en internet. Si no se aplica, se busca la coincidencia también teniendo
en cuenta la hora, lo cual no tiene mucho sentido. */

select count("rental_id") as "Número_Alquileres", cast("rental_date" as DATE) as "Fecha_Alquiler" 
from "rental"
group by "Fecha_Alquiler"
order by "Número_Alquileres" desc


/* E23_  Encuentra las películas con una duración superior al promedio. */

select "title" as "Películas_Largas" , "length" as "Duración"
from "film" 
where "length" > (select avg("length") 
				 from "film")
order by "length" desc
				 
select "title" as "Películas_Largas" , "length" as "Duración"
from "film"
group by "title", "length"
having "length" > (select AVG("length") 
				  FROM "film")
order by "length" desc

/* E25_ Averigua el número de alquileres registrados por mes. */

select count("rental_id") as "Alquileres_Por_Mes" , extract(month from "rental_date") as "Mes"
from "rental"
group by "Mes"
order by "Mes" asc


/* E26_ Encuentra el promedio, la desviación estándar y varianza del total pagado. */

select AVG("amount") as "CosteMedio_Alquiler" , 
       variance("amount") as "Varianza_CosteMedio_Alquiler", 
       stddev("amount") as "DesviaciónEstándar_CosteMedio_Alquiler"
from "payment"


/* E27_ ¿Qué películas se alquilan por encima del precio medio? */

select "payment_id" , "customer_id" , "staff_id" , "rental_id" 
from "payment"
group by "payment_id", "amount"
having "amount" > (select AVG("amount") 
				  FROM "payment")
order by "payment_id" asc

/* Visualizando el esquema no identifico ningún identificador único que pueda
relacionarse con la tabla obtenida. */


/* E28_ Muestra el id de los actores que hayan participado en más de 40 películas. */

select count("actor"."actor_id") > '40' as "Más_de_40Papeles", concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_completo"
from "actor"
right join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
group by "Nombre_completo"
order by "Más_de_40Papeles" desc


/* E29_ Obtener todas las películas y, si están disponibles en el inventario, 
mostrar la cantidad disponible. */

select "film"."title" as "Título_Película", "inventory"."film_id" as "Cantidad"
from "film"
full join "inventory"
on "film"."film_id" = "inventory"."inventory_id"
order by "Cantidad" asc

/* En cierta manera, si una película tiene un identificador de inventario, no tiene por
qué implicar que haya stock, pero en ete caso parece que sí. Se hace unión completa 
para no perder esas posibles películas sin stock en inventario. */ 


/* E30_ Obtener los actores y el número de películas en las que ha actuado */

select concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_Completo" , 
count("actor"."actor_id") as "N_Papeles"      
from "actor"
right join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
group by "Nombre_Completo"
order by "N_Papeles" desc


/* E31_ Obtener todas las películas y mostrar los actores que han actuado en ellas, 
incluso si algunas películas no tienen actores asociados. */

-- Similar a E29

select "title/film_id/actor_id"."title" as "Nombre_Película" , 
       concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_Completo"              
	from (select "film"."title" , "film"."film_id" , "film_actor"."actor_id"
	from "film"
	left join "film_actor"
	on "film"."film_id" = "film_actor"."film_id") as "title/film_id/actor_id"
left join "actor"
on "actor"."actor_id" = "title/film_id/actor_id"."actor_id"
order by "Nombre_Película" desc


/* E32_ Obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película. */

select  concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_Completo" ,  
       "title/film_id/actor_id"."title" as "Nombre_Película"             
	from (select "film"."title" , "film"."film_id" , "film_actor"."actor_id"
	from "film_actor"
	right join "film"
	on "film_actor"."film_id" = "film"."film_id") as "title/film_id/actor_id"
right join "actor"
on "actor"."actor_id" = "title/film_id/actor_id"."actor_id"
order by "Nombre_Completo" asc


/* E33_ Obtener todas las películas que tenemos y todos los registros de alquiler. */

select "film"."title" as "Nombre_Película" ,  
       "Registro"."rental_date" , "Registro"."return_date" , 
       "Registro"."customer_id"  
from (select "inventory"."film_id" , "rental"."rental_date" , "rental"."return_date" , 
       "rental"."customer_id" , "rental"."rental_id"
     from "inventory"
     full join "rental"
     on "inventory"."inventory_id" = "rental"."rental_id") as "Registro"
full join "film"
on "film"."film_id" = "Registro"."film_id"


/* E34_ Encuentra los 5 clientes que más dinero se hayan gastado con nosotros */

select concat("customer"."first_name" , ' ' , "customer"."last_name") as "Nombre_Cliente" , 
       sum("payment"."amount") as "Gasto_Por_Cliente"
from "payment"
left join "customer"
on "payment"."customer_id" = "customer"."customer_id"
group by concat("customer"."first_name" , ' ' , "customer"."last_name")
order by "Gasto_Por_Cliente" desc
limit 5

/* E35_ Selecciona todos los actores cuyo primer nombre es 'Johnny' */

select concat("first_name" , ' ' , "last_name") as "Nombre_Completo"
from "actor"
where "first_name" = 'JOHNNY'


/* E36_ Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido. */

select "first_name" as "Nombre" , "last_name" as "Apellido"
from "actor"


/* E37_ Encuentra el ID del actor más bajo y más alto en la tabla actor. */

select max("actor_id") , min("actor_id")
from "actor"


/* E38_ Cuenta cuántos actores hay en la tabla "actor". */

select count("actor_id")
from "actor"


/* E39_ Selecciona todos los actores y ordénalos por apellido en orden ascendente. */

select concat("first_name" , ' ' , "last_name") as "Nombre_Completo"
from "actor"
order by "last_name" asc


/* E40_ Selecciona las primeras 5 películas de la tabla “filmˮ. */

select "title" as "Nombre_Película"
from "film"
order by "Nombre_Película" asc 
limit 5

/* E41_ Agrupa los actores por su nombre y cuenta cuántos actores tienen el 
mismo nombre. ¿Cuál es el nombre más repetido. */

select "first_name" , count("first_name") as "Repeticiones_FirstName"
from "actor"
group by "first_name"
order by "Repeticiones_FirstName" desc

-- y si solo quieres el nombre más repetido
-- podríamos asegurar la inclusión de repetidos si aumentamos el límite

select "first_name" , count("first_name") as "Repeticiones_FirstName"
from "actor"
group by "first_name"
order by "Repeticiones_FirstName" desc
limit 1 


/* E42_ Encuentra todos los alquileres y los nombres de los clientes que los 
realizaron. */

select concat("customer"."first_name" , ' ' , "customer"."last_name") as "Nombre_Cliente", 
       count("payment"."customer_id") as "N_Alquileres"
from "customer"
left join "payment"
on "customer"."customer_id" = "payment"."customer_id"
group by "Nombre_Cliente"
order by "N_Alquileres" desc


/* E43_ Muestra todos los clientes y sus alquileres si existen, incluyendo 
aquellos que no tienen alquileres. */

select count(distinct("customer_id"))
from "rental"

/* Al haber 599 ids distintos en la tabla que registra los alquileres, 
asumo que todo cliente registrado ha hecho al menos un alquiler: */

select concat("customer"."first_name" , ' ' , "customer"."last_name") as "Nombre_Cliente", 
       count("payment"."customer_id") as "N_Alquileres"
from "customer"
left join "payment"
on "customer"."customer_id" = "payment"."customer_id"
group by "Nombre_Cliente"
order by "N_Alquileres" desc


/* E44_ Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor 
esta consulta? ¿Por qué? Deja después de la consulta la contestación. */

select * 
from "film"
cross join "category"

/* Personalmente no le veo demasiada utilidad. Si cruzas esas dos tablas, puede ser, por ejemplo, 
para atribuir la categoría de película correspondiente a cada una de las distintas cintas. 
Con un cross join hacemos que cada fila "film" se combine con cada una de las filas de "category".
Este join no requiere condición y por eso generaría una tabla innecesariamente extensa con un montón
de ruido y celdas y líneas inútiles. 

Como se ve en el enunciado 45, es util para generar una gran tabla que vas a poder filtrar, pero
es tan densa que para procesarla se tarda demasiado. */

/* E45_ Encuentra los actores que han participado en películas de la categoría 
'Action'. */

select concat("actor"."first_name" , ' ' , "last_name") as "Nombre_Completo"
from "actor"
cross join "film"
cross join "film_actor"
cross join "category"
cross join "film_category"
where "category"."name" = 'Action'

select distinct("Nombre_Completo")
from (select concat("actor"."first_name" , ' ' , "last_name") as "Nombre_Completo"
     from "actor"
     cross join "film"
     cross join "film_actor"
     cross join "category"
     cross join "film_category"
     where "category"."name" = 'Action')
     
select "Nombre_Completo" , count("Nombre_Completo")
from (select concat("actor"."first_name" , ' ' , "last_name") as "Nombre_Completo"
     from "actor"
     cross join "film"
     cross join "film_actor"
     cross join "category"
     cross join "film_category"
     where "category"."name" = 'Action')   
group by "Nombre_Completo"

     
/* E46_ Encuentra todos los actores que no han participado en películas. */

select * 
from "film_actor"
where "actor_id" is null 

select * 
from "film_actor"
where "actor_id" not BETWEEN 0 and 99999999999 

-- Todos los actores han participado en alguna película

/* E47_ Selecciona el nombre de los actores y la cantidad de películas en las 
que han participado. */

select count("film_actor"."actor_id")+1 as "N_Películas" , concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_Completo"
from "film_actor"
left join "actor"
on "film_actor"."actor_id" = "actor"."actor_id"
group by "Nombre_Completo"
order by "N_Películas" desc


/* E48_ Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres 
de los actores y el número de películas en las que han participado. */

create view "Actor_Num_Películas" as 
   select count("film_actor"."actor_id")+1 as "N_Películas" , 
          concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_Completo"
   from "film_actor"
   left join "actor"
   on "film_actor"."actor_id" = "actor"."actor_id"
   group by "Nombre_Completo"
   order by "N_Películas" desc

select *
from "Actor_Num_Películas"

-- Esto se puede usar para optimizar el código de las uniones cuando hay más de una


/* E49_ Calcula el número total de alquileres realizados por cada cliente. */

create view "CustomerID_CustomerName" as
   select "customer"."customer_id" as "Customer_Id" , 
       concat("customer"."first_name" , ' ' , "customer"."last_name") as "Nombre_Completo_Cliente"
   from "customer"
   left join "rental"
   on "customer"."customer_id" = "rental"."customer_id"

select "CustomerID_CustomerName"."Nombre_Completo_Cliente" , 
       count("CustomerID_CustomerName"."Customer_Id") as "N_Alquileres"
from "CustomerID_CustomerName"
right join "payment"
on "CustomerID_CustomerName"."Customer_Id" = "payment"."customer_id"
group by "CustomerID_CustomerName"."Nombre_Completo_Cliente"
order by "N_Alquileres" desc


/* E50_ Calcula la duración total de las películas en la categoría 'Action'. */

create view "FilmID_Título_CategoryID_Duración_ClasificaciónEdad" as
   select "film"."film_id" , "film"."title" as "Título", "film"."length" as "Duración" , 
       "film"."rating" as "Clasificación_Edad" , "film_category"."category_id"
   from "film"
   inner join "film_category"
   on "film"."film_id" = "film_category"."film_id"

select avg("Duración") as "Duración Media de Películas de acción (Minutos)"
from "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"
left join "category"
on "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."category_id" = "category"."category_id"
where "category"."name" = 'Action'


/* E51_ Crea una tabla temporal llamada “cliente_rentas_temporalˮ para 
almacenar el total de alquileres por cliente. */

--Esta tabla sirve para eso

select concat("customer"."first_name" , ' ' , "customer"."last_name") as "Nombre_Cliente", 
       count("payment"."customer_id") as "N_Alquileres"
from "customer"
left join "payment"
on "customer"."customer_id" = "payment"."customer_id"
group by "Nombre_Cliente"
order by "N_Alquileres" desc

-- La modificamos para conseguir hacer una tabla temporal igual

create temporary table “cliente_rentas_temporalˮ AS
   select concat("customer"."first_name" , ' ' , "customer"."last_name") as "Nombre_Cliente", 
       count("payment"."customer_id") as "N_Alquileres"
   from "customer"
   left join "payment"
   on "customer"."customer_id" = "payment"."customer_id"
   group by "Nombre_Cliente"
   order by "N_Alquileres" desc


/* E52_ Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las 
películas que han sido alquiladas al menos 10 veces */

create view "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID" as
   select "film"."film_id" , "film"."title" as "Título" ,  
       "Registro"."rental_date" , "Registro"."return_date" , 
       "Registro"."customer_id"  
   from (select "inventory"."film_id" , "rental"."rental_date" , "rental"."return_date" , 
       "rental"."customer_id" , "rental"."rental_id"
      from "inventory"
      full join "rental"
      on "inventory"."inventory_id" = "rental"."rental_id") as "Registro"
   full join "film"
   on "film"."film_id" = "Registro"."film_id"

create view "Película_VecesAlquilada" as
   select count("film_id") as "Veces_Alquilada" , "Título"
   from "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"
   group by "Título"
   order by "Veces_Alquilada"

create temporary table “peliculas_alquiladasˮ AS
   select * 
   from "Película_VecesAlquilada"
   where "Veces_Alquilada" > '10'
   order by "Veces_Alquilada"

-- Ninguna película ha sido alquilada más de 8 veces


/* E53_  Encuentra el título de las películas que han sido alquiladas por el cliente 
con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena 
los resultados alfabéticamente por título de película. */

   select * 
from "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"
full join "CustomerID_CustomerName"
on "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"."customer_id" =
   "CustomerID_CustomerName"."Customer_Id"
where "CustomerID_CustomerName"."Nombre_Completo_Cliente" = 'TAMMY SANDERS'

-- Todos los registros son antiguos pero la condición temporal sería... 
   
select * 
from "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"
full join "CustomerID_CustomerName"
on "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"."customer_id" =
   "CustomerID_CustomerName"."Customer_Id"
where "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"."rental_date" < '01/06/2025 00:00:00.000' 
      and "CustomerID_CustomerName"."Nombre_Completo_Cliente" = 'TAMMY SANDERS'
      

/* E54_  Encuentra los nombres de los actores que han actuado en al menos una 
película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados 
alfabéticamente por apellido. */

create view "FilmID_TítuloPelícula_Sci-Fi" as   
select "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."film_id" ,
       "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."Título" , 
       "category"."name" as "Género_Película"
from "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"
left join "category"
on "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."category_id" = "category"."category_id"
where "category"."name" = 'Sci-Fi' 

create view "ActorID_ActorName_FilmID" as
select "actor"."actor_id" , "film_actor"."film_id" , 
       concat("actor"."first_name" , ' ' , "actor"."last_name") as "Nombre_Actor"
from "film_actor"
inner join "actor"
on "film_actor"."actor_id" = "actor"."actor_id"

select distinct("Nombre_Actor")
from "FilmID_TítuloPelícula_Sci-Fi"
inner join "ActorID_ActorName_FilmID"
on "FilmID_TítuloPelícula_Sci-Fi"."film_id" = "ActorID_ActorName_FilmID"."film_id"
order by "Nombre_Actor" asc


/* E55_ Encuentra el nombre y apellido de los actores que han actuado en 
películas que se alquilaron después de que la película ‘Spartacus 
Cheaperʼ se alquilara por primera vez. Ordena los resultados 
alfabéticamente por apellido. */


/* E56_ Encuentra el nombre y apellido de los actores que no han actuado en 
ninguna película de la categoría ‘Musicʼ. */

create view "FilmID_Título_GéneroPelícula" as
select "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."film_id" ,
       "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."Título" , 
       "category"."name" as "Género_Película"
from "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"
left join "category"
on "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."category_id" = "category"."category_id"
where "category"."name" = 'Music'

create view "Actores_MÚSICA" as
select "ActorID_ActorName_FilmID"."actor_id" , "ActorID_ActorName_FilmID"."Nombre_Actor"
from "FilmID_Título_GéneroPelícula"
inner join "ActorID_ActorName_FilmID"
on "FilmID_Título_GéneroPelícula"."film_id" = "ActorID_ActorName_FilmID"."film_id"

select distinct(concat("actor"."first_name" , ' ' , "actor"."last_name")) 
from "actor"
inner join "Actores_MÚSICA"
on "actor"."actor_id" <> "Actores_MÚSICA"."actor_id"
order by concat("actor"."first_name" , ' ' , "actor"."last_name")


/* E58_ Encuentra el título de todas las películas que son de la misma categoría 
que ‘Animationʼ. */

select "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."film_id" ,
       "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."Título" , 
       "category"."name" as "Género_Película"
from "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"
left join "category"
on "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."category_id" = "category"."category_id"
where "category"."name" = 'Animation'


/* E60_ Encuentra los nombres de los clientes que han alquilado al menos 7 
películas distintas. Ordena los resultados alfabéticamente por apellido. */

select "CustomerID_CustomerName"."Nombre_Completo_Cliente" , 
       count("CustomerID_CustomerName"."Nombre_Completo_Cliente")
from "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"
left join "CustomerID_CustomerName"
on "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"."customer_id" = "CustomerID_CustomerName"."Customer_Id"
group by "CustomerID_CustomerName"."Nombre_Completo_Cliente"
order by "CustomerID_CustomerName"."Nombre_Completo_Cliente"


/*E61_  Encuentra la cantidad total de películas alquiladas por categoría y 
muestra el nombre de la categoría junto con el recuento de alquileres. */

select "category"."name" , 
       count("category"."name") as Cantidad
from "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"
left join "category"
on "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."category_id" = "category"."category_id"
group by "category"."name"
order by "category"."name" asc


/* E62_  Encuentra el número de películas por categoría estrenadas en 2006. */

select "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."release_year" , 
       "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."film_id" ,
       "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."Título" , 
       "category"."name" as "Género_Película"
from "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"
left join "category"
on "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."category_id" = "category"."category_id"
where "FilmID_Título_CategoryID_Duración_ClasificaciónEdad"."release_year" = '2006'
order by "category"."name"


/* E63_ Obtén todas las combinaciones posibles de trabajadores con las tiendas 
que tenemos. */

select concat("staff"."first_name" , ' ' , "staff"."last_name") as "NombreTrabajador" , 
       "store"."store_id" as "Id_Tienda"
from "staff"
cross join "store"


/* E64_ Encuentra la cantidad total de películas alquiladas por cada cliente y 
muestra el ID del cliente, su nombre y apellido junto con la cantidad de 
películas alquiladas. */

select count("CustomerID_CustomerName"."Customer_Id") as "Películas_Alquiladas", "CustomerID_CustomerName"."Nombre_Completo_Cliente" 
from "CustomerID_CustomerName"
left join "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"
on "CustomerID_CustomerName"."Customer_Id" = "FilmID_Título_FechaAlquiler_FechaDevolución_CustomerID"."customer_id"
group by "CustomerID_CustomerName"."Nombre_Completo_Cliente"
order by "Películas_Alquiladas" desc
















