REM   Script: CRUDdeProyecto
REM   CRUD

CREATE TABLE Paciente 
( 
Cedula NUMBER(3) NOT NULL, 
Num_seguroSocial NUMBER(3) NOT NULL, 
NUM_historialClinico NUMBER(3) NOT NULL, 
NAME VARCHAR(30) NOT NULL, 
LAST_NAME VARCHAR(30) NOT NULL, 
Domicilio VARCHAR(30) NOT NULL, 
Telefono NUMBER(3) NOT NULL, 
);

INSERT INTO Paciente (Cedula, Num_seguroSocial, NUM_historialClinico, NAME, LAST_NAME, Domicilio, Telefono) 
VALUES (001, 123, 456, 'Juan', 'Pérez', 'Calle 1 #123', 789);

SELECT * FROM Paciente;

SELECT * FROM Paciente WHERE Cedula = 001;

UPDATE Paciente 
SET Domicilio = 'Calle 2 #345', Telefono = 987 
WHERE Cedula = 001;

DELETE FROM Paciente WHERE Cedula = 001;

CREATE TABLE Doctor 
ID_medico NUMBER(3) NOT NULL, 
NAME VARCHAR(30) NOT NULL, 
LAST_NAME VARCHAR(30) NOT NULL, 
Especialidad VARCHAR(30) NOT NULL, 
 
---insertar 
INSERT INTO Doctor (ID_medico, NAME, LAST_NAME, Especialidad) 
VALUES (001, 'Pedro', 'López', 'Cardiología');

SELECT * FROM Doctor;

UPDATE Doctor 
SET Especialidad = 'Oncología' 
WHERE ID_medico = 001;

DELETE FROM Doctor WHERE ID_medico = 001;

CREATE TABLE Enfermero 
ID_enfermero NUMBER(3) NOT NULL, 
NAME VARCHAR(30) NOT NULL, 
LAST_NAME VARCHAR(30) NOT NULL, 
 
 
---insertar 
INSERT INTO Enfermero (ID_enfermero, NAME, LAST_NAME) 
VALUES (001, 'María', 'González');

SELECT * FROM Enfermero;

UPDATE Enfermero 
SET LAST_NAME = 'Pérez' 
WHERE ID_enfermero = 001;

DELETE FROM Enfermero WHERE ID_enfermero = 001;

CREATE TABLE Habitacion 
Cedula NUMBER(3) NOT NULL 
Num_Habitacion NUMBER(3) NOT NULL, 
Num_piso NUMBER(3) NOT NULL, 
Num_cama NUMBER(3) NOT NULL, 
 
---insertar 
INSERT INTO Habitacion (Cedula, Num_Habitacion, Num_piso, Num_cama) 
VALUES (001, 101, 1, 1);

SELECT * FROM Habitacion;

UPDATE Habitacion 
SET Num_piso = 2 
WHERE Num_Habitacion = 101;

DELETE FROM Habitacion WHERE Num_Habitacion = 101;

CREATE TABLE Factura 
Cedula NUMBER(3) NOT NULL 
NUM_historialClinico NUMBER(3) NOT NULL, 
Fecha_ingreso Date 
Fecha_Salida Date 
QTY_dias  
Num_cama NUMBER(3) NOT NULL, 
ID_medico NUMBER(3) NOT NULL, 
 
 
---insertar 
INSERT INTO Factura (Cedula, NUM_historialClinico, Fecha_ingreso, Fecha_Salida, QTY_dias, Num_cama, ID_medico) 
VALUES (001, 001, '01-01-2022', '05-01-2022', 4, 101, 001);

SELECT * FROM Factura;

UPDATE Factura 
SET Fecha_Salida = '06-01-2022', QTY_dias = 5 
WHERE Cedula = 001;

DELETE FROM Factura WHERE Cedula = 001;

CREATE TABLE Expediente 
Cedula NUMBER(3) NOT NULL 
NUM_historialClinico NUMBER(3) NOT NULL, 
Examenes_realizados VARCHAR(30) NOT NULL, 
Num_cama NUMBER 
 
 
---insertar 
INSERT INTO Expediente (Cedula, NUM_historialClinico, Examenes_realizados, Num_cama) 
VALUES (001, 001, 'Radiografía, análisis de sangre', 101);

SELECT * FROM Expediente WHERE Cedula = 001;

UPDATE Expediente 
SET Examenes_realizados = 'Radiografía, análisis de sangre, tomografía' 
WHERE Cedula = 001;

DELETE FROM Expediente WHERE Cedula = 001;

CREATE TABLE Seguro 
Cedula NUMBER(3) NOT NULL 
Num_seguroSocial NUMBER(3) NOT NULL, 
Tipo_cobertura VARCHAR(30) NOT NULL, 
 
 
---insertar 
INSERT INTO Seguro (Cedula, Num_seguroSocial, Tipo_cobertura) 
VALUES (001, 123, 'Cobertura completa');

SELECT * FROM Seguro;

UPDATE Seguro 
SET Tipo_cobertura = 'Cobertura parcial' 
WHERE Cedula = 001;

DELETE FROM Seguro WHERE Cedula = 001;

CREATE TABLE Servicios 
Cedula NUMBER(3) NOT NULL 
Cargo_AtencionMedica NUMBER(3) NOT NULL 
Cargo_Alimentacion NUMBER(3) NOT NULL, 
Cargo_Rehabilitacion NUMBER(3) NOT NULL, 
Cargo_Habitacion NUMBER(3) NOT NULL, 
 
---insertar 
INSERT INTO Servicios (Cedula, Cargo_AtencionMedica, Cargo_Alimentacion, Cargo_Rehabilitacion, Cargo_Habitacion) 
VALUES (001, 100, 50, 75, 200);

SELECT * FROM Servicios WHERE Cedula = 001;

UPDATE Servicios 
SET Cargo_Alimentacion = 60 
WHERE Cedula = 001;

DELETE FROM Servicios WHERE Cedula = 001;

