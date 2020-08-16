Use [Tarea2]

/**
	DELETE ValoresConfiguracion
	DELETE TiposValoresConfiguracion
	DELETE RecibosAP
	DELETE MovimientosAP
	DELETE AP
	DELETE TipoMovAP
	DELETE CCArregloPago	
*/
/** 
	DROP TABLE ValoresConfiguracion
	DROP TABLE TiposValoresConfiguracion
	DROP TABLE RecibosAP
	DROP TABLE MovimientosAP
	DROP TABLE AP
	DROP TABLE TipoMovAP
	DROP TABLE CCArregloPago	
	

*/

ALTER table dbo.ComprobantePago
add MedioPago varchar(10) not null

CREATE TABLE CCArregloPago(
	Id int not null Primary Key Foreign Key references ConceptoCobro(Id),
	Activo int not null
)

CREATE TABLE TipoMovAP(
	Id int not null Primary Key,
	Nombre varchar(50) not null,
	Activo int not null
);

CREATE TABLE AP (
	Id int not null identity(1,1) Primary Key,
	IdPropiedad int not null Foreign Key references Propiedad(Id),
	IdComprobante int Foreign Key references ComprobantePago(Id),
	MontoOriginal money not null,
	Saldo money not null,
	TasaInteresAnual real not null,
	PlazoOriginal int not null,
	PlazoResta int not null,
	Cuota money not null,
	InsertAt datetime not null,
	UpdateAt datetime not null,
	Activo int not null
);

CREATE TABLE MovimientosAP(
	Id int not null identity(1,1) Primary Key,
	IdAP int not null Foreign Key references AP(Id),
	IdTipoMovId int not null Foreign Key references TipoMovAP(Id),
	Monto money not null,
	InteresesDelMes real not null,
	PlazoResta int not null,
	NuevoSaldo money not null,
	Fecha date not null,
	InsertedAt datetime not null,
	Activo int not null
);

CREATE TABLE RecibosAP (
	Id int not null Primary Key Foreign Key references Recibo(Id),
	IdMovimientoAP int not null Foreign Key references MovimientosAP(Id),
	Descripcion varchar(100) not null,
	Activo int not null
);

CREATE TABLE TiposValoresConfiguracion(
	Id int not null Primary Key,
	NombreTipo varchar(30) not null,
	Activo int not null
);

CREATE TABLE ValoresConfiguracion(
	Id int not null Primary Key,
	IdTipo int not null Foreign Key references TiposValoresConfiguracion(Id),
	Nombre varchar(30) not null,
	Valor varchar(100) not null,
	InsertedAt datetime not null,
	UpdatedAt datetime not null,
	Activo int not null
);

Insert into dbo.TiposValoresConfiguracion(Id,NombreTipo,Activo) 
	values
	(1,'decimal',1);

Insert into dbo.ValoresConfiguracion(Id,IdTipo,Nombre,Valor,InsertedAt,UpdatedAt,Activo) values(
	1,1,'TasaInteres AP', '10.0',CONVERT(varchar,getDate()), CONVERT(varchar,getDate()),1
);

Insert into dbo.TipoMovAP(Id,Nombre,Activo) values 
(1,'Credito',1),(2,'Debito',1);
