---------------------------------------
-- Base de datos : EcomStore S.A.C
---------------------------------------
drop database EcomStore;
create database EcomStore;
use EcomStore;

-- Tabla : Categorias
DROP TABLE IF EXISTS Categorias;
CREATE TABLE Categorias(
    IdCategoria CHAR(6) NOT NULL UNIQUE,
    Descripcion VARCHAR(50) NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY (IdCategoria),
    CHECK(Estado IN ('0','1'))
);

-- Tabla : Usuarios
DROP TABLE IF EXISTS Usuarios;
CREATE TABLE Usuarios (
    IdUsuario INT NOT NULL AUTO_INCREMENT, -- Cambiado a INT para AUTO_INCREMENT
    Nombres VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    tipoUsuario VARCHAR(10) NOT NULL DEFAULT 'USER', -- Valor por defecto 'USER'
    PRIMARY KEY (IdUsuario),
    UNIQUE (Correo), -- Garantizar que el correo sea único
    CHECK (Sexo IN ('M', 'F'))
);

ALTER TABLE Usuarios 
ADD Estado CHAR(1) NOT NULL DEFAULT '1' 
CHECK (Estado IN ('0', '1'));


-- Tabla : Productos
DROP TABLE IF EXISTS Productos;
CREATE TABLE Productos(
    IdProducto CHAR(8) NOT NULL UNIQUE,
    IdCategoria CHAR(6) NOT NULL,
    Marca VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(150) NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    Stock INT NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdProducto),
    FOREIGN KEY(IdCategoria) REFERENCES Categorias(IdCategoria),
    CHECK(PrecioUnidad > 0),
    CHECK(Stock >= 0),
    CHECK(Estado IN ('0','1'))
);



-- Tabla : MetodoPago
DROP TABLE IF EXISTS MetodoPago;
CREATE TABLE MetodoPago(
    IdMetodoPago INT AUTO_INCREMENT,  -- El ID se autogenera de forma incremental
    TipoPago VARCHAR(50) NOT NULL,  -- Ejemplo: 'Tarjeta de Crédito', 'Efectivo'
    Nombre VARCHAR(50),
    Numero CHAR(16),
    Expiracion VARCHAR(10),
    Codigo CHAR(3),
    FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (IdMetodoPago)
);   

-- Tabla : Ventas
DROP TABLE IF EXISTS Ventas;
CREATE TABLE Ventas(
    IdVenta CHAR(10) NOT NULL,
    IdCliente CHAR(8) NOT NULL,
    IdMetodoPago int references MetodoPago(IdMetodoPago),
    FechaVenta DATE NOT NULL,
    MontoTotal DECIMAL NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdVenta), -- Esto crea una clave primaria compuesta
    CHECK(MontoTotal > 0),
    CHECK(Estado IN ('0','1'))
);


-- Tabla : Detalle
DROP TABLE IF EXISTS Detalle;
CREATE TABLE Detalle(
    IdDetalle VARCHAR(10) PRIMARY KEY NOT NULL,
    IdVenta CHAR(10) NOT NULL,
    IdProducto CHAR(8) REFERENCES Productos(IdProducto),
    Cantidad INT NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    FOREIGN KEY(IdVenta) REFERENCES Ventas(IdVenta),
    FOREIGN KEY(IdProducto) REFERENCES Productos(IdProducto),
    CHECK(Cantidad > 0),
    CHECK(PrecioUnidad >0)
);

-- Insertar filas en la tabla Categorias
INSERT INTO Categorias VALUES('CAT001','Consolas','consola.png','1');
INSERT INTO Categorias VALUES('CAT002','TV','TV.png','1');
INSERT INTO Categorias VALUES('CAT003','Celulares','celular.png','1');
INSERT INTO Categorias VALUES('CAT004','Smartwatches','smartwatch.png','1');
INSERT INTO Categorias VALUES('CAT005','Laptops','laptop.png','1');
INSERT INTO Categorias VALUES('CAT006','Tablets','tablet.png','1');
INSERT INTO Categorias VALUES('CAT007','Autoradios','autoradio.png','1');


