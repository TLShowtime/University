-- DROP PROCEDURE SP_Create_Propiedad
CREATE PROCEDURE SP_Create_Usuario (@inUsername varchar(100),@inContrasenna varchar(100),
									  @inTipoUsuario varchar(30))
AS BEGIN
	BEGIN TRY
		DECLARE @idUsuario int = NULL

		SELECT @idUsuario = U.Id 
		FROM dbo.Usuario U
		WHERE U.Username = @inUsername and U.Activo = 1

		IF @idUsuario IS NOT NULL
		BEGIN
			Print('El usuario ya existe')
			RETURN -5001
		END


		Insert dbo.Usuario (Username,Contrasenna,TipoUsuario,Activo)
		values(@inUsername ,@inContrasenna,@inTipoUsuario,1)

		RETURN 1
	END TRY
	BEGIN CATCH
		return @@ERROR *-1
	END CATCH
END;

EXEC SP_Create_Usuario 'zLiu','nada1234','cliente'

-- DROP PROCEDURE SP_Read_Usuario
CREATE PROCEDURE SP_Read_Usuario (@inUsername varchar(100))
AS BEGIN
	BEGIN TRY
		-- Si se desea ver todas las Propiedades
		IF @inUsername IS NULL OR @inUsername = ''
		BEGIN
			SELECT U.Username,U.Contrasenna,U.TipoUsuario
			From dbo.Usuario U
			where U.Activo = 1
			RETURN 2
		END

		DECLARE @idUsuario int = NULL

		SELECT @idUsuario = U.Id 
		FROM dbo.Usuario U
		WHERE U.Username = @inUsername and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario no existe')
			RETURN -5001
		END

		SELECT U.Username,U.Contrasenna,U.TipoUsuario
		From dbo.Usuario U
		where U.Id = @idUsuario and U.Activo = 1

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR *-1
	END CATCH
END;

EXEC SP_Read_Usuario 'zliu';

-- DROP PROC SP_Update_Usuario
CREATE PROC SP_Update_Usuario(@inUsuarioOriginal varchar(100),@inUsuarioNuevo varchar(100),
							  @inContrasenna varchar(100),@inTipoUsuario int) AS
BEGIN
	BEGIN TRY
		DECLARE @idUsuario int = NULL

		SELECT @idUsuario =U.Id 
		FROM dbo.Usuario U
		WHERE U.Username = @inUsuarioOriginal and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario no existe')
			RETURN -5001
		END

		-- Ver los espacios en blanco
		if (@inUsuarioNuevo IS NULL OR @inUsuarioNuevo = '')
		BEGIN 
			Select @inUsuarioNuevo = U.Username
			FROM dbo.Usuario U WHERE U.Id  = @idUsuario
		END

		-- Ver los espacios en blanco
		if (@inContrasenna IS NULL OR @inContrasenna = '')
		BEGIN 
			Select @inContrasenna = U.Contrasenna
			FROM dbo.Usuario U WHERE U.Id  = @idUsuario
		END

		DECLARE @TipoUsuario varchar(30);
		-- Ver los espacios en blanco
		IF @inTipoUsuario = 1
		Begin
		Set @TipoUsuario = 'administrador'
		End
		ELSE
		BEGIN
		SET @TipoUsuario = 'cliente'
		END

		UPDATE dbo.Usuario
		SET Usuario.Username = @inUsuarioNuevo,
			Usuario.Contrasenna = @inContrasenna,
			Usuario.TipoUsuario = @TipoUsuario
		WHERE Usuario.Id = @idUsuario and Usuario.Activo = 1

		return 1
	END TRY

	BEGIN CATCH
	return @@ERROR *-1
	END CATCH

END

EXEC SP_Update_Usuario 'zLiu','ZGuo','fasf',4

-- DROP PROCEDURE SP_Delete_Usuario
CREATE PROCEDURE SP_Delete_Usuario (@inUsername varchar(100))
AS BEGIN
	BEGIN TRY

		DECLARE @idUsuario int = NULL

		SELECT @idUsuario = U.Id 
		FROM dbo.Usuario U
		WHERE U.Username = @inUsername and U.Activo = 1

		IF @idUsuario IS NULL
		BEGIN
			Print('El usuario no existe')
			RETURN -5001
		END

		Update dbo.Usuario
		SET Usuario.Activo = 0
		where Usuario.Id = @idUsuario and Usuario.Activo = 1


		-- Eliminar Relacion con demas tablas
		Update dbo.UsuarioDePropiedad
		SET UsuarioDePropiedad.Activo = 0, UsuarioDePropiedad.FechaFinal = CONVERT(DATE,getDate())
		where UsuarioDePropiedad.UsuarioId = @idUsuario and UsuarioDePropiedad.Activo = 1

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR *-1
	END CATCH
END;

EXEC SP_Delete_Usuario 'zGuo'

SELECT * 
FROM dbo.UsuarioDePropiedad P
where P.Activo = 0

Select * from dbo.Usuario

EXEC SP_Read_Usuario ''