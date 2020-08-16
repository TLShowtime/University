-- DROP PROCEDURE SP_Create_Propiedad
CREATE PROCEDURE SP_Create_Propiedad (@inValor int,@inDireccion varchar(200),
									  @inNumeroFinca int)
AS BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = NULL

		SELECT @idPropiedad = P.Id 
		FROM dbo.Propiedad P
		WHERE P.NumeroFinca = @inNumeroFinca and P.Activo = 1

		IF @idPropiedad IS NOT NULL
		BEGIN
			Print('El numero de finca ya existe')
			RETURN -5001
		END

		Insert dbo.Propiedad (Valor,Direccion,NumeroFinca,FechaCreacion,Activo)
		values(cast (@inValor as Money) ,@inDireccion,@inNumeroFinca,CONVERT(DATE,GETDATE()),1)

		RETURN 1
	END TRY
	BEGIN CATCH
		return @@ERROR *-1
	END CATCH
END;

EXEC SP_Create_Propiedad 123451,'esquina de barrio',696969

Select* from dbo.Propiedad

delete dbo.Propiedad
where NumeroFinca = 696969
