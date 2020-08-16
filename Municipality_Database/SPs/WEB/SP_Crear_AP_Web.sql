Use [Tarea2]
GO
IF OBJECT_ID('[dbo].[SP_Crear_AP_Web]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[SP_Crear_AP_Web]
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC SP_Crear_AP_Web @inNumFinca int,@outMonto decimal OUTPUT
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON

		DECLARE @montoTotal money
				,@tasaInteres real
				,@idPropiedad int

		SELECT @idPropiedad = P.Id
		from dbo.Propiedad P where P.NumeroFinca = @inNumFinca

		-- Verifica si existe la propiedad
		IF (@idPropiedad <= 0 or @idPropiedad IS NULL )
		BEGIN
			RETURN -1
		END

		-- Saca la tasa de interes de la tabla de Configuraciones -- 0.10
		SELECT @tasaInteres = CASE when TVC.NombreTipo='decimal' THEN (CONVERT(real,VC.Valor)/100) end
		from dbo.ValoresConfiguracion VC inner join dbo.TiposValoresConfiguracion TVC on VC.IdTipo = TVC.Id

		BEGIN TRAN

				--Generar RECIBOS INT MORATORIOS
			INSERT into dbo.Recibo (PropiedadId,ConceptoCobroId,
									FechaEmision,FechaVencimiento,
									Monto,Estado,Activo)
			Select R.PropiedadId,C.Id,GETDATE()
					,dateadd(MONTH,1,dateadd(DAY,(C.QDiasVencen-DAY(GETDATE())),GETDATE()))
					,(R.Monto*C.TasaIntMor/365)*abs(datediff(day, R.FechaVencimiento, GETDATE()))
					,0,1
			from dbo.Recibo R inner join dbo.ConceptoCobro C  on R.ConceptoCobroId = C.Id
			where @idPropiedad = R.PropiedadId and R.Estado = 0 and R.Activo = 1
			and GETDATE() > R.FechaVencimiento and R.ConceptoCobroId != 12
		
			-- Suma los montos de los recibos pendientes de una propiedad
			SELECT @montoTotal = sum(R.Monto)
			from dbo.Recibo R
			where R.Estado = 0 and R.Activo = 1 and R.PropiedadId = @idPropiedad and R.ConceptoCobroId != 12;

		COMMIT

		SELECT @outMonto = CONVERT (decimal,@montoTotal)

		RETURN 1 -- Exito
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT >0
			ROLLBACK TRAN
		PRINT('Hubo un error, no se generaron APs');
		RETURN @@ERROR * -1
	END CATCH
END;


