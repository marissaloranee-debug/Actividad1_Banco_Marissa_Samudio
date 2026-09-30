-- Creación de la base de datos de la actividad 1

CREATE DATABASE Actividad1_Banco;

use Actividad1_Banco;

/*
Creación de las tablas
1. Tabla Sucursal
*/

CREATE TABLE Sucursal(
             nombre_sucursal varchar(50),
             localidad varchar(50),
             activos decimal(10,2) Default 0,
             CONSTRAINT PK_SUCURSAL PRIMARY KEY (nombre_sucursal)
);

--2. Tabla Empleado
CREATE TABLE Empleado(
             ID_Empleado int not null identity(1,1),
             nombre varchar(50) not null,
             telefono char(12),
             fecha_contratacion date not null,
             id_jefe int null,
             CONSTRAINT PK_Empleado PRIMARY KEY (ID_Empleado),
             CONSTRAINT FK_Empleado_Jefe
             FOREIGN KEY (id_jefe) references Empleado(ID_Empleado)
);
--3. Tabla Cliente
CREATE TABLE CLIENTE(
             ID_Cliente int not null identity(1,1),
             nombre varchar(50) not null,
             calle varchar(40),
             ciudad varchar(20),
             ID_Empleado int,
             CONSTRAINT PK_Cliente Primary Key (ID_Cliente),
             CONSTRAINT FK_Asesor
             FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado)
);
--4. Tabla Cuenta
CREATE TABLE Cuenta(
             Num_Cuenta BIGINT IDENTITY(1000000001,1) NOT NULL,
             saldo DECIMAL(15,2) NOT NULL,
             CONSTRAINT PK_Cuenta
             PRIMARY KEY (Num_Cuenta)
);

--5. Tabla Cliente-Cuenta
CREATE TABLE Cliente_Cuenta(
              Num_cuenta BIGINT not null,
              ID_Cliente int not null,
              Ultima_fecha_acceso datetime,
              CONSTRAINT PK_Cliente_Cuenta
              PRIMARY KEY (ID_Cliente, Num_Cuenta),
              CONSTRAINT FK_Cliente_Cuenta_Cliente
              FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
              CONSTRAINT FK_Cliente_Cuenta_Cuenta
              FOREIGN KEY (Num_Cuenta) REFERENCES Cuenta(Num_Cuenta)
);

--6. Tabla Cuenta ahorro
CREATE TABLE CUENTA_AHORRO(
             Num_Cuenta BIGINT not null,
             tasa_interes decimal(4,1) not null,
             CONSTRAINT PK_C_AHORRO PRIMARY KEY (Num_cuenta),
             constraint fk_AHORRO FOREIGN KEY (Num_cuenta) REFERENCES Cuenta(Num_cuenta)
             ON DELETE CASCADE
);

--7. Tabla Cuenta Corriente
CREATE TABLE CUENTA_CORRIENTE(
             Num_Cuenta BIGINT not null,
             Descubierto decimal(12,1) not null DEFAULT 0,
             CONSTRAINT PK_C_CORRIENTE PRIMARY KEY (Num_cuenta),
             constraint fk_CORRIENTE FOREIGN KEY (Num_cuenta) REFERENCES Cuenta(Num_cuenta)
             ON DELETE CASCADE
);

--8. Tabla Prestamo
CREATE TABLE Prestamo(
             ID_Prestamo BIGINT IDENTITY(1000000001,1) NOT NULL,
             nombre_sucursal VARCHAR(50) not null,
             importe DECIMAL(15,2) NOT NULL,
             CONSTRAINT PK_Prestamo PRIMARY KEY (ID_Prestamo)
             CONSTRAINT FK_Prestamo_Sucursal FOREIGN KEY (nombre_sucursal) REFERENCES Sucursal(Nombre_Sucursal)
);

--9. Tabla Prestamo_Cliente
CREATE TABLE Prestamo_Cliente(
             ID_Cliente int not null,
             ID_Prestamo Bigint not null,
             CONSTRAINT PK_Prestamo_Cliente PRIMARY KEY (ID_Cliente,ID_Prestamo),
             CONSTRAINT FK_Cliente_Prestamo FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
             CONSTRAINT FK_P_Prestamo FOREIGN KEY (ID_Prestamo) REFERENCES Prestamo(ID_Prestamo),
);

