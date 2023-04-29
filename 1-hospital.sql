--------------------------------------------------------
--  File created - viernes-abril-28-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table BITACORA
--------------------------------------------------------

  CREATE TABLE "BITACORA" 
   (	"ID_BITACORA" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"USUARIO" VARCHAR2(20), 
	"FECHA" DATE
   );
--------------------------------------------------------
--  DDL for Table CONSULTA
--------------------------------------------------------

  CREATE TABLE "CONSULTA" 
   (	"ID_CONSULTA" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ID_PACIENTE" VARCHAR2(9), 
	"ID_DOCTOR" VARCHAR2(9), 
	"ID_SERVICIO" NUMBER, 
	"FECHA_CTA" DATE, 
	"VALORACION" VARCHAR2(100)
   );
--------------------------------------------------------
--  DDL for Table DOCTOR
--------------------------------------------------------

  CREATE TABLE "DOCTOR" 
   (	"ID_DOCTOR" VARCHAR2(9), 
	"NOMBRE_DOC" VARCHAR2(30), 
	"APELLIDO_DOC" VARCHAR2(50), 
	"ESPECIALIDAD" VARCHAR2(30), 
	"OCUPADO" NUMBER
   );
--------------------------------------------------------
--  DDL for Table ENFERMERA
--------------------------------------------------------

  CREATE TABLE "ENFERMERA" 
   (	"ID_ENFERMERA" VARCHAR2(9), 
	"NOMBRE_ENF" VARCHAR2(30), 
	"APELLIDO_ENF" VARCHAR2(50)
   );
--------------------------------------------------------
--  DDL for Table FACTURA
--------------------------------------------------------

  CREATE TABLE "FACTURA" 
   (	"ID_FACTURA" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ID_CONSULTA" NUMBER, 
	"IMPUESTOS" NUMBER(10,2), 
	"PRECIO_TOTAL" NUMBER(10,2)
   );
--------------------------------------------------------
--  DDL for Table FAMILIAR
--------------------------------------------------------

  CREATE TABLE "FAMILIAR" 
   (	"ID_FAMILIAR" VARCHAR2(9), 
	"NOMBRE_FMA" VARCHAR2(30), 
	"APELLIDO_FMA" VARCHAR2(50), 
	"TELEFONO_FMA" VARCHAR2(8), 
	"ID_PACIENTE" VARCHAR2(9)
   );
--------------------------------------------------------
--  DDL for Table HABITACION
--------------------------------------------------------

  CREATE TABLE "HABITACION" 
   (	"ID_HABITACION" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ID_ENFERMERA" VARCHAR2(9), 
	"TIPO_HABITACION" VARCHAR2(30), 
	"OCUPADA" NUMBER
   );
--------------------------------------------------------
--  DDL for Table INTERNADO
--------------------------------------------------------

  CREATE TABLE "INTERNADO" 
   (	"ID_INTERNADO" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ID_PACIENTE" VARCHAR2(9), 
	"ID_HABITACION" NUMBER, 
	"FECHA_INGRESO" DATE, 
	"FECHA_SALIDA" DATE
   );
--------------------------------------------------------
--  DDL for Table PACIENTE
--------------------------------------------------------

  CREATE TABLE "PACIENTE" 
   (	"ID_PACIENTE" VARCHAR2(9), 
	"NOMBRE_PTE" VARCHAR2(30), 
	"APELLIDO_PTE" VARCHAR2(50), 
	"PESO_PTE" NUMBER(6,2), 
	"TELEFONO_PTE" VARCHAR2(8)
   );
--------------------------------------------------------
--  DDL for Table SERVICIO
--------------------------------------------------------

  CREATE TABLE "SERVICIO" 
   (	"ID_SERVICIO" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"NOMBRE_SERVICIO" VARCHAR2(30), 
	"COSTO" NUMBER(10,2)
   );
--------------------------------------------------------
--  DDL for View CONSULTAS_ACTIVAS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "CONSULTAS_ACTIVAS" ("ID_CONSULTA", "PACIENTE", "DOCTOR", "NOMBRE_SERVICIO", "COSTO") AS 
  select 
        cta.id_consulta,
        pte.nombre_pte || ' ' || pte.apellido_pte as paciente,
        doc.nombre_doc || ' ' || doc.apellido_doc as doctor,
        srv.nombre_servicio,
        srv.costo
    from consulta cta
    inner join paciente pte on pte.id_paciente = cta.id_paciente
    inner join doctor doc on doc.id_doctor = cta.id_doctor
    inner join servicio srv on srv.id_servicio = cta.id_servicio
    where valoracion = null;
--------------------------------------------------------
--  DDL for View CONSULTA_DETALLADA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "CONSULTA_DETALLADA" ("ID_CONSULTA", "PACIENTE", "DOCTOR", "NOMBRE_SERVICIO", "VALORACION", "COSTO") AS 
  select 
        cta.id_consulta,
        pte.nombre_pte || ' ' || pte.apellido_pte as paciente,
        doc.nombre_doc || ' ' || doc.apellido_doc as doctor,
        srv.nombre_servicio,
        cta.valoracion,
        srv.costo
    from consulta cta
    inner join paciente pte on pte.id_paciente = cta.id_paciente
    inner join doctor doc on doc.id_doctor = cta.id_doctor
    inner join servicio srv on srv.id_servicio = cta.id_servicio;
--------------------------------------------------------
--  DDL for View DESGLOCE_FACTURA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "DESGLOCE_FACTURA" ("ID_FACTURA", "NOMBRE_SERVICIO", "COSTO", "IMPUESTOS", "PRECIO_TOTAL") AS 
  select
        fa.id_factura,
        ser.nombre_servicio,
        ser.costo,
        fa.impuestos,
        fa.precio_total
    from factura fa
    inner join consulta cta on cta.id_consulta = fa.id_consulta
    inner join servicio ser on ser.id_servicio = cta.id_servicio;
--------------------------------------------------------
--  DDL for View DOCTORES_DISPONIBLES
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "DOCTORES_DISPONIBLES" ("ID_DOCTOR", "NOMBRE", "ESPECIALIDAD") AS 
  select 
        dc.id_doctor,
        dc.nombre_doc || ' ' || dc.apellido_doc nombre,
        dc.especialidad
    from doctor dc
    where dc.ocupado <> 1;
--------------------------------------------------------
--  DDL for View ENFERMERAS_DISPONIBLES
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "ENFERMERAS_DISPONIBLES" ("ID_ENFERMERA", "NOMBRE") AS 
  select 
        em.id_enfermera,
        em.nombre_enf || ' ' || em.apellido_enf nombre
    from enfermera em;
