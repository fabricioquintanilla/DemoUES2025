create database DWVentas
go

use DWVentas
go

create table DimCliente(
CustomerKey int identity(1,1) not null primary key, --Llave surrogada
CustomerID int not null, --Llave de negocio
DUI nvarchar(9),
Contacto nvarchar(100),
Region nvarchar(100),
Direccion nvarchar(500),
Pais nvarchar(100))
go

create table DimVendedor(
EmployeeKey int identity(1,1) not null primary key, --Llave surrogada
EmployeeID int not null, --Llave de negocio
Nombre nvarchar(100),
Ciudad nvarchar(100),
Pais nvarchar(100))
go

create table DimProducto(
ProductKey int identity(1,1) not null primary key, --Llave surrogada
ProductID int not null, --Llave de negocio
Nombre nvarchar(50),
PrecioUnitario float,
Descontinuado bit,
CategoriaProducto nvarchar(100))
go

create table DimProveedor(
SupplierKey int identity(1,1) not null primary key, --Llave surrogada
SupplierID int not null, --Llave de negocio
Compania nvarchar(100),
Ciudad nvarchar(100),
Pais nvarchar(100))
go

create table DimTiempo(
TiempoKey int not null primary key, --Llave surrogada
Fecha smalldatetime not null, --Llave de negocio
Dia int,
Mes int,
Anio int,
NombreDia nvarchar(10),
NombreMes nvarchar(15),
Semestre tinyint,
Trimestre tinyint)
go

create table FactVentas(
CustomerKey int not null,
EmployeeKey int not null,
ProductKey int not null,
SupplierKey int not null,
TiempoKey int not null,
CantidadVentas tinyint not null,
TotalVentas float)
go
--Agregar llave primaria para tabla de hechos
alter table FactVentas add constraint VentasPK primary key
(CustomerKey, EmployeeKey, ProductKey, SupplierKey, TiempoKey)
go

--Agregar laves foraneas para tabla de hechos
alter table FactVentas add constraint Clientes_Ventas foreign key
(CustomerKey) references DimCliente(CustomerKey)
go

alter table FactVentas add constraint Vendedores_Ventas foreign key
(EmployeeKey) references DimVendedor(EmployeeKey)
go

alter table FactVentas add constraint Proveedores_Ventas foreign key
(SupplierKey) references DimProveedor(SupplierKey)
go

alter table FactVentas add constraint Productos_Ventas foreign key
(ProductKey) references DimProducto(ProductKey)
go

alter table FactVentas add constraint Tiempo_Ventas foreign key
(TiempoKey) references DimTiempo(TiempoKey)
go
