SELECT  n_orden
FROM n_orden_ocupacional
LIMIT 1;




CREATE TABLE n_orden_examen_adicional ( id SERIAL PRIMARY KEY, n_orden BIGINT NOT NULL, id_examen_adicional_protocolo BIGINT NOT NULL, version_registro INTEGER, usuario_registro text, fecha_registro date, hora_registro TIME, CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional(n_orden) );

CREATE TABLE configuracion_deposito ( id SERIAL PRIMARY KEY, codigo_transferencia TEXT, banco TEXT, monto numeric(38, 2), archivo TEXT, usuario_registro text, fecha_registro date, hora_registro TIME, usuario_actualizacion text, fecha_actualizacion date, hora_actualizacion TIME, estado boolean );

CREATE TABLE detalle_pago ( id SERIAL PRIMARY KEY, n_orden integer NOT NULL, version_registro INTEGER, monto_adicionales numeric(38, 2), monto_protocolo numeric(38, 2), monto_total numeric(38, 2), id_configuracion_deposito INTEGER, fecha_pago date, hora_pago TIME, forma_pago text, usuario_registro text, fecha_registro date, hora_registro TIME, usuario_actualizacion text, fecha_actualizacion date, hora_actualizacion TIME, estado boolean, CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional(n_orden), CONSTRAINT fk_id_configuracion_deposito FOREIGN KEY (id_configuracion_deposito) REFERENCES configuracion_deposito(id) );

SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificado_aptitud_medico_resumen
WHERE n_orden = norden_param;
-----------------------------------------------------------------------------
--PGADMIN 4
--verificar el id porque no es autoincremental 
INSERT INTO lista_parametros values (54, 'Acuerdos de pago') --verificar el id porque no es autoincremental 
INSERT INTO detalle_parametro values (49052, 'Credito', 54)
INSERT INTO detalle_parametro values (49053, 'No Credito', 54)

ALTER TABLE protocolo RENAME COLUMN forma_pago TO acuerdo_pago;

ALTER TABLE protocolo add column forma_pago TEXT -- 

CREATE TABLE forma_pago(
-- forma_pago_id serial primary key,
-- nombre text not null,
-- anulado boolean,
-- usuario_registro TEXT,
-- fecha_registro DATE,
-- hora_registro TIME,
-- usuario_actualizacion TEXT,
-- fecha_actualizacion DATE,
-- hora_actualizacion TIME
-- ) 

CREATE TABLE protocolo_sub_examen_adicional( id_sub_examen_adicional_protocolo serial primary key, id_sub_examen Integer not null, id_protocolo INTEGER NOT NULL, precio numeric(38, 2), estado boolean, usuario_registro TEXT, fecha_registro DATE, hora_registro TIME, usuario_actualizacion TEXT, fecha_actualizacion DATE, hora_actualizacion TIME, CONSTRAINT fk_sub_examen FOREIGN KEY (id_sub_examen) REFERENCES sub_examen (id_sub_examen), CONSTRAINT fk_protocolo FOREIGN KEY (id_protocolo) REFERENCES protocolo (id_protocolo) );

CREATE TABLE protocolo_examen_adicional( id_examen_adicional_protocolo serial primary key, id_examen Integer not null, id_protocolo INTEGER NOT NULL, precio numeric(38, 2), estado boolean, usuario_registro TEXT, fecha_registro DATE, hora_registro TIME, usuario_actualizacion TEXT, fecha_actualizacion DATE, hora_actualizacion TIME, CONSTRAINT fk_examen FOREIGN KEY (id_examen) REFERENCES examen (id_examen), CONSTRAINT fk_protocolo FOREIGN KEY (id_protocolo) REFERENCES protocolo (id_protocolo) );
-- BUSQUEDA DE EXAMENES SEGUN PROTOCOLO 

CREATE OR REPLACE FUNCTION listado_examenes_protocolos_paciente( protocolo_param text, historia_clinica_param integer ) RETURNS TABLE( id_archivos bigint, nombre text, ruta text, valor boolean ) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $BODY$ BEGIN RETURN QUERY
SELECT  cast ( 1                                                           AS bigint )
       ,cast(tb1.nombre AS text)                                           AS nombre
       ,cast (tb2.ruta_Archivo AS text)                                    AS ruta
       ,( CASE WHEN tb2.id_archivos is not null THEN true else false end ) AS valor