--------------------------------------------------------
--  DDL for View FACTURAS_DETALLADAS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "FACTURAS_DETALLADAS" ("ID_FACTURA", "NOMBRE_SERVICIO", "COSTO", "IMPUESTOS", "PRECIO_TOTAL") AS 
  select 
        id_factura,
        serv.nombre_servicio,
        serv.costo,
        impuestos,
        precio_total
    from factura fac
    inner join consulta clt on clt.id_consulta = fac.id_consulta
    inner join servicio serv on serv.id_servicio = clt.id_servicio;
--------------------------------------------------------
--  DDL for View FAMILIAR_DETALLE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "FAMILIAR_DETALLE" ("ID_FAMILIAR", "NOMBRE_FAMILIAR", "TELEFONO_FMA", "NOMBRE_PACIENTE") AS 
  SELECT 
    FM.ID_FAMILIAR,
    NOMBRE_FMA ||' '|| APELLIDO_FMA AS NOMBRE_FAMILIAR,
    TELEFONO_FMA,
    NOMBRE_PTE ||' '|| APELLIDO_PTE AS NOMBRE_PACIENTE
FROM FAMILIAR FM
INNER JOIN PACIENTE PTE ON PTE.ID_PACIENTE = FM.ID_PACIENTE;
--------------------------------------------------------
--  DDL for View HABITACIONES_DISPONIBLES
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "HABITACIONES_DISPONIBLES" ("ID_HABITACION", "TIPO_HABITACION") AS 
  select 
        ht.id_habitacion,
        ht.tipo_habitacion
    from habitacion ht
    where ht.ocupada <> 1;
--------------------------------------------------------
--  DDL for View INICIO_SESION_ADMIN
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "INICIO_SESION_ADMIN" ("USUARIO", "FECHA") AS 
  select 
        usuario,
        fecha
    from bitacora
    where usuario like '%ADMIN%';
--------------------------------------------------------
--  DDL for View PACIENTES
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "PACIENTES" ("ID_PACIENTE", "NOMBRE_PTE", "APELLIDO_PTE", "PESO_PTE", "TELEFONO_PTE", "ID_FAMILIAR") AS 
  select pte.id_paciente,
    pte.nombre_pte, 
    pte.apellido_pte,
    pte.peso_pte,
    pte.telefono_pte,
    fm.id_familiar
    from paciente pte
    inner join familiar fm on fm.id_paciente = pte.id_paciente;
--------------------------------------------------------
--  DDL for View PACIENTES_INTERNADOS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "PACIENTES_INTERNADOS" ("ID_INTERNADO", "ID_PACIENTE", "NOMBRE", "PESO_PTE", "TELEFONO_PTE", "FECHA_INGRESO", "FAMILIAR") AS 
  select ido.id_internado,
    pte.id_paciente,
    pte.nombre_pte ||' '|| pte.apellido_pte as nombre,
    pte.peso_pte,
    pte.telefono_pte,
    ido.fecha_ingreso,
    fma.nombre_fma ||' '|| fma.apellido_fma as familiar
    from paciente pte
    inner join internado ido on pte.id_paciente = ido.id_paciente
    inner join familiar fma on fma.id_paciente = pte.id_paciente
    where ido.fecha_salida is null;
--------------------------------------------------------
--  DDL for View PACIENTES_SANOS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "PACIENTES_SANOS" ("PACIENTE_SANO") AS 
  select 
        pte.nombre_pte || ' ' || pte.apellido_pte paciente_sano
    from internado ido
    inner join paciente pte on pte.id_paciente = ido.id_paciente
    where ido.fecha_salida <> null;
--------------------------------------------------------
--  DDL for View REGISTRO_INTERNADOS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "REGISTRO_INTERNADOS" ("ID_PACIENTE", "NOMBRE", "PESO_PTE", "TELEFONO_PTE", "FECHA_INGRESO", "FAMILIAR", "FECHA_SALIDA") AS 
  select pte.id_paciente,
    pte.nombre_pte ||' '|| pte.apellido_pte as nombre,
    pte.peso_pte,
    pte.telefono_pte,
    ido.fecha_ingreso,
    fma.nombre_fma ||' '|| fma.apellido_fma as familiar,
    ido.fecha_salida
    from paciente pte
    inner join internado ido on pte.id_paciente = ido.id_paciente
    inner join familiar fma on fma.id_paciente = pte.id_paciente;
--------------------------------------------------------
--  DDL for View TODAS_HABITACIONES
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE VIEW "TODAS_HABITACIONES" ("ID_HABITACION", "ID_ENFERMERA", "NOMBRE_ENFERMERA", "TIPO_HABITACION", "OCUPADA") AS 
  select 
        ht.id_habitacion,
        ht.id_enfermera,
        enf.nombre_enf || ' ' || enf.apellido_enf as nombre_enfermera,
        ht.tipo_habitacion,
        ht.ocupada
    from habitacion ht
    inner join enfermera enf on enf.id_enfermera = ht.id_enfermera;
