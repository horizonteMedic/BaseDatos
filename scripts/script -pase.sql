SELECT  n_orden
FROM n_orden_ocupacional
LIMIT 1;






DROP FUNCTION obtener_reporte_anexo16(integer, text);

ALTER TABLE trastornos_personalidad add column usuario_firma text

ALTER TABLE infor_conductores add column usuario_firma text;

ALTER TABLE alto_riesgo add column usuario_firma text;

ALTER TABLE especificos add column usuario_firma text;

ALTER TABLE cuestionario_berlin add column usuario_firma text;

ALTER TABLE cuestionario_berlin ADD COLUMN fecha_registro DATE;

ALTER TABLE exam_complementarios add column usuario_firma text;

ALTER TABLE exam_complementarios add column fecha_registro date;

CREATE TABLE cuadradorvigia ( n_orden integer PRIMARY KEY REFERENCES n_orden_ocupacional(n_orden), t_riesgo_electrico text, t_tareas_altura text, t_espacios_confinados text, manejo_herramientas text, foda_for_opor text, foda_amen_debi text, observacion text, recomenda text, cumple_perfil boolean, user_registro text, usuario_firma text, fecha_registro date DEFAULT CURRENT_DATE );

CREATE OR REPLACE FUNCTION obtener_reporte_cuadrador_vigia(p_norden integer, name_service text) RETURNS TABLE( cod_pa integer, nombre text, fecha_nacimiento_pa date, nivel_est_pa text, fec_nac text, n_orden integer, razon_empresa text, cargo_de text, fecha_apertura_po date
-- Nombres reales de la tabla 
, t_riesgo_electrico text, t_tareas_altura text, t_espacios_confinados text, manejo_herramientas text, foda_for_opor text, foda_amen_debi text, observacion text, recomenda text, cumple_perfil boolean, user_registro text, usuario_firma text, fecha_registro date, color integer, nombre_sede text, sede text, namejasper text ) AS $$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,(d.nombres_pa || ' ' || d.apellidos_pa)::text
       ,d.fecha_nacimiento_pa
       ,d.nivel_est_pa::text
       ,CAST(obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT)
       ,n.n_orden
       ,n.razon_empresa
       ,n.cargo_de
       ,n.fecha_apertura_po
       ,ip.t_riesgo_electrico
       ,ip.t_tareas_altura
       ,ip.t_espacios_confinados
       ,ip.manejo_herramientas
       ,ip.foda_for_opor
       ,ip.foda_amen_debi
       ,ip.observacion
       ,ip.recomenda
       ,ip.cumple_perfil
       ,ip.user_registro
       ,ip.usuario_firma
       ,ip.fecha_registro
       ,n.color
       ,(
SELECT  s.nombre_sede
FROM sede s
WHERE s.cod_sede = n.cod_sede)::text, (
SELECT  CAST(sm.descripcion AS TEXT)
FROM sede_multisucursal sm
WHERE sm.id = n.cod_sede), obtener_name_jasper(p_norden, name_service)::text
FROM datos_paciente d
INNER JOIN n_orden_ocupacional n
ON d.cod_pa = n.cod_pa
INNER JOIN cuadradorvigia ip
ON ip.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $$ LANGUAGE plpgsql;
INSERT INTO config_general_service_digital ( name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic ) values( 'cuadradorvigia', 'Formulario de Informe Psicologico Cuadrador Vigia', false, false, true, false, false );

CREATE TABLE bombaelectrica ( n_orden integer NOT NULL PRIMARY KEY CONSTRAINT fk_bombaelectrica_norden REFERENCES n_orden_ocupacional(n_orden)
ON UPDATE CASCADE
ON
DELETE CASCADE,
-- Campos específicos de la evaluación 
 t_riesgo_electrico text, t_tareas_altura text, t_espacios_confinados text, manejo_herramientas text, foda_for_opor text, foda_amen_debi text, observacion text, recomenda text, cumple_perfil boolean, user_registro text, usuario_firma text, fecha_registro date DEFAULT CURRENT_DATE );

CREATE OR REPLACE FUNCTION obtener_reporte_bomba_electrica(p_norden integer, name_service text) RETURNS TABLE( dnipaciente integer, nombres text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, edadpaciente text, norden integer, empresa text, cargopaciente text, areapaciente text, t_riesgo_electrico text, t_tareas_altura text, t_espacios_confinados text, manejo_herramientas text, foda_for_opor text, foda_amen_debi text, observacion text, recomenda text, cumple_perfil boolean, user_registro text, usuario_firma text, fecha_registro date, color integer, nombrespede text, sede text, namejasper text ) AS $$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,d.nombres_pa::text
       ,d.apellidos_pa::text
       ,d.direccion_pa::text
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,CAST(obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT)
       ,n.n_orden
       ,n.razon_empresa
       ,n.cargo_de
       ,n.area_o
       ,b.t_riesgo_electrico
       ,b.t_tareas_altura
       ,b.t_espacios_confinados
       ,b.manejo_herramientas
       ,b.foda_for_opor
       ,b.foda_amen_debi
       ,b.observacion
       ,b.recomenda
       ,b.cumple_perfil
       ,b.user_registro
       ,b.usuario_firma
       ,b.fecha_registro
       ,n.color
       ,(
SELECT  s.nombre_sede
FROM sede s
WHERE s.cod_sede = n.cod_sede)::text AS nombrespede, (
SELECT  CAST(sm.descripcion AS TEXT)
FROM sede_multisucursal sm
WHERE sm.id = n.cod_sede) AS sede, obtener_name_jasper(p_norden, name_service)::text
FROM datos_paciente d
INNER JOIN n_orden_ocupacional n
ON d.cod_pa = n.cod_pa
INNER JOIN bombaelectrica b
ON b.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $$ LANGUAGE plpgsql;

CREATE TABLE psi_brigadistas ( n_orden integer NOT NULL PRIMARY KEY CONSTRAINT fk_psi_brigadistas_norden REFERENCES n_orden_ocupacional(n_orden)
ON UPDATE CASCADE
ON
DELETE CASCADE, afron_tdd text, estilo_conflicto text, afron_sit_riesgo text, level_ansiedad text, foda_for_opor text, foda_amen_debi text, observacion text, recomenda text, cumple_perfil boolean -- CAMPOS DE AUDITORÍA Y FIRMA AGREGADOS 
 , user_registro text, usuario_firma text, fecha_registro date DEFAULT CURRENT_DATE );

CREATE OR REPLACE FUNCTION obtener_reporte_brigadistas(IN p_norden integer, IN name_service text) RETURNS TABLE(
-- Datos Paciente (Alineados al Jasper) 
 cod_pa integer, nombre text, fecha_nacimiento_pa date, n_orden integer, razon_empresa text, cargo_de text, nivel_est_pa text, fecha_apertura_po date, fec_nac text -- Datos Brigadista (ip.*) 
 , afron_tdd text, estilo_conflicto text, afron_sit_riesgo text, level_ansiedad text, foda_for_opor text, foda_amen_debi text, observacion text, recomenda text, cumple_perfil boolean, user_registro text, fecha_registro date, usuario_firma text -- Gestión y Sede 
 , color integer, nombre_sede text, sede text, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,(d.nombres_pa || ' ' || d.apellidos_pa)::text                    AS nombre
       ,d.fecha_nacimiento_pa
       ,n.n_orden
       ,n.razon_empresa
       ,n.cargo_de
       ,d.nivel_est_pa
       ,n.fecha_apertura_po
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT ) AS fec_nac -- Campos de psi_brigadistas 
       ,ip.afron_tdd
       ,ip.estilo_conflicto
       ,ip.afron_sit_riesgo
       ,ip.level_ansiedad
       ,ip.foda_for_opor
       ,ip.foda_amen_debi
       ,ip.observacion
       ,ip.recomenda
       ,ip.cumple_perfil
       ,ip.user_registro
       ,ip.fecha_registro
       ,ip.usuario_firma -- Sede y Jasper 
       ,n.color
       ,(
SELECT  s.nombre_sede
FROM sede s
WHERE s.cod_sede = n.cod_sede )::text AS nombre_sede, (
SELECT  CAST(sm.descripcion AS TEXT)
FROM sede_multisucursal sm
WHERE sm.id = n.cod_sede ) AS sede, obtener_name_jasper(p_norden, name_service)::text AS namejasper
FROM datos_paciente AS d
INNER JOIN n_orden_ocupacional AS n
ON d.cod_pa = n.cod_pa
INNER JOIN psi_brigadistas AS ip
ON ip.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql VOLATILE;
INSERT INTO config_general_service_digital ( name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic ) values( 'psi_brigadistas', 'Formulario de Informe de Brigadistas', false, false, true, false, false );
INSERT INTO config_general_service_digital ( name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic ) values( 'exam_complementarios', 'Formulario para Cuestionario de Examen Complementarios', false, false, true, false, false );

CREATE OR REPLACE FUNCTION obtener_reporte_examen_complementario(IN p_norden integer, IN name_service text) RETURNS TABLE(
-- PACIENTE 
 dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, edadpaciente text -- ORDEN / EMPRESA 
 , norden integer, empresa text, cargopaciente text, areapaciente text, contrata text, codigoclinica text, tipoexamen text, fecha_apertura_po date -- RESULTADOS (EXAM_COMPLEMENTARIOS) 
 , level_autoconciencia text, level_autoconfianza text, level_autorregula text, level_motiva text, level_empatia text, level_compt_social text, foda_for_opor text, foda_amen_debi text, observacion text, recomenda text, cumple_perfil boolean -- AUDITORÍA Y FIRMA 
 , user_registro text, fecha_registro date, usuario_firma text -- GESTIÓN Y SEDE (Corregido 'nombrespede' a 'nombresede') 
 , nombresede text, sede text, color integer, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,d.nombres_pa
       ,d.apellidos_pa
       ,d.direccion_pa
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,d.ocupacion_pa
       ,d.lugar_nac_pa
       ,d.nivel_est_pa
       ,d.estado_civil_pa
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT )
       ,n.n_orden
       ,n.razon_empresa
       ,n.cargo_de
       ,n.area_o
       ,n.razon_contrata
       ,n.cod_clinica
       ,n.nom_examen
       ,n.fecha_apertura_po -- Datos de la tabla de examen complementario (ip) 
       ,ip.level_autoconciencia
       ,ip.level_autoconfianza
       ,ip.level_autorregula
       ,ip.level_motiva
       ,ip.level_empatia
       ,ip.level_compt_social
       ,ip.foda_for_opor
       ,ip.foda_amen_debi
       ,ip.observacion
       ,ip.recomenda
       ,ip.cumple_perfil
       ,ip.user_registro
       ,ip.fecha_registro
       ,ip.usuario_firma -- Sede y Jasper (Alias corregidos para coincidir con el RETURNS TABLE) 
       ,(
SELECT  s.nombre_sede
FROM sede s
WHERE s.cod_sede = n.cod_sede )::text AS nombresede, (
SELECT  CAST(sm.descripcion AS TEXT)
FROM sede_multisucursal sm
WHERE sm.id = n.cod_sede ) AS sede, n.color, obtener_name_jasper(p_norden, name_service)::text AS namejasper -- Alias explícito 
FROM datos_paciente AS d
INNER JOIN n_orden_ocupacional AS n
ON d.cod_pa = n.cod_pa
INNER JOIN exam_complementarios AS ip
ON ip.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql VOLATILE;
INSERT INTO config_general_service_digital ( name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic ) values( 'cuestionario_berlin', 'Formulario para Cuestionario de Berlin Psicología', false, false, true, false, false );

CREATE OR REPLACE FUNCTION obtener_reporte_cuestionario_berlin(IN p_norden integer, IN name_service text) RETURNS TABLE( dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, codigoclinica text, tipoexamen text, edadpaciente text -- CAMPOS ESPECÍFICOS BERLIN 
 , criterio_apnea_obstructiva_sueno text, criterio_fatiga_somnolencia text, criterio_hipertension_arterial text, analisis_foda_forta_oport text, analisis_foda_amenaz_debili text, observaciones text, recomendaciones text, perf_cumple boolean, perf_no_cumple boolean, usuario_firma text, user_registro text, fecha_registro date, nombresede text, sede text, color integer, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,d.nombres_pa
       ,d.apellidos_pa
       ,d.direccion_pa
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,d.ocupacion_pa
       ,d.lugar_nac_pa
       ,d.nivel_est_pa
       ,d.estado_civil_pa
       ,n.cargo_de
       ,n.area_o
       ,n.razon_contrata
       ,n.n_orden
       ,n.razon_empresa
       ,n.cod_clinica
       ,n.nom_examen
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT ) -- Datos de la tabla cuestionario_berlin 
       ,cb.criterio_apnea_obstructiva_sueño
       ,cb.criterio_fatiga_somnolencia
       ,cb.criterio_hipertension_arterial
       ,cb.analisis_foda_forta_oport
       ,cb.analisis_foda_amenaz_debili
       ,cb.observaciones
       ,cb.recomendaciones
       ,cb.perf_cumple
       ,cb.perf_no_cumple
       ,cb.usuario_firma
       ,cb.user_registro
       ,cb.fecha_registro
       ,CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'  ELSE (
SELECT  nombre_sede
FROM sede
WHERE cod_sede = n.cod_sede ) END AS nombre_sede, CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' ELSE (CAST(sm.descripcion AS TEXT)) END AS sede, n.color, obtener_name_jasper(p_norden, name_service)
FROM datos_paciente AS d
INNER JOIN n_orden_ocupacional AS n
ON d.cod_pa = n.cod_pa
INNER JOIN sede_multisucursal AS sm
ON n.cod_sede = sm.id
INNER JOIN cuestionario_berlin AS cb
ON cb.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION obtener_reporte_trabajos_especificos(IN p_norden integer, IN name_service text) RETURNS TABLE( dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, codigoclinica text, tipoexamen text, edadpaciente text, criterio_nivel_alert_riesgo text, criterio_nivel_psicomotrocidad text, analisis_foda_forta_oport text, analisis_foda_amenaz_debili text, observaciones text, recomendaciones text, perf_cumple boolean, perf_no_cumple boolean, user_registro text, usuario_firma text, nombresede text, sede text, color integer, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,d.nombres_pa
       ,d.apellidos_pa
       ,d.direccion_pa
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,d.ocupacion_pa
       ,d.lugar_nac_pa
       ,d.nivel_est_pa
       ,d.estado_civil_pa
       ,n.cargo_de
       ,n.area_o
       ,n.razon_contrata
       ,n.n_orden
       ,n.razon_empresa
       ,n.cod_clinica
       ,n.nom_examen
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT )
       ,e.criterio_nivel_alert_riesgo
       ,e.criterio_nivel_psicomotrocidad
       ,e.analisis_foda_forta_oport
       ,e.analisis_foda_amenaz_debili
       ,e.observaciones
       ,e.recomendaciones
       ,e.perf_cumple
       ,e.perf_no_cumple
       ,e.user_registro
       ,e.usuario_firma
       ,(
SELECT  s.nombre_sede
FROM sede s
WHERE s.cod_sede = n.cod_sede ) AS nombresede, (
SELECT  s.nombre_sede
FROM sede s
WHERE s.cod_sede = n.cod_sede ) AS sede, n.color, obtener_name_jasper(p_norden, name_service)
FROM datos_paciente AS d
INNER JOIN n_orden_ocupacional AS n
ON d.cod_pa = n.cod_pa
INNER JOIN especificos AS e
ON e.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql
INSERT INTO config_general_service_digital ( name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic ) values( 'alto_riesgo', 'Formulario para trabajos de alto riesgo', false, false, true, false, false );

