Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Generar_AP]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Generar_AP]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Generar_AP @inArregloPagos APTipo READONLY,@inFechaActual date
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		
		IF NOT EXISTS (SELECT * from @inArregloPagos)
		BEGIN
			RETURN -1
		END

		DECLARE @montoTotal money
				,@minCount int
				,@maxCount int
				,@tasaInteres real
				,@idAP int
				,@idComprobante int;

		DECLARE @idPropiedades Table (Id int identity(1,1) not null,IdPropiedad int not null,Plazo int not null);
		DECLARE @montosXPropiedad TABLE (Id int identity(1,1) not null,IdPropiedad int not null,Monto money not null)
		Declare @RecibosAPagar table (
			id int not null Primary Key identity(1,1),
			idRecibo int not null,
			montoInteresesMoratorios money not null
		)


		Insert into @idPropiedades (IdPropiedad,Plazo)
		SELECT P.Id,A.Plazo
		from dbo.Propiedad P
		inner join @inArregloPagos A on P.NumeroFinca = A.NumeroFinca
		
		Select @minCount = min(P.Id),@maxCount = max(P.Id)
		from @idPropiedades P

		-- Saca la tasa de interes de la tabla de Configuraciones -- 0.10
		SELECT @tasaInteres = CASE when TVC.NombreTipo='decimal' THEN (CONVERT(real,VC.Valor)/100) end
		from dbo.ValoresConfiguracion VC inner join dbo.TiposValoresConfiguracion TVC on VC.IdTipo = TVC.Id

		BEGIN TRAN

			WHILE @minCount <= @maxCount
			BEGIN
				SET @montoTotal = 0.0
				SET @idAP = 0
				SET @idComprobante = 0;

				--Generar RECIBOS INT MORATORIOS
				INSERT into dbo.Recibo (PropiedadId,ConceptoCobroId,
										FechaEmision,FechaVencimiento,
										Monto,Estado,Activo)
				Select R.PropiedadId,C.Id,@inFechaActual
						,dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@inFechaActual)),@inFechaActual))
						,(R.Monto*C.TasaIntMor/365)*abs(datediff(day, R.FechaVencimiento, @inFechaActual))
						,0,1
				from dbo.Recibo R inner join dbo.ConceptoCobro C  on R.ConceptoCobroId = C.Id, @idPropiedades P
				where P.IdPropiedad = R.PropiedadId and R.Estado = 0 and R.Activo = 1
				and @inFechaActual > R.FechaVencimiento and P.Id = @minCount
				and (R.Monto*C.TasaIntMor/365)*abs(datediff(day, R.FechaVencimiento, @inFechaActual)) > 0.0

			-- Suma los montos de los recibos pendientes de una propiedad
				SELECT @montoTotal = sum(R.Monto)
				from dbo.Recibo R
				inner join @idPropiedades ID on R.PropiedadId = ID.IdPropiedad
				where R.Estado = 0 and R.Activo = 1 and ID.Id = @minCount;
			

				-- Crea el AP
				INSERT INTO dbo.AP(IdPropiedad,MontoOriginal,Saldo,TasaInteresAnual
								   ,PlazoOriginal,PlazoResta,Cuota,InsertAt,UpdateAt,Activo)

				SELECT P.IdPropiedad,@montoTotal,0,@tasaInteres
					  ,P.Plazo,P.Plazo,@montoTotal * ( (@tasaInteres*(1 + @tasaInteres)*P.Plazo)/((1+@tasaInteres)*P.Plazo - 1)), CONVERT(DATETIME,@inFechaActual),CONVERT(DATETIME,@inFechaActual),1
				from @idPropiedades P where P.Id = @minCount and NOT EXISTS(SELECT * from dbo.AP A where A.IdPropiedad = P.IdPropiedad);

				-- SCOPE_IDENTITY
				-- @@identity 

				-- Guarda la direccion del AP para meter el Comprobante luego
				SELECT @idAP = max(A.Id)
				from dbo.AP A

				Insert Into dbo.ComprobantePago (TotalPagado,MedioPago,Fecha,Activo)
				values (@montoTotal,'AP# ' + CAST(@idAP AS VARCHAR(10)),@inFechaActual,1)

				SELECT @idComprobante = max(C.Id)
				from dbo.ComprobantePago C

				-- Enlazar el Comprobante con el AP
				UPDATE dbo.AP
				set [AP].IdComprobante = @idComprobante
				from @idPropiedades P
				where [AP].IdPropiedad = P.IdPropiedad  and P.Id  =@minCount

				-- Enlazar el Comprobante con los recibos y cambiar estado, incluyendo Intereses Moratorios
				UPDATE dbo.Recibo
				set [Recibo].ComprobanteId = @idComprobante, [Recibo].Estado = 1
				from @idPropiedades P
				where [Recibo].PropiedadId = P.IdPropiedad and P.Id = @minCount and NOT [Recibo].ConceptoCobroId = 12

				

				--Movimiento Inicial, un debito al saldo inicial 
				-- 1. Credito
				-- 2. Debito
				INSERT INTO dbo.MovimientosAP(IdAP,IdTipoMovId,Monto,InteresesDelMes,PlazoResta,NuevoSaldo,Fecha,InsertedAt,Activo)
				Select A.Id,2,A.MontoOriginal,0,A.PlazoOriginal,A.MontoOriginal,@inFechaActual,CONVERT(DATETIME,@inFechaActual),1
				from dbo.AP A
				where A.Id = @idAP

				-- Actualizacion en AP
				UPDATE dbo.AP
				SET [AP].Saldo = @montoTotal
				where [AP].Id = @idAP

				set @minCount = @minCount + 1
			END
		COMMIT
		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error, no se generaron APs');
		THROW 
	END CATCH
END;