REM INSERTING into CONSULTA
SET DEFINE OFF;
Insert into CONSULTA (ID_PACIENTE,ID_DOCTOR,ID_SERVICIO,FECHA_CTA,VALORACION) values ('123456789','789789789',3,to_date('28-APR-23','DD-MON-RR'),'asdasdas');
REM INSERTING into DOCTOR
SET DEFINE OFF;
Insert into DOCTOR (ID_DOCTOR,NOMBRE_DOC,APELLIDO_DOC,ESPECIALIDAD,OCUPADO) values ('789789789','MARIA JOSE','RIVERA PAEZ','PEDIATRIA/NUTRICION',1);
REM INSERTING into ENFERMERA
SET DEFINE OFF;
Insert into ENFERMERA (ID_ENFERMERA,NOMBRE_ENF,APELLIDO_ENF) values ('666666666','Karina','Ramos Fonseca');
REM INSERTING into FACTURA
SET DEFINE OFF;
Insert into FACTURA (ID_CONSULTA,IMPUESTOS,PRECIO_TOTAL) values (1,7800,67800);
REM INSERTING into FAMILIAR
SET DEFINE OFF;
Insert into FAMILIAR (ID_FAMILIAR,NOMBRE_FMA,APELLIDO_FMA,TELEFONO_FMA,ID_PACIENTE) values ('111222333','jenny','mora mata','11223344','123456789');
REM INSERTING into HABITACION
SET DEFINE OFF;
Insert into HABITACION (ID_ENFERMERA,TIPO_HABITACION,OCUPADA) values ('666666666','suite',0);
REM INSERTING into INTERNADO
SET DEFINE OFF;
Insert into INTERNADO (ID_PACIENTE,ID_HABITACION,FECHA_INGRESO,FECHA_SALIDA) values ('123456789',1,to_date('28-APR-23','DD-MON-RR'),to_date('28-APR-23','DD-MON-RR'));
Insert into INTERNADO (ID_PACIENTE,ID_HABITACION,FECHA_INGRESO,FECHA_SALIDA) values ('123456789',1,to_date('28-APR-23','DD-MON-RR'),to_date('28-APR-23','DD-MON-RR'));
Insert into INTERNADO (ID_PACIENTE,ID_HABITACION,FECHA_INGRESO,FECHA_SALIDA) values ('123456789',1,to_date('28-APR-23','DD-MON-RR'),to_date('28-APR-23','DD-MON-RR'));
REM INSERTING into PACIENTE
SET DEFINE OFF;
Insert into PACIENTE (ID_PACIENTE,NOMBRE_PTE,APELLIDO_PTE,PESO_PTE,TELEFONO_PTE) values ('123123123','asdasd','jimenez',75.43,'11111111');
Insert into PACIENTE (ID_PACIENTE,NOMBRE_PTE,APELLIDO_PTE,PESO_PTE,TELEFONO_PTE) values ('123456789','Paola','Mejia Lara',60,'00000000');
REM INSERTING into SERVICIO
SET DEFINE OFF;
Insert into SERVICIO (NOMBRE_SERVICIO,COSTO) values ('Pediatria',50000);
Insert into SERVICIO (NOMBRE_SERVICIO,COSTO) values ('Nutricion',60000);
REM INSERTING into CONSULTAS_ACTIVAS
SET DEFINE OFF;
REM INSERTING into CONSULTA_DETALLADA
SET DEFINE OFF;
Insert into CONSULTA_DETALLADA (ID_CONSULTA,PACIENTE,DOCTOR,NOMBRE_SERVICIO,VALORACION,COSTO) values (1,'Paola Mejia Lara','MARIA JOSE RIVERA PAEZ','Nutricion','asdasdas',60000);
REM INSERTING into DESGLOCE_FACTURA
SET DEFINE OFF;
Insert into DESGLOCE_FACTURA (ID_FACTURA,NOMBRE_SERVICIO,COSTO,IMPUESTOS,PRECIO_TOTAL) values (20,'Nutricion',60000,7800,67800);
REM INSERTING into DOCTORES_DISPONIBLES
SET DEFINE OFF;
REM INSERTING into ENFERMERAS_DISPONIBLES
SET DEFINE OFF;
Insert into ENFERMERAS_DISPONIBLES (ID_ENFERMERA,NOMBRE) values ('666666666','Karina Ramos Fonseca');
REM INSERTING into FACTURAS_DETALLADAS
SET DEFINE OFF;
Insert into FACTURAS_DETALLADAS (ID_FACTURA,NOMBRE_SERVICIO,COSTO,IMPUESTOS,PRECIO_TOTAL) values (20,'Nutricion',60000,7800,67800);
REM INSERTING into FAMILIAR_DETALLE
SET DEFINE OFF;
Insert into FAMILIAR_DETALLE (ID_FAMILIAR,NOMBRE_FAMILIAR,TELEFONO_FMA,NOMBRE_PACIENTE) values ('111222333','jenny mora mata','11223344','Paola Mejia Lara');
REM INSERTING into HABITACIONES_DISPONIBLES
SET DEFINE OFF;
Insert into HABITACIONES_DISPONIBLES (ID_HABITACION,TIPO_HABITACION) values (1,'suite');
REM INSERTING into PACIENTES
SET DEFINE OFF;
Insert into PACIENTES (ID_PACIENTE,NOMBRE_PTE,APELLIDO_PTE,PESO_PTE,TELEFONO_PTE,ID_FAMILIAR) values ('123456789','Paola','Mejia Lara',60,'00000000','111222333');
REM INSERTING into PACIENTES_INTERNADOS
SET DEFINE OFF;
REM INSERTING into PACIENTES_SANOS
SET DEFINE OFF;
REM INSERTING into REGISTRO_INTERNADOS
SET DEFINE OFF;
Insert into REGISTRO_INTERNADOS (ID_PACIENTE,NOMBRE,PESO_PTE,TELEFONO_PTE,FECHA_INGRESO,FAMILIAR,FECHA_SALIDA) values ('123456789','Paola Mejia Lara',60,'00000000',to_date('28-APR-23','DD-MON-RR'),'jenny mora mata',to_date('28-APR-23','DD-MON-RR'));
Insert into REGISTRO_INTERNADOS (ID_PACIENTE,NOMBRE,PESO_PTE,TELEFONO_PTE,FECHA_INGRESO,FAMILIAR,FECHA_SALIDA) values ('123456789','Paola Mejia Lara',60,'00000000',to_date('28-APR-23','DD-MON-RR'),'jenny mora mata',to_date('28-APR-23','DD-MON-RR'));
Insert into REGISTRO_INTERNADOS (ID_PACIENTE,NOMBRE,PESO_PTE,TELEFONO_PTE,FECHA_INGRESO,FAMILIAR,FECHA_SALIDA) values ('123456789','Paola Mejia Lara',60,'00000000',to_date('28-APR-23','DD-MON-RR'),'jenny mora mata',to_date('28-APR-23','DD-MON-RR'));
REM INSERTING into TODAS_HABITACIONES
SET DEFINE OFF;
Insert into TODAS_HABITACIONES (ID_HABITACION,ID_ENFERMERA,NOMBRE_ENFERMERA,TIPO_HABITACION,OCUPADA) values (1,'666666666','Karina Ramos Fonseca','suite',0);
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
ALTER TRIGGER "CALCULAR_TOTAL_FACTURA" ENABLE;
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
ALTER TRIGGER "DESOCUPAR_DOCTOR" ENABLE;
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
ALTER TRIGGER "DESOCUPAR_HABITACION" ENABLE;
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
ALTER TRIGGER "ELIMINA_INTERNADO_HABITACION" ENABLE;
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

