select n_orden from n_orden_ocupacional limit 1

SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM certificado_aptitud_medico_resumen WHERE n_orden = norden_param;



-- insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
-- values('evaluacion_psicologica_poderosa','formulario de evaluacion psicologica poderosa',false,false,true,false,false);



-----------------------------------------------------------------------------
--PGADMIN 4

--verificar el id porque no es autoincremental
insert into lista_parametros values (54, 'Acuerdos de pago')

--verificar el id porque no es autoincremental
insert into detalle_parametro values (49052, 'Credito', 54)
insert into detalle_parametro values (49053, 'No Credito', 54)


ALTER TABLE protocolo
RENAME COLUMN forma_pago TO acuerdo_pago;

alter table protocolo add column forma_pago TEXT

-- CREATE TABLE forma_pago(
-- 	forma_pago_id serial primary key,
-- 	nombre text not null,
-- 	anulado boolean,
-- 	usuario_registro TEXT,
--     fecha_registro DATE,
--     hora_registro TIME,
--     usuario_actualizacion TEXT,
--     fecha_actualizacion DATE,
--     hora_actualizacion TIME
-- )

CREATE TABLE protocolo_examen_adicional(
 	id_examen_adicional_protocolo serial primary key,
 	id_examen Integer not null,
	id_protocolo INTEGER NOT NULL,
	precio numeric(38,2),
 	estado boolean,
 	usuario_registro TEXT,
    fecha_registro DATE,
    hora_registro TIME,
    usuario_actualizacion TEXT,
    fecha_actualizacion DATE,
    hora_actualizacion TIME,
	CONSTRAINT fk_examen
        FOREIGN KEY (id_examen)
        REFERENCES examen (id_examen),

    CONSTRAINT fk_protocolo
        FOREIGN KEY (id_protocolo)
        REFERENCES protocolo (id_protocolo)
);


-- BUSQUEDA DE EXAMENES SEGUN PROTOCOLO
CREATE OR REPLACE FUNCTION listado_examenes_protocolos_paciente(
	protocolo_param text,historia_clinica_param integer)
    RETURNS TABLE(id_archivos bigint, nombre text,ruta text,valor boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	

BEGIN

	    RETURN QUERY 
select cast (1 as bigint),cast(tb1.nombre as text) as nombre, cast (tb2.ruta_Archivo as text)as ruta , ( case  when tb2.id_archivos is not null then  true else false end )as valor
FROM (
    SELECT exam.prefijo, exam.nombre
    FROM protocolo AS prot
    INNER JOIN protocolo_examenes AS prot_exam
        ON prot.id_protocolo = prot_exam.id_protocolo
    INNER JOIN examen AS exam
        ON prot_exam.id_examen = exam.id_examen
    WHERE prot.nombre = protocolo_param
      AND exam.prefijo IS NOT NULL
) as tb1
LEFT JOIN (
	select arch_Serv.id_archivos,arch_Serv.ruta_Archivo ,tip_Arch.nomenclatura 
	from archivos_servidores as arch_Serv 
	inner join tipo_archivo as tip_Arch 
	on arch_Serv.id_tipo_archivo=tip_Arch.id_tipo_archivo
	WHERE arch_Serv.orden=historia_clinica_param) 
	AS tb2 on tb1.prefijo =tb2.nomenclatura;

END; 
$BODY$;


-- PG ADMIN 3

CREATE OR REPLACE FUNCTION listado_pacientes_protocolo_busqueda_filtros(
	razon_empresa_param text,razon_contrata_param text, name_protocolo_param text, fecha_inicio_param date, fecha_fin_param date)
    RETURNS TABLE(protocolos text, nombres text,dni integer,n_orden integer, razon_empresa text, razon_contrata text, tipoexamen text, fechaexamen date) 
    LANGUAGE 'plpgsql'
AS $BODY$
	
BEGIN

	    RETURN QUERY 
	select  n.protocolo,dp.nombres_pa || ' ' || dp.apellidos_pa as nombres,n.cod_pa as dni,n.n_orden, n.razon_empresa, n.razon_contrata,n.nom_examen as tipoExamen,n.fecha_apertura_po as fechaExamen   
	from n_orden_ocupacional as n inner join datos_paciente as dp on n.cod_pa=dp.cod_pa
	where n.razon_empresa=razon_empresa_param and n.fecha_apertura_po BETWEEN fecha_inicio_param AND fecha_fin_param;

END; 
$BODY$;


------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(
	user_name text)
    RETURNS TABLE(id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying,
	empresas text, contratas text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	DECLARE validar_empresa_hm BIGINT;

BEGIN
	select count(emp.id_empleado) into validar_empresa_hm from empleado as emp inner join usuario as us on emp.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc='20477167561' and us.username=user_name;
		
	
	if(validar_empresa_hm>0) then
	RETURN QUERY 
		select empl.id_empleado, empl.apellidos , empl.cargo , empl.celular , empl.cip , empl.correo_elect, empl.direccion, empl.estado, 
		empl.fecha_actualizacion , empl.fecha_nacimiento , empl.fecha_registro , empl.nombres , empl.num_documento , 
		empl.tel_fijo, empl.tipo_doc, empl.ubigeo , empl.user_actualizacion, empl.user_registro,empl.sexo,
		(
			SELECT 
			    STRING_AGG(DISTINCT e1.razon_empresa, ' - ') AS empresas
			FROM empleado AS empl1
			INNER JOIN usuario AS us1 ON empl1.id_empleado = us1.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec1 ON us1.id_user = uec1.id_user
			INNER JOIN empresas AS e1 ON uec1.ruc = e1.ruc_empresa AND uec1.tipo = 'EMPRESA'
			WHERE uec1.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado
			)
			GROUP BY empl1.id_empleado
		),
		(
			SELECT 
			    STRING_AGG(DISTINCT e1.razon_contrata, ' - ') AS contratas
			FROM empleado AS empl1
			INNER JOIN usuario AS us1 ON empl1.id_empleado = us1.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec1 ON us1.id_user = uec1.id_user
			INNER JOIN contratas AS e1 ON uec1.ruc = e1.ruc_contrata AND uec1.tipo = 'CONTRATA'
			WHERE uec1.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado
			)
			GROUP BY empl1.id_empleado
		)
		from empleado as empl;
 	else
	    RETURN QUERY 
	
	select emp.id_empleado, emp.apellidos , emp.cargo , emp.celular , emp.cip , emp.correo_elect, emp.direccion, 
		emp.estado, emp.fecha_actualizacion, emp.fecha_nacimiento, emp.fecha_registro, emp.nombres, emp.num_documento, emp.tel_fijo, emp.tipo_doc, emp.ubigeo , emp.user_actualizacion, 
		emp.user_registro,emp.sexo,
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_empresa, ' - ') AS empresas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN empresas AS e ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		),
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_contrata, ' - ') AS contratas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN contratas AS e ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		)
		 from empleado as emp where emp.id_empleado in (select distinct(empl.id_empleado) from empleado as empl inner join usuario as us on empl.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc in (select distinct(ue.ruc) from usuario_empresa_contrada as ue inner join usuario as u on ue.id_user=u.id_user where u.username=user_name))
	union
	select e.id_empleado, e.apellidos , e.cargo , e.celular , e.cip , e.correo_elect, e.direccion, e.estado, e.fecha_actualizacion , e.fecha_nacimiento , 
		e.fecha_registro , e.nombres , e.num_documento , e.tel_fijo, e.tipo_doc, e.ubigeo , e.user_actualizacion, 
		e.user_registro,e.sexo,
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_empresa, ' - ') AS empresas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN empresas AS e ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		),
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_contrata, ' - ') AS contratas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN contratas AS e ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		)
		from empleado as e where e.user_registro=user_name;
	end if;

