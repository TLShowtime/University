USE [Tarea2]

delete dbo.CCenPropiedad;
delete dbo.PropietarioDePropiedad;
delete dbo.UsuarioDePropiedad;
delete dbo.Propiedad;
delete dbo.PersonaJuridica;
delete dbo.Propietario;

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

DECLARE @XMLData XML
DECLARE @hdoc int
SET NOCOUNT ON

SELECT @XMLData = C
FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Operaciones.xml',SINGLE_BLOB) AS Operaciones(C)
EXEC sp_xml_preparedocument @hdoc OUTPUT,@XMLData

DECLARE @PersonasJuridicas TABLE (
		docIdPersonaJuridica varchar(30),
		TipoDocIdPJ int, 

		DocidRepresentante varchar(30),
		Nombre varchar(100),
		TipoDocIdRepresentante int,
		FechaCreacion date
	)


WHILE @counterInicio <= @counterFin
BEGIN
	DECLARE @FechaActual date
	SELECT @FechaActual = F.Fecha
	FROM @Fechas F
	WHERE F.Id = @counterInicio



	-- Insercion de Propiedades
	INSERT INTO Propiedad(Valor,Direccion,NumeroFinca,FechaCreacion,Activo,M3Acumulados,M3AcumuladosUltimoRecibo)
	SELECT Valor,Direccion,NumeroFinca,FechaCreacion,Activo = 1,M3Acumulados = 0,M3AcumuladosUltimoRecibo = 0
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/Propiedad',1)
		WITH ( 
			Valor MONEY '@Valor',
			NumeroFinca INT '@NumFinca',
			Direccion VARCHAR(200) '@Direccion',
			FechaCreacion date '../@fecha'
		)
		Where FechaCreacion = @FechaActual

	--Insercion de Propietario

	INSERT INTO Propietario(ValorTipoDocId,Nombre,Identificacion,FechaCreacion,Activo)
	SELECT ValorTipoDocId,Nombre,Identificacion,FechaCreacion,Activo = 1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/Propietario',1)
		WITH ( 
			ValorTipoDocId int '@TipoDocIdentidad',
			Nombre varchar(100) '@Nombre',
			Identificacion varchar(30) '@identificacion',
			FechaCreacion date '../@fecha'
		)
		Where FechaCreacion = @FechaActual
	
	--Insercion de Personas Juridicas------------------
	
	INSERT INTO @PersonasJuridicas(DocidRepresentante,TipoDocIdPJ,TipoDocIdRepresentante,Nombre,docIdPersonaJuridica,FechaCreacion)
	SELECT DocidRepresentante,TipoDocIdPJ,TipoDocIdRepresentante,Nombre,docIdPersonaJuridica,FechaCreacion
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/PersonaJuridica',1)
		WITH ( 
			docIdPersonaJuridica varchar(30) '@docidPersonaJuridica',
			TipoDocIdPJ int '@TipDocIdPJ',

			DocidRepresentante varchar(30) '@DocidRepresentante',
			Nombre varchar(100) '@Nombre',
			TipoDocIdRepresentante int '@TipDocIdRepresentante',
			FechaCreacion date '../@fecha'
		)
		Where FechaCreacion = @FechaActual
	
	INSERT INTO Propietario(ValorTipoDocId,Nombre,Identificacion,FechaCreacion,Activo) 
	SELECT J.TipoDocIdRepresentante,J.Nombre,J.DocidRepresentante,J.FechaCreacion,Activo = 1
	FROM @PersonasJuridicas J
	Where J.FechaCreacion = @FechaActual

	INSERT INTO dbo.PersonaJuridica(Id,ValorTipoDocId,Identificacion,Activo)
	SELECT P.Id,J.TipoDocIdPJ,J.docIdPersonaJuridica,Activo = 1
	FROM @PersonasJuridicas J inner join dbo.Propietario P
	ON J.FechaCreacion = @FechaActual and P.Identificacion = J.DocidRepresentante
	
	
	-- Insertar PropiedadVSPropietario
	INSERT INTO dbo.PropietarioDePropiedad(PropiedadId,PropietarioId,FechaInicio,Activo)
	SELECT dbo.Propiedad.Id,dbo.Propietario.Id,FechaInicio,Activo = 1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/PropiedadVersusPropietario',1)
		WITH ( 
			[NumFinca1] int '@NumFinca',
			[Identificacion1] varchar(30) '@identificacion',
			[FechaInicio] date '../@fecha'
		)
		inner join dbo.Propiedad on NumFinca1 = Propiedad.NumeroFinca
		inner join dbo.Propietario on Identificacion1 = Propietario.Identificacion
		Where FechaInicio = @FechaActual

	-- Insertar PropiedadVSPropietarioJuridico
	INSERT INTO dbo.PropietarioDePropiedad(PropiedadId,PropietarioId,FechaInicio,Activo)
	SELECT dbo.Propiedad.Id,dbo.PersonaJuridica.Id,FechaInicio,Activo = 1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/PropiedadVersusPropietario',1)
		WITH ( 
			[NumFinca1] int '@NumFinca',
			[Identificacion1] varchar(30) '@identificacion',
			[FechaInicio] date '../@fecha'
		)
		inner join dbo.Propiedad on NumFinca1 = Propiedad.NumeroFinca
		inner join dbo.PersonaJuridica on Identificacion1 = PersonaJuridica.Identificacion
		Where FechaInicio = @FechaActual

	-- insertar ConceptoCobroVersusPropiedad
	INSERT INTO dbo.CCenPropiedad(PropiedadId,ConceptoCobroId,FechaInicio,Activo)
	SELECT dbo.Propiedad.Id,dbo.ConceptoCobro.Id,FechaInicio,Activo = 1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/ConceptoCobroVersusPropiedad',1)
		WITH ( 
			[idCobro2] int '@idcobro',
			[numFinca2] int '@NumFinca',
			[FechaInicio] date '../@fecha'
		)
		inner join dbo.Propiedad on numFinca2 = Propiedad.NumeroFinca
		inner join dbo.ConceptoCobro on idCobro2 = ConceptoCobro.Id
		Where FechaInicio = @FechaActual
		
	-- Insercion de Usuarios
	INSERT INTO dbo.Usuario(Username,Contrasenna,TipoUsuario,Activo)
	SELECT Username,Contrasenna,Tipo1,1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/Usuario',1)
		WITH ( 
			Username varchar(100) '@Nombre',
			Contrasenna varchar(100) '@password',
			Tipo1 varchar(30) '@tipo',
			FechaCreacion date '../@fecha'
		)
		Where FechaCreacion = @FechaActual

	--INsercion de UsuarioVsPropiedad
	INSERT INTO dbo.UsuarioDePropiedad(UsuarioId,PropiedadId,FechaInicio,Activo)
	SELECT dbo.Usuario.Id,dbo.Propiedad.Id,FechaInicio,Activo = 1
	FROM OPENXML (@hdoc, '/Operaciones_por_Dia/OperacionDia/UsuarioVersusPropiedad',1)
		WITH ( 
			[nombreUsuario] varchar(100) '@nombreUsuario',
			[numFinca2] int '@NumFinca',
			[FechaInicio] date '../@fecha'
		)
		inner join dbo.Usuario on nombreUsuario = Usuario.Username
		inner join dbo.Propiedad on numFinca2 = Propiedad.NumeroFinca

		Where FechaInicio = @FechaActual

	SET @counterInicio = @counterInicio + 1
END;

EXEC sp_xml_removedocument @hdoc;
