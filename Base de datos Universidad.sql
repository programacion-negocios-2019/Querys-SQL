/*
	Objetivo: Crear la base de datos para conocer LINQ to SQL
	Autor: Héctor Sabillón
	Fecha: 17/Julio/2019
*/

USE tempdb
GO

IF NOT EXISTS(SELECT * FROM sys.databases WHERE [name] = 'Universidad')
	BEGIN
		CREATE DATABASE Universidad
	END
GO

USE Universidad
GO

-- Esquema
CREATE SCHEMA Universidad
GO

-- Tablas
CREATE TABLE Universidad.Universidad (
	id INT NOT NULL IDENTITY (1, 1)
		CONSTRAINT PK_Universidad_Universidad_id PRIMARY KEY CLUSTERED,
	nombre NVARCHAR(100) NOT NULL
		CONSTRAINT AK_Universidad_Universidad_nombre UNIQUE NONCLUSTERED
)
GO

CREATE TABLE Universidad.Estudiante (
	id INT NOT NULL IDENTITY (100, 1)
		CONSTRAINT PK_Universidad_Estudiante_id PRIMARY KEY CLUSTERED,
	nombreCompleto NVARCHAR(200) NOT NULL,
	genero NVARCHAR(20) NOT NULL,
	idUniversidad INT NOT NULL
)
GO

CREATE TABLE Universidad.Clase (
	id INT NOT NULL IDENTITY (1000, 1)
		CONSTRAINT PK_Universidad_Clase_id PRIMARY KEY CLUSTERED,
	nombre NVARCHAR(100) NOT NULL
		CONSTRAINT AK_Universidad_Clase_nombre UNIQUE NONCLUSTERED
)
GO

CREATE TABLE Universidad.ClaseEstudiante (
	id INT NOT NULL IDENTITY (10000, 1),
	idEstudiante INT NOT NULL,
	idClase INT NOT NULL
)
GO

-- Llaves foráneas
ALTER TABLE Universidad.Estudiante
	ADD CONSTRAINT FK_Universidad_Estudiante$Pertenece$Universidad_Universidad
		FOREIGN KEY (idUniversidad) REFERENCES Universidad.Universidad(id)
		ON DELETE CASCADE
GO

ALTER TABLE Universidad.ClaseEstudiante
	ADD CONSTRAINT FK_Universidad_ClaseEstudiante$Tiene$Universidad_Estudiante
		FOREIGN KEY (idEstudiante) REFERENCES Universidad.Estudiante(id)
		ON DELETE CASCADE
GO

ALTER TABLE Universidad.ClaseEstudiante
	ADD CONSTRAINT FK_Universidad_ClaseEstudiante$Cursa$Universidad_Clase
		FOREIGN KEY (idClase) REFERENCES Universidad.Clase(id)
		ON DELETE CASCADE
GO