ALTER TRIGGER "INICIO_SESION" ENABLE;
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
ALTER TRIGGER "OCUPAR_DOCTOR" ENABLE;
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
ALTER TRIGGER "OCUPAR_HABITACION" ENABLE;
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
ALTER TRIGGER "OCUPAR_DOCTOR" ENABLE;
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
ALTER TRIGGER "CALCULAR_TOTAL_FACTURA" ENABLE;
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
ALTER TRIGGER "DESOCUPAR_DOCTOR" ENABLE;
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
ALTER TRIGGER "OCUPAR_HABITACION" ENABLE;
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
ALTER TRIGGER "DESOCUPAR_HABITACION" ENABLE;
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
ALTER TRIGGER "ELIMINA_INTERNADO_HABITACION" ENABLE;
--------------------------------------------------------
--  DDL for Package PKG_BITACORA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_BITACORA" AS
    PROCEDURE AGREGAR_BITACORA (
        B_USUARIO VARCHAR,
        B_FECHA DATE
    );

    FUNCTION LISTAR_FACTURAS RETURN SYS_REFCURSOR;

END PKG_BITACORA;
--------------------------------------------------------
--  DDL for Package PKG_CONSULTA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_CONSULTA" AS
    PROCEDURE AGREGAR_consulta (
        c_paciente varchar,
        c_doctor varchar,
        c_servicio number
    );

    PROCEDURE terminar_consulta (
        id_con number,
        valor varchar
    );

    FUNCTION BUSCAR_consulta (
        i_ID number
    ) RETURN SYS_REFCURSOR;

    FUNCTION BUSCAR_consulta_usuario (
        i_paciente number
    ) RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_consultas RETURN SYS_REFCURSOR;

END PKG_consulta;
--------------------------------------------------------
--  DDL for Package PKG_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_DOCTOR" AS
    PROCEDURE AGREGAR_DOCTOR (
        D_ID        VARCHAR,
        D_NOMBRE    VARCHAR,
        D_APELLIDOS VARCHAR,
        D_ESPEC     VARCHAR,
        D_OCUPADO   NUMBER
    );

    PROCEDURE ACTUALIZAR_DOCTOR (
        D_ID        VARCHAR,
        D_NOMBRE    VARCHAR,
        D_APELLIDOS VARCHAR,
        D_ESPEC     VARCHAR,
        D_OCUPADO   NUMBER
    );

    PROCEDURE BORRAR_DOCTOR (
        D_ID VARCHAR
    );

    FUNCTION BUSCAR_DOCTOR (
        D_ID VARCHAR
    ) RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_DOCTORES RETURN SYS_REFCURSOR;

END PKG_DOCTOR;
--------------------------------------------------------
--  DDL for Package PKG_ENFERMERA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_ENFERMERA" AS
    PROCEDURE AGREGAR_ENFERMERA (
        E_ID        VARCHAR,
        E_NOMBRE    VARCHAR,
        E_APELLIDOS VARCHAR
    );

    PROCEDURE ACTUALIZAR_ENFERMERA (
        E_ID        VARCHAR,
        E_NOMBRE    VARCHAR,
        E_APELLIDOS VARCHAR
    );

    PROCEDURE BORRAR_ENFERMERA (
        E_ID VARCHAR
    );

    FUNCTION BUSCAR_ENFERMERA (
        E_ID VARCHAR
    ) RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_ENFERMERAS RETURN SYS_REFCURSOR;

END PKG_ENFERMERA;
--------------------------------------------------------
--  DDL for Package PKG_FACTURA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_FACTURA" AS
    PROCEDURE AGREGAR_FACTURA (
        F_CONSULTA NUMBER
    );

    FUNCTION BUSCAR_FACTURA (
        F_ID number
    ) RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_FACTURAS RETURN SYS_REFCURSOR;

END PKG_FACTURA;
--------------------------------------------------------
--  DDL for Package PKG_FAMILIAR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_FAMILIAR" AS
    PROCEDURE agregar_familiar (
        f_id        VARCHAR,
        f_nombre    VARCHAR,
        f_apellidos VARCHAR,
        f_telefono  VARCHAR,
        f_paciente  VARCHAR
    );

    FUNCTION LISTAR_FAMILIARES
        RETURN SYS_REFCURSOR;

END pkg_familiar;
--------------------------------------------------------
--  DDL for Package PKG_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_HABITACION" AS
    PROCEDURE AGREGAR_habitacion (
        h_id_enfermera VARCHAR,
        h_tipo  varchar,
        h_ocupada number
    );

    PROCEDURE ACTUALIZAR_habitacion (
        h_ID     NUMBER,
        h_id_enfermera VARCHAR,
        h_tipo  varchar,
        h_ocupada number
    );

    PROCEDURE BORRAR_habitacion (
        h_ID number
    );

    FUNCTION BUSCAR_habitacion (
        h_ID number
    ) RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_habitaciones RETURN SYS_REFCURSOR;

END PKG_habitacion;
--------------------------------------------------------
--  DDL for Package PKG_INTERNADO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_INTERNADO" AS
    PROCEDURE AGREGAR_internado (
        i_paciente varchar,
        i_habitacion number
    );

    PROCEDURE ACTUALIZAR_internado (
        i_id number    );

    PROCEDURE BORRAR_internado (
        i_ID number
    );

    FUNCTION historial_internado RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_internados RETURN SYS_REFCURSOR;

END pkg_internado;
--------------------------------------------------------
--  DDL for Package PKG_PACIENTE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_PACIENTE" AS
    PROCEDURE AGREGAR_PACIENTE (
        P_ID        VARCHAR,
        P_NOMBRE    VARCHAR,
        P_APELLIDOS VARCHAR,
        P_PESO      DECIMAL,
        P_TELEFONO  VARCHAR
    );

    PROCEDURE ACTUALIZAR_PACIENTE (
        P_ID        VARCHAR,
        P_NOMBRE    VARCHAR,
        P_APELLIDOS VARCHAR,
        P_PESO      DECIMAL,
        P_TELEFONO  VARCHAR
    );

    PROCEDURE BORRAR_PACIENTE (
        P_ID VARCHAR
    );

    FUNCTION BUSCAR_PACIENTE (
        P_ID VARCHAR
    ) RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_PACIENTES RETURN SYS_REFCURSOR;

END PKG_PACIENTE;
--------------------------------------------------------
--  DDL for Package PKG_SERVICIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "PKG_SERVICIO" AS
    PROCEDURE AGREGAR_SERVICIO (
        S_NOMBRE VARCHAR,
        S_COSTO  NUMBER
    );

    PROCEDURE ACTUALIZAR_SERVICIO (
        S_ID     NUMBER,
        S_NOMBRE VARCHAR,
        S_COSTO  NUMBER
    );

    PROCEDURE BORRAR_SERVICIO (
        S_ID VARCHAR
    );

    FUNCTION BUSCAR_SERVICIO (
        S_ID VARCHAR
    ) RETURN SYS_REFCURSOR;

    FUNCTION LISTAR_SERVICIOS RETURN SYS_REFCURSOR;

