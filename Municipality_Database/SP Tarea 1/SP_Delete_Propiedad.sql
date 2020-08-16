-- DROP PROCEDURE SP_Delete_Propiedad
CREATE PROCEDURE SP_Delete_Propiedad (@inNumeroFinca int)
AS BEGIN
	BEGIN TRY

		DECLARE @idPropiedad int = NULL

		SELECT @idPropiedad = P.Id 
		FROM dbo.Propiedad P
		WHERE P.NumeroFinca = @inNumeroFinca and P.Activo = 1

		IF @idPropiedad IS NULL
		BEGIN
			Print('El numero de finca no existe')
			RETURN -5001
		END

		Update dbo.Propiedad
		SET Propiedad.Activo = 0
		where Propiedad.Id = @idPropiedad and Propiedad.Activo = 1


		-- Eliminar Relacion con demas tablas
		Update dbo.CCenPropiedad
		SET CCenPropiedad.Activo = 0, CCenPropiedad.FechaFinal = CONVERT(DATE,getDate())
		where CCenPropiedad.PropiedadId = @idPropiedad and CCenPropiedad.Activo = 1

		Update dbo.PropietarioDePropiedad
		SET PropietarioDePropiedad.Activo = 0, PropietarioDePropiedad.FechaFinal = CONVERT(DATE,getDate())
		where PropietarioDePropiedad.PropiedadId = @idPropiedad and PropietarioDePropiedad.Activo = 1

		Update dbo.UsuarioDePropiedad
		SET UsuarioDePropiedad.Activo = 0, UsuarioDePropiedad.FechaFinal = CONVERT(DATE,getDate())
		where UsuarioDePropiedad.PropiedadId = @idPropiedad and UsuarioDePropiedad.Activo = 1


		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR *-1
	END CATCH
END;

EXEC SP_Delete_Propiedad 1579482

SELECT * 
FROM dbo.CCenPropiedad P
where P.Activo = 0

SELECT * 
FROM dbo.UsuarioDePropiedad P
where P.Activo = 0

SELECT * 
FROM dbo.PropietarioDePropiedad P
where P.Activo = 0

SELECT * FROM
dbo.Propiedad P
where P.Activo = 0