--*Base de datos de Newspaper
--*Fecha de creacion: 13-09-2023

CREATE DATABASE Newspapr

CREATE TABLE categorias(
  id int PRIMARY KEY AUTO_INCREMENT,
  denominacion varchar(50)
)

CREATE TABLE imagenes(
  id int PRIMARY KEY AUTO_INCREMENT,
  ruta varchar(250) NOT NULL,
  alt varchar(50) NOT NULL
)

CREATE TABLE estados(
  id int PRIMARY KEY AUTO_INCREMENT,
  denominacion varchar(50)
)

CREATE TABLE mensajes(
  id int PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(30) NOT NULL,
  email varchar(250) NOT NULL,
  mensaje mediumtext NOT NULL,
  estado_id int NOT NULL,
  FOREIGN KEY (estado_id) REFERENCES estados(id)
)

CREATE TABLE noticias(
  id int PRIMARY KEY AUTO_INCREMENT,
  titulo varchar(250) NOT NULL,
  autor varchar(50) NOT NULL,
  categoria_id int NOT NULL,
  imagen_id int NOT NULL,
  fecha_hora datetime NOT NULL,
  texto longtext NOT NULL,
  estado_id int NOT NULL,
  FOREIGN KEY (estado_id) REFERENCES estados(id),
  FOREIGN KEY (categoria_id) REFERENCES categorias(id),
  FOREIGN KEY (imagen_id) REFERENCES imagenes(id)
)

----------------------------------------------------------------------------------------?

CATEGORIAS:
  => Educacion
  => Economia
  => Internacional
  => Salud
  => Politica
  => Deporte
  => Entretenimiento

INSERT INTO categorias(denominacion)
VALUES ('Educacion'),
      ('Economia'),
      ('Internacional'),
      ('Salud'),
      ('Politica'),
      ('Deporte'),
      ('Entretenimiento')

ESTADOS:
  => Activo
  => Inactivo
  => Enviado
  => Pendiente

INSERT INTO estados(denominacion)
VALUES ('Activo'),
      ('Inactivo'),
      ('Enviado'),
      ('Pendiente')