-- Insertar filas en la tabla Productos
-- CONSOLAS
INSERT INTO Productos VALUES('PRO00001','CAT001','MICROSOFT','Consola Xbox Serie X 1TB bluetooth, negro',
2500,10,'consola1.png','1');
INSERT INTO Productos VALUES('PRO00002','CAT001','SONY','Consola PS5 con lector de discos, Bundle Spider-Man 2',
3000,10,'consola2.png','1');
INSERT INTO Productos VALUES('PRO00003','CAT001','PLAYSTATION','Consola PS4 1TB + God of War Ragnarok',
2200,10,'consola3.png','1');
INSERT INTO Productos VALUES('PRO00004','CAT001','NINTENDO','Consola Nintendo Switch Oled Edicion Splatoon 3',
1500,10,'consola4.png','1');
INSERT INTO Productos VALUES('PRO00005','CAT001','GENERICO','Consola de videojuegos de TV Retro M10 64GB',
150,10,'consola5.png','1');
INSERT INTO Productos VALUES('PRO00006','CAT001','NINTENDO','Consola Nintendo Switch Oled Pokémon Escarlata/Púrpura',
2000,10,'consola6.png','1');
INSERT INTO Productos VALUES('PRO00007','CAT001','MICROSOFT','Consola Xbox Series S 512 GB',
1500,10,'consola7.png','1');
INSERT INTO Productos VALUES('PRO00008','CAT001','PLAYSTATION','Consola PS5 HW Slim Edición Digital Bundle',
2300,10,'consola8.png','1');
INSERT INTO Productos VALUES('PRO00009','CAT001','NINTENDO','Consola Nintendo Switch + Mario Kart 8 Deluxe',
1600,10,'consola9.png','1');


INSERT INTO Productos VALUES('PRO00010','CAT002','SAMSUNG','Smart TV 65" Samsung Crystal 4K, Ultra HD',
1990,10,'tele1.png','1');
INSERT INTO Productos VALUES('PRO00011','CAT002','LG','Smart TV LG 4K 55" ThinQ Ai, Ultra HD',
1700,10,'tele2.png','1');
INSERT INTO Productos VALUES('PRO00012','CAT002','SAMSUNG','Televisor 65 Crystal Uhd Du7000 4k Tizen Os Smart Tv ',
1800,10,'tele3.png','1');
INSERT INTO Productos VALUES('PRO00013','CAT002','LG','Televisor LG UHD 65” 4K Smart TV con ThinQ AI',
2100,10,'tele4.png','1');
INSERT INTO Productos VALUES('PRO00014','CAT002','SAMSUNG','Televisor Samsung 75 Pulg. Crystal Smart TV UHD 4K',
3400,10,'tele5.png','1');
INSERT INTO Productos VALUES('PRO00015','CAT002','LG','Smart TV LG NanoCell 4K 75", UHD, Web Os',
3990,10,'tele6.png','1');
INSERT INTO Productos VALUES('PRO00016','CAT002','SAMSUNG','Televisor Samsung Hd 32'' Un32T4202Agxpe',
700,10,'tele7.png','1');
INSERT INTO Productos VALUES('PRO00017','CAT002','SAMSUNG','Smart TV Samsung 43" LED, Full HD',
1200,10,'tele8.png','1');
INSERT INTO Productos VALUES('PRO00018','CAT002','LG','Televisor 50" Lg Uhd 4k Thinq Ai 50ut7300psa',
1400,10,'tele9.png','1');


INSERT INTO Productos VALUES('PRO00019','CAT003','XIAOMI','Xiaomi Redmi A3 3+64GB Azul',
300,10,'cel1.png','1');
INSERT INTO Productos VALUES('PRO00020','CAT003','APPLE','iPhone 15 128GB, 6GB ram, negro',
3500,10,'cel2.png','1');
INSERT INTO Productos VALUES('PRO00021','CAT003','APPLE','Iphone 15 Pro Max 256gb',
6000,10,'cel21.png','1');
INSERT INTO Productos VALUES('PRO00022','CAT003','XIAOMI','Celular Xiaomi Redmi Note 13 Pro 8GB',
1190,10,'cel4.png','1');
INSERT INTO Productos VALUES('PRO00023','CAT003','SAMSUNG','Celular Samsung S24 Ultra 5G 512GB, negro',
5300,10,'cel5.png','1');
INSERT INTO Productos VALUES('PRO00024','CAT003','XIAOMI','Celular Xiaomi 12 256GB, 12GB ram, púrpura',
1900,10,'cel6.png','1');
INSERT INTO Productos VALUES('PRO00025','CAT003','APPLE','Celular Apple Iphone 13 128gb',
2700,10,'cel7.png','1');
INSERT INTO Productos VALUES('PRO00026','CAT003','MOTOROLA', 'Celular Motorola G84 256GB, 8GB ram',
900,10,'cel8.png','1');
INSERT INTO Productos VALUES('PRO00027','CAT003','SAMSUNG','Celular Samsung Galaxy A15 8GB RAM 256GB',
560,10,'cel9.png','1');

