select n_orden from n_orden_ocupacional limit 1

SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM certificado_aptitud_medico_resumen WHERE n_orden = norden_param;

alter table audiometria_2023 add column usuario_firma text

DROP FUNCTION obtener_reporte_audiometria(integer);

CREATE OR REPLACE FUNCTION obtener_reporte_audiometria(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, cod_au integer, fecha_au date, rbsasordera_si boolean, rbsasordera_no boolean, rbsaacufenos_si boolean, rbsaacufenos_no boolean, rbsavertigo_si boolean, rbsavertigo_no boolean, rbsaotalgia_si boolean, rbsaotalgia_no boolean, rbsasecrecion_si boolean, rbsasecrecion_no boolean, txtsaotrossintomas text, rbamrenitis_si boolean, rbamrenitis_no boolean, rbamsinusitis_si boolean, rbamsinusitis_no boolean, rbamotitis_si boolean, rbamotitis_no boolean, rbamototoxicos_si boolean, rbamototoxicos_no boolean, rbammeningitis_si boolean, rbammeningitis_no boolean, rbamtec_si boolean, rbamtec_no boolean, rbamsordera_si boolean, rbamsordera_no boolean, rbamparotiditis_si boolean, rbamparotiditis_no boolean, rbamsarampion_si boolean, rbamsarampion_no boolean, rbamtbc_si boolean, rbamtbc_no boolean, txtamcuales text, rbeoexposicion_si boolean, rbeoexposicion_no boolean, rbeoprotectores_si boolean, rbeoprotectores_no boolean, rbeosustancias_si boolean, rbeosustancias_no boolean, rbte0a2 boolean, rbte2a4 boolean, rbte4a6 boolean, rbte6a8 boolean, rbte8a10 boolean, rbte10a12 boolean, rbtem12 boolean, rbteeventual boolean, chktapones boolean, chkorejeras boolean, txthplomo text, txthmercurio text, txthtolueno text, txthxileno text, txthplaguic text, txthorganofos text, txttplomo text, txttmercurio text, txtttolueno text, txttxileno text, txttplaguic text, txttorganofos text, txteootros text, rbaepratica_si boolean, rbaepratica_no boolean, rbaeuso_si boolean, rbaeuso_no boolean, rbaeotros_si boolean, rbaeotros_no boolean, txtaecuales text, txtood text, txtooi text, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, txtdiag_od text, txtdiag_oi text, txtcomentarios text, chkrpasimple boolean, chkrpadoble boolean, chkcasemestral boolean, chkcaanual boolean, txtotrasrecomendaciones text, txtanios text, txtmeses text, formato character varying, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, fecha_nacimiento_pa date, sexo "char", areatrabajo text, ocupacion text, nom_examen text, usuario_firma text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.apellidos_pa || ' ' || dp.nombres_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    aud.n_orden,
    noo.cod_pa,
    noo.razon_empresa,
    noo.razon_contrata,

    aud.cod_au,
    aud.fecha_au,
    aud.rbsasordera_si,
    aud.rbsasordera_no,
    aud.rbsaacufenos_si,
    aud.rbsaacufenos_no,
    aud.rbsavertigo_si,
    aud.rbsavertigo_no,
    aud.rbsaotalgia_si,
    aud.rbsaotalgia_no,
    aud.rbsasecrecion_si,
    aud.rbsasecrecion_no,
    aud.txtsaotrossintomas,
    aud.rbamrenitis_si,
    aud.rbamrenitis_no,
    aud.rbamsinusitis_si,
    aud.rbamsinusitis_no,
    aud.rbamotitis_si,
    aud.rbamotitis_no,
    aud.rbamototoxicos_si,
    aud.rbamototoxicos_no,
    aud.rbammeningitis_si,
    aud.rbammeningitis_no,
    aud.rbamtec_si,
    aud.rbamtec_no,
    aud.rbamsordera_si,
    aud.rbamsordera_no,
    aud.rbamparotiditis_si,
    aud.rbamparotiditis_no,
    aud.rbamsarampion_si,
    aud.rbamsarampion_no,
    aud.rbamtbc_si,
    aud.rbamtbc_no,
    aud.txtamcuales,
    aud.rbeoexposicion_si,
    aud.rbeoexposicion_no,
    aud.rbeoprotectores_si,
    aud.rbeoprotectores_no,
    aud.rbeosustancias_si,
    aud.rbeosustancias_no,
    aud.rbte0a2,
    aud.rbte2a4,
    aud.rbte4a6,
    aud.rbte6a8,
    aud.rbte8a10,
    aud.rbte10a12,
    aud.rbtem12,
    aud.rbteeventual,
    aud.chktapones,
    aud.chkorejeras,
    aud.txthplomo,
    aud.txthmercurio,
    aud.txthtolueno,
    aud.txthxileno,
    aud.txthplaguic,
    aud.txthorganofos,
    aud.txttplomo,
    aud.txttmercurio,
    aud.txtttolueno,
    aud.txttxileno,
    aud.txttplaguic,
    aud.txttorganofos,
    aud.txteootros,
    aud.rbaepratica_si,
    aud.rbaepratica_no,
    aud.rbaeuso_si,
    aud.rbaeuso_no,
    aud.rbaeotros_si,
    aud.rbaeotros_no,
    aud.txtaecuales,
    aud.txtood,
    aud.txtooi,
    aud.o_d_500,
    aud.o_d_1000,
    aud.o_d_2000,
    aud.o_d_3000,
    aud.o_d_4000,
    aud.o_d_6000,
    aud.o_d_8000,
    aud.o_i_500,
    aud.o_i_1000,
    aud.o_i_2000,
    aud.o_i_3000,
    aud.o_i_4000,
    aud.o_i_6000,
    aud.o_i_8000,
    aud.o_d1_500,
    aud.o_d1_1000,
    aud.o_d1_2000,
    aud.o_d1_3000,
    aud.o_d1_4000,
    aud.o_d1_6000,
    aud.o_d1_8000,
    aud.o_i1_500,
    aud.o_i1_1000,
    aud.o_i1_2000,
    aud.o_i1_3000,
    aud.o_i1_4000,
    aud.o_i1_6000,
    aud.o_i1_8000,
    aud.txtdiag_od,
    aud.txtdiag_oi,
    aud.txtcomentarios,
    aud.chkrpasimple,
    aud.chkrpadoble,
    aud.chkcasemestral,
    aud.chkcaanual,
    aud.txtotrasrecomendaciones,
    aud.txtanios,
    aud.txtmeses,
    aud.formato,
     

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
    dp.fecha_nacimiento_pa,
    dp.sexo_pa,
    noo.area_o,
    noo.cargo_de,
    noo.nom_examen,
    aud.usuario_firma

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN audiometria_2023 aud ON aud.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

alter table informe_electrocardiograma add column usuario_firma text

DROP FUNCTION obtener_reporte_informe_electro_cardiograma(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_informe_electro_cardiograma(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(nombres text, sexo "char", dni integer, edad text, empresa text, contrata text, codigo_electrocardiograma integer, n_orden integer, fecha_informe date, mensaje_ritmo text, mensaje_pr text, mensaje_fc text, mensaje_qtc text, mensaje_qrs text, mensaje_eje text, hallazgo text, conclusion text, recomendaciones text, color integer, sede text, codigo_sede text, name_jasper text, onda_p text, s_t text, onda_t text, q_t text, fecha_nacimiento date, informe_completo boolean, presion_arterial text, procedencia text, usuario_firma text, descripcion_digitalizacion text, name_digitalizacion text, dni_digitalizacion integer) AS
$BODY$
BEGIN
    -- Tabla temporal para los parametros digitalizados
    CREATE TEMP TABLE temp_digitalizados_informe_electro_cardiograma AS
    SELECT p_norden AS n_orden, *
    FROM obtener_parametros_digitalizados(p_norden, name_service);
    
    RETURN QUERY
    SELECT 
        dp.nombres_pa || ' ' || dp.apellidos_pa,
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
        END AS nom_sede,
        obtener_name_jasper(p_norden, name_service),
        ie.onda_p,
        ie.s_t,
        ie.onda_t,
        ie.q_t,
        dp.fecha_nacimiento_pa,
        CASE WHEN ie.informe_completo IS NULL THEN TRUE ELSE ie.informe_completo END AS informe_completo,
        tr.sistolica || '/' || tr.diastolica || ' mmHg',
        dp.lugar_nac_pa,
        ie.usuario_firma,
        td.descripcion,
        td.name_digitalizacion,
        td.dni
    FROM datos_paciente dp
    INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
    INNER JOIN informe_electrocardiograma ie ON ie.n_orden = noo.n_orden
    LEFT JOIN triaje tr ON tr.n_orden = noo.n_orden
    INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
    INNER JOIN temp_digitalizados_informe_electro_cardiograma td ON ie.n_orden = td.n_orden
    WHERE noo.n_orden = p_norden;

    DROP TABLE IF EXISTS temp_digitalizados_informe_electro_cardiograma;

END;
$BODY$
  LANGUAGE plpgsql;

alter table oit add column usuario_firma text

DROP FUNCTION obtener_reporte_oit(integer);

CREATE OR REPLACE FUNCTION obtener_reporte_oit(IN p_norden integer)
  RETURNS TABLE(nombres text, dni integer, fecha_nac date, sexo "char", doctor text, n_rx integer, fecha_exra date, n_orden integer, n_placa integer, edad text, dni_user integer, f_lectura date, f_radiografia date, rb_buena boolean, rb_aceptable boolean, rb_bajacalidad boolean, rb_inaceptable boolean, rb_sobreexposicion boolean, rb_subexposicion boolean, rb_posicioncentrado boolean, rb_inspiracioninsuficiente boolean, rb_escapulas boolean, rb_artefactos boolean, rb_otros boolean, txt_defectostecnicos text, chk1_d boolean, chk2_d boolean, chk3_d boolean, chk1_i boolean, chk2_i boolean, chk3_i boolean, chk1 boolean, chk2 boolean, chk3 boolean, chk4 boolean, chk5 boolean, chk6 boolean, chk7 boolean, chk8 boolean, chk9 boolean, chk10 boolean, chk11 boolean, chk12 boolean, chk_p_1 boolean, chk_p_2 boolean, chk_p_3 boolean, chk_p_4 boolean, chk_p_5 boolean, chk_p_6 boolean, chk_s_1 boolean, chk_s_2 boolean, chk_s_3 boolean, chk_s_4 boolean, chk_s_5 boolean, chk_s_6 boolean, chko boolean, chka boolean, chkb boolean, chkc boolean, chk2_1 boolean, chk2_2 boolean, chk2_3 boolean, chk2_4 boolean, chk2_5 boolean, chk2_6 boolean, chk2_7 boolean, chk2_8 boolean, chk2_9 boolean, chk2_10 boolean, chk2_11 boolean, chk2_12 boolean, chk2_13 boolean, chk2_14 boolean, chk2_15 boolean, chk2_16 boolean, chk2_17 boolean, chk2_18 boolean, chk2_19 boolean, chk2_20 boolean, chk2_21 boolean, chk2_22 boolean, chk2_23 boolean, chk2_24 boolean, chk2_25 boolean, chk2_26 boolean, chk2_27 boolean, chk2_28 boolean, chk2_29 boolean, chk2_30 boolean, chk2_31 boolean, chk2_32 boolean, chk2_33 boolean, chk2_34 boolean, chk2_35 boolean, chk2_36 boolean, chk2_37 boolean, chk2_38 boolean, chk2_39 boolean, chk2_40 boolean, chk2_41 boolean, chk2_42 boolean, chk2_43 boolean, chk2_44 boolean, chk2_45 boolean, chk2_46 boolean, chk2_47 boolean, chk2_48 boolean, chk2_49 boolean, chk2_50 boolean, chk2_51 boolean, chk2_52 boolean, chk2_53 boolean, chk2_54 boolean, chk2_55 boolean, chk2_56 boolean, chk2_57 boolean, chk2_58 boolean, chk2_59 boolean, chk2_60 boolean, chk2_61 boolean, chk3_si boolean, chk3_no boolean, chk_01 boolean, chk_02 boolean, chk_03 boolean, chk_04 boolean, chk_05 boolean, chk_06 boolean, chk_07 boolean, chk_08 boolean, chk_09 boolean, chk_10 boolean, chk_11 boolean, chk_12 boolean, chk_13 boolean, chk_14 boolean, chk_17 boolean, chk_18 boolean, chk_19 boolean, chk_20 boolean, chk_21 boolean, chk_22 boolean, chk_23 boolean, chk_24 boolean, chk_25 boolean, chk_26 boolean, chk_27 boolean, txt_s_comentarios text, chk_15 boolean, chk_16 boolean, chk_2_si boolean, chk_2_no boolean, chk_e_1 boolean, chk_e_2 boolean, chk_e_3 boolean, chk_e_4 boolean, chk_e_5 boolean, chk_e_6 boolean, chk2_62 boolean, chk2_63 boolean, chk2_64 boolean, chk2_65 boolean, chk2_66 boolean, chk2_67 boolean, chk2_68 boolean, chk2_69 boolean, chk_28 boolean, chk_29 boolean, user_registro text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, anormalidades_parenquimatosas_si boolean, anormalidades_parenquimatosas_no boolean, usuario_firma text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    noo.cod_pa,
    dp.fecha_nacimiento_pa,
    dp.sexo_pa,
    u.nombre_user||' '||u.apellido_user,
    CASE WHEN e.n_orden IS NULL THEN o.n_orden ELSE e.n_rx END,
    e.fecha_exra,
    o.n_orden,
    o.n_placa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
    o.dni_user,
    o.f_lectura,
    o.f_radiografia,
    o.rb_buena,
    o.rb_aceptable,
    o.rb_bajacalidad,
    o.rb_inaceptable,
    o.rb_sobreexposicion,
    o.rb_subexposicion,
    o.rb_posicioncentrado,
    o.rb_inspiracioninsuficiente,
    o.rb_escapulas,
    o.rb_artefactos,
    o.rb_otros,
    o.txt_defectostecnicos,
    o.chk1_d,
    o.chk2_d,
    o.chk3_d,
    o.chk1_i,
    o.chk2_i,
    o.chk3_i,
    o.chk1,
    o.chk2,
    o.chk3,
    o.chk4,
    o.chk5,
    o.chk6,
    o.chk7,
    o.chk8,
    o.chk9,
    o.chk10,
    o.chk11,
    o.chk12,
    o.chk_p_1,
    o.chk_p_2,
    o.chk_p_3,
    o.chk_p_4,
    o.chk_p_5,
    o.chk_p_6,
    o.chk_s_1,
    o.chk_s_2,
    o.chk_s_3,
    o.chk_s_4,
    o.chk_s_5,
    o.chk_s_6,
    o.chko,
    o.chka,
    o.chkb,
    o.chkc,
    o.chk2_1,
    o.chk2_2,
    o.chk2_3,
    o.chk2_4,
    o.chk2_5,
    o.chk2_6,
    o.chk2_7,
    o.chk2_8,
    o.chk2_9,
    o.chk2_10,
    o.chk2_11,
    o.chk2_12,
    o.chk2_13,
    o.chk2_14,
    o.chk2_15,
    o.chk2_16,
    o.chk2_17,
    o.chk2_18,
    o.chk2_19,
    o.chk2_20,
    o.chk2_21,
    o.chk2_22,
    o.chk2_23,
    o.chk2_24,
    o.chk2_25,
    o.chk2_26,
    o.chk2_27,
    o.chk2_28,
    o.chk2_29,
    o.chk2_30,
    o.chk2_31,
    o.chk2_32,
    o.chk2_33,
    o.chk2_34,
    o.chk2_35,
    o.chk2_36,
    o.chk2_37,
    o.chk2_38,
    o.chk2_39,
    o.chk2_40,
    o.chk2_41,
    o.chk2_42,
    o.chk2_43,
    o.chk2_44,
    o.chk2_45,
    o.chk2_46,
    o.chk2_47,
    o.chk2_48,
    o.chk2_49,
    o.chk2_50,
    o.chk2_51,
    o.chk2_52,
    o.chk2_53,
    o.chk2_54,
    o.chk2_55,
    o.chk2_56,
    o.chk2_57,
    o.chk2_58,
    o.chk2_59,
    o.chk2_60,
    o.chk2_61,
    o.chk3_si,
    o.chk3_no,
    o.chk_01,
    o.chk_02,
    o.chk_03,
    o.chk_04,
    o.chk_05,
    o.chk_06,
    o.chk_07,
    o.chk_08,
    o.chk_09,
    o.chk_10,
    o.chk_11,
    o.chk_12,
    o.chk_13,
    o.chk_14,
    o.chk_17,
    o.chk_18,
    o.chk_19,
    o.chk_20,
    o.chk_21,
    o.chk_22,
    o.chk_23,
    o.chk_24,
    o.chk_25,
    o.chk_26,
    o.chk_27,
    o.txt_s_comentarios,
    o.chk_15,
    o.chk_16,
    o.chk_2_si,
    o.chk_2_no,
    o.chk_e_1,
    o.chk_e_2,
    o.chk_e_3,
    o.chk_e_4,
    o.chk_e_5,
    o.chk_e_6,
    o.chk2_62,
    o.chk2_63,
    o.chk2_64,
    o.chk2_65,
    o.chk2_66,
    o.chk2_67,
    o.chk2_68,
    o.chk2_69,
    o.chk_28,
    o.chk_29,
    o.user_registro,
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
    o.anormalidades_parenquimatosas_si,
    o.anormalidades_parenquimatosas_no,
    o.usuario_firma

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN oit o ON o.n_orden = noo.n_orden
  LEFT JOIN ex_radiograficos_sanguineos e ON e.n_orden = noo.n_orden 
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  LEFT JOIN usuarios u ON u.dni_user = o.dni_user
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

alter table radiografia_torax add column usuario_firma text

DROP FUNCTION obtener_reporte_radiografiatorax(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_radiografiatorax(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(nombres text, apellidos text, edad text, n_orden integer, dni integer, empresa text, contrata text, sexo "char", cod_rat integer, fecha_examen date, edad_rat text, txtvertices text, txthilios text, txtsenoscostofrenicos text, txtmediastinos text, txtsiluetacardiovascular text, txtosteomuscular text, txtconclusionesradiograficas text, txtobservacionesrt text, txtcampospulm text, color integer, sede_descripcion text, name_jasper text, usuario_firma text) AS
$BODY$
BEGIN

  RETURN QUERY
  SELECT 
    dp.nombres_pa,
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
    rt.usuario_firma

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN radiografia_torax rt ON rt.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

alter table certificado_aptitud_herramientas_manuales add column usuario_firma text

DROP FUNCTION obtener_reporte_certificado_aptitud_herramientas_manuales(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_certificado_aptitud_herramientas_manuales(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, explotacion text, idcertificado integer, apto boolean, aptorestriccion boolean, aptotemporal boolean, observacion text, fechacertificado date, fechacaducidad date, nombremedico text, nombresede text, numerosede text, sede text, color integer, namejasper text, usuarioFirma text) AS
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
	    n.nom_ex,
	    c.id_certificado,
	    c.apto,
	    c.apto_restriccion,
	    c.apto_temporal,
	    c.observacion,
	    c.fecha_certificado,
	    c.fecha_caducidad,
	    u.nombre_user||' '||u.apellido_user AS nom_medico,
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
	    c.usuario_firma
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN certificado_aptitud_herramientas_manuales AS c
	    ON c.n_orden = n.n_orden
	INNER JOIN usuarios AS u 
	    ON LOWER(u.usuario_user) = LOWER(c.user_registro)
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

alter table certificado_manipuladores_barrick add column usuario_firma text

DROP FUNCTION obtener_reporte_certificado_manipuladores_barrick(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_certificado_manipuladores_barrick(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, fechaexamen date, apt boolean, noapto boolean, observaciones text, recomendaciones text, nombresede text, sede text, color integer, namejasper text, usuarioFirma text) AS
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
	    d.lugar_nac_pa,
	    d.nivel_est_pa,
	    d.estado_civil_pa,
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    n.nom_examen,
	    n.cod_clinica,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
	    cmb.fecha_examen,
	    cmb.chkapto,
	    cmb.chknoapto,
	    cmb.txtobservaciones,
	    cmb.txtrecomendaciones,
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
	    cmb.usuario_firma
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN certificado_manipuladores_barrick AS cmb
	    ON cmb.n_orden = n.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

alter table hoja_consulta_externa add column usuario_firma text

DROP FUNCTION obtener_reporte_hoja_consulta_externa(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_hoja_consulta_externa(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, edadpaciente text, fechaexamen date, horasalida time without time zone, nombremedico text, postavijus boolean, cedro boolean, paraiso boolean, otros boolean, otrosdescripcion text, observaciones text, color integer, sede text, nombresede text, namejasper text, anexo16antecedentespersonales text, anexo16antecedentespersonales2 text, anexo16antecedentesfamiliares text, anexo16otrosexamenes text, anexo16observacionesgenerales text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, creatininalaboratorioclinico_txtcreatininabio text, hemoglobina_txthemoglobina text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, usuarioFirma text) AS
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
	    dp.ocupacion_pa,
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    n.nom_examen,
	    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
	    ca.fecha_examen,
	    ca.horasalida,
	    ca.nom_medico,
	    ca.rbposta_vijus,
	    ca.rbcedro,
	    ca.rbparaiso,
	    ca.rbotros,
	    ca.txtotros,
	    ca.txtobservaciones,
	    n.color,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    CASE
		WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
		WHEN n.cod_sede = 1 THEN 'Trujillo'
		WHEN n.cod_sede = 2 THEN 'Huamachuco'
		WHEN n.cod_sede = 3 THEN 'Huancayo'
		WHEN n.cod_sede = 4 THEN 'Trujillo'
	    END AS nom_sede,
	    obtener_name_jasper(p_norden, name_service),
	    a7.txtantecedentespersonales,
	    a7.txtantecedentespersonales2,
	    a7.txtantecedentesfamiliares,
	    e2.txtotrosex,
	    a7.txtobservacionesfm,
	    l.txtnitritoseq, 
	    l.txtproteinaseq, 
	    l.txtcetonaseq,
	    l.txtleucocitoseq, 
	    l.txturobilinogenoeq, 
	    l.txtbilirubinaeq, 
	    l.txtglucosaeq, 
	    l.txtsangreeq,
	    l.txtleucocitossu,
	    l.txtcelepitelialessu, 
	    l.txtcilindiossu, 
	    l.txtbacteriassu, 
	    l.txthematiessu, 
	    l.txtcristalessu, 
	    l.txtpussu, 
	    l.txtotrossu,
	    l.txtcoloref, 
	    l.txtdensidadef, 
	    l.txtaspectoef, 
	    l.txtphef,
	    l.chko, 
	    l.chka, 
	    l.chkb, 
	    l.chkab,
	    l.rbrhpositivo, 
	    l.rbrhnegativo,
	    l.txtglucosabio,
	    l.txtvsg,
	    l.txtcocaina,
	    l.txtmarihuana,
	    l.txtcreatininabio,
	    l.txthemoglobina,
	    ab.txtcolesterol, 
	    ab.txtldlcolesterol, 
	    ab.txthdlcolesterol, 
	    ab.txtvldlcolesterol,
	    ab.txttrigliseridos,
	    ca.usuario_firma
	  FROM datos_paciente AS dp
	INNER JOIN n_orden_ocupacional AS n 
	    ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	LEFT JOIN hoja_consulta_externa AS ca 
	    ON ca.n_orden = n.n_orden
	INNER JOIN anexo7c AS a7
	    ON a7.n_orden = n.n_orden
	LEFT JOIN lab_clinico AS l 
	    ON n.n_orden = l.n_orden
	LEFT JOIN ex_radiograficos_sanguineos AS e2 
	    ON (e2.n_orden = n.n_orden)
	LEFT JOIN analisis_bioquimicos AS ab 
	    ON (n.n_orden = ab.n_orden)
	WHERE n.n_orden = p_norden;

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

CREATE TABLE protocolo_sub_examen_adicional(
 	id_sub_examen_adicional_protocolo serial primary key,
 	id_sub_examen Integer not null,
	id_protocolo INTEGER NOT NULL,
	precio numeric(38,2),
 	estado boolean,
 	usuario_registro TEXT,
    fecha_registro DATE,
    hora_registro TIME,
    usuario_actualizacion TEXT,
    fecha_actualizacion DATE,
    hora_actualizacion TIME,
	CONSTRAINT fk_sub_examen
        FOREIGN KEY (id_sub_examen)
        REFERENCES sub_examen (id_sub_examen),

    CONSTRAINT fk_protocolo
        FOREIGN KEY (id_protocolo)
        REFERENCES protocolo (id_protocolo)
);

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
