REM   Script: vistas
REM   vistas

CREATE VIEW Vista_Pacientes AS 
SELECT p.Cedula, p.Num_seguroSocial, p.NUM_historialClinico, p.NAME, p.LAST_NAME, p.Domicilio, p.Telefono, e.Examenes_realizados, s.Tipo_cobertura  
FROM Paciente p  
LEFT JOIN Expediente e ON p.NUM_historialClinico = e.NUM_historialClinico  
LEFT JOIN Seguro s ON p.Num_seguroSocial = s.Num_seguroSocial;

CREATE VIEW Vista_Pacientes_Doctor AS 
SELECT p.Cedula, p.NAME, p.LAST_NAME, d.NAME AS Nombre_Doctor, d.LAST_NAME AS Apellido_Doctor  
FROM Paciente p  
LEFT JOIN Factura f ON p.Cedula = f.Cedula  
LEFT JOIN Doctor d ON f.ID_medico = d.ID_medico;

CREATE VIEW Vista_Enfermeros_Pacientes AS 
SELECT e.ID_enfermero, e.NAME, e.LAST_NAME, p.NAME AS Nombre_Paciente, p.LAST_NAME AS Apellido_Paciente  
FROM Enfermero e  
LEFT JOIN Habitacion h ON e.ID_enfermero = h.ID_enfermero  
LEFT JOIN Paciente p ON h.Cedula = p.Cedula;

CREATE VIEW Vista_Pacientes_Factura AS 
SELECT p.Cedula, p.NAME, p.LAST_NAME, f.Fecha_ingreso, f.Fecha_Salida, f.QTY_dias, s.Cargo_Alimentacion, s.Cargo_AtencionMedica, s.Cargo_Habitacion, s.Cargo_Rehabilitacion  
FROM Paciente p  
LEFT JOIN Factura f ON p.Cedula = f.Cedula  
LEFT JOIN Servicios s ON p.Cedula = s.Cedula;

CREATE VIEW Vista_Doctor_Pacientes AS 
SELECT d.ID_medico, d.NAME, d.LAST_NAME, p.NAME AS Nombre_Paciente, p.LAST_NAME AS Apellido_Paciente  
FROM Doctor d  
LEFT JOIN Factura f ON d.ID_medico = f.ID_medico  
LEFT JOIN Paciente p ON f.Cedula = p.Cedula;

CREATE VIEW Vista_Pacientes_Sin_Seguro AS 
SELECT p.Cedula, p.NAME, p.LAST_NAME  
FROM Paciente p  
LEFT JOIN Seguro s ON p.Num_seguroSocial = s.Num_seguroSocial  
WHERE s.Cedula IS NULL;

CREATE VIEW Vista_Habitaciones_Disponibles AS 
SELECT h.Num_Habitacion, h.Num_piso, h.Num_cama  
FROM Habitacion h  
LEFT JOIN Paciente p ON h.Cedula = p.Cedula  
WHERE p.Cedula IS NULL;

CREATE VIEW Vista_Pacientes_Habitaciones AS 
SELECT p.NAME, p.LAST_NAME, h.Num_Habitacion, h.Num_piso, h.Num_cama  
FROM Paciente p  
LEFT JOIN Habitacion h ON p.Cedula = h.Cedula;

CREATE VIEW Vista_Enfermeros AS 
SELECT ID_enfermero, NAME, LAST_NAME 
FROM Enfermero;

CREATE VIEW Doctor_View AS 
SELECT ID_medico, NAME, LAST_NAME, Especialidad 
FROM Doctor;