FROM
(
	SELECT  exam.prefijo
	       ,exam.nombre
	FROM protocolo AS prot
	INNER JOIN protocolo_examenes AS prot_exam
	ON prot.id_protocolo = prot_exam.id_protocolo
	INNER JOIN examen AS exam
	ON prot_exam.id_examen = exam.id_examen
	WHERE prot.nombre = protocolo_param
	AND exam.prefijo IS NOT NULL 
) AS tb1
LEFT JOIN
(
	SELECT  arch_Serv.id_archivos
	       ,arch_Serv.ruta_Archivo
	       ,tip_Arch.nomenclatura
	FROM archivos_servidores AS arch_Serv
	INNER JOIN tipo_archivo AS tip_Arch
	ON arch_Serv.id_tipo_archivo = tip_Arch.id_tipo_archivo
	WHERE arch_Serv.orden = historia_clinica_param 
) AS tb2
ON tb1.prefijo = tb2.nomenclatura; END; $BODY$;
-- PG ADMIN 3 

CREATE OR REPLACE FUNCTION listado_pacientes_protocolo_busqueda_filtros( razon_empresa_param text, razon_contrata_param text, name_protocolo_param text, fecha_inicio_param date, fecha_fin_param date ) RETURNS TABLE( protocolos text, nombres text, dni integer, n_orden integer, razon_empresa text, razon_contrata text, tipoexamen text, fechaexamen date ) LANGUAGE 'plpgsql' AS $BODY$ BEGIN RETURN QUERY
SELECT  n.protocolo
       ,dp.nombres_pa || ' ' || dp.apellidos_pa AS nombres
       ,n.cod_pa                                AS dni
       ,n.n_orden
       ,n.razon_empresa
       ,n.razon_contrata
       ,n.nom_examen                            AS tipoExamen
       ,n.fecha_apertura_po                     AS fechaExamen
FROM n_orden_ocupacional AS n
INNER JOIN datos_paciente AS dp
ON n.cod_pa = dp.cod_pa
WHERE n.razon_empresa = razon_empresa_param
AND n.fecha_apertura_po BETWEEN fecha_inicio_param AND fecha_fin_param; END; $BODY$;
------------------------------------------------------------------ 

CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(user_name text) RETURNS TABLE( id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying, empresas text, contratas text ) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $BODY$ DECLARE validar_empresa_hm BIGINT; BEGIN

SELECT  COUNT(emp.id_empleado) into validar_empresa_hm
FROM empleado AS emp
INNER JOIN usuario AS us
ON emp.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc = '20477167561'
AND us.username = user_name; IF(validar_empresa_hm > 0) THEN RETURN QUERY

SELECT  empl.id_empleado
       ,empl.apellidos
       ,empl.cargo
       ,empl.celular
       ,empl.cip
       ,empl.correo_elect
       ,empl.direccion
       ,empl.estado
       ,empl.fecha_actualizacion
       ,empl.fecha_nacimiento
       ,empl.fecha_registro
       ,empl.nombres
       ,empl.num_documento
       ,empl.tel_fijo
       ,empl.tipo_doc
       ,empl.ubigeo
       ,empl.user_actualizacion
       ,empl.user_registro
       ,empl.sexo
       ,(
SELECT  STRING_AGG(DISTINCT e1.razon_empresa,' - ') AS empresas
FROM empleado AS empl1
INNER JOIN usuario AS us1
ON empl1.id_empleado = us1.id_empleado
INNER JOIN usuario_empresa_contrada AS uec1
ON us1.id_user = uec1.id_user
INNER JOIN empresas AS e1
ON uec1.ruc = e1.ruc_empresa AND uec1.tipo = 'EMPRESA'
WHERE uec1.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado )
GROUP BY  empl1.id_empleado )
         ,(
SELECT  STRING_AGG(DISTINCT e1.razon_contrata,' - ') AS contratas
FROM empleado AS empl1
INNER JOIN usuario AS us1
ON empl1.id_empleado = us1.id_empleado
INNER JOIN usuario_empresa_contrada AS uec1
ON us1.id_user = uec1.id_user
INNER JOIN contratas AS e1
ON uec1.ruc = e1.ruc_contrata AND uec1.tipo = 'CONTRATA'
WHERE uec1.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado )
GROUP BY  empl1.id_empleado )
FROM empleado AS empl; else RETURN QUERY

