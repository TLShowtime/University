
--create DATABASE Municipalidad;

Use Tarea2;

create TABLE ConceptoCobro (
	Id int not null Primary Key,
	Nombre varchar(100) not null,
	DiasDelMes int not null,
	QDiasVencen int not null,
	TasaIntMor real not null,
	EsImpuesto varchar(2) not null,
	EsRecurrente varchar(2) not null,
	EsFijo varchar(2) not null,
	Activo int not null
);

-- Borra tablas
/*
drop Table dbo.UsuarioDePropiedad;
drop Table dbo.PersonaJuridica;
drop Table dbo.CCenPropiedad;
drop Table dbo.PropietarioDePropiedad;
drop Table dbo.CCConsumo;
drop Table dbo.CCFijo;
drop Table dbo.CCPorcentaje;
drop Table dbo.Propiedad;


drop Table dbo.Propietario;

drop Table dbo.Usuario;
drop Table dbo.ConceptoCobro;
drop Table dbo.TipoDocId;
*/
-- Borra datos
/*     
delete dbo.ConceptoCobro;
delete dbo.CCConsumo;
delete dbo.CCFijo;
delete dbo.CCPorcentaje;
delete dbo.Propiedad;
delete dbo.CCenPropiedad;
delete dbo.TipoDocId;
delete dbo.Propietario;
delete dbo.PersonaJuridica;
delete dbo.PropietarioDePropiedad;
delete dbo.Usuario;
delete dbo.UsuarioPropiedad;
*/



create TABLE CCFijo (
	Id int not null Primary Key Foreign Key references ConceptoCobro(Id),
	Monto Money not null
);

create TABLE CCConsumo (
	Id int not null Primary Key Foreign Key references ConceptoCobro(Id),
	ValorM3 Money not null
);

create TABLE CCPorcentaje (
	Id int not null Primary Key Foreign Key references ConceptoCobro(Id),
	ValorPorcentaje float not null
);

-- ---------------------------------------------------------

------------------------------------------------------------
create TABLE Propiedad (
	Id int identity(1,1) not null Primary Key,
	Valor Money not null,
	Direccion varchar(200) not null,
	NumeroFinca int not null,
	FechaCreacion date not null,
	Activo int not null
);

create TABLE CCenPropiedad (
	Id int identity(1,1) not null Primary Key,
	PropiedadId int not null Foreign Key references Propiedad(Id),
	ConceptoCobroId int not null Foreign Key references ConceptoCobro(Id),
	FechaInicio Date not null,
	FechaFinal Date,
	Activo int not null
);

create TABLE TipoDocId(
	Id int not null Primary Key,
	Nombre varchar(100) not null,
	Activo int not null
);

create TABLE Propietario(
	Id int identity(1,1) not null Primary Key,
	ValorTipoDocId int not null Foreign Key references TipoDocId(Id),
	Nombre varchar(100) not null,
	Identificacion varchar(30) not null,
	FechaCreacion date not null,
	Activo int not null
);
/*
ALTER TABLE dbo.Propietario
ADD FechaCreacion date not null*/

create TABLE PersonaJuridica(
	Id int not null Primary Key Foreign Key references Propietario(Id),
	ValorTipoDocId int not null Foreign Key references TipoDocId(Id),
	Identificacion varchar(30) not null,
	Activo int not null
);

create TABLE PropietarioDePropiedad(
	Id int identity(1,1) not null Primary Key,
	PropiedadId int not null Foreign Key references Propiedad(Id),
	PropietarioId int not null Foreign Key references Propietario(Id),
	FechaInicio Date not null,
	FechaFinal Date,
	Activo int not null
);

-- ----------------------------------------------
create TABLE Usuario(
	Id int identity(1,1) not null Primary Key,
	Username varchar(100) not null,
	Contrasenna varchar(100) not null,
	TipoUsuario varchar(30) not null,
	Activo int not null
);

create Table UsuarioDePropiedad(
	Id int identity(1,1) not null Primary Key,
	UsuarioId int not null Foreign Key references Usuario(Id),
	PropiedadId int not null Foreign Key references Propiedad(Id),
	FechaInicio Date not null,
	FechaFinal Date,
	Activo int not null
)