INSERT INTO Productos VALUES('PRO00028','CAT004','HUAWEI','Smartwatch HUAWEI Watch Fit Special Edition Negro',
190,10,'rel1.png','1');
INSERT INTO Productos VALUES('PRO00029','CAT004','HUAWEI','Smartwatch HUAWEI Watch Fit 3 Blanco',
500,10,'rel2.png','1');
INSERT INTO Productos VALUES('PRO00030','CAT004','HUAWEI','Smartwatch HUAWEI Watch Kids 4 Pro Azul',
400,10,'rel3.png','1');
INSERT INTO Productos VALUES('PRO00031','CAT004','HUAWEI','Smartwatch Huawei Watch GT 4 Blanco 41mm',
600,10,'rel4.png','1');
INSERT INTO Productos VALUES('PRO00032','CAT004','HUAWEI','Smartwatch HUAWEI Watch Fit Special, Rosado',
200,10,'rel5.png','1');
INSERT INTO Productos VALUES('PRO00033','CAT004','SAMSUNG','Watch4 40mm',
550,10,'rel6.png','1');
INSERT INTO Productos VALUES('PRO00034','CAT004','HUAWEI','Smartwatch Huawei Watch GT 4 Negro 46mm',
700,10,'rel7.png','1');
INSERT INTO Productos VALUES('PRO00035','CAT004','APPLE','Apple Watch Series 9 41mm',
2200,10,'rel8.png','1');
INSERT INTO Productos VALUES('PRO00036','CAT004','APPLE','Apple watch Serie SE Gps 44mm',
1200,10,'rel9.png','1');

INSERT INTO Productos VALUES('PRO00037','CAT005','ACER','LAPTOP GAMER ACER NITRO 5 15.6" INTEL CORE i5 12450H RTX3050',
4000,10,'lap1.png','1');
INSERT INTO Productos VALUES('PRO00038','CAT005','ACER','Laptop Acer 15.6" Core i5 14VA Windows 11 8GB',
1900,10,'lap2.png','1');
INSERT INTO Productos VALUES('PRO00039','CAT005','HP','Laptop Hp Ryzen R7-5700u 12GB RAM 512GB Win 11',
2400,10,'lap3.png','1');
INSERT INTO Productos VALUES('PRO00040','CAT005','LENOVO','Laptop Lenovo Ideapad 1 AMD Ryzen 7 5700U 16GB RAM',
2100,10,'lap4.png','1');
INSERT INTO Productos VALUES('PRO00041','CAT005','ACER','LAPTOP ACER 15.6" TACTIL RYZEN 5 8GB 512GB',
2000,10,'lap5.png','1');
INSERT INTO Productos VALUES('PRO00042','CAT005','APPLE','MacBook Air 13.6" 256GB - Chip M2 - Blanco Estelar',
5000,10,'lap6.png','1');
INSERT INTO Productos VALUES('PRO00043','CAT005','LENOVO','Laptop Lenovo Ideapad Slim 3i Intel Core i5 12va Gen',
1900,10,'lap7.png','1');
INSERT INTO Productos VALUES('PRO00044','CAT005','HP','Gamer Hp Amd Ryzen 7 Rtx 3050 16gb 512gb Ssd Victus 15.6',
3100,10,'lap8.png','1');
INSERT INTO Productos VALUES('PRO00045','CAT005','ASUS','Gamer Asus TUF Gaming  F15 15.6" i5 12va Gen 8GB 512GB RTX3050',
3000,10,'lap9.png','1');

