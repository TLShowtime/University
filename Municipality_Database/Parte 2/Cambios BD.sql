USE [Tarea2]

ALTER TABLE dbo.Propiedad
add M3Acumulados int not null, M3AcumuladosUltimoRecibo int not null

ALTER TABLE dbo.CCConsumo
add MontoMinimoRecibo money not null

/* 
USE [Tarea2]
DROP TABLE CCInteresesMoratorios
 
 
 
 DROP TABLE Movimiento
 DROP TABLE Corta
 DROP TABLE Reconexion
 DROP TABLE ReciboReconexion
 DROP TABLE Bitacora
 DROP TABLE TipoEntidad
 DROP TABLE TipoMovimiento
 DROP TABLE Recibo
 DROP TABLE ComprobantePago
 */

CREATE TABLE CCInteresesMoratorios (
	Id int not null Primary Key Foreign Key references ConceptoCobro(Id),
	Activo int not null
)


CREATE TABLE ComprobantePago (
	Id int identity(1,1) not null Primary Key,
	Fecha date not null,
	TotalPagado money not null,
	Activo int not null
)


CREATE TABLE Recibo (
	Id int identity(1,1) not null Primary Key,
	PropiedadId int not null Foreign Key references Propiedad(Id),
	ConceptoCobroId int not null Foreign Key references ConceptoCobro(Id),
	ComprobanteId int Foreign Key references ComprobantePago(Id),
	FechaEmision date not null,
	FechaVencimiento date not null,
	Monto money not null,
	Estado int not null, -- 0. Pendiente,1. Pagado, 2.Anulado(No tiene mayor peso)
	Activo int not null
)

CREATE table TipoMovimiento (
	Id int not null Primary Key,
	Nombre varchar(30) not null,
	Activo int not null
)

CREATE TABLE Movimiento (
	Id int identity(1,1) not null Primary Key,
	PropiedadId int not null Foreign Key references Propiedad(Id),
	TipoMovId int not null Foreign Key references TipoMovimiento(Id),
	Fecha date not null,
	MontoM3 int  not null,
	LecturaConsumo int not null,
	NuevoM3Acumulado int not null,
	Activo int not null,
	Descripcion varchar(100) not null
)


CREATE TABLE ReciboReconexion (
	Id int not null Primary Key Foreign Key references Recibo(Id),
	Activo int not null
)

CREATE TABLE Corta (
	Id int identity(1,1) not null Primary Key,
	PropiedadId int not null Foreign Key references Propiedad(Id),
	ReciboReconexionId int not null Foreign Key references ReciboReconexion(Id),
	Fecha date not null,
	Activo int not null
)

CREATE TABLE Reconexion (
	Id int identity(1,1) not null Primary Key,
	PropiedadId int not null Foreign Key references Propiedad(Id),
	ReciboReconexionId int not null Foreign Key references ReciboReconexion(Id),
	Fecha date not null,
	Activo int not null
)

CREATE TABLE TipoEntidad (
	Id int not null Primary Key,
	Nombre varchar(30) not null,
	Activo int not null
)

CREATE TABLE Bitacora (
	id int not null identity (1, 1) primary key ,
	IdEntityType int not null Foreign Key references TipoEntidad(Id), -- referencia a table EntityType
	EntityId int not null, -- Id de la entidad siendo actualizada
	jsonAntes varchar (500),
	jsonDespues varchar (500),
	insertedAt datetime, -- estampa de tiempo de cuando se hizo la actualizacion
	insertedby varchar (20), -- usuario persona que hizo la actualizacion
	insertedIn varchar(20), -- IP desde donde se hizo la actualizacion, NO la IP del servidor,
	Activo int not null		--	sino la del usuario que debe capturarse en capa logica.
)