Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Pago_Seleccion_Web]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Pago_Seleccion_Web]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Pago_Seleccion_Web @inNumFinca int,@inIdReciboMayor int,@outMontoAPagar decimal OUTPUT
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
	/*
		DECLARE  @inNumFinca int,@inIdReciboMayor int,@outMontoAPagar decimal;

		SET @inNumFinca= 2132441 
		SET @inIdReciboMayor = 22455*/


		IF NOT EXISTS (SELECT P.Id from dbo.Propiedad P where P.NumeroFinca = @inNumFinca)
		BEGIN
			RETURN -2
		END;

		DECLARE @sumaTotal money
				,@fechaActual date;

		DECLARE @RecibosAPagar table(
			Id int IDENTITY(1,1) not null
			,IdRecibo int not null
			,idConceptoCobro int not null
			,MontoInteresesMoratorios money not null
			)

		SET @fechaActual = GETDATE()


		INSERT INTO @RecibosAPagar (IdRecibo,MontoInteresesMoratorios,idConceptoCobro)
		SELECT R.Id,case
				when CONVERT(DATE,GETDATE())<=R.FechaVencimiento then 0 -- no tiene que generarse recibo de int moratorios
				else (R.Monto*C.TasaIntMor/365)*abs(datediff(day, R.FechaVencimiento, CONVERT(DATE,GETDATE())))
					-- SI tiene que generarse recibo
				end,R.ConceptoCobroId
		FROM dbo.Recibo R inner join dbo.Propiedad P 
			 on R.PropiedadId = P.Id and P.NumeroFinca = @inNumFinca and R.Id <= @inIdReciboMayor
									 and R.Estado = 0 and R.Activo = 1
			inner join dbo.ConceptoCobro C on R.ConceptoCobroId = C.Id

		Select @sumaTotal = sum(R.Monto + RP.montoInteresesMoratorios)
			from @RecibosAPagar RP
			inner join dbo.Recibo R on RP.idRecibo = R.Id

		SELECT @outMontoAPagar = CONVERT(decimal,@sumaTotal)

		BEGIN TRAN

				-- Crea los recibos de Intereses Moratorios
			INSERT into dbo.Recibo (PropiedadId,ConceptoCobroId,
									FechaEmision,FechaVencimiento,
									Monto,Estado,Activo)
			Select R.PropiedadId,C.Id,@FechaActual,
					dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@FechaActual)),@FechaActual)),
					RP.montoInteresesMoratorios,0,1
				from @RecibosAPagar RP, dbo.Recibo R,dbo.ConceptoCobro C inner join dbo.CCInteresesMoratorios CIM on C.Id = CIM.Id
					where RP.idRecibo = R.Id and RP.montoInteresesMoratorios > 0.0

		COMMIT

		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error, no se generaron recibos antes del pago');
		RETURN @@ERROR *-1 
	END CATCH
END;