INSERT INTO Productos VALUES('PRO00046','CAT006','SAMSUNG','Galaxy Tab S6 Lite 2024 4+128 10.4" Graphite',
899,10,'ta1.png','1');
INSERT INTO Productos VALUES('PRO00047','CAT006','LENOVO','Tablet Lenovo Xiaoxin Pad Pro- 8GB ROM OLED 120Hz',
1399,10,'ta2.png','1');
INSERT INTO Productos VALUES('PRO00048','CAT006','APPLE','Apple iPad Air 11 Chip M2 Wifi 2024 128GB - Starlight',
2000,10,'ta3.png','1');
INSERT INTO Productos VALUES('PRO00049','CAT006','SAMSUNG','Tablet Samsung Galaxy Tab S9, lila + Lápiz',
2299,10,'ta4.png','1');
INSERT INTO Productos VALUES('PRO00050','CAT006','APPLE','iPad Pro 12.9 6ta Generación con Chip M2 - 128GB - Gris Espacial',
3659,10,'ta5.png','1');
INSERT INTO Productos VALUES('PRO00051','CAT006','APPLE','iPad 10th generacion - 128GB - Amarillo',
1200,10,'ta6.png','1');
INSERT INTO Productos VALUES('PRO00052','CAT006','SAMSUNG','Samsung Galaxy Tab S9 256GB 11',
2500,10,'ta7.png','1');
INSERT INTO Productos VALUES('PRO00053','CAT006','SAMSUNG','Tablet Samsung Galaxy Tab A9 Plus SM-X210N 11 WUXGA 4GB 64B WiFi Gris',
700,10,'ta8.png','1');
INSERT INTO Productos VALUES('PRO00054','CAT006','LENOVO','Tablet Lenovo TAB M9 4GB 64GB HD WIFI',
600,10,'ta9.png','1');

INSERT INTO Productos VALUES('PRO00055','CAT007','BOWMANN','Autoradio Bowmann DD-5800L 50W x 4, control remoto',
209,10,'auto1.png','1');
INSERT INTO Productos VALUES('PRO00056','CAT007','PIONEER','Autoradio Pioneer DMH-Z6350BT, Bluetooth, USB, Negro',
3000,10,'auto2.png','1');
INSERT INTO Productos VALUES('PRO00057','CAT007','X BASS','Autoradio X Bass 9" Android, doble cámara 2GB, 32GB ram, negro',
640,10,'auto3.png','1');
INSERT INTO Productos VALUES('PRO00058','CAT007','PIONEER','Autoradio Pioneer SPH-C10BT panel desmontable, usb, bluetooth, negro',
530,10,'auto4.png','1');
INSERT INTO Productos VALUES('PRO00059','CAT007','BEATFAM','Autoradio Android 9" Pulgadas Carplay/ Android Auto Con Camara De Regalo',
490,10,'auto5.png','1');
INSERT INTO Productos VALUES('PRO00060','CAT007','KENWOOD','Autorradio Kenwood DMX-5020s, radio, Usb, Aux, Mirrorring, bluetooth, negro',
1000,10,'auto6.png','1');
INSERT INTO Productos VALUES('PRO00061','CAT007','AIWA','Autoradio Android 2 Din Slim HD 7" HD 4GB RAM + 64GB AIWA AW-A789BT',
700,10,'auto7.png','1');
INSERT INTO Productos VALUES('PRO00062','CAT007','BEATFAM','Autoradio Android 1 Din 9" Pulgadas 2GB 32GB Con Camara de Regalo',
500,10,'auto8.png','1');
INSERT INTO Productos VALUES('PRO00063','CAT007','PIONEER','Autoradio Pioneer AVH-Z5250BT, Pantalla 6.8", Bluetooth, DVD, CD, USB, Negro',
2100,10,'auto9.png','1');

-- Insertar usuarios con el campo tipoUsuario - CLIENTES
INSERT INTO Usuarios (Nombres, Apellidos, Direccion, FechaNacimiento, Sexo, Correo, Password, tipoUsuario)
VALUES ('JUAN CARLOS', 'RIVERA RIOS', 'AV.LIMA 1234-CERCADO', '1990-05-01', 'M', 'jrivera@gmail.com', '1234', 'USER');
INSERT INTO Usuarios (Nombres, Apellidos, Direccion, FechaNacimiento, Sexo, Correo, Password, tipoUsuario)
VALUES ('CLAUDIA', 'TORRES DURAN', 'AV.PRIMAVERA 1234-SURCO', '1991-07-11', 'F', 'ctorres@gmail.com', '1234', 'USER');
INSERT INTO Usuarios (Nombres, Apellidos, Direccion, FechaNacimiento, Sexo, Correo, Password, tipoUsuario)
VALUES ('WALTER ISMAEL', 'VILLAR RAMOS', 'AV.ARENALES 1525-LINCE', '1989-12-01', 'M', 'wvillar@gmail.com', '1234', 'USER');
INSERT INTO Usuarios (Nombres, Apellidos, Direccion, FechaNacimiento, Sexo, Correo, Password, tipoUsuario)
VALUES ('WALTER ISMAEL', 'VILLAR RAMOS', 'AV.ARENALES 1525-LINCE', '1989-12-01', 'M', 'mirellayurikomatsuoespinoza@gmail.com', '1234', 'USER');
-- Insertar usuarios con el campo tipoUsuario - ADMINISTRADORES
INSERT INTO Usuarios (Nombres, Apellidos, Direccion, FechaNacimiento, Sexo, Correo, Password, tipoUsuario)
VALUES ('RINCON RODRIGUEZ', 'ALONSO', 'AV.PRUEBA 2', '1990-01-01', 'M', 'admin1@gmail.com', '12345', 'ADMIN');


