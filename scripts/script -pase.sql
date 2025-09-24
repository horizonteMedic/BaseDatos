ALTER TABLE n_orden_ocupacional
  ADD COLUMN espacios_confinados BOOLEAN DEFAULT FALSE,
  ADD COLUMN t_marihuana BOOLEAN DEFAULT FALSE,
  ADD COLUMN t_cocaina BOOLEAN DEFAULT FALSE;

CREATE OR REPLACE FUNCTION backend_registro_historiaclinica_ocupacional(
    IN tipo_operacion_exp bigint,
    IN n_orden_exp bigint,
    IN cod_pa_exp bigint,
    IN razon_empresa_exp character varying,
    IN razon_contrata_exp character varying,
    IN nom_ex_exp character varying,
    IN altura_po_exp character varying,
    IN mineral_po_exp character varying,
    IN fecha_apertura_po_exp character varying,
    IN precio_po_exp character varying,
    IN estado_ex_exp character varying,
    IN nom_examen_exp character varying,
    IN cargo_de_exp character varying,
    IN area_o_exp character varying,
    IN n_medico_exp character varying,
    IN n_hora_exp character varying,
    IN tipo_pago_exp character varying,
    IN n_fisttest_exp boolean,
    IN n_psicosen_exp boolean,
    IN n_testaltura_exp boolean,
    IN grupo_san_exp character varying,
    IN grupo_factor_san_exp character varying,
    IN cod_clinica_exp character varying,
    IN visual_compl_exp boolean,
    IN trab_calientes_exp boolean,
    IN chk_covid1_exp boolean,
    IN chk_covid2_exp boolean,
    IN manip_alimentos_exp boolean,
    IN txtobserv1_exp character varying,
    IN txtobserv2_exp character varying,
    IN cod_sede_exp character varying,
    IN tipo_prueba_covid_exp character varying,
    IN tipo_prueba_exp character varying,
    IN nombre_hotel_exp character varying,
    IN protocolo_exp character varying,
    IN precio_adic_exp character varying,
    IN autoriza_exp character varying,
    IN n_operacion_exp character varying,
    IN herra_manuales_exp boolean,
    IN rxc_dorso_lumbar_exp boolean,
    IN rxc_lumbar_exp boolean,
    IN rxc_lumbosacra_exp boolean,
    IN rxc_plomos_exp boolean,
    IN mercurioo_exp boolean,
    IN user_registro_exp text,
    IN espacios_confinados_exp boolean,
    IN t_marihuana_exp boolean,
    IN t_cocaina_exp boolean)
  RETURNS TABLE(id_resp bigint, mensaje text) AS
$BODY$
	DECLARE codigo_sede_param integer;
	DECLARE n_orden_hm integer;
	Declare color_varia integer;

