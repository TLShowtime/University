Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Crear_AP_Confirmado_Web]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Crear_AP_Confirmado_Web]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Crear_AP_Confirmado_Web @inNumFinca int ,@inMontoTotal decimal,@inPlazo int
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON

		DECLARE @montoTotal money
				,@tasaInteres real
				,@idAP int
				,@idComprobante int
				,@FechaActual date
				,@idPropiedad int;

		SELECT @idPropiedad = P.Id
		from dbo.Propiedad P where P.NumeroFinca = @inNumFinca

		-- Verifica si existe la propiedad
		IF (@idPropiedad <= 0 or @idPropiedad IS NULL )
		BEGIN
			RETURN -1
		END

		SELECT @montoTotal  = CONVERT (money,@inMontoTotal)

		-- Saca la tasa de interes de la tabla de Configuraciones -- 0.10
		SELECT @tasaInteres = CASE when TVC.NombreTipo='decimal' THEN (CONVERT(real,VC.Valor)/100) end
		from dbo.ValoresConfiguracion VC inner join dbo.TiposValoresConfiguracion TVC on VC.IdTipo = TVC.Id

		SET @FechaActual = GETDATE()

		BEGIN TRAN
				-- Crea el AP
			INSERT INTO dbo.AP(IdPropiedad,MontoOriginal,Saldo,TasaInteresAnual
								   ,PlazoOriginal,PlazoResta
								   ,Cuota
								   ,InsertAt,UpdateAt,Activo)
			VALUES  (@idPropiedad,@montoTotal,0,@tasaInteres
					  ,@inPlazo,@inPlazo
					  ,@inMontoTotal * ( (@tasaInteres*(1 + @tasaInteres)*@inPlazo)/((1+@tasaInteres)*@inPlazo - 1))
					  ,GETDATE(),GETDATE(),1)



				-- Guarda la direccion del AP para meter el Comprobante luego
			SELECT @idAP = max(A.Id)
			from dbo.AP A

			-- Agrega Comprobante de Pago
			Insert Into dbo.ComprobantePago (TotalPagado,MedioPago,Fecha,Activo)
			values (@montoTotal,'AP# ' + CAST(@idAP AS VARCHAR(10)),GETDATE(),1)

			-- Guarda la direccion de CP
			SELECT @idComprobante = max(C.Id)
			from dbo.ComprobantePago C

				-- Enlazar el Comprobante con el AP
			UPDATE dbo.AP
			set [AP].IdComprobante = @idComprobante
			where [AP].IdPropiedad = @idPropiedad and [AP].Id =  @idAP

				-- Enlazar el Comprobante con los recibos y cambiar estado, incluyendo Intereses Moratorios
			UPDATE dbo.Recibo
			set [Recibo].ComprobanteId = @idComprobante, [Recibo].Estado = 1
			where [Recibo].PropiedadId = @idPropiedad and NOT [Recibo].ConceptoCobroId = 12 and [Recibo].Estado = 0 and [Recibo].Activo = 1

				--Movimiento Inicial, un debito al saldo inicial 
				-- 1. Credito
				-- 2. Debito
			INSERT INTO dbo.MovimientosAP(IdAP,IdTipoMovId,Monto,InteresesDelMes,PlazoResta,NuevoSaldo,Fecha,InsertedAt,Activo)
			Select A.Id,2,A.MontoOriginal,A.MontoOriginal * @tasaInteres/12,A.PlazoOriginal,A.MontoOriginal,GETDATE(),GETDATE(),1
			from dbo.AP A
			where A.Id = @idAP

				-- Actualizacion en AP
			UPDATE dbo.AP
			SET [AP].Saldo = @montoTotal
			where [AP].Id = @idAP

		COMMIT
		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error, no logro terminar la Confirmacion de AP');
		RETURN @@ERROR * -1
	END CATCH
END;
