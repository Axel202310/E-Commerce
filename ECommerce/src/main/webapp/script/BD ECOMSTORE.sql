---------------------------------------
-- Base de datos : EcomStore S.A.C
---------------------------------------
drop database EcomStore;
create database EcomStore;
use EcomStore;

-- Tabla : Categorias
DROP TABLE IF EXISTS Categorias;
CREATE TABLE Categorias(
    IdCategoria CHAR(6) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY (IdCategoria),
    CHECK(Estado IN ('0','1'))
);

-- Insertar filas en la tabla Categorias
INSERT INTO Categorias VALUES('CAT001','Minimarket','logoMinimarket.jpg','1');
INSERT INTO Categorias VALUES('CAT002','Hogar','logoHogar.jpg','1');
INSERT INTO Categorias VALUES('CAT003','Equipos Tecnologicos','logoTecnologia.jpg','1');
INSERT INTO Categorias VALUES('CAT004','Music Market','logoMusica.jpg','1');
INSERT INTO Categorias VALUES('CAT005','Ropa','logoRelativaropa.jpg','1');
INSERT INTO Categorias VALUES('CAT006','Medicina','logoFarma.jpg','1');

-- Tabla : Productos
DROP TABLE IF EXISTS Productos;
CREATE TABLE Productos(
    IdProducto CHAR(8) NOT NULL,
    IdCategoria CHAR(6) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    Stock INT NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdProducto),
    FOREIGN KEY(IdCategoria) REFERENCES Categorias(IdCategoria),
    CHECK(PrecioUnidad > 0),
    CHECK(Stock > 0),
    CHECK(Estado IN ('0','1'))
);

-- Insertar filas en la tabla Productos
INSERT INTO Productos VALUES('PRO00001','CAT001','Mini Oreo',
5,10,'minioreo.jpg','1');
INSERT INTO Productos VALUES('PRO00002','CAT001','Acuarius',
10,10,'acuarius.jpg','1');
INSERT INTO Productos VALUES('PRO00003','CAT001','Frac',
1.50,10,'frac.jpg','1');
INSERT INTO Productos VALUES('PRO00004','CAT001','7UP',
3,10,'7up.jpg','1');
INSERT INTO Productos VALUES('PRO00005','CAT001','Pepsi',
2.50,10,'pepsi.jpg','1');
INSERT INTO Productos VALUES('PRO00006','CAT001','chocapic',
6.99,10,'chocapic.jpg','1');
INSERT INTO Productos VALUES('PRO00007','CAT001','Gretel',
1,10,'gretel.jpg','1');
INSERT INTO Productos VALUES('PRO00008','CAT001','Mentas',
0.50,10,'mentas.jpg','1');
INSERT INTO Productos VALUES('PRO00009','CAT001','Obsesion',
1.50,10,'obsesion.jpg','1');
INSERT INTO Productos VALUES('PRO00010','CAT001','Powerade',
2.50,10,'powerade.jpg','1');

INSERT INTO Productos VALUES('PRO00011','CAT002','Ambientador',
20,10,'ambientador.jpg','1');
INSERT INTO Productos VALUES('PRO00012','CAT002','Cesta de Ropa',
30,10,'cestaropa.jpg','1');
INSERT INTO Productos VALUES('PRO00013','CAT002','Cuchillos',
40,10,'cuchillos.jpg','1');
INSERT INTO Productos VALUES('PRO00014','CAT002','Glade',
12,10,'glade.jpg','1');
INSERT INTO Productos VALUES('PRO00015','CAT002','Juego de Tazas',
50,10,'juegodetazas.jpg','1');
INSERT INTO Productos VALUES('PRO00016','CAT002','Mezclador',
200,10,'mezclador.jpg','1');
INSERT INTO Productos VALUES('PRO00017','CAT002','Papel Higienico',
14,10,'papelH.jpg','1');
INSERT INTO Productos VALUES('PRO00018','CAT002','Pilas Energizer',
7,10,'pila.jpg','1');
INSERT INTO Productos VALUES('PRO00019','CAT002','Toallas Humedas',
12,10,'toallashumedas.jpg','1');
INSERT INTO Productos VALUES('PRO00020','CAT002','Licuadora Oster',
540,10,'licuadoraOster.jpg','1');


