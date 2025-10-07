select n_orden from n_orden_ocupacional limit 1

CREATE OR REPLACE FUNCTION obtener_reporte_constancia_certificado_medico_ocupacional(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, 
  ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, 
  codigoclinica text, edadpaciente text, observacionesfichamedica text, fechadesde date, nombremedico text, apto boolean, aptoconrestriccion boolean, noapto boolean, horasalida time without time zone, fechahasta date,
  conclusiones text, usuarioRegistro text,
hemoglobina_txthemoglobina text, hematocritolabclinico_txthematocrito text, vsglabclinico_txtvsg text, leucocitoSematologiaLabClinico text, glucosalabclinico_txtglucosabio text, 
creatininalabclinico_txtcreatininabio text, densidadLabClinico_txtdensidadef text, aspectoLabClinico_txtaspectoef text, cocainaLabClinico_txtcocaina text,
marihuanaLabClinico_txtmarihuana text, tallaTriaje text, pesoTriaje text, bacteriaLabClinico_txtbacteriassu text,
grupoFactor text,
visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, 
oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, 
oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, 
nombresede text, sede text, color integer, namejasper text) AS

$BODY$
BEGIN
    RETURN QUERY
    SELECT 
	    d.cod_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    d.direccion_pa,
	    d.sexo_pa,
	    d.fecha_nacimiento_pa,
	    d.ocupacion_pa,
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    n.nom_examen,
	    n.cod_clinica,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
	    txtobservacionesfm,
	    apt.fecha,
	    apt.nom_medico,
	    CASE WHEN apt.chkapto IS NULL THEN apm.chkapto ELSE apt.chkapto END,
	    CASE WHEN apt.chkapto_restriccion IS NULL THEN apm.chkapto_restriccion ELSE apt.chkapto_restriccion END,
	    CASE WHEN apt.chkno_apto IS NULL THEN apm.chkno_apto ELSE apt.chkno_apto END,
	    apt.horasalida,
	    apt.fecha_hasta,
	    apt.txtexamenes,
	    apt.user_registro,
    l.txthemoglobina,
    l.txthematocrito,
    l.txtvsg,
    l.txtleucocitosematologia,
    l.txtglucosabio,
    l.txtcreatininabio,
    l.txtdensidadef,
    l.txtaspectoef,
    l.txtcocaina,
    l.txtmarihuana,
    t.talla,
    t.peso,
    l.txtbacteriassu,
    CASE 
        WHEN l.chko = 'TRUE' THEN 'O'
        WHEN l.chka = 'TRUE' THEN 'A'
        WHEN l.chkb = 'TRUE' THEN 'B'
        WHEN l.chkab = 'TRUE' THEN 'AB'
        ELSE '.'
    END || '' ||
    CASE 
        WHEN l.rbrhpositivo = 'TRUE' THEN '+' 
        WHEN l.rbrhnegativo = 'TRUE' THEN '-' 
    END AS Grupofactor,