CREATE OR REPLACE FUNCTION obtener_reporte_alto_riesgo(IN p_norden integer, IN name_service text) RETURNS TABLE( dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, codigoclinica text, tipoexamen text, edadpaciente text, crit_temor_riesgo_electrico text, crit_temor_alturas_izaje text, crit_temor_espac_confi text, anali_foda_forta_oport text, anali_foda_amenaz_debili text, observaciones text, recomendaciones text, perf_cumple boolean, perf_no_cumple boolean, user_registro text, usuario_firma text, nombresede text, sede text, color integer, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  -- =  =  =  =  = DATOS DEL PACIENTE (Desde datos_paciente) =  =  =  =  = 
 d.cod_pa
       ,d.nombres_pa
       ,d.apellidos_pa
       ,d.direccion_pa
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,d.ocupacion_pa
       ,d.lugar_nac_pa
       ,d.nivel_est_pa
       ,d.estado_civil_pa -- =  =  =  =  = DATOS LABORALES (Desde n_orden_ocupacional) =  =  =  =  = 
       ,n.cargo_de
       ,n.area_o
       ,n.razon_contrata
       ,n.n_orden
       ,n.razon_empresa
       ,n.cod_clinica
       ,n.nom_examen
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT ) -- =  =  =  =  = DATOS DE ALTO RIESGO (Desde alto_riesgo - Tu nueva tabla) =  =  =  =  = 
       ,ar.crit_temor_riesgo_electrico
       ,ar.crit_temor_alturas_izaje
       ,ar.crit_temor_espac_confi
       ,ar.anali_foda_forta_oport
       ,ar.anali_foda_amenaz_debili
       ,ar.observaciones
       ,ar.recomendaciones
       ,ar.perf_cumple
       ,ar.perf_no_cumple
       ,ar.user_registro
       ,ar.usuario_firma -- Campo agregado manualmente vía 

ALTER TABLE -- =  =  =  =  = LÓGICA DE SEDE Y JASPER =  =  =  =  = 
 , CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' ELSE (
SELECT  nombre_sede
FROM sede
WHERE cod_sede = n.cod_sede ) END AS nombresede, CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' ELSE (CAST(sm.descripcion AS TEXT)) END AS sede, n.color, obtener_name_jasper(p_norden, name_service)
FROM datos_paciente d
INNER JOIN n_orden_ocupacional n
ON d.cod_pa = n.cod_pa
INNER JOIN sede_multisucursal sm
ON n.cod_sede = sm.id
INNER JOIN alto_riesgo ar
ON ar.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION obtener_reporte_informe_trastorno_personalidad(IN p_norden integer, IN name_service text) RETURNS TABLE( dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, codigoclinica text, tipoexamen text, edadpaciente text, paranoide_bajo boolean, paranoide_medio boolean, paranoide_alto boolean, esquizoide_bajo boolean, esquizoide_medio boolean, esquizoide_alto boolean, esquizotipico_bajo boolean, esquizotipico_medio boolean, esquizotipico_alto boolean, histrionico_bajo boolean, histrionico_medio boolean, histrionico_alto boolean, antisocial_bajo boolean, antisocial_medio boolean, antisocial_alto boolean, narcicista_bajo boolean, narcicista_medio boolean, narcicista_alto boolean, impulsivo_bajo boolean, impulsivo_medio boolean, impulsivo_alto boolean, limite_bajo boolean, limite_medio boolean, limite_alto boolean, anancastico_bajo boolean, anancastico_medio boolean, anancastico_alto boolean, dependiente_bajo boolean, dependiente_medio boolean, dependiente_alto boolean, ansioso_bajo boolean, ansioso_medio boolean, ansioso_alto boolean, observaciones text, recomendacion text, apto boolean, noapto boolean, usuario_firma text, nombresede text, sede text, color integer, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,d.nombres_pa
       ,d.apellidos_pa
       ,d.direccion_pa
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,d.ocupacion_pa
       ,d.lugar_nac_pa
       ,d.nivel_est_pa
       ,d.estado_civil_pa
       ,n.cargo_de
       ,n.area_o
       ,n.razon_contrata
       ,n.n_orden
       ,n.razon_empresa
       ,n.cod_clinica
       ,n.nom_examen
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT ) -- =  =  =  =  = TRASTORNO PERSONALIDAD =  =  =  =  = 
       ,tp.grup_a_paranoide_bajo
       ,tp.grup_a_paranoide_medio
       ,tp.grup_a_paranoide_alto
       ,tp.grup_a_esquizoide_bajo
       ,tp.grup_a_esquizoide_medio
       ,tp.grup_a_esquizoide_alto
       ,tp.grup_a_esquizotipico_bajo
       ,tp.grup_a_esquizotipico_medio
       ,tp.grup_a_esquizotipico_alto
       ,tp.grup_b_histrionico_bajo
       ,tp.grup_b_histrionico_medio
       ,tp.grup_b_histrionico_alto
       ,tp.grup_b_antisocial_bajo
       ,tp.grup_b_antisocial_medio
       ,tp.grup_b_antisocial_alto
       ,tp.grup_b_narcicista_bajo
       ,tp.grup_b_narcicista_medio
       ,tp.grup_b_narcicista_alto
       ,tp.grup_b_inesta_emoci_subtip_impul_bajo
       ,tp.grup_b_inesta_emoci_subtip_impul_medio
       ,tp.grup_b_inesta_emoci_subtip_impul_alto
       ,tp.grup_b_emoci_subtip_lim_bajo
       ,tp.grup_b_emoci_subtip_lim_medio
       ,tp.grup_b_emoci_subtip_lim_alto
       ,tp.grup_c_anancastico_bajo
       ,tp.grup_c_anancastico_medio
       ,tp.grup_c_anancastico_alto
       ,tp.grup_c_dependiente_bajo
       ,tp.grup_c_dependiente_medio
       ,tp.grup_c_dependiente_alto
       ,tp.grup_c_ansioso_bajo
       ,tp.grup_c_ansioso_medio
       ,tp.grup_c_ansioso_alto
       ,tp.analisis_resulta
       ,tp.recomendacion
       ,tp.perf_cumple
       ,tp.perf_no_cumple
       ,tp.usuario_firma
       ,CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'  ELSE (
SELECT  nombre_sede
FROM sede
WHERE cod_sede = n.cod_sede ) END, CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' ELSE CAST(sm.descripcion AS TEXT) END, n.color, obtener_name_jasper(p_norden, name_service)
FROM datos_paciente d
INNER JOIN n_orden_ocupacional n
ON d.cod_pa = n.cod_pa
INNER JOIN sede_multisucursal sm
ON n.cod_sede = sm.id
INNER JOIN trastornos_personalidad tp
ON tp.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION obtener_reporte_informe_conductores(IN p_norden integer, IN name_service text) RETURNS TABLE( dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, codigoclinica text, tipoexamen text, edadpaciente text, crit_atencion text, crit_concetracion text, crit_segurid_control_conduc text, anali_foda_forta_oport text, anali_foda_amenaz_debili text, observacion text, recomendacion text, perf_cumple boolean, perf_no_cumple boolean, user_registro text, usuario_firma text, nombresede text, sede text, color integer, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  -- =  =  =  =  = PACIENTE =  =  =  =  = 
 d.cod_pa
       ,d.nombres_pa
       ,d.apellidos_pa
       ,d.direccion_pa
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,d.ocupacion_pa
       ,d.lugar_nac_pa
       ,d.nivel_est_pa
       ,d.estado_civil_pa -- =  =  =  =  = LABORALES =  =  =  =  = 
       ,n.cargo_de
       ,n.area_o
       ,n.razon_contrata
       ,n.n_orden
       ,n.razon_empresa
       ,n.cod_clinica
       ,n.nom_examen
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT ) -- =  =  =  =  = INFORME CONDUCTORES =  =  =  =  = 
       ,ic.crit_atencion
       ,ic.crit_concetracion
       ,ic.crit_segurid_control_conduc
       ,ic.anali_foda_forta_oport
       ,ic.anali_foda_amenaz_debili
       ,ic.observacion
       ,ic.recomendacion
       ,ic.perf_cumple
       ,ic.perf_no_cumple
       ,ic.user_registro
       ,ic.usuario_firma -- =  =  =  =  = SEDE / JASPER =  =  =  =  = 
       ,CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'  ELSE (
SELECT  nombre_sede
FROM sede
WHERE cod_sede = n.cod_sede ) END AS nombresede, CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' ELSE (CAST(sm.descripcion AS TEXT)) END AS sede, n.color, obtener_name_jasper(p_norden, name_service)
FROM datos_paciente d
INNER JOIN n_orden_ocupacional n
ON d.cod_pa = n.cod_pa
INNER JOIN sede_multisucursal sm
ON n.cod_sede = sm.id
INNER JOIN infor_conductores ic
ON ic.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION obtener_reporte_informe_conductores(IN p_norden integer, IN name_service text) RETURNS TABLE ( dnipaciente integer, nombrespaciente text, nivelestudiopaciente text, codpaciente integer, edadpaciente bigint, cargopaciente text, fechaapertura text, empresa text -- infor_conductores 
 , crit_atencion text, crit_concetracion text, crit_segurid_control_conduc text, anali_foda_forta_oport text, anali_foda_amenaz_debili text, observacion text, recomendacion text, perf_cumple boolean, perf_no_cumple boolean, user_registro text, nombresede text, dir_tru_pierola text, email_tru_pierola text, telf_tru_pierola text, dir_huancayo text, email_huancayo text, telf_huancayo text, dir_huamachuco text, email_huamachuco text, telf_huamachuco text, dir_trujillo text, email_trujillo text, telf_trujillo text, cel_huamachuco text, cel_trujillo_pie text, namejasper text ) LANGUAGE plpgsql AS $BODY$ BEGIN RETURN QUERY
SELECT  d.cod_pa                                AS dnipaciente
       ,CONCAT(d.apellidos_pa,' ',d.nombres_pa) AS nombrespaciente
       ,d.nivel_est_pa                          AS nivelestudiopaciente
       ,d.cod_pa                                AS codpaciente
       ,CAST( EXTRACT( YEAR
FROM age
(current_date, d.fecha_nacimiento_pa
) ) AS bigint ) AS edadpaciente, n.cargo_de AS cargopaciente, TO_CHAR(n.fecha_apertura_po, 'DD/MM/YY') AS fechaapertura, n.razon_empresa AS empresa -- infor_conductores 
 , ic.crit_atencion, ic.crit_concetracion, ic.crit_segurid_control_conduc, ic.anali_foda_forta_oport, ic.anali_foda_amenaz_debili, ic.observacion, ic.recomendacion, ic.perf_cumple, ic.perf_no_cumple, ic.user_registro, (
SELECT  nombre_sede
FROM sede
WHERE cod_sede = n.cod_sede ) AS nombresede, (
SELECT  direccion
FROM sede
WHERE cod_sede = 4 ) AS dir_tru_pierola, (
SELECT  email
FROM sede
WHERE cod_sede = 4 ) AS email_tru_pierola, (
SELECT  telefono
FROM sede
WHERE cod_sede = 4 ) AS telf_tru_pierola, (
SELECT  direccion
FROM sede
WHERE cod_sede = 3 ) AS dir_huancayo, (
SELECT  email
FROM sede
WHERE cod_sede = 3 ) AS email_huancayo, (
SELECT  telefono
FROM sede
WHERE cod_sede = 3 ) AS telf_huancayo, (
SELECT  direccion
FROM sede
WHERE cod_sede = 2 ) AS dir_huamachuco, (
SELECT  email
FROM sede
WHERE cod_sede = 2 ) AS email_huamachuco, (
SELECT  telefono
FROM sede
WHERE cod_sede = 2 ) AS telf_huamachuco, (
SELECT  direccion
FROM sede
WHERE cod_sede = 1 ) AS dir_trujillo, (
SELECT  email
FROM sede
WHERE cod_sede = 1 ) AS email_trujillo, (
SELECT  telefono
FROM sede
WHERE cod_sede = 1 ) AS telf_trujillo, (
SELECT  celular
FROM sede
WHERE cod_sede = 2 ) AS cel_huamachuco, (
SELECT  celular
FROM sede
WHERE cod_sede = 4 ) AS cel_trujillo_pie, obtener_name_jasper(p_norden, name_service) AS namejasper
FROM datos_paciente d
INNER JOIN n_orden_ocupacional n
ON d.cod_pa = n.cod_pa
INNER JOIN infor_conductores ic
ON ic.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$;

CREATE OR REPLACE FUNCTION obtener_name_jasper(norden_param bigint, name_service_param text) RETURNS text AS $BODY$ DECLARE resultado text; name_empresa_busqueda_var text; name_valor_microbiologia_var text; name_valor_hepatitisa_var text; name_valor_hepatitisc_var text; valor_coproparasitologico_var boolean; valor_cuantitativo_antigeno_var boolean; valor_formato_marsa_var boolean; valor_electro_cardiograma boolean; BEGIN -- Obtener el nombre de la empresa de la historia clinica a registrar; 

SELECT  trim(razon_empresa) INTO name_empresa_busqueda_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param;
-- obtener el valor del txt en microbiologia 
SELECT  trim(txtkoh) INTO name_valor_microbiologia_var
FROM microbiologia
WHERE n_orden = norden_param;
-- obtener el valor del txt en hepatitis 
SELECT  trim(txthepatitisa) INTO name_valor_hepatitisa_var
FROM lhepatitis
WHERE n_orden = norden_param;

SELECT  trim(hepatitisc) INTO name_valor_hepatitisc_var
FROM lhepatitis
WHERE n_orden = norden_param;
-- obtener el valor del boolean en coproparasitologico 
SELECT  tipo_coproparasitologico INTO valor_coproparasitologico_var
FROM ac_coproparasitologico
WHERE n_orden = norden_param;
-- obtener los valores de los booleanos en examen inmunologico 
SELECT  cuantitativo_antigeno
       ,formato_marsa INTO valor_cuantitativo_antigeno_var
       ,valor_formato_marsa_var
