Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Pago_Confirmado_Web]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Pago_Confirmado_Web]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Pago_Confirmado_Web @inMontoTotal decimal,@inNumFinca int,@inIdReciboMayor int
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		
		DECLARE @fechaActual date
				,@idAP int
				,@esAP int
				,@idComprobante int;

		DECLARE @RecibosAPagar table(
			Id int IDENTITY(1,1) not null
			,IdRecibo int not null
			,idConceptoCobro int not null
			)

		SET @fechaActual = GETDATE()

		-- Obtiene los recibos que se han escogido sin incluir a los generados por intereses moratorios
		INSERT INTO @RecibosAPagar (IdRecibo,idConceptoCobro)
		SELECT R.Id,R.ConceptoCobroId
		FROM dbo.Recibo R inner join dbo.Propiedad P 
			 on R.PropiedadId = P.Id and P.NumeroFinca = @inNumFinca and R.Id <= @inIdReciboMayor
									 and R.Estado = 0 and R.Activo = 1
			inner join dbo.ConceptoCobro C on R.ConceptoCobroId = C.Id


		-- Revisa si lo que se paga es un AP
		SELECT @esAP = R.idConceptoCobro
			from @RecibosAPagar R

		SELECT @idAP = A.Id
			from dbo.AP A inner join dbo.MovimientosAP M on A.Id = M.IdAP 
				,dbo.Recibo R inner join dbo.RecibosAP RA on R.Id = RA.Id
				,@RecibosAPagar RP
				where RP.idRecibo = R.Id and RA.IdMovimientoAP = M.Id

		BEGIN TRAN
			Insert dbo.ComprobantePago (Fecha,TotalPagado,MedioPago,Activo) values(
				GETDATE(),CONVERT(money,@inMontoTotal),case when @esAP = 12   
											then 
												'AP# ' + CAST (@idAP AS varchar(15)) 
											else
												'Web' end,1
			)

			
			Select @idComprobante = max(C.Id)
				from dbo.ComprobantePago C

			-- Paga los recibos 
			UPDATE [dbo].[Recibo]
				SET [Recibo].Estado = 1,[Recibo].ComprobanteId = @idComprobante
				from @RecibosAPagar R
				where [Recibo].Id = R.idRecibo and [Recibo].Estado = 0
						and [Recibo].FechaEmision <= @FechaActual and [Recibo].Activo = 1

			-- Paga los recibos que son de intereses Moratorios
			UPDATE [dbo].[Recibo]
				SET [Recibo].ComprobanteId = @idComprobante,[Recibo].Estado = 1
				from dbo.CCInteresesMoratorios CIM
				where [Recibo].ConceptoCobroId = CIM.Id and [Recibo].Estado = 0 and [Recibo].Activo = 1 and [Recibo].FechaEmision = @fechaActual

		COMMIT

		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error, no se pagaron los recibos');
		RETURN @@ERROR *-1 
	END CATCH
END;

DECLARE @monto decimal

EXEC SP_Pago_Seleccion_Web 1176180,11972,@monto output 

PRINT(@monto)



SELECT * from dbo.Recibo R inner join dbo.Propiedad P on R.PropiedadId = P.Id 
		and P.NumeroFinca = 1176180 and R.Estado = 0

EXEC SP_Pago_Confirmado_Web 20571,1176180,11972

SELECT * FROM DBO.ComprobantePago CP

SELECT ComprobantePago.MedioPago,Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto, Recibo.Id,Recibo.ConceptoCobroId
FROM Recibo INNER JOIN ComprobantePago ON Recibo.ComprobanteId = ComprobantePago.Id 
			INNER JOIN Propiedad ON Recibo.PropiedadId = Propiedad.Id
			WHERE(Recibo.Activo = 1) AND(Recibo.Estado = 1)
			AND ComprobantePago.Id = 10910 ORDER BY Recibo.FechaEmision;
