-- DROP PROCEDURE SP_Read_Propiedad
CREATE PROCEDURE SP_Read_Propiedad (@inNumeroFinca int)
AS BEGIN
	BEGIN TRY
		-- Si se desea ver todas las Propiedades
		IF @inNumeroFinca IS NULL OR @inNumeroFinca = 0
		BEGIN
			SELECT P.NumeroFinca,P.Valor,P.Direccion
			From dbo.Propiedad P
			where P.Activo = 1
		END

		DECLARE @idPropiedad int = NULL

		SELECT @idPropiedad = P.Id 
		FROM dbo.Propiedad P
		WHERE P.NumeroFinca = @inNumeroFinca and P.Activo = 1

		IF @idPropiedad IS NULL
		BEGIN
			Print('El numero de finca no existe')
			RETURN -5001
		END

		SELECT P.NumeroFinca,P.Valor,P.Direccion
		From dbo.Propiedad P
		where P.Id = @idPropiedad and P.Activo = 1

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR *-1
	END CATCH
END;

EXEC SP_Read_Propiedad 1579482