-- PROCEDIMIENTOS ALMACENADOS
-- Store Procedure : RegistrarUsuario
DROP PROCEDURE IF EXISTS RegistrarUsuario;
DELIMITER @@
CREATE PROCEDURE RegistrarUsuario(
    IN p_Nombres VARCHAR(50),
    IN p_Apellidos VARCHAR(50),
    IN p_Direccion VARCHAR(50),
    IN p_FechaNacimiento DATE,
    IN p_Sexo CHAR(1),
    IN p_Correo VARCHAR(50),
    IN p_Password VARCHAR(50)
)
BEGIN
    INSERT INTO Usuarios (Nombres, Apellidos, Direccion, FechaNacimiento, Sexo, Correo, Password)
    VALUES (p_Nombres, p_Apellidos, p_Direccion, p_FechaNacimiento, p_Sexo, p_Correo, p_Password);
END @@
DELIMITER ;
 
 ALTER TABLE Productos MODIFY PrecioUnidad DECIMAL(10, 2); 
-- Store Procedure : ListarUsuarios
DROP PROCEDURE IF EXISTS ListarUsuarios;
DELIMITER @@
CREATE PROCEDURE ListarUsuarios()
BEGIN
    -- Selecciona solo los usuarios que son clientes
    SELECT * FROM Usuarios WHERE tipoUsuario = 'USER';
END @@
DELIMITER ;

CALL ListarUsuarios();

-- Store Procedure : InfoUsuario
DROP PROCEDURE IF EXISTS InfoUsuario;
DELIMITER @@
CREATE PROCEDURE InfoUsuario(IdUsu INT)
BEGIN
    SELECT * FROM Usuarios
    WHERE IdUsuario = IdUsu;
END @@
DELIMITER ;

CALL InfoUsuario('1');
CALL InfoUsuario('3');

-- Store Procedure : EliminarUsuario
DROP PROCEDURE IF EXISTS EliminarUsuario;
DELIMITER @@
CREATE PROCEDURE EliminarUsuario(IN p_IdUsuario INT)
BEGIN
    DELETE FROM Usuarios WHERE IdUsuario = p_IdUsuario;
END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS ActualizarUsuario;
DELIMITER @@
CREATE PROCEDURE ActualizarUsuario(
    IN p_IdUsuario INT,
    IN p_Nombres VARCHAR(50),
    IN p_Apellidos VARCHAR(50),
    IN p_Direccion VARCHAR(50),
    IN p_FechaNacimiento DATE,
    IN p_Sexo CHAR(1),
    IN p_Correo VARCHAR(50)
)
BEGIN
    -- Verifica si el usuario existe antes de intentar actualizar
    IF EXISTS (SELECT 1 FROM Usuarios WHERE IdUsuario = p_IdUsuario) THEN
        -- Actualiza la información del usuario
        UPDATE Usuarios
        SET
            Nombres = p_Nombres,
            Apellidos = p_Apellidos,
            Direccion = p_Direccion,
            FechaNacimiento = p_FechaNacimiento,
            Sexo = p_Sexo,
            Correo = p_Correo
        WHERE IdUsuario = p_IdUsuario;

        -- Mensaje de éxito
        SELECT 'Usuario actualizado exitosamente.' AS Mensaje;
    ELSE
        -- Mensaje de error si el usuario no existe
        SELECT 'Error: El usuario con el IdUsuario especificado no existe.' AS Mensaje;
    END IF;