FROM examen_inmunologico
WHERE n_orden = norden_param;
-- obtener valor boolean del campo informe_completo de electro cardiograma 
SELECT  CASE WHEN informe_completo IS NULL THEN TRUE  ELSE informe_completo END AS informe_completo INTO valor_electro_cardiograma
FROM informe_electrocardiograma
WHERE n_orden = norden_param; IF name_service_param = 'con_panel10D' THEN resultado := 'Consentimiento_Panel10D_Digitalizado'; ELSIF name_service_param = 'con_panel5D' THEN IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'Consentimiento_Panel5D_ohla_Digitalizado'; ELSE resultado := 'Consentimiento_Panel5D_Digitalizado'; END IF; ELSIF name_service_param = 'con_panel3D' THEN resultado := 'Consentimiento_Panel3D_Digitalizado'; ELSIF name_service_param = 'con_panel2D' THEN resultado := 'Consentimiento_Panel2D_Digitalizado'; ELSIF name_service_param = 'consent_Muestra_Sangre' THEN resultado := 'Consentimiento_Muestra_Sangre_Digitalizado'; ELSIF name_service_param = 'consent_marihuana' THEN resultado := 'Consentimiento_Marihuana_Digitalizado'; ELSIF name_service_param = 'consent_Boro' THEN resultado := 'Consentimiento_Boro_Digitalizado'; ELSIF name_service_param = 'analisis_bioquimicos' THEN resultado := 'AnalisisBioquimicos_Digitalizado'; ELSIF name_service_param = 'lab_clinico' THEN resultado := 'LaboratorioClinico_Digitalizado'; ELSIF name_service_param = 'hemograma_autom' THEN resultado := 'Hematologia_Digitalizado'; ELSIF name_service_param = 'lgonadotropina' THEN resultado := 'LGonadotropina_Digitalizado'; ELSIF name_service_param = 'panel2d' THEN resultado := 'Panel2d_Digitalizado'; ELSIF name_service_param = 'panel3d' THEN resultado := 'Panel3d_Digitalizado'; ELSIF name_service_param = 'toxicologia' THEN IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'ResultadosPanel5d_ohla_Digitalizado'; ELSE resultado := 'ResultadosPanel5d_Digitalizado'; END IF; ELSIF name_service_param = 'panel10d' THEN resultado := 'Panel10d_Digitalizado'; ELSIF name_service_param = 'inmunologia' THEN resultado := 'InmunologiaLab_Digitalizado'; ELSIF name_service_param = 'microbiologia' THEN IF name_valor_microbiologia_var IS NOT NULL
AND LENGTH(name_valor_microbiologia_var) > 0 THEN resultado := 'Microbiologia1_Digitalizado'; ELSE resultado := 'Microbiologia_Digitalizado'; END IF; ELSIF name_service_param = 'lhepatitis' THEN IF name_valor_hepatitisa_var IS NOT NULL
AND LENGTH(name_valor_hepatitisa_var) > 0 THEN resultado := 'LHepatitisA_Digitalizado'; ELSIF name_valor_hepatitisc_var IS NOT NULL
AND LENGTH(name_valor_hepatitisc_var) > 0 THEN resultado := 'LHepatitisC_Digitalizado'; ELSE resultado := 'LHepatitisB_Digitalizado'; END IF; ELSIF name_service_param = 'l_bioquimica' THEN resultado := 'LBioquimica_Digitalizado'; ELSIF name_service_param = 'ac_bioquimica2022' THEN resultado := 'AnalisisClinicosB_Digitalizado'; ELSIF name_service_param = 'perfil_hepatico' THEN resultado := 'PerfilHepatico_Digitalizado'; ELSIF name_service_param = 'ac_coprocultivo' THEN resultado := 'coprocultivo_digitalizado'; ELSIF name_service_param = 'ac_coproparasitologico' THEN IF valor_coproparasitologico_var = true THEN resultado := 'Coproparasitologico_Digitalizado'; ELSE resultado := 'ParasitologiaSeriado_Digitalizado'; END IF; ELSIF name_service_param = 'examen_inmunologico' THEN IF valor_cuantitativo_antigeno_var = true THEN resultado := 'pcuantiantigeno'; ELSE IF valor_formato_marsa_var = true THEN resultado := 'pcualitativaantigenoMarsa'; ELSE resultado := 'pcualitativaantigeno'; END IF; END IF; ELSIF name_service_param = 'audiometria_2023' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'Audiometria2021-_Digitalizado_boro'; ELSE resultado := 'Audiometria2021-_Digitalizado'; END IF; ELSIF name_service_param = 'historia_oc_info' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'HistoriaOcupacional_Digitalizado_boro'; ELSE resultado := 'HistoriaOcupacional_Digitalizado'; END IF; ELSIF name_service_param = 'audiometria_po' THEN resultado := 'FichaAudiologica_Digitalizado'; ELSIF name_service_param = 'cuestionario_audiometria' THEN resultado := 'CuestionarioAudiometria_Digitalizado'; ELSIF name_service_param = 'oftalmologia_lo' THEN resultado := 'OftalmologiaLO'; ELSIF name_service_param = 'oftalmologia' THEN resultado := 'Oftalmologia'; ELSIF name_service_param = 'oftalmologia_reporte' THEN resultado := 'ReporteOftalmologico'; ELSIF name_service_param = 'oftalmologia2021' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'EvaluacionOftalmologica2021_Digitalizado_boro'; ELSIF name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'EvaluacionOftalmologica2021_Digitalizado_ohla'; ELSE resultado := 'EvaluacionOftalmologica2021_Digitalizado'; END IF; ELSIF name_service_param = 'odontograma' THEN resultado := 'Odontograma_Digitalizado'; ELSIF name_service_param = 'odontograma_lo' THEN resultado := 'Odontograma_lo_Digitalizado'; ELSIF name_service_param = 'radiografia_torax' THEN resultado := 'RagiografiaToraxPA_Digitalizado'; ELSIF name_service_param = 'radiografia_fechas' THEN resultado := 'ReporteFechasRadiografia_Digitalizado'; ELSIF name_service_param = 'radiografia' THEN resultado := 'RAYOSXXXOFI_Digitalizado'; ELSIF name_service_param = 'oit' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'OIT_Digitalizado_boro'; ELSE resultado := 'OIT_Digitalizado'; END IF; ELSIF name_service_param = 'evaluacion_musculo_esqueletica' THEN resultado := 'EvaluacionMuscoloEsqueletica'; ELSIF name_service_param = 'evaluacion_musculo_esqueletica2021' THEN resultado := 'EvaluacionMuscoloEsqueletica2021_Digitalizado_boro'; ELSIF name_service_param = 'consentimientoInformado' THEN resultado := 'conInformadoOcupacional_Digitalizado'; ELSIF name_service_param = 'cuestionario_nordico' THEN resultado := 'CuestionarioNordico'; ELSIF name_service_param = 'consentimiento_rayosx' THEN resultado := 'ConsentimientoRayosX_Digitalizado'; ELSIF name_service_param = 'test_fatiga_somnolencia' THEN resultado := 'TestFatigaSomnolenia_Digitalizado_boro'; ELSIF name_service_param = 'informe_electrocardiograma' THEN IF valor_electro_cardiograma = TRUE THEN resultado := 'InformeElectrocardiograma2023'; ELSE resultado := 'InformeElectrocardiograma_Digitalizado'; END IF; ELSIF name_service_param = 'antece_enfermedades_altura' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'AnexoCB_boro_Digitalizado'; ELSE resultado := 'AnexoCB_Digitalizado'; END IF; ELSIF name_service_param = 'anexo_agroindustrial' THEN resultado := 'Anexo2'; ELSIF name_service_param = 'consentimientobuenasalud' THEN resultado := 'ConsentimientoBuenaSalud2021_Digitalizado'; ELSIF name_service_param = 'anexo7c' THEN resultado := 'Anexo7C_Boro'; ELSIF name_service_param = 'anexo16a' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'Anexo16ABoro_Digitalizado'; ELSE resultado := 'Anexo16A_Digitalizado'; END IF; ELSIF name_service_param = 'antecedentes_patologicos' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'ficha_antecedente_patologico_boro'; ELSE resultado := 'ficha_antecedente_patologico_Digitalizado'; END IF; ELSIF name_service_param = 'aptitud_medico_ocupacional_agro' THEN resultado := 'Aptitud_Agroindustrial'; ELSIF name_service_param = 'certificado_aptitud_medico_ocupacional' THEN IF name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'Aptitud_medico_ocupacional_11'; ELSE resultado := 'Aptitud_medico_ocupacional_F'; END IF; ELSIF name_service_param = 'ficha_sas' THEN resultado := 'FichaDetencionSAS_boro_Digitalizado'; ELSIF name_service_param = 'certificado_aptitud_medico_resumen' THEN resultado := 'Aptitud_medico_resumen_Digitalizado'; ELSIF name_service_param = 'b_certificado_conduccion' THEN resultado := 'certificaciondeconduccion_Digitalizado_boro'; ELSIF name_service_param = 'ficha_interconsulta' THEN resultado := 'Ficha_interconsulta_Digitalizado'; ELSIF name_service_param = 'b_certificado_altura' THEN resultado := 'Certificacion_suficiencia_trabajos_en_altura_boro_Digitalizado'; ELSIF name_service_param = 'informe_psicologico' THEN resultado := 'InformePsicologico_Digitalizado'; ELSIF name_service_param = 'b_uso_respiradores' THEN resultado := 'UsoRespiradores'; ELSIF name_service_param = 'ficha_psicologica_anexo02' THEN resultado := 'InformePsicologico_Anexo02_Digitalizado'; ELSIF name_service_param = 'ficha_psicologica_anexo03' THEN resultado := 'FichaPsicologicaOcupacional_Digitalizado'; ELSIF name_service_param = 'certificado_altura_poderosa' THEN resultado := 'CertificadoAlturaPoderosa_Digitalizado'; ELSIF name_service_param = 'hoja_consulta_externa' THEN resultado := 'Hoja_Consulta_Externa'; ELSIF name_service_param = 'aptitud_altura_poderosa' THEN resultado := 'Aptitud_Poderosa_Digitalizado'; ELSIF name_service_param = 'aptitud_trabajos_encaliente' THEN resultado := 'Aptitud_Trabajos_EnCaliente_Digitalizado'; ELSIF name_service_param = 'aptitud_licencia_conduciri' THEN resultado := 'Aptitud_Licencia_Conducir_Interna_Digitalizado'; ELSIF name_service_param = 'certificado_aptitud_herramientas_manuales' THEN resultado := 'Certificado_Aptitud_Herramientas_Manuales_Digitalizado'; ELSIF name_service_param = 'informe_psicolaboral' THEN resultado := 'Informe_PsicolaboralBoroo_Digitalizado'; ELSIF name_service_param = 'certificado_manipuladores_barrick' THEN resultado := 'CertificadoMedicoManipuladores_Barrick_Digitalizado'; ELSIF name_service_param = 'informe_psicologico_estres' THEN resultado := 'InformePsicologicoAdecoEstres_Digitalizado'; ELSIF name_service_param = 'evaluacion_psicologica_poderosa' THEN resultado := 'InformePsicologico_Digitalizado'; ELSIF name_service_param = 'psicologia_espacios_confinados' THEN resultado := 'formatPsicologia_SuficienciaEspaciosC'; ELSIF name_service_param = 'informe_riesgos_psicosociales' THEN resultado := 'Informe_Riesgos_Psicosociales_Digitalizado'; ELSIF name_service_param = 'informe_burnout' THEN resultado := 'Informe_burnout_Digitalizado'; ELSIF name_service_param = 'psicologiafobias' THEN resultado := 'formatPsicologia_Digitalizado'; ELSIF name_service_param = 'calidad_sueño' THEN resultado := 'CUESTIONARIO_CALIDAD_DE_SUEÑO_Digitalizado'; ELSIF name_service_param = 'trastornos_personalidad' THEN resultado := 'Informe_Psico_Test_Personalidad'; ELSIF name_service_param = 'infor_conductores' THEN resultado := 'Informe_Psico_Conductores'; ELSIF name_service_param = 'certificacion_medica_altura' THEN resultado := 'A_CertificacionMedicaPTA_Digitalizado'; ELSIF name_service_param = 'alto_riesgo' THEN resultado := 'Informe_Psico_Alto_Riesgo'; ELSIF name_service_param = 'especificos' THEN resultado := 'Informe_Psico_Especificos'; ELSIF name_service_param = 'cuestionario_berlin' THEN resultado := 'Informe_Psico_Cuestionario_Berlin'; ELSIF name_service_param = 'exam_complementarios' THEN resultado := 'Informe_Psico_Exam_Complementario'; ELSIF name_service_param = 'psi_brigadistas' THEN resultado := 'Informe_Psico_Brigadista'; ELSIF name_service_param = 'bombaelectrica' THEN resultado := 'Informe_Psico_BombaElectrica'; ELSIF name_service_param = 'cuadradorvigia' THEN resultado := 'Informe_Psico_CuadradorVigia'; END IF; RETURN resultado; END; $BODY$ LANGUAGE plpgsql; 

ALTER FUNCTION obtener_name_jasper(bigint, text) OWNER TO pierola;