--10.Tabla Pago
CREATE TABLE Pago(
       ID_Prestamo BIGINT NOT NULL,
       Num_Pago int not null,
       importe DECIMAL(15,2) NOT NULL,
       fecha_pago date not null,
       CONSTRAINT PK_PAGO PRIMARY KEY (ID_Prestamo, Num_pago),
       CONSTRAINT FK_PAGO_PRESTAMO FOREIGN KEY (id_prestamo) REFERENCES PRESTAMO(id_prestamo)
        ON DELETE CASCADE
);


--- 11.Tabla Persona depediente del empleado
CREATE TABLE Persona_Dependiente(
             ID_Empleado int not null,
             nombre_dependiente varchar(50) not null,
             CONSTRAINT PK_Dependiente PRIMARY KEY (ID_Empleado, nombre_dependiente),
             CONSTRAINT FK_Persona_dependiente FOREIGN KEY (ID_Empleado) REFERENCES Empleado (ID_Empleado)
             ON DELETE CASCADE
  );

  --INSERTANDO DATOS

 -- 1.Datos de la Tabla Sucursal

 INSERT INTO Sucursal (nombre_sucursal, localidad, activos) VALUES
('Sucursal Sede Central', 'Ciudad de Panamá', 2500000.00),
('Sucursal Sabanitas', 'Colón', 1850000.00),
('Sucursal La Mitra', 'La Chorrera', 1200000.00),
('Sucursal La 24 de Diciembre', 'Tocumen', 980000.00),
('Sucursal Chiriquí', 'David', 1450000.00),
('Sucursal Los Santos', 'Las Tablas', 250000.00),
('Sucursal Coclé', 'Penonomé', 250000.00);

Select * from Sucursal

-- 2. Datos de la Tabla Empleado

INSERT INTO Empleado (nombre, telefono, fecha_contratacion, id_jefe) VALUES 
('Carlos Mendoza', '6000-1001', '2011-03-10', NULL),
('Andrés Gómez', '6000-1003', '2013-01-15', 1),
('María Rodríguez', '6000-1004', '2020-05-22', 1),
('Laura Castillo', '6000-1002', '2005-07-18', NULL),
('José Herrera', '6000-1005', '2010-09-06', 2),
('Daniel Ríos', '6000-1007', '2023-06-12', 1),
('Crispino Ceballos', '6785-8951', '2011-06-12', 1),
('Sofía Torres', '6000-1006', '2016-11-08', 2),
('Enereida Sanchez', '6850-1026', '2018-12-01', 2);

Select * from empleado

-- 3. Datos de la Tabla Cliente

INSERT INTO Cliente
(nombre, calle, ciudad, ID_Empleado)
VALUES
('Ana Martínez', 'Calle 50', 'Ciudad de Panamá', 2),
('Luis Pérez', 'Avenida Central', 'Ciudad de Panamá', 4),
('María López', 'Calle 8', 'Colón', 7),
('Jorge Castillo', 'Calle Bolívar', 'Colón', 2),
('Sofía González', 'Calle Principal', 'La Chorrera', 3),
('Ricardo Sánchez', 'Avenida Las Américas', 'La Chorrera', 9),
('Elena Vargas', 'Calle 12', 'Tocumen', 3),
('Miguel Torres', 'Calle Los Pinos', 'Tocumen', 8),
('Carolina Díaz', 'Avenida Central', 'David', 5),
('Fernando Ruiz', 'Calle 4', 'David', 6),
('Danelis Almendra', 'Calle 6', 'Las Tablas', 9),
('Marianela Isaza', 'Calle las flores', 'Aguadulce', 8);

select * from cliente

--4. Datos de la Tabla Cuenta

INSERT INTO Cuenta (saldo)
VALUES
(2500.50),
(850.00),
(5200.75),
(1250.00),
(8900.00),
(450.25),
(3200.00),
(15750.80),
(675.40),
(4100.00),
(10000.00),
(15000000.00);

select * from cuenta
select * from cliente

--5. Datos de la Tabla Cliente_cuenta

INSERT INTO Cliente_Cuenta
(Num_Cuenta, ID_Cliente, Ultima_fecha_acceso)
VALUES
(1000000001, 1, '2026-09-20 09:15:00'),
(1000000002, 2, '2026-09-21 14:30:00'),
(1000000003, 3, '2026-09-22 10:45:00'),
(1000000003, 4, '2026-09-23 16:20:00'),
(1000000004, 5, '2026-09-19 08:10:00'),
(1000000005, 6, '2026-09-24 11:35:00'),
(1000000006, 7, '2026-09-18 13:50:00'),
(1000000007, 8, '2026-09-25 15:05:00'),
(1000000008, 9, '2026-09-24 09:40:00'),
(1000000009, 10, '2026-09-22 17:15:00'),
(1000000010, 1, '2026-09-25 10:25:00'),
(1000000011, 11, '2026-09-27 10:25:00'),
(1000000012, 12, '2026-09-25 09:25:00'),
(1000000012, 8, '2026-09-24 15:00:00');
select * from cliente_cuenta

