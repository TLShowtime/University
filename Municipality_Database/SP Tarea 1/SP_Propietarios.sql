-- DROP PROCEDURE SP_Create_Propietario
CREATE PROCEDURE SP_Create_Propietario (@inValorTipoId int,@inNombre varchar(100),@inIdentificacion varchar(30)
										,@inValorTipoIdPersonaJ int,@inIdentificacionPersonaJ varchar(30)
										,@inEsJuridico int)
AS BEGIN
	BEGIN TRY
		DECLARE @idPropietario int = NULL
		DECLARE @idPersonaJuridica int = NULL

		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacion and P.Activo = 1
		
		SELECT @idPersonaJuridica = PJ.Id 
		FROM dbo.PersonaJuridica PJ,dbo.Propietario P
		WHERE (PJ.Identificacion = @inIdentificacionPersonaJ AND P.Identificacion = @inIdentificacion) and PJ.Activo = 1

		IF @idPropietario IS NOT NULL
		BEGIN
			Print('El Propietario existe')
			RETURN -5001
		END

		IF @idPersonaJuridica IS NOT NULL AND @inEsJuridico = 1
		BEGIN
			Print('El propietario juridico existe')
			RETURN -5001
		END

		DECLARE @idTipoId int = NULL
		DECLARE @idTipoIdPJ int = NULL
		
		SELECT @idTipoId = T.Id
		FROM dbo.TipoDocId T
		where T.Id = @inValorTipoId
		
		IF @idTipoId IS NULL
		BEGIN
			Print('El Tipo de Documento del propietario no es valido')
			RETURN -5001
		END

		SELECT @idTipoIdPJ = T.Id
		FROM dbo.TipoDocId T
		where T.Id = @inValorTipoIdPersonaJ
		
		IF @idTipoIdPJ IS NULL and @inEsJuridico = 1
		BEGIN
			Print('El Tipo de Documento del propietario juridico no es valido')
			RETURN -5001
		END

		Insert dbo.Propietario(ValorTipoDocId,Nombre,Identificacion,FechaCreacion,Activo) 
		values (
			@inValorTipoId,@inNombre,@inIdentificacion,CONVERT(DATE,GETDATE()),1
		)
		
		
		IF @inEsJuridico = 1
		BEGIN	
			DECLARE @idPersonaJuridicaNueva int

			SELECT @idPersonaJuridicaNueva =P.Id
			FROM dbo.Propietario P
			where P.Identificacion = @inIdentificacion and Activo = 1

			Insert dbo.PersonaJuridica(Id,ValorTipoDocId,Identificacion,Activo) 
			values (
				@idPersonaJuridicaNueva,@inValorTipoIdPersonaJ,@inIdentificacionPersonaJ,1
			)
		END
		
		RETURN 1
	END TRY
	BEGIN CATCH
		return @@ERROR *-1
	END CATCH
END;

EXEC SP_Create_Propietario 1,'Zhong Liu','401230456',0,'',0

SELECT * from dbo.PersonaJuridica inner join dbo.Propietario on PersonaJuridica.Id = Propietario.Id;