END @@
DELIMITER ;

-- Store Procedure : ListarUsuarios
DROP PROCEDURE IF EXISTS ListarVentas;
DELIMITER @@
CREATE PROCEDURE ListarVentas()
BEGIN
    SELECT * FROM Ventas;
END @@
DELIMITER ;


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

-- Store Procedure : InsertaVenta
DROP PROCEDURE IF EXISTS InsertaVenta;
DELIMITER @@
CREATE PROCEDURE InsertaVenta(
    IdVenta CHAR(10),
    IdCliente CHAR(8),
    IdMetodoPago INT,
    FechaVenta DATE,
    MontoTotal DECIMAL,
    Estado CHAR(1)
)
BEGIN
    INSERT INTO Ventas VALUES(IdVenta,IdCliente,IdMetodoPago,FechaVenta,MontoTotal,Estado);
END @@
DELIMITER ;

-- Store Procedure : InsertaDetalle
DROP PROCEDURE IF EXISTS InsertaDetalle;
DELIMITER @@
CREATE PROCEDURE InsertaDetalle(
    IdDetalle CHAR(10),
    IdVenta CHAR(10),
    IdProducto CHAR(8),
    Cantidad INT,
    PrecioUnidad DECIMAL
)
BEGIN
    INSERT INTO Detalle VALUES(IdDetalle, IdVenta,IdProducto,Cantidad,PrecioUnidad);
END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS RegistrarMetodoPago;
DELIMITER @@
CREATE PROCEDURE RegistrarMetodoPago(
    IN p_TipoPago VARCHAR(50),
    IN p_Nombre VARCHAR(50),
    IN p_Numero CHAR(16),
    IN p_Expiracion VARCHAR(10),
    IN p_Codigo CHAR(3)
)
BEGIN
     -- Lógica para registrar el método de pago en la base de datos
    INSERT INTO MetodoPago (tipopago, nombre, numero, expiracion, codigo)
    VALUES (p_TipoPago, p_Nombre, p_Numero, p_Expiracion, p_Codigo);
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


-- Procedimiento almacenado para actualizar el stock del admin
DROP PROCEDURE IF EXISTS ActualizarStockAdmin;
DELIMITER @@
CREATE PROCEDURE ActualizarStockAdmin(
    IN p_IdProducto CHAR(8),
    IN p_NuevoStock INT
)
BEGIN
    -- Actualizar directamente el stock del producto
    UPDATE Productos
    SET Stock = p_NuevoStock
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

-- Store Procedure : BuscarProductoPorMarca
DROP PROCEDURE IF EXISTS BuscarProductoPorDescripcion;
DELIMITER @@
CREATE PROCEDURE BuscarProductoPorDescripcion(IN descripcionBusqueda VARCHAR(150))
BEGIN
    SELECT * 
    FROM Productos
    WHERE Descripcion LIKE CONCAT('%', descripcionBusqueda, '%');
END @@
CALL BuscarProductoPorDescripcion('Samsung');
CALL BuscarProductoPorDescripcion('Celular Xiaomi Redmi Note 13 Pro 8GB');

 
-- Store Procedure : BuscarPorMarca
DROP PROCEDURE IF EXISTS BuscarProductoPorMarca;
DELIMITER @@
CREATE PROCEDURE BuscarProductoPorMarca(IN marcaBusqueda VARCHAR(100))
BEGIN
    SELECT * 
    FROM Productos
    WHERE Marca LIKE CONCAT('%', marcaBusqueda, '%');
END  @@
CALL BuscarProductoPorMarca('APPLE');

DELIMITER //

DELIMITER @@
CREATE PROCEDURE DetalleVenta(
    IN p_IdVenta CHAR(10)
)
BEGIN
    SELECT 
        d.IdDetalle,
        d.IdVenta,
        d.IdProducto,
        p.Marca,
        p.Descripcion,
        d.Cantidad,
        d.PrecioUnidad,
        (d.Cantidad * d.PrecioUnidad) AS SubTotal,
        v.FechaVenta,
        v.MontoTotal,
        v.Estado AS EstadoVenta,
        u.Nombres AS NombreCliente,
        u.Apellidos AS ApellidoCliente
    FROM 
        Detalle d
    JOIN 
        Productos p ON d.IdProducto = p.IdProducto
    JOIN 
        Ventas v ON d.IdVenta = v.IdVenta
    JOIN 
        Usuarios u ON v.IdCliente = u.IdUsuario
    WHERE 
        d.IdVenta = p_IdVenta;
