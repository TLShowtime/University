USE [Tarea2]

DELETE RecibosAP
DELETE MovimientosAP
DELETE AP

delete dbo.Corta
delete dbo.Reconexion
delete dbo.Movimiento
delete dbo.ReciboReconexion
delete dbo.Recibo
delete dbo.ComprobantePago

DECLARE @Fechas table (id int identity(1,1) not null,Fecha date not null)

INSERT INTO @Fechas(Fecha)
SELECT
	FechaC.value('@fecha','date') as Fecha
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Operaciones.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Operaciones_por_Dia/OperacionDia') AS MY_XML (FechaC)

DECLARE @fechaini date
DECLARE @fechafin date
DECLARE @counterFin int
DECLARE @counterInicio int

SELECT @fechaini = min(F.Fecha)
FROM @Fechas F

SELECT @fechafin = max(F.Fecha)
FROM @Fechas F

SELECT @counterInicio = F.id
FROM @Fechas F
WHERE F.Fecha = @fechaini

SELECT @counterFin = F.id
FROM @Fechas F
WHERE F.Fecha = @fechafin

/*print(@counterInicio)
print(@counterFin)
*/
/**
Select *
from @Fechas
*/
--------------------------- 
DECLARE @diaCCConsumo int,@diaCCConsumoVence int

SELECT @diaCCConsumo = C.DiasDelMes, @diaCCConsumoVence = C.QDiasVencen
FROM dbo.CCConsumo CO
inner join dbo.ConceptoCobro C on CO.Id = C.Id

---------------------------

DECLARE @TransConsumo table (
		Id int identity(1,1) not null Primary Key,
		IdMovimiento int not null, LecturaM3 int not null,
		Descripcion varchar(100) not null, NumFinca int not null,
		Fecha date not null
	) 
DECLARE @cantidadRecibosPendientesAgua table (
				id int not null identity(1,1) Primary key,
				idPropiedad int not null,
				cantidadRecibos int not null
			)
DECLARE @Pagos table(
		id int not null primary key identity(1,1),
		TipoRecibo int not null,
		NumFinca int not null
	)
Declare @RecibosAPagarReconexion table (
			id int not null Primary Key identity(1,1),
			idRecibo int not null,
			montoInteresesMoratorios money not null
		)


DECLARE @ArregloPago APTipo
		,@FechaActual date
		,@lowMov int
		,@highMov int
		,@sumaTotalReconexion money
		,@idComprobanteReconexion int


DECLARE @XMLData XML
DECLARE @hdoc int
SET NOCOUNT ON



SELECT @XMLData = C
FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Operaciones.xml',SINGLE_BLOB) AS Operaciones(C)
EXEC sp_xml_preparedocument @hdoc OUTPUT,@XMLData

