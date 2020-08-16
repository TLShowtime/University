-- DROP PROC SP_Create_CCVSPropiedad
CREATE PROC SP_Create_CCVSPropiedad (@inIdCobro int,@inNumFinca int)
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


		DECLARE @idConceptoCobro int = NULL	
		
		SELECT @idConceptoCobro  = C.Id
		FROM dbo.ConceptoCobro C
		where C.Id = @inIdCobro and C.Activo = 1

		IF @idConceptoCobro IS NULL
		BEGIN
			Print('El Concepto de cobro no existe')
			RETURN -5001
		END

		INSERT dbo.CCenPropiedad(PropiedadId,ConceptoCobroId,FechaInicio,Activo)
		values(@idPropiedad,@idConceptoCobro,CONVERT(DATE,GETDATE()),1)

		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

SELECT * from dbo.ConceptoCobro

EXEC SP_Create_CCVSPropiedad 4,6852677

Select * from dbo.CCenPropiedad


-- DROP PROC SP_Read_CCVSPropiedad
CREATE PROC SP_Read_CCVSPropiedad (@inIdCobro int,@inNumFinca int)
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


		DECLARE @idConceptoCobro int = NULL	
		
		SELECT @idConceptoCobro  = C.Id
		FROM dbo.ConceptoCobro C
		where C.Id = @inIdCobro and C.Activo = 1

		IF @idConceptoCobro IS NULL
		BEGIN
			Print('El Concepto de cobro no existe')
			RETURN -5001
		END


		DECLARE @idCCVSProp int = null

		SELECT @idCCVSProp = CP.Id
		FROM dbo.CCenPropiedad CP
		where CP.PropiedadId = @idPropiedad and (CP.ConceptoCobroId= @idConceptoCobro)

		IF @idCCVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y un concepto de cobro')
			RETURN -5004
		END

		SELECT P.NumeroFinca,P.Valor,P.Direccion,C.Nombre,C.TasaIntMor,C.DiasDelMes
		FROM dbo.CCenPropiedad CP
		inner join dbo.Propiedad P on CP.PropiedadId = P.Id
		inner join dbo.ConceptoCobro C on CP.ConceptoCobroId = C.Id
		where CP.Id = @idCCVSProp and CP.Activo = 1

		RETURN 1
	END TRY

	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Read_CCVSPropiedad 4,6852677


-- DROP PROC SP_Update_CCVSPropiedad
CREATE PROC SP_Update_CCVSPropiedad (@inIdCobroOriginal int,@inNumFincaOriginal int,@inIdCobroNuevo int,@inNumFincaNuevo int)
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


		DECLARE @idConceptoCobro int = NULL	
		
		SELECT @idConceptoCobro  = C.Id
		FROM dbo.ConceptoCobro C
		where C.Id = @inIdCobroOriginal and C.Activo = 1

		IF @idConceptoCobro IS NULL
		BEGIN
			Print('El Concepto de cobro no existe')
			RETURN -5001
		END


		DECLARE @idCCVSProp int = null

		SELECT @idCCVSProp = CP.Id
		FROM dbo.CCenPropiedad CP
		where CP.PropiedadId = @idPropiedad and (CP.ConceptoCobroId= @idConceptoCobro)

		IF @idCCVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y un concepto de cobro')
			RETURN -5004
		END

		-- Obtener si hay espacios blancos
		IF @inNumFincaNuevo <= 0 OR @inNumFincaNuevo IS NULL
		BEGIN
			SET @inNumFincaNuevo = @inNumFincaOriginal
		END
		IF @inIdCobroNuevo <= 0 OR @inIdCobroNuevo IS NULL
		BEGIN
			SET @inIdCobroNuevo = @inIdCobroOriginal
		END

		-- Verificar si existen los campos nuevos
		SET @idPropiedad = null
		SET @idConceptoCobro = null

		SELECT @idPropiedad = P.Id
		FROM dbo.Propiedad P
		where P.NumeroFinca = @inNumFincaNuevo and P.Activo = 1

		IF @idPropiedad IS NULL
		BEGIN
			Print('El numero de finca Nuevo no existe')
			RETURN -5001
		END

		SELECT @idConceptoCobro  = C.Id
		FROM dbo.ConceptoCobro C
		where C.Id = @inIdCobroNuevo and C.Activo = 1

		IF @idConceptoCobro IS NULL
		BEGIN
			Print('El Concepto de cobro Nuevo no existe')
			RETURN -5001
		END

		UPDATE dbo.CCenPropiedad
		SET CCenPropiedad.PropiedadId = @idPropiedad,
		CCenPropiedad.ConceptoCobroId= @idConceptoCobro
		WHERE CCenPropiedad.Id = @idCCVSProp AND CCenPropiedad.Activo = 1

		RETURN 1

	END TRY

	BEGIN CATCH
		RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Update_CCVSPropiedad  4,6852677,1,0

EXEC SP_Read_CCVSPropiedad 1,6852677



-- DROP PROC SP_Delete_CCVSPropiedad
CREATE PROC SP_Delete_CCVSPropiedad (@inIdCobro int,@inNumFinca int)
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


		DECLARE @idConceptoCobro int = NULL	
		
		SELECT @idConceptoCobro  = C.Id
		FROM dbo.ConceptoCobro C
		where C.Id = @inIdCobro and C.Activo = 1

		IF @idConceptoCobro IS NULL
		BEGIN
			Print('El Concepto de cobro no existe')
			RETURN -5001
		END


		DECLARE @idCCVSProp int = null

		SELECT @idCCVSProp = CP.Id
		FROM dbo.CCenPropiedad CP
		where CP.PropiedadId = @idPropiedad and (CP.ConceptoCobroId= @idConceptoCobro)

		IF @idCCVSProp IS NULL
		BEGIN
			Print('No existe una relacion entre la propiedad y un concepto de cobro')
			RETURN -5004
		END

		Update dbo.CCenPropiedad
		SET CCenPropiedad.Activo = 0,CCenPropiedad.FechaFinal = CONVERT(DATE,getDate())
		where CCenPropiedad.Id = @idCCVSProp and CCenPropiedad.Activo = 1

		RETURN 1
	END TRY

	BEGIN CATCH
			RETURN @@ERROR*-1
	END CATCH
END;

EXEC SP_Delete_CCVSPropiedad 1,6852677
EXEC SP_Read_CCVSPropiedad 1,6852677

SELECT * from dbo.CCenPropiedad c where c.Activo = 0