END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS ObtenerCategoriaPorId;
DELIMITER @@
CREATE PROCEDURE ObtenerCategoriaPorId(
    IN p_IdCategoria CHAR(6)
)
BEGIN
    SELECT * 
    FROM Categorias 
    WHERE IdCategoria = p_IdCategoria;
END @@
DELIMITER ;

-- Procedimientos Almacenados que Faltan (MySQL)

DROP PROCEDURE IF EXISTS registrarProducto;
DELIMITER @@
CREATE PROCEDURE registrarProducto(
    OUT p_idProducto CHAR(8),         -- Parámtero de salida para el ID generado
    IN p_idCategoria CHAR(6),
    IN p_marca VARCHAR(100),
    IN p_descripcion VARCHAR(150),
    IN p_precioUnidad DECIMAL(10,2),
    IN p_stock INT,
    IN p_imagen VARCHAR(50),
    IN p_estado CHAR(1)
)
BEGIN
    DECLARE nuevoIdProducto CHAR(8);

    -- Llamar al procedimiento para generar el nuevo ID
    CALL obtenerSiguienteIdProducto(nuevoIdProducto);

    -- Pasar el nuevo ID generado al parámetro de salida
    SET p_idProducto = nuevoIdProducto;

    -- Insertar el nuevo producto con el ID generado
    INSERT INTO Productos (IdProducto, IdCategoria, Marca, Descripcion, PrecioUnidad, Stock, Imagen, Estado)
    VALUES (nuevoIdProducto, p_idCategoria, p_marca, p_descripcion, p_precioUnidad, p_stock, p_imagen, p_estado);
END @@
DELIMITER ;


-- Store Procedure: actualizarProducto
DROP PROCEDURE IF EXISTS actualizarProducto;
DELIMITER @@
CREATE PROCEDURE actualizarProducto(
    IN p_idProducto CHAR(8),
    IN p_idCategoria CHAR(6),
    IN p_marca VARCHAR(100),
    IN p_descripcion VARCHAR(150),
    IN p_precioUnidad DECIMAL(10,2),
    IN p_stock INT,
    IN p_imagen VARCHAR(50),
    IN p_estado CHAR(1)
)
BEGIN
    UPDATE Productos
    SET 
        IdCategoria = p_idCategoria,
        Marca = p_marca,
        Descripcion = p_descripcion,
        PrecioUnidad = p_precioUnidad,
        Stock = p_stock,
        Imagen = p_imagen,
        Estado = p_estado
    WHERE IdProducto = p_idProducto;
END @@
DELIMITER ;


-- Store Procedure: eliminarProducto
DROP PROCEDURE IF EXISTS eliminarProducto;
DELIMITER @@
CREATE PROCEDURE eliminarProducto(
    IN p_idProducto CHAR(8)
)
BEGIN
    DELETE FROM Productos WHERE IdProducto = p_idProducto;
END @@
DELIMITER ;

-- Store Procedure: buscarProducto
DROP PROCEDURE IF EXISTS buscarProducto;
DELIMITER @@
CREATE PROCEDURE buscarProducto(
    IN p_busqueda VARCHAR(150)
)
BEGIN
    SELECT * FROM Productos
    WHERE IdProducto = p_busqueda
       OR Descripcion LIKE CONCAT('%', p_busqueda, '%');
END @@
DELIMITER ;

-- ---------------------------------------------------------------------------------

-- Store Procedure: registrarCategoria
DROP PROCEDURE IF EXISTS registrarCategoria;
DELIMITER @@

CREATE PROCEDURE registrarCategoria(
    OUT p_idCategoria CHAR(8),
    IN p_descripcion VARCHAR(50),
    IN p_imagen VARCHAR(50),
    IN p_estado CHAR(1)
)
BEGIN
    DECLARE nuevoIdCategoria CHAR(8);

    -- Llamar al procedimiento para generar el nuevo ID
    CALL obtenerSiguienteIdCategoria(nuevoIdCategoria);

    -- Pasar el nuevo ID generado al parámetro de salida
    SET p_idCategoria = nuevoIdCategoria;

    -- Insertar la nueva categoría con el ID generado
    INSERT INTO Categorias (IdCategoria, Descripcion, Imagen, Estado)
    VALUES (nuevoIdCategoria, p_descripcion, p_imagen, p_estado);

