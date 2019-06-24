/*
	Objetivo: Crear la base de datos Zoologico
	para utilizarla en el aprendizaje de la conectividad
	con C# WPF.
	Autor: Ing. Héctor Sabillón
	Fecha: 18/Junio/2019
*/

-- Seleccionar la base de datos por defecto
USE tempdb
GO

-- Crear la base de datos
IF NOT EXISTS(SELECT * FROM sys.databases WHERE [name] = 'Zoologico')
	BEGIN
		CREATE DATABASE Zoologico
	END
GO

-- Seleccionar la base de datos recién creada (o existente)
USE Zoologico
GO

-- Crear el esquema a utilizar
CREATE SCHEMA Zoo
GO

-- Crear la tabla Zoologico
CREATE TABLE Zoo.Zoologico (
	id INT NOT NULL IDENTITY
		CONSTRAINT PK_Zoologico_id PRIMARY KEY CLUSTERED,
	ciudad NVARCHAR(50) NOT NULL
)
GO

-- Crear la tabla Animal
CREATE TABLE Zoo.Animal (
	id INT NOT NULL IDENTITY
		CONSTRAINT PK_Animal_id PRIMARY KEY CLUSTERED,
	nombre NVARCHAR(50) NOT NULL
)
GO

-- Crear la tabla de relación entre los Zoológicos y los Animales
CREATE TABLE Zoo.AnimalZoologico (
	idZoologico INT NOT NULL,
	idAnimal INT NOT NULL
)
GO

-- Relaciones
ALTER TABLE Zoo.AnimalZoologico
	ADD CONSTRAINT
		FK_Zoo_AnimalZoologico$Pertenece$Zoo_Zoologico_id
		FOREIGN KEY (idZoologico) REFERENCES Zoo.Zoologico(id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
GO

ALTER TABLE Zoo.AnimalZoologico
	ADD CONSTRAINT
		FK_Zoo_AnimalZoologico$EsUn$Zoo_Animal_id
		FOREIGN KEY (idAnimal) REFERENCES Zoo.Animal(id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
GO

-- Insertar en las tablas
INSERT INTO Zoo.Zoologico (ciudad)
VALUES	('Yojoa'),
		('New York'),
		('Tokyo'),
		('Paris'),
		('Madrid'),
		('Zambrano')
GO

INSERT INTO Zoo.Animal (nombre)
VALUES	('Águila'),
		('Venado Cola Blanca'),
		('Cocodrilo'),
		('Jirafa'),
		('León'),
		('Mono'),
		('Tigre'),
		('Elefante'),
		('Zebra'),
		('Hipopótamo'),
		('Pinguinos'),
		('Lémur')
GO

INSERT INTO Zoo.AnimalZoologico (idZoologico, idAnimal)
VALUES	(1, 1),
		(1, 3),
		(1, 5),
		(2, 2),
		(2, 4),
		(2, 6),
		(3, 7),
		(3, 8),
		(3, 9),
		(4, 10),
		(4, 11),
		(4, 12),
		(5, 4),
		(5, 8),
		(5, 11),
		(6, 1),
		(6, 2),
		(6, 3),
		(6, 4),
		(6, 5),
		(6, 6),
		(6, 7),
		(6, 8),
		(6, 9),
		(6, 10),
		(6, 11),
		(6, 12)
GO