BEGIN
			Select id into codigo_sede_param from sede_multisucursal where codigo_sucursal=cod_sede_exp;
			SELECT (CASE WHEN max(color)>0 THEN max(color)+1 ELSE 1 END) into color_varia from n_orden_ocupacional where fecha_apertura_po = TO_DATE(fecha_apertura_po_exp, 'YYYY-MM-DD');
			if(tipo_operacion_exp=2) then
		update n_orden_ocupacional set cod_pa=cod_pa_exp,razon_empresa=razon_empresa_exp,razon_contrata=razon_contrata_exp,nom_ex=nom_ex_exp,
		altura_po=altura_po_exp,mineral_po=mineral_po_exp,fecha_apertura_po=TO_DATE(fecha_apertura_po_exp,'YYYY-MM-DD'),precio_po=CAST(precio_po_exp as money),
		estado_ex=estado_ex_exp,nom_examen=nom_examen_exp,cargo_de=cargo_de_exp,area_o=area_o_exp,n_medico=n_medico_exp,n_hora=CAST (n_hora_exp as time without time zone),
		tipo_pago=tipo_pago_exp,n_fisttest=n_fisttest_exp,n_psicosen=n_psicosen_exp,n_testaltura=n_testaltura_exp,gruposan=grupo_san_exp,grupofactorsan=grupo_factor_san_exp,
		cod_clinica=cod_clinica_exp,visual_compl=visual_compl_exp,trab_calientes=trab_calientes_exp,chkcovid1=chk_covid1_exp,chkcovid2=chk_covid2_exp,manip_alimentos=manip_alimentos_exp,
		txtobserv1=txtobserv1_exp,txtobserv2=txtobserv2_exp,cod_sede=codigo_sede_param,tipo_prueba_covid=tipo_prueba_covid_exp,tipoPrueba=tipo_prueba_exp,nombrehotel=nombre_hotel_exp,
		protocolo=protocolo_exp,precio_adic=CAST(precio_adic_exp AS money),autoriza=autoriza_exp,n_operacion=n_operacion_exp, herra_manuales=herra_manuales_exp, rxc_dorso_lumbar=rxc_dorso_lumbar_exp,
		 rxc_lumbar=rxc_lumbar_exp, rxc_lumbosacra=rxc_lumbosacra_exp, rxc_plomos=rxc_plomos_exp, mercurioo=mercurioo_exp, user_registro=user_registro_exp, espacios_confinados=espacios_confinados_exp, t_marihuana=t_marihuana_exp, t_cocaina=t_cocaina_exp where n_orden=n_orden_exp;
		RETURN QUERY 
		select CAST(1 AS bigint) as id_resp, CAST('El usuario se actualizo con exito!' AS TEXT) as mensaje;

		else
		
		INSERT INTO n_orden_ocupacional(cod_pa, razon_empresa, razon_contrata,
                        nom_ex, altura_po,mineral_po, fecha_apertura_po,precio_po,estado_ex,nom_examen,cargo_de,area_o,n_medico,n_hora,
                        tipo_pago,n_fisttest,n_psicosen,n_testaltura,color,gruposan,grupofactorsan,visual_compl,
                        trab_calientes,chkcovid1,chkcovid2,manip_alimentos, txtobserv1,txtobserv2,cod_sede,tipo_prueba_covid,tipoPrueba,nombrehotel,protocolo,
                        precio_adic,autoriza,n_operacion, herra_manuales, rxc_dorso_lumbar, rxc_lumbar, rxc_lumbosacra, rxc_plomos,mercurioo,user_registro, espacios_confinados, t_marihuana, t_cocaina)
		values (cod_pa_exp, razon_empresa_exp, razon_contrata_exp,nom_ex_exp, altura_po_exp, mineral_po_exp, TO_DATE(fecha_apertura_po_exp,'YYYY-MM-DD'), CAST(precio_po_exp as money), estado_ex_exp,
	nom_examen_exp, cargo_de_exp, area_o_exp,n_medico_exp, CAST (n_hora_exp as time without time zone), tipo_pago_exp,n_fisttest_exp, n_psicosen_exp,n_testaltura_exp, color_varia, grupo_san_exp,grupo_factor_san_exp,
	visual_compl_exp, trab_calientes_exp,chk_covid1_exp,chk_covid2_exp,manip_alimentos_exp,txtobserv1_exp,txtobserv2_exp,codigo_sede_param,tipo_prueba_covid_exp ,tipo_prueba_exp,nombre_hotel_exp,
	protocolo_exp,CAST(precio_adic_exp AS money),autoriza_exp,n_operacion_exp,herra_manuales_exp, rxc_dorso_lumbar_exp, rxc_lumbar_exp,rxc_lumbosacra_exp ,rxc_plomos_exp, mercurioo_exp, user_registro_exp, espacios_confinados_exp, t_marihuana_exp, t_cocaina_exp ) RETURNING n_orden into n_orden_hm;
                        PERFORM  spAgregarPE(n_orden_hm);
                        PERFORM  spagregarconta(n_orden_hm);
		RETURN QUERY 
		select CAST(n_orden_hm as bigint) as id_resp, CAST('El usuario se registro con exito!' AS TEXT) as mensaje;
		end if;

END; $BODY$
  LANGUAGE plpgsql

----------------------------------------
insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('anexo16a','formulario de anexo 16a',true,true,true,false,false);

