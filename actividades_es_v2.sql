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

/*UPDATE articulos 
SET precio = (precio*0.9);

SELECT * FROM articulos;*/

#1.20. Aplicar un descuento de 10€ a todos los productos cuyo precio sea mayor o igual a 120€.

/*UPDATE articulos 
SET precio = (precio-10)
WHERE precio >= 120;*/