-- 
--DROP PROC SP_ConsultarPropiedades

CREATE PROC SP_ConsultarPropiedades(@inNombre varchar(100),@inIdentificacion varchar(30))
AS
BEGIN
	BEGIN TRY
		IF (@inNombre IS NULL AND @inIdentificacion IS NULL)
		BEGIN
			PRINT('Digite al menos un dato')
			return -5001
		END


		DECLARE @idPropietario int = NULL
		-- Busca el propietario
		Select @idPropietario = P.Id
		FROM dbo.Propietario P
		Where P.Nombre = @inNombre OR P.Identificacion = @inIdentificacion

		--Si no encontro a propietario
		IF (@idPropietario IS NULL)
		BEGIN
			PRINT('No existe el propietario')
			return -5002
		END
		Print(@idPropietario)

	
		DECLARE @idPersonaJuridica int
		/**Select @idPersonaJuridica = PJ.Id
		FROM dbo.PersonaJuridica PJ, dbo.Propietario P 
		Where (P.Nombre = @inNombre OR PJ.Identificacion = @inIdentificacion) and PJ.Id = P.Id 
		*/
		DECLARE @PropConProp table(id int identity(1,1) not null,PropietarioId int not null,PropiedadId int not null) 

		Insert into @PropConProp(PropietarioId,PropiedadId)
		Select PP.PropietarioId,PP.PropiedadId
		FROM dbo.PropietarioDePropiedad PP
		WHERE PP.PropietarioId = @idPropietario or PP.PropietarioId = @idPersonaJuridica


		Select  P.NumeroFinca,P.Valor,P.Direccion
		FROM @PropConProp PP
		inner join  dbo.Propiedad P on  PP.PropiedadId = P.Id 
	END TRY
	BEGIN CATCH
		return @@ERROR *-1
	END CATCH
END

select * from dbo.PropietarioDePropiedad

EXEC SP_ConsultarPropiedades '','3102456541'
-- Ver si los dos son iguales