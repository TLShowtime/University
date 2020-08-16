Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Generar_AP_Web]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Generar_AP_Web]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Generar_AP_Web @inNumFinca int,@inPlazo int
AS
BEGIN
	BEGIN TRY
		DECLARE @ArregloPago APTipo
				,@existePropiedad int
				,@fechaActual date

		SELECT @existePropiedad = P.Id
		from dbo.Propiedad P 
		where P.NumeroFinca = @inNumFinca

		-- Si existe la propiedad
		IF @existePropiedad IS NULL OR @existePropiedad < 1
		BEGIN
			RETURN @@error *-1
		END 
		
		-- Si el plazo es menor a 1
		IF @inPlazo < 1
		BEGIN
			RETURN @@ERROR * -1 - 1
		END

		INSERT into @ArregloPago(NumeroFinca,Plazo)
		values (@inNumFinca,@inPlazo);

		SET @fechaActual  = GETDATE()

		EXEC SP_Generar_AP @ArregloPago,@fechaActual

		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		PRINT('Hubo un error, no se generaron APs desde el portal WEB');
		THROW 
	END CATCH
END;