INSERT INTO Productos VALUES('PRO00021','CAT003','Laptop Asus Zenbook',
4500,10,'asusZenbook.jpg','1');
INSERT INTO Productos VALUES('PRO00022','CAT003','Laptop Lenovo',
3700,10,'laptopLenovo.jpg','1');
INSERT INTO Productos VALUES('PRO00023','CAT003','PC',
5000,10,'PC.jpg','1');
INSERT INTO Productos VALUES('PRO00024','CAT003','iPhone-15 Pro max',
7000,10,'iPhone-15.jpg','1');
INSERT INTO Productos VALUES('PRO00025','CAT003','Galaxy-A34',
1500,10,'Galaxy-A34.jpg','1');
INSERT INTO Productos VALUES('PRO00026','CAT003','Auriculares QCY',
80,10,'auricularesQCY.jpg','1');


INSERT INTO Productos VALUES('PRO00027','CAT004','Squier Mustang',
990,10,'squierMustang.jpg','1');
INSERT INTO Productos VALUES('PRO00028','CAT004','Fender stratocaster blanca',
1050,10,'fenderStratocaster.jpg','1');
INSERT INTO Productos VALUES('PRO00029','CAT004','Guitarra fender Acustica',
1900,10,'guitarraAcustica.jpg','1');
INSERT INTO Productos VALUES('PRO00030','CAT004','Fender Telecaster',
1500,10,'fenderTelecaster.jpg','1');
INSERT INTO Productos VALUES('PRO00031','CAT004','AKAI Drum Pad',
2500,10,'drumPad.jpg','1');
INSERT INTO Productos VALUES('PRO00032','CAT004','Fender JazzBass',
2500,10,'JazzBass.jpg','1');


INSERT INTO Productos VALUES('PRO00033','CAT005','Polera Negra',
85,10,'poleraNegra.jpg','1');
INSERT INTO Productos VALUES('PRO00034','CAT005','Camiseta Blanca',
50,10,'camisetaBlanca.jpg','1');
INSERT INTO Productos VALUES('PRO00035','CAT005','Chaqueta Marron',
200,10,'chaquetaMarron.jpg','1');
INSERT INTO Productos VALUES('PRO00036','CAT005','Jeans',
65,10,'jeans.jpg','1');
INSERT INTO Productos VALUES('PRO00037','CAT005','Camiseta Plata',
45,10,'camisetaPlata.jpg','1');
INSERT INTO Productos VALUES('PRO00038','CAT005','Zapatillas New Balance',
400,10,'zapatillasNewBalance.jpg','1');

INSERT INTO Productos VALUES('PRO00039','CAT006','Medicamento',
17.50,10,'medicina.jpg','1');
INSERT INTO Productos VALUES('PRO00040','CAT006','Jarabe Abrilar',
21.20,10,'abrilarJarabe.jpg','1');
INSERT INTO Productos VALUES('PRO00041','CAT006','Vick Vaporub',
14,10,'vickVaporub.jpg','1');
INSERT INTO Productos VALUES('PRO00042','CAT006','Panadol Forte',
1.78,10,'panadolForte.jpg','1');
INSERT INTO Productos VALUES('PRO00043','CAT006','Nastisol Antigripal',
11.74,10,'nastisolAntigripal.jpg','1');
INSERT INTO Productos VALUES('PRO00044','CAT006','Aspirina',
60,10,'aspirina.jpg','1');



-- Tabla : Usuarios
DROP TABLE IF EXISTS Usuarios;
CREATE TABLE Usuarios(
    IdUsuario CHAR(8) NOT NULL,
    Nombres VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    tipoUsuario VARCHAR(10) NOT NULL DEFAULT 'USER', 
    PRIMARY KEY(IdUsuario),
    CHECK(Sexo IN ('M','F')),
    CHECK(Estado IN ('0','1'))
);