CREATE OR REPLACE FUNCTION obtener_reporte_anexo16(IN p_norden integer, IN name_service text) RETURNS TABLE( fechaanexo7c_fecha date, telefonotrabajopaciente_tel_trabajo_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, dni_cod_pa integer, sexo_sexo_pa "char", numerocontacto_num_contacto text, direccionpaciente_direccion text, fechanacimientopaciente_fecha_nacimiento_pa date, lugarnacimientopaciente_lugar_nac_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiopaciente_nivel_est_pa text, cargo_cargo_de text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, empresa_razon_empresa text, explotacion_nom_ex text, altura_altura_po text, contrata_razon_contrata text, norden_n_orden integer, fechaapertura_fecha_apertura_po date, nombreexamen_nom_examen text, mineral_mineral_po text, nombres_nombres text, edad_edad text, perimetrocuellotriaje_perimetro_cuello text, imctriaje_imc text, pesotriaje_peso text, tallatriaje_talla text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, temperaturatriaje_temperatura text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageograficaanexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, reubicacionsianexo7c_tbrsi boolean, reubicacionnoanexo7c_rbrno boolean, puestoactualanexo7c_txtpuestoactual text, tiempoanexo7c_txttiempo text, antecedentespersonalesanexo7c_txtantecedentespersonales text, antecedentesfamiliaresanexo7c_txtantecedentesfamiliares text, tetanoanexo7c_tetano boolean, hepatitisbanexo7c_hepatitisb boolean, fiebreamarillaanexo7c_fiebreamarilla boolean, hijosvivosanexo7c_txthijosvivos text, hijosmuertosanexo7c text, tabaconadaaexo7c_chktnada boolean, tabacopocoanexo7c_chktpoco boolean, tabacohabitualanexo7c_chkthabitual boolean, tabacoexcesivoanexo7c_chktexcesivo boolean, alcoholnadaanexo7c_chkanada boolean, alcoholpocoanexo7c_chkapoco boolean, alcoholhabitualanexo7c_chkahabitual boolean, alcoholexcesivoanexo7c_chkaexcesivo boolean, drogasnadaanexo7c_chkdnada boolean, drogaspocoanexo7c_chkdpoco boolean, drogashabitualanexo7c_chkdhabitual boolean, drogasexcesivoanexo7c_chkdexcesivo boolean, conclusionanexo7c_txtconclusion text, cabezaanexo7c_txtcabeza text, narizanexo7c_txtnariz text, cuelloanexo7c_txtcuello text, perimetroanexo7c_txtperimetro text, baflanexo7c_txtb_a_f_l text, visioncoloresanexo7c_txtvisioncolores text, enfermedadesocularesanexo7c_txtenfermedadesoculares text, reflejospupilaresanexo7c_txtreflejospupilares text, binocularanexo7c_txtbinocular text, odanexo7c_txtod text, oianexo7c_txtoi text, toraxanexo7c_txttorax text, corazonanexo7c_txtcorazon text, pulmonesnormalanexo7c_rbnormal boolean, pulmonesanormalanexo7c_rbanormal boolean, pulmonesdescripcionanexo7c_txtpulmones text, miembrossuperioresanexo7c_txtmiembrossuperiores text, miembrosinferioresanexo7c_txtmiembrosinferiores text, ausentesodontograma_txtausentes integer, piezasmalestadoodontograma_txtpiezasmalestado integer, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, odcc_odcc text, oicc_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlc_odlc text, oilc_oilc text, vc_vc text, vb_vb text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, enfermedadesocularesvisionlejos_e_oculvisionlejos text, tecishiharanormal_rbtecishihara_normal boolean, tecishiharaanormal_rbtecishihara_anormal boolean, teccoleresnormal_rbteccoleres_normal boolean, teccoleresanormal_rbteccoleres_anormal boolean, tecestereopsianormal_rbtecestereopsia_normal boolean, tecestereopsiaanormal_rbtecestereopsia_anormal boolean, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, reflejososteotendinososanexo7c_txtreflejososteotendinosos text, marchaanexo7c_txtmarcha text, columnavertebralanexo7c_txtcolumnavertebral text, abdomenanexo7c_txtabdomen text, anillosinguinalesanexo7c_txtanillosinguinales text, organosgenitalesanexo7c_txtorganosgenitales text, tactorectalnohizoanexo7c_rbtnohizo boolean, tactorectalnormalanexo7c_rbtnormal boolean, tactorectalanormalanexo7c_rbtanormal boolean, describirobservacionanexo7c_chkdescribirobservacion boolean, herniasanexo7c_txthernias text, varicesanexo7c_txtvarices text, gangliosanexo7c_txtganglios text, lenguageanexo7c_txtlenguage text, observacionesfichamedicaanexo7c_txtobservacionesfm text, nrx_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, conclusionmedicoanexo7c_txtconclusionmed text, estadomentalanexo7c_txtestadomental text, anamnesisanexo7c_txtanamnesis text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, verticesradiografiatorax_txtvertices text, hilosradiografiatorax_txthilios text, senoscostofrenicos_txtsenoscostofrenicos text, meadiastinos_txtmediastinos text, siluetacardiovascular_txtsiluetacardiovascular text, conclusionesradiograficas_txtconclusionesradiograficas text, color integer, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, glucosalaboratorioclinico_txtglucosabio text, creatininalaboratorioclinico_txtcreatininabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, leucocitos_txtleucocitosematologia text, hematies_txthematiesematologia text, plaquetas_txtplaquetas text, neutrofilos_txtneutrofilos text, abastonados_txtabastonados text, segmentados_txtsegmentadosematologia text, monocitos_txtmonocitosematologia text, eosinofilos_txteosinofiosematologia text, basofilos_txtbasofilosematologia text, linfocitos_txtlinfocitosematologia text, creatininaanalisisbioquimico_txtcreatinina text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliceridosanalisisbioquimico_txttrigliceridos text, sede text, nombresede text, numero text, codigoanexo7c_cod_anexo integer, namejasper text, pielanexo7c_piel boolean, pieldescripcionanexo7c_piel_descripcion text, usuariofirma text, interpretacionfuncionrespiratoria_interpretacion text, hematocritoLaboratorioClinico_txthematocrito text, creatininaPerfilRenal_txtcreatinina text, ureaAsericaPerfilRenal_txtureaserica text, acidoUricoPerfilRenal_txtacidourico text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  a.fecha
       ,d.tel_trabajo_pa
       ,d.tel_casa_pa
       ,d.cel_pa
       ,d.cod_pa
       ,d.sexo_pa
       ,CASE WHEN LENGTH(TRIM(CAST(d.tel_casa_pa AS TEXT))) > 1 THEN d.tel_casa_pa  ELSE d.cel_pa END                                             AS num_contacto
       ,d.direccion_pa || '-' || d.distrito_pa || '-' || d.provincia_pa || '-' || d.departamento_pa                                               AS direccion
       ,d.fecha_nacimiento_pa
       ,d.lugar_nac_pa
       ,d.estado_civil_pa
       ,d.nivel_est_pa
       ,n.cargo_de
       ,f.fvc
       ,f.fev1
       ,f.fev1fvc
       ,f.fef25_75
       ,n.razon_empresa
       ,n.nom_ex
       ,n.altura_po
       ,n.razon_contrata
       ,n.n_orden
       ,n.fecha_apertura_po
       ,e.nom_examen
       ,n.mineral_po
       ,d.apellidos_pa || ' ' || d.nombres_pa                                                                                                     AS nombres
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date)                                                                                    AS TEXT )
       ,t.perimetro_cuello
       ,t.imc
       ,t.peso
       ,t.talla
       ,t.cintura
       ,t.cadera
       ,t.icc
       ,t.temperatura
       ,t.f_respiratoria
       ,t.f_cardiaca
       ,t.sat_02
       ,t.sistolica
       ,t.diastolica
       ,CASE WHEN apt.ruido IS NULL THEN a.chkruido  ELSE apt.ruido END
       ,CASE WHEN apt.polvo IS NULL THEN a.chkpolvo  ELSE apt.polvo END
       ,CASE WHEN apt.vid_segmentario IS NULL THEN a.chkvidsegmentario  ELSE apt.vid_segmentario END
       ,CASE WHEN apt.vid_total IS NULL THEN a.chkvidtotal  ELSE apt.vid_total END
       ,CASE WHEN apt.cancerigenos IS NULL THEN a.chkcancerigenos  ELSE apt.cancerigenos END
       ,CASE WHEN apt.mutagenicos IS NULL THEN a.chkmutagenicos  ELSE apt.mutagenicos END
       ,CASE WHEN apt.solventes IS NULL THEN a.chksolventes  ELSE apt.solventes END
       ,CASE WHEN apt.metales IS NULL THEN a.chkmetales  ELSE apt.metales END
       ,CASE WHEN apt.temperatura IS NULL THEN a.chktemperatura  ELSE apt.temperatura END
       ,CASE WHEN apt.biologicos IS NULL THEN a.chkbiologicos  ELSE apt.biologicos END
       ,CASE WHEN apt.posturas IS NULL THEN a.chkposturas  ELSE apt.posturas END
       ,CASE WHEN apt.turnos IS NULL THEN a.chkturnos  ELSE apt.turnos END
       ,CASE WHEN apt.cargas IS NULL THEN a.chkcargas  ELSE apt.cargas END
       ,CASE WHEN apt.mov_repet IS NULL THEN a.chkmovrepet  ELSE apt.mov_repet END
       ,CASE WHEN apt.pvd IS NULL THEN a.chkpvd  ELSE apt.pvd END
       ,CASE WHEN apt.electricos IS NULL THEN a.electricos  ELSE apt.electricos END
       ,CASE WHEN apt.vibraciones IS NULL THEN a.vibraciones  ELSE apt.vibraciones END
       ,CASE WHEN apt.otros IS NULL THEN a.chkotros  ELSE apt.otros END
       ,CASE WHEN apt.altura_estructura IS NULL THEN a.altura_estructura  ELSE apt.altura_estructura END
       ,CASE WHEN apt.altura_geografica IS NULL THEN a.altura_geog  ELSE apt.altura_geografica END
       ,CASE WHEN apt.quimicos IS NULL THEN a.quimicos  ELSE apt.quimicos END
       ,a.tbrsi
       ,a.rbrno
       ,a.txtpuestoactual
       ,a.txttiempo
       ,a.txtantecedentespersonales
       ,a.txtantecedentesfamiliares
       ,a.tetano
       ,a.hepatitisb
       ,a.fiebreamarilla
       ,a.txthijosvivos
       ,a.txthijosmuertos
       ,a.chktnada
       ,a.chktpoco
       ,a.chkthabitual
       ,a.chktexcesivo
       ,a.chkanada
       ,a.chkapoco
       ,a.chkahabitual
       ,a.chkaexcesivo
       ,a.chkdnada
       ,a.chkdpoco
       ,a.chkdhabitual
       ,a.chkdexcesivo
       ,a.txtconclusion
       ,a.txtcabeza
       ,a.txtnariz
       ,a.txtcuello
       ,a.txtperimetro
       ,a.txtb_a_f_l
       ,a.txtvisioncolores
       ,a.txtenfermedadesoculares
       ,a.txtreflejospupilares
       ,a.txtbinocular
       ,a.txtod
       ,a.txtoi
       ,a.txttorax
       ,a.txtcorazon
       ,a.rbnormal
       ,a.rbanormal
       ,a.txtpulmones
       ,a.txtmiembrossuperiores
       ,a.txtmiembrosinferiores
       ,od.txtausentes
       ,od.txtpiezasmalestado
       ,CASE WHEN oft.txtcercasincorregirod is not null THEN oft.txtcercasincorregirod  ELSE o.v_cerca_s_od END                                   AS v_cerca_s_od
       ,CASE WHEN oft.txtcercasincorregiroi is not null THEN oft.txtcercasincorregiroi  ELSE o.v_cerca_s_oi END                                   AS v_cerca_s_oi
       ,CASE WHEN oft.txtcercacorregidaod is not null THEN oft.txtcercacorregidaod
             WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od  ELSE ol.v_cerca_c_od END                                                           AS ODCC
       ,CASE WHEN oft.txtcercacorregidaoi is not null THEN oft.txtcercacorregidaoi
             WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi  ELSE ol.v_cerca_c_oi END                                                           AS OICC
       ,CASE WHEN oft.txtlejossincorregirod is not null THEN oft.txtlejossincorregirod  ELSE o.v_lejos_s_od END                                   AS v_lejos_s_od
       ,CASE WHEN oft.txtlejossincorregiroi is not null THEN oft.txtlejossincorregiroi  ELSE o.v_lejos_s_oi END                                   AS v_lejos_s_oi
       ,CASE WHEN oft.txtlejoscorregidaod is not null THEN oft.txtlejoscorregidaod
             WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  ELSE ol.v_lejos_c_od END                                                           AS ODLC
       ,CASE WHEN oft.txtlejoscorregidaoi is not null THEN oft.txtlejoscorregidaoi
             WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  ELSE ol.v_lejos_c_oi END                                                           AS OILC
       ,CASE WHEN ol.v_colores IS NULL THEN o.v_colores  ELSE ol.v_colores END                                                                    AS VC
       ,CASE WHEN oft.txtbinocularsincorregir IS not NULL THEN oft.txtbinocularsincorregir
             WHEN ol.v_binocular IS NULL THEN o.v_binocular  ELSE ol.v_binocular END                                                              AS VB
       ,CASE WHEN ol.r_pupilares IS NULL THEN o.r_pupilares  ELSE ol.r_pupilares END                                                              AS RP
       ,CASE WHEN oft.txtdiagnostico IS not NULL THEN oft.txtdiagnostico  ELSE o.e_oculares END                                                   AS e_oculares
       ,o.e_oculares1
       ,o.e_oculvisionlejos
       ,oft.rbtecishihara_normal
       ,oft.rbtecishihara_anormal
       ,oft.rbteccoleres_normal
       ,oft.rbteccoleres_anormal
       ,oft.rbtecestereopsia_normal
       ,oft.rbtecestereopsia_anormal
       ,CASE WHEN au.o_d_500 is not null THEN au.o_d_500
             WHEN a25.o_d_500 is not null THEN a25.o_d_500  ELSE m.o_d_500 END                                                                    AS o_d_500
       ,CASE WHEN au.o_d_1000 is not null THEN au.o_d_1000
             WHEN a25.o_d_1000 is not null THEN a25.o_d_1000  ELSE m.o_d_1000 END                                                                 AS o_d_1000
       ,CASE WHEN au.o_d_2000 is not null THEN au.o_d_2000
             WHEN a25.o_d_2000 is not null THEN a25.o_d_2000  ELSE m.o_d_2000 END                                                                 AS o_d_2000
       ,CASE WHEN au.o_d_3000 is not null THEN au.o_d_3000
             WHEN a25.o_d_3000 is not null THEN a25.o_d_3000  ELSE m.o_d_3000 END                                                                 AS o_d_3000
       ,CASE WHEN au.o_d_4000 is not null THEN au.o_d_4000
             WHEN a25.o_d_4000 is not null THEN a25.o_d_4000  ELSE m.o_d_4000 END                                                                 AS o_d_4000
       ,CASE WHEN au.o_d_6000 is not null THEN au.o_d_6000
             WHEN a25.o_d_6000 is not null THEN a25.o_d_6000  ELSE m.o_d_6000 END                                                                 AS o_d_6000
       ,CASE WHEN au.o_d_8000 is not null THEN au.o_d_8000
             WHEN a25.o_d_8000 is not null THEN a25.o_d_8000  ELSE m.o_d_8000 END                                                                 AS o_d_8000
       ,CASE WHEN au.o_i_500 is not null THEN au.o_i_500
             WHEN a25.o_i_500 is not null THEN a25.o_i_500  ELSE m.o_i_500 END                                                                    AS o_i_500
       ,CASE WHEN au.o_i_1000 is not null THEN au.o_i_1000
             WHEN a25.o_i_1000 is not null THEN a25.o_i_1000  ELSE m.o_i_1000 END                                                                 AS o_i_1000
       ,CASE WHEN au.o_i_2000 is not null THEN au.o_i_2000
             WHEN a25.o_i_2000 is not null THEN a25.o_i_2000  ELSE m.o_i_2000 END                                                                 AS o_i_2000
       ,CASE WHEN au.o_i_3000 is not null THEN au.o_i_3000
             WHEN a25.o_i_3000 is not null THEN a25.o_i_3000  ELSE m.o_i_3000 END                                                                 AS o_i_3000
       ,CASE WHEN au.o_i_4000 is not null THEN au.o_i_4000
             WHEN a25.o_i_4000 is not null THEN a25.o_i_4000  ELSE m.o_i_4000 END                                                                 AS o_i_4000
       ,CASE WHEN au.o_i_6000 is not null THEN au.o_i_6000
             WHEN a25.o_i_6000 is not null THEN a25.o_i_6000  ELSE m.o_i_6000 END                                                                 AS o_i_6000
       ,CASE WHEN au.o_i_8000 is not null THEN au.o_i_8000
             WHEN a25.o_i_8000 is not null THEN a25.o_i_8000  ELSE m.o_i_8000 END                                                                 AS o_i_8000
       ,CASE WHEN m.diagnostico is null THEN ''  ELSE m.diagnostico END                                                                           AS diagnostico
       ,a.txtreflejososteotendinosos
       ,a.txtmarcha
       ,a.txtcolumnavertebral
       ,a.txtabdomen
       ,a.txtanillosinguinales
       ,a.txtorganosgenitales
       ,a.rbtnohizo
       ,a.rbtnormal
       ,a.rbtanormal
       ,a.chkdescribirobservacion
       ,a.txthernias
       ,a.txtvarices
       ,a.txtganglios
       ,a.txtlenguage
       ,a.txtobservacionesfm
       ,e2.n_rx
       ,e2.fecha_exra
       ,e2.txtcalidad
       ,e2.txtsimbolos
       ,a.txtconclusionmed
       ,a.txtestadomental
       ,a.txtanamnesis
       ,e2.ex_0
       ,e2.ex_10
       ,e2.ex_11
       ,e2.ex_12
       ,e2.ex_21
       ,e2.ex_22
       ,e2.ex_23
       ,e2.ex_32
       ,e2.ex_33
       ,e2.ex_3mas
       ,e2.ex_abc
       ,e2.ex_st
       ,e2.txtsinneumoconiosis
       ,e2.txtconneumoconiosis
       ,e2.txtirep
       ,e2.txtotrosex
       ,e2.apto_si
       ,e2.apto_no
       ,e2.apto_re
       ,r.txtvertices
       ,r.txthilios
       ,r.txtsenoscostofrenicos
       ,r.txtmediastinos
       ,r.txtsiluetacardiovascular
       ,r.txtconclusionesradiograficas
       ,n.color
       ,l.chko
       ,l.chka
       ,l.chkb
       ,l.chkab
       ,l.rbrhpositivo
       ,l.rbrhnegativo
       ,l.txthemoglobina
       ,l.chkpositivo
       ,l.chknegativo
       ,l.txtglucosabio
       ,l.txtcreatininabio
       ,l.txtvsg
       ,l.txtcocaina
       ,l.txtmarihuana
       ,l.txtleucocitosematologia
       ,l.txthematiesematologia
       ,l.txtplaquetas
       ,l.txtneutrofilos
       ,l.txtabastonados
       ,l.txtsegmentadosematologia
       ,l.txtmonocitosematologia
       ,l.txteosinofiosematologia
       ,l.txtbasofilosematologia
       ,l.txtlinfocitosematologia
       ,ab.txtcreatinina
       ,ab.txtcolesterol
       ,ab.txtldlcolesterol
       ,ab.txthdlcolesterol
       ,ab.txtvldlcolesterol
       ,ab.txttrigliseridos
       ,CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' AND n.cod_sede <> 3 THEN 'Huamachuco'  ELSE (CAST(sm.descripcion       AS TEXT)) END
       ,CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
             WHEN n.cod_sede = 1 THEN 'Trujillo'
             WHEN n.cod_sede = 2 THEN 'Huamachuco'
             WHEN n.cod_sede = 3 THEN 'Huancayo'
             WHEN n.cod_sede = 4 THEN 'Trujillo' END                                                                                              AS nombreSede
       ,( CASE WHEN n.cod_sede = 1 THEN CONCAT(n.n_orden,'-T') WHEN n.cod_sede = 4 THEN CONCAT(n.n_orden,'-TP') else CONCAT(n.n_orden,'-H') END ) AS numero
       ,a.cod_anexo
       ,obtener_name_jasper(p_norden,name_service)
       ,a.piel
       ,a.piel_descripcion
       ,a.usuario_firma
       ,f.interpretacion
       ,l.txthematocrito
       ,lbi.txtcreatinina
       ,lbi.txtureaserica
       ,lbi.txtacidourico
