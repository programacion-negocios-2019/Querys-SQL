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