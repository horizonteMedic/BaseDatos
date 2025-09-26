

CREATE OR REPLACE FUNCTION eliminar_antecedentes_patologicos_quirurgicos(cod_ap_param integer)
  RETURNS text AS
$BODY$

	BEGIN

	IF EXISTS (SELECT 1 FROM antecedentes_patologicos_quirurgicos WHERE cod_ap = cod_ap_param) THEN
		DELETE FROM antecedentes_patologicos_quirurgicos apq WHERE apq.cod_ap = cod_ap_param;
	END IF;

	RETURN 'OK';

	END;

$BODY$
  LANGUAGE plpgsql;

  CREATE OR REPLACE FUNCTION registrar_antecedentes_patologicos_quirurgicos(
    cod_ap_param integer,
    hospital_operacion_param text,
    operacion_param text,
    dias_hospitalizado_param text,
    complicaciones_param text,
    fecha_param text)
  RETURNS void AS
$BODY$
BEGIN
    INSERT INTO antecedentes_patologicos_quirurgicos (
        cod_ap, hospital_operacion, operacion, dias_hospitalizado,
        complicaciones, fecha
    ) VALUES (
        cod_ap_param, hospital_operacion_param, operacion_param, dias_hospitalizado_param,
        complicaciones_param, fecha_param
    );