FROM n_orden_ocupacional AS n
INNER JOIN datos_paciente AS d
ON (n.cod_pa = d.cod_pa)
INNER JOIN sede_multisucursal AS sm
ON n.cod_sede = sm.id
INNER JOIN examen_medico_ocupacional AS e
ON (e.nom_examen = n.nom_examen)
INNER JOIN anexo7c AS a
ON (a.n_orden = n.n_orden)
INNER JOIN triaje AS t
ON (t.n_orden = n.n_orden)
LEFT JOIN oftalmologia AS o
ON (o.n_orden = n.n_orden)
LEFT JOIN audiometria_2021 AS au
ON (n.n_orden = au.n_orden)
LEFT JOIN audiometria_2023 AS a25
ON (n.n_orden = a25.n_orden)
LEFT JOIN oftalmologia2021 AS oft
ON (n.n_orden = oft.n_orden)
INNER JOIN funcion_abs AS f
ON (f.n_orden = n.n_orden)
INNER JOIN odontograma AS od
ON (od.n_orden = n.n_orden)
LEFT JOIN audiometria_po AS m
ON (m.n_orden = n.n_orden)
LEFT JOIN oftalmologia_lo AS ol
ON (ol.n_orden = n.n_orden)
INNER JOIN radiografia_torax AS r
ON (r.n_orden = n.n_orden)
INNER JOIN lab_clinico AS l
ON (l.n_orden = n.n_orden)
INNER JOIN ex_radiograficos_sanguineos AS e2
ON (e2.n_orden = n.n_orden)
LEFT JOIN analisis_bioquimicos AS ab
ON (n.n_orden = ab.n_orden)
LEFT JOIN antecedentes_patologicos AS apt
ON (n.n_orden = apt.n_orden)
LEFT JOIN l_bioquimica AS lbi
ON (n.n_orden = lbi.n_orden)
WHERE n.n_orden = p_norden
LIMIT 1; END; $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sp_validar_existencia_servicios( IN p_historia_clinica bigint, IN p_examen_med text ) RETURNS TABLE(id_resp integer, mensaje text) AS $BODY$ declare v_mensaje text; declare v_id_existencia integer; declare v_triaje_existencia_espirometria integer; declare v_agudeza_visual_existencia integer; declare v_tabla_necesaria_existencia integer; begin if(p_examen_med = 'triaje') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM triaje
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'con_panel10D') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consent_laboratorios
WHERE n_orden = p_historia_clinica
AND name_conset = p_examen_med
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'con_panel5D') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consent_laboratorios
WHERE n_orden = p_historia_clinica
AND name_conset = p_examen_med
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'con_panel3D') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consent_laboratorios
WHERE n_orden = p_historia_clinica
AND name_conset = p_examen_med
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'con_panel2D') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consent_laboratorios
WHERE n_orden = p_historia_clinica
AND name_conset = p_examen_med
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'consent_Muestra_Sangre') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consent_laboratorios
WHERE n_orden = p_historia_clinica
AND name_conset = p_examen_med
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'consent_marihuana') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consent_laboratorios
WHERE n_orden = p_historia_clinica
AND name_conset = p_examen_med
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'consent_Boro') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consent_Boro
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'panel10d') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM panel10d
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'toxicologia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM toxicologia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'panel3d') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM panel3d
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'panel2d') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM panel2d
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'analisis_bioquimicos') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM analisis_bioquimicos
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'lab_clinico') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM lab_clinico
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'examen_inmunologico') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM examen_inmunologico
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'microbiologia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM microbiologia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'inmunologia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM inmunologia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'parasitologia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM parasitologia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'ac_bioquimica2022') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ac_bioquimica2022
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'ac_coprocultivo') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ac_coprocultivo
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'ac_coproparasitologico') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ac_coproparasitologico
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'perfil_hepatico') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM perfil_hepatico
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'l_bioquimica') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM l_bioquimica
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'lhepatitis') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM lhepatitis
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'hemograma_autom') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM hemograma_autom
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'ltest_altura') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ltest_altura
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'lanexo16a') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM lanexo16a
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'lpsiconsensometria') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM lpsiconsensometria
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'lgonadotropina') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM lgonadotropina
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'consen_digit') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consen_digit
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'audiometria_2023') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM audiometria_2023
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'historia_oc_info') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM historia_oc_info
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'audiometria_po') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM audiometria_po
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'ficha_audiologica') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ficha_audiologica
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'cuestionario_audiometria') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM cuestionario_audiometria
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'funcion_abs') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM funcion_abs
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_triaje_existencia_espirometria
FROM triaje
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_triaje_existencia_espirometria = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'oftalmologia_lo') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM oftalmologia_lo
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'oftalmologia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM oftalmologia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'oftalmologia2021') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM oftalmologia2021
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'odontograma') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM odontograma
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'odontograma_lo') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM odontograma_lo
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'radiografia_torax') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM radiografia_torax
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'radiografia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM radiografia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'oit') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM oit
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'consentimientoInformado') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consentimientoInformado
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'radiografia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM radiografia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'radiografia_torax') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM radiografia_torax
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'evaluacion_musculo_esqueletica') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM evaluacion_musculo_esqueletica
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if( p_examen_med = 'evaluacion_musculo_esqueletica2021' ) THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM evaluacion_musculo_esqueletica2021
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'cuestionario_nordico') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM cuestionario_nordico
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'consentimiento_rayosx') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consentimiento_rayosx
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'test_fatiga_somnolencia') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM test_fatiga_somnolencia
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'informe_electrocardiograma') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM informe_electrocardiograma
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'antece_enfermedades_altura') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM antece_enfermedades_altura
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'anexo_agroindustrial') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM anexo_agroindustrial
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'consentimientobuenasalud') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM consentimientobuenasalud
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'anexo7c') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM anexo7c
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'anexo16a') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM anexo16a
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_triaje_existencia_espirometria
FROM triaje
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_triaje_existencia_espirometria = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'antecedentes_patologicos') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM antecedentes_patologicos
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  CASE WHEN EXISTS (
SELECT  1
FROM oftalmologia2021
WHERE n_orden = p_historia_clinica ) OR EXISTS (
SELECT  1
FROM oftalmologia
WHERE n_orden = p_historia_clinica ) OR EXISTS (
SELECT  1
FROM oftalmologia_lo
WHERE n_orden = p_historia_clinica ) THEN 1 ELSE 0 END INTO v_agudeza_visual_existencia; IF(v_agudeza_visual_existencia = 1) THEN IF(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR AGUDEZA VISUAL PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'aptitud_medico_ocupacional_agro') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM aptitud_medico_ocupacional_agro
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM anexo_agroindustrial
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_tabla_necesaria_existencia = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR ANEXO 2 PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if( p_examen_med = 'certificado_aptitud_medico_ocupacional' ) THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM certificado_aptitud_medico_ocupacional
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM anexo7c
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_tabla_necesaria_existencia = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR ANEXO 16 PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'ficha_sas') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ficha_sas
WHERE n_orden = p_historia_clinica
LIMIT 1;
-- 
SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM triaje
WHERE n_orden = p_historia_clinica
LIMIT 1;
-- if(v_tabla_necesaria_existencia = 1) THEN
-- if(v_id_existencia = 0) THEN
-- v_mensaje:= 'SIN REGISTROS EN EL SISTEMA';
-- else
-- v_mensaje:= 'YA FUE REGISTRADO';
--
-- end if;
-- else
-- v_mensaje:= 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)';
-- v_id_existencia:= 2;
-- end if; 
 if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if( p_examen_med = 'certificado_aptitud_medico_resumen' ) THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM certificado_aptitud_medico_resumen
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'b_certificado_conduccion') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM b_certificado_conduccion
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM ficha_sas
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_tabla_necesaria_existencia = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR FICHA SAS PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'ficha_interconsulta') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ficha_interconsulta
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM triaje
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_tabla_necesaria_existencia = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'b_certificado_altura') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM b_certificado_altura
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  CASE WHEN EXISTS (
SELECT  1
FROM audiometria_2023
WHERE n_orden = p_historia_clinica ) OR EXISTS (
SELECT  1
FROM audiometria_po
WHERE n_orden = p_historia_clinica ) THEN 1 ELSE 0 END INTO v_tabla_necesaria_existencia; IF(v_tabla_necesaria_existencia = 1) THEN IF(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR AUDIOMETRIA PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'informe_psicologico') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM informe_psicologico
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'b_uso_respiradores') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM b_uso_respiradores
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'ficha_psicologica_anexo02') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ficha_psicologica_anexo02
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'ficha_psicologica_anexo03') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM ficha_psicologica_anexo03
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'certificado_altura_poderosa') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM certificado_altura_poderosa
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM triaje
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_tabla_necesaria_existencia = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'hoja_consulta_externa') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM hoja_consulta_externa
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM anexo7c
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_tabla_necesaria_existencia = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR ANEXO 16 PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'aptitud_altura_poderosa') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM aptitud_altura_poderosa
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'aptitud_trabajos_encaliente') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM aptitud_trabajos_encaliente
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'aptitud_licencia_conduciri') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM aptitud_licencia_conduciri
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if( p_examen_med = 'certificado_aptitud_herramientas_manuales' ) THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM certificado_aptitud_herramientas_manuales
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'informe_psicolaboral') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM informe_psicolaboral
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'informe_psicologico_estres') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM informe_psicologico_estres
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if( p_examen_med = 'certificado_manipuladores_barrick' ) THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM certificado_manipuladores_barrick
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'evaluacion_psicologica_poderosa') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM evaluacion_psicologica_poderosa
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'psicologia_espacios_confinados') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM psicologia_espacios_confinados
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'informe_riesgos_psicosociales') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM informe_riesgos_psicosociales
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'informe_burnout') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM informe_burnout
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'psicologiafobias') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM psicologiafobias
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'calidad_sueño') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM calidad_sueño
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'trastornos_personalidad') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM trastornos_personalidad
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'infor_conductores') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM infor_conductores
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'certificacion_medica_altura') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM certificacion_medica_altura
WHERE n_orden = p_historia_clinica
LIMIT 1;

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_tabla_necesaria_existencia
FROM triaje
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_tabla_necesaria_existencia = 1) THEN if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; else v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)'; v_id_existencia := 2; end if; end if; if(p_examen_med = 'alto_riesgo') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM alto_riesgo
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'especificos') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM especificos
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'cuestionario_berlin') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM cuestionario_berlin
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if(p_examen_med = 'exam_complementarios') THEN

