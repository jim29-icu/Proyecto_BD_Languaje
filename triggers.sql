REM   Script: triggers
REM   triggers

CREATE OR REPLACE TRIGGER actualizar_paciente_trigger 
AFTER UPDATE ON Paciente 
FOR EACH ROW 
BEGIN 
    UPDATE Paciente SET  
        NAME = :new.NAME,  
        LAST_NAME = :new.LAST_NAME,  
        Domicilio = :new.Domicilio,  
        Telefono = :new.Telefono 
    WHERE Cedula = :new.Cedula; 
END; 
/

CREATE OR REPLACE TRIGGER actualizar_doctor_trigger 
AFTER UPDATE ON Doctor 
FOR EACH ROW 
BEGIN 
    UPDATE Doctor SET  
        NAME = :new.NAME,  
        LAST_NAME = :new.LAST_NAME,  
        Especialidad = :new.Especialidad 
    WHERE ID_medico = :new.ID_medico; 
END; 
/

CREATE OR REPLACE TRIGGER actualizar_enfermero_trigger 
AFTER UPDATE ON Enfermero 
FOR EACH ROW 
BEGIN 
    UPDATE Enfermero SET  
        NAME = :new.NAME,  
        LAST_NAME = :new.LAST_NAME 
    WHERE ID_enfermero = :new.ID_enfermero; 
END; 
/

CREATE OR REPLACE TRIGGER actualizar_habitacion_trigger 
AFTER UPDATE ON Habitacion 
FOR EACH ROW 
BEGIN 
    UPDATE Habitacion SET  
        Cedula = :new.Cedula,  
        Num_piso = :new.Num_piso,  
        Num_cama = :new.Num_cama 
    WHERE Num_Habitacion = :new.Num_Habitacion; 
END; 
/

CREATE OR REPLACE TRIGGER actualizar_factura_trigger 
AFTER UPDATE ON Factura 
FOR EACH ROW 
BEGIN 
    UPDATE Factura SET  
        Cedula = :new.Cedula,  
        NUM_historialClinico = :new.NUM_historialClinico,  
        Fecha_ingreso = :new.Fecha_ingreso, 
        Fecha_Salida = :new.Fecha_Salida, 
        QTY_dias = :new.QTY_dias, 
        Num_cama = :new.Num_cama, 
        ID_medico = :new.ID_medico 
    WHERE Num_Habitacion = :new.Num_Habitacion; 
END; 
/

CREATE OR REPLACE TRIGGER actualizar_seguro_trigger 
AFTER UPDATE ON Seguro 
FOR EACH ROW 
BEGIN 
    UPDATE Seguro SET  
        Cedula = :new.Cedula,  
        Num_seguroSocial = :new.Num_seguroSocial,  
        Tipo_cobertura = :new.Tipo_cobertura 
    WHERE Cedula = :new.Cedula; 
END; 
/

CREATE OR REPLACE TRIGGER actualizar_servicios_trigger 
AFTER UPDATE ON Servicios 
FOR EACH ROW 
BEGIN 
    UPDATE Servicios SET  
        Cargo_AtencionMedica = :new.Cargo_AtencionMedica,  
        Cargo_Alimentacion = :new.Cargo_Alimentacion,  
        Cargo_Rehabilitacion = :new.Cargo_Rehabilitacion,  
        Cargo_Habitacion = :new.Cargo_Habitacion 
    WHERE Cedula = :new.Cedula; 
END; 
/