-- DROP PROCEDURE SP_Read_Propietario
CREATE PROCEDURE SP_Read_Propietario (@inIdentificacion varchar(30),@inIdentificacionPersonaJ varchar(30),@inEsJuridico int)
AS BEGIN
	BEGIN TRY
		-- Si se desea ver todos los propietarios
		IF (@inIdentificacion IS NULL OR @inIdentificacion = '') AND @inEsJuridico = 0 
		BEGIN
			SELECT P.Nombre,P.Identificacion,P.ValorTipoDocId
			From dbo.Propietario P
			where P.Activo = 1
			RETURN 2
		END

		IF (@inIdentificacion IS NULL OR @inIdentificacion  = '') AND (@inIdentificacionPersonaJ IS NULL OR @inIdentificacionPersonaJ  = '') AND @inEsJuridico = 1 
		BEGIN
			SELECT P.Nombre,P.Identificacion,P.ValorTipoDocId,PJ.Identificacion
			From dbo.PersonaJuridica PJ,dbo.Propietario P
			where P.Activo = 1 and PJ.Id = P.Id
			RETURN 2
		END
		---------------------------------------------
		DECLARE @idPropietario int = NULL
		declare @idPersonaJuridica int = null
		
		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacion and P.Activo = 1
		PRINT(@idPropietario)
		IF(@inEsJuridico = 1)
		BEGIN
			SELECT @idPersonaJuridica = PJ.Id 
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE (PJ.Identificacion = @inIdentificacionPersonaJ and P.Identificacion = @inIdentificacion) and PJ.Activo = 1
			PRINT(@idPropietario)
			PRINT(@idPersonaJuridica)
			IF @idPersonaJuridica IS NULL AND @idPropietario IS NULL
			BEGIN
				Print('El propietario Juridico no existe')
				RETURN -5001
			END

			SELECT PJ.ValorTipoDocId,PJ.Identificacion, P.Nombre,P.ValorTipoDocId,P.Identificacion
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE PJ.Activo = 1 and P.Activo = 1 and (PJ.Id = @idPersonaJuridica and P.Id = @idPropietario) and PJ.Id = P.Id
			
			RETURN 1
		END

		IF @idPropietario IS NULL
		BEGIN
			Print('El propietario no existe')
			RETURN -5001
		END

		SELECT P.ValorTipoDocId,P.Identificacion,P.Nombre
		FROM dbo.Propietario P
		where P.Activo = 1 and P.Id = @idPropietario

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR *-1
	END CATCH
END;

EXEC SP_Read_Propietario '647781624','301790528',0

SELECT PJ.Id,PJ.ValorTipoDocId,PJ.Identificacion, P.Nombre,P.ValorTipoDocId,P.Identificacion,P.Id
FROM dbo.PersonaJuridica PJ,dbo.Propietario P
WHERE PJ.Activo = 1 and P.Activo = 1 and  PJ.Id = P.Id
			

-- DROP PROC SP_Update_Propietario
CREATE PROC SP_Update_Propietario(@inIdentificacionOriginal varchar(30),@inIdentificacionPJOriginal varchar(30),@inValorTipoId int,@inNombre varchar(100),@inIdentificacion varchar(30)
										,@inValorTipoIdPersonaJ int,@inIdentificacionPersonaJ varchar(30)
										,@inEsJuridico int) AS
BEGIN
	BEGIN TRY
		DECLARE @idPropietario int = NULL
		DECLARE @idPersonaJuridica int = NULL

		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacionOriginal and P.Activo = 1
		
		SELECT @idPersonaJuridica = PJ.Id 
		FROM dbo.PersonaJuridica PJ,dbo.Propietario P
		WHERE (PJ.Identificacion = @inIdentificacionPJOriginal AND P.Identificacion = @inIdentificacionOriginal) and PJ.Activo = 1

		IF @idPropietario IS NULL
		BEGIN
			Print('El Propietario no existe')
			RETURN -5001
		END

		IF @idPersonaJuridica IS NULL AND @inEsJuridico = 1
		BEGIN
			Print('El propietario juridico no existe')
			RETURN -5001
		END
		-------- Verifica el tipo de Documentacion correcta
		DECLARE @idTipoId int = NULL
		DECLARE @idTipoIdPJ int = NULL
		
		SELECT @idTipoId = T.Id
		FROM dbo.TipoDocId T
		where T.Id = @inValorTipoId
		
		IF @idTipoId IS NULL
		BEGIN
			Print('El Tipo de Documento del propietario no es valido')
			RETURN -5001
		END

		SELECT @idTipoIdPJ = T.Id
		FROM dbo.TipoDocId T
		where T.Id = @inValorTipoIdPersonaJ
		
		IF @idTipoIdPJ IS NULL and @inEsJuridico = 1
		BEGIN
			Print('El Tipo de Documento del propietario juridico no es valido')
			RETURN -5001
		END
		-----------------------------------------------------------------------------

		-- Ver los espacios en blanco en propietarios
		if (@inIdentificacion IS NULL OR @inIdentificacion = '')
		BEGIN 
			Select @inIdentificacion = P.Identificacion
			FROM dbo.Propietario P WHERE P.Id  = @idPropietario
		END

		if (@inNombre IS NULL OR @inNombre = '')
		BEGIN 
			Select @inNombre = P.Nombre
			FROM dbo.Propietario P WHERE P.Id  = @idPropietario
		END

		if (@inValorTipoId IS NULL OR @inValorTipoId <= 0)
		BEGIN 
			Select @inValorTipoId = P.ValorTipoDocId
			FROM dbo.Propietario P WHERE P.Id  = @idPropietario
		END

		UPDATE dbo.Propietario
		SET Propietario.Identificacion = @inIdentificacion,
			Propietario.Nombre = @inNombre,
			Propietario.ValorTipoDocId = @inValorTipoId
		WHERE Propietario.Id = @idPropietario and Propietario.Activo = 1

		IF @inEsJuridico = 1
		BEGIN
			if (@inIdentificacionPersonaJ IS NULL OR @inIdentificacionPersonaJ = '')
			BEGIN 
				Select @inIdentificacionPersonaJ = P.Identificacion
				FROM dbo.PersonaJuridica P WHERE P.Id  = @idPersonaJuridica
			END

			if (@inValorTipoIdPersonaJ IS NULL OR @inValorTipoIdPersonaJ <= 0)
			BEGIN 
				Select @inValorTipoIdPersonaJ = P.ValorTipoDocId
				FROM dbo.PersonaJuridica P WHERE P.Id  = @idPersonaJuridica
			END	

			UPDATE dbo.PersonaJuridica
			SET PersonaJuridica.Identificacion = @inIdentificacionPersonaJ,
				PersonaJuridica.ValorTipoDocId = @inValorTipoIdPersonaJ
			WHERE PersonaJuridica.Id = @idPersonaJuridica and PersonaJuridica.Activo = 1

				
		END

		return 1
	END TRY

	BEGIN CATCH
	return @@ERROR *-1
	END CATCH

