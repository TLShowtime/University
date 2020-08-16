Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Generar_RecibosAP]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Generar_RecibosAP]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Generar_RecibosAP @inFechaActual date
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON

		DECLARE @diasGeneracionRecibo table (id int identity(1,1),idAP int not null, dateCreacion date not null)

		INSERT into @diasGeneracionRecibo (idAP,dateCreacion)
		SELECT A.Id, dateadd(MONTH,1,CONVERT(DATE,A.InsertAt))
		from dbo.AP A,dbo.CCArregloPago CAP inner join dbo.ConceptoCobro C on CAP.Id = C.Id

		IF NOT EXISTS (SELECT * from @diasGeneracionRecibo)
		BEGIN
			RETURN 0
		END;
	

		BEGIN TRAN

			-- Movimiento -- 1. Credito
			/**
				- A.Saldo * A.TasaInteresAnual/12 = Intereses del Mes
				- (A.Cuota - A.Saldo * A.TasaInteresAnual/12) = Amortizacion
			*/
			INSERT INTO dbo.MovimientosAP (IdAP,IdTipoMovId,
			Monto,InteresesDelMes,PlazoResta,NuevoSaldo
			,Fecha,InsertedAt,Activo)
			SELECT DC.idAP,1
				  ,A.Cuota,A.Saldo * A.TasaInteresAnual/12,A.PlazoResta - 1,A.Saldo - (A.Cuota - A.Saldo * A.TasaInteresAnual/12)
				  ,@inFechaActual,CONVERT(DATETIME,@inFechaActual),1
			from @diasGeneracionRecibo DC inner join dbo.AP A on DC.idAP = A.Id
			where DC.dateCreacion = @inFechaActual
			;

			-- Crea el recibo 
			INSERT INTO dbo.Recibo(PropiedadId,ConceptoCobroId,
								   FechaEmision,FechaVencimiento,
								   Monto,Estado,Activo)
				SELECT P.Id,C.Id,
						@inFechaActual,dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@inFechaActual)),@inFechaActual)),
						A.Cuota,0,1
					from  dbo.AP A inner join @diasGeneracionRecibo D on D.idAP = A.Id
								   inner join dbo.Propiedad P on A.IdPropiedad = P.Id
					
					,dbo.CCArregloPago CF inner join dbo.ConceptoCobro C on CF.Id = C.Id
					where D.dateCreacion = @inFechaActual and P.FechaCreacion <= @inFechaActual
		
		
			-- Une con el ReciboAP
			INSERT INTO RecibosAP(Id,IdMovimientoAP,Descripcion,Activo)
			SELECT R.Id,M.Id
				   ,'Interes mensual: '+CAST( M.InteresesDelMes AS varchar(20)) + ', amortizacion: ' + CAST(A.Cuota - A.Saldo * A.TasaInteresAnual/12 AS varchar(20)) + ', plazo resta: ' + CAST(M.PlazoResta AS varchar(3))
				   ,1
			FROM dbo.Recibo R, dbo.AP A inner join dbo.MovimientosAP M on A.Id = M.IdAP
										inner join @diasGeneracionRecibo D on A.Id = D.idAP
 			where R.PropiedadId = A.IdPropiedad and R.ConceptoCobroId = 12 and R.Estado = 0
				  and R.FechaEmision = @inFechaActual and M.Fecha = @inFechaActual 
		
			-- Actualiza AP
			UPDATE dbo.AP
			SET [AP].PlazoResta =MA.PlazoResta,[AP].Saldo = MA.NuevoSaldo,[AP].UpdateAt = CONVERT(DATETIME,@inFechaActual)
			from dbo.MovimientosAP MA
			where MA.IdAP = [AP].Id and MA.Fecha = @inFechaActual

		

		COMMIT
		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error, no se generaron RecibosAPs');
		THROW 
	END CATCH
END;