-- 6. Datos de la Tabla Cuenta Ahorro
INSERT INTO CUENTA_AHORRO
(Num_Cuenta, tasa_interes)
VALUES
(1000000001, 2.5),
(1000000003, 3.0),
(1000000005, 3.5),
(1000000007, 2.8),
(1000000009, 4.0),
(1000000011, 2.8);
select * from cuenta_ahorro

-- 7. Datos de la Tabla Cuenta Corriente

INSERT INTO CUENTA_CORRIENTE
(Num_Cuenta, Descubierto)
VALUES
(1000000002, 0.0),
(1000000004, 150.0),
(1000000006, 0.0),
(1000000008, 500.0),
(1000000010, 75.5),
(1000000012, 500.00);

select * from cuenta_corriente

-- 8. Datos de la Tabla Prestamos


INSERT INTO Prestamo
(nombre_sucursal, importe)
VALUES
('Sucursal Sede Central', 15002331721.45),
('Sucursal Coclé', 85015334.00),
('Sucursal La 24 de Diciembre', 2501552.95),
('Sucursal La Mitra', 1200125.00),
('Sucursal Los Santos', 3000642.00),
('Sucursal Sabanitas', 75008540.00),
('Sucursal Chiriquí', 180520000.89);

select * from prestamo

--9. Datos de la Tabla Prestamo_Cliente
INSERT INTO Prestamo_Cliente
(ID_Cliente, ID_Prestamo)
VALUES
(1, 1000000001),
(2, 1000000002),
(3, 1000000003),
(4, 1000000003),
(5, 1000000004),
(6, 1000000005),
(7, 1000000005),
(8, 1000000006),
(9, 1000000007),
(10, 1000000007),
(12, 1000000006);

Select * from prestamo_cliente

-- 10. Datos de la Tabla Pago

INSERT INTO Pago
(ID_Prestamo, Num_Pago, importe, fecha_pago)
VALUES
(1000000001, 1, 750.00, '2026-01-15'),
(1000000001, 2, 750.00, '2026-02-15'),
(1000000001, 3, 750.00, '2026-03-15'),
(1000000002, 1, 500.00, '2026-02-10'),
(1000000002, 2, 500.00, '2026-03-10'),
(1000000003, 1, 1200.00, '2026-01-20'),
(1000000003, 2, 1200.00, '2026-02-20'),
(1000000003, 3, 1200.00, '2026-03-20'),
(1000000004, 1, 600.00, '2026-04-05'),
(1000000004, 2, 600.00, '2026-05-05'),
(1000000005, 1, 1500.00, '2026-01-12'),
(1000000005, 2, 1500.00, '2026-02-12'),
(1000000005, 3, 1500.00, '2026-03-12'),
(1000000006, 1, 400.00, '2026-05-18'),
(1000000006, 2, 400.00, '2026-06-18'),
(1000000007, 1, 9000.00, '2026-06-25');

Select * from pago


-- 11. Datos de la Tabla Persona_dependiente

INSERT INTO Persona_Dependiente
(ID_Empleado, nombre_dependiente)
VALUES
(1, 'Santiago Mendoza'),
(1, 'Valentina Mendoza'),
(3, 'Gabriela Gómez'),
(4, 'Mateo Rodríguez'),
(5, 'Daniela Herrera'),
(5, 'Lucas Herrera'),
(6, 'Isabella Torres'),
(8, 'Nicolás Ríos'),
(7, 'David Ceballos'),
(9, 'Omar Samudio'),
(7, 'Ezequiel Ceballos');

select * from Persona_Dependiente

--- CONSULTAS SQL

SELECT * FROM Sucursal;
SELECT * FROM Empleado;
SELECT * FROM Cliente;
SELECT * FROM Cuenta;
SELECT * FROM Cliente_Cuenta;
SELECT * FROM Cuenta_Ahorro;
SELECT * FROM Cuenta_Corriente;
SELECT * FROM Prestamo;
SELECT * FROM Prestamo_Cliente;
SELECT * FROM Pago;
SELECT * FROM Persona_Dependiente;

