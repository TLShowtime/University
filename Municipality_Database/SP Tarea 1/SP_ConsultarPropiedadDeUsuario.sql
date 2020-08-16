-- DROP PROC SP_ConsultarPropiedadDeUsuario 
CREATE PROC SP_ConsultarPropiedadDeUsuario (@inUsername varchar(100))
AS
BEGIN
	BEGIN TRY
		IF (@inUsername IS NULL)
		BEGIN
			PRINT('Digite al menos un dato')
			return -5001
		END

		DECLARE @idUsuario int = NULL
		-- Busca el usuario
		Select @idUsuario = U.Id
		FROM dbo.Usuario U
		Where U.Username = @inUsername

		IF (@idUsuario IS NULL)
		BEGIN
			PRINT('No existe el usuario')
			return -5002
		END
		Print(@idUsuario)

		DECLARE @UsuarioConProp table(id int identity(1,1) not null,UsuarioId int not null,PropiedadId int not null) 

		Insert into @UsuarioConProp(UsuarioId,PropiedadId)
		Select UP.UsuarioId,UP.PropiedadId
		FROM dbo.UsuarioDePropiedad UP
		WHERE UP.UsuarioId = @idUsuario

		Select  U.Username,P.NumeroFinca,P.Valor,P.Direccion
		FROM @UsuarioConProp UP
		inner join  dbo.Propiedad P on  UP.PropiedadId = P.Id 
		inner join dbo.Usuario U on UP.UsuarioId = U.Id
		return 1
	END TRY
	BEGIN CATCH
		return @@ERROR * -1
	END CATCH
END

EXEC SP_ConsultarPropiedadDeUsuario 'EMadrigal'