END; 
$BODY$;

ALTER FUNCTION public.listado_empleado_por_username(text)
    OWNER TO developerhm;


----- COPIA SEGURIDAD -----------
-- FUNCTION: public.listado_empleado_por_username(text)

-- DROP FUNCTION IF EXISTS public.listado_empleado_por_username(text);

CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(
	user_name text)
    RETURNS TABLE(id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	DECLARE validar_empresa_hm BIGINT;

BEGIN
	select count(emp.id_empleado) into validar_empresa_hm from empleado as emp inner join usuario as us on emp.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc='20477167561' and us.username=user_name;
		
	
	if(validar_empresa_hm>0) then
	RETURN QUERY 
		select empl.id_empleado, empl.apellidos , empl.cargo , empl.celular , empl.cip , empl.correo_elect, empl.direccion, empl.estado, 
		empl.fecha_actualizacion , empl.fecha_nacimiento , empl.fecha_registro , empl.nombres , empl.num_documento , 
		empl.tel_fijo, empl.tipo_doc, empl.ubigeo , empl.user_actualizacion, empl.user_registro,empl.sexo
		from empleado as empl;
 	else
	    RETURN QUERY 
	
	select emp.id_empleado, emp.apellidos , emp.cargo , emp.celular , emp.cip , emp.correo_elect, emp.direccion, 
		emp.estado, emp.fecha_actualizacion, emp.fecha_nacimiento, emp.fecha_registro, emp.nombres, emp.num_documento, emp.tel_fijo, emp.tipo_doc, emp.ubigeo , emp.user_actualizacion, 
		emp.user_registro,emp.sexo
		 from empleado as emp where emp.id_empleado in (select distinct(empl.id_empleado) from empleado as empl inner join usuario as us on empl.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc in (select distinct(ue.ruc) from usuario_empresa_contrada as ue inner join usuario as u on ue.id_user=u.id_user where u.username=user_name))
	union
	select e.id_empleado, e.apellidos , e.cargo , e.celular , e.cip , e.correo_elect, e.direccion, e.estado, e.fecha_actualizacion , e.fecha_nacimiento , 
		e.fecha_registro , e.nombres , e.num_documento , e.tel_fijo, e.tipo_doc, e.ubigeo , e.user_actualizacion, 
		e.user_registro,e.sexo  from empleado as e where e.user_registro=user_name;
	end if;

END; 
$BODY$;

ALTER FUNCTION public.listado_empleado_por_username(text)
    OWNER TO developerhm;