END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_reporte_antecedentes_patologicos(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, direccionpaciente_direccion_pa text, sexo_sexo_pa "char", fechanacimientopaciente_fecha_nacimiento_pa date, cargo_cargo_de text, area_area_o text, contrata_razon_contrata text, n_orden integer, empresa_razon_empresa text, edad_edad text, color integer, codigoantecedentespatologicos_cod_ap integer, fechaantecedentespatologicos_fecha_ap date, dniusuario_dni_user integer, alergias_chk1 boolean, amigdalitiscronica_chk2 boolean, arritmiascardiacas_chk3 boolean, asma_chk4 boolean, bocio_chk5 boolean, bronconeumonia_chk6 boolean, bronquitisarepeticion_chk7 boolean, cariesogingivitis_chk8 boolean, colecistitis_chk9 boolean, dermatitis_chk10 boolean, diabetes_chk11 boolean, disenteria_chk12 boolean, enfermedadescorazon_chk13 boolean, enfermedadesoculares_chk14 boolean, epilsepsiaoconvulsiones_chk15 boolean, faringitiscronica_chk16 boolean, fiebremalta_chk17 boolean, fiebretifoidea_chk18 boolean, fiebrereumatica_chk19 boolean, foruncolois_chk20 boolean, gastritiscronica_chk21 boolean, gonorrea_chk22 boolean, gota_chk23 boolean, hemorroides_chk24 boolean, hepatitis_chk25 boolean, hernias_chk26 boolean, hipertencionarterial_chk27 boolean, urinariasrepetidas_chk28 boolean, intoxicaciones_chk29 boolean, insuficienciacardiaca_chk30 boolean, insuficienciacoronariacronica_chk31 boolean, insuficienciarenalcronica_chk32 boolean, litiasisurinaria_chk33 boolean, meningitis_chk34 boolean, neuritis_chk35 boolean, otitismedia_chk36 boolean, presionaltaobaja_chk37 boolean, paludismoomalaria_chk38 boolean, parasitosisintestinal_chk39 boolean, paratiditis_chk40 boolean, pleuresia_chk41 boolean, plumbismo_chk42 boolean, poliomielitis_chk43 boolean, portadormarcapasos_chk44 boolean, protesiscardiacasvalvulares_chk45 boolean, resfriosfrecuentes_chk46 boolean, reumatismo_chk47 boolean, sarampion_chk48 boolean, sifilis_chk49 boolean, silicosis_chk50 boolean, sinusitiscronica_chk51 boolean, tosconvulsiva_chk52 boolean, transtornosnerviosos_chk53 boolean, traumatismoencefalocraneano_chk54 boolean, tuberculosis_chk55 boolean, tumoresquistes_chk56 boolean, ulcerapeptica_chk57 boolean, varicela_chk58 boolean, varices_chk59 boolean, varicocele_chk60 boolean, perdidamemoria_chk61 boolean, preocupacionesangustia_chk62 boolean, doloresarticulares_chk63 boolean, aumentodisminucionpeso_chk64 boolean, dolorcabeza_chk65 boolean, diarrea_chk66 boolean, agitacionejercicio_chk67 boolean, dolorocular_chk68 boolean, doloropresivotorax_chk69 boolean, hinchazonpiesomanos_chk70 boolean, estrenimiento_chk71 boolean, vomitosconsangre_chk72 boolean, sangradopororina_chk73 boolean, tosconsangre_chk74 boolean, coloracionamarrillapiel_chk75 boolean, indigestionfrecuente_chk76 boolean, insomnio_chk77 boolean, lumbalgiaodolorcintura_chk78 boolean, mareos_chk79 boolean, hecesnegras_chk80 boolean, orinacondolor_chk81 boolean, orinainvoluntaria_chk82 boolean, doloroido_chk83 boolean, secrecionesoido_chk84 boolean, palpitaciones_chk85 boolean, adormecimientos_chk86 boolean, pesadillasfrecuentes_chk87 boolean, doloresmusculares_chk88 boolean, toscronica_chk89 boolean, sangradoencias_chk90 boolean, drogasno_rbdrogasno boolean, drogassi_rbdrogassi boolean, licorno_rblicorno boolean, licorsi_rblicorsi boolean, fumarno_rbfumarno boolean, fumarsi_rbfumarsi boolean, drogasfrecuencia_txtdrogasfrecuencia text, drogastipo_txtdrogastipo text, licorfrecuencia_txtlicorfrecuencia text, licortipofrecuente_txtlicortipofrecuente text, numerocigarrillos_txtncigarrillos text, precisarcausasvarones_txtvcausas text, hijosvivosvarones_txtvhijosvivos text, hijosfallecidosvarones_txtvhijosfallecidos text, abortosparejasvarones_txtvnabortosparejas text, iniciomestruaciondamas_txtdiniciomestruacion text, iniciovidasexualdamas_txtdiniciovidasexual text, numeroparejassexactualidaddamas_txtdnumparejassexactualidad text, hijosvivosdamas_txtdhijosvivos text, hijosfallecidosdamas_txtdhijosfallecidos text, numerosdeabortosdamas_txtdnumerosdeabortos text, precisarcausasdamas_txtdcausas text, otrosdescripcionantecedentespatologicos_txtotrosap text, otrosdescripcionindicarenfermedades_txtotros1ap text, covid_chkcovid boolean, fechacovid_fechacovid date, covidlevel_chkcovidl boolean, covidmoderado_chkcovidm boolean, covidsevero_chkcovids boolean, dosisvacunas_txtdosis text, userregistro_user_registro text, otrostipoindicarenfermedades_txtotros text, otrosfrecuenciaindicarenfermedades_txtotrosfrecuencia text, otrossiindicarenfermedades_rbotrossi boolean, otrosnoindicarenfermedades_rbotrosno boolean, imaboro_ima boolean, acvboro_acv boolean, tbcboro_tbc boolean, vihboro_vih boolean, fobiasboro_fobias boolean, vertigosboro_vertigos boolean, tifoideaboro_tifoidea boolean, neoplasiasboro_neoplasias boolean, quemadurasboro_quemaduras boolean, discopatiasboro_discopatias boolean, columnaboro_columna boolean, enfermedadespsiquiatricasboro_enf_psiquiatricas boolean, enfermedadesreumaticasboro_enf_reumatica boolean, enfermedadespulmonaresboro_enf_pulmonares boolean, enfermedadespielboro_enf_piel boolean, tendinitisboro_tendinitis boolean, onicomicosisboro_onicomicosis boolean, fracturasboro_fracturas boolean, anemiaboro_anemia boolean, obesidadboro_obesidad boolean, dislipidemiaboro_dislipidemia boolean, intoxicacionesboro_intoxicaciones boolean, amputacionboro_amputacion boolean, sorderaboro_sordera boolean, especifiquetratamientoboro_especifique_detalleenfermedades text, alergiasalimentosboro_alergias_medic_alim boolean, alergiasalimentosespecifiqueboro_alergias_medic_alimdetall text, accidentetrabajoboro_accitrabajo boolean, accidentetrabajofechaboro_accit_fecha date, descansomedicoboro_accit_descanso boolean, descansomedicoespecifiqueboro_accit_descanso_detal text, enfermedadesprofesionalesboro_enfe_prof boolean, enfermedadesprofesionalesfechaboro_enfe_profecha date, enfermedadeslaboralescalificacionboro_enfe_lab_calif boolean, enfermedadeslaboralesespecifiqueboro_enfe_lab_califdetal text, antitetanicaboro_antitetanica boolean, fiebreamarillaboro_fiebre_amarilla boolean, influenzaboro_influenza boolean, hepatitisaboro_hepatitisa boolean, hepatitisbboro_hepatitisb boolean, gripeinfluenzaboro_gripe_influenza boolean, neumococoboro_neumococo boolean, rabiaboro_rabia boolean, papilomahumanoboro_papiloma_humano boolean, cantidosisboro_cantidosis boolean, medicamentoboro_medicamento boolean, medicamentoespecifiqueboro_medicamento_detal text, actividadfisicaboro_activ_fisic boolean, actividadfisicaespecifiqueboro_activ_fisic_detal text, padreespecifiqueboro_padre_detall text, madreespecifiqueboro_madre_detall text, hermanosespecifiqueboro_hermanos_detall text, hijosespecifiqueboro_hijos_detall text, esposconyespecifiqueboro_espos_cony_detall text, conadisespecifiqueboro_conadisdetalle text, etsboro_ets boolean, migranaboro_migrana boolean, tiempoincapacidadboro_timeincapacidad text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, cancerigenosanexo7c_chkcancerigenos boolean, metalesanexo7c_chkmetales boolean, vibracionesanexo7c_vibraciones boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, cargasanexo7c_chkcargas boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageograficaanexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, electricosanexo7c_electricos boolean, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, direccionsede text, sede text, nombresede text, namejasper text, esBoro boolean) AS
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
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
	    n.color,
	    ap.cod_ap,
	    ap.fecha_ap,
	ap.dni_user,
    ap.chk1,
    ap.chk2,
    ap.chk3,
    ap.chk4,
    ap.chk5,
    ap.chk6,
    ap.chk7,
    ap.chk8,
    ap.chk9,
    ap.chk10,
    ap.chk11,
    ap.chk12,
    ap.chk13,
    ap.chk14,
    ap.chk15,
    ap.chk16,
    ap.chk17,
    ap.chk18,
    ap.chk19,
    ap.chk20,
    ap.chk21,
    ap.chk22,
    ap.chk23,
    ap.chk24,
    ap.chk25,
    ap.chk26,
    ap.chk27,
    ap.chk28,
    ap.chk29,
    ap.chk30,
    ap.chk31,
    ap.chk32,
    ap.chk33,
    ap.chk34,
    ap.chk35,
    ap.chk36,
    ap.chk37,
    ap.chk38,
    ap.chk39,
    ap.chk40,
    ap.chk41,
    ap.chk42,
    ap.chk43,
    ap.chk44,
    ap.chk45,
    ap.chk46,
    ap.chk47,
    ap.chk48,
    ap.chk49,
    ap.chk50,
    ap.chk51,
    ap.chk52,
    ap.chk53,
    ap.chk54,
    ap.chk55,
    ap.chk56,
    ap.chk57,
    ap.chk58,
    ap.chk59,
    ap.chk60,
    ap.chk61,
    ap.chk62,
    ap.chk63,
    ap.chk64,
    ap.chk65,
    ap.chk66,
    ap.chk67,
    ap.chk68,
    ap.chk69,
    ap.chk70,
    ap.chk71,
    ap.chk72,
    ap.chk73,
    ap.chk74,
    ap.chk75,
    ap.chk76,
    ap.chk77,
    ap.chk78,
    ap.chk79,
    ap.chk80,
    ap.chk81,
    ap.chk82,
    ap.chk83,
    ap.chk84,
    ap.chk85,
    ap.chk86,
    ap.chk87,
    ap.chk88,
    ap.chk89,
    ap.chk90,
    ap.rbdrogasno,
    ap.rbdrogassi,
    ap.rblicorno,
    ap.rblicorsi,
    ap.rbfumarno,
    ap.rbfumarsi,
    ap.txtdrogasfrecuencia,
    ap.txtdrogastipo,
    ap.txtlicorfrecuencia,
    ap.txtlicortipofrecuente,
    ap.txtncigarrillos,
    ap.txtvcausas,
    ap.txtvhijosvivos,
    ap.txtvhijosfallecidos,
    ap.txtvnabortosparejas,
    ap.txtdiniciomestruacion,
    ap.txtdiniciovidasexual,
    ap.txtdnumparejassexactualidad,
    ap.txtdhijosvivos,
    ap.txtdhijosfallecidos,
    ap.txtdnumerosdeabortos,
    ap.txtdcausas,
    ap.txtotrosap,
    ap.txtotros1ap,
    ap.chkcovid,
    ap.fechacovid,
    ap.chkcovidl,
    ap.chkcovidm,
    ap.chkcovids,
    ap.txtdosis,
    ap.user_registro,
    ap.txtotros,
    ap.txtotrosfrecuencia,
    ap.rbotrossi,
    ap.rbotrosno,
    ap.ima,
    ap.acv,
    ap.tbc,
    ap.vih,
    ap.fobias,
    ap.vertigos,
    ap.tifoidea,
    ap.neoplasias,
    ap.quemaduras,
    ap.discopatias,
    ap.columna,
    ap.enf_psiquiatricas,
    ap.enf_reumatica,
    ap.enf_pulmonares,
    ap.enf_piel,
    ap.tendinitis,
    ap.onicomicosis,
    ap.fracturas,
    ap.anemia,
    ap.obesidad,
    ap.dislipidemia,
    ap.intoxicaciones,
    ap.amputacion,
    ap.sordera,
    ap.especifique_detalleenfermedades,
    ap.alergias_medic_alim,
    ap.alergias_medic_alimdetall,
    ap.accitrabajo,
    ap.accit_fecha,
    ap.accit_descanso,
    ap.accit_descanso_detal,
    ap.enfe_prof,
    ap.enfe_profecha,
    ap.enfe_lab_calif,
    ap.enfe_lab_califdetal,
    ap.antitetanica,
    ap.fiebre_amarilla,
    ap.influenza,
    ap.hepatitisa,
    ap.hepatitisb,
    ap.gripe_influenza,
    ap.neumococo,
    ap.rabia,
    ap.papiloma_humano,
    ap.cantidosis,
    ap.medicamento,
    ap.medicamento_detal,
    ap.activ_fisic,
    ap.activ_fisic_detal,
    ap.padre_detall,
    ap.madre_detall,
    ap.hermanos_detall,
    ap.hijos_detall,
    ap.espos_cony_detall,
    ap.conadisdetalle,
    ap.ets,
    ap.migrana,
    ap.timeincapacidad,
	    CASE 
		WHEN oft.txtdiagnostico IS not NULL
		    THEN UPPER(oft.txtdiagnostico) 
		ELSE UPPER(o.e_oculares) 
	    END AS e_oculares, o.e_oculares1,
	    CASE 
		WHEN oft.txtcercasincorregirod IS NOT NULL 
		    THEN oft.txtcercasincorregirod 
		ELSE o.v_cerca_s_od 
	    END AS v_cerca_s_od,
	    
	    CASE 
		WHEN oft.txtcercasincorregiroi IS NOT NULL 
		    THEN oft.txtcercasincorregiroi 
		ELSE o.v_cerca_s_oi 
	    END AS v_cerca_s_oi,
	    
	    CASE 
		WHEN oft.txtcercacorregidaod IS NOT NULL 
		    THEN oft.txtcercacorregidaod
		WHEN ol.v_cerca_c_od IS NULL 
		    THEN o.v_cerca_c_od
		ELSE ol.v_cerca_c_od 
	    END AS ODCC,
	    
	    CASE 
		WHEN oft.txtcercacorregidaoi IS NOT NULL 
		    THEN oft.txtcercacorregidaoi
		WHEN ol.v_cerca_c_oi IS NULL 
		    THEN o.v_cerca_c_oi
		ELSE ol.v_cerca_c_oi 
	    END AS OICC,
	    
	    CASE 
		WHEN oft.txtlejossincorregirod IS NOT NULL 
		    THEN oft.txtlejossincorregirod 
		ELSE o.v_lejos_s_od 
	    END AS v_lejos_s_od,
	    
	    CASE 
		WHEN oft.txtlejossincorregiroi IS NOT NULL 
		    THEN oft.txtlejossincorregiroi 
		ELSE o.v_lejos_s_oi 
	    END AS v_lejos_s_oi,
	    
	    CASE 
		WHEN oft.txtlejoscorregidaod IS NOT NULL 
		    THEN oft.txtlejoscorregidaod
		WHEN ol.v_lejos_c_od IS NULL 
		    THEN o.v_lejos_c_od 
		ELSE ol.v_lejos_c_od 
	    END AS ODLC,
	    
	    CASE 
		WHEN oft.txtlejoscorregidaoi IS NOT NULL 
		    THEN oft.txtlejoscorregidaoi
		WHEN ol.v_lejos_c_oi IS NULL 
		    THEN o.v_lejos_c_oi 
		ELSE ol.v_lejos_c_oi 
	    END AS OILC,
	    
	    CASE  
		WHEN oft.rbtecishihara_normal = 'TRUE'  
		    THEN 'NORMAL'
		WHEN oft.rbtecishihara_anormal = 'TRUE' 
		    THEN 'ANORMAL'
		WHEN ol.v_colores IS NULL 
		    THEN o.v_colores  
		ELSE ol.v_colores  
	    END AS VC,
	    
	    CASE  
		WHEN oft.txtbinocularsincorregir IS NOT NULL 
		    THEN oft.txtbinocularsincorregir
		WHEN ol.v_binocular IS NULL 
		    THEN o.v_binocular  
		ELSE ol.v_binocular  
	    END AS VB,
	    
	    CASE  
		WHEN oft.txtrp IS NOT NULL 
		    THEN oft.txtrp
		WHEN ol.r_pupilares IS NULL 
		    THEN o.r_pupilares
		ELSE ol.r_pupilares  
	    END AS RP,
	  a7.chkruido,
	  a7.chkpolvo,
	  a7.chkcancerigenos,
	  a7.chkmetales,
	  a7.vibraciones,
	  a7.chktemperatura,
	  a7.chkbiologicos,
	  a7.chkposturas,
	  a7.chkcargas,
	  a7.chkotros,
	  a7.altura_estructura,
	  a7.altura_geog,
	  a7.quimicos,
	  a7.electricos,
	  l.txtcocaina,
	  l.txtmarihuana,
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
	    obtener_name_jasper(p_norden, name_service),
	    CASE 
		    WHEN n.razon_empresa ILIKE '%MINERA BOROO MISQUICHILCA S.A.%'
		      OR n.razon_empresa ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		      OR n.razon_empresa ILIKE '%DEYFOR EIRL%'
		    THEN TRUE 
		    ELSE FALSE 
	    END AS esBoro
	FROM datos_paciente dp
	INNER JOIN n_orden_ocupacional n ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
	LEFT JOIN antecedentes_patologicos ap ON n.n_orden = ap.n_orden
	LEFT JOIN anexo7c AS a7 ON a7.n_orden = ap.n_orden
	LEFT JOIN lab_clinico l ON n.n_orden = l.n_orden
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql

;

  insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('antecedentes_patologicos','formulario de antecedentes patologicos',true,true,true,false,false);


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