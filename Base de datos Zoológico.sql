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