WHILE @counterInicio <= @counterFin
BEGIN
	SELECT @FechaActual = F.Fecha
	FROM @Fechas F
	WHERE F.Id = @counterInicio

	DELETE @TransConsumo

	PRINT(@FechaActual)

	--Cambio Propiedad
	Update dbo.Propiedad
	SET Propiedad.Valor = ValorNuevo
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/CambioPropiedad',1)
		WITH ( 
			ValorNuevo MONEY '@NuevoValor',
			NumeroFincaBusqueda INT '@NumFinca',
			FechaCreacion1 date '../@fecha'
		)
		Where FechaCreacion1 = @FechaActual and Propiedad.NumeroFinca = NumeroFincaBusqueda

			-- <TransConsumo id="1" LecturaM3="309" descripcion="Cobro Mensual" NumFinca="1750401"/>
	INSERT INTO @TransConsumo(IdMovimiento,LecturaM3,Descripcion,NumFinca,Fecha)
	SELECT IdMovimientoTipo,LecturaM3Var,Descripcion1,NumeroFinca1,FechaCreacion1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/TransConsumo',1)
		WITH ( 
			IdMovimientoTipo int '@id',
			LecturaM3Var int '@LecturaM3',
			Descripcion1 varchar(100) '@descripcion',
			NumeroFinca1 int '@NumFinca',
			FechaCreacion1 date '../@fecha'
		)
	Where (FechaCreacion1 = @FechaActual)

	
	SELECT @highMov = max(T.Id),@lowMov = min(T.Id)
	from @TransConsumo T

	-- Todos los procesos tuvieron que estar en un SP para manejar errores, Trans sea a todas
	set nocount on
	BEGIN TRY
		BEGIN TRANSACTION T1

			WHILE @lowMov <= @highMov
			BEGIN
				DECLARE @TipoMovimiento int
				SELECT @TipoMovimiento = T.IdMovimiento
				FROM @TransConsumo T
				where T.Id = @lowMov

				DECLARE @idPropiedad int, @idMov int
				SELECT @idPropiedad = P.id, @idMov = T.Id
				from dbo.Propiedad P,@TransConsumo T
				where T.NumFinca = P.NumeroFinca and T.Id = @lowMov

			
					-- Pagos regulares     Nuevo acumulado = P.M3ACUMULADONUEVORecibo - lectura
					IF @TipoMovimiento = 1
					BEGIN
						Insert into dbo.Movimiento (PropiedadId,TipoMovId,Fecha,LecturaConsumo,MontoM3,NuevoM3Acumulado,Descripcion,Activo)
						SELECT P.Id,T.IdMovimiento,T.Fecha,T.LecturaM3,P.M3Acumulados,P.M3AcumuladosUltimoRecibo + T.LecturaM3,T.Descripcion,1
						FROM @TransConsumo T,dbo.Propiedad P
						WHERE T.Id = @lowMov and P.Id = @idPropiedad

						UPDATE dbo.Propiedad
						SET Propiedad.M3Acumulados = Propiedad.M3Acumulados + T.LecturaM3
						FROM @TransConsumo T
						WHERE Propiedad.NumeroFinca = T.NumFinca and T.Id = @lowMov
					END
					-- Debito
					IF @TipoMovimiento = 2
					BEGIN	
						Insert into dbo.Movimiento (PropiedadId,TipoMovId,Fecha,LecturaConsumo,MontoM3,NuevoM3Acumulado,Descripcion,Activo)
						SELECT P.Id,T.IdMovimiento,T.Fecha,T.LecturaM3,P.M3Acumulados ,P.M3Acumulados - T.LecturaM3,T.Descripcion,1
						FROM dbo.Propiedad P,@TransConsumo T
						WHERE T.Id = @lowMov and P.Id = @idPropiedad

						UPDATE dbo.Propiedad
						SET Propiedad.M3Acumulados = Propiedad.M3Acumulados - T.LecturaM3
						FROM @TransConsumo T
						WHERE Propiedad.NumeroFinca = T.NumFinca and T.Id = @lowMov
					END
					-- Credito
					IF @TipoMovimiento = 3
					BEGIN	
						Insert into dbo.Movimiento (PropiedadId,TipoMovId,Fecha,LecturaConsumo,MontoM3,NuevoM3Acumulado,Descripcion,Activo)
						SELECT P.Id,T.IdMovimiento,T.Fecha,T.LecturaM3,P.M3Acumulados ,P.M3Acumulados + T.LecturaM3,T.Descripcion,1
						FROM dbo.Propiedad P,@TransConsumo T
						WHERE T.Id = @lowMov and P.Id = @idPropiedad

						UPDATE dbo.Propiedad
						SET Propiedad.M3Acumulados = Propiedad.M3Acumulados + T.LecturaM3
						FROM @TransConsumo T
						WHERE Propiedad.NumeroFinca = T.NumFinca and T.Id = @lowMov
					END
				
				SET @lowMov = @lowMov + 1
			END
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH 
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION T1
		PRINT('ERROR EN TRANSCONSUMO')
		
	END CATCH
	-- Generar recibos

	BEGIN TRY
		set nocount on
		BEGIN TRANSACTION T2
				-- 1. EXTRAER EL DIA DE PAGO DE CADA 
			IF DAY(@FechaActual) = @diaCCConsumo
			BEGIN
				INSERT INTO Recibo(PropiedadId,ConceptoCobroId,FechaEmision,
									FechaVencimiento,
									Monto,
									Estado,Activo)
				SELECT	P.Id,C.Id,@FechaActual,
						dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@FechaActual)),@FechaActual)),
					case when (P.M3Acumulados - P.M3AcumuladosUltimoRecibo)*CO.ValorM3>CO.MontoMinimoRecibo
					 then (P.M3Acumulados - P.M3AcumuladosUltimoRecibo)*CO.ValorM3
					 else CO.MontoMinimoRecibo
					 end,
					 0,1
				from  dbo.CCenPropiedad CP
				inner join dbo.CCConsumo CO on CP.ConceptoCobroId = CO.Id
				inner join dbo.ConceptoCobro C on CP.ConceptoCobroId = C.Id
				inner join dbo.Propiedad P on CP.PropiedadId = P.Id
				WHERE P.FechaCreacion <= @FechaActual

				-- Modifica el M3 Acumulados del Ultimo Recibo
				UPDATE dbo.Propiedad
				SET Propiedad.M3AcumuladosUltimoRecibo = R.Monto
				from  dbo.CCenPropiedad CP
				inner join dbo.CCConsumo CO on CP.ConceptoCobroId = CO.Id
				inner join dbo.ConceptoCobro C on CP.ConceptoCobroId = C.Id
				inner join dbo.Propiedad P on CP.PropiedadId = P.Id
				inner join dbo.Recibo R on CP.PropiedadId = R.PropiedadId
				WHERE P.FechaCreacion <= @FechaActual
			END

			-- Recibos de Conceptos de Cobro Fijo
			INSERT INTO Recibo(PropiedadId,ConceptoCobroId,
							   FechaEmision,FechaVencimiento,
							   Monto,Estado,Activo)
			SELECT P.Id,C.Id,
				   @FechaActual,dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@FechaActual)),@FechaActual)),
				   CF.Monto,0,1
			from  dbo.CCenPropiedad CP
			inner join dbo.CCFijo CF on CP.ConceptoCobroId = CF.Id
			inner join dbo.ConceptoCobro C on CP.ConceptoCobroId = C.Id
			inner join dbo.Propiedad P on CP.PropiedadId = P.Id
			where C.DiasDelMes = day(@FechaActual) and P.FechaCreacion <= @FechaActual

			-- Recibos de Conceptos de Cobro Porcentuales
			INSERT INTO Recibo(PropiedadId,ConceptoCobroId,
							   FechaEmision,FechaVencimiento,
							   Monto,Estado,Activo)
			SELECT P.Id,C.Id,
					@FechaActual,dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@FechaActual)),@FechaActual)),
					(P.Valor * CF.ValorPorcentaje/100),0,1
				from  dbo.CCenPropiedad CP
				inner join dbo.CCPorcentaje CF on CP.ConceptoCobroId = CF.Id
				inner join dbo.ConceptoCobro C on CP.ConceptoCobroId = C.Id
				inner join dbo.Propiedad P on CP.PropiedadId = P.Id
				where C.DiasDelMes = day(@FechaActual) and P.FechaCreacion <= @FechaActual

			-- Obtiene la cantidad de recibos pendientes de una propiedad con Consumo de agua
			-- para hacer los recibos de reconexion
			

			Delete @cantidadRecibosPendientesAgua

			INSERT INTO @cantidadRecibosPendientesAgua (idPropiedad,cantidadRecibos)
			SELECT R.PropiedadId,count(R.PropiedadId)
			from  dbo.Recibo R
			inner join dbo.CCConsumo CO on R.ConceptoCobroId = CO.Id
			inner join dbo.Propiedad P on R.PropiedadId = P.Id
			where R.Estado = 0 and R.Activo = 1
			GROUP BY R.PropiedadId

				-- Realiza el Recibo Padre del ReciboReconexion
			Insert into dbo.Recibo(PropiedadId,ConceptoCobroId,FechaEmision,FechaVencimiento,Monto,Estado,Activo)
			SELECT	P.Id,C.Id,@FechaActual,
					dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@FechaActual)),@FechaActual)),
				CF.Monto,
				 0,1
			from  @cantidadRecibosPendientesAgua CR, dbo.Propiedad P,dbo.ConceptoCobro C,dbo.CCFijo CF
			WHERE CR.cantidadRecibos > 1 and C.Nombre = 'Reconexion de agua' AND C.Id = CF.Id and CR.idPropiedad= P.Id
			AND NOT EXISTS (SELECT * from dbo.Recibo R
							where R.PropiedadId = CR.idPropiedad AND C.Nombre = 'Reconexion de agua' 
							and R.ConceptoCobroId = C.Id and R.Activo = 1 and R.Estado = 0)


			INSERT INTO dbo.ReciboReconexion (Id,Activo)
			SELECT R.Id,1
			from  dbo.Recibo R,@cantidadRecibosPendientesAgua CR,dbo.ConceptoCobro C
			WHERE R.PropiedadId = CR.idPropiedad and R.ConceptoCobroId=C.Id and C.Nombre = 'Reconexion de agua' and R.FechaEmision=@FechaActual
			and NOT EXISTS(SELECT* from dbo.ReciboReconexion) 
			and NOT EXISTS (SELECT * from dbo.ReciboReconexion RR where R.Id = RR.Id AND R.PropiedadId = CR.idPropiedad AND R.Activo=1 and R.Estado=0)
			--PRINT('PASO RECIBOS - RECONEXION')


			INSERT INTO DBO.Corta (PropiedadId,ReciboReconexionId,Fecha,Activo)
			SELECT R.PropiedadId,RR.Id,@FechaActual,1
			from dbo.Recibo R
			inner join dbo.ReciboReconexion RR on R.Id = RR.Id 
			inner join dbo.Propiedad P on R.PropiedadId = P.Id
			where R.Estado = 0 and R.Activo = 1 and 
			NOT EXISTS (SELECT * from dbo.Corta C) and
			NOT EXISTS (SELECT * from dbo.Corta C where C.ReciboReconexionId = RR.Id and C.Activo = 1
																  and RR.Activo = 1 and R.Estado = 0)
				--PRINT('PASO RECIBOS - CORTA')
				

			--END
			
		COMMIT TRANSACTION T2
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION T2
		PRINT('ERROR EN GENERACION DE RECIBOS')
	END CATCH

	-- Generacion de recibosAP
	EXEC SP_Generar_RecibosAP @FechaActual

	-- Pagos
				-- <Pago TipoRecibo="1-9/11" NumFinca="1420570"/>
	
	DELETE @Pagos

	INSERT INTO @Pagos(TipoRecibo,NumFinca)
	SELECT TipoRecibo1,NumeroFinca1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/Pago',1)
		WITH ( 
			TipoRecibo1 int '@TipoRecibo',
			NumeroFinca1 int '@NumFinca',
			FechaCreacion1 date '../@fecha'
		),dbo.ConceptoCobro C
	Where (FechaCreacion1 = @FechaActual) and C.Id = TipoRecibo1 and C.Nombre != 'Reconexion de agua'

	DECLARE @lowPago int = 0
	DECLARE @highPago int = -1


	Select @lowPago = min(P.id), @highPago = max(P.id)
	from @Pagos P

	Declare @RecibosAPagar table (
			id int not null Primary Key identity(1,1),
			idRecibo int not null,
			montoInteresesMoratorios money not null,
			idConceptoCobro int not null
		)
	DECLARE @sumaTotal money 
	DECLARE @idComprobante int

	while @lowPago <= @highPago
	BEGIN
		delete @RecibosAPagar
		SET @sumaTotal = 0.0
		SET @idComprobante = -1

		Insert into @RecibosAPagar(idRecibo,montoInteresesMoratorios,idConceptoCobro)
		SELECT R.Id
				,case
				when @FechaActual<=R.FechaVencimiento then 0 -- no tiene que generarse recibo de int moratorios
				else (R.Monto*C.TasaIntMor/365)*abs(datediff(day, R.FechaVencimiento, @FechaActual))
					-- SI tiene que generarse recibo
				end
				,R.ConceptoCobroId
		from dbo.Recibo R
		inner join dbo.Propiedad Pr on R.PropiedadId = Pr.Id,
		@Pagos P,
		dbo.ConceptoCobro C
		where P.id = @lowPago and Pr.NumeroFinca = P.NumFinca and R.ConceptoCobroId = P.TipoRecibo
			  and R.FechaEmision <= @FechaActual and R.Estado = 0 AND R.ConceptoCobroId = C.Id


		IF EXISTS (SELECT * from @RecibosAPagar)
		BEGIN

			Select @sumaTotal = sum(R.Monto + RP.montoInteresesMoratorios)
			from @RecibosAPagar RP
			inner join dbo.Recibo R on RP.idRecibo = R.Id

			DECLARE @esAP int
					,@idAP int

			SELECT @esAP = R.idConceptoCobro
			from @RecibosAPagar R

			SELECT @idAP = A.Id
			from dbo.AP A inner join dbo.MovimientosAP M on A.Id = M.IdAP 
				,dbo.Recibo R inner join dbo.RecibosAP RA on R.Id = RA.Id
				,@RecibosAPagar RP
				where RP.idRecibo = R.Id and RA.IdMovimientoAP = M.Id

			Insert dbo.ComprobantePago (Fecha,TotalPagado,MedioPago,Activo) values(
				@FechaActual,@sumaTotal,case when @esAP = 12   then 'AP# ' + CAST (@idAP AS varchar(15)) else
												'Pago' end,1
			)

			
			Select @idComprobante = max(C.Id)
			from dbo.ComprobantePago C

			UPDATE [dbo].[Recibo]
			SET [Recibo].Estado = 1,[Recibo].ComprobanteId = @idComprobante
			from @RecibosAPagar R
			where [Recibo].Id = R.idRecibo and [Recibo].Estado = 0
					and [Recibo].FechaEmision <= @FechaActual

			-- Crea los recibos de Intereses Moratorios
			INSERT into dbo.Recibo (PropiedadId,ConceptoCobroId,ComprobanteId,
									FechaEmision,FechaVencimiento,
									Monto,Estado,Activo)
			Select R.PropiedadId,C.Id,@idComprobante,@FechaActual,
					dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@FechaActual)),@FechaActual)),
					RP.montoInteresesMoratorios,1,1
			from @RecibosAPagar RP, dbo.Recibo R,dbo.ConceptoCobro C inner join dbo.CCInteresesMoratorios CIM on C.Id = CIM.Id
			where RP.idRecibo = R.Id and RP.montoInteresesMoratorios > CONVERT(money,0)
			and  R.FechaVencimiento> @FechaActual

		END
		SET @lowPago = @lowPago + 1
	END

	
	-- Pagos de reconexion
				--<Pago TipoRecibo= "10"> 

	DELETE @Pagos

	INSERT INTO @Pagos(TipoRecibo,NumFinca)
	SELECT TipoRecibo1,NumeroFinca1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/Pago',1)
		WITH ( 
			TipoRecibo1 int '@TipoRecibo',
			NumeroFinca1 int '@NumFinca',
			FechaCreacion1 date '../@fecha'
		),dbo.ConceptoCobro C
	Where (FechaCreacion1 = @FechaActual) and C.Id = TipoRecibo1 and C.Nombre = 'Reconexion de agua'

	SET @lowPago = 0
	SET @highPago = -1


	Select @lowPago = min(P.id), @highPago = max(P.id)
	from @Pagos P

	while @lowPago <= @highPago
	BEGIN

		delete @RecibosAPagarReconexion

		Insert into @RecibosAPagarReconexion(idRecibo,montoInteresesMoratorios)
		SELECT R.Id,case
		when @FechaActual<=R.FechaVencimiento then 0.0 -- no tiene que generarse recibo de int moratorios
		else (R.Monto*C.TasaIntMor/365)*abs(datediff(day, R.FechaVencimiento, @FechaActual))
			-- SI tiene que generarse recibo
		end

		from dbo.Recibo R
		inner join dbo.Propiedad Pr on R.PropiedadId = Pr.Id,
		@Pagos P,
		dbo.ConceptoCobro C
		where P.id = @lowPago and Pr.NumeroFinca = P.NumFinca and R.ConceptoCobroId = P.TipoRecibo
			  and R.FechaEmision <= @FechaActual and R.Estado = 0 AND R.ConceptoCobroId = C.Id

		IF EXISTS (SELECT * from @RecibosAPagarReconexion)
		BEGIN
			SET  @sumaTotalReconexion = 0  -- afuera del while

			Select @sumaTotalReconexion = sum(R.Monto + RP.montoInteresesMoratorios)
			from @RecibosAPagarReconexion RP
			inner join dbo.Recibo R on RP.idRecibo = R.Id

			Insert dbo.ComprobantePago (Fecha,TotalPagado,MedioPago,Activo) values(
				@FechaActual,@sumaTotalReconexion,'Reconexion',1
			)

			
			Select @idComprobanteReconexion = max(C.Id)
			from dbo.ComprobantePago C

			UPDATE [dbo].[Recibo]
			SET [Recibo].Estado = 1,[Recibo].ComprobanteId = @idComprobanteReconexion
			from @RecibosAPagar R
			where [Recibo].Id = R.idRecibo and [Recibo].Estado = 0
					and [Recibo].FechaEmision <= @FechaActual

			-- Crea los recibos de Intereses Moratorios
			INSERT into dbo.Recibo (PropiedadId,ConceptoCobroId,ComprobanteId,
									FechaEmision,FechaVencimiento,
									Monto,Estado,Activo)
			Select R.PropiedadId,C.Id,@idComprobanteReconexion,@FechaActual,
					dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(@FechaActual)),@FechaActual)),
					RP.montoInteresesMoratorios,1,1
			from @RecibosAPagar RP, dbo.Recibo R,dbo.ConceptoCobro C inner join dbo.CCInteresesMoratorios CIM on C.Id = CIM.Id
			where RP.idRecibo = R.Id and RP.montoInteresesMoratorios > CONVERT(money,0)
			and  R.FechaVencimiento> @FechaActual

			
		END

		

		SET @lowPago = @lowPago + 1
	END

	INSERT INTO dbo.Reconexion (PropiedadId,ReciboReconexionId,Fecha,Activo)
	SELECT C.PropiedadId,C.ReciboReconexionId,@FechaActual,1
	from dbo.Recibo R
	inner join dbo.ReciboReconexion RR on R.Id = RR.Id
	inner join dbo.Corta C on R.Id = C.ReciboReconexionId
	where R.Estado = 1
	AND NOT EXISTS (SELECT * from dbo.Reconexion RE)
	AND NOT EXISTS (SELECT * from dbo.Reconexion RE where RE.ReciboReconexionId = RR.Id and RE.Activo = 1
																	and RR.Activo = 1 and R.Estado = 0)
			
	-- Arreglos de Pago <AP NumFinca=h123h, Plazo=h12h/>
	
	
	INSERT INTO @ArregloPago(NumeroFinca,Plazo)
	SELECT NumeroFinca1,Plazo1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/AP',1)
		WITH ( 
			NumeroFinca1 int '@NumFinca',
			Plazo1 int '@Plazo',
			FechaCreacion10 date '../@fecha'
		)
	Where (FechaCreacion10 = @FechaActual)
	
	IF EXISTS(SELECT * from @ArregloPago)
	BEGIN
		EXEC SP_Generar_AP @ArregloPago,@FechaActual
	END

	

	SET		@counterInicio = @counterInicio + 1
	DELETE @ArregloPago
END;

EXEC sp_xml_removedocument @hdoc;

SELECT * FROM dbo.ComprobantePago C where C.MedioPago LIKE 'AP#%'

		