-- Insertar usuarios con el campo tipoUsuario - CLIENTES
INSERT INTO Usuarios VALUES('CLI00001','RIVERA RIOS','JUAN CARLOS',
'AV.LIMA 1234-CERCADO','1990-05-01','M','jrivera@gmail.com','1234','1', 'USER');
INSERT INTO Usuarios VALUES('CLI00002','TORRES DURAN','CLAUDIA',
'AV.PRIMAVERA 1234-SURCO','1991-07-11','F','ctorres@gmail.com','1234','1', 'USER');
INSERT INTO Usuarios VALUES('CLI00003','VILLAR RAMOS','WALTER ISMAEL',
'AV.ARENALES 1525-LINCE','1989-12-01','M','wvillar@gmail.com','1234','1', 'USER');

-- Insertar usuarios con el campo tipoUsuario - ADMINISTRADORES
INSERT INTO Usuarios VALUES('ADM00001','RINCON RODRIGUEZ','ALONSO',
'AV.PRUEBA 2','1990-01-01','M','admin1@gmail.com','12345','1', 'ADMIN');

SELECT * FROM Usuarios;

-- Tabla : Ventas
DROP TABLE IF EXISTS Ventas;
CREATE TABLE Ventas(
    IdVenta CHAR(10) NOT NULL,
    IdCliente CHAR(8) NOT NULL,
    FechaVenta DATE NOT NULL,
    MontoTotal DECIMAL NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdCliente, IdVenta), -- Esto crea una clave primaria compuesta
    CHECK(MontoTotal > 0),
    CHECK(Estado IN ('0','1'))
);

-- Agregar un índice a la columna IdVenta
CREATE INDEX idx_IdVenta ON Ventas(IdVenta);

-- Mostrar la estructura de la tabla Ventas
DESCRIBE Ventas;

SELECT * FROM Ventas;

-- Tabla : Detalle
DROP TABLE IF EXISTS Detalle;
CREATE TABLE Detalle(
    IdVenta CHAR(10) NOT NULL,
    IdProducto CHAR(8) NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdVenta, IdProducto),
    FOREIGN KEY(IdVenta) REFERENCES Ventas(IdVenta),
    CHECK(Cantidad > 0),
    CHECK(PrecioUnidad >0),
    CHECK(Estado IN ('0','1'))
);

SELECT * FROM Detalle;

-- PROCEDIMIENTOS ALMACENADOS
-- Store Procedure : Listar Categorias
DROP PROCEDURE IF EXISTS ListarCategorias;
DELIMITER @@
CREATE PROCEDURE ListarCategorias()
BEGIN
    SELECT * FROM Categorias;
END @@
DELIMITER ;
-- Llamada al procedimiento almacenado
CALL ListarCategorias();

-- Store Procedure : InfoProducto
DROP PROCEDURE IF EXISTS InfoProducto;
DELIMITER @@
CREATE PROCEDURE InfoProducto(IdProd CHAR(8))	
BEGIN
    SELECT * FROM Productos WHERE IdProducto=IdProd;
END @@
DELIMITER ;
-- Llamada al procedimiento almacenado
CALL InfoProducto('PRO00003');

-- Store Procedure : ListarProductosXCategoria
DROP PROCEDURE IF EXISTS ListarProductosXCategoria;
DELIMITER //
CREATE PROCEDURE ListarProductosXCategoria(IdCat CHAR(6))
BEGIN
    SELECT * FROM Productos
    WHERE IdCategoria = IdCat;
END //
DELIMITER ;

CALL ListarProductosXCategoria('CAT001');

-- Store Procedure : InfoUsuario
DROP PROCEDURE IF EXISTS InfoUsuario;
DELIMITER @@
CREATE PROCEDURE InfoUsuario(IdUsu CHAR(8))
BEGIN
    SELECT * FROM Usuarios
    WHERE IdUsuario = IdUsu;
END @@
DELIMITER ;

CALL InfoUsuario('CLI00001');
CALL InfoUsuario('ADM00001');

