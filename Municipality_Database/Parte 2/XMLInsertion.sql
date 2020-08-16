USE [Tarea2]

delete dbo.CCArregloPago
delete dbo.CCConsumo
delete dbo.CCFijo
delete dbo.CCPorcentaje
delete dbo.CCInteresesMoratorios
delete dbo.ConceptoCobro
delete dbo.TipoDocId
delete dbo.Usuario
delete dbo.TipoMovimiento
delete dbo.TipoEntidad

INSERT INTO dbo.ConceptoCobro(Id,Nombre,DiasDelMes,QDiasVencen,TasaIntMor,EsImpuesto,EsRecurrente,EsFijo,Activo)
SELECT
	CCobro.value('@id','int') as Id,
	CCobro.value('@Nombre','varchar(100)') as Nombre,
	CCobro.value('@DiaCobro','int') as DiasDelMes,
	CCobro.value('@QDiasVencimiento','int') as QDiasVencen,
	CCobro.value('@TasaInteresMoratoria','real') as TasaIntMor,
	CCobro.value('@EsImpuesto','varchar(2)') as EsImpuesto,
	CCobro.value('@EsRecurrente','varchar(2)') as EsRecurrente,
	CCobro.value('@EsFijo','varchar(2)') as EsFijo,
	Activo = 1
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Concepto de Cobro.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Conceptos_de_Cobro/conceptocobro') AS MY_XML (CCobro)


INSERT INTO dbo.CCConsumo(Id,ValorM3,MontoMinimoRecibo)
SELECT
	CCobro.value('@id','int') as Id,
	CCobro.value('@ValorM3','money') as ValorM3,
	CCobro.value('@MontoMinRecibo','money') as MontoMinimoRecibo
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Concepto de Cobro.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Conceptos_de_Cobro/conceptocobro') AS MY_XML (CCobro)
WHERE CCobro.value('@TipoCC','varchar(50)') = 'CC Consumo';
	
INSERT INTO dbo.CCFijo(Id,Monto)
SELECT
	CCobro.value('@id','int') as Id,
	CCobro.value('@Monto','money') as Monto
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Concepto de Cobro.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Conceptos_de_Cobro/conceptocobro') AS MY_XML (CCobro)
WHERE CCobro.value('@TipoCC','varchar(50)') = 'CC Fijo';

INSERT INTO dbo.CCPorcentaje(Id,ValorPorcentaje)
SELECT
	CCobro.value('@id','int') as Id,
	CCobro.value('@ValorPorcentaje','float') as Monto
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Concepto de Cobro.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Conceptos_de_Cobro/conceptocobro') AS MY_XML (CCobro)
WHERE CCobro.value('@TipoCC','varchar(50)') = 'CC Porcentaje';

INSERT INTO dbo.CCInteresesMoratorios(Id,Activo)
SELECT
	CCobro.value('@id','int') as Id,
	Activo = 1
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Concepto de Cobro.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Conceptos_de_Cobro/conceptocobro') AS MY_XML (CCobro)
WHERE CCobro.value('@TipoCC','varchar(50)') = 'CC Interes Moratorio';

INSERT INTO dbo.CCArregloPago(Id,Activo)
SELECT
	CCobro.value('@id','int') as Id,
	Activo = 1
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Concepto de Cobro.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Conceptos_de_Cobro/conceptocobro') AS MY_XML (CCobro)
WHERE CCobro.value('@TipoCC','varchar(50)') = 'Cuota Calculada';


------------------------------------------------------------------------------------------
INSERT INTO dbo.Usuario(Username,Contrasenna,TipoUsuario,Activo)
SELECT
	Usuario.value('@user','varchar(100)') as Username,
	Usuario.value('@password','varchar(100)') as Contrasenna,
	Usuario.value('@tipo','varchar(30)') as TipoUsuario,
	Activo = 1
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\Usuarios.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('Usuarios/Usuario') AS MY_XML (Usuario)

/*
Select *
from dbo.Usuario
*/
-------------------------------------------------------------------------------------
INSERT INTO dbo.TipoDocId(Id,Nombre,Activo)
SELECT
	TipoId.value('@codigoDoc','int') as Id,
	TipoId.value('@descripcion','varchar(100)') as Nombre,
	Activo = 1
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\TipoDocumentoIdentidad.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('TipoDocIdentidad/TipoDocId') AS MY_XML (TipoId)
/*
Select *
from dbo.TipoDocId
*/

-----------------------------------------------------
INSERT INTO dbo.TipoEntidad(Id,Nombre,Activo)
SELECT
	TipoId.value('@id','int') as Id,
	TipoId.value('@Nombre','varchar(100)') as Nombre,
	Activo = 1
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\TipoEntidad.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('TipoEntidades/Entidad') AS MY_XML (TipoId)


INSERT INTO dbo.TipoMovimiento(Id,Nombre,Activo)
SELECT
	TipoId.value('@id','int') as Id,
	TipoId.value('@Nombre','varchar(100)') as Nombre,
	Activo = 1
FROM (SELECT CAST(MY_XML AS xml)
	 FROM OPENROWSET (BULK 'C:\Users\liugu\Desktop\Pruebas_2\TipoTransConsumo.xml',SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
	 CROSS APPLY MY_XML.nodes('TipoTransConsumo/TransConsumo') AS MY_XML (TipoId)
