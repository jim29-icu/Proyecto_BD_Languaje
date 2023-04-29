--------------------------------------------------------
--  DDL for Trigger CALCULAR_TOTAL_FACTURA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "CALCULAR_TOTAL_FACTURA" 
    AFTER
    update OF valoracion
    on consulta
    FOR EACH ROW    
DECLARE
    --PRAGMA AUTONOMOUS_TRANSACTION;
    costoCta number;
    impuesto number;
    total number;
BEGIN
    select costo
    into costoCta
    from servicio
    where id_servicio = :new.id_servicio;

    impuesto := costoCta * 0.13;
    total := costoCta + impuesto;

   insert into factura (id_consulta, impuestos, precio_total)
   values(:new.id_consulta, impuesto, total);
END;
--------------------------------------------------------
--  DDL for Trigger DESOCUPAR_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DESOCUPAR_DOCTOR" 
    AFTER
    UPDATE OF VALORACION
    ON consulta
    FOR EACH ROW    
DECLARE
BEGIN
   update doctor
   set ocupado = 0
   where id_doctor = :new.id_doctor;
END;
--------------------------------------------------------
--  DDL for Trigger DESOCUPAR_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DESOCUPAR_HABITACION" AFTER
    update OF fecha_salida
    on internado
    FOR EACH ROW    
DECLARE
BEGIN
   update habitacion
   set ocupada = 0
   where id_habitacion = :new.id_habitacion;
END;
--------------------------------------------------------
--  DDL for Trigger ELIMINA_INTERNADO_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "ELIMINA_INTERNADO_HABITACION" AFTER
    DELETE ON internado
    FOR EACH ROW    
DECLARE
BEGIN
   update habitacion
   set ocupada = 0
   where id_habitacion = :new.id_habitacion;
END;
--------------------------------------------------------
--  DDL for Trigger INICIO_SESION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "INICIO_SESION" 
  AFTER LOGON
  ON DATABASE
BEGIN
  INSERT INTO bitacora (usuario, fecha)
  VALUES (USER, SYSDATE);
END;

--------------------------------------------------------
--  DDL for Trigger OCUPAR_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "OCUPAR_DOCTOR" AFTER
    insert
    ON consulta
    FOR EACH ROW    
DECLARE
BEGIN
   update doctor
   set ocupado = 1
   where id_doctor = :new.id_doctor;
END;
--------------------------------------------------------
--  DDL for Trigger OCUPAR_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "OCUPAR_HABITACION" AFTER
    INSERT ON internado
    FOR EACH ROW    
DECLARE
BEGIN
   update habitacion
   set ocupada = 1
   where id_habitacion = :new.id_habitacion;
END;
--------------------------------------------------------
--  DDL for Trigger OCUPAR_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "OCUPAR_DOCTOR" AFTER
    insert
    ON consulta
    FOR EACH ROW    
DECLARE
BEGIN
   update doctor
   set ocupado = 1
   where id_doctor = :new.id_doctor;
END;
--------------------------------------------------------
--  DDL for Trigger CALCULAR_TOTAL_FACTURA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "CALCULAR_TOTAL_FACTURA" 
    AFTER
    update OF valoracion
    on consulta
    FOR EACH ROW    
DECLARE
    --PRAGMA AUTONOMOUS_TRANSACTION;
    costoCta number;
    impuesto number;
    total number;
BEGIN
    select costo
    into costoCta
    from servicio
    where id_servicio = :new.id_servicio;

    impuesto := costoCta * 0.13;
    total := costoCta + impuesto;

   insert into factura (id_consulta, impuestos, precio_total)
   values(:new.id_consulta, impuesto, total);
END;
--------------------------------------------------------
--  DDL for Trigger DESOCUPAR_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DESOCUPAR_DOCTOR" 
    AFTER
    UPDATE OF VALORACION
    ON consulta
    FOR EACH ROW    
DECLARE
BEGIN
   update doctor
   set ocupado = 0
   where id_doctor = :new.id_doctor;
END;
--------------------------------------------------------
--  DDL for Trigger OCUPAR_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "OCUPAR_HABITACION" AFTER
    INSERT ON internado
    FOR EACH ROW    
DECLARE
BEGIN
   update habitacion
   set ocupada = 1
   where id_habitacion = :new.id_habitacion;
END;
--------------------------------------------------------
--  DDL for Trigger DESOCUPAR_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DESOCUPAR_HABITACION" AFTER
    update OF fecha_salida
    on internado
    FOR EACH ROW    
DECLARE
BEGIN
   update habitacion
   set ocupada = 0
   where id_habitacion = :new.id_habitacion;
END;
--------------------------------------------------------
--  DDL for Trigger ELIMINA_INTERNADO_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "ELIMINA_INTERNADO_HABITACION" AFTER
    DELETE ON internado
    FOR EACH ROW    
DECLARE
BEGIN
   update habitacion
   set ocupada = 0
   where id_habitacion = :new.id_habitacion;
END;