--     f.n_orden AS audiologia,
--     a.n_orden AS espirometria,
--     o.n_orden AS oftalmologia,
--     p.n_orden AS rayosx,
--     od.n_orden AS odontologia,
--     l.n_orden AS laboratorio,
--     i.n_orden AS psicologia,
--     e.n_orden AS electrocardiograma,
--     t.n_orden AS triaje,
--     c.n_orden AS anexo7c,
--     cma.n_orden AS cerificadoAltura,
--     au.n_orden AS audiometria,
--     bc.n_orden AS conduccion,
--     ap.n_orden AS antecedentesp,
--     ur.n_orden AS usorespiradores,
--     oi.n_orden AS oit,
--     cn.n_orden AS cuestionarionordico,
--     fs.n_orden AS fichasas,
--     bca.n_orden AS b_certiAltura,
    CASE 
        WHEN oft.txtcercasincorregirod IS NOT NULL THEN oft.txtcercasincorregirod 
        ELSE o.v_cerca_s_od 
    END AS v_cerca_s_od,
    
    CASE 
        WHEN oft.txtcercasincorregiroi IS NOT NULL THEN oft.txtcercasincorregiroi 
        ELSE o.v_cerca_s_oi 
    END AS v_cerca_s_oi,
    
    CASE 
        WHEN oft.txtcercacorregidaod IS NOT NULL THEN oft.txtcercacorregidaod 
        WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od 
        ELSE ol.v_cerca_c_od 
    END AS ODCC,
    
    CASE 
        WHEN oft.txtcercacorregidaoi IS NOT NULL THEN oft.txtcercacorregidaoi 
        WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi 
        ELSE ol.v_cerca_c_oi 
    END AS OICC,
    
    CASE 
        WHEN oft.txtlejossincorregirod IS NOT NULL THEN oft.txtlejossincorregirod 
        ELSE o.v_lejos_s_od 
    END AS v_lejos_s_od,
    
    CASE 
        WHEN oft.txtlejossincorregiroi IS NOT NULL THEN oft.txtlejossincorregiroi 
        ELSE o.v_lejos_s_oi 
    END AS v_lejos_s_oi,
    
    CASE 
        WHEN oft.txtlejoscorregidaod IS NOT NULL THEN oft.txtlejoscorregidaod 
        WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od 
        ELSE ol.v_lejos_c_od 
    END AS ODLC,
    
    CASE 
        WHEN oft.txtlejoscorregidaoi IS NOT NULL THEN oft.txtlejoscorregidaoi 
        WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi 
        ELSE ol.v_lejos_c_oi 
    END AS OILC,
    
    CASE 
        WHEN oft.rbtecishihara_normal = 'TRUE' THEN 'NORMAL' 
        WHEN oft.rbtecishihara_anormal = 'TRUE' THEN 'ANORMAL' 
        WHEN ol.v_colores IS NULL THEN o.v_colores 
        ELSE ol.v_colores 
    END AS VC,
    
    CASE 
        WHEN oft.txtbinocularsincorregir IS NOT NULL THEN oft.txtbinocularsincorregir 
        WHEN ol.v_binocular IS NULL THEN o.v_binocular 
        ELSE ol.v_binocular 
    END AS VB,
    
    CASE 
        WHEN oft.txtrp IS NOT NULL THEN oft.txtrp 
        WHEN ol.r_pupilares IS NULL THEN o.r_pupilares 
        ELSE ol.r_pupilares 
    END AS RP,
    
    CASE 
        WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico 
        ELSE o.e_oculares 
    END AS e_oculares,
	    CASE 
		WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' 
		    THEN 'Huamachuco'
		ELSE (
		    SELECT nombre_sede 
		    FROM sede 
		    WHERE cod_sede = n.cod_sede
		)
	    END AS nombre_sede,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    n.color,
	    obtener_name_jasper(p_norden, name_service)
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	LEFT JOIN certificado_aptitud_medico_resumen AS apt 
	    ON apt.n_orden = n.n_orden
	LEFT JOIN certificado_aptitud_medico_ocupacional AS apm
	    ON apm.n_orden = n.n_orden
	LEFT JOIN ficha_audiologica AS f 
	    ON f.n_orden = n.n_orden
	LEFT JOIN informe_electrocardiograma AS e 
	    ON e.n_orden = n.n_orden
	LEFT JOIN funcion_abs AS a 
	    ON a.n_orden = n.n_orden
	LEFT JOIN oftalmologia AS o 
	    ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol 
	    ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft 
	    ON n.n_orden = oft.n_orden
	LEFT JOIN perimetro_toracico AS p 
	    ON p.n_orden = n.n_orden
	LEFT JOIN odontograma AS od 
	    ON od.n_orden = n.n_orden
	LEFT JOIN informe_psicologico AS i 
	    ON i.n_orden = n.n_orden
	LEFT JOIN lab_clinico AS l 
	    ON l.n_orden = n.n_orden
	LEFT JOIN triaje AS t 
	    ON t.n_orden = n.n_orden
	LEFT JOIN anexo7c AS c 
	    ON c.n_orden = n.n_orden
	LEFT JOIN certificacion_medica_altura AS cma 
	    ON cma.n_orden = n.n_orden
	LEFT JOIN b_certificado_altura AS bca 
	    ON bca.n_orden = n.n_orden
	LEFT JOIN audiometria_po AS au 
	    ON au.n_orden = n.n_orden
	LEFT JOIN b_certificado_conduccion AS bc 
	    ON bc.n_orden = n.n_orden
	LEFT JOIN antecedentes_patologicos AS ap 
	    ON ap.n_orden = n.n_orden
	LEFT JOIN b_uso_respiradores AS ur 
	    ON ur.n_orden = n.n_orden
	LEFT JOIN cuestionario_nordico AS cn 
	    ON cn.n_orden = n.n_orden
	LEFT JOIN ficha_sas AS fs 
	    ON fs.n_orden = n.n_orden
	LEFT JOIN oit AS oi 
	    ON oi.n_orden = n.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

  insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('certificado_aptitud_medico_resumen','formulario de certificado aptitud medico ocupacional',true,true,true,false,false);


-----------------------------------------------------------------------------
--PGADMIN 4

CREATE TABLE area_secuencia (
    prefijo VARCHAR(10) PRIMARY KEY,
    ultimo_numero INTEGER NOT NULL DEFAULT 0
);

create table area (
	id_area SERIAL PRIMARY KEY,
	prefijo VARCHAR(10) NOT NULL,
	codigo VARCHAR(15),
	descripcion TEXT,
	estado BOOLEAN NOT NULL
);

create table examen (
	id_examen SERIAL PRIMARY KEY,
	id_area INTEGER NOT NULL,
	orden INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	descripcion TEXT,
	estado BOOLEAN,
	precio_referencial NUMERIC(10,2),
	FOREIGN KEY (id_area) REFERENCES area(id_area)
);

ALTER TABLE examen
ADD COLUMN prefijo VARCHAR(50);

create table protocolo (
	id_protocolo SERIAL PRIMARY KEY,
	nombre TEXT NOT NULL,
	descripcion TEXT,
	precio INTEGER,
	estado BOOLEAN NOT NULL
)