END @@
DELIMITER ;

-- Store Procedure: actualizarCategoria
DROP PROCEDURE IF EXISTS actualizarCategoria;
DELIMITER @@
CREATE PROCEDURE actualizarCategoria(
    IN p_idCategoria VARCHAR(10),
    IN p_descripcion VARCHAR(50),
    IN p_imagen VARCHAR(50),
    IN p_estado CHAR(1)
)
BEGIN
    UPDATE Categorias  -- Usar la tabla correcta 'Categorias'
    SET Descripcion = p_descripcion,
        Imagen = p_imagen,
        Estado = p_estado
    WHERE IdCategoria = p_idCategoria;  -- Usar el nombre correcto del campo 'IdCategoria'
END @@
DELIMITER ;


-- Store Procedure: eliminarCategoria
DROP PROCEDURE IF EXISTS eliminarCategoria;
DELIMITER @@
CREATE PROCEDURE eliminarCategoria(
    IN p_idCategoria VARCHAR(10)
)
BEGIN
    DELETE FROM Categorias  -- Usar la tabla correcta 'Categorias'
    WHERE IdCategoria = p_idCategoria;  -- Usar el nombre correcto del campo 'IdCategoria'
END @@
DELIMITER ;

-- -----------------------------------------------------------------
DROP PROCEDURE IF EXISTS obtenerSiguienteIdCategoria;
DELIMITER @@
CREATE PROCEDURE obtenerSiguienteIdCategoria(OUT sigId CHAR(8))
BEGIN
    DECLARE ultimoId CHAR(8);
    DECLARE num INT;

    -- Obtener el último ID registrado
    SELECT IdCategoria INTO ultimoId
    FROM Categorias
    ORDER BY IdCategoria DESC
    LIMIT 1;

    -- Extraer el número y aumentar en 1
    SET num = CAST(SUBSTRING(ultimoId, 4) AS UNSIGNED) + 1;

    SET sigId = CONCAT('CAT', LPAD(num, 3, '0'));
END @@
DELIMITER ;
-- -----------------------------------------------------------------


DROP PROCEDURE IF EXISTS obtenerSiguienteIdProducto;
DELIMITER @@
CREATE PROCEDURE obtenerSiguienteIdProducto(OUT siguienteId CHAR(8))
BEGIN
    DECLARE ultimoId CHAR(8);
    DECLARE numero INT;

    -- Obtener el último ID registrado
    SELECT IdProducto INTO ultimoId
    FROM Productos
    ORDER BY IdProducto DESC
    LIMIT 1;

    -- Extraer el número y aumentar en 1
    SET numero = CAST(SUBSTRING(ultimoId, 4) AS UNSIGNED) + 1;

    -- Generar el nuevo ID con formato 'PRO' + número ajustado a 5 dígitos
    SET siguienteId = CONCAT('PRO', LPAD(numero, 5, '0'));
END @@
DELIMITER ;

DELIMITER //

CREATE TRIGGER BeforeInsertMetodoPago
BEFORE INSERT ON MetodoPago
FOR EACH ROW
BEGIN
    SET NEW.Numero = CONCAT(LEFT(NEW.Numero, 1), REPEAT('*', LENGTH(NEW.Numero) - 1));
END;
//

DELIMITER  ;


DELIMITER $$
CREATE PROCEDURE CambiarEstadoCliente(
    IN correoUsuario VARCHAR(50),
    IN nuevoEstado CHAR(1)
)
BEGIN
    UPDATE Usuarios 
    SET Estado = nuevoEstado 
    WHERE Correo = correoUsuario;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ObtenerIdUsuarioPorCorreo;
DELIMITER @@
CREATE PROCEDURE ObtenerIdUsuarioPorCorreo(
    IN p_Correo VARCHAR(50),
    OUT p_IdUsuario INT
)
BEGIN
    SELECT IdUsuario INTO p_IdUsuario
    FROM Usuarios
    WHERE Correo = p_Correo;
END @@
DELIMITER ;
-- -----------------------------------------------------------------

SELECT * FROM Categorias;
SELECT * FROM Productos;
SELECT * FROM Usuarios;
SELECT * FROM Ventas;
SELECT * FROM Detalle;    
SELECT * FROM MetodoPago;
