
-- DROP PROC SP_ConsultarPropietarioDePropiedad
CREATE PROC SP_ConsultarPropietarioDePropiedad (@inNumFinca int)
AS
BEGIN
	BEGIN TRY
		IF (@inNumFinca IS NULL)
		BEGIN
			PRINT('Digite al menos un dato')
			return -5001
		END

		DECLARE @idPropiedad int = NULL

		Select @idPropiedad = P.Id
		FROM dbo.Propiedad P
		Where P.NumeroFinca = @inNumFinca

		--Si no encontro a propietario
		IF (@idPropiedad IS NULL)
		BEGIN
			PRINT('No existe la propiedad')
			return -5002
		END
		Print(@idPropiedad)

		DECLARE @PropConProp table(id int identity(1,1) not null,PropietarioId int not null,PropiedadId int not null) 

		Insert into @PropConProp(PropietarioId,PropiedadId)
		Select PP.PropietarioId,PP.PropiedadId
		FROM dbo.PropietarioDePropiedad PP
		WHERE PP.PropiedadId = @idPropiedad

		SELECT P.Nombre,P.Identificacion,J.NumeroFinca,J.Valor,J.Direccion
		FROM @PropConProp PP
		inner join dbo.Propietario P on PP.PropietarioId = P.Id
		inner join dbo.Propiedad J on PP.PropiedadId = J.Id
		return 1
	END TRY

	BEGIN CATCH
		return @@ERROR *-1
	END CATCH
END;

select * from dbo.PropietarioDePropiedad 

EXEC SP_ConsultarPropietarioDePropiedad 2291223