create function sp_mostrar_info_paciente_filtros(norden_p integer, sucursal_p text)
    returns TABLE(n_orden integer, nombres_apellidos text, dni integer, fecha_examen date, nombres text, apellidos text, fecha_nac date, edad integer, empresa text, contrata text, nom_examen text, talla text, peso text, sexo_pa "char", area text, cargo text, direccion_pa text, estado_civil text, estudio_paciente text, lugar_nacimiento text, explotacion text, diastolica text, sistolica text, departamento text, provincia text,
                  distrito text)
    language plpgsql
as
$$
DECLARE
codigo_sede_param INTEGER;
BEGIN
SELECT id INTO codigo_sede_param FROM sede_multisucursal WHERE codigo_sucursal = sucursal_p;

RETURN QUERY
SELECT n.n_orden,TRIM(dp.nombres_pa) || ' ' || TRIM(dp.apellidos_pa) as nombres_apellidos, dp.cod_pa as dni, n.fecha_apertura_po as fecha_examen,
       dp.nombres_pa as nombres, dp.apellidos_pa as apellidos, dp.fecha_nacimiento_pa as fecha_nac, obtener_edad(dp.fecha_nacimiento_pa,CURRENT_DATE) as edad,
       n.razon_empresa as empresa, n.razon_contrata as contrata, n.nom_examen as nom_examn,trj.talla,trj.peso, dp.sexo_pa, n.area_o, n.cargo_de,
       dp.direccion_pa, dp.estado_civil_pa, dp.nivel_est_pa, dp.lugar_nac_pa, n.nom_ex, trj.diastolica, trj.sistolica, dp.departamento_pa, dp.provincia_pa,
       dp.distrito_pa
FROM datos_paciente as dp inner join
     n_orden_ocupacional as n on n.cod_pa=dp.cod_pa left join triaje as trj on  n.n_orden=trj.n_orden where n.n_orden=norden_p and n.cod_sede=codigo_sede_param;
END;
$$;

alter function sp_mostrar_info_paciente_filtros(integer, text) owner to pierola;




update config_general_service_digital
set sello_doc_asig = true
where name_service = 'examen_inmunologico';

alter table antece_enfermedades_altura add column doctor_asignado text;

update config_general_service_digital
set sello_doc_asig = true
where name_service = 'antece_enfermedades_altura';

