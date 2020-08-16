
-- DROP PROC SP_Create_PropietariosVsPropiedades 
CREATE PROC SP_Create_PropietariosVsPropiedades (@inNumeroFinca int,@inIdentificacion varchar(30),
												 @inIdentificacionPJ varchar(30),@inEsJuridico int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumeroFinca and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END

		DECLARE @idPropietario int = NULL
		declare @idPersonaJuridica int = null
	
		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacion and P.Activo = 1
		
		IF(@inEsJuridico = 1)
		BEGIN
			SELECT @idPersonaJuridica = PJ.Id 
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE (PJ.Identificacion = @inIdentificacionPJ and P.Identificacion = @inIdentificacion) and PJ.Activo = 1
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

		INSERT dbo.PropietarioDePropiedad (PropiedadId,PropietarioId,FechaInicio,Activo)
		values(@idPropiedad,@idPropietario,CONVERT(DATE,GETDATE()),1)

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;


EXEC SP_Create_Propiedad 124512,'Estados Unidos',123
EXEC SP_Create_PropietariosVsPropiedades 123,'401230456','',0
Select * from dbo.PropietarioDePropiedad

-- DROP PROC SP_Read_PropietariosVsPropiedades
CREATE PROC SP_Read_PropietariosVsPropiedades (@inNumeroFinca int,@inIdentificacion varchar(30),
												 @inIdentificacionPJ varchar(30),@inEsJuridico int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumeroFinca and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END

		DECLARE @idPropietario int = NULL
		declare @idPersonaJuridica int = null
	
		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacion and P.Activo = 1
		
		IF(@inEsJuridico = 1)
		BEGIN
			SELECT @idPersonaJuridica = PJ.Id 
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE (PJ.Identificacion = @inIdentificacionPJ and P.Identificacion = @inIdentificacion) and PJ.Activo = 1
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

		DECLARE @idPropVSProp int = null

		SELECT @idPropVSProp = PP.Id
		FROM dbo.PropietarioDePropiedad PP
		where PP.PropiedadId = @idPropiedad and (PP.PropietarioId = @idPropietario)

		IF @idPropVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y el propietario')
			RETURN -5004
		END

		IF @inEsJuridico = 1
		BEGIN
			SELECT P.NumeroFinca,P.Valor,P.Direccion,J.Identificacion,J.Nombre,PJ.ValorTipoDocId,pj.Identificacion
			FROM dbo.PropietarioDePropiedad PP
			inner join dbo.Propiedad P on PP.PropiedadId = P.Id
			inner join dbo.Propietario J on PP.PropietarioId = J.Id
			inner join dbo.PersonaJuridica PJ on PP.PropietarioId = PJ.Id
			where PP.Id = @idPropVSProp AND PP.Activo = 1
	
			RETURN 1
		END

		SELECT P.NumeroFinca,P.Valor,P.Direccion,J.Identificacion,J.Nombre
		FROM dbo.PropietarioDePropiedad PP
		inner join dbo.Propiedad P on PP.PropiedadId = P.Id
		inner join dbo.Propietario J on PP.PropietarioId = J.Id
		where PP.Id = @idPropVSProp and PP.Activo = 1

		RETURN 1
	END TRY

	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Read_PropietariosVsPropiedades 123,'401230456','',0

-- DROP PROC SP_Update_PropietariosVsPropiedades
CREATE PROC SP_Update_PropietariosVsPropiedades (@inNumeroFincaOriginal int,@inIdentificacionOriginal varchar(30),
												 @inIdentificacionPJOriginal varchar(30),
												 @inNumeroFincaNuevo int,@inIdentificacionNuevo varchar(30),
												 @inIdentificacionPJNuevo varchar(30)
												 ,@inEsJuridico int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumeroFincaOriginal and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END

		DECLARE @idPropietario int = NULL
		declare @idPersonaJuridica int = null
	
		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacionOriginal and P.Activo = 1
		
		IF(@inEsJuridico = 1)
		BEGIN
			SELECT @idPersonaJuridica = PJ.Id 
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE (PJ.Identificacion = @inIdentificacionPJOriginal and P.Identificacion = @inIdentificacionOriginal) and PJ.Activo = 1
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

		DECLARE @idPropVSProp int = null

		SELECT @idPropVSProp = PP.Id
		FROM dbo.PropietarioDePropiedad PP
		where PP.PropiedadId = @idPropiedad and (PP.PropietarioId = @idPropietario)

		IF @idPropVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y el propietario')
			RETURN -5004
		END

		-- Obtener si hay espacios blancos
		IF @inNumeroFincaNuevo <= 0 OR @inNumeroFincaNuevo IS NULL
		BEGIN
			SET @inNumeroFincaNuevo = @inNumeroFincaOriginal
		END
		IF @inIdentificacionNuevo = '' OR @inIdentificacionNuevo IS NULL
		BEGIN
			SET @inIdentificacionNuevo = @inIdentificacionOriginal
		END
		IF @inIdentificacionPJNuevo = '' OR @inIdentificacionPJNuevo IS NULL
		BEGIN
			SET @inIdentificacionPJNuevo = @inIdentificacionPJOriginal
		END

		SET @idPropiedad = null
		SET @idPropietario = null
		SET @idPersonaJuridica = null

		-- Verificar si existen los campos nuevos
		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumeroFincaNuevo and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca NUEVA no existe')
				RETURN -5001
			END
		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacionOriginal and P.Activo = 1
		
		IF(@inEsJuridico = 1)
		BEGIN
			SELECT @idPersonaJuridica = PJ.Id 
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE (PJ.Identificacion = @inIdentificacionPJOriginal and P.Identificacion = @inIdentificacionOriginal) and PJ.Activo = 1
			IF @idPersonaJuridica IS NULL AND @idPropietario IS NULL
			BEGIN
				Print('El propietario Juridico NUEVO no existe')
				RETURN -5001
			END
		END
		
		IF @idPropietario IS NULL
		BEGIN
			Print('El propietario NUEVO no existe')
			RETURN -5001
		END

		UPDATE dbo.PropietarioDePropiedad
		SET PropietarioDePropiedad.PropiedadId = @idPropiedad,
		PropietarioDePropiedad.PropietarioId = @idPropietario
		WHERE PropietarioDePropiedad.Id = @idPropVSProp AND PropietarioDePropiedad.Activo = 1

		RETURN 1

	END TRY

	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Update_PropietariosVsPropiedades 123,'401230456','',6852677,'','',0

SELECT * FROM dbo.PropietarioDePropiedad 

SELect * FROM DBO.Propiedad

-- DROP PROC SP_Delete_PropietariosVsPropiedades
CREATE PROC SP_Delete_PropietariosVsPropiedades (@inNumeroFinca int,@inIdentificacion varchar(30),
												 @inIdentificacionPJ varchar(30),@inEsJuridico int)
AS
BEGIN
	BEGIN TRY
		DECLARE @idPropiedad int = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumeroFinca and P.Activo = 1

		IF @idPropiedad IS NULL
			BEGIN
				Print('El numero de finca no existe')
				RETURN -5001
			END

		DECLARE @idPropietario int = NULL
		declare @idPersonaJuridica int = null
	
		SELECT @idPropietario = P.Id 
		FROM dbo.Propietario P
		WHERE P.Identificacion = @inIdentificacion and P.Activo = 1
		
		IF(@inEsJuridico = 1)
		BEGIN
			SELECT @idPersonaJuridica = PJ.Id 
			FROM dbo.PersonaJuridica PJ,dbo.Propietario P
			WHERE (PJ.Identificacion = @inIdentificacionPJ and P.Identificacion = @inIdentificacion) and PJ.Activo = 1
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

		DECLARE @idPropVSProp int = null

		SELECT @idPropVSProp = PP.Id
		FROM dbo.PropietarioDePropiedad PP
		where PP.PropiedadId = @idPropiedad and (PP.PropietarioId = @idPropietario)

		IF @idPropVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y el propietario')
			RETURN -5004
		END

		Update dbo.PropietarioDePropiedad
		SET PropietarioDePropiedad.Activo = 0,PropietarioDePropiedad.FechaFinal = CONVERT(DATE,getDate())
		where PropietarioDePropiedad.Id = @idPropVSProp and PropietarioDePropiedad.Activo = 1

		RETURN 1
	END TRY

	BEGIN CATCH
			RETURN @@ERROR*-1
	END CATCH
END;

exec SP_Read_PropietariosVsPropiedades 6852677,'401230456','',0

EXEC SP_Delete_PropietariosVsPropiedades  6852677,'401230456','',0
