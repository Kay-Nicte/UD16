CREATE DATABASE  IF NOT EXISTS `actividades`;
USE `actividades`;


DROP TABLE IF EXISTS `almacenes`;
CREATE TABLE `almacenes` (
  `CODIGO` int NOT NULL,
  `LUGAR` varchar(255) NOT NULL,
  `CAPACIDAD` int NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `almacenes` VALUES (1,'Valencia',3),(2,'Barcelona',4),(3,'Bilbao',7),(4,'Los Angeles',2),(5,'San Francisco',8);


DROP TABLE IF EXISTS `fabricantes`;
CREATE TABLE `fabricantes` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fabricantes` VALUES (1,'Sony'),(2,'Creative Labs'),(3,'Hewlett-Packard'),(4,'Iomega'),(5,'Fujitsu'),(6,'Winchester');


DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRECIO` decimal(10,0) NOT NULL,
  `FABRICANTE` int NOT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `FABRICANTE` (`FABRICANTE`),
  CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`FABRICANTE`) REFERENCES `fabricantes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `articulos` VALUES (1,'Hard drive',240,5),(2,'Memory',120,6),(3,'ZIP drive',150,4),(4,'Floppy disk',5,6),(5,'Monitor',240,1),(6,'DVD drive',180,2),(7,'CD drive',90,2),(8,'Printer',270,3),(9,'Toner cartridge',66,3),(10,'DVD burner',180,2);


DROP TABLE IF EXISTS `cajas`;
CREATE TABLE `cajas` (
  `NUMREFERENCIA` varchar(255) NOT NULL,
  `CONTENIDO` varchar(255) NOT NULL,
  `VALOR` double NOT NULL,
  `ALMACEN` int NOT NULL,
  PRIMARY KEY (`NUMREFERENCIA`),
  KEY `ALMACEN` (`ALMACEN`),
  CONSTRAINT `cajas_ibfk_1` FOREIGN KEY (`ALMACEN`) REFERENCES `almacenes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cajas` VALUES ('0MN7','Rocks',180,3),('4H8P','Rocks',250,1),('4RT3','Scissors',190,4),('7G3H','Rocks',200,1),('8JN6','Papers',75,1),('8Y6U','Papers',50,3),('9J6F','Papers',175,2),('LL08','Rocks',140,4),('P0H6','Scissors',125,1),('P2T6','Scissors',150,2),('TU55','Papers',90,5);


DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRESUPUESTO` decimal(10,0) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `departamentos` VALUES (14,'IT',65000),(37,'Accounting',15000),(59,'Human Resources',240000),(77,'Research',55000);


DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `DNI` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `APELLIDOS` varchar(255) NOT NULL,
  `DEPARTAMENTO` int NOT NULL,
  PRIMARY KEY (`DNI`),
  KEY `DEPARTAMENTO` (`DEPARTAMENTO`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `empleados` VALUES (123234877,'Michael','Rogers',14),(152934485,'Anand','Manikutty',14),(222364883,'Carol','Smith',37),(326587417,'Joe','Stevens',37),(332154719,'Mary-Anne','Foster',14),(332569843,'George','O\'Donnell',77),(546523478,'John','Doe',59),(631231482,'David','Smith',77),(654873219,'Zacary','Efron',59),(745685214,'Eric','Goldsmith',59),(845657233,'Luis','López',14),(845657245,'Elizabeth','Doe',14),(845657246,'Kumar','Swamy',14),(845657266,'Jose','Pérez',77);


DROP TABLE IF EXISTS `peliculas`;
CREATE TABLE `peliculas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `CALIFICACIONEDAD` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `peliculas` VALUES (1,'Citizen Kane','PG'),(2,'Singin\' in the Rain','G'),(3,'The Wizard of Oz','G'),(4,'The Quiet Man',NULL),(5,'North by Northwest',NULL),(6,'The Last Tango in Paris','NC-17'),(7,'Some Like it Hot','PG-13'),(8,'A Night at the Opera',NULL),(9,'Citizen King','G');


DROP TABLE IF EXISTS `salas`;
CREATE TABLE `salas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PELICULA` int DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `PELICULA` (`PELICULA`),
  CONSTRAINT `salas_ibfk_1` FOREIGN KEY (`PELICULA`) REFERENCES `peliculas` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `salas` VALUES (1,'Odeon',5),(2,'Imperial',1),(3,'Majestic',NULL),(4,'Royale',6),(5,'Paraiso',3),(6,'Nickelodeon',NULL);

/*----------------------------------------------------------------------------------------------------
EJERCICIO 1
------------------------------------------------------------------------------------------------------*/
#1.1. Obtener los nombres de los productos de la tienda: 

SELECT nombre as "Nombre Artículo" FROM articulos;

#1.2. Obtener los nombres y los precios de los productos de la tienda

SELECT nombre as Artículo, precio as Precio FROM articulos;

#1.3. Obtener el nombre de los productos cuyo precio sea menor o igual a 200€

SELECT nombre as Artículo, precio as Precio
FROM articulos
WHERE precio <= 200;

#1.4. Obtener todos los datos de los artículos cuyo precio esté entre los 60€ y 120€ (ambas cantidades incluidas)

SELECT * 
FROM articulos
WHERE precio 
BETWEEN 60 AND 120;

#1.5. Obtener el nombre y el precio en pesetas (es decir, el precio en euros multiplicado por 166'386)

SELECT nombre as Artículo, precio as "Precio(€)", precio*166.386 as "Precio(pts)"
FROM articulos;

#1.6. Seleccionar el precio medio de todos los productos.

SELECT AVG(precio) as "Precio medio"
FROM articulos;

#1.7. Obtener el precio medio de los artículos cuyo código de fabricante sea 2.

SELECT fabricante as "Código Fabricante", AVG(precio) as "Precio medio"
FROM articulos
WHERE fabricante = 2;

#1.8. Obtener el número de artículos cuyo precio sea mayor o igual a los 180€.

SELECT COUNT(nombre) as "Nº Artículos"
FROM articulos
WHERE precio >= 180;

/*1.9. Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a 180€ y ordenadlos 
descendentemente por precio, y luego ascendentemente por nombre.*/

SELECT nombre, precio
FROM articulos 
WHERE precio >= 180
ORDER BY precio DESC, nombre ASC;

/*1.10. Obtener un listado completo de artículos, incluyendo por cada artículo los datos del artículo 
y de su fabricante.*/

SELECT a.codigo AS "ID Artículo", a.nombre as Artículo, a.precio , f.codigo AS "ID Fabricante", f.nombre as Fabricante
FROM articulos AS a
INNER JOIN fabricantes AS f
ON a.fabricante = f.codigo;

/*Nota: No he usado el asterisco porque necesitaba ponerles alias para que se entendiera mejor
-------------------------------------------------------------------------------------------------*/

/*1.11. Obtener un listado de artículos, incliyendo el nombre del artículo, su precio y el nombre de 
su fabricante.*/

SELECT a.*, f.nombre AS FABRICANTE
FROM articulos AS a
INNER JOIN fabricantes AS f
ON a.fabricante = f.codigo;

#1.12. Obtener el precio medio de los productos de cada fabricante, mostrando sólo los códigos de fabricante.

SELECT f.codigo as Fabricante, AVG(a.precio) AS "Precio medio"
FROM articulos AS a
INNER JOIN fabricantes AS f
ON a.fabricante = f.codigo
GROUP BY f.codigo;

#1.13. Obtener el precio medio de los productos de cada fabricante, mostrando el nombre del fabricante.

SELECT f.nombre as Fabricante, AVG(a.precio) AS "Precio medio"
FROM articulos AS a
INNER JOIN fabricantes AS f
ON a.fabricante = f.codigo
GROUP BY f.nombre
ORDER BY f.nombre;

#1.14. Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150€.

/*SELECT f.nombre AS Fabricante, AVG(a.precio) AS "Precio Medio"
FROM fabricantes AS f
INNER JOIN articulos AS a
ON a.fabricante = f.codigo
HAVING AVG(a.precio) >= 150;*/

#1.15. Obtener el nombre y precio del artículo más barato.

SELECT nombre, MIN(precio)
FROM articulos;

/*1.16. Obtener una lista con el nombre y precio de los artículos más caros de cada proveedor 
(incluyendo el nombre del proveedor).*/

SELECT f.nombre AS Proveedor, a.nombre AS Artículo, MAX(a.precio) AS Precio
FROM articulos AS a
INNER JOIN fabricantes AS f
ON a.fabricante = f.codigo
GROUP BY f.nombre;

#1.17. Añadir un nuevo producto: Altavoces de 70€ (del fabricante 2).

INSERT INTO `articulos` VALUES (11,'Altavoces',70,2);

#1.18. Cambiar el nombre del producto 8 a 'Impresora Láser'.

UPDATE articulos 
SET nombre = 'Impresora Láser' 
WHERE codigo = 8; 

#1.19. Aplicar un descuento del 10% (multiplicar el precio por el 0'9) a todos los productos.

UPDATE articulos 
SET precio = precio*0.9;

#1.20. Aplicar un descuento de 10€ a todos los productos cuyo precio sea mayor o igual a 120€.

UPDATE articulos 
SET precio = (precio-10)
WHERE precio >= 120;

/*----------------------------------------------------------------------------------------------------
EJERCICIO 2
------------------------------------------------------------------------------------------------------*/

#2.1. Obtener los apellidos de los empleados

SELECT apellidos
FROM empleados
ORDER BY apellidos;

#2.2. Obtener los apellidos de los empleados sin repeticiones

SELECT DISTINCT apellidos
FROM empleados
ORDER BY apellidos;

#2.3. Obtener todos los datos de los empleados que se apellidan 'Smith'.

SELECT *
FROM empleados
WHERE apellidos = 'Smith';

#2.4. Obtener todos los datos de los empleados que se apellidan 'Smith' y 'Rogers'.

SELECT *
FROM empleados
WHERE apellidos = 'Smith'
OR apellidos = 'Rogers';

#2.5. Obtener todos los datos de los empleados que trabajan para el departamento 14.

SELECT * 
FROM empleados
WHERE departamento = 14;

#2.6. Obtener todos los datos de los empleados que trabajan para el departamento 37 y para el departamento 77

SELECT * 
FROM empleados
WHERE departamento = 37
OR departamento = 77;

#2.7. Obtener todos los datos de los empleados cuyo apellido comience por 'P'.

SELECT * 
FROM empleados
WHERE apellidos LIKE 'P%';

#2.8. Obtener el presupuesto total de todos los departamentos

SELECT SUM(presupuesto) AS "Presupuesto total"
FROM departamentos;

#2.9. Obtener el número de empleados en cada departamento.

SELECT COUNT(nombre) AS "Nº empleados", departamento
FROM empleados
GROUP BY departamento;

#2.10. Obtener un listado completo de empleados, incluyendo por cada empleado los datos del empleado y de su departamento

SELECT e.*, d.*
FROM empleados AS e
INNER JOIN departamentos AS d
ON e.departamento = d.codigo;

#2.11. Obtener un listado completo de empleados, incluyendo el nombre y apellidos del empleado junto al nombre y presupuesto de su departamento.

SELECT e.nombre AS Nombre, e.apellidos AS Apellido, d.nombre AS Departamento, d.presupuesto AS Presupuesto
FROM empleados AS e
INNER JOIN departamentos AS d
ON e.departamento = d.codigo;

#2.12 Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor de 60.000€.

SELECT e.nombre AS Nombre, e.apellidos AS Apellido
FROM empleados AS e
INNER JOIN departamentos AS d
ON e.departamento = d.codigo
WHERE d.presupuesto > 60000;

#2.13 Obtener los datos de los departamentos cuyo presupuesto es superior al presupuesto medio de todos los departamentos

SELECT *
FROM departamentos
HAVING presupuesto > AVG(presupuesto);

#2.14 Obtener los nombres (únicamente los nombres) de los departamentos que tienen más de dos empleados

SELECT d.nombre
FROM departamentos AS d
INNER JOIN empleados AS e
ON d.codigo = e.departamento
HAVING COUNT(e.nombre) > 2;

#2.15. Añadir un nuevo departamento: 'Calidad', con presupuesto 40.000€ código 11. Añadir un empleado vinculado al departamento recién creado: Esther Vázquez, DNI: 89237109

INSERT INTO departamentos VALUE (19, 'Calidad', 40000);
INSERT INTO empleados VALUE(89267109, 'Esther', 'Vázquez', 19);

#2.16. Aplicar un recorte presupuestario del 10% a todos los departamentos.

UPDATE departamentos 
SET presupuesto = presupuesto*0.10;

#2.17. Reasignar a los empleados del departamento de investigación (código 77) al departamento de informática (código 14).

UPDATE empleados
SET departamento = 14
WHERE departamento = 77;

#2.18. Despedir a todos los empleados que trabajan para el departamento de informática (código 14).

DELETE FROM empleados WHERE departamento = 14;

#1.19. Despedir a todos los empleados que trabajen para departamentos cuyo presupuesto sea superior a los 60.000€.

DELETE FROM departamentos WHERE presupuesto > 60000;

#1.20. Despedir a todos los empleados;

DELETE FROM empleados;

/*----------------------------------------------------------------------------------------------------
EJERCICIO 3
------------------------------------------------------------------------------------------------------*/

#3.1. Obtener todos los almacenes

SELECT * 
FROM almacenes;

#3.2. Obtener todas las cajas cuyo contenido tenga un valor superior a 150€.

SELECT *
FROM cajas
WHERE valor > 150;

#3.3. Obtener los tipos de contenidos de las cajas.

SELECT DISTINCT contenido
FROM cajas;

#3.4. Obtener el valor medio de las cajas.

SELECT AVG(valor) AS "Valor medio"
FROM cajas;

#3.5. Obtener el valor medio de las cajas de cada almacén.

SELECT almacen, AVG(valor) AS "Valor medio"
FROM cajas
GROUP BY almacen;

#3.6. Obtener los códigos de los almacenes en los cuales el valor medio de las cajas sea superior a 150€.

SELECT a.codigo, AVG(c.valor)
FROM almacenes AS a
INNER JOIN cajas AS c
ON a.codigo = c.almacen
HAVING AVG(c.valor) > 150;

#3.7. Obtener el número de referencia de cada cada caja junto con el nombre de la ciudad en el que se encuentra

SELECT c.numreferencia, a.lugar
FROM cajas AS c
INNER JOIN almacenes AS a
ON c.almacen = a.codigo
ORDER BY a.lugar;

#3.8. Obtener el número de cajas que hay en cada almacén

SELECT almacen, COUNT(NUMREFERENCIA) AS "Total Cajas"
FROM cajas
GROUP BY almacen;

#3.9. Obtener los códigos de los almacenes que están saturados (los almacenes donde el número de cajas es superior a la capacidad).

SELECT c.almacen
FROM cajas AS c
INNER JOIN almacenes AS a
ON c.almacen = a.codigo
WHERE (SELECT COUNT(c.NUMREFERENCIA)) > a.capacidad
GROUP BY c.almacen;

#3.10. Obtener los números de referencia de las cajas que están en Bilbao.

SELECT c.numreferencia, a.lugar
FROM cajas AS c
INNER JOIN almacenes AS a
ON c.almacen = a.codigo
WHERE a.lugar = 'Bilbao';

#3.11. Insertar un nuevo almacén en Barcelona con capacidad para 3 cajas

INSERT INTO almacenes VALUE(6, 'Barcelona', 3);

#3.12. Insertar una nueva caja, con número de referencia 'H5RT', con contenido 'Papel', valor 200, y situada en el almacén 2.

INSERT INTO cajas VALUE('H5RT', 'Papel', 200, 2);

#3.13. Rebajar el valor de todas las cajas un 15%.

UPDATE cajas 
SET valor = valor*0.15;

#3.14. Rebajar un 20% el valor de todas las cajas cuyo valor sea superior al valor medio de todas las cajas.

UPDATE cajas 
SET valor = valor*0.20
WHERE valor > (SELECT AVG(valor));

#3.15. Eliminar todas las cajas cuyo valor sea inferior a 100€.

DELETE FROM cajas WHERE valor < 100;

#3.16.Vaciar el contenido de los almacenes que están saturados.

DELETE a.*
FROM almacenes AS a
INNER JOIN cajas AS c
ON a.codigo = c.almacen
WHERE(SELECT COUNT(c.NUMREFERENCIA)) > a.capacidad;