END PKG_SERVICIO;
--------------------------------------------------------
--  DDL for Package Body PKG_BITACORA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_BITACORA" AS 
    PROCEDURE AGREGAR_BITACORA (
        B_USUARIO VARCHAR,
        B_FECHA DATE
    ) IS 
    BEGIN
    INSERT INTO BITACORA (USUARIO, FECHA)
    VALUES (B_USUARIO, B_FECHA);
    COMMIT;
    END AGREGAR_BITACORA;

    FUNCTION LISTAR_FACTURAS RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_BITACORA,
                USUARIO,
                FECHA
            FROM BITACORA;
        RETURN RF_CUR;
    END LISTAR_FACTURAS;
END PKG_BITACORA;
--------------------------------------------------------
--  DDL for Package Body PKG_CONSULTA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_CONSULTA" AS 
    PROCEDURE AGREGAR_consulta (
        c_paciente varchar,
        c_doctor varchar,
        c_servicio number
    ) IS 
    BEGIN
        INSERT INTO CONSULTA (ID_PACIENTE, ID_DOCTOR, ID_SERVICIO, FECHA_CTA)
        VALUES (c_paciente, c_doctor, c_servicio, sysdate);
        COMMIT;
    END AGREGAR_consulta;

    PROCEDURE terminar_consulta (
        id_con number,
        valor varchar
    ) is
    begin
        update consulta
        set valoracion = valor
        where id_consulta = id_con;
        commit;
    end terminar_consulta;

    FUNCTION BUSCAR_consulta (
        i_ID IN number
    ) RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_CONSULTA, 
                PACIENTE, 
                DOCTOR, 
                NOMBRE_SERVICIO, 
                VALORACION,
                COSTO
            FROM CONSULTA_DETALLADA
            WHERE ID_CONSULTA = i_ID;
        RETURN RF_CUR;
    END BUSCAR_consulta;

    FUNCTION BUSCAR_consulta_usuario (
        I_PACIENTE IN number
    ) RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_CONSULTA, 
                ID_PACIENTE, 
                ID_DOCTOR, 
                ID_SERVICIO, 
                VALORACION
            FROM CONSULTA
            WHERE ID_PACIENTE = I_PACIENTE;
        RETURN RF_CUR;
    END BUSCAR_consulta_usuario;

    FUNCTION LISTAR_CONSULTAS RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_CONSULTA, 
                PACIENTE, 
                DOCTOR, 
                NOMBRE_SERVICIO, 
                VALORACION,
                COSTO
            FROM CONSULTA_DETALLADA;
        RETURN RF_CUR;
    END LISTAR_CONSULTAS;
END PKG_consulta;
--------------------------------------------------------
--  DDL for Package Body PKG_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_DOCTOR" AS

    PROCEDURE AGREGAR_DOCTOR (
        D_ID        VARCHAR,
        D_NOMBRE    VARCHAR,
        D_APELLIDOS VARCHAR,
        D_ESPEC     VARCHAR,
        D_OCUPADO   NUMBER
    ) IS
    BEGIN
        INSERT INTO DOCTOR (
            ID_DOCTOR,
            NOMBRE_DOC,
            APELLIDO_DOC,
            ESPECIALIDAD,
            OCUPADO
        ) VALUES (
            D_ID,
            D_NOMBRE,
            D_APELLIDOS,
            D_ESPEC,
            D_OCUPADO
        );

        COMMIT;
    END AGREGAR_DOCTOR;

    PROCEDURE ACTUALIZAR_DOCTOR (
        D_ID        VARCHAR,
        D_NOMBRE    VARCHAR,
        D_APELLIDOS VARCHAR,
        D_ESPEC     VARCHAR,
        D_OCUPADO   NUMBER
    ) IS
    BEGIN
        UPDATE DOCTOR
        SET
            NOMBRE_DOC = D_NOMBRE,
            APELLIDO_DOC = D_APELLIDOS,
            ESPECIALIDAD = D_ESPEC,
            OCUPADO = D_OCUPADO
        WHERE
            ID_DOCTOR = D_ID;

        COMMIT;
    END ACTUALIZAR_DOCTOR;

    PROCEDURE BORRAR_DOCTOR (
        D_ID VARCHAR
    ) IS
    BEGIN
        DELETE FROM DOCTOR
        WHERE
            ID_DOCTOR = D_ID;

        COMMIT;
    END BORRAR_DOCTOR;

    FUNCTION BUSCAR_DOCTOR (
        D_ID IN VARCHAR
    ) RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_DOCTOR,
                NOMBRE_DOC,
                APELLIDO_DOC,
                ESPECIALIDAD,
                OCUPADO
            FROM DOCTOR
            WHERE ID_DOCTOR = D_ID;
        RETURN RF_CUR;
    END;

    FUNCTION LISTAR_DOCTORES RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT 
                ID_DOCTOR,
                NOMBRE_DOC,
                APELLIDO_DOC,
                ESPECIALIDAD,
                OCUPADO
            FROM DOCTOR;
        RETURN RF_CUR;
    END;

END PKG_DOCTOR;
--------------------------------------------------------
--  DDL for Package Body PKG_ENFERMERA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_ENFERMERA" AS

    PROCEDURE AGREGAR_ENFERMERA (
        E_ID        VARCHAR,
        E_NOMBRE    VARCHAR,
        E_APELLIDOS VARCHAR
    ) IS
    BEGIN
        INSERT INTO ENFERMERA (
            ID_ENFERMERA,
            NOMBRE_ENF,
            APELLIDO_ENF
        ) VALUES (
            E_ID,
            E_NOMBRE,
            E_APELLIDOS
        );

        COMMIT;
    END AGREGAR_ENFERMERA;

    PROCEDURE ACTUALIZAR_ENFERMERA (
        E_ID        VARCHAR,
        E_NOMBRE    VARCHAR,
        E_APELLIDOS VARCHAR
    ) IS
    BEGIN
        UPDATE ENFERMERA
        SET
            NOMBRE_ENF = E_NOMBRE,
            APELLIDO_ENF = E_APELLIDOS
        WHERE
            ID_ENFERMERA = E_ID;

        COMMIT;
    END ACTUALIZAR_ENFERMERA;

    PROCEDURE BORRAR_ENFERMERA (
        E_ID VARCHAR
    ) IS
    BEGIN
        DELETE FROM ENFERMERA
        WHERE
            ID_ENFERMERA = E_ID;

        COMMIT;
    END BORRAR_ENFERMERA;

    FUNCTION BUSCAR_ENFERMERA (
        E_ID IN VARCHAR
    ) RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_ENFERMERA,
                NOMBRE_ENF,
                APELLIDO_ENF
            FROM ENFERMERA
            WHERE ID_ENFERMERA = E_ID;
        RETURN RF_CUR;
    END;

    FUNCTION LISTAR_ENFERMERAS RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_ENFERMERA,
                NOMBRE_ENF,
                APELLIDO_ENF
            FROM ENFERMERA;
        RETURN RF_CUR;
    END;

