Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Pago_Cancelado_Web]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Pago_Cancelado_Web]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Pago_Cancelado_Web
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		
		DECLARE @fechaActual date
		SET @fechaActual = GETDATE()

		BEGIN TRAN
			-- Anula los recibos que son de intereses Moratorios
			UPDATE [dbo].[Recibo]
				SET [Recibo].Estado = 2
				from dbo.CCInteresesMoratorios CIM
				where [Recibo].ConceptoCobroId = CIM.Id and [Recibo].Estado = 0 and [Recibo].Activo = 1 and [Recibo].FechaEmision = @fechaActual

		COMMIT

		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error en la cancelacion de pagos');
		RETURN @@ERROR *-1 
	END CATCH
END;