-- Store Procedure : InsertaVenta
DROP PROCEDURE IF EXISTS InsertaVenta;
DELIMITER @@
CREATE PROCEDURE InsertaVenta(
    IdVenta CHAR(10),
    IdCliente CHAR(8),
    FechaVenta DATE,
    MontoTotal DECIMAL,
    Estado CHAR(1)
)
BEGIN
    INSERT INTO Ventas VALUES(IdVenta,IdCliente,FechaVenta,MontoTotal,Estado);
END @@
DELIMITER ;

-- Store Procedure : InsertaDetalle
DROP PROCEDURE IF EXISTS InsertaDetalle;
DELIMITER @@
CREATE PROCEDURE InsertaDetalle(
    IdVenta CHAR(10),
    IdProducto CHAR(8),
    Cantidad INT,
    PrecioUnidad DECIMAL,
    Estado CHAR(1)
)
BEGIN
    INSERT INTO Detalle VALUES(IdVenta,IdProducto,Cantidad,PrecioUnidad,Estado);
END @@
DELIMITER ;

-- Store Procedure : RegistrarUsuario
DROP PROCEDURE IF EXISTS RegistrarUsuario;
DELIMITER @@
CREATE PROCEDURE RegistrarUsuario(
    IN p_IdUsuario CHAR(8),
    IN p_Nombres VARCHAR(50),
    IN p_Apellidos VARCHAR(50),
    IN p_Direccion VARCHAR(50),
    IN p_FechaNacimiento DATE,
    IN p_Sexo CHAR(1),
    IN p_Correo VARCHAR(50),
    IN p_Password VARCHAR(50),
    IN p_Estado CHAR(1),
    IN p_TipoUsuario VARCHAR(10)
)
BEGIN
    INSERT INTO Usuarios (IdUsuario, Nombres, Apellidos, Direccion, FechaNacimiento, Sexo, Correo, Password, Estado, tipoUsuario)
    VALUES (p_IdUsuario, p_Nombres, p_Apellidos, p_Direccion, p_FechaNacimiento, p_Sexo, p_Correo, p_Password, p_Estado, p_TipoUsuario);
END @@
DELIMITER ;

-- Store Procedure : ListarUsuarios
DROP PROCEDURE IF EXISTS ListarUsuarios;
DELIMITER @@
CREATE PROCEDURE ListarUsuarios()
BEGIN
    SELECT * FROM Usuarios;
END @@
DELIMITER ;

-- Store Procedure : ListarProductos
DROP PROCEDURE IF EXISTS ListarProductos;
DELIMITER @@
CREATE PROCEDURE ListarProductos()
BEGIN
    SELECT * FROM Productos;
END @@
DELIMITER ;

-- Llamada al procedimiento almacenado
CALL ListarProductos();

-- Procedimiento almacenado para actualizar el stock de un producto después de una compra
DROP PROCEDURE IF EXISTS ActualizarStock;
DELIMITER @@
CREATE PROCEDURE ActualizarStock(
    IN p_IdProducto CHAR(8),
    IN p_Cantidad INT
)
BEGIN
    UPDATE Productos
    SET Stock = Stock - p_Cantidad
    WHERE IdProducto = p_IdProducto;
END @@
DELIMITER ;

-- Procedimiento almacenado para actualizar el precio de venta de un producto
DROP PROCEDURE IF EXISTS ActualizarPrecioVenta;
DELIMITER @@
CREATE PROCEDURE ActualizarPrecioVenta(
    IN p_IdProducto CHAR(8),
    IN p_Precio DECIMAL(10,2)
)
BEGIN
    UPDATE Productos
    SET PrecioUnidad = p_Precio
    WHERE IdProducto = p_IdProducto;
END @@
DELIMITER ;

-- Store Procedure : EliminarUsuario
DROP PROCEDURE IF EXISTS EliminarUsuario;
DELIMITER @@
CREATE PROCEDURE EliminarUsuario(
    IN p_IdUsuario CHAR(8)
)
BEGIN
    DELETE FROM Usuarios WHERE IdUsuario = p_IdUsuario;
END @@
DELIMITER ;