create function obtener_reporte_antecedentes_enfermedades_altura(p_norden integer, name_service text)
    returns TABLE(nombres text, apellidos text, sexo "char", dni integer, edad text, direccion_paciente text, fecha_nacimiento_paciente date, empresa text, contrata text, cargo text, area text, codigo_enfermedades_altura integer, fecha_antecedente date, edad_usuario text, dni_usuario integer, direccion_usuario text, email_usuario text, norden integer, es_apto boolean, no_es_apto boolean, accidente_cerebro_vascular_no boolean, accidente_cerebro_vascular_si boolean, angina_inestable_no boolean, angina_inestable_si boolean, antecedente_bypass_arterial_no boolean, antecedente_bypass_arterial_si boolean, antecedente_edema_cerebral_no boolean, antecedente_edema_cerebral_si boolean, antecedente_edema_pulmonar_no boolean, antecedente_edema_pulmonar_si boolean, antecedente_neumotorax_no boolean, antecedente_neumotorax_si boolean, arritmia_cardiaca_no boolean, arritmia_cardiaca_si boolean, cardiomiopatia_no boolean, cardiomiopatia_si boolean, cirujia_mayor_no boolean, cirujia_mayor_si boolean, cualquier_insuficiencia_no boolean, cualquier_insuficiencia_si boolean, diabetes_mellitus_no boolean, diabetes_mellitus_si boolean, embarazo_no boolean, embarazo_si boolean, epilepsia_no boolean, epilepsia_si boolean, epoc_no boolean, epoc_si boolean, eritrocitosis_no boolean, eritrocitosis_si boolean, hipertension_arterial_no boolean, hipertension_arterial_si boolean, hipertension_pulmonar_no boolean, hipertension_pulmonar_si boolean, infarto_miocardio_no boolean, infarto_miocardio_si boolean, insuficiencia_cardiaca_no boolean, insuficiencia_cardiaca_si boolean, patologia_hemorragica_no boolean, patologia_hemorragica_si boolean, patologia_valvular_no boolean, patologia_valvular_si boolean, presencia_marca_pasos_no boolean, presencia_marca_pasos_si boolean, presencia_riesgo_cardio_no boolean, presencia_riesgo_cardio_si boolean, transtorno_coagulacion_no boolean, transtorno_coagulacion_si boolean, trombosis_no boolean, trombosis_si boolean, otros_no boolean, otros_si boolean, otros_descripcion text, observaciones text, usuario_registro text, color integer, sede_descripcion text, codigo_sede text, name_jasper text, nombre_usuario text, apellido_usuario text, cmp_usuario text, usuario_firma text, nombreexamen text, doctorAsignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa,
       dp.apellidos_pa,
       dp.sexo_pa,
       noo.cod_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       dp.direccion_pa,
       dp.fecha_nacimiento_pa,
       noo.razon_empresa,
       noo.razon_contrata,
       noo.cargo_de,
       noo.area_o,
       aea.cod_enfaltura,
       aea.fecha_anexoc,
       aea.edad_anexoc,
       aea.dni_user,
       aea.direccion_user,
       aea.email_user,
       aea.n_orden,
       aea.apto,
       aea.no_apto,
       aea.no1,
       aea.si1,
       aea.no2,
       aea.si2,
       aea.no3,
       aea.si3,
       aea.no4,
       aea.si4,
       aea.no5,
       aea.si5,
       aea.no6,
       aea.si6,
       aea.no7,
       aea.si7,
       aea.no8,
       aea.si8,
       aea.no9,
       aea.si9,
       aea.no10,
       aea.si10,
       aea.no11,
       aea.si11,
       aea.no12,
       aea.si12,
       aea.no13,
       aea.si13,
       aea.no14,
       aea.si14,
       aea.no15,
       aea.si15,
       aea.no16,
       aea.si16,
       aea.no17,
       aea.si17,
       aea.no18,
       aea.si18,
       aea.no19,
       aea.si19,
       aea.no20,
       aea.si20,
       aea.no21,
       aea.si21,
       aea.no22,
       aea.si22,
       aea.no23,
       aea.si23,
       aea.no24,
       aea.si24,
       aea.no25,
       aea.si25,
       aea.no26,
       aea.si26,
       aea.txtotros,
       aea.observaciones,
       aea.user_registro,
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
       case
           when noo.razon_empresa = 'MONARCA GOLD S.A.C.'
               then (select nombre_user from usuarios where dni_user = 66666666)
           else u.nombre_user end,
       case
           when noo.razon_empresa = 'MONARCA GOLD S.A.C.'
               then (select apellido_user from usuarios where dni_user = 66666666)
           else u.apellido_user end,
       u.cmp_user,
       aea.usuario_firma,
       noo.nom_examen,
       aea.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN antece_enfermedades_altura aea ON aea.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
         INNER JOIN usuarios u ON aea.dni_user = u.dni_user
WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_antecedentes_enfermedades_altura(integer, text) owner to pierola;



alter table aptitud_trabajos_encaliente add column doctor_asignado text;

alter table aptitud_altura_poderosa add column doctor_asignado text;

update config_general_service_digital
set sello_doc_asig = true
where name_service = 'aptitud_altura_poderosa';

create function obtener_reporte_aptitud_altura_poderosa(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, fechaexamen date, fechahasta date, nombremedico text, apto boolean, aptorestriccion boolean, aptotemporal boolean, noapto boolean, observaciones text, horasalida time without time zone, hemoglobina_txthemoglobina text, hematocritolabclinico_txthematocrito text, vsglabclinico_txtvsg text, glucosalabclinico_txtglucosabio text, creatininalabclinico_txtcreatininabio text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, nombresede text, numerosede text, sede text, color integer, namejasper text, usuariofirma text, explotacion text, lugarnacimiento text, nivelestudio text, estadocivil text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT d.cod_pa,
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
           ELSE (SELECT nombre_sede
                 FROM sede
                 WHERE cod_sede = n.cod_sede)
           END AS nombre_sede,
       CASE
           WHEN n.cod_sede = 1
               THEN CONCAT(n.n_orden, '-T')
           WHEN n.cod_sede = 4
               THEN CONCAT(n.n_orden, '-TP')
           ELSE CONCAT(n.n_orden, '-H')
           END AS numero,
       CASE
           WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
           else (CAST(sm.descripcion AS TEXT)) end,
       n.color,
       obtener_name_jasper(p_norden, name_service),
       ca.usuario_firma,
       n.nom_ex,
       d.lugar_nac_pa,
       d.nivel_est_pa,
       d.estado_civil_pa,
       ca.doctor_asignado
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
$$;

alter function obtener_reporte_aptitud_altura_poderosa(integer, text) owner to pierola;




alter table certificado_altura_poderosa add column doctor_asignado text;

update config_general_service_digital
set sello_doc_asig = true
where name_service = 'certificado_altura_poderosa';

create function obtener_reporte_certificado_trabajo_altura_poderosa(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, fechaexamen_f_examen date, fechacaducidad_f_caducidad date, procedencia_procedencia text, tiempoexperiencia_t_experiencia text, lugarexperiencia_lugar_expe text, accidentestrabajo_txtaccidentes_trab text, antecedentesfamiliares_txtantecedente_familiares text, tecmoderadosi_chk_psico_si1 boolean, tecmoderadono_chk_psico_no1 boolean, convulsionessi_chk_psico_si2 boolean, convulsionesno_chk_psico_no2 boolean, mareossi_chk_psico_si3 boolean, mareosno_chk_psico_no3 boolean, problemasauditivossi_chk_psico_si4 boolean, problemasauditivosno_chk_psico_no4 boolean, problemasequilibriosi_chk_psico_si5 boolean, problemasequilibriono_chk_psico_no5 boolean, acrofobiasi_chk_psico_si6 boolean, acrofobiano_chk_psico_no6 boolean, agarofobiasi_chk_psico_si7 boolean, agarofobiano_chk_psico_no7 boolean, tecmoderadodescripcion_txt_antecpsico_1 text, convulsionesdescripcion_txt_antecpsico_2 text, mareosdescripcion_txt_antecpsico_3 text, problemasauditivosdescripcion_txt_antecpsico_4 text, problemasequilibriodescripcion_txt_antecpsico_5 text, acrofobiadescripcion_txt_antecpsico_6 text, agarofobiadescripcion_txt_antecpsico_7 text, tabacocantidad_txt_tabaco_cantiad text, tabacofrecuencia_txt_tabaco_frecuencia text, alcoholcantidad_txt_alcohol_cantiad text, alcoholfrecuencia_txt_alcohol_frecuencia text, drogascantidad_txt_drogas_cantiad text, drogasfrecuencia_txt_drogas_frecuencia text, hojacocacantidad_txt_hojacoca_cantiad text, hojacocafrecuencia_txt_hojacoca_frecuencia text, cafecantidad_txt_cafe_cantiad text, cafefrecuencia_txt_cafe_frecuencia text, gustadivertirsesi_chktest_si1 boolean, gustadivertirseno_chktest_no1 boolean, gustadivertirsepuntaje_txttest_p1 text, tardecompromisosi_chktest_si2 boolean, tardecompromisono_chktest_no2 boolean, tardecompromisopuntaje_txttest_p2 text, criticaformabebersi_chktest_si3 boolean, criticaformabeberno_chktest_no3 boolean, criticaformabeberpuntaje_txttest_p3 text, reuniondivertirsereanimasi_chktest_si4 boolean, reuniondivertirsereanimano_chktest_no4 boolean, reuniondivertirsereanimapuntaje_txttest_p4 text, impresionbebermenossi_chktest_si5 boolean, impresionbebermenosno_chktest_no5 boolean, impresionbebermenospuntaje_txttest_p5 text, duermebiensi_chktest_si6 boolean, duermebienno_chktest_no6 boolean, duermebienpuntaje_txttest_p6 text, costumbrebebersi_chktest_si7 boolean, costumbrebeberno_chktest_no7 boolean, costumbrebeberpuntaje_txttest_p7 text, nerviosoamenudosi_chktest_si8 boolean, nerviosoamenudono_chktest_no8 boolean, nerviosoamenudopuntaje_txttest_p8 text, bebercalmarnerviossi_chktest_si9 boolean, bebercalmarnerviosno_chktest_no9 boolean, bebercalmarnerviospuntaje_txttest_p9 text, doloresespaldasi_chktest_si10 boolean, doloresespaldano_chktest_no10 boolean, doloresespaldapuntaje_txttest_p10 text, anamnesis_txtanamnesis text, apreciaciongeneral_txtapresiaciongeneral text, cabeza_txtcabeza text, piel_txtpiel text, motilidadocular_txtmotilidadocular text, otoscopiaod_txtotoscopiaod text, otoscopiaoi_txtotoscopiaoi text, nariz_txtnariz text, aprespiratorio_txtaprespiratorio text, apcardiovascular_txtapcardiovascuar text, abdomen_txtabdomen text, musculoesqueletico_txtmusculoesqueletico text, columna_txtcolumna text, tesepworth_txttesepworth text, reflejos_txtreflejos text, dedonariznegativo_chkneuro_neg1 boolean, dedonarizpositivo_chkneuro_pos1 boolean, indicebaranynegativo_chkneuro_neg2 boolean, indicebaranypositivo_chkneuro_pos2 boolean, diadococinesianegativo_chkneuro_neg3 boolean, diadococinesiapositivo_chkneuro_pos3 boolean, rombergsimplenegativo_chkneuro_neg4 boolean, rombergsimplepositivo_chkneuro_pos4 boolean, rombergsensibilizadonegativo_chkneuro_neg5 boolean, rombergsensibilizadopositivo_chkneuro_pos5 boolean, marchatandemnegativo_chkneuro_neg6 boolean, marchatandempositivo_chkneuro_pos6 boolean, unterbergnegativo_chkneuro_neg7 boolean, unterbergpositivo_chkneuro_pos7 boolean, babinskinegativo_chkneuro_neg8 boolean, babinskipositivo_chkneuro_pos8 boolean, dixnegativo_chkneuro_neg9 boolean, dixpositivo_chkneuro_pos9 boolean, marchanegativo_chkneuro_neg10 boolean, marchapositivo_chkneuro_pos10 boolean, diagnostico_txtdiagnostico text, apto_chk_apto boolean, noapto_chk_no_apto boolean, aptorestriccion_chk_apto_r boolean, conclusiones_atxtobservaciones text, dniusuario_dni_user integer, otrosexameneslaboratorio_txtotrosexamlab text, altura_txtaltura text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, cinturatriaje_cintura text, icctriaje_icc text, caderatriaje_cadera text, temperaturatriaje_temperatura text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje_perimetro_cuello text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, odcc_odcc text, oicc_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlc_odlc text, oilc_oilc text, vc_vc text, vb_vb text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesoftalmo_e_oculares1 text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, hemoglobinalaboratorioclinico_txthemoglobina text, hematocritolaboratorioclinico_txthematocrito text, glucosalaboratorioclinico_txtglucosabio text, creatininalaboratorioclinico_txtcreatininabio text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, nombremedico text, cmpusuario text, nombresede text, sede text, color integer, namejasper text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, usuariofirma text, lugarnacimiento text, nivelestudio text, estadocivil text, celularpaciente text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT d.cod_pa,
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

       ca.chk_psico_si1,
       ca.chk_psico_no1,
       ca.chk_psico_si2,
       ca.chk_psico_no2,
       ca.chk_psico_si3,
       ca.chk_psico_no3,
       ca.chk_psico_si4,
       ca.chk_psico_no4,
       ca.chk_psico_si5,
       ca.chk_psico_no5,
       ca.chk_psico_si6,
       ca.chk_psico_no6,
       ca.chk_psico_si7,
       ca.chk_psico_no7,

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

       ca.chktest_si1,
       ca.chktest_no1,
       ca.txttest_p1,
       ca.chktest_si2,
       ca.chktest_no2,
       ca.txttest_p2,
       ca.chktest_si3,
       ca.chktest_no3,
       ca.txttest_p3,
       ca.chktest_si4,
       ca.chktest_no4,
       ca.txttest_p4,
       ca.chktest_si5,
       ca.chktest_no5,
       ca.txttest_p5,
       ca.chktest_si6,
       ca.chktest_no6,
       ca.txttest_p6,
       ca.chktest_si7,
       ca.chktest_no7,
       ca.txttest_p7,
       ca.chktest_si8,
       ca.chktest_no8,
       ca.txttest_p8,
       ca.chktest_si9,
       ca.chktest_no9,
       ca.txttest_p9,
       ca.chktest_si10,
       ca.chktest_no10,
       ca.txttest_p10,
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

       ca.chkneuro_neg1,
       ca.chkneuro_pos1,
       ca.chkneuro_neg2,
       ca.chkneuro_pos2,
       ca.chkneuro_neg3,
       ca.chkneuro_pos3,
       ca.chkneuro_neg4,
       ca.chkneuro_pos4,
       ca.chkneuro_neg5,
       ca.chkneuro_pos5,
       ca.chkneuro_neg6,
       ca.chkneuro_pos6,
       ca.chkneuro_neg7,
       ca.chkneuro_pos7,
       ca.chkneuro_neg8,
       ca.chkneuro_pos8,
       ca.chkneuro_neg9,
       ca.chkneuro_pos9,
       ca.chkneuro_neg10,
       ca.chkneuro_pos10,

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
           END                                 AS v_cerca_s_od,

       CASE
           WHEN oft.txtcercasincorregiroi IS NOT NULL THEN oft.txtcercasincorregiroi
           ELSE o.v_cerca_s_oi
           END                                 AS v_cerca_s_oi,

       -- Visión cerca corregida
       CASE
           WHEN oft.txtcercacorregidaod IS NOT NULL THEN oft.txtcercacorregidaod
           WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od
           ELSE ol.v_cerca_c_od
           END                                 AS ODCC,

       CASE
           WHEN oft.txtcercacorregidaoi IS NOT NULL THEN oft.txtcercacorregidaoi
           WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi
           ELSE ol.v_cerca_c_oi
           END                                 AS OICC,

       -- Visión lejos sin corregir
       CASE
           WHEN oft.txtlejossincorregirod IS NOT NULL THEN oft.txtlejossincorregirod
           ELSE o.v_lejos_s_od
           END                                 AS v_lejos_s_od,

       CASE
           WHEN oft.txtlejossincorregiroi IS NOT NULL THEN oft.txtlejossincorregiroi
           ELSE o.v_lejos_s_oi
           END                                 AS v_lejos_s_oi,

       -- Visión lejos corregida
       CASE
           WHEN oft.txtlejoscorregidaod IS NOT NULL THEN oft.txtlejoscorregidaod
           WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od
           ELSE ol.v_lejos_c_od
           END                                 AS ODLC,

       CASE
           WHEN oft.txtlejoscorregidaoi IS NOT NULL THEN oft.txtlejoscorregidaoi
           WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi
           ELSE ol.v_lejos_c_oi
           END                                 AS OILC,

       -- Colores
       CASE
           WHEN oft.rbtecishihara_normal = 'TRUE' THEN 'NORMAL'
           WHEN oft.rbtecishihara_anormal = 'TRUE' THEN 'ANORMAL'
           WHEN ol.v_colores IS NULL THEN o.v_colores
           ELSE ol.v_colores
           END                                 AS VC,

       -- Binocular
       CASE
           WHEN oft.txtbinocularsincorregir IS NOT NULL THEN oft.txtbinocularsincorregir
           WHEN ol.v_binocular IS NULL THEN o.v_binocular
           ELSE ol.v_binocular
           END                                 AS VB,

       -- Reflejos Pupilares
       CASE
           WHEN oft.txtrp IS NOT NULL THEN oft.txtrp
           WHEN ol.r_pupilares IS NULL THEN o.r_pupilares
           ELSE ol.r_pupilares
           END                                 AS RP,

       -- Diagnóstico
       CASE
           WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico
           ELSE o.e_oculares
           END                                 AS e_oculares,
       o.e_oculares1,
       pt.p_max_inspiracion,
       pt.p_ex_forzada,
       l.txthemoglobina,
       l.txthematocrito,
       l.txtglucosabio,
       l.txtcreatininabio,
       l.txtcocaina,
       l.txtmarihuana,
       a.txtcolesterol,
       a.txtldlcolesterol,
       a.txthdlcolesterol,
       a.txtvldlcolesterol,
       a.txttrigliseridos,
       u.nombre_user || ' ' || u.apellido_user AS nom_medico,
       u.cmp_user,
       CASE
           WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
               THEN 'Huamachuco'
           ELSE (SELECT nombre_sede
                 FROM sede
                 WHERE cod_sede = n.cod_sede)
           END                                 AS nombre_sede,
       CASE
           WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
           else (CAST(sm.descripcion AS TEXT)) end,
       n.color,
       obtener_name_jasper(p_norden, name_service),
       au.o_d_500,
       au.o_d_1000,
       au.o_d_2000,
       au.o_d_3000,
       au.o_d_4000,
       au.o_d_6000,
       au.o_d_8000,
       au.o_i_500,
       au.o_i_1000,
       au.o_i_2000,
       au.o_i_3000,
       au.o_i_4000,
       au.o_i_6000,
       au.o_i_8000,
       au.diagnostico,
       ca.usuario_firma,
       d.lugar_nac_pa,
       d.nivel_est_pa,
       d.estado_civil_pa,
       d.cel_pa,
       ca.doctor_asignado
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
                   ON l.n_orden = n.n_orden
         LEFT JOIN analisis_bioquimicos AS a
                   ON (a.n_orden = n.n_orden)
         LEFT JOIN audiometria_po AS au
                   ON (au.n_orden = n.n_orden)
         LEFT JOIN usuarios AS u
                   ON (u.dni_user = ca.dni_user)
WHERE n.n_orden = p_norden;

END;
$$;

alter function obtener_reporte_certificado_trabajo_altura_poderosa(integer, text) owner to pierola;

create function obtener_reporte_informe_electro_cardiograma(p_norden integer, name_service text)
    returns TABLE(nombres text, sexo "char", dni integer, edad text, empresa text, contrata text, codigo_electrocardiograma integer, n_orden integer, fecha_informe date, mensaje_ritmo text, mensaje_pr text, mensaje_fc text, mensaje_qtc text, mensaje_qrs text, mensaje_eje text, hallazgo text, conclusion text, recomendaciones text, color integer, sede text, codigo_sede text, name_jasper text, onda_p text, s_t text, onda_t text, q_t text, fecha_nacimiento date, informe_completo boolean, presion_arterial text, procedencia text, usuario_firma text, direccion_paciente text, estado_civil_paciente text, nivel_estudios_paciente text, ocupacion_paciente text, cargo_paciente text, area_paciente text, tipo_examen text, fecha_apertura date, descripcion_digitalizacion text, name_digitalizacion text, dni_digitalizacion integer)
    language plpgsql
as
$$
BEGIN
    -- Tabla temporal para los parametros digitalizados
    CREATE TEMP TABLE temp_digitalizados_informe_electro_cardiograma AS
SELECT p_norden AS n_orden, *
FROM obtener_parametros_digitalizados(p_norden, name_service);

RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       dp.sexo_pa,
       noo.cod_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       noo.razon_empresa,
       noo.razon_contrata,
       ie.cod_elec,
       ie.n_orden,
       ie.fecha_informe,
       ie.ritmo,
       ie.p_r,
       ie.f_c,
       ie.q_t_c,
       ie.q_r_s,
       ie.eje,
       ie.hallazgo,
       ie.conclusion,
       ie.recomendaciones,
       noo.color,
       CAST(sm.descripcion AS TEXT),
       CASE
           WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
           WHEN noo.cod_sede = 1 THEN 'Trujillo'
           WHEN noo.cod_sede = 2 THEN 'Huamachuco'
           WHEN noo.cod_sede = 3 THEN 'Huancayo'
           WHEN noo.cod_sede = 4 THEN 'Trujillo'
           END                                                                      AS nom_sede,
       obtener_name_jasper(p_norden, name_service),
       CASE WHEN ie.onda_p IS NOT NULL THEN ie.onda_p ELSE iep.onda_p END,
       CASE WHEN ie.s_t IS NOT NULL THEN ie.s_t ELSE iep.s_t END,
       CASE WHEN ie.onda_t IS NOT NULL THEN ie.onda_t ELSE iep.onda_t END,
       ie.q_t,
       dp.fecha_nacimiento_pa,
       CASE WHEN ie.informe_completo IS NULL THEN TRUE ELSE ie.informe_completo END AS informe_completo,
       tr.sistolica || '/' || tr.diastolica || ' mmHg',
       dp.lugar_nac_pa,
       ie.usuario_firma,
       dp.direccion_pa,
       dp.estado_civil_pa,
       dp.nivel_est_pa,
       dp.ocupacion_pa,
       noo.cargo_de,
       noo.area_o,
       noo.nom_examen,
       noo.fecha_apertura_po,
       td.descripcion,
       td.name_digitalizacion,
       td.dni
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN informe_electrocardiograma ie ON ie.n_orden = noo.n_orden
         LEFT JOIN informe_electrocardiograma_poderosa iep ON iep.n_orden = noo.n_orden
         LEFT JOIN triaje tr ON tr.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
         INNER JOIN temp_digitalizados_informe_electro_cardiograma td ON ie.n_orden = td.n_orden
WHERE noo.n_orden = p_norden;

DROP TABLE IF EXISTS temp_digitalizados_informe_electro_cardiograma;

END;
$$;


ALTER TABLE lab_clinico ADD COLUMN doctor_asignado TEXT;

create function obtener_datos_lab_clinico_reporte(n_orden_param integer)
    returns TABLE(nombres text, empresa text, contrata text, cod_labclinico integer, tipo_servicio text, n_orden integer, fecha_lab date, chko boolean, chka boolean, chkb boolean, chkab boolean, rbrhpositivo boolean, rbrhnegativo boolean, txthemoglobina text, txthematocrito text, txtvsg text, txtleucocitosematologia text, txthematiesematologia text, txtneutrofilos text, txtabastonados text, txtsegmentadosematologia text, txtmonocitosematologia text, txteosinofiosematologia text, txtbasofilosematologia text, txtlinfocitosematologia text, txtglucosabio text, txtcreatininabio text, chkpositivo boolean, chknegativo boolean, txtvih text, txtcoloref text, txtdensidadef text, txtaspectoef text, txtphef text, txtnitritoseq text, txtproteinaseq text, txtcetonaseq text, txtleucocitoseq text, txturobilinogenoeq text, txtbilirubinaeq text, txtglucosaeq text, txtsangreeq text, txtleucocitossu text, txtcelepitelialessu text, txtcilindiossu text, txtbacteriassu text, txthematiessu text, txtcristalessu text, txtpussu text, txtotrossu text, txtcocaina text, txtmarihuana text, txtobservacioneslb text, res_lab text, txtplaquetas text, txtac_ascorbico text, user_registro text, color integer, sede text, direccion_sede4 text, email_sede4 text, telefono_sede4 text, celular_sede4 text, direccion_sede3 text, email_sede3 text, telefono_sede3 text, direccion_sede2 text, email_sede2 text, telefono_sede2 text, celular_sede2 text, direccion_sede1 text, email_sede1 text, telefono_sede1 text, usuario_firma text, dni_paciente integer, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, nombreexamen text, codigoclinica text, edadpaciente text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.apellidos_pa || ' ' || dp.nombres_pa,
       n.razon_empresa,
       n.razon_contrata,
       lbl.cod_labclinico,
       lbl.tipo_servicio,
       lbl.n_orden,
       lbl.fecha_lab,
       lbl.chko,
       lbl.chka,
       lbl.chkb,
       lbl.chkab,
       lbl.rbrhpositivo,
       lbl.rbrhnegativo,
       lbl.txthemoglobina,
       lbl.txthematocrito,
       lbl.txtvsg,
       lbl.txtleucocitosematologia,
       lbl.txthematiesematologia,
       lbl.txtneutrofilos,
       lbl.txtabastonados,
       lbl.txtsegmentadosematologia,
       lbl.txtmonocitosematologia,
       lbl.txteosinofiosematologia,
       lbl.txtbasofilosematologia,
       lbl.txtlinfocitosematologia,
       lbl.txtglucosabio,
       lbl.txtcreatininabio,
       lbl.chkpositivo,
       lbl.chknegativo,
       lbl.txtvih,
       lbl.txtcoloref,
       lbl.txtdensidadef,
       lbl.txtaspectoef,
       lbl.txtphef,
       lbl.txtnitritoseq,
       lbl.txtproteinaseq,
       lbl.txtcetonaseq,
       lbl.txtleucocitoseq,
       lbl.txturobilinogenoeq,
       lbl.txtbilirubinaeq,
       lbl.txtglucosaeq,
       lbl.txtsangreeq,
       lbl.txtleucocitossu,
       lbl.txtcelepitelialessu,
       lbl.txtcilindiossu,
       lbl.txtbacteriassu,
       lbl.txthematiessu,
       lbl.txtcristalessu,
       lbl.txtpussu,
       lbl.txtotrossu,
       lbl.txtcocaina,
       lbl.txtmarihuana,
       lbl.txtobservacioneslb,
       lbl.res_lab,
       lbl.txtplaquetas,
       lbl.txtac_ascorbico,
       lbl.user_registro,
       n.color,
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
       lbl.usuario_firma,
       dp.cod_pa,
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       n.cargo_de,
       n.area_o,
       n.nom_examen,
       n.cod_clinica,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       lbl.doctor_asignado
FROM lab_clinico lbl
         INNER JOIN n_orden_ocupacional n ON n.n_orden = lbl.n_orden
         INNER JOIN datos_paciente dp ON dp.cod_pa = n.cod_pa
         INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
WHERE n.n_orden = n_orden_param;
END;
$$;


ALTER TABLE hemograma_autom ADD COLUMN doctor_asignado TEXT;

create function obtener_reporte_hemograma_reporte(n_orden_param integer)
    returns TABLE
            (
                nombres                 text,
                edad                    text,
                n_orden                 integer,
                dni                     integer,
                fecha_examen            date,
                txthemoglobina          text,
                txthematocrito          text,
                txthematies             text,
                txtvolumen              text,
                txthemocorpuscular      text,
                txtconcentracion        text,
                txtleucocitos           text,
                txtneutrofilos          text,
                txtabastonados          text,
                txtsegmentados          text,
                txtmonocitos            text,
                txteosinofios           text,
                txtbasofilos            text,
                txtlinfocitos           text,
                txtplaquetas            text,
                user_registro           text,
                color                   integer,
                descripcion_sede        text,
                direccion_4             text,
                email_4                 text,
                telefono_4              text,
                celular_4               text,
                direccion_3             text,
                email_3                 text,
                telefono_3              text,
                direccion_2             text,
                email_2                 text,
                telefono_2              text,
                celular_2               text,
                direccion_1             text,
                email_1                 text,
                telefono_1              text,
                sexopaciente            "char",
                fechanacimientopaciente date,
                ocupacionpaciente       text,
                lugarnacimientopaciente text,
                nivelestudiopaciente    text,
                estadocivilpaciente     text,
                cargopaciente           text,
                areapaciente            text,
                nombreexamen            text,
                codigoclinica           text,
                empresa                 text,
                contrata                text,
                usuario_firma           text,
                doctorasignado          text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       hemo.n_orden,
       noo.cod_pa,
       hemo.fecha_examen,
       hemo.txthemoglobina,
       hemo.txthematocrito,
       hemo.txthematies,
       hemo.txtvolumen,
       hemo.txthemocorpuscular,
       hemo.txtconcentracion,
       hemo.txtleucocitos,
       hemo.txtneutrofilos,
       hemo.txtabastonados,
       hemo.txtsegmentados,
       hemo.txtmonocitos,
       hemo.txteosinofios,
       hemo.txtbasofilos,
       hemo.txtlinfocitos,
       hemo.txtplaquetas,
       hemo.user_registro,
       noo.color,
       CASE
           WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
           else (CAST(sm.descripcion AS TEXT)) end,
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
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.nom_examen,
       noo.cod_clinica,
       noo.razon_empresa,
       noo.razon_contrata,
       hemo.usuario_firma,
       hemo.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN hemograma_autom hemo ON hemo.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = n_orden_param;
END;
$$;


create function obtener_reporte_hemoglobina(p_norden integer, name_service text)
    returns TABLE(cod_labclinico integer, tipo_servicio text, n_orden integer, fecha_lab date, nom_examen text, nombres_pa text, apellidos_pa text, dni_pa integer, edad_pa text, sexo_pa text, fecha_nacimiento_pa date, lugar_nac_pa text, estado_civil_pa text, nivel_est_pa text, direccion_pa text, empresa text, contrata text, ocupacion_pa text, cargo_de text, area_o text, fecha_apertura_po date, chko boolean, chka boolean, chkb boolean, chkab boolean, rbrhpositivo boolean, rbrhnegativo boolean, txthemoglobina text, txthematocrito text, usuario_firma text, fecha_registro date, nombre_sede text, sede text, color integer, namejasper text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT l.cod_labclinico,
       CAST(l.tipo_servicio AS TEXT),
       n.n_orden,
       l.fecha_lab,
       n.nom_examen,
       CAST(d.nombres_pa AS TEXT),
       CAST(d.apellidos_pa AS TEXT),
       d.cod_pa,
       CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
       CAST(d.sexo_pa AS TEXT),
       d.fecha_nacimiento_pa,
       CAST(d.lugar_nac_pa AS TEXT),
       CAST(d.estado_civil_pa AS TEXT),
       CAST(d.nivel_est_pa AS TEXT),
       CAST(d.direccion_pa AS TEXT),
       CAST(n.razon_empresa AS TEXT),
       CAST(n.razon_contrata AS TEXT),
       CAST(d.ocupacion_pa AS TEXT),
       CAST(n.cargo_de AS TEXT),
       CAST(n.area_o AS TEXT),
       n.fecha_apertura_po,
       l.chko,
       l.chka,
       l.chkb,
       l.chkab,
       l.rbrhpositivo,
       l.rbrhnegativo,
       l.txthemoglobina,
       l.txthematocrito,
       l.usuario_firma,
       CAST(l.fecha_lab AS DATE),
       (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1),
               CAST(sm.descripcion AS TEXT),
               n.color,
               obtener_name_jasper(p_norden, name_service),
               l.doctor_asignado
FROM datos_paciente d
    INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
    INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
    INNER JOIN lab_clinico l ON l.n_orden = n.n_orden
WHERE n.n_orden = p_norden;
END;
$$;


ALTER TABLE analisis_bioquimicos ADD COLUMN doctor_asignado TEXT;


create function laboratorio_obtener_analisis_bioquimico_detalle(norden_param bigint)
    returns TABLE
            (
                nombres_retorn           text,
                fecha_retorn             date,
                n_orden_retorn           integer,
                sede_retorn              text,
                cod_ab_retorn            integer,
                txtcreatinina_retorn     text,
                txtcolesterol_retorn     text,
                txtldlcolesterol_retorn  text,
                txthdlcolesterol_retorn  text,
                txtvldlcolesterol_retorn text,
                txttrigliseridos_retorn  text,
                txtreponsable_retorn     text,
                dir_tru_pierola          text,
                email_tru_pierola        text,
                telf_tru_pierola         text,
                cel_trujillo_pie         text,
                dir_huancayo             text,
                email_huancayo           text,
                telf_huancayo            text,
                dir_huamachuco           text,
                email_huamachuco         text,
                telf_huamachuco          text,
                cel_huamachuco           text,
                dir_trujillo             text,
                email_trujillo           text,
                telf_trujillo            text,
                color                    integer,
                dni_paciente             integer,
                sexopaciente             "char",
                fechanacimientopaciente  date,
                ocupacionpaciente        text,
                lugarnacimientopaciente  text,
                nivelestudiopaciente     text,
                estadocivilpaciente      text,
                cargopaciente            text,
                areapaciente             text,
                nombreexamen             text,
                codigoclinica            text,
                edadpaciente             text,
                empresa                  text,
                contrata                 text,
                gluc_basal_retorn        text,
                fecha_registro           date,
                usuario_firma            text,
                user_medico_ocup         text,
                doctorasignado           text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT d.nombres_pa || ' ' || d.apellidos_pa,
       ab.fecha_ab, -- Este campo ab.fecha_ab es el que mapeas como 'fecha' en el índice 1
       ab.n_orden,
       (SELECT nombre_sede FROM sede WHERE cod_sede = n.cod_sede)::text,
    ab.cod_ab,
       ab.txtcreatinina,
       ab.txtcolesterol,
       ab.txtldlcolesterol,
       ab.txthdlcolesterol,
       ab.txtVldlColesterol,
       ab.txtTrigliseridos,
       ab.txtReponsable,
       -- Sedes
       (SELECT direccion FROM sede WHERE cod_sede = 4)::text,
    (SELECT email FROM sede WHERE cod_sede = 4)::text,
    (SELECT telefono FROM sede WHERE cod_sede = 4)::text,
    (SELECT celular FROM sede WHERE cod_sede = 4)::text,
    (SELECT direccion FROM sede WHERE cod_sede = 3)::text,
    (SELECT email FROM sede WHERE cod_sede = 3)::text,
    (SELECT telefono FROM sede WHERE cod_sede = 3)::text,
    (SELECT direccion FROM sede WHERE cod_sede = 2)::text,
    (SELECT email FROM sede WHERE cod_sede = 2)::text,
    (SELECT telefono FROM sede WHERE cod_sede = 2)::text,
    (SELECT celular FROM sede WHERE cod_sede = 2)::text,
    (SELECT direccion FROM sede WHERE cod_sede = 1)::text,
    (SELECT email FROM sede WHERE cod_sede = 1)::text,
    (SELECT telefono FROM sede WHERE cod_sede = 1)::text,
               -- Datos adicionales
    n.color,
       d.cod_pa,
       d.sexo_pa,
       d.fecha_nacimiento_pa,
       d.ocupacion_pa::text,
    d.lugar_nac_pa::text,
    d.nivel_est_pa::text,
    d.estado_civil_pa::text,
    n.cargo_de::text,
    n.area_o::text,
    n.nom_examen::text,
    n.cod_clinica::text,
    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
       n.razon_empresa::text,
    n.razon_contrata::text,
    ab.gluc_basal,
       ab.fecha_ab,
       ab.usuario_firma,
       ab.user_medico_ocup,
       ab.doctor_asignado
FROM analisis_bioquimicos AS ab
         INNER JOIN n_orden_ocupacional AS n ON n.n_orden = ab.n_orden
         INNER JOIN datos_paciente AS d ON n.cod_pa = d.cod_pa
WHERE ab.n_orden = norden_param;
END;
$$;

ALTER TABLE perfil_hepatico ADD COLUMN doctor_asignado TEXT;

create function obtener_reporte_perfil_hepatico(p_norden integer)
    returns TABLE
            (
                nombres                 text,
                edad                    text,
                n_orden                 integer,
                dni                     integer,
                fecha_examen            date,
                txtr_tgo                text,
                txtr_tgp                text,
                txtr_ggt                text,
                txtr_fosfalcalina       text,
                txtr_bilirrtotal        text,
                txtr_bilirrdirecta      text,
                txtr_bilirrindirecta    text,
                txtr_protetotales       text,
                txtr_albumina           text,
                txtr_globulina          text,
                color                   integer,
                sede_descripcion        text,
                dir_sede4               text,
                email_sede4             text,
                tel_sede4               text,
                cel_sede4               text,
                dir_sede3               text,
                email_sede3             text,
                tel_sede3               text,
                dir_sede2               text,
                email_sede2             text,
                tel_sede2               text,
                cel_sede2               text,
                dir_sede1               text,
                email_sede1             text,
                tel_sede1               text,
                sexopaciente            "char",
                fechanacimientopaciente date,
                ocupacionpaciente       text,
                lugarnacimientopaciente text,
                nivelestudiopaciente    text,
                estadocivilpaciente     text,
                cargopaciente           text,
                areapaciente            text,
                nombreexamen            text,
                codigoclinica           text,
                empresa                 text,
                contrata                text,
                usuario_firma           text,
                doctorasignado          text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       phep.n_orden,
       noo.cod_pa,
       phep.fecha_examen,
       phep.txtr_tgo,
       phep.txtr_tgp,
       phep.txtr_ggt,
       phep.txtr_fosfalcalina,
       phep.txtr_bilirrtotal,
       phep.txtr_bilirrdirecta,
       phep.txtr_bilirrindirecta,
       phep.txtr_protetotales,
       phep.txtr_albumina,
       phep.txtr_globulina,

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
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.nom_examen,
       noo.cod_clinica,
       noo.razon_empresa,
       noo.razon_contrata,
       phep.usuario_firma,
       phep.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN perfil_hepatico phep ON phep.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;

ALTER TABLE l_bioquimica ADD COLUMN doctor_asignado TEXT;

create function obtener_reporte_perfil_renal(p_norden integer)
    returns TABLE
            (
                nombres                 text,
                edad                    text,
                n_orden                 integer,
                dni                     integer,
                fecha                   date,
                txtcreatinina           text,
                txtureaserica           text,
                txtacidourico           text,
                color                   integer,
                sede_descripcion        text,
                dir_sede4               text,
                email_sede4             text,
                tel_sede4               text,
                cel_sede4               text,
                dir_sede3               text,
                email_sede3             text,
                tel_sede3               text,
                dir_sede2               text,
                email_sede2             text,
                tel_sede2               text,
                cel_sede2               text,
                dir_sede1               text,
                email_sede1             text,
                tel_sede1               text,
                sexopaciente            "char",
                fechanacimientopaciente date,
                ocupacionpaciente       text,
                lugarnacimientopaciente text,
                nivelestudiopaciente    text,
                estadocivilpaciente     text,
                cargopaciente           text,
                areapaciente            text,
                nombreexamen            text,
                codigoclinica           text,
                empresa                 text,
                contrata                text,
                usuario_firma           text,
                doctorasignado          text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

       lbioq.n_orden,
       noo.cod_pa,
       lbioq.fecha_examen,
       lbioq.txtcreatinina,
       lbioq.txtureaserica,
       lbioq.txtacidourico,

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
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.nom_examen,
       noo.cod_clinica,
       noo.razon_empresa,
       noo.razon_contrata,
       lbioq.usuario_firma,
       lbioq.doctor_asignado

FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN l_bioquimica lbioq ON lbioq.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;


ALTER TABLE toxicología ADD COLUMN doctor_asignado TEXT;

create function obetner_reporte_panel5d(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_examen date, txtr_cocaina text, txtr_marihuana text, txtr_anfetamina text, txtr_methanfetamina text, txtr_benzodiacepina text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, nombreexamen text, codigoclinica text, empresa text, contrata text, usuario_firma text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       txc.n_orden,
       noo.cod_pa,
       txc.fecha_examen,
       txc.txtr_cocaina,
       txc.txtr_marihuana,
       txc.txtr_anfetamina,
       txc.txtr_methanfetamina,
       txc.txtr_benzodiacepina,
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
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.nom_examen,
       noo.cod_clinica,
       noo.razon_empresa,
       noo.razon_contrata,
       txc.usuario_firma,
       txc.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN toxicologia txc ON txc.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;

ALTER TABLE oftalmologia ADD COLUMN doctor_asignado TEXT;

create function obtener_reporte_oftalmologia(p_norden integer)
    returns TABLE
            (
                nombres              text,
                edad                 text,
                n_orden              integer,
                dni                  integer,
                fecha_nacimiento_pa  date,
                empresa              text,
                contrata             text,
                nom_examen           text,
                sexo_pa              "char",
                cod_of               integer,
                num_ticket           integer,
                v_cerca_s_od         text,
                v_cerca_s_oi         text,
                v_cerca_c_od         text,
                v_cerca_c_oi         text,
                v_lejos_s_od         text,
                v_lejos_s_oi         text,
                v_lejos_c_od         text,
                v_lejos_c_oi         text,
                v_colores            text,
                v_binocular          text,
                r_pupilares          text,
                e_oculares           text,
                fecha_of             date,
                e_oculares1          text,
                e_oculvisionlejos    text,
                f_actualizacion      date,
                agudezavisuallejor   text,
                color                integer,
                sede_descripcion     text,
                dir_sede4            text,
                email_sede4          text,
                tel_sede4            text,
                cel_sede4            text,
                dir_sede3            text,
                email_sede3          text,
                tel_sede3            text,
                dir_sede2            text,
                email_sede2          text,
                tel_sede2            text,
                cel_sede2            text,
                dir_sede1            text,
                email_sede1          text,
                tel_sede1            text,
                lugar_nac_pa         text,
                direccion_pa         text,
                ocupacion_pa         text,
                cargo_de             text,
                area_o               text,
                usuario_firma        text,
                nivelestudiopaciente text,
                estadocivilpaciente  text,
                codigoclinica        text,
                doctorasignado       text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
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
       of.usuario_firma,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cod_clinica,
       of.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN oftalmologia of ON of.n_orden = noo.n_orden
    INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;



alter table audiometria_po
    add usuario_firma text;

alter table audiometria_po
    add doctor_asignado text;



create function obtener_informacion_audiometriapo(p_norden integer)
    returns TABLE
            (
                nombres             text,
                edad                text,
                n_orden             integer,
                dni                 integer,
                fecha_nacimiento_pa date,
                empresa             text,
                contrata            text,
                nom_examen          text,
                cod_au              integer,
                num_ticket          integer,
                fecha_au            date,
                o_d_500             text,
                o_d_1000            text,
                o_d_2000            text,
                o_d_3000            text,
                o_d_4000            text,
                o_d_6000            text,
                o_d_8000            text,
                o_i_500             text,
                o_i_1000            text,
                o_i_2000            text,
                o_i_3000            text,
                o_i_4000            text,
                o_i_6000            text,
                o_i_8000            text,
                o_d1_500            text,
                o_d1_1000           text,
                o_d1_2000           text,
                o_d1_3000           text,
                o_d1_4000           text,
                o_d1_6000           text,
                o_d1_8000           text,
                o_i1_500            text,
                o_i1_1000           text,
                o_i1_2000           text,
                o_i1_3000           text,
                o_i1_4000           text,
                o_i1_6000           text,
                o_i1_8000           text,
                diagnostico         text,
                sexo_pa             "char",
                direccion_pa        text,
                estado_civil_pa     text,
                nivel_est_pa        text,
                ocupacion_pa        text,
                lugar_nac_pa        text,
                cargo_paciente      text,
                area_paciente       text,
                fecha_apertura      date,
                codigo_clinica      text,
                color               integer,
                sede                text,
                usuariofirma        text,
                doctorasignado      text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

       apo.n_orden,
       noo.cod_pa,
       dp.fecha_nacimiento_pa,
       noo.razon_empresa,
       noo.razon_contrata,
       noo.nom_examen,

       apo.cod_au,
       apo.num_ticket,
       apo.fecha_au,
       apo.o_d_500,
       apo.o_d_1000,
       apo.o_d_2000,
       apo.o_d_3000,
       apo.o_d_4000,
       apo.o_d_6000,
       apo.o_d_8000,
       apo.o_i_500,
       apo.o_i_1000,
       apo.o_i_2000,
       apo.o_i_3000,
       apo.o_i_4000,
       apo.o_i_6000,
       apo.o_i_8000,
       apo.o_d1_500,
       apo.o_d1_1000,
       apo.o_d1_2000,
       apo.o_d1_3000,
       apo.o_d1_4000,
       apo.o_d1_6000,
       apo.o_d1_8000,
       apo.o_i1_500,
       apo.o_i1_1000,
       apo.o_i1_2000,
       apo.o_i1_3000,
       apo.o_i1_4000,
       apo.o_i1_6000,
       apo.o_i1_8000,
       apo.diagnostico,


       dp.sexo_pa,
       dp.direccion_pa,
       dp.estado_civil_pa,
       dp.nivel_est_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,

       noo.cargo_de,
       noo.area_o,
       noo.fecha_apertura_po,
       noo.n_orden::text,
    noo.color,
       CAST(sm.descripcion AS text),
       apo.usuario_firma,
       apo.doctor_asignado

FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN audiometria_po apo ON apo.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;





create function obtener_reporte_riesgo_coronario(p_norden integer, name_service text)
    returns TABLE(cod_pa integer, nombres_pa text, apellidos_pa text, direccion_pa text, sexo_pa text, fecha_nacimiento_pa date, ocupacion_pa text, lugar_nac_pa text, nivel_est_pa text, estado_civil_pa text, fec_nac text, n_orden integer, razon_empresa text, cargo_de text, area_o text, razon_contrata text, fecha_apertura_po date, cod_clinica text, tipo_examen text, fecha_examen date, muestra text, resultado_riesgocoronario integer, user_registro text, usuario_firma text, fecha_registro timestamp without time zone, color integer, nombre_sede text, sede text, namejasper text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT
    d.cod_pa, d.nombres_pa::text, d.apellidos_pa::text, d.direccion_pa::text,
    d.sexo_pa::text, d.fecha_nacimiento_pa, d.ocupacion_pa::text,
    d.lugar_nac_pa::text, d.nivel_est_pa::text, d.estado_civil_pa::text,
    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
    n.n_orden, n.razon_empresa::text, n.cargo_de::text, n.area_o::text,
    n.razon_contrata::text, n.fecha_apertura_po,
    n.n_orden::text AS cod_clinica,
    n.nom_examen::text AS tipo_examen,
    r.fecha_examen, r.muestra, r.resultado_riesgocoronario,
    r.user_registro, r.usuario_firma, r.fecha_registro,
    n.color,
    (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede)::text,
    (SELECT CAST(sm.descripcion AS TEXT) FROM sede_multisucursal sm WHERE sm.id = n.cod_sede),
    obtener_name_jasper(p_norden, name_service)::text
FROM datos_paciente d
         INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
         INNER JOIN riesgocoronario r ON r.n_orden = n.n_orden
WHERE n.n_orden = p_norden;
END; $$;



create function obtener_informacion_audiometriapo(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_nacimiento_pa date, empresa text, contrata text, nom_examen text, cod_au integer, num_ticket integer, fecha_au date, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, diagnostico text, sexo_pa "char", direccion_pa text, estado_civil_pa text, nivel_est_pa text, ocupacion_pa text, lugar_nac_pa text, cargo_paciente text, area_paciente text, fecha_apertura date, codigo_clinica text, color integer, sede text, usuariofirma text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

       apo.n_orden,
       noo.cod_pa,
       dp.fecha_nacimiento_pa,
       noo.razon_empresa,
       noo.razon_contrata,
       noo.nom_examen,

       apo.cod_au,
       apo.num_ticket,
       apo.fecha_au,
       apo.o_d_500,
       apo.o_d_1000,
       apo.o_d_2000,
       apo.o_d_3000,
       apo.o_d_4000,
       apo.o_d_6000,
       apo.o_d_8000,
       apo.o_i_500,
       apo.o_i_1000,
       apo.o_i_2000,
       apo.o_i_3000,
       apo.o_i_4000,
       apo.o_i_6000,
       apo.o_i_8000,
       apo.o_d1_500,
       apo.o_d1_1000,
       apo.o_d1_2000,
       apo.o_d1_3000,
       apo.o_d1_4000,
       apo.o_d1_6000,
       apo.o_d1_8000,
       apo.o_i1_500,
       apo.o_i1_1000,
       apo.o_i1_2000,
       apo.o_i1_3000,
       apo.o_i1_4000,
       apo.o_i1_6000,
       apo.o_i1_8000,
       apo.diagnostico,
       dp.sexo_pa,
       dp.direccion_pa,
       dp.estado_civil_pa,
       dp.nivel_est_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,

       noo.cargo_de,
       noo.area_o,
       noo.fecha_apertura_po,
       noo.n_orden::text,
    noo.color,
       CAST(sm.descripcion AS text),
       apo.usuario_firma,
       apo.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN audiometria_po apo ON apo.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;



alter table ficha_audiologica
    add usuario_firma text;

alter table ficha_audiologica
    add doctor_asignado text;


create function obtener_informacion_fichaaudiologica(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_nacimiento_pa date, empresa text, contrata text, nom_examen text, sexo_pa "char", area_o text, cod_fa integer, fecha_examen date, tiempo_trabajo integer, tiempo_exposicion_total_ponderado text, edad_fa text, chk_tapones boolean, chkgrajeras boolean, chkintenso boolean, chkmoderado boolean, chknomolesto boolean, txtmarca text, txtmodelo text, fechacalibracion date, chk1_si boolean, chk2_si boolean, chk3_si boolean, chk4_si boolean, chk5_si boolean, chk6_si boolean, chk7_si boolean, chk8_si boolean, chk9_si boolean, chk10_si boolean, chk11_si boolean, chk12_si boolean, chk1_no boolean, chk2_no boolean, chk3_no boolean, chk4_no boolean, chk5_no boolean, chk6_no boolean, chk7_no boolean, chk8_no boolean, chk9_no boolean, chk10_no boolean, chk11_no boolean, chk12_no boolean, txtdod250 text, txtdod500 text, txtdod1000 text, txtdoi250 text, txtdoi500 text, txtdoi1000 text, txtldumbraldiscriminacion text, txtliumbraldiscriminacion text, txtldporcentagediscriminacion text, txtliporcentagediscriminacion text, txtldconfort text, txtliconfort text, txtlddisconfort text, txtlidisconfort text, txtresponsable text, txtconclusiones text, txtmedico text, txtotoscopia text, txtmesestrabajo integer, user_registro text, otros text, usuariofirma text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.apellidos_pa || ' ' || dp.nombres_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

       fa.n_orden,
       noo.cod_pa,
       dp.fecha_nacimiento_pa,
       noo.razon_empresa,
       noo.razon_contrata,
       noo.nom_examen,
       dp.sexo_pa,
       noo.area_o,

       fa.cod_fa,
       fa.fecha_examen,
       fa.tiempo_trabajo,
       fa.tiempo_exposicion_total_ponderado,
       fa.edad_fa,
       fa.chk_tapones,
       fa.chkgrajeras,
       fa.chkintenso,
       fa.chkmoderado,
       fa.chknomolesto,
       fa.txtmarca,
       fa.txtmodelo,
       fa.fechacalibracion,
       fa.chk1_si,
       fa.chk2_si,
       fa.chk3_si,
       fa.chk4_si,
       fa.chk5_si,
       fa.chk6_si,
       fa.chk7_si,
       fa.chk8_si,
       fa.chk9_si,
       fa.chk10_si,
       fa.chk11_si,
       fa.chk12_si,
       fa.chk1_no,
       fa.chk2_no,
       fa.chk3_no,
       fa.chk4_no,
       fa.chk5_no,
       fa.chk6_no,
       fa.chk7_no,
       fa.chk8_no,
       fa.chk9_no,
       fa.chk10_no,
       fa.chk11_no,
       fa.chk12_no,
       fa.txtdod250,
       fa.txtdod500,
       fa.txtdod1000,
       fa.txtdoi250,
       fa.txtdoi500,
       fa.txtdoi1000,
       fa.txtldumbraldiscriminacion,
       fa.txtliumbraldiscriminacion,
       fa.txtldporcentagediscriminacion,
       fa.txtliporcentagediscriminacion,
       fa.txtldconfort,
       fa.txtliconfort,
       fa.txtlddisconfort,
       fa.txtlidisconfort,
       fa.txtresponsable,
       fa.txtconclusiones,
       fa.txtmedico,
       fa.txtotoscopia,
       fa.txtmesestrabajo,
       fa.user_registro,
       fa.otros,
       fa.usuario_firma,
       fa.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;
create function obetner_reporte_espirometria(p_norden integer)
    returns TABLE(nombres text, edad text, cod_abs integer, n_orden integer, fecha_examen date, cod_exam integer, fvc text, fev1 text, fev1fvc text, fef25_75 text, interpretacion text, fvc_teorico text, fev1_teorico text, talla text, peso text, usuario_firma text, dnipaciente integer, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, empresa text, codigoclinica text, tipoexamen text, departamento text, provincia text, distrito text, edadpaciente text, sistolica text, diastolica text, doctorasignado text, doctorextra text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       fbs.cod_abs,
       fbs.n_orden,
       fbs.fecha_abs,
       fbs.cod_exam,
       fbs.fvc,
       fbs.fev1,
       fbs.fev1fvc,
       fbs.fef25_75,
       fbs.interpretacion,
       fbs.fvc_teorico,
       fbs.fev1_teorico,
       trj.talla,
       trj.peso,
       fbs.usuario_firma,
       dp.cod_pa,
       dp.direccion_pa,
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.razon_contrata,
       noo.razon_empresa,
       noo.cod_clinica,
       noo.nom_examen,
       dp.departamento_pa,
       dp.provincia_pa,
       dp.distrito_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       trj.sistolica,
       trj.diastolica,
       fbs.doctor_asignado,
       fbs.doctor_extra
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN funcion_abs fbs ON fbs.n_orden = noo.n_orden
         INNER JOIN triaje trj ON noo.n_orden = trj.n_orden
WHERE noo.n_orden = p_norden;
END;
$$;



alter table lgonadotropina
    add doctor_asignado text;




create function obtener_reporte__inmunologia_lgonadotropina(norden_param integer)
    returns TABLE(nombres_completos text, edad text, n_orden integer, dni integer, fecha_examen date, txtresultado text, color integer, descripcion_sede text, direccion_sede4 text, email_sede4 text, telefono_sede4 text, celular_sede4 text, direccion_sede3 text, email_sede3 text, telefono_sede3 text, direccion_sede2 text, email_sede2 text, telefono_sede2 text, celular_sede2 text, direccion_sede1 text, email_sede1 text, telefono_sede1 text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, nombreexamen text, codigoclinica text, empresa text, contrata text, usuario_firma text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       lgo.n_orden,
       noo.cod_pa,
       lgo.fecha_examen,
       lgo.txtresultado,
       noo.color,
       CAST(sm.descripcion AS TEXT),

       s4.direccion,
       s4.email,
       s4.telefono,
       s4.celular,

       s3.direccion,
       s3.email,
       s3.telefono,

       s2.direccion,
       s2.email,
       s2.telefono,
       s2.celular,

       s1.direccion,
       s1.email,
       s1.telefono,
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.nom_examen,
       noo.cod_clinica,
       noo.razon_empresa,
       noo.razon_contrata,
       lgo.usuario_firma,
       lgo.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN lgonadotropina lgo ON lgo.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id

         LEFT JOIN sede s4 ON s4.cod_sede = 4
         LEFT JOIN sede s3 ON s3.cod_sede = 3
         LEFT JOIN sede s2 ON s2.cod_sede = 2
         LEFT JOIN sede s1 ON s1.cod_sede = 1

WHERE noo.n_orden = norden_param;
END;
$$;


alter table consent_laboratorios
    add doctor_asignado text;

create function registrar_actualizar_consent_laboratorio(n_orden_param bigint, name_conset_param text, ant_consume_marih_param boolean, ant_consume_cocacina_param boolean, ant_consume_hoja_coca_param boolean, ant_consume_anfetamina_o_extasis_param boolean, ant_consume_methanfetamina_param boolean, ant_consume_benzodiacepinas_param boolean, ant_consume_opiacesos_param boolean, ant_consume_barbituricos_param boolean, ant_consume_metadona_param boolean, ant_consume_fenciclidina_param boolean, ant_consume_antidepre_tricicli_param boolean, user_registro_param text, user_medico_ocup_param text, fechaex_param date, fecha_consumo_hojacoca_param date, fechaconsumemarih_param date, fechaconsumecocacina_param date, fechaconsumeanfetamina_param date, fechaconsumemethanfetamina_param date, fechaconsumebenzodiacepinas_param date, fechaconsumeopiacesos_param date, fechaconsumebarbituricos_param date, fechaconsumemetadona_param date, fechaconsumefenciclidina_param date, fechaconsumeantidepretricicli_param date, usuario_firma_param text, doctor_asignado_param text)
    returns TABLE(id_resp bigint, mensaje text)
    language plpgsql
as
$$
DECLARE
codigo_existencia_var             integer;
    name_empresa_busqueda_var         text;
    name_user_medico_var              text;
    fecha_consumo_hojacoca_var        date;
    fechaConsumeMarih_var             date;
    fechaConsumeCocacina_var          date;
    fechaConsumeAnfetamina_var        date;
    fechaConsumeMethanfetamina_var    date;
    fechaConsumeBenzodiacepinas_var   date;
    fechaConsumeOpiacesos_var         date;
    fechaConsumeBarbituricos_var      date;
    fechaConsumeMetadona_var          date;
    fechaConsumeFenciclidina_var      date;
    fechaConsumeAntidepreTricicli_var date;

BEGIN
    if (fecha_consumo_hojacoca_param is null) then
        fecha_consumo_hojacoca_var := current_date;
else
        fecha_consumo_hojacoca_var := fecha_consumo_hojacoca_param;
end if;

    if (fechaConsumeMarih_param is null) then
        fechaConsumeMarih_var := current_date;
else
        fechaConsumeMarih_var := fechaConsumeMarih_param;
end if;

    if (fechaConsumeCocacina_param is null) then
        fechaConsumeCocacina_var := current_date;
else
        fechaConsumeCocacina_var := fechaConsumeCocacina_param;
end if;

    if (fechaConsumeAnfetamina_param is null) then
        fechaConsumeAnfetamina_var := current_date;
else
        fechaConsumeAnfetamina_var := fechaConsumeAnfetamina_param;
end if;

    if (fechaConsumeMethanfetamina_param is null) then
        fechaConsumeMethanfetamina_var := current_date;
else
        fechaConsumeMethanfetamina_var := fechaConsumeMethanfetamina_param;
end if;

    if (fechaConsumeBenzodiacepinas_param is null) then
        fechaConsumeBenzodiacepinas_var := current_date;
else
        fechaConsumeBenzodiacepinas_var := fechaConsumeBenzodiacepinas_param;
end if;

    if (fechaConsumeOpiacesos_param is null) then
        fechaConsumeOpiacesos_var := current_date;
else
        fechaConsumeOpiacesos_var := fechaConsumeOpiacesos_param;
end if;


    if (fechaConsumeBarbituricos_param is null) then
        fechaConsumeBarbituricos_var := current_date;
else
        fechaConsumeBarbituricos_var := fechaConsumeBarbituricos_param;
end if;

    if (fechaConsumeMetadona_param is null) then
        fechaConsumeMetadona_var := current_date;
else
        fechaConsumeMetadona_var := fechaConsumeMetadona_param;
end if;

    if (fechaConsumeFenciclidina_param is null) then
        fechaConsumeFenciclidina_var := current_date;
else
        fechaConsumeFenciclidina_var := fechaConsumeFenciclidina_param;
end if;

    if (fechaConsumeAntidepreTricicli_param is null) then
        fechaConsumeAntidepreTricicli_var := current_date;
else
        fechaConsumeAntidepreTricicli_var := fechaConsumeAntidepreTricicli_param;
end if;


    -- Verificar si ya existe el registro
SELECT count(*)
INTO codigo_existencia_var
FROM consent_laboratorios
WHERE n_orden = n_orden_param
  AND name_conset = name_conset_param;


-- Obtener el nombre de la empresa de la historia clinica a registrar;
SELECT trim(razon_empresa) INTO name_empresa_busqueda_var from n_orden_ocupacional where n_orden = n_orden_param;

IF (name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' AND name_conset_param = 'con_panel5D') THEN
        name_user_medico_var = 'AGARCIA';
ELSE
        name_user_medico_var = '';
END IF;

    IF codigo_existencia_var > 0 THEN
        -- Realizar UPDATE
UPDATE consent_laboratorios
SET ant_consume_marih                = ant_consume_marih_param,
    ant_consume_cocacina             = ant_consume_cocacina_param,
    ant_consume_hoja_coca            = ant_consume_hoja_coca_param,
    ant_consume_anfetamina_o_extasis = ant_consume_anfetamina_o_extasis_param,
    ant_consume_methanfetamina       = ant_consume_methanfetamina_param,
    ant_consume_benzodiacepinas      = ant_consume_benzodiacepinas_param,
    ant_consume_opiacesos            = ant_consume_opiacesos_param,
    ant_consume_barbituricos         = ant_consume_barbituricos_param,
    ant_consume_metadona             = ant_consume_metadona_param,
    ant_consume_fenciclidina         = ant_consume_fenciclidina_param,
    ant_consume_antidepre_tricicli   = ant_consume_antidepre_tricicli_param,
    user_registro                    = user_registro_param,
    user_medico_ocup                 = name_user_medico_var,
    fechaex                          = fechaex_param,
    fecha_consumo_hojacoca           = fecha_consumo_hojacoca_var,
    fechaConsumeMarih                = fechaConsumeMarih_var,
    fechaConsumeCocacina             = fechaConsumeCocacina_var,
    fechaConsumeAnfetamina           = fechaConsumeAnfetamina_var,
    fechaConsumeMethanfetamina       = fechaConsumeMethanfetamina_var,
    fechaConsumeBenzodiacepinas      = fechaConsumeBenzodiacepinas_var,
    fechaConsumeOpiacesos            = fechaConsumeOpiacesos_var,
    fechaConsumeBarbituricos         = fechaConsumeBarbituricos_var,
    fechaConsumeMetadona             = fechaConsumeMetadona_var,
    fechaConsumeFenciclidina         = fechaConsumeFenciclidina_var,
    fechaConsumeAntidepreTricicli    = fechaConsumeAntidepreTricicli_var,
    usuario_firma                    = usuario_firma_param,
    doctor_asignado                  = doctor_asignado_param

WHERE n_orden = n_orden_param
  AND name_conset = name_conset_param;

RETURN QUERY SELECT 1::bigint AS id_resp, 'Registro actualizado correctamente'::text;
ELSE
        -- Realizar INSERT
        INSERT INTO consent_laboratorios (n_orden,
                                          name_conset,
                                          ant_consume_marih,
                                          ant_consume_cocacina,
                                          ant_consume_hoja_coca,
                                          ant_consume_anfetamina_o_extasis,
                                          ant_consume_methanfetamina,
                                          ant_consume_benzodiacepinas,
                                          ant_consume_opiacesos,
                                          ant_consume_barbituricos,
                                          ant_consume_metadona,
                                          ant_consume_fenciclidina,
                                          ant_consume_antidepre_tricicli,
                                          user_registro,
                                          user_medico_ocup,
                                          fechaex,
                                          fecha_consumo_hojacoca,
                                          fechaconsumemarih,
                                          fechaconsumecocacina,
                                          fechaconsumeanfetamina,
                                          fechaconsumemethanfetamina,
                                          fechaconsumebenzodiacepinas,
                                          fechaconsumeopiacesos,
                                          fechaconsumebarbituricos,
                                          fechaconsumemetadona,
                                          fechaconsumefenciclidina,
                                          fechaconsumeantidepretricicli,
                                          usuario_firma,
                                          doctor_asignado)
        VALUES (n_orden_param,
                name_conset_param,
                ant_consume_marih_param,
                ant_consume_cocacina_param,
                ant_consume_hoja_coca_param,
                ant_consume_anfetamina_o_extasis_param,
                ant_consume_methanfetamina_param,
                ant_consume_benzodiacepinas_param,
                ant_consume_opiacesos_param,
                ant_consume_barbituricos_param,
                ant_consume_metadona_param,
                ant_consume_fenciclidina_param,
                ant_consume_antidepre_tricicli_param,
                user_registro_param,
                name_user_medico_var,
                fechaex_param,
                fecha_consumo_hojacoca_var,
                fechaConsumeMarih_var,
                fechaConsumeCocacina_var,
                fechaConsumeAnfetamina_var,
                fechaConsumeMethanfetamina_var,
                fechaConsumeBenzodiacepinas_var,
                fechaConsumeOpiacesos_var,
                fechaConsumeBarbituricos_var,
                fechaConsumeMetadona_var,
                fechaConsumeFenciclidina_var,
                fechaConsumeAntidepreTricicli_var,
                usuario_firma_param,
                doctor_asignado_param);
RETURN QUERY SELECT 0::bigint AS id_resp, 'Registro insertado correctamente'::text;
END IF;
END;
$$;


create function obtener_consent_laboratorio(n_orden_param integer, name_conset_param text)
    returns TABLE(n_orden integer, name_conset text, ant_consume_marih boolean, ant_consume_cocacina boolean, ant_consume_hoja_coca boolean, ant_consume_anfetamina_o_extasis boolean, ant_consume_methanfetamina boolean, ant_consume_benzodiacepinas boolean, ant_consume_opiacesos boolean, ant_consume_barbituricos boolean, ant_consume_metadona boolean, ant_consume_fenciclidina boolean, ant_consume_antidepre_tricicli boolean, user_registro text, user_medico_ocup text, fechaex date, usuario_firma text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT cl.n_orden,
       cl.name_conset,
       cl.ant_consume_marih,
       cl.ant_consume_cocacina,
       cl.ant_consume_hoja_coca,
       cl.ant_consume_anfetamina_o_extasis,
       cl.ant_consume_methanfetamina,
       cl.ant_consume_benzodiacepinas,
       cl.ant_consume_opiacesos,
       cl.ant_consume_barbituricos,
       cl.ant_consume_metadona,
       cl.ant_consume_fenciclidina,
       cl.ant_consume_antidepre_tricicli,
       cl.user_registro,
       cl.user_medico_ocup,
       cl.fechaex,
       cl.usuario_firma,
       cl.doctor_asignado
FROM consent_laboratorios cl
WHERE cl.n_orden = n_orden_param
  AND cl.name_conset = name_conset_param;
END;
$$;




create function sp_listar_consentimiento_laboratorio(p_n_orden bigint, p_name_conset text)
    returns TABLE
            (
                nombres                          text,
                edad                             integer,
                dni                              integer,
                empresa                          text,
                n_orden                          integer,
                name_conset                      text,
                ant_consume_marih                boolean,
                ant_consume_cocacina             boolean,
                ant_consume_hoja_coca            boolean,
                ant_consume_anfetamina_o_extasis boolean,
                ant_consume_methanfetamina       boolean,
                ant_consume_benzodiacepinas      boolean,
                ant_consume_opiacesos            boolean,
                ant_consume_barbituricos         boolean,
                ant_consume_metadona             boolean,
                ant_consume_fenciclidina         boolean,
                ant_consume_antidepre_tricicli   boolean,
                user_registro                    text,
                user_medico_ocup                 text,
                fecha                            date,
                fecha_consumo_hojacoca           date,
                fechaconsumemarih                date,
                fechaconsumecocacina             date,
                fechaconsumeanfetamina           date,
                fechaconsumemethanfetamina       date,
                fechaconsumebenzodiacepinas      date,
                fechaconsumeopiacesos            date,
                fechaconsumebarbituricos         date,
                fechaconsumemetadona             date,
                fechaconsumefenciclidina         date,
                fechaconsumeantidepretricicli    date,
                color                            integer,
                sede                             text,
                dir_tru_pierola                  text,
                email_tru_pierola                text,
                telf_tru_pierola                 text,
                cel_trujillo_pie                 text,
                dir_huancayo                     text,
                email_huancayo                   text,
                telf_huancayo                    text,
                dir_huamachuco                   text,
                email_huamachuco                 text,
                telf_huamachuco                  text,
                cel_huamachuco                   text,
                dir_trujillo                     text,
                email_trujillo                   text,
                telf_trujillo                    text,
                usuario_firma                    text,
                direccion_pa                     text,
                sexo_pa                          text,
                ocupacion_pa                     text,
                lugar_nac_pa                     text,
                nivel_est_pa                     text,
                estado_civil_pa                  text,
                cargo_de                         text,
                area_o                           text,
                razon_contrata                   text,
                cod_clinica                      text,
                nom_examen                       text,
                doctorasignado                   text
            )
    language plpgsql
as
$$
BEGIN

RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa            AS nombres,
       obtener_edad(dp.fecha_nacimiento_pa, current_date) AS edad,
       n.cod_pa                                           as dni,
       n.razon_empresa                                    AS empresa,
       csnt_l.n_orden,
       csnt_l.name_conset,
       csnt_l.ant_consume_marih,
       csnt_l.ant_consume_cocacina,
       csnt_l.ant_consume_hoja_coca,
       csnt_l.ant_consume_anfetamina_o_extasis,
       csnt_l.ant_consume_methanfetamina,
       csnt_l.ant_consume_benzodiacepinas,
       csnt_l.ant_consume_opiacesos,
       csnt_l.ant_consume_barbituricos,
       csnt_l.ant_consume_metadona,
       csnt_l.ant_consume_fenciclidina,
       csnt_l.ant_consume_antidepre_tricicli,
       csnt_l.user_registro,
       csnt_l.user_medico_ocup,
       csnt_l.fechaex                                     AS fecha,
       csnt_l.fecha_consumo_hojacoca                      as fecha_consumo_hojacoca,
       csnt_l.fechaConsumeMarih,
       csnt_l.fechaConsumeCocacina,
       csnt_l.fechaConsumeAnfetamina,
       csnt_l.fechaConsumeMethanfetamina,
       csnt_l.fechaConsumeBenzodiacepinas,
       csnt_l.fechaConsumeOpiacesos,
       csnt_l.fechaConsumeBarbituricos,
       csnt_l.fechaConsumeMetadona,
       csnt_l.fechaConsumeFenciclidina,
       csnt_l.fechaConsumeAntidepreTricicli,
       n.color,
       CAST(sm.descripcion AS TEXT)                       AS sede,

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
       csnt_l.usuario_firma,
       dp.direccion_pa,
       CAST(dp.sexo_pa AS TEXT),
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       n.cargo_de,
       n.area_o,
       n.razon_contrata,
       CAST(n.cod_clinica AS TEXT),
       n.nom_examen,
       csnt_l.doctor_asignado
FROM datos_paciente AS dp
         INNER JOIN n_orden_ocupacional AS n ON dp.cod_pa = n.cod_pa
         INNER JOIN consent_laboratorios AS csnt_l ON n.n_orden = csnt_l.n_orden
         INNER JOIN sede_multisucursal AS sm ON n.cod_sede = sm.id
WHERE csnt_l.n_orden = p_n_orden
  AND csnt_l.name_conset = p_name_conset
    LIMIT 1;
END;
$$;


alter table odontograma
    add doctor_asignado text;



create function obtener_reporte_odontograma(p_norden integer, name_service text)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, sexo "char", cod_od integer, fecha_od date, edad_od text, lbl_18 text, lbl_17 text, lbl_16 text, lbl_15 text, lbl_14 text, lbl_13 text, lbl_12 text, lbl_11 text, lbl_21 text, lbl_22 text, lbl_23 text, lbl_24 text, lbl_25 text, lbl_26 text, lbl_27 text, lbl_28 text, lbl_31 text, lbl_32 text, lbl_33 text, lbl_34 text, lbl_35 text, lbl_36 text, lbl_37 text, lbl_38 text, lbl_41 text, lbl_42 text, lbl_43 text, lbl_44 text, lbl_45 text, lbl_46 text, lbl_47 text, lbl_48 text, txtpiezasmalestado integer, txtausentes integer, txtcariadasoturar integer, txtporextraer integer, txtfracturada integer, txtobturacionesefectuadas integer, txtpuentes integer, txtpprmetalicas integer, txtppracrilicas integer, txtptotal integer, txtnormales integer, txtcoronas integer, txtobservaciones text, color integer, sede_descripcion text, nom_sede text, name_jasper text, usuario_firma text, direccionpaciente text, fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
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
       o.usuario_firma,
       dp.direccion_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       o.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN odontograma o ON o.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
--INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
WHERE noo.n_orden = p_norden;
END;
$$;


alter table radiografia add column doctor_asignado text;

create function obtener_reporte_informeradiografico(p_norden integer, name_service text)
    returns TABLE
            (
                nombres                 text,
                edad                    text,
                n_orden                 integer,
                dni                     integer,
                empresa                 text,
                contrata                text,
                sexo                    "char",
                fecha_nac               date,
                nivel_est_pa            text,
                tipo_radio              text,
                info_general            text,
                conclu                  text,
                fecha_ex                date,
                color                   integer,
                sede_descripcion        text,
                cargo                   text,
                name_jasper             text,
                fecharegistro           date,
                usuariofirma            text,
                direccionpaciente       text,
                ocupacionpaciente       text,
                lugarnacimientopaciente text,
                estadocivilpaciente     text,
                area                    text,
                codigoclinica           text,
                nombreexamen            text,
                doctorasignado          text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
                        CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
                        r.n_orden,
                        noo.cod_pa,
                        noo.razon_empresa,
                        noo.razon_contrata,
                        dp.sexo_pa,
                        dp.fecha_nacimiento_pa,
                        dp.nivel_est_pa,
                        r.tipo_radio,
                        r.info_general,
                        r.conclu,
                        r.fecha_ex,
                        noo.color,
                        CAST(sm.descripcion AS TEXT),
                        noo.cargo_de,
                        obtener_name_jasper(p_norden, name_service),
                        r.fecha_registro,
                        r.usuario_firma,
                        dp.direccion_pa,
                        dp.ocupacion_pa,
                        dp.lugar_nac_pa,
                        dp.estado_civil_pa,
                        noo.area_o,
                        noo.cod_clinica,
                        noo.nom_examen,
                        r.doctor_asignado
                 FROM datos_paciente dp
                          INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
                          INNER JOIN radiografia r ON r.n_orden = noo.n_orden
                          INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
                 WHERE noo.n_orden = p_norden;
END;
$$;

alter table radiografia_torax
    add doctor_asignado text;

create function obtener_reporte_radiografiatorax(p_norden integer, name_service text)
    returns TABLE
            (
                nombres                      text,
                apellidos                    text,
                edad                         text,
                n_orden                      integer,
                dni                          integer,
                empresa                      text,
                contrata                     text,
                sexo                         "char",
                cod_rat                      integer,
                fecha_examen                 date,
                edad_rat                     text,
                txtvertices                  text,
                txthilios                    text,
                txtsenoscostofrenicos        text,
                txtmediastinos               text,
                txtsiluetacardiovascular     text,
                txtosteomuscular             text,
                txtconclusionesradiograficas text,
                txtobservacionesrt           text,
                txtcampospulm                text,
                color                        integer,
                sede_descripcion             text,
                name_jasper                  text,
                usuario_firma                text,
                direccionpaciente            text,
                fechanacimientopaciente      date,
                ocupacionpaciente            text,
                lugarnacimientopaciente      text,
                nivelestudiopaciente         text,
                estadocivilpaciente          text,
                cargo                        text,
                area                         text,
                codigoclinica                text,
                nombreexamen                 text,
                doctorasignado               text
            )
    language plpgsql
as
$$
BEGIN

RETURN QUERY
SELECT dp.nombres_pa,
       dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
       rt.n_orden,
       noo.cod_pa,
       noo.razon_empresa,
       noo.razon_contrata,
       dp.sexo_pa,

       rt.cod_rat,
       rt.fecha_examen,
       rt.edad_rat,
       rt.txtvertices,
       rt.txthilios,
       rt.txtsenoscostofrenicos,
       rt.txtmediastinos,
       rt.txtsiluetacardiovascular,
       rt.txtosteomuscular,
       rt.txtconclusionesradiograficas,
       rt.txtobservacionesrt,
       rt.txtcampospulm,

       noo.color,
       CAST(sm.descripcion AS TEXT),
       obtener_name_jasper(p_norden, name_service),
       rt.usuario_firma,
       dp.direccion_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.cod_clinica,
       noo.nom_examen,
       rt.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN radiografia_torax rt ON rt.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;


ALTER TABLE examen_inmunologico add column doctor_asignado TEXT;

create function obtener_reporte_exameninmunologico(p_norden integer)
    returns TABLE
            (
                nombres                 text,
                edad                    text,
                n_orden                 integer,
                dni                     integer,
                fecha_examen            date,
                chkigm_reactivo         boolean,
                chkigm_noreactivo       boolean,
                chkigg_reactivo         boolean,
                chkigg_noreactivo       boolean,
                chkinvalido             boolean,
                txtobservaciones        text,
                cbomarca                text,
                txtvrigm                text,
                txtvrigg                text,
                valorigm                numeric,
                valorigg                numeric,
                medico                  text,
                fecha_sintomas          date,
                formato_marsa           boolean,
                cuantitativo_antigeno   boolean,
                color                   integer,
                sede_descripcion        text,
                dir_sede4               text,
                email_sede4             text,
                tel_sede4               text,
                cel_sede4               text,
                dir_sede3               text,
                email_sede3             text,
                tel_sede3               text,
                dir_sede2               text,
                email_sede2             text,
                tel_sede2               text,
                cel_sede2               text,
                dir_sede1               text,
                email_sede1             text,
                tel_sede1               text,
                direccionpaciente       text,
                sexopaciente            "char",
                fechanacimientopaciente date,
                ocupacionpaciente       text,
                lugarnacimientopaciente text,
                nivelestudiopaciente    text,
                estadocivilpaciente     text,
                cargopaciente           text,
                areapaciente            text,
                contrata                text,
                empresa                 text,
                nombreexamen            text,
                codigoclinica           text,
                usuario_firma           text,
                doctorasignado          text
            )
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
       CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

       exinm.n_orden,
       noo.cod_pa,

       exinm.fecha_examen,
       exinm.chkigm_reactivo,
       exinm.chkigm_noreactivo,
       exinm.chkigg_reactivo,
       exinm.chkigg_noreactivo,
       exinm.chkinvalido,
       exinm.txtobservaciones,
       exinm.cbomarca,
       exinm.txtvrigm,
       exinm.txtvrigg,
       exinm.valorigm,
       exinm.valorigg,
       exinm.medico,
       exinm.fecha_sintomas,
       exinm.formato_marsa,
       exinm.cuantitativo_antigeno,

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
       dp.direccion_pa,
       dp.sexo_pa,
       dp.fecha_nacimiento_pa,
       dp.ocupacion_pa,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cargo_de,
       noo.area_o,
       noo.razon_contrata,
       noo.razon_empresa,
       noo.nom_examen,
       noo.cod_clinica,
       exinm.usuario_firma,
       exinm.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN examen_inmunologico exinm ON exinm.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;