END PKG_ENFERMERA;
--------------------------------------------------------
--  DDL for Package Body PKG_FACTURA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_FACTURA" AS 
    PROCEDURE AGREGAR_FACTURA (
        F_CONSULTA NUMBER
    ) IS 
    BEGIN
    INSERT INTO FACTURA (ID_CONSULTA)
    VALUES (F_CONSULTA);
    COMMIT;
    END AGREGAR_FACTURA;

    FUNCTION BUSCAR_FACTURA (
        F_ID IN number
    ) RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_FACTURA,
                ID_CONSULTA,
                IMPUESTOS,
                PRECIO_TOTAL
            FROM FACTURA
            WHERE ID_FACTURA = F_ID;
        RETURN RF_CUR;
    END BUSCAR_FACTURA;

    FUNCTION LISTAR_FACTURAS RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_FACTURA,
                NOMBRE_SERVICIO,
                COSTO,
                IMPUESTOS,
                PRECIO_TOTAL
            FROM FACTURAS_DETALLADAS;
        RETURN RF_CUR;
    END LISTAR_FACTURAS;
END PKG_FACTURA;
--------------------------------------------------------
--  DDL for Package Body PKG_FAMILIAR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_FAMILIAR" AS

    PROCEDURE agregar_familiar (
        f_id        VARCHAR,
        f_nombre    VARCHAR,
        f_apellidos VARCHAR,
        f_telefono  VARCHAR,
        f_paciente  VARCHAR
    ) IS
    BEGIN
        INSERT INTO familiar (
            id_familiar,
            nombre_fma,
            apellido_fma,
            telefono_fma,
            id_paciente
        ) VALUES (
            f_id,
            f_nombre,
            f_apellidos,
            f_telefono,
            f_paciente
        );

        COMMIT;
    END agregar_familiar;

    FUNCTION listar_familiares RETURN SYS_REFCURSOR IS
        rf_cur SYS_REFCURSOR;
    BEGIN
        OPEN rf_cur FOR SELECT
                            id_familiar,
                            nombre_familiar,
                            telefono_fma,
                            nombre_paciente
                        FROM
                            familiar_detalle;

        RETURN rf_cur;
    END;

END pkg_familiar;
--------------------------------------------------------
--  DDL for Package Body PKG_HABITACION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_HABITACION" AS 
    PROCEDURE AGREGAR_habitacion (
        h_id_enfermera VARCHAR,
        h_tipo  varchar,
        h_ocupada number
    ) IS 
    BEGIN
    INSERT INTO habitacion (ID_ENFERMERA, TIPO_HABITACION, OCUPADA)
    VALUES (h_id_enfermera, h_tipo, h_ocupada);
    COMMIT;
    END AGREGAR_habitacion;


    PROCEDURE ACTUALIZAR_habitacion (
        h_ID     NUMBER,
        h_id_enfermera VARCHAR,
        h_tipo  varchar,
        h_ocupada number
    ) IS
    BEGIN
    UPDATE habitacion
    SET ID_ENFERMERA = h_id_enfermera,
    TIPO_HABITACION = h_tipo,
    OCUPADA = h_ocupada
    WHERE ID_HABITACION = h_ID;
    COMMIT;
    END ACTUALIZAR_habitacion;

    PROCEDURE BORRAR_habitacion (
        h_ID number
    ) IS 
    BEGIN
    DELETE FROM habitacion
    WHERE ID_HABITACION= h_ID;
    COMMIT;
    END BORRAR_habitacion;

    FUNCTION BUSCAR_habitacion (
        h_ID IN number
    ) RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                id_habitacion,
                id_enfermera,
                nombre_enfermera,
                tipo_habitacion,
                ocupada
            FROM todas_habitaciones
            WHERE id_habitacion = h_ID;
        RETURN RF_CUR;
    END BUSCAR_habitacion;

    FUNCTION LISTAR_habitaciones RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                id_habitacion,
                id_enfermera,
                nombre_enfermera,
                tipo_habitacion,
                ocupada
            FROM todas_habitaciones;
        RETURN RF_CUR;
    END LISTAR_habitaciones;
END PKG_habitacion;
--------------------------------------------------------
--  DDL for Package Body PKG_INTERNADO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_INTERNADO" AS 
    PROCEDURE AGREGAR_internado (
        i_paciente varchar,
        i_habitacion number
    ) IS 
    BEGIN
    INSERT INTO internado (ID_PACIENTE,ID_HABITACION,FECHA_INGRESO)
    VALUES (i_paciente, i_habitacion, sysdate);
    COMMIT;
    END AGREGAR_internado;

    PROCEDURE ACTUALIZAR_internado (
        i_id number
    ) IS
    BEGIN
    UPDATE internado
    SET FECHA_SALIDA = sysdate
    WHERE ID_INTERNADO = i_id;
    COMMIT;
    END ACTUALIZAR_internado;

    PROCEDURE BORRAR_internado (
        i_ID number
    ) IS 
    BEGIN
    DELETE FROM internado
    WHERE ID_INTERNADO= i_ID;
    COMMIT;
    END BORRAR_internado;

    FUNCTION historial_internado
    RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                id_paciente,
                nombre,
                peso_pte,
                telefono_pte,
                familiar,
                fecha_ingreso,
                fecha_salida
            FROM
                registro_internados;
        RETURN RF_CUR;
    END historial_internado;

    FUNCTION LISTAR_internados RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR select
                id_internado,
                ID_PACIENTE,
                NOMBRE,
                PESO_PTE,
                TELEFONO_PTE,
                FECHA_INGRESO,
                FAMILIAR
            from PACIENTES_INTERNADOS;
        RETURN RF_CUR;
    END LISTAR_internados;
