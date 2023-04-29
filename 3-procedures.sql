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