CREATE OR REPLACE FUNCTION obtener_reporte_anexo16a(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(
dni_cod_pa integer,
nombres_nombres_pa text,
apellidos_apellidos_pa text,
direccionPaciente_direccion_pa text,
sexo_sexo_pa "char",
fechaNacimientoPaciente_fecha_nacimiento_pa date,
cargo_cargo_de text,
contrata_razon_contrata text,
norden_n_orden integer,
empresa_razon_empresa text,
edad_edad text,
direccionClinicaAnexo16a_direccion_clinica text,
fechaAnexo16a_fecha_anexo date,
nombreUsuario_nombre_user text,
apellidoUsuario_apellido_user text,
cmpUsuario_cmp_user text,

aptoAnexo16a_apto Boolean,
noAptoAnexo16a_no_apto Boolean,
cirujiaMayorRecienteNoAnexo16a_no1 Boolean,
cirujiaMayorRecienteSiAnexo16a_si1 Boolean,
desordenCoagulacionNoAnexo16a_no2 Boolean,
desordenCoagulacionSiAnexo16a_si2 Boolean,
diabetesMellitusNoAnexo16a_no3 Boolean,
diabetesMellitusSiAnexo16a_si3 Boolean,
hipertensionArterialNoAnexo16a_no4 Boolean,
hipertensionArterialSiAnexo16a_si4 Boolean,
embarazoNoAnexo16a_no5 Boolean,
embarazoSiAnexo16a_si5 Boolean,
furDescripcionAnexo16a_txtfur text,
problemaNeurologicoNoAnexo16a_no6 Boolean,
problemaNeurologicoSiAnexo16a_si6 Boolean,
infeccionRecienteNoAnexo16a_no7 Boolean,
infeccionRecienteSiAnexo16a_si7 Boolean,
obesidadMorbididadNoAnexo16a_no8 Boolean,
obesidadMorbididadSiAnexo16a_si8 Boolean,
problemasCardiacoNoAnexo16a_no9 Boolean,
problemasCardiacoSiAnexo16a_si9 Boolean,
problemasRespiratoriosNoAnexo16a_no10 Boolean,
problemasRespiratoriosSiAnexo16a_si10 Boolean,
problemasOftalmologicosNoAnexo16a_no11 Boolean,
problemasOftalmologicosSiAnexo16a_si11 Boolean,
problemasDigestivosNoAnexo16a_no12 Boolean,
problemasDigestivosSiAnexo16a_si12 Boolean,
apneaDelSuenoNoAnexo16a_no13 Boolean,
apneaDelSuenoSiAnexo16a_si13 Boolean,
otraCondicionMedicaNoAnexo16a_no14 Boolean,
otraCondicionMedicaSiAnexo16a_si14 Boolean,
alergiasNoAnexo16a_no15 Boolean,
alergiasSiAnexo16a_si15 Boolean,
usoMedicacionActualNoAnexo16a_no16 Boolean,
usoMedicacionActualSiAnexo16a_si16 Boolean,
medicacionActualAnexo16a_m_actual text,
frecuenciaCardiacaTriaje_f_cardiaca text,
sistolicaTriaje_sistolica text,
diastolicaTriaje_diastolica text,
frecuenciaRespiratoriaTriaje_f_respiratoria text,
imcTriaje_imc text,
saturacionOxigenoTriaje_sat_02 text,
pesoTriaje_peso text,
tallaTriaje_talla text,
temperaturaTriaje_temperatura text,
observacionesAnexo16a_observaciones text,
color integer,
hemoglobinaLaboratorioClinico_txthemoglobina text,
hematocritoLaboratorioClinico_txthematocrito text,
visionCercaSinCorregirOd_v_cerca_s_od text,
visionCercaSinCorregirOi_v_cerca_s_oi TEXT,
odccOftalmologia_odcc text,
oiccOftalmologia_oicc text,
visionLejosSinCorregirOd_v_lejos_s_od text,
visionLejosSinCorregirOi_v_lejos_s_oi text,
odlcOftalmologia_odlc text,
oiloOftalmologia_oilc text,
vcOftalmologia_vc text,
vbOftalmologia_vb text,
rpOftalmologia_rp text,
enfermedadesOcularesOftalmo_e_oculares text,
glucosaLaboratorioClinico_txtglucosabio text,
hallazgosInformeElectroCardiograma_hallazgo text,
direccionSede text,
sede text,
nombreSede text,
nameJasper text
  ) AS
$BODY$
BEGIN
    RETURN QUERY
	SELECT 
	    dp.cod_pa,
	    dp.nombres_pa,
	    dp.apellidos_pa,
	    dp.direccion_pa,
	    dp.sexo_pa,
	    dp.fecha_nacimiento_pa,
	    n.cargo_de,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
	    a16.direccion_clinica,
	    a16.fecha_anexo,
	    u.nombre_user,
	    u.apellido_user,
	    u.cmp_user,
	    a16.apto,
	    a16.no_apto,
	    a16.no1,
	    a16.si1,
	    a16.no2,
	    a16.si2,
	    a16.no3,
	    a16.si3,
	    a16.no4,
	    a16.si4,
	    a16.no5,
	    a16.si5,
	    a16.txtfur,
	    a16.no6,
	    a16.si6,
	    a16.no7,
	    a16.si7,
	    a16.no8,
	    a16.si8,
	    a16.no9,
	    a16.si9,
	    a16.no10,
	    a16.si10,
	    a16.no11,
	    a16.si11,
	    a16.no12,
	    a16.si12,
	    a16.no13,
	    a16.si13,
	    a16.no14,
	    a16.si14,
	    a16.no15,
	    a16.si15,
	    a16.no16,
	    a16.si16,
	    a16.m_actual,
	    t.f_cardiaca,
	    t.sistolica,
	    t.diastolica,
	    t.f_respiratoria,
	    t.imc,
	    t.sat_02,
	    t.peso,
	    t.talla,
	    t.temperatura,
	    a16.observaciones,
	    n.color,
	    l.txthemoglobina,
	    l.txthematocrito,
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
	    l.txtglucosabio,
	    i.hallazgo,
	    CASE n.cod_sede
		WHEN 4 THEN 'Av. Nicolas de Piérola N°1106 Urb. San Fernando'
		WHEN 3 THEN 'Av. Huancavelica N°2225 - Distrito El Tambo'
		WHEN 2 THEN 'Jr. Leoncio Prado N°786'
		WHEN 1 THEN 'Cl.Guillermo Prescott N°127 Urb. Sto. Dominguito'
		ELSE ' '
	    END AS direccionSede,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    CASE
		    WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
		    WHEN n.cod_sede = 1 THEN 'Trujillo'
		    WHEN n.cod_sede = 2 THEN 'Huamachuco'
		    WHEN n.cod_sede = 3 THEN 'Huancayo'
		    WHEN n.cod_sede = 4 THEN 'Trujillo'
	    END AS nombreSede,
	    obtener_name_jasper(p_norden, name_service)
	FROM datos_paciente dp
	INNER JOIN n_orden_ocupacional n
	    ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal sm 
	    ON n.cod_sede = sm.id
	INNER JOIN triaje t
	    ON n.n_orden = t.n_orden
	INNER JOIN anexo16a a16
	    ON t.n_orden = a16.n_orden
	INNER JOIN usuarios u
	    ON a16.dni_user = u.dni_user
	INNER JOIN lab_clinico l
	    ON n.n_orden = l.n_orden
	LEFT JOIN informe_electrocardiograma i
	    ON n.n_orden = i.n_orden
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	WHERE a16.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;


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





-- PG ADMIN 3

CREATE OR REPLACE FUNCTION listado_pacientes_protocolo_busqueda_filtros(
	razon_empresa_param text,razon_contrata_param text, name_protocolo_param text, fecha_inicio_param date, fecha_fin_param date)
    RETURNS TABLE(protocolos text, nombres text, razon_empresa text, razon_contrata text, tipoexamen text, fechaexamen date) 
    LANGUAGE 'plpgsql'
AS $BODY$
	
BEGIN

	    RETURN QUERY 
	select  n.protocolo,dp.nombres_pa || ' ' || dp.apellidos_pa as nombres,n.razon_empresa, n.razon_contrata,n.nom_examen as tipoExamen,n.fecha_apertura_po as fechaExamen   
	from n_orden_ocupacional as n inner join datos_paciente as dp on n.cod_pa=dp.cod_pa
	where n.razon_empresa=razon_empresa_param and n.fecha_apertura_po BETWEEN fecha_inicio_param AND fecha_fin_param;

END; 
$BODY$;