create table protocolo_examenes (
	id_protocolo_examen SERIAL PRIMARY KEY,
	id_protocolo INTEGER NOT NULL,
	id_examen INTEGER NOT NULL,
	precio NUMERIC(10,2),
	estado BOOLEAN NOT NULL,
	orden INTEGER,
	FOREIGN KEY (id_protocolo) REFERENCES protocolo(id_protocolo),
	FOREIGN KEY (id_examen) REFERENCES examen(id_examen)
)

create table protocolo_empresa (
	id_protocolo_empresa SERIAL PRIMARY KEY,
	id_protocolo INTEGER NOT NULL,
	ruc_empresa TEXT NOT NULL,
	estado BOOLEAN NOT NULL,
	FOREIGN KEY (id_protocolo) REFERENCES protocolo(id_protocolo)
)

create table sub_examen (
	id_sub_examen SERIAL PRIMARY KEY,
	id_examen INTEGER NOT NULL,
	descripcion TEXT,
	prefijo TEXT,
	precio NUMERIC(10,2),
	estado BOOLEAN DEFAULT 'true',
	FOREIGN KEY (id_examen) REFERENCES examen(id_examen)
)

create table protocolo_sub_examenes (
	id_protocolo_sub_examen SERIAL PRIMARY KEY,
	id_protocolo INTEGER NOT NULL,
	id_sub_examen INTEGER NOT NULL,
	estado BOOLEAN NOT NULL,
	FOREIGN KEY (id_protocolo) REFERENCES protocolo(id_protocolo),
	FOREIGN KEY (id_sub_examen) REFERENCES sub_examen(id_sub_examen)
)


-- Función para generar el código de área
CREATE OR REPLACE FUNCTION generar_codigo_area()
RETURNS TRIGGER AS $$
DECLARE
    nuevo_numero INTEGER;
BEGIN
    -- Se actualiza el contador para el prefijo
    UPDATE area_secuencia
    SET ultimo_numero = ultimo_numero + 1
    WHERE prefijo = NEW.prefijo
    RETURNING ultimo_numero INTO nuevo_numero;

    -- Si no existe el prefijo en la tabla de secuencias, lo insertamos
    IF NOT FOUND THEN
        INSERT INTO area_secuencia (prefijo, ultimo_numero)
        VALUES (NEW.prefijo, 1)
        RETURNING ultimo_numero INTO nuevo_numero;
    END IF;

    -- Generamos el código con el prefijo y el número en 3 dígitos
    NEW.codigo := NEW.prefijo || LPAD(nuevo_numero::TEXT, 3, '0');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_codigo_area
BEFORE INSERT ON area
FOR EACH ROW
EXECUTE FUNCTION generar_codigo_area();


-- Función para calcular el orden
CREATE OR REPLACE FUNCTION set_orden_examen()
RETURNS TRIGGER AS $$
DECLARE
    max_orden INTEGER;
BEGIN
    -- Buscar el máximo orden dentro del área considerando solo los activos
    SELECT COALESCE(MAX(orden), 0)
    INTO max_orden
    FROM examen
    WHERE id_area = NEW.id_area AND estado = TRUE;

    -- Asignar el nuevo orden
    NEW.orden := max_orden + 1;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que llama a la función antes de insertar
CREATE TRIGGER trigger_set_orden_examen
BEFORE INSERT ON examen
FOR EACH ROW
EXECUTE FUNCTION set_orden_examen();


-- Función para calcular el orden
CREATE OR REPLACE FUNCTION set_orden_protocolo_examenes()
RETURNS TRIGGER AS $$
DECLARE
    max_orden INTEGER;
BEGIN
    -- Buscar el máximo orden dentro del área considerando solo los activos
    SELECT COALESCE(MAX(orden), 0)
    INTO max_orden
    FROM protocolo_examenes
    WHERE id_protocolo = NEW.id_protocolo AND estado = TRUE;

    -- Asignar el nuevo orden
    NEW.orden := max_orden + 1;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que llama a la función antes de insertar
CREATE TRIGGER trigger_set_orden_protocolo_examenes
BEFORE INSERT ON protocolo_examenes
FOR EACH ROW
EXECUTE FUNCTION set_orden_protocolo_examenes();

-- LISTADO DE PROTOCOLO POR FILTROS, V01



CREATE OR REPLACE FUNCTION listado_protocolo_busqueda_filtros(
	user_name_param text,razon_empre_param text, razon_emp_cont text)
    RETURNS TABLE(id_resp bigint, mensaje text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	

BEGIN

	    RETURN QUERY 
SELECT DISTINCT 
       CAST(prot.id_protocolo AS bigint) AS id_resp,
       prot.nombre as mensaje
FROM protocolo AS prot
INNER JOIN protocolo_empresa AS prot_emp 
    ON prot.id_protocolo = prot_emp.id_protocolo
INNER JOIN usuario_empresa_contrada AS user_prot_empcont  -- corregí el nombre
    ON prot_emp.ruc_empresa = user_prot_empcont.ruc
INNER JOIN usuario AS us 
    ON user_prot_empcont.id_user = us.id_user
WHERE us.username = user_name_param;

END; 
$BODY$;


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