END

EXEC SP_Update_Propietario '5437673','301790528',1,'Ezequiel Z. Asociados','',4,'',1

EXEC SP_Read_Propietario '5437673','',0

-- DROP PROCEDURE SP_Delete_Propietario
CREATE PROCEDURE SP_Delete_Propietario (@inIdentificacion varchar(30),@inIdentificacionPersonaJ varchar(30),@inEsJuridico int)
AS BEGIN
	BEGIN TRY

		DECLARE @idPropietario int = NULL
		declare @idPersonaJuridica int = null
		
		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacion and P.Activo = 1
		
		IF(@inEsJuridico = 1)
		BEGIN
			SELECT @idPersonaJuridica = PJ.Id 
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE (PJ.Identificacion = @inIdentificacionPersonaJ and P.Identificacion = @inIdentificacion) and PJ.Activo = 1
			IF @idPersonaJuridica IS NULL AND @idPropietario IS NULL
			BEGIN
				Print('El propietario Juridico no existe')
				RETURN -5001
			END
		END

		IF @idPropietario IS NULL
		BEGIN
			Print('El propietario no existe')
			RETURN -5001
		END

		Update dbo.Propietario
		SET Propietario.Activo = 0
		where Propietario.Id = @idPropietario and Propietario.Activo = 1

		IF @inEsJuridico = 1
		BEGIN
			Update dbo.PersonaJuridica
			SET PersonaJuridica.Activo = 0
			where PersonaJuridica.Id = @idPersonaJuridica and PersonaJuridica.Activo = 1
		END

		-- Eliminar Relacion con demas tablas
		Update dbo.PropietarioDePropiedad
		SET PropietarioDePropiedad.Activo = 0, PropietarioDePropiedad.FechaFinal = CONVERT(DATE,getDate())
		where PropietarioDePropiedad.PropietarioId = @idPropietario and PropietarioDePropiedad.Activo = 1

		Update dbo.PropietarioDePropiedad
		SET PropietarioDePropiedad.Activo = 0, PropietarioDePropiedad.FechaFinal = CONVERT(DATE,getDate())
		where PropietarioDePropiedad.PropietarioId = @idPersonaJuridica and PropietarioDePropiedad.Activo = 1

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR *-1
	END CATCH
END;

EXEC SP_Delete_Propietario '206130789','3101359071',0 --IGNACIO BOGARIN MARIN

SELECT * 
FROM dbo.PropietarioDePropiedad P
where P.Activo = 0

Select * from dbo.PersonaJuridica
inner join dbo.Propietario on PersonaJuridica.Id = Propietario.Id