SELECT  ( CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END ) into v_id_existencia
FROM exam_complementarios
WHERE n_orden = p_historia_clinica
LIMIT 1; if(v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; if (p_examen_med = 'bombaelectrica') THEN

SELECT  (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END) into v_id_existencia
FROM bombaelectrica
WHERE n_orden = p_historia_clinica
LIMIT 1; if (v_id_existencia = 0) THEN v_mensaje := 'SIN REGISTROS EN EL SISTEMA'; else v_mensaje := 'YA FUE REGISTRADO'; end if; end if; 


 if (p_examen_med = 'cuadradorvigia') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from cuadradorvigia
        where n_orden = p_historia_clinica
        limit 1;
        if (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;











RETURN query

SELECT  v_id_existencia AS id_resp
       ,v_mensaje       AS mensaje; end; $BODY$ LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION obtener_parametros_digitalizados( IN norden_param bigint, IN name_servicio_param text ) RETURNS TABLE( descripcion text, name_digitalizacion text, dni integer ) AS $BODY$ DECLARE dni_paciente_var INTEGER; dni_user_registro_var INTEGER; dni_user_doctor_asig_var INTEGER; dni_user_doc_adic_var INTEGER; empresa_var TEXT; user_registro_var TEXT; sede_var INTEGER; completo_electro_var BOOLEAN; BEGIN -- Obtener DNI del paciente 
 IF name_servicio_param = 'ficha_interconsulta' THEN

SELECT  cod_pa INTO dni_paciente_var
FROM n_orden_ocupacional n
INNER JOIN ficha_interconsulta f
ON n.n_orden = f.n_orden
WHERE f.cod_fichaint = norden_param; ELSE

SELECT  cod_pa INTO dni_paciente_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param; END IF; IF name_servicio_param = 'ficha_interconsulta' THEN

SELECT  trim(razon_empresa) INTO empresa_var
FROM n_orden_ocupacional n
INNER JOIN ficha_interconsulta f
ON n.n_orden = f.n_orden
WHERE f.cod_fichaint = norden_param; ELSE

SELECT  trim(razon_empresa) INTO empresa_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param; END IF;

SELECT  COALESCE(informe_completo,FALSE) INTO completo_electro_var
FROM informe_electrocardiograma
WHERE n_orden = norden_param;
-- Primera condición 
 IF name_servicio_param = 'con_panel10D' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; END IF;
-- Segunda condición 
 IF name_servicio_param = 'con_panel5D' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF( (

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) AND empresa_var = 'OBRASCÓN HUARTE LAIN S.A' ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- Tercera condicion 
 IF name_servicio_param = 'con_panel3D' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; END IF;
-- Cuarta condición 
 IF name_servicio_param = 'con_panel2D' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; END IF;
-- Quinta condición 
 IF name_servicio_param = 'consent_Muestra_Sangre' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM consent_laboratorios
WHERE n_orden = norden_param
AND name_conset = name_servicio_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- Sexta condición 
 IF name_servicio_param = 'consent_marihuana' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; END IF;
-- Septima condición 
 IF name_servicio_param = 'consent_Boro' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM consent_Boro
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'analisis_bioquimicos' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM analisis_bioquimicos
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; ELSE dni_user_registro_var := 1; END IF; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'lab_clinico' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM lab_clinico
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; ELSE dni_user_registro_var := 1; END IF; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'hemograma_autom' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM hemograma_autom
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'lgonadotropina' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM lgonadotropina
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'panel2d' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM panel2d
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; s END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'panel3d' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM panel2d
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'toxicologia' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM toxicologia
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'panel10d' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM panel10d
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'inmunologia' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM inmunologia
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'microbiologia' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM microbiologia
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'lhepatitis' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM lhepatitis
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- perfil renal 
 IF name_servicio_param = 'l_bioquimica' THEN IF(
SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM l_bioquimica
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- acido urino 
 IF name_servicio_param = 'ac_bioquimica2022' THEN IF(
SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM ac_bioquimica2022
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- perfil hepatico 
 IF name_servicio_param = 'perfil_hepatico' THEN IF(
SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM perfil_hepatico
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- coprocultivo 
 IF name_servicio_param = 'ac_coprocultivo' THEN IF(
SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM ac_coprocultivo
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- coproparasitologico 
 IF name_servicio_param = 'ac_coproparasitologico' THEN IF(
SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM ac_coproparasitologico
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF;
-- examen inmunologico 
 IF name_servicio_param = 'examen_inmunologico' THEN IF(
SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM examen_inmunologico
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'audiometria_2023' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM audiometria_2023
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 42664426; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'historia_oc_info' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM historia_oc_info
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'audiometria_po' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM ficha_audiologica
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 74723311; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; ELSE dni_user_registro_var := 1; END IF; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_adic
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF(empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN dni_user_registro_var := 55555555; ELSE dni_user_registro_var := 1; end if; descripcion := 'SELLO DEL DOCTOR ADICIONAL'; name_digitalizacion := 'SELLOFIRMADOCASIG-EXTRA';
--prueba 
 dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'cuestionario_audiometria' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM cuestionario_audiometria
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'oftalmologia' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM oftalmologia
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; ELSE dni_user_registro_var := 1; END IF; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'oftalmologia_lo' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM oftalmologia_lo
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; ELSE dni_user_registro_var := 1; END IF; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'oftalmologia2021' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM oftalmologia2021
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; IF(

SELECT  sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; ELSE dni_user_registro_var := 1; END IF; descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO'; name_digitalizacion := 'SELLOFIRMADOCASIG'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'odontograma' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM odontograma
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'odontograma_lo' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  o.user_registro INTO user_registro_var
FROM odontograma_lo olo
INNER JOIN odontograma o
ON olo.n_orden = o.n_orden
WHERE olo.n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'radiografia_torax' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM radiografia_torax
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'radiografia' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM radiografia
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'oit' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM oit
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'evaluacion_musculo_esqueletica' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM evaluacion_musculo_esqueletica
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'evaluacion_musculo_esqueletica2021' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM evaluacion_musculo_esqueletica2021
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'consentimientoInformado' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'cuestionario_nordico' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM cuestionario_nordico
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'consentimiento_rayosx' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'test_fatiga_somnolencia' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM test_fatiga_somnolencia
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'informe_electrocardiograma' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM informe_electrocardiograma
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; IF completo_electro_var = TRUE THEN dni := 70436528; ELSE dni := dni_user_registro_var; END IF; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'antece_enfermedades_altura' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM antece_enfermedades_altura
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'anexo_agroindustrial' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM anexo_agroindustrial
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'consentimientobuenasalud' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'anexo7c' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM anexo7c
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'anexo16a' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM anexo16a
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'antecedentes_patologicos' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM antecedentes_patologicos
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'aptitud_medico_ocupacional_agro' THEN ---cambios por sede, por hacer 
 IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN -- SELECT user_registro INTO user_registro_var
-- 
FROM aptitud_medico_ocupacional_agro
WHERE n_orden = norden_param;

SELECT  cod_sede INTO sede_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param; IF sede_var = 3 THEN dni_user_registro_var = 88888888; ELSE IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 88888888; ELSE dni_user_registro_var = 66666666; END IF; END IF;
-- SELECT dni_user into dni_user_registro_var 
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'certificado_aptitud_medico_ocupacional' THEN ---cambios por sede, por hacer 
 IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN -- SELECT user_registro INTO user_registro_var
-- 
FROM certificado_aptitud_medico_ocupacional
WHERE n_orden = norden_param;
-- 
SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);

SELECT  cod_sede INTO sede_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param; IF sede_var = 3 THEN dni_user_registro_var = 88888888; ELSE IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 88888888; ELSE dni_user_registro_var := 66666666; END IF; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'ficha_sas' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM ficha_sas
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'certificado_aptitud_medico_resumen' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificado_aptitud_medico_resumen
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);

SELECT  cod_sede INTO sede_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param; IF sede_var = 3 THEN dni_user_registro_var = 88888888; ELSE IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 88888888; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'b_certificado_conduccion' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM b_certificado_conduccion
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'ficha_interconsulta' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  dni_user INTO dni_user_registro_var
FROM ficha_interconsulta
WHERE cod_fichaint = norden_param; IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'b_certificado_altura' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM b_certificado_altura
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'informe_psicologico' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM informe_psicologico
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'b_uso_respiradores' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM b_uso_respiradores
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'ficha_psicologica_anexo02' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM ficha_psicologica_anexo02
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'ficha_psicologica_anexo03' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM ficha_psicologica_anexo03
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'certificado_altura_poderosa' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificado_altura_poderosa
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'aptitud_altura_poderosa' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM aptitud_altura_poderosa
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'aptitud_trabajos_encaliente' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM aptitud_trabajos_encaliente
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'aptitud_licencia_conduciri' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM aptitud_licencia_conduciri
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'hoja_consulta_externa' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM hoja_consulta_externa
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'certificado_aptitud_herramientas_manuales' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificado_aptitud_herramientas_manuales
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'resumen_medico_poderosa' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM anexo7c
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 88888888; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'informe_psicolaboral' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM informe_psicolaboral
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'certificado_manipuladores_barrick' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificado_manipuladores_barrick
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'informe_psicologico_estres' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM informe_psicologico_estres
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'evaluacion_psicologica_poderosa' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM evaluacion_psicologica_poderosa
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'psicologia_espacios_confinados' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM psicologia_espacios_confinados
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'informe_riesgos_psicosociales' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM informe_riesgos_psicosociales
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'informe_burnout' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM informe_burnout
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'psicologiafobias' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  user_registro INTO user_registro_var
FROM psicologiafobias
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN dni_user_registro_var := 66666666; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'trastornos_personalidad' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM trastornos_personalidad
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'infor_conductores' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM infor_conductores
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'alto_riesgo' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM alto_riesgo
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'certificacion_medica_altura' THEN IF(

SELECT  firma_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'FIRMA DEL PACIENTE'; name_digitalizacion := 'FIRMAP'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN descripcion := 'HUELLA DEL PACIENTE'; name_digitalizacion := 'HUELLA'; dni := dni_paciente_var; RETURN NEXT; END IF; IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificacion_medica_altura
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'especificos' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM especificos
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'cuestionario_berlin' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM cuestionario_berlin
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'exam_complementarios' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM exam_complementarios
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'psi_brigadistas' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param ) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM psi_brigadistas
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var); IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN dni_user_registro_var := 42664426; END IF; descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; IF name_servicio_param = 'bombaelectrica' THEN IF(

SELECT  sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM bombaelectrica
WHERE n_orden = norden_param;

SELECT  dni_user into dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
-- dni_user_registro_var := 42664426;
-- END IF; 
 descripcion := 'SELLO DEL PROFESIONAL DE SALUD'; name_digitalizacion := 'SELLOFIRMA'; dni := dni_user_registro_var; RETURN NEXT; END IF; END IF; 
 
  IF name_servicio_param = 'cuadradorvigia' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM cuadradorvigia
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
 
 
 
 
 
 
 
 END; $BODY$ LANGUAGE plpgsql







INSERT INTO config_general_service_digital ( name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic ) values( 'trastornos_personalidad', 'formulario de trastornos de personalidad', false, false, true, false, false );

CREATE OR REPLACE FUNCTION obtener_reporte_informe_trastorno_personalidad(IN p_norden integer, IN name_service text) RETURNS TABLE( dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, codigoclinica text, tipoexamen text, edadpaciente text, paranoide_bajo boolean, paranoide_medio boolean, paranoide_alto boolean, esquizoide_bajo boolean, esquizoide_medio boolean, esquizoide_alto boolean, esquizotipico_bajo boolean, esquizotipico_medio boolean, esquizotipico_alto boolean, histrionico_bajo boolean, histrionico_medio boolean, histrionico_alto boolean, antisocial_bajo boolean, antisocial_medio boolean, antisocial_alto boolean, narcicista_bajo boolean, narcicista_medio boolean, narcicista_alto boolean, impulsivo_bajo boolean, impulsivo_medio boolean, impulsivo_alto boolean, limite_bajo boolean, limite_medio boolean, limite_alto boolean, anancastico_bajo boolean, anancastico_medio boolean, anancastico_alto boolean, dependiente_bajo boolean, dependiente_medio boolean, dependiente_alto boolean, ansioso_bajo boolean, ansioso_medio boolean, ansioso_alto boolean, observaciones text, recomendacion text, apto boolean, noapto boolean, nombresede text, sede text, color integer, namejasper text ) AS $BODY$ BEGIN RETURN QUERY
SELECT  d.cod_pa
       ,d.nombres_pa
       ,d.apellidos_pa
       ,d.direccion_pa
       ,d.sexo_pa
       ,d.fecha_nacimiento_pa
       ,d.ocupacion_pa
       ,d.lugar_nac_pa
       ,d.nivel_est_pa
       ,d.estado_civil_pa
       ,n.cargo_de
       ,n.area_o
       ,n.razon_contrata
       ,n.n_orden
       ,n.razon_empresa
       ,n.cod_clinica
       ,n.nom_examen
       ,CAST( obtener_edad(d.fecha_nacimiento_pa,current_date) AS TEXT ) -- =  =  =  =  = TRASTORNO PERSONALIDAD =  =  =  =  = 
       ,tp.grup_a_paranoide_bajo
       ,tp.grup_a_paranoide_medio
       ,tp.grup_a_paranoide_alto
       ,tp.grup_a_esquizoide_bajo
       ,tp.grup_a_esquizoide_medio
       ,tp.grup_a_esquizoide_alto
       ,tp.grup_a_esquizotipico_bajo
       ,tp.grup_a_esquizotipico_medio
       ,tp.grup_a_esquizotipico_alto
       ,tp.grup_b_histrionico_bajo
       ,tp.grup_b_histrionico_medio
       ,tp.grup_b_histrionico_alto
       ,tp.grup_b_antisocial_bajo
       ,tp.grup_b_antisocial_medio
       ,tp.grup_b_antisocial_alto
       ,tp.grup_b_narcicista_bajo
       ,tp.grup_b_narcicista_medio
       ,tp.grup_b_narcicista_alto
       ,tp.grup_b_inesta_emoci_subtip_impul_bajo
       ,tp.grup_b_inesta_emoci_subtip_impul_medio
       ,tp.grup_b_inesta_emoci_subtip_impul_alto
       ,tp.grup_b_emoci_subtip_lim_bajo
       ,tp.grup_b_emoci_subtip_lim_medio
       ,tp.grup_b_emoci_subtip_lim_alto
       ,tp.grup_c_anancastico_bajo
       ,tp.grup_c_anancastico_medio
       ,tp.grup_c_anancastico_alto
       ,tp.grup_c_dependiente_bajo
       ,tp.grup_c_dependiente_medio
       ,tp.grup_c_dependiente_alto
       ,tp.grup_c_ansioso_bajo
       ,tp.grup_c_ansioso_medio
       ,tp.grup_c_ansioso_alto
       ,tp.analisis_resulta
       ,tp.recomendacion
       ,tp.perf_cumple
       ,tp.perf_no_cumple
       ,CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'  ELSE (
SELECT  nombre_sede
FROM sede
WHERE cod_sede = n.cod_sede ) END, CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' ELSE CAST(sm.descripcion AS TEXT) END, n.color, obtener_name_jasper(p_norden, name_service)
FROM datos_paciente d
INNER JOIN n_orden_ocupacional n
ON d.cod_pa = n.cod_pa
INNER JOIN sede_multisucursal sm
ON n.cod_sede = sm.id
INNER JOIN trastornos_personalidad tp
ON tp.n_orden = n.n_orden
WHERE n.n_orden = p_norden; END; $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_name_jasper(norden_param bigint, name_service_param text) RETURNS text AS $BODY$ DECLARE resultado text; name_empresa_busqueda_var text; name_valor_microbiologia_var text; name_valor_hepatitisa_var text; name_valor_hepatitisc_var text; valor_coproparasitologico_var boolean; valor_cuantitativo_antigeno_var boolean; valor_formato_marsa_var boolean; valor_electro_cardiograma boolean; BEGIN -- Obtener el nombre de la empresa de la historia clinica a registrar; 

SELECT  trim(razon_empresa) INTO name_empresa_busqueda_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param;
-- obtener el valor del txt en microbiologia 
SELECT  trim(txtkoh) INTO name_valor_microbiologia_var
FROM microbiologia
WHERE n_orden = norden_param;
-- obtener el valor del txt en hepatitis 
SELECT  trim(txthepatitisa) INTO name_valor_hepatitisa_var
FROM lhepatitis
WHERE n_orden = norden_param;

SELECT  trim(hepatitisc) INTO name_valor_hepatitisc_var
FROM lhepatitis
WHERE n_orden = norden_param;
-- obtener el valor del boolean en coproparasitologico 
SELECT  tipo_coproparasitologico INTO valor_coproparasitologico_var
FROM ac_coproparasitologico
WHERE n_orden = norden_param;
-- obtener los valores de los booleanos en examen inmunologico 
SELECT  cuantitativo_antigeno
       ,formato_marsa INTO valor_cuantitativo_antigeno_var
       ,valor_formato_marsa_var
FROM examen_inmunologico
WHERE n_orden = norden_param;
-- obtener valor boolean del campo informe_completo de electro cardiograma 
SELECT  CASE WHEN informe_completo IS NULL THEN TRUE  ELSE informe_completo END AS informe_completo INTO valor_electro_cardiograma
FROM informe_electrocardiograma
WHERE n_orden = norden_param; IF name_service_param = 'con_panel10D' THEN resultado := 'Consentimiento_Panel10D_Digitalizado'; ELSIF name_service_param = 'con_panel5D' THEN IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'Consentimiento_Panel5D_ohla_Digitalizado'; ELSE resultado := 'Consentimiento_Panel5D_Digitalizado'; END IF; ELSIF name_service_param = 'con_panel3D' THEN resultado := 'Consentimiento_Panel3D_Digitalizado'; ELSIF name_service_param = 'con_panel2D' THEN resultado := 'Consentimiento_Panel2D_Digitalizado'; ELSIF name_service_param = 'consent_Muestra_Sangre' THEN resultado := 'Consentimiento_Muestra_Sangre_Digitalizado'; ELSIF name_service_param = 'consent_marihuana' THEN resultado := 'Consentimiento_Marihuana_Digitalizado'; ELSIF name_service_param = 'consent_Boro' THEN resultado := 'Consentimiento_Boro_Digitalizado'; ELSIF name_service_param = 'analisis_bioquimicos' THEN resultado := 'AnalisisBioquimicos_Digitalizado'; ELSIF name_service_param = 'lab_clinico' THEN resultado := 'LaboratorioClinico_Digitalizado'; ELSIF name_service_param = 'hemograma_autom' THEN resultado := 'Hematologia_Digitalizado'; ELSIF name_service_param = 'lgonadotropina' THEN resultado := 'LGonadotropina_Digitalizado'; ELSIF name_service_param = 'panel2d' THEN resultado := 'Panel2d_Digitalizado'; ELSIF name_service_param = 'panel3d' THEN resultado := 'Panel3d_Digitalizado'; ELSIF name_service_param = 'toxicologia' THEN IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'ResultadosPanel5d_ohla_Digitalizado'; ELSE resultado := 'ResultadosPanel5d_Digitalizado'; END IF; ELSIF name_service_param = 'panel10d' THEN resultado := 'Panel10d_Digitalizado'; ELSIF name_service_param = 'inmunologia' THEN resultado := 'InmunologiaLab_Digitalizado'; ELSIF name_service_param = 'microbiologia' THEN IF name_valor_microbiologia_var IS NOT NULL
AND LENGTH(name_valor_microbiologia_var) > 0 THEN resultado := 'Microbiologia1_Digitalizado'; ELSE resultado := 'Microbiologia_Digitalizado'; END IF; ELSIF name_service_param = 'lhepatitis' THEN IF name_valor_hepatitisa_var IS NOT NULL
AND LENGTH(name_valor_hepatitisa_var) > 0 THEN resultado := 'LHepatitisA_Digitalizado'; ELSIF name_valor_hepatitisc_var IS NOT NULL
AND LENGTH(name_valor_hepatitisc_var) > 0 THEN resultado := 'LHepatitisC_Digitalizado'; ELSE resultado := 'LHepatitisB_Digitalizado'; END IF; ELSIF name_service_param = 'l_bioquimica' THEN resultado := 'LBioquimica_Digitalizado'; ELSIF name_service_param = 'ac_bioquimica2022' THEN resultado := 'AnalisisClinicosB_Digitalizado'; ELSIF name_service_param = 'perfil_hepatico' THEN resultado := 'PerfilHepatico_Digitalizado'; ELSIF name_service_param = 'ac_coprocultivo' THEN resultado := 'coprocultivo_digitalizado'; ELSIF name_service_param = 'ac_coproparasitologico' THEN IF valor_coproparasitologico_var = true THEN resultado := 'Coproparasitologico_Digitalizado'; ELSE resultado := 'ParasitologiaSeriado_Digitalizado'; END IF; ELSIF name_service_param = 'examen_inmunologico' THEN IF valor_cuantitativo_antigeno_var = true THEN resultado := 'pcuantiantigeno'; ELSE IF valor_formato_marsa_var = true THEN resultado := 'pcualitativaantigenoMarsa'; ELSE resultado := 'pcualitativaantigeno'; END IF; END IF; ELSIF name_service_param = 'audiometria_2023' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'Audiometria2021-_Digitalizado_boro'; ELSE resultado := 'Audiometria2021-_Digitalizado'; END IF; ELSIF name_service_param = 'historia_oc_info' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'HistoriaOcupacional_Digitalizado_boro'; ELSE resultado := 'HistoriaOcupacional_Digitalizado'; END IF; ELSIF name_service_param = 'audiometria_po' THEN resultado := 'FichaAudiologica_Digitalizado'; ELSIF name_service_param = 'cuestionario_audiometria' THEN resultado := 'CuestionarioAudiometria_Digitalizado'; ELSIF name_service_param = 'oftalmologia_lo' THEN resultado := 'OftalmologiaLO'; ELSIF name_service_param = 'oftalmologia' THEN resultado := 'Oftalmologia'; ELSIF name_service_param = 'oftalmologia_reporte' THEN resultado := 'ReporteOftalmologico'; ELSIF name_service_param = 'oftalmologia2021' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'EvaluacionOftalmologica2021_Digitalizado_boro'; ELSIF name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'EvaluacionOftalmologica2021_Digitalizado_ohla'; ELSE resultado := 'EvaluacionOftalmologica2021_Digitalizado'; END IF; ELSIF name_service_param = 'odontograma' THEN resultado := 'Odontograma_Digitalizado'; ELSIF name_service_param = 'odontograma_lo' THEN resultado := 'Odontograma_lo_Digitalizado'; ELSIF name_service_param = 'radiografia_torax' THEN resultado := 'RagiografiaToraxPA_Digitalizado'; ELSIF name_service_param = 'radiografia_fechas' THEN resultado := 'ReporteFechasRadiografia_Digitalizado'; ELSIF name_service_param = 'radiografia' THEN resultado := 'RAYOSXXXOFI_Digitalizado'; ELSIF name_service_param = 'oit' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'OIT_Digitalizado_boro'; ELSE resultado := 'OIT_Digitalizado'; END IF; ELSIF name_service_param = 'evaluacion_musculo_esqueletica' THEN resultado := 'EvaluacionMuscoloEsqueletica'; ELSIF name_service_param = 'evaluacion_musculo_esqueletica2021' THEN resultado := 'EvaluacionMuscoloEsqueletica2021_Digitalizado_boro'; ELSIF name_service_param = 'consentimientoInformado' THEN resultado := 'conInformadoOcupacional_Digitalizado'; ELSIF name_service_param = 'cuestionario_nordico' THEN resultado := 'CuestionarioNordico'; ELSIF name_service_param = 'consentimiento_rayosx' THEN resultado := 'ConsentimientoRayosX_Digitalizado'; ELSIF name_service_param = 'test_fatiga_somnolencia' THEN resultado := 'TestFatigaSomnolenia_Digitalizado_boro'; ELSIF name_service_param = 'informe_electrocardiograma' THEN IF valor_electro_cardiograma = TRUE THEN resultado := 'InformeElectrocardiograma2023'; ELSE resultado := 'InformeElectrocardiograma_Digitalizado'; END IF; ELSIF name_service_param = 'antece_enfermedades_altura' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'AnexoCB_boro_Digitalizado'; ELSE resultado := 'AnexoCB_Digitalizado'; END IF; ELSIF name_service_param = 'anexo_agroindustrial' THEN resultado := 'Anexo2'; ELSIF name_service_param = 'consentimientobuenasalud' THEN resultado := 'ConsentimientoBuenaSalud2021_Digitalizado'; ELSIF name_service_param = 'anexo7c' THEN resultado := 'Anexo7C_Boro'; ELSIF name_service_param = 'anexo16a' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'Anexo16ABoro_Digitalizado'; ELSE resultado := 'Anexo16A_Digitalizado'; END IF; ELSIF name_service_param = 'antecedentes_patologicos' THEN IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN resultado := 'ficha_antecedente_patologico_boro'; ELSE resultado := 'ficha_antecedente_patologico_Digitalizado'; END IF; ELSIF name_service_param = 'aptitud_medico_ocupacional_agro' THEN resultado := 'Aptitud_Agroindustrial'; ELSIF name_service_param = 'certificado_aptitud_medico_ocupacional' THEN IF name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN resultado := 'Aptitud_medico_ocupacional_11'; ELSE resultado := 'Aptitud_medico_ocupacional_F'; END IF; ELSIF name_service_param = 'ficha_sas' THEN resultado := 'FichaDetencionSAS_boro_Digitalizado'; ELSIF name_service_param = 'certificado_aptitud_medico_resumen' THEN resultado := 'Aptitud_medico_resumen_Digitalizado'; ELSIF name_service_param = 'b_certificado_conduccion' THEN resultado := 'certificaciondeconduccion_Digitalizado_boro'; ELSIF name_service_param = 'ficha_interconsulta' THEN resultado := 'Ficha_interconsulta_Digitalizado'; ELSIF name_service_param = 'b_certificado_altura' THEN resultado := 'Certificacion_suficiencia_trabajos_en_altura_boro_Digitalizado'; ELSIF name_service_param = 'informe_psicologico' THEN resultado := 'InformePsicologico_Digitalizado'; ELSIF name_service_param = 'b_uso_respiradores' THEN resultado := 'UsoRespiradores'; ELSIF name_service_param = 'ficha_psicologica_anexo02' THEN resultado := 'InformePsicologico_Anexo02_Digitalizado'; ELSIF name_service_param = 'ficha_psicologica_anexo03' THEN resultado := 'FichaPsicologicaOcupacional_Digitalizado'; ELSIF name_service_param = 'certificado_altura_poderosa' THEN resultado := 'CertificadoAlturaPoderosa_Digitalizado'; ELSIF name_service_param = 'hoja_consulta_externa' THEN resultado := 'Hoja_Consulta_Externa'; ELSIF name_service_param = 'aptitud_altura_poderosa' THEN resultado := 'Aptitud_Poderosa_Digitalizado'; ELSIF name_service_param = 'aptitud_trabajos_encaliente' THEN resultado := 'Aptitud_Trabajos_EnCaliente_Digitalizado'; ELSIF name_service_param = 'aptitud_licencia_conduciri' THEN resultado := 'Aptitud_Licencia_Conducir_Interna_Digitalizado'; ELSIF name_service_param = 'certificado_aptitud_herramientas_manuales' THEN resultado := 'Certificado_Aptitud_Herramientas_Manuales_Digitalizado'; ELSIF name_service_param = 'informe_psicolaboral' THEN resultado := 'Informe_PsicolaboralBoroo_Digitalizado'; ELSIF name_service_param = 'certificado_manipuladores_barrick' THEN resultado := 'CertificadoMedicoManipuladores_Barrick_Digitalizado'; ELSIF name_service_param = 'informe_psicologico_estres' THEN resultado := 'InformePsicologicoAdecoEstres_Digitalizado'; ELSIF name_service_param = 'evaluacion_psicologica_poderosa' THEN resultado := 'InformePsicologico_Digitalizado'; ELSIF name_service_param = 'psicologia_espacios_confinados' THEN resultado := 'formatPsicologia_SuficienciaEspaciosC'; ELSIF name_service_param = 'informe_riesgos_psicosociales' THEN resultado := 'Informe_Riesgos_Psicosociales_Digitalizado'; ELSIF name_service_param = 'informe_burnout' THEN resultado := 'Informe_burnout_Digitalizado'; ELSIF name_service_param = 'psicologiafobias' THEN resultado := 'formatPsicologia_Digitalizado'; ELSIF name_service_param = 'calidad_sueño' THEN resultado := 'CUESTIONARIO_CALIDAD_DE_SUEÑO_Digitalizado'; ELSIF name_service_param = 'trastornos_personalidad' THEN resultado := 'Informe_Psico_Test_Personalidad'; ELSIF name_service_param = 'infor_conductores' THEN resultado := 'Informe_Psico_Conductores'; ELSIF name_service_param = 'certificacion_medica_altura' THEN resultado := 'A_CertificacionMedicaPTA_Digitalizado'; ELSIF name_service_param = 'alto_riesgo' THEN resultado := 'Informe_Psico_Alto_Riesgo'; ELSIF name_service_param = 'especificos' THEN resultado := 'Informe_Psico_Especificos'; ELSIF name_service_param = 'cuestionario_berlin' THEN resultado := 'Informe_Psico_Cuestionario_Berlin'; END IF; RETURN resultado; END; $BODY$ LANGUAGE plpgsql VOLATILE COST 100; 

ALTER FUNCTION obtener_name_jasper(bigint, text) OWNER TO pierola;

CREATE OR REPLACE FUNCTION obtener_existencias_examenes(nOrden INTEGER) RETURNS TABLE (existe BOOLEAN, nameService TEXT) LANGUAGE plpgsql AS $$ BEGIN RETURN QUERY
SELECT  EXISTS(
SELECT  1
FROM certificado_aptitud_medico_ocupacional
WHERE n_orden = nOrden ), 'certificado_aptitud_medico_ocupacional' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM anexo7c
WHERE n_orden = nOrden ), 'anexo7c' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM antece_enfermedades_altura
WHERE n_orden = nOrden ), 'antece_enfermedades_altura' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM anexo16a
WHERE n_orden = nOrden ), 'anexo16a' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM b_uso_respiradores
WHERE n_orden = nOrden ), 'b_uso_respiradores' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM historia_oc_info
WHERE n_orden = nOrden ), 'historia_oc_info' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM antecedentes_patologicos
WHERE n_orden = nOrden ), 'antecedentes_patologicos' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM cuestionario_nordico
WHERE n_orden = nOrden ), 'cuestionario_nordico' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM evaluacion_musculo_esqueletica
WHERE n_orden = nOrden ), 'evaluacion_musculo_esqueletica' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM lab_clinico
WHERE n_orden = nOrden ), 'lab_clinico' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM analisis_bioquimicos
WHERE n_orden = nOrden ), 'analisis_bioquimicos' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM radiografia_torax
WHERE n_orden = nOrden ), 'radiografia_torax' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM audiometria_po
WHERE n_orden = nOrden ), 'audiometria_po' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM ficha_audiologica
WHERE n_orden = nOrden ), 'ficha_audiologica' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM informe_psicologico
WHERE n_orden = nOrden ), 'informe_psicologico' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM oftalmologia
WHERE n_orden = nOrden ), 'oftalmologia' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM consentimientoInformado
WHERE n_orden = nOrden ), 'consentimientoInformado' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM triaje
WHERE n_orden = nOrden ), 'triaje' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM informe_electrocardiograma
WHERE n_orden = nOrden ), 'informe_electrocardiograma' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM funcion_abs
WHERE n_orden = nOrden ), 'funcion_abs' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM odontograma
WHERE n_orden = nOrden ), 'odontograma' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM certificacion_medica_altura
WHERE n_orden = nOrden ), 'certificacion_medica_altura' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM ficha_sas
WHERE n_orden = nOrden ), 'ficha_sas' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM consentimiento_dosaje
WHERE n_orden = nOrden ), 'consentimiento_dosaje' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM perimetro_toracico
WHERE n_orden = nOrden ), 'perimetro_toracico' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM ex_radiograficos_sanguineos
WHERE n_orden = nOrden ), 'ex_radiograficos_sanguineos' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM b_certificado_altura
WHERE n_orden = nOrden ), 'b_certificado_altura' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM b_certificado_conduccion
WHERE n_orden = nOrden ), 'b_certificado_conduccion' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM oit
WHERE n_orden = nOrden ), 'oit' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM cuestionario_audiometria
WHERE n_orden = nOrden ), 'cuestionario_audiometria' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM informe_audiometria
WHERE n_orden = nOrden ), 'informe_audiometria' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM anexo7c2
WHERE n_orden = nOrden ), 'anexo7c2' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM certificado_aptitud_medico_ocupacional1
WHERE n_orden = nOrden ), 'certificado_aptitud_medico_ocupacional1' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM aptitud_medico_ocupacional_agro
WHERE n_orden = nOrden ), 'aptitud_medico_ocupacional_agro' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM anexo_agroindustrial
WHERE n_orden = nOrden ), 'anexo_agroindustrial' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM certificado_aptitud_anexo02
WHERE n_orden = nOrden ), 'certificado_aptitud_anexo02' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM anexo_02
WHERE n_orden = nOrden ), 'anexo_02' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM audiometria_2021
WHERE n_orden = nOrden ), 'audiometria_2021' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM evaluacion_musculo_esqueletica2021
WHERE n_orden = nOrden ), 'evaluacion_musculo_esqueletica2021' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM cuestionario_calidad_sueno
WHERE n_orden = nOrden ), 'cuestionario_calidad_sueno' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM test_fatiga_somnolencia
WHERE n_orden = nOrden ), 'test_fatiga_somnolencia' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM oftalmologia2021
WHERE n_orden = nOrden ), 'oftalmologia2021' 
UNION ALL
SELECT  EXISTS(
SELECT  1
FROM certificado_manipuladores_barrick
WHERE n_orden = nOrden ), 'certificado_manipuladores_barrick'; END; $$;

