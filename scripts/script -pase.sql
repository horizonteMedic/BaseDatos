select n_orden from n_orden_ocupacional limit 1

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
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, tiempoexperiencia_t_experiencia text, primeraaptitud_chk_primera boolean, revalidacion_chk_revalidacion boolean, fechaexamen_f_examen date, antecedentestodasenfermedadessi_chk_1_si boolean, antecedentestodasenfermedadesno_chk_1_no boolean, antecedentesalcoholismocronicosi_chk_2_si boolean, antecedentesalcoholismocronicono_chk_2_no boolean, antecedentesenfermedadesinvoluntariossi_chk_3_si boolean, antecedentesenfermedadesinvoluntariosno_chk_3_no boolean, antecedentesperdidaconcienciasi_chk_4_si boolean, antecedentesperdidaconcienciano_chk_4_no boolean, chk5si_chk_5_si boolean, chk5no_chk_5_no boolean, antecedentesconsumesustanciassialteresi_chk_7_si boolean, antecedentesconsumesustanciassialtereno_chk_7_no boolean, antecedentesconsumesustanciasnoalteresi_chk_8_si boolean, antecedentesconsumesustanciasnoaltereno_chk_8_no boolean, antecedentesvariosefectossi_chk_9_si boolean, antecedentesvariosefectosno_chk_9_no boolean, antecedentesapneasi_chk_10_si boolean, antecedentesapneano_chk_10_no boolean, antecedentesobesidadsi_chk_11_si boolean, antecedentesobesidadno_chk_11_no boolean, pcomplementariashipoacusiasi_chk_13_si boolean, pcomplementariashipoacusiano_chk_13_no boolean, pcomplementariasalteracionagudezavisualsi_chk_14_si boolean, pcomplementariasalteracionagudezavisualno_chk_14_no boolean, pcomplementariastemoralturassi_chk_15_si boolean, pcomplementariastemoralturasno_chk_15_no boolean, pcomplementariasresfriadosi_chk_16_si boolean, pcomplementariasresfriadono_chk_16_no boolean, pcomplementariasvertigosi_chk_17_si boolean, pcomplementariasvertigono_chk_17_no boolean, pcomplementariacampimetriasi_chk_18_si boolean, pcomplementariacampimetriano_chk_18_no boolean, examenfisicolimitacionfuerzasi_chk_19_si boolean, examenfisicolimitacionfuerzano_chk_19_no boolean, examenfisicoalteracionequilibriosi_chk_20_si boolean, examenfisicoalteracionequilibriono_chk_20_no boolean, examenfisicoanormalidadmarchasi_chk_21_si boolean, examenfisicoanormalidadmarchano_chk_21_no boolean, examenfisicoalteracioncoordinacionsi_chk_22_si boolean, examenfisicoalteracioncoordinacionno_chk_22_no boolean, examenfisicoasimetriafacialsi_chk_23_si boolean, examenfisicoasimetriafacialno_chk_23_no boolean, examefisiconistagmussi_chk_24_si boolean, examefisiconistagmusno_chk_24_no boolean, examenfisicoanormalidadmovimientosi_chk_25_si boolean, examenfisicoanormalidadmovimientono_chk_25_no boolean, examenfisicocirlasi_chk_26_si boolean, examenfisicocirlano_chk_26_no boolean, examenfisicoanormalidadlenguajesi_chk_27_si boolean, examenfisicoanormalidadlenguajeno_chk_27_no boolean, examenfisicomovimientoinvoluntariosi_chk_28_si boolean, examenfisicomovimientoinvoluntariono_chk_28_no boolean, fechadesde_f_desde date, fechahasta_f_hasta date, apto_chk_si boolean, observado_chk_observado boolean, detallemedicina_d_medicina text, detalleinformacion_d_informacion text, noapto_chk_no_apto boolean, aptoconrestriccion_chk_apto_r boolean, observacionesrecomendaciones_b_c_observaciones text, antecedentescomentariosdetalles_comentariosdetalleantecedent text, antecedentesdiabetesmellitussi_chk_29_si boolean, antecedentesdiabetesmellitusno_chk_29_no boolean, chk30si_chk_30_si boolean, chk30no_chk_30_no boolean, examenfisicosustentacionpie_suste_pie_15 boolean, tallatriaje text, pesotriaje text, imctriaje text, cinturatriaje text, icctriaje text, caderatriaje text, temperatura text, frecuenciacardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje text, sistolica text, diastolica text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, conclusiontriaje text, frecuenciarespiratoriatriaje_f_respiratoria text, grado3fichasas_chkgradoiii boolean, grado4fichasas_chkgradoiiii boolean, aptocriterioesifichasas_chk1_apto_sie boolean, tiempolicenciabsas_t_licencia text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, nombresede text, sede text, color integer, namejasper text, nombremedico text, cmpusuario text, dniusuario integer, usuarioFirma text) AS
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
	    ca.usuario_firma
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
	    audiometria_2021 AS au ON n.n_orden = au.n_orden
	LEFT JOIN oftalmologia AS o ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft ON n.n_orden = oft.n_orden
	LEFT JOIN ficha_sas AS fsa ON n.n_orden = fsa.n_orden
	LEFT JOIN b_sas AS s ON s.n_orden = n.n_orden
	LEFT JOIN perimetro_toracico AS p ON p.n_orden=n.n_orden
	LEFT JOIN usuarios AS u ON (u.dni_user = ca.dni_user)
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