-- 1. Consulta para conocer los clientes y sus asesores bancarios

SELECT C.ID_Cliente, C.Nombre as Cliente, E.nombre as Asesor
From Empleado E
Inner join Cliente C on C.ID_empleado = E.ID_empleado;

-- 2. Consulta de las cuentas y los saldos de los diferentes clientes
SELECT C.ID_Cliente, C.Nombre as Cliente, CT.Num_Cuenta as Cuenta, CT.Saldo as Saldo
From Cliente C
INNER JOIN Cliente_Cuenta CC on CC.ID_Cliente = C.ID_CLIENTE 
INNER JOIN Cuenta CT on CT.Num_cuenta = CC.Num_cuenta

-- 3. Consulta sobre las cuentas de los clientes y el tipo de cuenta (Ahorros o corrientes)
SELECT C.ID_Cliente, C.Nombre as Cliente, CT.Num_cuenta, CA.Num_cuenta as Cuenta_Ahorros, CR.Num_Cuenta as Cuenta_Corriente
From Cliente C
INNER JOIN Cliente_cuenta CC on CC.ID_Cliente = C.ID_CLIENTE
INNER JOIN Cuenta CT on CT.Num_cuenta = CC.Num_cuenta
LEFT JOIN Cuenta_Ahorro CA
    ON CT.Num_Cuenta = CA.Num_Cuenta
LEFT JOIN Cuenta_Corriente CR
    ON CT.Num_Cuenta = CR.Num_Cuenta;

--4.Consulta para determinar la cantidad de cuentas por cliente
SELECT C.ID_Cliente, C.nombre, COUNT(CC.Num_Cuenta) AS cantidad_cuentas
FROM Cliente C
LEFT JOIN Cliente_Cuenta CC ON CC.ID_Cliente = C.ID_Cliente
GROUP BY C.ID_Cliente, C.nombre;

-- 5. Consulta sobre los Préstamos, quienes son los titulares, los importes de los prestámos y la sucursal que los concedió
SELECT p.id_prestamo  AS Prestamo, p.importe AS Importe,p.nombre_sucursal AS Sucursal, cl.nombre AS Titular
FROM PRESTAMO p
INNER JOIN Prestamo_cliente cp ON cp.id_prestamo = p.id_prestamo
INNER JOIN Cliente cl ON cl.id_cliente = cp.id_cliente
ORDER BY p.id_prestamo;

--6.Total de pagos realizados por préstamo
SELECT ID_Prestamo, COUNT(Num_Pago) AS cantidad_pagos, SUM(importe) AS total_pagado
FROM Pago
GROUP BY ID_Prestamo;

--7. Cantidad de préstamos por sucursal
SELECT S.nombre_sucursal, COUNT(P.ID_Prestamo) AS cantidad_prestamos
FROM Sucursal S
LEFT JOIN Prestamo P ON S.nombre_sucursal = P.nombre_sucursal
GROUP BY S.nombre_sucursal;

SELECT * FROM Empleado;
SELECT * FROM Persona_Dependiente;

-- 8. Consulta de los empleados y su respectivo Jefe
SELECT E.ID_Empleado, E.nombre AS Empleado, J.nombre AS Jefe
FROM Empleado E
LEFT JOIN Empleado J ON E.id_jefe = J.ID_Empleado;

-- 9. Consulta de los Dependientes de cada empleado
SELECT E.nombre AS Empleado,D.nombre_dependiente AS Dependiente
FROM Empleado E
INNER JOIN Persona_Dependiente D ON E.ID_Empleado = D.ID_Empleado
ORDER BY E.nombre;

-- 10. Consulta sobre los productos de los clientes en el banco (prestámos y cuentas)

SELECT C.ID_Cliente, C.nombre AS Cliente, CC.Num_Cuenta AS Cuenta, CU.saldo AS Saldo, PC.ID_Prestamo AS Prestamo,
P.importe AS Importe_Prestamo
FROM Cliente C
LEFT JOIN Cliente_Cuenta CC ON CC.ID_Cliente = C.ID_Cliente
LEFT JOIN Cuenta CU ON CU.Num_Cuenta = CC.Num_Cuenta
LEFT JOIN Prestamo_Cliente PC ON PC.ID_Cliente = C.ID_Cliente
LEFT JOIN Prestamo P ON P.ID_Prestamo = PC.ID_Prestamo
ORDER BY C.ID_Cliente;