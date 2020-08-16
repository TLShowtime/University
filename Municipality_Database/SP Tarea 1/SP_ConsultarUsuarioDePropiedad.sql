-- DROP PROC SP_ConsultarUsuarioDePropiedad
CREATE PROC SP_ConsultarUsuarioDePropiedad (@inNumFinca int)
AS
BEGIN
	Begin try

		IF (@inNumFinca IS NULL)
		BEGIN
			PRINT('Digite al menos un dato')
			return -5001
		END

		DECLARE @idPropiedad int = NULL
		-- Busca la propiedad
		Select @idPropiedad = P.Id
		FROM dbo.Propiedad P
		Where P.NumeroFinca = @inNumFinca

		IF (@idPropiedad IS NULL)
		BEGIN
			PRINT('No existe la propiedad')
			return -5002
		END
		Print(@idPropiedad)

		DECLARE @UsuarioConProp table(id int identity(1,1) not null,UsuarioId int not null,PropiedadId int not null) 

		Insert into @UsuarioConProp(UsuarioId,PropiedadId)
		Select UP.UsuarioId,UP.PropiedadId
		FROM dbo.UsuarioDePropiedad UP
		WHERE UP.PropiedadId = @idPropiedad

		Select  U.Username
		FROM @UsuarioConProp UP
		inner join dbo.Usuario U on UP.UsuarioId = U.Id
	end try
	begin catch
		return @@ERROR * -1
	end catch
END

EXEC SP_ConsultarUsuarioDePropiedad 1568495