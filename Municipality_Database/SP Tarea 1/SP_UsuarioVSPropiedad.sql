
-- DROP PROC SP_Create_UsuarioVSPropiedad
CREATE PROC SP_Create_UsuarioVSPropiedad (@inUsuario varchar(100),@inNumFinca int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumFinca and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END


		DECLARE @idUsuario int = NULL	
		
		SELECT @idUsuario  = U.Id
		FROM dbo.Usuario U
		where U.Username = @inUsuario and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario no existe')
			RETURN -5001
		END

		INSERT dbo.UsuarioDePropiedad(UsuarioId,PropiedadId,FechaInicio,Activo)
		values(@idUsuario,@idPropiedad,CONVERT(DATE,GETDATE()),1)

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

SELECT * from dbo.Usuario
EXEC SP_Create_Usuario  'ZLiu','fasfgasg','cliente'

EXEC SP_Create_UsuarioVSPropiedad 'ZLiu',6852677

Select * from dbo.UsuarioDePropiedad

-- DROP PROC SP_Read_UsuarioVSPropiedad
CREATE PROC SP_Read_UsuarioVSPropiedad (@inUsuario varchar(100),@inNumFinca int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumFinca and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END


		DECLARE @idUsuario int = NULL	
		
		SELECT @idUsuario  = U.Id
		FROM dbo.Usuario U
		where U.Username = @inUsuario and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario no existe')
			RETURN -5001
		END


		DECLARE @idUsuarioVSProp int = null

		SELECT @idUsuarioVSProp = UP.Id
		FROM dbo.UsuarioDePropiedad UP
		where UP.PropiedadId = @idPropiedad and (UP.UsuarioId = @idUsuario)

		IF @idUsuarioVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y el usuario')
			RETURN -5004
		END

		SELECT P.NumeroFinca,P.Valor,P.Direccion,U.Username,U.TipoUsuario
		FROM dbo.UsuarioDePropiedad UP
		inner join dbo.Propiedad P on UP.PropiedadId = P.Id
		inner join dbo.Usuario U on UP.UsuarioId = U.Id
		where UP.Id = @idUsuarioVSProp and UP.Activo = 1

		RETURN 1
	END TRY

	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Read_UsuarioVSPropiedad 'ZLiu',6852677


-- DROP PROC SP_Update_UsuarioVSPropiedad
CREATE PROC SP_Update_UsuarioVSPropiedad (@inUsuarioOriginal varchar(100),@inNumFincaOriginal int,
												 @inUsuarioNuevo varchar(100),@inNumFincaNuevo int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumFincaOriginal and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END


		DECLARE @idUsuario int = NULL	
		
		SELECT @idUsuario  = U.Id
		FROM dbo.Usuario U
		where U.Username = @inUsuarioOriginal and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario no existe')
			RETURN -5001
		END


		DECLARE @idUsuarioVSProp int = null

		SELECT @idUsuarioVSProp = UP.Id
		FROM dbo.UsuarioDePropiedad UP
		where UP.PropiedadId = @idPropiedad and (UP.UsuarioId = @idUsuario)

		IF @idUsuarioVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y el usuario')
			RETURN -5004
		END

		-- Obtener si hay espacios blancos
		IF @inNumFincaNuevo <= 0 OR @inNumFincaNuevo IS NULL
		BEGIN
			SET @inNumFincaNuevo = @inNumFincaOriginal
		END
		IF @inUsuarioNuevo = '' OR @inUsuarioNuevo IS NULL
		BEGIN
			SET @inUsuarioNuevo = @inUsuarioOriginal
		END

		SET @idPropiedad = null
		SET @idUsuario = null

		-- Verificar si existen los campos nuevos
		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumFincaNuevo and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca NUEVO no existe')
				RETURN -5001
			END

		SELECT @idUsuario  = U.Id
		FROM dbo.Usuario U
		where U.Username = @inUsuarioNuevo and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario NUEVO no existe')
			RETURN -5001
		END

		UPDATE dbo.UsuarioDePropiedad
		SET UsuarioDePropiedad.PropiedadId = @idPropiedad,
		UsuarioDePropiedad.UsuarioId= @idUsuario
		WHERE UsuarioDePropiedad.Id = @idUsuarioVSProp AND UsuarioDePropiedad.Activo = 1

		RETURN 1

	END TRY

	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Update_UsuarioVSPropiedad 'ZLiu',6852677,'asfga',0
EXEC SP_Read_UsuarioVSPropiedad 'ZLiu',6852677



-- DROP PROC SP_Delete_UsuarioVSPropiedad
CREATE PROC SP_Delete_UsuarioVSPropiedad (@inUsuario varchar(100),@inNumFinca int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumFinca and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END


		DECLARE @idUsuario int = NULL	
		
		SELECT @idUsuario  = U.Id
		FROM dbo.Usuario U
		where U.Username = @inUsuario and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario no existe')
			RETURN -5001
		END


		DECLARE @idUsuarioVSProp int = null

		SELECT @idUsuarioVSProp = UP.Id
		FROM dbo.UsuarioDePropiedad UP
		where UP.PropiedadId = @idPropiedad and (UP.UsuarioId = @idUsuario)

		IF @idUsuarioVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y el usuario')
			RETURN -5004
		END

		Update dbo.UsuarioDePropiedad
		SET UsuarioDePropiedad.Activo = 0,UsuarioDePropiedad.FechaFinal = CONVERT(DATE,getDate())
		where UsuarioDePropiedad.Id = @idUsuarioVSProp and UsuarioDePropiedad.Activo = 1

		RETURN 1
	END TRY

	BEGIN CATCH
			RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Delete_UsuarioVSPropiedad 'ZLiu',6852677
EXEC SP_Read_UsuarioVSPropiedad 'ZLiu',6852677