END pkg_internado;
--------------------------------------------------------
--  DDL for Package Body PKG_PACIENTE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_PACIENTE" AS

    PROCEDURE AGREGAR_PACIENTE (
        P_ID    VARCHAR,
        P_NOMBRE    VARCHAR,
        P_APELLIDOS VARCHAR,
        P_PESO      DECIMAL,
        P_TELEFONO  VARCHAR
    ) IS
    BEGIN
        INSERT INTO PACIENTE (
            ID_PACIENTE,
            NOMBRE_PTE,
            APELLIDO_PTE,
            PESO_PTE,
            TELEFONO_PTE
        ) VALUES (
            P_ID,
            P_NOMBRE,
            P_APELLIDOS,
            P_PESO,
            P_TELEFONO
        );
        COMMIT;
    END AGREGAR_PACIENTE;

    PROCEDURE ACTUALIZAR_PACIENTE (
        P_ID    VARCHAR,
        P_NOMBRE    VARCHAR,
        P_APELLIDOS VARCHAR,
        P_PESO      DECIMAL,
        P_TELEFONO  VARCHAR
    ) IS
    BEGIN
        UPDATE PACIENTE
        SET
            NOMBRE_PTE = P_NOMBRE,
            APELLIDO_PTE = P_APELLIDOS,
            PESO_PTE = P_PESO,
            TELEFONO_PTE = P_TELEFONO
        WHERE
            ID_PACIENTE = P_ID;
        COMMIT;
    END ACTUALIZAR_PACIENTE;

    PROCEDURE BORRAR_PACIENTE (
        P_ID VARCHAR
    ) IS
    BEGIN
        DELETE FROM PACIENTE
        WHERE ID_PACIENTE = P_ID;
        COMMIT;
    END BORRAR_PACIENTE;

    FUNCTION BUSCAR_PACIENTE (
        P_ID IN VARCHAR
        ) RETURN SYS_REFCURSOR IS 
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
        FOR SELECT ID_PACIENTE, NOMBRE_PTE, APELLIDO_PTE, PESO_PTE, TELEFONO_PTE 
            FROM PACIENTE 
            WHERE ID_PACIENTE = P_ID;
        RETURN RF_CUR;
    END;

    FUNCTION LISTAR_PACIENTES
        RETURN SYS_REFCURSOR IS 
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
        FOR SELECT ID_PACIENTE, NOMBRE_PTE, APELLIDO_PTE, PESO_PTE, TELEFONO_PTE
            FROM PACIENTE;
        RETURN RF_CUR;
    END;
END PKG_PACIENTE;
--------------------------------------------------------
--  DDL for Package Body PKG_SERVICIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "PKG_SERVICIO" AS 
    PROCEDURE AGREGAR_SERVICIO (
        S_NOMBRE VARCHAR,
        S_COSTO  NUMBER
    ) IS 
    BEGIN
    INSERT INTO SERVICIO (NOMBRE_SERVICIO, COSTO)
    VALUES (S_NOMBRE, S_COSTO);
    COMMIT;
    END AGREGAR_SERVICIO;


    PROCEDURE ACTUALIZAR_SERVICIO (
        S_ID     NUMBER,
        S_NOMBRE VARCHAR,
        S_COSTO  NUMBER
    ) IS
    BEGIN
    UPDATE SERVICIO
    SET NOMBRE_SERVICIO = S_NOMBRE,
    COSTO = S_COSTO
    WHERE ID_SERVICIO = S_ID;
    COMMIT;
    END ACTUALIZAR_SERVICIO;

    PROCEDURE BORRAR_SERVICIO (
        S_ID VARCHAR
    ) IS 
    BEGIN
    DELETE FROM SERVICIO
    WHERE ID_SERVICIO = S_ID;
    COMMIT;
    END BORRAR_SERVICIO;

    FUNCTION BUSCAR_SERVICIO (
        S_ID IN VARCHAR
    ) RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_SERVICIO,
                NOMBRE_SERVICIO,
                COSTO
            FROM SERVICIO
            WHERE ID_SERVICIO = S_ID;
        RETURN RF_CUR;
    END BUSCAR_SERVICIO;

    FUNCTION LISTAR_SERVICIOS RETURN SYS_REFCURSOR IS
        RF_CUR SYS_REFCURSOR;
    BEGIN
        OPEN RF_CUR 
            FOR SELECT
                ID_SERVICIO,
                NOMBRE_SERVICIO,
                COSTO
            FROM SERVICIO;
        RETURN RF_CUR;
    END LISTAR_SERVICIOS;
END PKG_SERVICIO;
--------------------------------------------------------
--  Constraints for Table BITACORA
--------------------------------------------------------

  ALTER TABLE "BITACORA" MODIFY ("ID_BITACORA" NOT NULL ENABLE);
  ALTER TABLE "BITACORA" MODIFY ("FECHA" NOT NULL ENABLE);
  ALTER TABLE "BITACORA" ADD CONSTRAINT "PK_BITACORA" PRIMARY KEY ("ID_BITACORA")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table CONSULTA
