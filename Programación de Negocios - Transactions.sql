-- Transacciones
USE tempdb
GO

CREATE DATABASE TrialTransaction
GO

USE TrialTransaction
GO

CREATE SCHEMA Persona
GO

CREATE TABLE Persona.Persona (
	Id NVARCHAR(5) NOT NULL
		CONSTRAINT PK_Persona_Persona_Id PRIMARY KEY CLUSTERED,
	Nombre NVARCHAR(100) NOT NULL,
	Empresa NVARCHAR(100)
)
GO

CREATE TABLE Persona.DetallePersona (
	IdPersona NVARCHAR(5) NOT NULL,
	Direccion TEXT
)
GO

ALTER TABLE Persona.DetallePersona
	ADD CONSTRAINT
		FK_Persona_Persona$TieneUnaOMas$Persona_DetallePersona
		FOREIGN KEY (IdPersona) REFERENCES Persona.Persona(Id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
GO

-- Insertar valores
INSERT INTO Persona.Persona
VALUES	('JohnC', 'John Connor', 'La Resistencia'),
		('T30', 'Terminator T30', 'Skynet')
GO

INSERT INTO Persona.DetallePersona
VALUES	('JohnC', 'Los Ángeles'),
		('T30', 'Seattle')
GO

-- Realizar la transacción
CREATE PROCEDURE Persona.sp_Transaccion_Persona_Detalle
	@idPersona NVARCHAR(5),
	@nombre NVARCHAR(100),
	@empresa NVARCHAR(100),
	@idPersonaAnterior NVARCHAR(5)
AS
	DECLARE @errorInsercion INT
	DECLARE @errorEliminacion INT
	DECLARE @errorMax INT

	SET @errorMax = 0

	BEGIN TRANSACTION
		-- Agregar una persona
		INSERT INTO Persona.Persona (Id, Nombre, Empresa)
		VALUES (@idPersona, @nombre, @empresa)

		-- Guardar el número de error en caso de que el INSERT
		-- retorne error.
		SET @errorInsercion = @@ERROR
		IF @errorInsercion > @errorMax
			SET @errorMax = @errorInsercion

		-- Eliminar una persona
		SELECT @errorEliminacion = COUNT(Id)
		FROM Persona.Persona
		WHERE Id = @idPersonaAnterior

		IF @errorEliminacion > 0
			BEGIN
				DELETE FROM Persona.Persona
				WHERE Id = @idPersonaAnterior
			END
		ELSE
			BEGIN
				-- Como DELTE no retorna error al momento de
				-- tratar de eliminar un registro que no existe,
				-- creamos nuestro propio valor de error.
				SET @errorEliminacion = 1000
				SET @errorMax = @errorEliminacion
			END

		-- Si ocurre un error en cualquier parte de la ejecución
		-- de la transacción, realizar un ROLLBACK.
		IF @errorMax <> 0
			BEGIN
				ROLLBACK
				PRINT 'La transacción no se ha realizado (ROLLED BACK).'
			END
		ELSE
			BEGIN
				COMMIT
				PRINT 'La transacción se ha realizado correctamente (COMMITED).'
			END

		PRINT 'Número de error al momento de insertar: ' + CAST(@errorInsercion AS NVARCHAR(8))
		PRINT 'Número de error al momento de eliminar: ' + CAST(@errorEliminacion AS NVARCHAR(8))

		RETURN @errorMax
	GO
	-- =============================================================================================================
	
	-- Comprobar la transacción
	EXEC Persona.sp_Transaccion_Persona_Detalle 'Peter', 'Peter Parker', NULL, 'Existe'
	EXEC Persona.sp_Transaccion_Persona_Detalle 'María', NULL, NULL, 'Existe'
	EXEC Persona.sp_Transaccion_Persona_Detalle 'Peter', 'Peter Parker', 'Daily Mail', 'T30'

	SELECT * FROM Persona.DetallePersona