CREATE OR REPLACE FUNCTION obtener_existencias_examenes(p_n_orden BIGINT) RETURNS TABLE ( tieneTriaje BOOLEAN, tieneLabClinico BOOLEAN, tieneInformeElectrocardiograma BOOLEAN, tieneRadiografiaTorax BOOLEAN, tieneFichaAudiologica BOOLEAN, tieneAudiometriaPo BOOLEAN, tieneFuncionAbs BOOLEAN, tieneOdontograma BOOLEAN, tieneInformePsicologico BOOLEAN, tieneAnexo16a BOOLEAN, tieneHistoriaOcInfo BOOLEAN, tieneAntecedentesPatologicos BOOLEAN, tieneCuestionarioNordico BOOLEAN, tieneCertificacionMedicaAltura BOOLEAN, tieneFichaSas BOOLEAN, tieneConsentimientoDosaje BOOLEAN, tienePerimetroToracico BOOLEAN, tieneExRadiograficosSanguineos BOOLEAN, tieneAnexo7c BOOLEAN, tieneOftalmologia BOOLEAN, tieneBCertificadoAltura BOOLEAN, tieneBCertificadoConduccion BOOLEAN, tieneBUsoRespiradores BOOLEAN, tieneCertificadoAptitudMoc BOOLEAN, tieneOit BOOLEAN, tieneCuestionarioAudiometria BOOLEAN, tieneInformeAudiometria BOOLEAN, tieneEvaluacionMusculoEsqueletica BOOLEAN, tieneAnexo7c2 BOOLEAN, tieneCertificadoAptitudMoc1 BOOLEAN, tieneAptoAgroindustrial BOOLEAN, tieneAnexoAgroindustrial BOOLEAN, tieneCertificadoAnexo02 BOOLEAN, tieneAnexo02 BOOLEAN, tieneAudiometria2021 BOOLEAN, tieneEvaluacionMusculoEsqueletica2021 BOOLEAN, tieneCuestionarioCalidadSueno BOOLEAN, tieneTestFatigaSomnolencia BOOLEAN, tieneOftalmologia2021 BOOLEAN, tieneCertificadoManipuladoresBarrick BOOLEAN ) AS $$ BEGIN RETURN QUERY
SELECT  CASE WHEN t.n_orden IS NULL THEN FALSE  ELSE TRUE END     AS tieneTriaje
       ,CASE WHEN lc.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneLabClinico
       ,CASE WHEN ie.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneInformeElectrocardiograma
       ,CASE WHEN rt.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneRadiografiaTorax
       ,CASE WHEN fa.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneFichaAudiologica
       ,CASE WHEN ap.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneAudiometriaPo
       ,CASE WHEN fab.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneFuncionAbs
       ,CASE WHEN od.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneOdontograma
       ,CASE WHEN ip.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneInformePsicologico
       ,CASE WHEN a16.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneAnexo16a
       ,CASE WHEN hoi.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneHistoriaOcInfo
       ,CASE WHEN ap2.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneAntecedentesPatologicos
       ,CASE WHEN cn.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneCuestionarioNordico
       ,CASE WHEN cma.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneCertificacionMedicaAltura
       ,CASE WHEN fs.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneFichaSas
       ,CASE WHEN cd.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneConsentimientoDosaje
       ,CASE WHEN pt.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tienePerimetroToracico
       ,CASE WHEN ers.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneExRadiograficosSanguineos
       ,CASE WHEN a7.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneAnexo7c
       ,CASE WHEN oft.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneOftalmologia
       ,CASE WHEN bca.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneBCertificadoAltura
       ,CASE WHEN bcc.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneBCertificadoConduccion
       ,CASE WHEN bur.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneBUsoRespiradores
       ,CASE WHEN camo.n_orden IS NULL THEN FALSE  ELSE TRUE END  AS tieneCertificadoAptitudMoc
       ,CASE WHEN oit.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneOit
       ,CASE WHEN ca.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneCuestionarioAudiometria
       ,CASE WHEN ia.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneInformeAudiometria
       ,CASE WHEN eme.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneEvaluacionMusculoEsqueletica
       ,CASE WHEN a7c2.n_orden IS NULL THEN FALSE  ELSE TRUE END  AS tieneAnexo7c2
       ,CASE WHEN camo1.n_orden IS NULL THEN FALSE  ELSE TRUE END AS tieneCertificadoAptitudMoc1
       ,CASE WHEN amoag.n_orden IS NULL THEN FALSE  ELSE TRUE END AS tieneAptoAgroindustrial
       ,CASE WHEN aa.n_orden IS NULL THEN FALSE  ELSE TRUE END    AS tieneAnexoAgroindustrial
       ,CASE WHEN caa02.n_orden IS NULL THEN FALSE  ELSE TRUE END AS tieneCertificadoAnexo02
       ,CASE WHEN an02.n_orden IS NULL THEN FALSE  ELSE TRUE END  AS tieneAnexo02
       ,CASE WHEN a21.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneAudiometria2021
       ,CASE WHEN eme21.n_orden IS NULL THEN FALSE  ELSE TRUE END AS tieneEvaluacionMusculoEsqueletica2021
       ,CASE WHEN ccs.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneCuestionarioCalidadSueno
       ,CASE WHEN tfs.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneTestFatigaSomnolencia
       ,CASE WHEN oft21.n_orden IS NULL THEN FALSE  ELSE TRUE END AS tieneOftalmologia2021
       ,CASE WHEN cmb.n_orden IS NULL THEN FALSE  ELSE TRUE END   AS tieneCertificadoManipuladoresBarrick
