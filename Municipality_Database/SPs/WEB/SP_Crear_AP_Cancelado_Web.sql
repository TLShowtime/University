Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Crear_AP_Cancelado_Web]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Crear_AP_Cancelado_Web]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Crear_AP_Cancelado_Web @inNumFinca int
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON

		DECLARE @idPropiedad int;

		SELECT @idPropiedad = P.Id
		from dbo.Propiedad P where P.NumeroFinca = @inNumFinca

				-- Verifica si existe la propiedad
		IF (@idPropiedad <= 0 or @idPropiedad IS NULL )
		BEGIN
			RETURN -1
		END

		BEGIN TRAN
				-- Cambio los Recibos de ConceptoCobro=11 (InteresesMoratorios)
			UPDATE dbo.Recibo
			set  [Recibo].Estado = 2
			from dbo.CCInteresesMoratorios CIM 
			where [Recibo].PropiedadId = @idPropiedad and [Recibo].ConceptoCobroId = CIM.Id and [Recibo].Estado = 0 and [Recibo].Activo = 1
		COMMIT
		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error, logro terminar la Cancelacion de AP');
		RETURN @@ERROR * -1
	END CATCH
END;