--------------------------------------------------------

  ALTER TABLE "CONSULTA" MODIFY ("ID_CONSULTA" NOT NULL ENABLE);
  ALTER TABLE "CONSULTA" MODIFY ("FECHA_CTA" NOT NULL ENABLE);
  ALTER TABLE "CONSULTA" ADD CONSTRAINT "PK_CONSULTA" PRIMARY KEY ("ID_CONSULTA")
  USING INDEX  ENABLE;
  ALTER TABLE "CONSULTA" MODIFY ("ID_PACIENTE" NOT NULL ENABLE);
  ALTER TABLE "CONSULTA" MODIFY ("ID_DOCTOR" NOT NULL ENABLE);
  ALTER TABLE "CONSULTA" MODIFY ("ID_SERVICIO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DOCTOR
--------------------------------------------------------

  ALTER TABLE "DOCTOR" MODIFY ("ID_DOCTOR" NOT NULL ENABLE);
  ALTER TABLE "DOCTOR" MODIFY ("NOMBRE_DOC" NOT NULL ENABLE);
  ALTER TABLE "DOCTOR" MODIFY ("APELLIDO_DOC" NOT NULL ENABLE);
  ALTER TABLE "DOCTOR" MODIFY ("ESPECIALIDAD" NOT NULL ENABLE);
  ALTER TABLE "DOCTOR" MODIFY ("OCUPADO" NOT NULL ENABLE);
  ALTER TABLE "DOCTOR" ADD CONSTRAINT "PK_DOCTOR" PRIMARY KEY ("ID_DOCTOR")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table ENFERMERA
--------------------------------------------------------

  ALTER TABLE "ENFERMERA" MODIFY ("ID_ENFERMERA" NOT NULL ENABLE);
  ALTER TABLE "ENFERMERA" MODIFY ("NOMBRE_ENF" NOT NULL ENABLE);
  ALTER TABLE "ENFERMERA" MODIFY ("APELLIDO_ENF" NOT NULL ENABLE);
  ALTER TABLE "ENFERMERA" ADD CONSTRAINT "PK_ENFERMERA" PRIMARY KEY ("ID_ENFERMERA")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table FACTURA
--------------------------------------------------------

  ALTER TABLE "FACTURA" MODIFY ("ID_FACTURA" NOT NULL ENABLE);
  ALTER TABLE "FACTURA" MODIFY ("IMPUESTOS" NOT NULL ENABLE);
  ALTER TABLE "FACTURA" MODIFY ("PRECIO_TOTAL" NOT NULL ENABLE);
  ALTER TABLE "FACTURA" ADD CONSTRAINT "PK_FACTURA" PRIMARY KEY ("ID_FACTURA")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table FAMILIAR
--------------------------------------------------------

  ALTER TABLE "FAMILIAR" MODIFY ("ID_FAMILIAR" NOT NULL ENABLE);
  ALTER TABLE "FAMILIAR" MODIFY ("NOMBRE_FMA" NOT NULL ENABLE);
  ALTER TABLE "FAMILIAR" MODIFY ("APELLIDO_FMA" NOT NULL ENABLE);
  ALTER TABLE "FAMILIAR" MODIFY ("TELEFONO_FMA" NOT NULL ENABLE);
  ALTER TABLE "FAMILIAR" ADD CONSTRAINT "PK_FAMILIAR" PRIMARY KEY ("ID_FAMILIAR")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table HABITACION
--------------------------------------------------------

  ALTER TABLE "HABITACION" MODIFY ("ID_HABITACION" NOT NULL ENABLE);
  ALTER TABLE "HABITACION" MODIFY ("TIPO_HABITACION" NOT NULL ENABLE);
  ALTER TABLE "HABITACION" MODIFY ("OCUPADA" NOT NULL ENABLE);
  ALTER TABLE "HABITACION" ADD CONSTRAINT "PK_HABITACION" PRIMARY KEY ("ID_HABITACION")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table INTERNADO
--------------------------------------------------------

  ALTER TABLE "INTERNADO" MODIFY ("ID_INTERNADO" NOT NULL ENABLE);
  ALTER TABLE "INTERNADO" MODIFY ("FECHA_INGRESO" NOT NULL ENABLE);
  ALTER TABLE "INTERNADO" ADD CONSTRAINT "PK_INTERNADO" PRIMARY KEY ("ID_INTERNADO")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table PACIENTE
--------------------------------------------------------

  ALTER TABLE "PACIENTE" MODIFY ("ID_PACIENTE" NOT NULL ENABLE);
  ALTER TABLE "PACIENTE" MODIFY ("NOMBRE_PTE" NOT NULL ENABLE);
  ALTER TABLE "PACIENTE" MODIFY ("APELLIDO_PTE" NOT NULL ENABLE);
  ALTER TABLE "PACIENTE" MODIFY ("PESO_PTE" NOT NULL ENABLE);
  ALTER TABLE "PACIENTE" MODIFY ("TELEFONO_PTE" NOT NULL ENABLE);
  ALTER TABLE "PACIENTE" ADD CONSTRAINT "PK_PACIENTE" PRIMARY KEY ("ID_PACIENTE")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table SERVICIO
--------------------------------------------------------

  ALTER TABLE "SERVICIO" MODIFY ("ID_SERVICIO" NOT NULL ENABLE);
  ALTER TABLE "SERVICIO" MODIFY ("NOMBRE_SERVICIO" NOT NULL ENABLE);
  ALTER TABLE "SERVICIO" MODIFY ("COSTO" NOT NULL ENABLE);
  ALTER TABLE "SERVICIO" ADD CONSTRAINT "PK_SERVICIO" PRIMARY KEY ("ID_SERVICIO")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CONSULTA
--------------------------------------------------------

  ALTER TABLE "CONSULTA" ADD CONSTRAINT "FK_CONSULTA_PACIENTE" FOREIGN KEY ("ID_PACIENTE")
	  REFERENCES "PACIENTE" ("ID_PACIENTE") ENABLE;
  ALTER TABLE "CONSULTA" ADD CONSTRAINT "FK_CONSULTA_DOCTOR" FOREIGN KEY ("ID_DOCTOR")
	  REFERENCES "DOCTOR" ("ID_DOCTOR") ENABLE;
  ALTER TABLE "CONSULTA" ADD CONSTRAINT "FK_CONSULTA_SERVICIO" FOREIGN KEY ("ID_SERVICIO")
	  REFERENCES "SERVICIO" ("ID_SERVICIO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FACTURA
--------------------------------------------------------

  ALTER TABLE "FACTURA" ADD CONSTRAINT "FK_FACTURA_CONSULTA" FOREIGN KEY ("ID_CONSULTA")
	  REFERENCES "CONSULTA" ("ID_CONSULTA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FAMILIAR
--------------------------------------------------------

  ALTER TABLE "FAMILIAR" ADD CONSTRAINT "FK_FAMILIA_PACIENTE" FOREIGN KEY ("ID_PACIENTE")
	  REFERENCES "PACIENTE" ("ID_PACIENTE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table HABITACION
--------------------------------------------------------

  ALTER TABLE "HABITACION" ADD CONSTRAINT "FK_HABITACION_ENFERMERA" FOREIGN KEY ("ID_ENFERMERA")
	  REFERENCES "ENFERMERA" ("ID_ENFERMERA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table INTERNADO
--------------------------------------------------------

  ALTER TABLE "INTERNADO" ADD CONSTRAINT "FK_INTERNADO_PACIENTE" FOREIGN KEY ("ID_PACIENTE")
	  REFERENCES "PACIENTE" ("ID_PACIENTE") ENABLE;
  ALTER TABLE "INTERNADO" ADD CONSTRAINT "FK_INTERNADO_HABITACION" FOREIGN KEY ("ID_HABITACION")
	  REFERENCES "HABITACION" ("ID_HABITACION") ENABLE;
