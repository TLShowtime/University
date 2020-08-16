-- DROP PROC SP_Update_Propiedad
CREATE PROC SP_Update_Propiedad(@inNumFincaOriginal int,@inValor int,@inDireccion varchar(200),@inNumeroFincaNuevo int) AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = NULL

		SELECT @idPropiedad = P.Id 
		FROM dbo.Propiedad P
		WHERE P.NumeroFinca = @inNumFincaOriginal and P.Activo = 1

		IF @idPropiedad IS NULL
		BEGIN
			Print('El numero de finca no existe')
			RETURN -5001
		END

		-- Ver los espacios en blanco
		if (@inNumeroFincaNuevo IS NULL OR @inNumeroFincaNuevo<1)
		BEGIN 
			Select @inNumeroFincaNuevo = P.NumeroFinca
			FROM dbo.Propiedad P WHERE P.Id  = @idPropiedad
		END

		-- Ver los espacios en blanco
		if (@inValor IS NULL OR @inValor < 1)
		BEGIN 
			Select @inValor = CONVERT(INT,P.Valor)
			FROM dbo.Propiedad P WHERE P.Id  = @idPropiedad
		END

		-- Ver los espacios en blanco
		if (@inDireccion = '' OR @inDireccion IS NULL)
		BEGIN 
			Select @inDireccion = P.Direccion
			FROM dbo.Propiedad P WHERE P.Id  = @idPropiedad
		END

		UPDATE dbo.Propiedad
		SET Propiedad.NumeroFinca = @inNumeroFincaNuevo,
			Propiedad.Valor = CONVERT(MONEY,@inValor),
			Propiedad.Direccion = @inDireccion,
			Propiedad.FechaCreacion = CONVERT(DATE,getDate())
		WHERE Propiedad.Id = @idPropiedad and Propiedad.Activo = 1


		return 1
	END TRY

	BEGIN CATCH
	return @@ERROR *-1
	END CATCH

END

EXEC SP_Update_Propiedad 8765,0,'',0