SELECT  emp.id_empleado
       ,emp.apellidos
       ,emp.cargo
       ,emp.celular
       ,emp.cip
       ,emp.correo_elect
       ,emp.direccion
       ,emp.estado
       ,emp.fecha_actualizacion
       ,emp.fecha_nacimiento
       ,emp.fecha_registro
       ,emp.nombres
       ,emp.num_documento
       ,emp.tel_fijo
       ,emp.tipo_doc
       ,emp.ubigeo
       ,emp.user_actualizacion
       ,emp.user_registro
       ,emp.sexo
       ,(
SELECT  STRING_AGG(DISTINCT e.razon_empresa,' - ') AS empresas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN empresas AS e
ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
WHERE uec.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
         ,(
SELECT  STRING_AGG(DISTINCT e.razon_contrata,' - ') AS contratas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN contratas AS e
ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
WHERE uec.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
FROM empleado AS emp
WHERE emp.id_empleado IN (
SELECT  distinct(empl.id_empleado)
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc IN (
SELECT  distinct(ue.ruc)
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name ) )
UNION
SELECT  e.id_empleado
       ,e.apellidos
       ,e.cargo
       ,e.celular
       ,e.cip
       ,e.correo_elect
       ,e.direccion
       ,e.estado
       ,e.fecha_actualizacion
       ,e.fecha_nacimiento
       ,e.fecha_registro
       ,e.nombres
       ,e.num_documento
       ,e.tel_fijo
       ,e.tipo_doc
       ,e.ubigeo
       ,e.user_actualizacion
       ,e.user_registro
       ,e.sexo
       ,(
SELECT  STRING_AGG(DISTINCT e.razon_empresa,' - ') AS empresas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN empresas AS e
ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
WHERE uec.ruc IN (
SELECT  DISTINCT ue.ruc
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name
AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
         ,(
SELECT  STRING_AGG(DISTINCT e.razon_contrata,' - ') AS contratas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN contratas AS e
ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
WHERE uec.ruc IN (
SELECT  DISTINCT ue.ruc
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name
AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
FROM empleado AS e
WHERE e.user_registro = user_name; end if; END; $BODY$; 

ALTER FUNCTION public.listado_empleado_por_username(text) OWNER TO developerhm;
----- COPIA SEGURIDAD -----------
-- FUNCTION: public.listado_empleado_por_username(text)
-- DROP FUNCTION IF EXISTS public.listado_empleado_por_username(text); 
CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(user_name text) RETURNS TABLE( id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying ) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $BODY$ DECLARE validar_empresa_hm BIGINT; BEGIN

SELECT  COUNT(emp.id_empleado) into validar_empresa_hm
FROM empleado AS emp
INNER JOIN usuario AS us
ON emp.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc = '20477167561'
AND us.username = user_name; IF(validar_empresa_hm > 0) THEN RETURN QUERY

SELECT  empl.id_empleado
       ,empl.apellidos
       ,empl.cargo
       ,empl.celular
       ,empl.cip
       ,empl.correo_elect
       ,empl.direccion
       ,empl.estado
       ,empl.fecha_actualizacion
       ,empl.fecha_nacimiento
       ,empl.fecha_registro
       ,empl.nombres
       ,empl.num_documento
       ,empl.tel_fijo
       ,empl.tipo_doc
       ,empl.ubigeo
       ,empl.user_actualizacion
       ,empl.user_registro
       ,empl.sexo
FROM empleado AS empl; else RETURN QUERY

SELECT  emp.id_empleado
       ,emp.apellidos
       ,emp.cargo
       ,emp.celular
       ,emp.cip
       ,emp.correo_elect
       ,emp.direccion
       ,emp.estado
       ,emp.fecha_actualizacion
       ,emp.fecha_nacimiento
       ,emp.fecha_registro
       ,emp.nombres
       ,emp.num_documento
       ,emp.tel_fijo
       ,emp.tipo_doc
       ,emp.ubigeo
       ,emp.user_actualizacion
       ,emp.user_registro
       ,emp.sexo
FROM empleado AS emp
WHERE emp.id_empleado IN (
SELECT  distinct(empl.id_empleado)
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc IN (
SELECT  distinct(ue.ruc)
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name ) )
UNION
SELECT  e.id_empleado
       ,e.apellidos
       ,e.cargo
       ,e.celular
       ,e.cip
       ,e.correo_elect
       ,e.direccion
       ,e.estado
       ,e.fecha_actualizacion
       ,e.fecha_nacimiento
       ,e.fecha_registro
       ,e.nombres
       ,e.num_documento
       ,e.tel_fijo
       ,e.tipo_doc
       ,e.ubigeo
       ,e.user_actualizacion
       ,e.user_registro
       ,e.sexo
FROM empleado AS e
WHERE e.user_registro = user_name; end if; END; $BODY$; 

ALTER FUNCTION public.listado_empleado_por_username(text) OWNER TO developerhm;