FROM n_orden_ocupacional AS n
LEFT JOIN triaje t
ON t.n_orden = n.n_orden
LEFT JOIN lab_clinico lc
ON lc.n_orden = n.n_orden
LEFT JOIN informe_electrocardiograma ie
ON ie.n_orden = n.n_orden
LEFT JOIN radiografia_torax rt
ON rt.n_orden = n.n_orden
LEFT JOIN ficha_audiologica fa
ON fa.n_orden = n.n_orden
LEFT JOIN audiometria_po ap
ON ap.n_orden = n.n_orden
LEFT JOIN funcion_abs fab
ON fab.n_orden = n.n_orden
LEFT JOIN odontograma od
ON od.n_orden = n.n_orden
LEFT JOIN informe_psicologico ip
ON ip.n_orden = n.n_orden
LEFT JOIN anexo16a a16
ON a16.n_orden = n.n_orden
LEFT JOIN historia_oc_info hoi
ON hoi.n_orden = n.n_orden
LEFT JOIN antecedentes_patologicos ap2
ON ap2.n_orden = n.n_orden
LEFT JOIN cuestionario_nordico cn
ON cn.n_orden = n.n_orden
LEFT JOIN certificacion_medica_altura cma
ON cma.n_orden = n.n_orden
LEFT JOIN ficha_sas fs
ON fs.n_orden = n.n_orden
LEFT JOIN consentimiento_dosaje cd
ON cd.n_orden = n.n_orden
LEFT JOIN perimetro_toracico pt
ON pt.n_orden = n.n_orden
LEFT JOIN ex_radiograficos_sanguineos ers
ON ers.n_orden = n.n_orden
LEFT JOIN anexo7c a7
ON a7.n_orden = n.n_orden
LEFT JOIN oftalmologia oft
ON oft.n_orden = n.n_orden
LEFT JOIN b_certificado_altura bca
ON bca.n_orden = n.n_orden
LEFT JOIN b_certificado_conduccion bcc
ON bcc.n_orden = n.n_orden
LEFT JOIN b_uso_respiradores bur
ON bur.n_orden = n.n_orden
LEFT JOIN certificado_aptitud_medico_ocupacional camo
ON camo.n_orden = n.n_orden
LEFT JOIN oit oit
ON oit.n_orden = n.n_orden
LEFT JOIN cuestionario_audiometria ca
ON ca.n_orden = n.n_orden
LEFT JOIN informe_audiometria ia
ON ia.n_orden = n.n_orden
LEFT JOIN evaluacion_musculo_esqueletica eme
ON eme.n_orden = n.n_orden
LEFT JOIN anexo7c2 a7c2
ON a7c2.n_orden = n.n_orden
LEFT JOIN certificado_aptitud_medico_ocupacional1 camo1
ON camo1.n_orden = n.n_orden
LEFT JOIN aptitud_medico_ocupacional_agro amoag
ON amoag.n_orden = n.n_orden
LEFT JOIN anexo_agroindustrial aa
ON aa.n_orden = n.n_orden
LEFT JOIN certificado_aptitud_anexo02 caa02
ON caa02.n_orden = n.n_orden
LEFT JOIN anexo_02 an02
ON an02.n_orden = n.n_orden
LEFT JOIN audiometria_2021 a21
ON a21.n_orden = n.n_orden
LEFT JOIN evaluacion_musculo_esqueletica2021 eme21
ON eme21.n_orden = n.n_orden
LEFT JOIN cuestionario_calidad_sueno ccs
ON ccs.n_orden = n.n_orden
LEFT JOIN test_fatiga_somnolencia tfs
ON tfs.n_orden = n.n_orden
LEFT JOIN oftalmologia2021 oft21
ON oft21.n_orden = n.n_orden
LEFT JOIN certificado_manipuladores_barrick cmb
ON cmb.n_orden = n.n_orden
WHERE n.n_orden = p_n_orden; END; $$ LANGUAGE plpgsql;

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