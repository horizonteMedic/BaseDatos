select n_orden from n_orden_ocupacional limit 1

SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM certificado_aptitud_medico_resumen WHERE n_orden = norden_param;

alter table aptitud_trabajos_encaliente add column usuario_firma text

DROP FUNCTION obtener_reporte_aptitud_certificado_caliente(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_aptitud_certificado_caliente(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, fechaexamen date, fechahasta date, nombremedico text, apto boolean, aptorestriccion boolean, aptotemporal boolean, noapto boolean, observaciones text, horasalida time without time zone, nombresede text, numerosede text, sede text, color integer, namejasper text, explotacion text, usuarioFirma text) AS
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
	    ca.fecha_examen,
	    ca.fecha_hasta,
	    ca.nom_medico,
	    ca.chkapto,
	    ca.chkapto_restriccion,
	    ca.chkno_apto_temporal,
	    ca.chkno_apto,
	    ca.txtobservaciones,
	    ca.horasalida,
	    CASE 
		WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' 
		    THEN 'Huamachuco'
		ELSE (
		    SELECT nombre_sede 
		    FROM sede 
		    WHERE cod_sede = n.cod_sede
		)
	    END AS nombre_sede,
	    CASE 
		WHEN n.cod_sede = 1 
		    THEN CONCAT(n.n_orden, '-T')
		WHEN n.cod_sede = 4 
		    THEN CONCAT(n.n_orden, '-TP')
		ELSE CONCAT(n.n_orden, '-H')
	    END AS numero,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    n.color,
	    obtener_name_jasper(p_norden, name_service),
	    n.nom_ex,
	    ca.usuario_firma
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN aptitud_trabajos_encaliente AS ca 
	    ON ca.n_orden = n.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

alter table aptitud_altura_poderosa add column usuario_firma text

DROP FUNCTION obtener_reporte_aptitud_altura_poderosa(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_aptitud_altura_poderosa(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, fechaexamen date, fechahasta date, nombremedico text, apto boolean, aptorestriccion boolean, aptotemporal boolean, noapto boolean, observaciones text, horasalida time without time zone, hemoglobina_txthemoglobina text, hematocritolabclinico_txthematocrito text, vsglabclinico_txtvsg text, glucosalabclinico_txtglucosabio text, creatininalabclinico_txtcreatininabio text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, nombresede text, numerosede text, sede text, color integer, namejasper text, usuarioFirma text) AS
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
	    ca.fecha_examen,
	    ca.fecha_hasta,
	    ca.nom_medico,
	    ca.chkapto,
	    ca.chkapto_restriccion,
	    ca.chkno_apto_temporal,
	    ca.chkno_apto,
	    ca.txtobservaciones,
	    ca.horasalida,
	    l.txthemoglobina,
	    l.txthematocrito,
	    l.txtvsg,
	    l.txtglucosabio,
	    l.txtcreatininabio,
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
	    
	    CASE  
		WHEN oft.txtdiagnostico IS NOT NULL 
		    THEN oft.txtdiagnostico  
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
	    CASE 
		WHEN n.cod_sede = 1 
		    THEN CONCAT(n.n_orden, '-T')
		WHEN n.cod_sede = 4 
		    THEN CONCAT(n.n_orden, '-TP')
		ELSE CONCAT(n.n_orden, '-H')
	    END AS numero,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    n.color,
	    obtener_name_jasper(p_norden, name_service),
	    ca.usuario_firma
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	LEFT JOIN aptitud_altura_poderosa AS ca 
	    ON ca.n_orden = n.n_orden
	LEFT JOIN lab_clinico AS l 
	    ON l.n_orden = n.n_orden
	LEFT JOIN oftalmologia AS o 
	    ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol 
	    ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft 
	    ON n.n_orden = oft.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

DROP FUNCTION obtener_reporte_certificado_conduccion(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_certificado_conduccion(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, tiempoexperiencia_t_experiencia text, primeraaptitud_chk_primera boolean, revalidacion_chk_revalidacion boolean, fechaexamen_f_examen date, antecedentestodasenfermedadessi_chk_1_si boolean, antecedentestodasenfermedadesno_chk_1_no boolean, antecedentesalcoholismocronicosi_chk_2_si boolean, antecedentesalcoholismocronicono_chk_2_no boolean, antecedentesenfermedadesinvoluntariossi_chk_3_si boolean, antecedentesenfermedadesinvoluntariosno_chk_3_no boolean, antecedentesperdidaconcienciasi_chk_4_si boolean, antecedentesperdidaconcienciano_chk_4_no boolean, antecedentesanemiagradosi_chk_5_si boolean, antecedentesanemiagradono_chk_5_no boolean, chk6si_chk_6_si boolean, chk6no_chk_6_no boolean, antecedentesvariosefectossi_chk_7_si boolean, antecedentesvariosefectosno_chk_7_no boolean, antecedentesconsumesustanciasnoalteresi_chk_8_si boolean, antecedentesconsumesustanciasnoaltereno_chk_8_no boolean, antecedentesconsumesustanciassialteresi_chk_9_si boolean, antecedentesconsumesustanciassialtereno_chk_9_no boolean, antecedentesapneasi_chk_10_si boolean, antecedentesapneano_chk_10_no boolean, antecedentesobesidadsi_chk_11_si boolean, antecedentesobesidadno_chk_11_no boolean, chk12si_chk_12_si boolean, chk12no_chk_12_no boolean, pcomplementariashipoacusiasi_chk_13_si boolean, pcomplementariashipoacusiano_chk_13_no boolean, pcomplementariasalteracionagudezavisualsi_chk_14_si boolean, pcomplementariasalteracionagudezavisualno_chk_14_no boolean, pcomplementariasampliometriaanormalsi_chk_15_si boolean, pcomplementariasampliometriaanormalno_chk_15_no boolean, chk16si_chk_16_si boolean, chk16no_chk_16_no boolean, pcomplementariasnocolorsi_chk_17_si boolean, pcomplementariasnocolorno_chk_17_no boolean, pcomplementariaspruebavisionsi_chk_18_si boolean, pcomplementariaspruebavisionno_chk_18_no boolean, pcomplementariaspsicosensometricaalteradasi_chk_19_si boolean, pcomplementariaspsicosensometricaalteradano_chk_19_no boolean, chk20si_chk_20_si boolean, chk20no_chk_20_no boolean, examenfisicolimitacionsi_chk_21_si boolean, examenfisicolimitacionno_chk_21_no boolean, examenfisicoaleracionpresentesi_chk_22_si boolean, examenfisicoaleracionpresenteno_chk_22_no boolean, examenfisicoanormalidadmarchasi_chk_23_si boolean, examenfisicoanormalidadmarchano_chk_23_no boolean, examenfisicoalteracioncoordinacionsi_chk_24_si boolean, examenfisicoalteracioncoordinacionno_chk_24_no boolean, examefisiconistagmussi_chk_25_si boolean, examefisiconistagmusno_chk_25_no boolean, examenfisicoanormalidadmovimientosi_chk_26_si boolean, examenfisicoanormalidadmovimientono_chk_26_no boolean, examenfisicocirlasi_chk_27_si boolean, examenfisicocirlano_chk_27_no boolean, examenfisicoanormalidadlenguajesi_chk_28_si boolean, examenfisicoanormalidadlenguajeno_chk_28_no boolean, examenfisicomovimientoinvoluntariosi_chk_29_si boolean, examenfisicomovimientoinvoluntariono_chk_29_no boolean, examenfisicoasimetriafacialsi_chk_30_si boolean, examenfisicoasimetriafacialno_chk_30_no boolean, fechadesde_f_desde date, fechahasta_f_hasta date, apto_chk_si boolean, noapto_chk_no boolean, observado_chk_observado boolean, observacionesrecomendaciones_b_c_observaciones text, detallemedicinas_d_medicina text, detalleinformacion_d_informacion text, aptoconrestriccion_chk_apto_r boolean, otrosdescripcion_txtotros text, antecedentesdiabetesmellitus_diabete_mellitus boolean, antecedentesinsuficienciarenal_insuficiencia_renaliv boolean, pcomplementariastestsas_testsas boolean, examenfisicosustentacionpie_sustentacionpie boolean, antecedentescomentariosdetalles_comendetalleantecedentes text, tallatriaje text, pesotriaje text, imctriaje text, cinturatriaje text, icctriaje text, caderatriaje text, temperatura text, frecuenciacardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje text, sistolica text, diastolica text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, conclusiontriaje text, frecuenciarespiratoriatriaje_f_respiratoria text, grado3fichasas_chkgradoiii boolean, grado4fichasas_chkgradoiiii boolean, aptocriterioesifichasas_chk1_apto_sie boolean, tiempolicenciabsas_t_licencia text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, diagnosticoaudiometria text, nombresede text, sede text, color integer, namejasper text, usuariofirma text, laboratorioClinicoHemoglobina text) AS
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
	    t.cod_certificado,
	    t.t_experiencia,
	    t.chk_primera,
	    t.chk_revalidacion,
	    t.f_examen,
	    t.chk_1_si, t.chk_1_no,
	    t.chk_2_si, t.chk_2_no,
	    t.chk_3_si, t.chk_3_no,
	    t.chk_4_si, t.chk_4_no,
	    t.chk_5_si, t.chk_5_no,
	    t.chk_6_si, t.chk_6_no,
	    t.chk_7_si, t.chk_7_no,
	    t.chk_8_si, t.chk_8_no,
	    t.chk_9_si, t.chk_9_no,
	    t.chk_10_si, t.chk_10_no,
	    t.chk_11_si, t.chk_11_no,
	    t.chk_12_si, t.chk_12_no,
	    t.chk_13_si, t.chk_13_no,
	    t.chk_14_si, t.chk_14_no,
	    t.chk_15_si, t.chk_15_no,
	    t.chk_16_si, t.chk_16_no,
	    t.chk_17_si, t.chk_17_no,
	    t.chk_18_si, t.chk_18_no,
	    t.chk_19_si, t.chk_19_no,
	    t.chk_20_si, t.chk_20_no,
	    t.chk_21_si, t.chk_21_no,
	    t.chk_22_si, t.chk_22_no,
	    t.chk_23_si, t.chk_23_no,
	    t.chk_24_si, t.chk_24_no,
	    t.chk_25_si, t.chk_25_no,
	    t.chk_26_si, t.chk_26_no,
	    t.chk_27_si, t.chk_27_no,
	    t.chk_28_si, t.chk_28_no,
	    t.chk_29_si, t.chk_29_no,
	    t.chk_30_si, t.chk_30_no,
	    t.f_desde,
	    t.f_hasta,
	    t.chk_si,
	    t.chk_no,
	    t.chk_observado,
	    t.b_c_observaciones,
	    t.d_medicina,
	    t.d_informacion,
	    t.chk_apto_r,
	    t.txtotros,
	    t.diabete_mellitus,
	    t.insuficiencia_renalIV,
	    t.testSAS,
	    t.sustentacionpie,
	    t.comenDetalleAntecedentes,
	    c.talla,
	    c.peso,
	    c.imc,
	    c.cintura,
	    c.icc,
	    c.cadera,
	    c.temperatura,
	    c.f_cardiaca,
	    c.sat_02,
	    c.perimetro_cuello,
	    c.sistolica,
	    c.diastolica,
	    c.fvc, c.fev_1, c.fev1_fvc, c.fef25_75, c.conclusion,
	    c.f_respiratoria,
	    fsa.chkgradoiii, 
	    fsa.chkgradoiiii, 
	    fsa.chk1_apto_sie,
	    s.t_licencia,
	    p.p_max_inspiracion,
	    p.p_ex_forzada,
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
		WHEN au.o_d_500 IS NOT NULL THEN au.o_d_500 
		ELSE m.o_d_500 
	    END AS o_d_500,
	    
	    CASE 
		WHEN au.o_d_1000 IS NOT NULL THEN au.o_d_1000 
		ELSE m.o_d_1000 
	    END AS o_d_1000,
	    
	    CASE 
		WHEN au.o_d_2000 IS NOT NULL THEN au.o_d_2000 
		ELSE m.o_d_2000 
	    END AS o_d_2000,
	    
	    CASE 
		WHEN au.o_i_500 IS NOT NULL THEN au.o_i_500 
		ELSE m.o_i_500 
	    END AS o_i_500,
	    
	    CASE 
		WHEN au.o_i_1000 IS NOT NULL THEN au.o_i_1000 
		ELSE m.o_i_1000 
	    END AS o_i_1000,
	    
	    CASE 
		WHEN au.o_i_2000 IS NOT NULL THEN au.o_i_2000 
		ELSE m.o_i_2000 
	    END AS o_i_2000,
	    CASE
		WHEN au.txtdiag_od IS NULL AND au.txtdiag_oi IS NULL THEN m.diagnostico
		ELSE au.txtdiag_od ||', '|| au.txtdiag_oi
	    END AS diagnosticoAudiometria,

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
	    obtener_name_jasper(p_norden, name_service),
	    t.usuario_firma,
	    lc.txthemoglobina
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN 
	    triaje AS c ON n.n_orden = c.n_orden
	LEFT JOIN 
	    b_certificado_conduccion AS t ON n.n_orden = t.n_orden
	LEFT JOIN 
	    audiometria_po AS m ON n.n_orden = m.n_orden
	LEFT JOIN 
	    audiometria_2023 AS au ON n.n_orden = au.n_orden
	LEFT JOIN oftalmologia AS o ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft ON n.n_orden = oft.n_orden
	LEFT JOIN ficha_sas AS fsa ON n.n_orden = fsa.n_orden
	LEFT JOIN b_sas AS s ON s.n_orden = n.n_orden
	LEFT JOIN perimetro_toracico AS p ON p.n_orden=n.n_orden
	LEFT JOIN lab_clinico AS lc ON lc.n_orden = n.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

alter table anexo16a add column usuario_firma text

DROP FUNCTION obtener_reporte_anexo16a(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_anexo16a(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(codigoanexo16a integer, dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, direccionpaciente_direccion_pa text, sexo_sexo_pa "char", fechanacimientopaciente_fecha_nacimiento_pa date, cargo_cargo_de text, area_area_o text, contrata_razon_contrata text, norden_n_orden integer, empresa_razon_empresa text, edad_edad text, direccionclinicaanexo16a_direccion_clinica text, fechaanexo16a_fecha_anexo date, nombreusuario_nombre_user text, apellidousuario_apellido_user text, cmpusuario_cmp_user text, aptoanexo16a_apto boolean, noaptoanexo16a_no_apto boolean, cirujiamayorrecientenoanexo16a_no1 boolean, cirujiamayorrecientesianexo16a_si1 boolean, desordencoagulacionnoanexo16a_no2 boolean, desordencoagulacionsianexo16a_si2 boolean, diabetesmellitusnoanexo16a_no3 boolean, diabetesmellitussianexo16a_si3 boolean, hipertensionarterialnoanexo16a_no4 boolean, hipertensionarterialsianexo16a_si4 boolean, embarazonoanexo16a_no5 boolean, embarazosianexo16a_si5 boolean, furdescripcionanexo16a_txtfur text, problemaneurologiconoanexo16a_no6 boolean, problemaneurologicosianexo16a_si6 boolean, infeccionrecientenoanexo16a_no7 boolean, infeccionrecientesianexo16a_si7 boolean, obesidadmorbididadnoanexo16a_no8 boolean, obesidadmorbididadsianexo16a_si8 boolean, problemascardiaconoanexo16a_no9 boolean, problemascardiacosianexo16a_si9 boolean, problemasrespiratoriosnoanexo16a_no10 boolean, problemasrespiratoriossianexo16a_si10 boolean, problemasoftalmologicosnoanexo16a_no11 boolean, problemasoftalmologicossianexo16a_si11 boolean, problemasdigestivosnoanexo16a_no12 boolean, problemasdigestivossianexo16a_si12 boolean, apneadelsuenonoanexo16a_no13 boolean, apneadelsuenosianexo16a_si13 boolean, otracondicionmedicanoanexo16a_no14 boolean, otracondicionmedicasianexo16a_si14 boolean, alergiasnoanexo16a_no15 boolean, alergiassianexo16a_si15 boolean, usomedicacionactualnoanexo16a_no16 boolean, usomedicacionactualsianexo16a_si16 boolean, medicacionactualanexo16a_m_actual text, frecuenciacardiacatriaje_f_cardiaca text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, imctriaje_imc text, saturacionoxigenotriaje_sat_02 text, pesotriaje_peso text, tallatriaje_talla text, temperaturatriaje_temperatura text, observacionesanexo16a_observaciones text, color integer, hemoglobinalaboratorioclinico_txthemoglobina text, hematocritolaboratorioclinico_txthematocrito text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, odccoftalmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, glucosalaboratorioclinico_txtglucosabio text, hallazgosinformeelectrocardiograma_hallazgo text, direccionsede text, sede text, nombresede text, namejasper text, usuarioFirma text) AS
$BODY$
BEGIN
    RETURN QUERY
	SELECT 
	    a16.cod_anexo16a,
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
	    a16.direccion_clinica,
	    a16.fecha_anexo,
	    case when n.razon_empresa = 'MONARCA GOLD S.A.C.' then (select nombre_user from usuarios where dni_user = 66666666) else u.nombre_user end,
	    case when n.razon_empresa = 'MONARCA GOLD S.A.C.' then (select apellido_user from usuarios where dni_user = 66666666) else u.apellido_user end,
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
	    obtener_name_jasper(p_norden, name_service),
	    a16.usuario_firma
	FROM datos_paciente dp
	INNER JOIN n_orden_ocupacional n
	    ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal sm 
	    ON n.cod_sede = sm.id
	INNER JOIN triaje t
	    ON n.n_orden = t.n_orden
	LEFT JOIN anexo16a a16
	    ON t.n_orden = a16.n_orden
	LEFT JOIN usuarios u
	    ON a16.dni_user = u.dni_user
	LEFT JOIN lab_clinico l
	    ON n.n_orden = l.n_orden
	LEFT JOIN informe_electrocardiograma i
	    ON n.n_orden = i.n_orden
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

alter table oftalmologia add column usuario_firma text

DROP FUNCTION obtener_reporte_oftalmologia(integer);

CREATE OR REPLACE FUNCTION obtener_reporte_oftalmologia(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_nacimiento_pa date, empresa text, contrata text, nom_examen text, sexo_pa "char", cod_of integer, num_ticket integer, v_cerca_s_od text, v_cerca_s_oi text, v_cerca_c_od text, v_cerca_c_oi text, v_lejos_s_od text, v_lejos_s_oi text, v_lejos_c_od text, v_lejos_c_oi text, v_colores text, v_binocular text, r_pupilares text, e_oculares text, fecha_of date, e_oculares1 text, e_oculvisionlejos text, f_actualizacion date, agudezavisuallejor text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, lugar_nac_pa text, direccion_pa text, ocupacion_pa text, cargo_de text, area_o text, usuario_firma text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    of.n_orden,
    noo.cod_pa,

    dp.fecha_nacimiento_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    noo.nom_examen,
    dp.sexo_pa,

    of.cod_of,
    of.num_ticket,
    of.v_cerca_s_od,
    of.v_cerca_s_oi,
    of.v_cerca_c_od,
    of.v_cerca_c_oi,
    of.v_lejos_s_od,
    of.v_lejos_s_oi,
    of.v_lejos_c_od,
    of.v_lejos_c_oi,
    of.v_colores,
    of.v_binocular,
    of.r_pupilares,
    of.e_oculares,
    of.fecha_of,
    of.e_oculares1,
    of.e_oculvisionlejos,
    of.f_actualizacion,
    of.agudezavisuallejor,

    noo.color,
    CAST(sm.descripcion AS TEXT),

    (SELECT direccion FROM sede WHERE cod_sede = 4),
    (SELECT email FROM sede WHERE cod_sede = 4),
    (SELECT telefono FROM sede WHERE cod_sede = 4),
    (SELECT celular FROM sede WHERE cod_sede = 4),

    (SELECT direccion FROM sede WHERE cod_sede = 3),
    (SELECT email FROM sede WHERE cod_sede = 3),
    (SELECT telefono FROM sede WHERE cod_sede = 3),

    (SELECT direccion FROM sede WHERE cod_sede = 2),
    (SELECT email FROM sede WHERE cod_sede = 2),
    (SELECT telefono FROM sede WHERE cod_sede = 2),
    (SELECT celular FROM sede WHERE cod_sede = 2),

    (SELECT direccion FROM sede WHERE cod_sede = 1),
    (SELECT email FROM sede WHERE cod_sede = 1),
    (SELECT telefono FROM sede WHERE cod_sede = 1),
    dp.lugar_nac_pa,
    dp.direccion_pa,
    dp.ocupacion_pa,
    noo.cargo_de,
    noo.area_o,
    of.usuario_firma

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN oftalmologia of ON of.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

alter table odontograma add column usuario_firma text

drop FUNCTION obtener_reporte_odontograma(
    IN p_norden integer,
    IN name_service text)

CREATE OR REPLACE FUNCTION obtener_reporte_odontograma(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, sexo "char", cod_od integer, fecha_od date, edad_od text, lbl_18 text, lbl_17 text, lbl_16 text, lbl_15 text, lbl_14 text, lbl_13 text, lbl_12 text, lbl_11 text, lbl_21 text, lbl_22 text, lbl_23 text, lbl_24 text, lbl_25 text, lbl_26 text, lbl_27 text, lbl_28 text, lbl_31 text, lbl_32 text, lbl_33 text, lbl_34 text, lbl_35 text, lbl_36 text, lbl_37 text, lbl_38 text, lbl_41 text, lbl_42 text, lbl_43 text, lbl_44 text, lbl_45 text, lbl_46 text, lbl_47 text, lbl_48 text, txtpiezasmalestado integer, txtausentes integer, txtcariadasoturar integer, txtporextraer integer, txtfracturada integer, txtobturacionesefectuadas integer, txtpuentes integer, txtpprmetalicas integer, txtppracrilicas integer, txtptotal integer, txtnormales integer, txtcoronas integer, txtobservaciones text, color integer, sede_descripcion text, nom_sede text, name_jasper text, usuario_firma text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    o.n_orden,
    noo.cod_pa,
    --dp.fecha_nacimiento_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    --noo.nom_examen,
    --dp.lugar_nac_pa,
    --dp.cel_pa,
    dp.sexo_pa,
    --dp.direccion_pa ||'-'|| dp.distrito_pa ||'-'|| dp.provincia_pa ||'-'|| dp.departamento_pa,
    --u.nombre_user||' '||u.apellido_user,
    o.cod_od,
    o.fecha_od,
    o.edad_od,
    o.lbl_18,
    o.lbl_17,
    o.lbl_16,
    o.lbl_15,
    o.lbl_14,
    o.lbl_13,
    o.lbl_12,
    o.lbl_11,
    o.lbl_21,
    o.lbl_22,
    o.lbl_23,
    o.lbl_24,
    o.lbl_25,
    o.lbl_26,
    o.lbl_27,
    o.lbl_28,
    o.lbl_31,
    o.lbl_32,
    o.lbl_33,
    o.lbl_34,
    o.lbl_35,
    o.lbl_36,
    o.lbl_37,
    o.lbl_38,
    o.lbl_41,
    o.lbl_42,
    o.lbl_43,
    o.lbl_44,
    o.lbl_45,
    o.lbl_46,
    o.lbl_47,
    o.lbl_48,
    o.txtpiezasmalestado,
    o.txtausentes,
    o.txtcariadasoturar,
    o.txtporextraer,
    o.txtfracturada,
    o.txtobturacionesefectuadas,
    o.txtpuentes,
    o.txtpprmetalicas,
    o.txtppracrilicas,
    o.txtptotal,
    o.txtnormales,
    o.txtcoronas,
    o.txtobservaciones,

    noo.color,
    CAST(sm.descripcion AS TEXT),
    CASE
        WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
        WHEN noo.cod_sede = 1 THEN 'Trujillo'
        WHEN noo.cod_sede = 2 THEN 'Huamachuco'
        WHEN noo.cod_sede = 3 THEN 'Huancayo'
        WHEN noo.cod_sede = 4 THEN 'Trujillo'
    END AS nom_sede,
    obtener_name_jasper(p_norden, name_service),
    o.usuario_firma

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN odontograma o ON o.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

alter table certificado_altura_poderosa add column usuario_firma text

DROP FUNCTION obtener_reporte_certificado_trabajo_altura_poderosa(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_certificado_trabajo_altura_poderosa(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, fechaexamen_f_examen date, fechacaducidad_f_caducidad date, procedencia_procedencia text, tiempoexperiencia_t_experiencia text, lugarexperiencia_lugar_expe text, accidentestrabajo_txtaccidentes_trab text, antecedentesfamiliares_txtantecedente_familiares text, tecmoderadosi_chk_psico_si1 boolean, tecmoderadono_chk_psico_no1 boolean, convulsionessi_chk_psico_si2 boolean, convulsionesno_chk_psico_no2 boolean, mareossi_chk_psico_si3 boolean, mareosno_chk_psico_no3 boolean, problemasauditivossi_chk_psico_si4 boolean, problemasauditivosno_chk_psico_no4 boolean, problemasequilibriosi_chk_psico_si5 boolean, problemasequilibriono_chk_psico_no5 boolean, acrofobiasi_chk_psico_si6 boolean, acrofobiano_chk_psico_no6 boolean, agarofobiasi_chk_psico_si7 boolean, agarofobiano_chk_psico_no7 boolean, tecmoderadodescripcion_txt_antecpsico_1 text, convulsionesdescripcion_txt_antecpsico_2 text, mareosdescripcion_txt_antecpsico_3 text, problemasauditivosdescripcion_txt_antecpsico_4 text, problemasequilibriodescripcion_txt_antecpsico_5 text, acrofobiadescripcion_txt_antecpsico_6 text, agarofobiadescripcion_txt_antecpsico_7 text, tabacocantidad_txt_tabaco_cantiad text, tabacofrecuencia_txt_tabaco_frecuencia text, alcoholcantidad_txt_alcohol_cantiad text, alcoholfrecuencia_txt_alcohol_frecuencia text, drogascantidad_txt_drogas_cantiad text, drogasfrecuencia_txt_drogas_frecuencia text, hojacocacantidad_txt_hojacoca_cantiad text, hojacocafrecuencia_txt_hojacoca_frecuencia text, cafecantidad_txt_cafe_cantiad text, cafefrecuencia_txt_cafe_frecuencia text, gustadivertirsesi_chktest_si1 boolean, gustadivertirseno_chktest_no1 boolean, gustadivertirsepuntaje_txttest_p1 text, tardecompromisosi_chktest_si2 boolean, tardecompromisono_chktest_no2 boolean, tardecompromisopuntaje_txttest_p2 text, criticaformabebersi_chktest_si3 boolean, criticaformabeberno_chktest_no3 boolean, criticaformabeberpuntaje_txttest_p3 text, reuniondivertirsereanimasi_chktest_si4 boolean, reuniondivertirsereanimano_chktest_no4 boolean, reuniondivertirsereanimapuntaje_txttest_p4 text, impresionbebermenossi_chktest_si5 boolean, impresionbebermenosno_chktest_no5 boolean, impresionbebermenospuntaje_txttest_p5 text, duermebiensi_chktest_si6 boolean, duermebienno_chktest_no6 boolean, duermebienpuntaje_txttest_p6 text, costumbrebebersi_chktest_si7 boolean, costumbrebeberno_chktest_no7 boolean, costumbrebeberpuntaje_txttest_p7 text, nerviosoamenudosi_chktest_si8 boolean, nerviosoamenudono_chktest_no8 boolean, nerviosoamenudopuntaje_txttest_p8 text, bebercalmarnerviossi_chktest_si9 boolean, bebercalmarnerviosno_chktest_no9 boolean, bebercalmarnerviospuntaje_txttest_p9 text, doloresespaldasi_chktest_si10 boolean, doloresespaldano_chktest_no10 boolean, doloresespaldapuntaje_txttest_p10 text, anamnesis_txtanamnesis text, apreciaciongeneral_txtapresiaciongeneral text, cabeza_txtcabeza text, piel_txtpiel text, motilidadocular_txtmotilidadocular text, otoscopiaod_txtotoscopiaod text, otoscopiaoi_txtotoscopiaoi text, nariz_txtnariz text, aprespiratorio_txtaprespiratorio text, apcardiovascular_txtapcardiovascuar text, abdomen_txtabdomen text, musculoesqueletico_txtmusculoesqueletico text, columna_txtcolumna text, tesepworth_txttesepworth text, reflejos_txtreflejos text, dedonariznegativo_chkneuro_neg1 boolean, dedonarizpositivo_chkneuro_pos1 boolean, indicebaranynegativo_chkneuro_neg2 boolean, indicebaranypositivo_chkneuro_pos2 boolean, diadococinesianegativo_chkneuro_neg3 boolean, diadococinesiapositivo_chkneuro_pos3 boolean, rombergsimplenegativo_chkneuro_neg4 boolean, rombergsimplepositivo_chkneuro_pos4 boolean, rombergsensibilizadonegativo_chkneuro_neg5 boolean, rombergsensibilizadopositivo_chkneuro_pos5 boolean, marchatandemnegativo_chkneuro_neg6 boolean, marchatandempositivo_chkneuro_pos6 boolean, unterbergnegativo_chkneuro_neg7 boolean, unterbergpositivo_chkneuro_pos7 boolean, babinskinegativo_chkneuro_neg8 boolean, babinskipositivo_chkneuro_pos8 boolean, dixnegativo_chkneuro_neg9 boolean, dixpositivo_chkneuro_pos9 boolean, marchanegativo_chkneuro_neg10 boolean, marchapositivo_chkneuro_pos10 boolean, diagnostico_txtdiagnostico text, apto_chk_apto boolean, noapto_chk_no_apto boolean, aptorestriccion_chk_apto_r boolean, conclusiones_atxtobservaciones text, dniusuario_dni_user integer, otrosexameneslaboratorio_txtotrosexamlab text, altura_txtaltura text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, cinturatriaje_cintura text, icctriaje_icc text, caderatriaje_cadera text, temperaturatriaje_temperatura text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje_perimetro_cuello text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, odcc_odcc text, oicc_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlc_odlc text, oilc_oilc text, vc_vc text, vb_vb text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesoftalmo_e_oculares1 text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, hemoglobinalaboratorioclinico_txthemoglobina text, hematocritolaboratorioclinico_txthematocrito text, glucosalaboratorioclinico_txtglucosabio text, creatininalaboratorioclinico_txtcreatininabio text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, nombremedico text, cmpusuario text, nombresede text, sede text, color integer, namejasper text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, usuarioFirma text) AS
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
	    ca.cod_certificado,
	    ca.f_examen,
	    ca.f_caducidad,
	    ca.procedencia,
	    ca.t_experiencia,
	    ca.lugar_expe,
	    ca.txtaccidentes_trab,
	    ca.txtantecedente_familiares,

	    ca.chk_psico_si1, ca.chk_psico_no1,
	    ca.chk_psico_si2, ca.chk_psico_no2,
	    ca.chk_psico_si3, ca.chk_psico_no3,
	    ca.chk_psico_si4, ca.chk_psico_no4,
	    ca.chk_psico_si5, ca.chk_psico_no5,
	    ca.chk_psico_si6, ca.chk_psico_no6,
	    ca.chk_psico_si7, ca.chk_psico_no7,

	    ca.txt_antecpsico_1,
	    ca.txt_antecpsico_2,
	    ca.txt_antecpsico_3,
	    ca.txt_antecpsico_4,
	    ca.txt_antecpsico_5,
	    ca.txt_antecpsico_6,
	    ca.txt_antecpsico_7,

	    ca.txt_tabaco_cantiad,
	    ca.txt_tabaco_frecuencia,
	    ca.txt_alcohol_cantiad,
	    ca.txt_alcohol_frecuencia,
	    ca.txt_drogas_cantiad,
	    ca.txt_drogas_frecuencia,
	    ca.txt_hojacoca_cantiad,
	    ca.txt_hojacoca_frecuencia,
	    ca.txt_cafe_cantiad,
	    ca.txt_cafe_frecuencia,

	    ca.chktest_si1,  ca.chktest_no1,  ca.txttest_p1,
	    ca.chktest_si2,  ca.chktest_no2,  ca.txttest_p2,
	    ca.chktest_si3,  ca.chktest_no3,  ca.txttest_p3,
	    ca.chktest_si4,  ca.chktest_no4,  ca.txttest_p4,
	    ca.chktest_si5,  ca.chktest_no5,  ca.txttest_p5,
	    ca.chktest_si6,  ca.chktest_no6,  ca.txttest_p6,
	    ca.chktest_si7,  ca.chktest_no7,  ca.txttest_p7,
	    ca.chktest_si8,  ca.chktest_no8,  ca.txttest_p8,
	    ca.chktest_si9,  ca.chktest_no9,  ca.txttest_p9,
	    ca.chktest_si10, ca.chktest_no10, ca.txttest_p10,
	    --
	    ca.txtanamnesis,
	    ca.txtapresiaciongeneral,
	    ca.txtcabeza,
	    ca.txtpiel,
	    ca.txtmotilidadocular,
	    ca.txtotoscopiaod,
	    ca.txtotoscopiaoi,
	    ca.txtnariz,
	    ca.txtaprespiratorio,
	    ca.txtapcardiovascuar,
	    ca.txtabdomen,
	    ca.txtmusculoesqueletico,
	    ca.txtcolumna,
	    ca.txttesepworth,
	    ca.txtreflejos,

	    ca.chkneuro_neg1,  ca.chkneuro_pos1,
	    ca.chkneuro_neg2,  ca.chkneuro_pos2,
	    ca.chkneuro_neg3,  ca.chkneuro_pos3,
	    ca.chkneuro_neg4,  ca.chkneuro_pos4,
	    ca.chkneuro_neg5,  ca.chkneuro_pos5,
	    ca.chkneuro_neg6,  ca.chkneuro_pos6,
	    ca.chkneuro_neg7,  ca.chkneuro_pos7,
	    ca.chkneuro_neg8,  ca.chkneuro_pos8,
	    ca.chkneuro_neg9,  ca.chkneuro_pos9,
	    ca.chkneuro_neg10, ca.chkneuro_pos10,

	    ca.txtdiagnostico,
	    ca.chk_apto,
	    ca.chk_no_apto,
	    ca.chk_apto_r,
	    ca.atxtobservaciones,
	    ca.dni_user,
	    ca.txtotrosexamlab,
	    ca.txtaltura,

	    t.talla,
	    t.peso,
	    t.imc,
	    t.cintura,
	    t.icc,
	    t.cadera,
	    t.temperatura,
	    t.f_cardiaca,
	    t.sat_02,
	    t.perimetro_cuello,
	    t.sistolica,
	    t.diastolica,
	    t.f_respiratoria,
	    CASE 
		WHEN oft.txtcercasincorregirod IS NOT NULL THEN oft.txtcercasincorregirod
		ELSE o.v_cerca_s_od
	    END AS v_cerca_s_od,

	    CASE 
		WHEN oft.txtcercasincorregiroi IS NOT NULL THEN oft.txtcercasincorregiroi
		ELSE o.v_cerca_s_oi
	    END AS v_cerca_s_oi,

	    -- Visión cerca corregida
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

	    -- Visión lejos sin corregir
	    CASE 
		WHEN oft.txtlejossincorregirod IS NOT NULL THEN oft.txtlejossincorregirod
		ELSE o.v_lejos_s_od
	    END AS v_lejos_s_od,

	    CASE 
		WHEN oft.txtlejossincorregiroi IS NOT NULL THEN oft.txtlejossincorregiroi
		ELSE o.v_lejos_s_oi
	    END AS v_lejos_s_oi,

	    -- Visión lejos corregida
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

	    -- Colores
	    CASE  
		WHEN oft.rbtecishihara_normal = 'TRUE' THEN 'NORMAL'
		WHEN oft.rbtecishihara_anormal = 'TRUE' THEN 'ANORMAL'
		WHEN ol.v_colores IS NULL THEN o.v_colores
		ELSE ol.v_colores
	    END AS VC,

	    -- Binocular
	    CASE  
		WHEN oft.txtbinocularsincorregir IS NOT NULL THEN oft.txtbinocularsincorregir
		WHEN ol.v_binocular IS NULL THEN o.v_binocular
		ELSE ol.v_binocular
	    END AS VB,

	    -- Reflejos Pupilares
	    CASE  
		WHEN oft.txtrp IS NOT NULL THEN oft.txtrp
		WHEN ol.r_pupilares IS NULL THEN o.r_pupilares
		ELSE ol.r_pupilares
	    END AS RP,

	    -- Diagnóstico
	    CASE  
		WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico
		ELSE o.e_oculares
	    END AS e_oculares,
	    o.e_oculares1,
	    pt.p_max_inspiracion,
	    pt.p_ex_forzada,
	    l.txthemoglobina, l.txthematocrito, l.txtglucosabio, l.txtcreatininabio,
	    l.txtcocaina,l.txtmarihuana,
	    a.txtcolesterol, a.txtldlcolesterol, a.txthdlcolesterol, a.txtvldlcolesterol, a.txttrigliseridos,
	    u.nombre_user||' '||u.apellido_user AS nom_medico, u.cmp_user,
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
	    obtener_name_jasper(p_norden, name_service),
	    au.o_d_500, au.o_d_1000, au.o_d_2000,au.o_d_3000, au.o_d_4000, au.o_d_6000, au.o_d_8000, au.o_i_500, au.o_i_1000, au.o_i_2000, 
	    au.o_i_3000, au.o_i_4000, au.o_i_6000, au.o_i_8000,au.diagnostico,
	    ca.usuario_firma
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN triaje AS t 
	    ON n.n_orden = t.n_orden
	LEFT JOIN certificado_altura_poderosa AS ca 
	    ON n.n_orden = ca.n_orden
	LEFT JOIN oftalmologia AS o 
	    ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol 
	    ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft 
	    ON n.n_orden = oft.n_orden
	LEFT JOIN perimetro_toracico AS pt
	    ON n.n_orden = pt.n_orden
	LEFT JOIN lab_clinico AS l 
	    ON l.n_orden=n.n_orden
	LEFT JOIN analisis_bioquimicos AS a 
	    ON (a.n_orden=n.n_orden)
	LEFT JOIN audiometria_po AS au 
	    ON (au.n_orden=n.n_orden)
	LEFT JOIN usuarios AS u 
	    ON (u.dni_user = ca.dni_user)
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

alter table b_certificado_altura add column usuario_firma text

DROP FUNCTION obtener_reporte_certificado_trabajo_altura(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_certificado_trabajo_altura(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, tiempoexperiencia_t_experiencia text, primeraaptitud_chk_primera boolean, revalidacion_chk_revalidacion boolean, fechaexamen_f_examen date, antecedentestodasenfermedadessi_chk_1_si boolean, antecedentestodasenfermedadesno_chk_1_no boolean, antecedentesalcoholismocronicosi_chk_2_si boolean, antecedentesalcoholismocronicono_chk_2_no boolean, antecedentesenfermedadesinvoluntariossi_chk_3_si boolean, antecedentesenfermedadesinvoluntariosno_chk_3_no boolean, antecedentesperdidaconcienciasi_chk_4_si boolean, antecedentesperdidaconcienciano_chk_4_no boolean, chk5si_chk_5_si boolean, chk5no_chk_5_no boolean, antecedentesconsumesustanciassialteresi_chk_7_si boolean, antecedentesconsumesustanciassialtereno_chk_7_no boolean, antecedentesconsumesustanciasnoalteresi_chk_8_si boolean, antecedentesconsumesustanciasnoaltereno_chk_8_no boolean, antecedentesvariosefectossi_chk_9_si boolean, antecedentesvariosefectosno_chk_9_no boolean, antecedentesapneasi_chk_10_si boolean, antecedentesapneano_chk_10_no boolean, antecedentesobesidadsi_chk_11_si boolean, antecedentesobesidadno_chk_11_no boolean, pcomplementariashipoacusiasi_chk_13_si boolean, pcomplementariashipoacusiano_chk_13_no boolean, pcomplementariasalteracionagudezavisualsi_chk_14_si boolean, pcomplementariasalteracionagudezavisualno_chk_14_no boolean, pcomplementariastemoralturassi_chk_15_si boolean, pcomplementariastemoralturasno_chk_15_no boolean, pcomplementariasresfriadosi_chk_16_si boolean, pcomplementariasresfriadono_chk_16_no boolean, pcomplementariasvertigosi_chk_17_si boolean, pcomplementariasvertigono_chk_17_no boolean, pcomplementariacampimetriasi_chk_18_si boolean, pcomplementariacampimetriano_chk_18_no boolean, examenfisicolimitacionfuerzasi_chk_19_si boolean, examenfisicolimitacionfuerzano_chk_19_no boolean, examenfisicoalteracionequilibriosi_chk_20_si boolean, examenfisicoalteracionequilibriono_chk_20_no boolean, examenfisicoanormalidadmarchasi_chk_21_si boolean, examenfisicoanormalidadmarchano_chk_21_no boolean, examenfisicoalteracioncoordinacionsi_chk_22_si boolean, examenfisicoalteracioncoordinacionno_chk_22_no boolean, examenfisicoasimetriafacialsi_chk_23_si boolean, examenfisicoasimetriafacialno_chk_23_no boolean, examefisiconistagmussi_chk_24_si boolean, examefisiconistagmusno_chk_24_no boolean, examenfisicoanormalidadmovimientosi_chk_25_si boolean, examenfisicoanormalidadmovimientono_chk_25_no boolean, examenfisicocirlasi_chk_26_si boolean, examenfisicocirlano_chk_26_no boolean, examenfisicoanormalidadlenguajesi_chk_27_si boolean, examenfisicoanormalidadlenguajeno_chk_27_no boolean, examenfisicomovimientoinvoluntariosi_chk_28_si boolean, examenfisicomovimientoinvoluntariono_chk_28_no boolean, fechadesde_f_desde date, fechahasta_f_hasta date, apto_chk_si boolean, observado_chk_observado boolean, detallemedicina_d_medicina text, detalleinformacion_d_informacion text, noapto_chk_no_apto boolean, aptoconrestriccion_chk_apto_r boolean, observacionesrecomendaciones_b_c_observaciones text, antecedentescomentariosdetalles_comentariosdetalleantecedent text, antecedentesdiabetesmellitussi_chk_29_si boolean, antecedentesdiabetesmellitusno_chk_29_no boolean, chk30si_chk_30_si boolean, chk30no_chk_30_no boolean, examenfisicosustentacionpie_suste_pie_15 boolean, tallatriaje text, pesotriaje text, imctriaje text, cinturatriaje text, icctriaje text, caderatriaje text, temperatura text, frecuenciacardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje text, sistolica text, diastolica text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, conclusiontriaje text, frecuenciarespiratoriatriaje_f_respiratoria text, grado3fichasas_chkgradoiii boolean, grado4fichasas_chkgradoiiii boolean, aptocriterioesifichasas_chk1_apto_sie boolean, tiempolicenciabsas_t_licencia text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, diagnosticoaudiometria text, nombresede text, sede text, color integer, namejasper text, nombremedico text, cmpusuario text, dniusuario integer, usuariofirma text, laboratorioClinicoHemoglobina text) AS
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
	    ca.cod_certificado,
	    ca.t_experiencia,
	    ca.chk_primera,
	    ca.chk_revalidacion,
	    ca.f_examen,
	    ca.chk_1_si, ca.chk_1_no,
	    ca.chk_2_si, ca.chk_2_no,
	    ca.chk_3_si, ca.chk_3_no,
	    ca.chk_4_si, ca.chk_4_no,
	    ca.chk_5_si, ca.chk_5_no,
	    ca.chk_7_si, ca.chk_7_no,
	    ca.chk_8_si, ca.chk_8_no,
	    ca.chk_9_si, ca.chk_9_no,
	    ca.chk_10_si, ca.chk_10_no,
	    ca.chk_11_si, ca.chk_11_no,
	    ca.chk_13_si, ca.chk_13_no,
	    ca.chk_14_si, ca.chk_14_no,
	    ca.chk_15_si, ca.chk_15_no,
	    ca.chk_16_si, ca.chk_16_no,
	    ca.chk_17_si, ca.chk_17_no,
	    ca.chk_18_si, ca.chk_18_no,
	    ca.chk_19_si, ca.chk_19_no,
	    ca.chk_20_si, ca.chk_20_no,
	    ca.chk_21_si, ca.chk_21_no,
	    ca.chk_22_si, ca.chk_22_no,
	    ca.chk_23_si, ca.chk_23_no,
	    ca.chk_24_si, ca.chk_24_no,
	    ca.chk_25_si, ca.chk_25_no,
	    ca.chk_26_si, ca.chk_26_no,
	    ca.chk_27_si, ca.chk_27_no,
	    ca.chk_28_si, ca.chk_28_no,
	    ca.f_desde,
	    ca.f_hasta,
	    ca.chk_si,
	    ca.chk_observado,
	    ca.d_medicina,
	    ca.d_informacion,
	    ca.chk_no_apto,
	    ca.chk_apto_r,
	    ca.b_c_observaciones,
	    ca.ComentariosDetalleAntecedent,
	    ca.chk_29_si, ca.chk_29_no,
	    ca.chk_30_si, ca.chk_30_no,
	    ca.suste_pie_15,
	    c.talla,
	    c.peso,
	    c.imc,
	    c.cintura,
	    c.icc,
	    c.cadera,
	    c.temperatura,
	    c.f_cardiaca,
	    c.sat_02,
	    c.perimetro_cuello,
	    c.sistolica,
	    c.diastolica,
	    c.fvc, c.fev_1, c.fev1_fvc, c.fef25_75, c.conclusion,
	    c.f_respiratoria,
	    fsa.chkgradoiii, 
	    fsa.chkgradoiiii, 
	    fsa.chk1_apto_sie,
	    s.t_licencia,
	    p.p_max_inspiracion,
	    p.p_ex_forzada,
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
		WHEN au.o_d_500 IS NOT NULL THEN au.o_d_500 
		ELSE m.o_d_500 
	    END AS o_d_500,
	    
	    CASE 
		WHEN au.o_d_1000 IS NOT NULL THEN au.o_d_1000 
		ELSE m.o_d_1000 
	    END AS o_d_1000,
	    
	    CASE 
		WHEN au.o_d_2000 IS NOT NULL THEN au.o_d_2000 
		ELSE m.o_d_2000 
	    END AS o_d_2000,
	    
	    CASE 
		WHEN au.o_i_500 IS NOT NULL THEN au.o_i_500 
		ELSE m.o_i_500 
	    END AS o_i_500,
	    
	    CASE 
		WHEN au.o_i_1000 IS NOT NULL THEN au.o_i_1000 
		ELSE m.o_i_1000 
	    END AS o_i_1000,
	    
	    CASE 
		WHEN au.o_i_2000 IS NOT NULL THEN au.o_i_2000 
		ELSE m.o_i_2000 
	    END AS o_i_2000,
	    CASE
		WHEN au.txtdiag_od IS NULL AND au.txtdiag_oi IS NULL THEN m.diagnostico
		ELSE au.txtdiag_od ||', '|| au.txtdiag_oi
	    END AS diagnosticoAudiometria,

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
	    obtener_name_jasper(p_norden, name_service),
	    u.nombre_user||' '||u.apellido_user AS nom_medico, 
	    u.cmp_user,
	    ca.dni_user,
	    ca.usuario_firma,
	    lc.txthemoglobina
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN 
	    triaje AS c ON n.n_orden = c.n_orden
	LEFT JOIN 
	    b_certificado_altura AS ca ON n.n_orden = ca.n_orden
	LEFT JOIN 
	    audiometria_po AS m ON n.n_orden = m.n_orden
	LEFT JOIN 
	    audiometria_2023 AS au ON n.n_orden = au.n_orden
	LEFT JOIN oftalmologia AS o ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft ON n.n_orden = oft.n_orden
	LEFT JOIN ficha_sas AS fsa ON n.n_orden = fsa.n_orden
	LEFT JOIN b_sas AS s ON s.n_orden = n.n_orden
	LEFT JOIN perimetro_toracico AS p ON p.n_orden=n.n_orden
	LEFT JOIN usuarios AS u ON (u.dni_user = ca.dni_user)
	LEFT JOIN lab_clinico AS lc ON lc.n_orden = n.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

alter table ficha_sas add column usuario_firma text

DROP FUNCTION obtener_reporte_ficha_sas(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_ficha_sas(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, pesotriaje text, imctriaje text, tallatriaje text, perimetrocuellotriaje text, sistolicatriaje text, diastolicatriaje text, codigosas_cod_sas integer, tipolicencia_licencia_sas text, trabajanochesi_tbtrabajanochesi boolean, trabajanocheno_tbtrabajanocheno boolean, diastrabajo_txtdiastrabajo text, descanso_txtdescanso text, anostrabajo_txtanostrabajo text, apneasi_rbapneasi boolean, apneano_rbapneano boolean, ultimocontrol_txtultimocontrol text, htasi_rbhtasi boolean, htano_rbhtano boolean, riesgo_txtriesgo text, psgsi_rbpsgsi boolean, psgno_rbpsgno boolean, fechapsg_fechapsg date, enminasi_rbenminasi boolean, enminano_rbenminano boolean, fueraminasi_rbfueraminasi boolean, fueraminano_rbfueraminano boolean, casochoquepregunta1si_chk1_sassi boolean, casochoquepregunta2si_chk2_sassi boolean, casochoquepregunta3si_chk3_sassi boolean, casochoquepregunta4si_chk4_sassi boolean, casochoquepregunta5si_chk5_sassi boolean, casochoquepregunta6si_chk6_sassi boolean, casochoquepregunta7si_chk7_sassi boolean, casochoquepregunta8si_chk8_sassi boolean, casochoquepregunta9si_chk9_sassi boolean, casochoquepregunta10si_chk10_sassi boolean, casochoquepregunta11si_chk11_sassi boolean, casochoquepregunta12si_chk12_sassi boolean, casochoquepregunta13si_chk13_sassi boolean, casochoquepregunta1no_chk1_sasno boolean, casochoquepregunta2no_chk2_sasno boolean, casochoquepregunta3no_chk3_sasno boolean, casochoquepregunta4no_chk4_sasno boolean, casochoquepregunta5no_chk5_sasno boolean, casochoquepregunta6no_chk6_sasno boolean, casochoquepregunta7no_chk7_sasno boolean, casochoquepregunta8no_chk8_sasno boolean, casochoquepregunta9no_chk9_sasno boolean, casochoquepregunta10no_chk10_sasno boolean, casochoquepregunta11no_chk11_sasno boolean, casochoquepregunta12no_chk12_sasno boolean, casochoquepregunta13no_chk13_sasno boolean, entrevistaantefamiliarapneasi_chkantsi boolean, entrevistaantefamiliarapneano_chkantno boolean, entrevistaantefamiliarapneadescrip_txtantecedentefamiliar text, entrevistapregunta1si_chk1_esi boolean, entrevistapregunta2si_chk2_esi boolean, entrevistapregunta3si_chk3_esi boolean, entrevistapregunta4si_chk4_esi boolean, entrevistapregunta5si_chk5_esi boolean, entrevistapregunta6si_chk6_esi boolean, entrevistapregunta7si_chk7_esi boolean, entrevistapregunta8si_chk8_esi boolean, entrevistapregunta1no_chk1_eno boolean, entrevistapregunta2no_chk2_eno boolean, entrevistapregunta3no_chk3_eno boolean, entrevistapregunta4no_chk4_eno boolean, entrevistapregunta5no_chk5_eno boolean, entrevistapregunta6no_chk6_eno boolean, entrevistapregunta7no_chk7_eno boolean, entrevistapregunta8no_chk8_eno boolean, entrevistapuntuacion_txtpuntuacion text, examenfisicovaronsi_chkvaronsi boolean, examenfisicovaronno_chkvaronno boolean, examenfisicomujersi_chkmujersi boolean, examenfisicomujerno_chkmujerno boolean, examenfisicohtanuevasi_chkhtanuevasi boolean, examenfisicohtanuevano_chkhtanuevano boolean, examenfisicogradoi_chkgradoi boolean, examenfisicogradoii_chkgradoii boolean, examenfisicogradoiii_chkgradoiii boolean, examenfisicogradoiv_chkgradoiiii boolean, conclusionaptobajoriesgosi_chkaptobajosi boolean, conclusionaptobajoriesgono_chkaptobajono boolean, conclusionobservaciones_txtobservaciones text, dniusuario_dni_user integer, fechasas_fecha_sas date, conclusionrequierepsgsi_chk1_psg_si boolean, conclusionrequierepsgno_chk1_psg_no boolean, conclusionaptopsgsi_chk1_apto_si boolean, conclusionaptopsgno_chk1_apto_no boolean, fechapsg2_fecha_psg text, conclusionrequierepsgasi_chk1_psg_sia boolean, conclusionrequierepsgano_chk1_psg_noa boolean, conclusionrequierepsgbsi_chk1_psg_sib boolean, conclusionrequierepsgbno_chk1_psg_nob boolean, conclusionaptocriteriodsi_chk1_apto_sid boolean, conclusionaptocriteriodno_chk1_apto_nod boolean, conclusionaptocriteriod1si_chk1_apto_sid1 boolean, conclusionaptocriteriod1no_chk1_apto_nod1 boolean, conclusionaptocriteriod2si_chk1_apto_sid2 boolean, conclusionaptocriteriod2no_chk1_apto_nod2 boolean, conclusionaptocriteriod3si_chk1_apto_sid3 boolean, conclusionaptocriteriod3no_chk1_apto_nod3 boolean, conclusionaptocriteriod4si_chk1_apto_sid4 boolean, conclusionaptocriteriod4no_chk1_apto_nod4 boolean, conclusionaptocriteriod5si_chk1_apto_sid5 boolean, conclusionaptocriteriod5no_chk1_apto_nod5 boolean, conclusionaptocriteriod6si_chk1_apto_sid6 boolean, conclusionaptocriteriod6no_chk1_apto_nod6 boolean, conclusionaptocriterioesi_chk1_apto_sie boolean, conclusionaptocriterioeno_chk1_apto_noe boolean, conclusionaptocriteriocsi_chk1_apto_sic boolean, conclusionaptocriteriocno_chk1_apto_noc boolean, usuarioregistro_user_registro text, 
  usuarioFirma text, nombresede text, sede text, color integer, namejasper text, nombremedico text) AS
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
	    t.peso,
	    t.imc,
	    t.talla,
	    t.perimetro_cuello,
	    t.sistolica,
	    t.diastolica,
	    f.cod_sas,
	    f.licencia_sas,
	    f.tbtrabajanochesi,
	    f.tbtrabajanocheno,
	    f.txtdiastrabajo,
	    f.txtdescanso,
	    f.txtanostrabajo,
	    f.rbapneasi,
	    f.rbapneano,
	    f.txtultimocontrol,
	    f.rbhtasi,
	    f.rbhtano,
	    f.txtriesgo,
	    f.rbpsgsi,
	    f.rbpsgno,
	    f.fechapsg,
	    f.rbenminasi,
	    f.rbenminano,
	    f.rbfueraminasi,
	    f.rbfueraminano,
	    f.chk1_sassi,
	    f.chk2_sassi,
	    f.chk3_sassi,
	    f.chk4_sassi,
	    f.chk5_sassi,
	    f.chk6_sassi,
	    f.chk7_sassi,
	    f.chk8_sassi,
	    f.chk9_sassi,
	    f.chk10_sassi,
	    f.chk11_sassi,
	    f.chk12_sassi,
	    f.chk13_sassi,
	    f.chk1_sasno,
	    f.chk2_sasno,
	    f.chk3_sasno,
	    f.chk4_sasno,
	    f.chk5_sasno,
	    f.chk6_sasno,
	    f.chk7_sasno,
	    f.chk8_sasno,
	    f.chk9_sasno,
	    f.chk10_sasno,
	    f.chk11_sasno,
	    f.chk12_sasno,
	    f.chk13_sasno,
	    f.chkantsi,
	    f.chkantno,
	    f.txtantecedentefamiliar,
	    f.chk1_esi,
	    f.chk2_esi,
	    f.chk3_esi,
	    f.chk4_esi,
	    f.chk5_esi,
	    f.chk6_esi,
	    f.chk7_esi,
	    f.chk8_esi,
	    f.chk1_eno,
	    f.chk2_eno,
	    f.chk3_eno,
	    f.chk4_eno,
	    f.chk5_eno,
	    f.chk6_eno,
	    f.chk7_eno,
	    f.chk8_eno,
	    f.txtpuntuacion,
	    f.chkvaronsi,
	    f.chkvaronno,
	    f.chkmujersi,
	    f.chkmujerno,
	    f.chkhtanuevasi,
	    f.chkhtanuevano,
	    f.chkgradoi,
	    f.chkgradoii,
	    f.chkgradoiii,
	    f.chkgradoiiii,
	    f.chkaptobajosi,
	    f.chkaptobajono,
	    f.txtobservaciones,
	    f.dni_user,
	    f.fecha_sas,
	    f.chk1_psg_si,
	    f.chk1_psg_no,
	    f.chk1_apto_si,
	    f.chk1_apto_no,
	    f.fecha_psg,
	    f.chk1_psg_sia,
	    f.chk1_psg_noa,
	    f.chk1_psg_sib,
	    f.chk1_psg_nob,
	    f.chk1_apto_sid,
	    f.chk1_apto_nod,
	    f.chk1_apto_sid1,
	    f.chk1_apto_nod1,
	    f.chk1_apto_sid2,
	    f.chk1_apto_nod2,
	    f.chk1_apto_sid3,
	    f.chk1_apto_nod3,
	    f.chk1_apto_sid4,
	    f.chk1_apto_nod4,
	    f.chk1_apto_sid5,
	    f.chk1_apto_nod5,
	    f.chk1_apto_sid6,
	    f.chk1_apto_nod6,
	    f.chk1_apto_sie,
	    f.chk1_apto_noe,
	    f.chk1_apto_sic,
	    f.chk1_apto_noc,
	    f.user_registro,
	    f.usuario_firma,
	    
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
	    obtener_name_jasper(p_norden, name_service),
	    u.nombre_user || ' ' || u.apellido_user
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN triaje AS t 
	    ON n.n_orden = t.n_orden
	LEFT JOIN ficha_sas AS f 
	    ON n.n_orden = f.n_orden
	LEFT JOIN usuarios AS u
	    ON UPPER(f.user_registro) = UPPER(u.usuario_user)
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_parametros_digitalizados(
    IN norden_param bigint,
    IN name_servicio_param text)
  RETURNS TABLE(descripcion text, name_digitalizacion text, dni integer) AS
$BODY$
DECLARE 
    dni_paciente_var INTEGER;
    dni_user_registro_var INTEGER;
    dni_user_doctor_asig_var INTEGER;
    dni_user_doc_adic_var INTEGER;
    empresa_var TEXT;
    user_registro_var TEXT;
    sede_var INTEGER;
    completo_electro_var BOOLEAN;
BEGIN
    -- Obtener DNI del paciente
    IF name_servicio_param = 'ficha_interconsulta' THEN
	SELECT cod_pa INTO dni_paciente_var
	FROM n_orden_ocupacional n
	INNER JOIN ficha_interconsulta f ON n.n_orden = f.n_orden
	WHERE f.cod_fichaint = norden_param;
    ELSE
	SELECT cod_pa INTO dni_paciente_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
    END IF;

    IF name_servicio_param = 'ficha_interconsulta' THEN
	SELECT trim(razon_empresa) INTO empresa_var
	FROM n_orden_ocupacional n
	INNER JOIN ficha_interconsulta f ON n.n_orden = f.n_orden
	WHERE f.cod_fichaint = norden_param;
    ELSE
	SELECT trim(razon_empresa) INTO empresa_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
    END IF;
    
    SELECT COALESCE(informe_completo, FALSE) INTO completo_electro_var FROM informe_electrocardiograma WHERE n_orden = norden_param;

    -- Primera condición
    IF name_servicio_param = 'con_panel10D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    -- Segunda condición
    IF name_servicio_param = 'con_panel5D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF ((SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) and empresa_var='OBRASCÓN HUARTE LAIN S.A')THEN 
		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
    
    -- Tercera condicion
    IF name_servicio_param = 'con_panel3D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

     -- Cuarta condición
    IF name_servicio_param = 'con_panel2D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;  
     -- Quinta condición
    
    IF name_servicio_param = 'consent_Muestra_Sangre' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM consent_laboratorios WHERE n_orden = norden_param AND name_conset = name_servicio_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

      -- Sexta condición
    IF name_servicio_param = 'consent_marihuana' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF; 

      -- Septima condición
    IF name_servicio_param = 'consent_Boro' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM consent_Boro WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;        
    END IF;     


    IF name_servicio_param = 'analisis_bioquimicos' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM analisis_bioquimicos WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		ELSE
		    dni_user_registro_var := 1;
		END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 



    IF name_servicio_param = 'lab_clinico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM lab_clinico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		ELSE
		    dni_user_registro_var := 1;
		END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 



    IF name_servicio_param = 'hemograma_autom' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM hemograma_autom WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  

    END IF; 


    IF name_servicio_param = 'lgonadotropina' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM lgonadotropina WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 


    IF name_servicio_param = 'panel2d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM panel2d WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 
    

    IF name_servicio_param = 'panel3d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM panel2d WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 

     IF name_servicio_param = 'toxicologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM toxicologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 


     IF name_servicio_param = 'panel10d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM panel10d WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 



     IF name_servicio_param = 'inmunologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM inmunologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
              
    END IF;


     IF name_servicio_param = 'microbiologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM microbiologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
         
    END IF;       



     IF name_servicio_param = 'lhepatitis' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM lhepatitis WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
         
    END IF;   


-- perfil renal
     IF name_servicio_param = 'l_bioquimica' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM l_bioquimica WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 
    

-- acido urino
     IF name_servicio_param = 'ac_bioquimica2022' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM ac_bioquimica2022 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 


-- perfil hepatico
     IF name_servicio_param = 'perfil_hepatico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM perfil_hepatico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 



-- coprocultivo
     IF name_servicio_param = 'ac_coprocultivo' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM ac_coprocultivo WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
              
    END IF; 
    
-- coproparasitologico

    IF name_servicio_param = 'ac_coproparasitologico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM ac_coproparasitologico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
     END IF;

-- examen inmunologico

    IF name_servicio_param = 'examen_inmunologico' THEN
    
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM examen_inmunologico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
    END IF; 

    IF name_servicio_param = 'audiometria_2023' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM audiometria_2023 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'historia_oc_info' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM historia_oc_info WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
    END IF;

    IF name_servicio_param = 'audiometria_po' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM ficha_audiologica WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 74723311;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		ELSE
		    dni_user_registro_var := 1;
		END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_adic FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
            dni_user_registro_var :=55555555;
            ELSE
            dni_user_registro_var:=1;
            end if;
            descripcion := 'SELLO DEL DOCTOR ADICIONAL';
            name_digitalizacion := 'SELLOFIRMADOCASIG-EXTRA'; --prueba
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'cuestionario_audiometria' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM cuestionario_audiometria WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'oftalmologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM oftalmologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		ELSE
		    dni_user_registro_var := 1;
		END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'oftalmologia_lo' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM oftalmologia_lo WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		ELSE
		    dni_user_registro_var := 1;
		END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'oftalmologia2021' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM oftalmologia2021 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		ELSE
		    dni_user_registro_var := 1;
		END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'odontograma' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM odontograma WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'odontograma_lo' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT o.user_registro INTO user_registro_var 
            FROM odontograma_lo olo 
            INNER JOIN odontograma o on olo.n_orden = o.n_orden
            WHERE olo.n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'radiografia_torax' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM radiografia_torax WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'radiografia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM radiografia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'oit' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM oit WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'evaluacion_musculo_esqueletica' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM evaluacion_musculo_esqueletica WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'evaluacion_musculo_esqueletica2021' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM evaluacion_musculo_esqueletica2021 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'consentimientoInformado' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'cuestionario_nordico' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM cuestionario_nordico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'consentimiento_rayosx' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;


IF name_servicio_param = 'test_fatiga_somnolencia' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM test_fatiga_somnolencia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_electrocardiograma' THEN
        
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM informe_electrocardiograma WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            IF completo_electro_var = TRUE THEN
		dni := 70436528;
	    ELSE
	        dni := dni_user_registro_var;
            END IF;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'antece_enfermedades_altura' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM antece_enfermedades_altura WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'anexo_agroindustrial' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM anexo_agroindustrial WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'consentimientobuenasalud' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'anexo7c' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM anexo7c WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'anexo16a' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM anexo16a WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'antecedentes_patologicos' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM antecedentes_patologicos WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'aptitud_medico_ocupacional_agro' THEN ---cambios por sede, por hacer
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            -- SELECT user_registro INTO user_registro_var 
--             FROM aptitud_medico_ocupacional_agro WHERE n_orden = norden_param;
	    SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
	    IF sede_var = 3 THEN
		dni_user_registro_var = 88888888;
	    ELSE
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSE
	            dni_user_registro_var = 66666666;
		END IF;
	    END IF;
            -- select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'certificado_aptitud_medico_ocupacional' THEN ---cambios por sede, por hacer
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            -- SELECT user_registro INTO user_registro_var 
--             FROM certificado_aptitud_medico_ocupacional WHERE n_orden = norden_param;
--             select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
		    IF sede_var = 3 THEN
			dni_user_registro_var = 88888888;
		    ELSE
			IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
			    dni_user_registro_var := 42664426;
			ELSE
			    dni_user_registro_var = 66666666;
			END IF;
		 END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'ficha_sas' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM ficha_sas WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'certificado_aptitud_medico_resumen' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM certificado_aptitud_medico_resumen WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
	    IF sede_var = 3 THEN
		dni_user_registro_var = 88888888;
	    -- ELSE
-- 		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
-- 		    dni_user_registro_var := 42664426;
-- 		ELSE
-- 	            dni_user_registro_var = 66666666;
-- 		END IF;
	    END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'b_certificado_conduccion' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM b_certificado_conduccion WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'ficha_interconsulta' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT dni_user INTO dni_user_registro_var
            FROM ficha_interconsulta WHERE cod_fichaint = norden_param;
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'b_certificado_altura' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM b_certificado_altura WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_psicologico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM informe_psicologico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'b_uso_respiradores' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM b_uso_respiradores WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'ficha_psicologica_anexo02' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  ficha_psicologica_anexo02 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'ficha_psicologica_anexo03' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  ficha_psicologica_anexo03 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'certificado_altura_poderosa' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM certificado_altura_poderosa WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'aptitud_altura_poderosa' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM aptitud_altura_poderosa WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'aptitud_trabajos_encaliente' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
        
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM aptitud_trabajos_encaliente WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'aptitud_licencia_conduciri' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
        
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  aptitud_licencia_conduciri WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'hoja_consulta_externa' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
        
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  hoja_consulta_externa WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'certificado_aptitud_herramientas_manuales' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
        
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  certificado_aptitud_herramientas_manuales WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'resumen_medico_poderosa' THEN 
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  anexo7c WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_psicolaboral' THEN 
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  informe_psicolaboral WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'certificado_manipuladores_barrick' THEN 
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  certificado_manipuladores_barrick WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_psicologico_estres' THEN 
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  informe_psicologico_estres WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'evaluacion_psicologica_poderosa' THEN 
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  evaluacion_psicologica_poderosa WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'psicologia_espacios_confinados' THEN 
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM  psicologia_espacios_confinados WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
                 
END;
$BODY$
  LANGUAGE plpgsql;


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
