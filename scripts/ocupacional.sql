create function obtener_reporte_psicologia_fobias(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, razonamientoi boolean, razonamientonpi boolean, razonamientonp boolean, razonamientonps boolean, razonamientos boolean, memoriai boolean, memorianpi boolean, memorianp boolean, memorianps boolean, memorias boolean, atencioni boolean, atencionnpi boolean, atencionnp boolean, atencionnps boolean, atencions boolean, coordinacioni boolean, coordinacionnpi boolean, coordinacionnp boolean, coordinacionnps boolean, coordinacions boolean, orientacioni boolean, orientacionnpi boolean, orientacionnp boolean, orientacionnps boolean, orientacions boolean, estabilidadinestable boolean, estabilidadestable boolean, nivelansiedadcaso boolean, nivelansiedadnocaso boolean, consumoalcoholcaso boolean, consumoalcoholnocaso boolean, fobiaalturanada boolean, fobiaalturaligeramente boolean, fobiaalturamoderadamente boolean, fobiaalturamarcadamente boolean, fobiaalturamiedoextremo boolean, apto boolean, noapto boolean, fecha date, analisis text, recomendacion text, nombreexamenpsicologico text, usuariofirma text, nombresede text, sede text, color integer, namejasper text, esohla boolean)
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

               pf.r1,
               pf.r2,
               pf.r3,
               pf.r4,
               pf.r5,
               pf.m1,
               pf.m2,
               pf.m3,
               pf.m4,
               pf.m5,
               pf.at1,
               pf.at2,
               pf.at3,
               pf.at4,
               pf.at5,
               pf.coo1,
               pf.coo2,
               pf.coo3,
               pf.coo4,
               pf.coo5,
               pf.oo1,
               pf.oo2,
               pf.oo3,
               pf.oo4,
               pf.oo5,
               pf.e1,
               pf.e2,
               pf.an1,
               pf.an2,
               pf.ca1,
               pf.ca2,
               pf.f1,
               pf.f2,
               pf.f3,
               pf.f4,
               pf.f5,
               pf.adpto,
               pf.noadpto,
               pf.fecha,
               pf.analisis,
               pf.recomendacion,
               pf.nombre_examen,
               pf.usuario_firma,

               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                       THEN 'Huamachuco'
                   ELSE (SELECT nombre_sede
                         FROM sede
                         WHERE cod_sede = n.cod_sede)
                   END AS nombre_sede,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               n.color,
               obtener_name_jasper(p_norden, name_service),
               CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'OBRASCÓN HUARTE LAIN S.A' THEN TRUE ELSE FALSE END
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal AS sm
                            ON n.cod_sede = sm.id
                 INNER JOIN psicologiafobias AS pf
                            ON pf.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;

END;
$$;

alter function obtener_reporte_psicologia_fobias(integer, text) owner to pierola;


create function obtener_reporte_ficha_psicologica_anexo2(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, estadocivilpaciente text, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, fechaexamen_fecha date, motivoevaluacion_motivo_eval text, presentacionadecuado_rb_adecuado boolean, presentacioninadecuado_rb_inadecuado boolean, posturaerguida_rb_erguida boolean, posturaencorvada_rb_encorvada boolean, ritmolento_rb_lento boolean, ritmorapido_rb_rapido boolean, ritmofluido_rb_fluido boolean, tonobajo_rb_bajo boolean, tonomoderado_rb_moderado boolean, tonoalto_rb_alto boolean, marchacondificultad_rb_condificultad boolean, marchasindificultad_rb_sindificultad boolean, tiempoorientado_rb_tiempo_orientado boolean, tiempodesorientado_rb_tiempo_desorientado boolean, espacioorientado_rb_espacio_orientado boolean, espaciodesorientado_rb_espacio_desorientado boolean, personaorientado_rb_persona_orientado boolean, personadesorientado_rb_persona_desorientado boolean, apto_apto boolean, nivelintelectual_resul_nivel_intelectual text, coordinacionvisomotriz_resul_coordinacion_visomotriz text, nivelmemoria_resul_nivel_memoria text, personalidad_resul_personalidad text, efectividad_resul_efectividad text, areacognitiva_areacognitiva text, areaemocional_areaemocional text, recomendaciones_recomendaciones text, usuariofirma text, nombresede text, sede text, color integer, namejasper text, esohla boolean)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               d.estado_civil_pa,
               d.nombres_pa,
               d.apellidos_pa,
               d.direccion_pa,
               d.sexo_pa,
               d.fecha_nacimiento_pa,
               d.ocupacion_pa,
               d.lugar_nac_pa,
               d.nivel_est_pa,
               n.cargo_de,
               n.area_o,
               n.razon_contrata,
               n.n_orden,
               n.razon_empresa,
               n.nom_examen,
               n.cod_clinica,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               f.fecha,
               f.motivo_eval,
               f.rb_adecuado,
               f.rb_inadecuado,
               f.rb_erguida,
               f.rb_encorvada,
               f.rb_lento,
               f.rb_rapido,
               f.rb_fluido,
               f.rb_bajo,
               f.rb_moderado,
               f.rb_alto,
               f.rb_condificultad,
               f.rb_sindificultad,
               f.rb_tiempo_orientado,
               f.rb_tiempo_desorientado,
               f.rb_espacio_orientado,
               f.rb_espacio_desorientado,
               f.rb_persona_orientado,
               f.rb_persona_desorientado,
               f.apto,
               f.resul_nivel_intelectual,
               f.resul_coordinacion_visomotriz,
               f.resul_nivel_memoria,
               f.resul_personalidad,
               f.resul_efectividad,
               f.areacognitiva,
               f.areaemocional,
               f.recomendaciones,
               f.usuario_firma,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                       THEN 'Huamachuco'
                   ELSE (SELECT nombre_sede
                         FROM sede
                         WHERE cod_sede = n.cod_sede)
                   END AS nombre_sede,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               n.color,
               obtener_name_jasper(p_norden, name_service),
               CASE WHEN UPPER(TRIM(n.razon_empresa)) = 'OBRASCÓN HUARTE LAIN S.A' THEN TRUE ELSE FALSE END
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal AS sm
                            ON n.cod_sede = sm.id
                 INNER JOIN ficha_psicologica_anexo02 AS f
                            ON f.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;

END;
$$;

alter function obtener_reporte_ficha_psicologica_anexo2(integer, text) owner to pierola;


create function obtener_reporte_ficha_interconsulta(p_norden integer, p_especialidad text, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, fecha_apertura date, edadpaciente text, celularpaciente text, frecuenciacardiaca text, sistolica text, diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, imctriaje text, saturacionoxigenotriaje_sat_02 text, temperatura text, peso text, tallatriaje text, codigofichainterconsulta integer, fechaexamen date, horasalida time without time zone, dniusuario integer, especialidad text, motivo text, hallazgo text, diagnostico text, tratamiento text, apto boolean, noapto boolean, nombreusuario text, apellidousuario text, cmpusuario text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, nombresede text, sede text, color integer, namejasper text, nomenclatura text, usuariofirma text, fecharegistro date, userregistro text, lugarnacimiento text, nivelestudio text, estadocivil text, esoftalmologia boolean)
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
               n.fecha_apertura_po,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               d.cel_pa,
               t.f_cardiaca,
               t.sistolica,
               t.diastolica,
               t.f_respiratoria,
               t.imc,
               t.sat_02,
               t.temperatura,
               t.peso,
               t.talla,
               f.cod_fichaint,
               f.fecha_exa,
               f.horasalida,
               f.dni_user,
               f.especialidad,
               f.motivo,
               f.hallazgo,
               f.diagnostico,
               f.tratamiento,
               f.apto,
               f.no_apto,
               u.nombre_user,
               u.apellido_user,
               u.cmp_user,
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
                   ELSE (SELECT nombre_sede
                         FROM sede
                         WHERE cod_sede = n.cod_sede)
                   END AS nombre_sede,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               n.color,
               obtener_name_jasper(p_norden, name_service),
               f.nomenclatura,
               f.usuario_firma,
               f.fecha_registro,
               f.user_registro,
               d.lugar_nac_pa,
               d.nivel_est_pa,
               d.estado_civil_pa,
               CASE WHEN f.especialidad ILIKE 'OFTALMOLOGIA' OR
                         f.especialidad ILIKE 'AGUDEZA VISUAL' THEN TRUE ELSE FALSE END
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal AS sm
                            ON n.cod_sede = sm.id
                 INNER JOIN
             triaje AS t ON n.n_orden = t.n_orden
                 LEFT JOIN
             ficha_interconsulta AS f ON n.n_orden = f.n_orden
                 LEFT JOIN
             usuarios AS u ON f.dni_user = u.dni_user
                 LEFT JOIN
             oftalmologia AS o ON n.n_orden = o.n_orden
                 LEFT JOIN
             oftalmologia_lo AS ol ON n.n_orden = ol.n_orden
                 LEFT JOIN
             oftalmologia2021 AS oft ON n.n_orden = oft.n_orden
        WHERE n.n_orden = p_norden
          AND (f.cod_fichaint IS NULL OR UPPER(f.especialidad) = UPPER(p_especialidad));

END;
$$;

alter function obtener_reporte_ficha_interconsulta(integer, text, text) owner to pierola;


create function obtener_reporte_evaluacion_psicologica_poderosa(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigoevaluacionpsicologicapoderosa integer, fecha date, coeficienteintelectuals boolean, coeficienteintelectualnps boolean, coeficienteintelectualnp boolean, coeficienteintelectualnpi boolean, coeficienteintelectuali boolean, compresions boolean, compresionnps boolean, compresionnp boolean, compresionnpi boolean, compresioni boolean, nivelatencions boolean, nivelatencionnps boolean, nivelatencionnp boolean, nivelatencionnpi boolean, nivelatencioni boolean, memorias boolean, memorianps boolean, memorianp boolean, memorianpi boolean, memoriai boolean, coordinacionvisos boolean, coordinacionvisonps boolean, coordinacionvisonp boolean, coordinacionvisonpi boolean, coordinacionvisoi boolean, orientacionespacials boolean, orientacionespacialnps boolean, orientacionespacialnp boolean, orientacionespacialnpi boolean, orientacionespaciali boolean, capacidaddetalless boolean, capacidaddetallesnps boolean, capacidaddetallesnp boolean, capacidaddetallesnpi boolean, capacidaddetallesi boolean, capacidadaprendizajes boolean, capacidadaprendizajenps boolean, capacidadaprendizajenp boolean, capacidadaprendizajenpi boolean, capacidadaprendizajei boolean, capacidadanalisiss boolean, capacidadanalisisnps boolean, capacidadanalisisnp boolean, capacidadanalisisnpi boolean, capacidadanalisisi boolean, estabilidademocionals boolean, estabilidademocionalnps boolean, estabilidademocionalnp boolean, estabilidademocionalnpi boolean, estabilidademocionali boolean, afrontamientoestress boolean, afrontamientoestresnps boolean, afrontamientoestresnp boolean, afrontamientoestresnpi boolean, afrontamientoestresi boolean, afrontamientoriesgos boolean, afrontamientoriesgonps boolean, afrontamientoriesgonp boolean, afrontamientoriesgonpi boolean, afrontamientoriesgoi boolean, relacionesinterpersonaless boolean, relacionesinterpersonalesnps boolean, relacionesinterpersonalesnp boolean, relacionesinterpersonalesnpi boolean, relacionesinterpersonalesi boolean, disposicionnormass boolean, disposicionnormasnps boolean, disposicionnormasnp boolean, disposicionnormasnpi boolean, disposicionnormasi boolean, fortalezasoportunidades text, amenazasdebilidades text, observaciones text, recomendaciones text, apto boolean, noapto boolean, excelente boolean, aptoobservacion boolean, licencia boolean, trabajoscaliente boolean, nombresede text, sede text, color integer, namejasper text, numero text, usuariofirma text)
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
               ip.cod_ep,
               ip.fecha_ep,
               ip.rbi1,
               ip.rbi2,
               ip.rbi3,
               ip.rbi4,
               ip.rbi5,
               ip.rbi6,
               ip.rbi7,
               ip.rbi8,
               ip.rbi9,
               ip.rbi10,
               ip.rbi11,
               ip.rbi12,
               ip.rbi13,
               ip.rbi14,
               ip.rbi15,
               ip.rbi16,
               ip.rbi17,
               ip.rbi18,
               ip.rbi19,
               ip.rbi20,
               ip.rbi21,
               ip.rbi22,
               ip.rbi23,
               ip.rbi24,
               ip.rbi25,
               ip.rbi26,
               ip.rbi27,
               ip.rbi28,
               ip.rbi29,
               ip.rbi30,
               ip.rbi31,
               ip.rbi32,
               ip.rbi33,
               ip.rbi34,
               ip.rbi35,
               ip.rbi36,
               ip.rbi37,
               ip.rbi38,
               ip.rbi39,
               ip.rbi40,
               ip.rbi41,
               ip.rbi42,
               ip.rbi43,
               ip.rbi44,
               ip.rbi45,
               ip.rbp1,
               ip.rbp2,
               ip.rbp3,
               ip.rbp4,
               ip.rbp5,
               ip.rbp6,
               ip.rbp7,
               ip.rbp8,
               ip.rbp9,
               ip.rbp10,
               ip.rbp11,
               ip.rbp12,
               ip.rbp13,
               ip.rbp14,
               ip.rbp15,
               ip.rbp16,
               ip.rbp17,
               ip.rbp18,
               ip.rbp19,
               ip.rbp20,
               ip.rbp21, --
               ip.rbp22,
               ip.rbp23,
               ip.rbp24,
               ip.rbp25,
               ip.txtfortalezas_o,
               ip.txtamenazas_d,
               ip.txtobservaciones,
               ip.txtrecomendaciones,
               ip.rbapto,
               ip.rbnoapto,
               ip.rbexcelente,
               ip.rbapto_observacion,
               ip.chklicencia,
               ip.chktrabcalientes,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                       THEN 'Huamachuco'
                   ELSE (SELECT nombre_sede
                         FROM sede
                         WHERE cod_sede = n.cod_sede)
                   END                                AS nombre_sede,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               n.color,
               obtener_name_jasper(p_norden, name_service),
               (case
                    when n.cod_sede = 1 then CONCAT(n.n_orden, '-T')
                    when n.cod_sede = 4 then CONCAT(n.n_orden, '-TP')
                    else CONCAT(n.n_orden, '-H') END) as numero,
               ip.usuario_firma
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal AS sm
                            ON n.cod_sede = sm.id
                 INNER JOIN evaluacion_psicologica_poderosa AS ip
                            ON ip.n_orden = n.n_orden
        WHERE n.n_orden = p_norden
          AND
            (
                (
                    name_service = 'evaluacion_psicologica_poderosa_normal'
                        AND chktrabcalientes IS DISTINCT FROM true
                        AND chklicencia IS DISTINCT FROM true
                    )
                    OR
                (
                    name_service = 'evaluacion_psicologica_poderosa_licencia'
                        AND chklicencia = true
                    )
                    OR
                (
                    name_service = 'evaluacion_psicologica_poderosa_caliente'
                        AND chktrabcalientes = true
                    )
                );


END;
$$;

alter function obtener_reporte_evaluacion_psicologica_poderosa(integer, text) owner to pierola;



create function editar_anexo7c(p_norden integer)
    returns TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiopaciente_nivel_est_pa text, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, areaocupacional_area_o text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, detallehijosvivosantecedentes_txtdhijosvivos text, detallehijosfallecidosantecedentes_txtdhijosfallecidos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, visionbinocular_v_binocular text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, vc_vc text, rp_rp text, enfermedadesocularesvisionlejos_e_oculvisionlejos text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, observacionesradiografiatorax_txtobservacionesrt text, observacioneslaboratorioclinico_txtobservacioneslb text, examenradiograficossanguineos_txtobservacionesrs text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, creatininalaboratorioclinico_txtcreatininabio text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, fechaanexo7c_fecha date, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageograficaanexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, reubicacionsianexo7c_tbrsi boolean, reubicacionnoanexo7c_rbrno boolean, tabaconadaaexo7c_chktnada boolean, tabacopocoanexo7c_chktpoco boolean, tabacohabitualanexo7c_chkthabitual boolean, tabacoexcesivoanexo7c_chktexcesivo boolean, alcoholnadaanexo7c_chkanada boolean, alcoholpocoanexo7c_chkapoco boolean, alcoholhabitualanexo7c_chkahabitual boolean, alcoholexcesivoanexo7c_chkaexcesivo boolean, drogasnadaanexo7c_chkdnada boolean, drogaspocoanexo7c_chkdpoco boolean, drogashabitualanexo7c_chkdhabitual boolean, drogasexcesivoanexo7c_chkdexcesivo boolean, puestoactualanexo7c_txtpuestoactual text, tiempoanexo7c_txttiempo text, antecedentespersonalesanexo7c_txtantecedentespersonales text, antecedentespersonales2anexo7c_txtantecedentespersonales2 text, antecedentesfamiliaresanexo7c_txtantecedentesfamiliares text, cabezaanexo7c_txtcabeza text, narizanexo7c_txtnariz text, cuelloanexo7c_txtcuello text, perimetroanexo7c_txtperimetro text, baflanexo7c_txtb_a_f_l text, visioncoloresanexo7c_txtvisioncolores text, enfermedadesocularesanexo7c_txtenfermedadesoculares text, diagnosticoaudioanexo7c_txtdiagnosticoaudio text, enfermedadesoculares2anexo7c_txtenfermedadesoculares2 text, reflejospupilaresanexo7c_txtreflejospupilares text, binocularanexo7c_txtbinocular text, odanexo7c_txtod text, oianexo7c_txtoi text, toraxanexo7c_txttorax text, corazonanexo7c_txtcorazon text, pulmonesnormalanexo7c_rbnormal boolean, pulmonesanormalanexo7c_rbanormal boolean, pulmonesdescripcionanexo7c_txtpulmones text, miembrossuperioresanexo7c_txtmiembrossuperiores text, miembrosinferioresanexo7c_txtmiembrosinferiores text, reflejososteotendinososanexo7c_txtreflejososteotendinosos text, marchaanexo7c_txtmarcha text, columnavertebralanexo7c_txtcolumnavertebral text, abdomenanexo7c_txtabdomen text, anillosinguinalesanexo7c_txtanillosinguinales text, organosgenitalesanexo7c_txtorganosgenitales text, tactorectalnohizoanexo7c_rbtnohizo boolean, tactorectalnormalanexo7c_rbtnormal boolean, tactorectalanormalanexo7c_rbtanormal boolean, describirobservacionanexo7c_chkdescribirobservacion boolean, herniasanexo7c_txthernias text, varicesanexo7c_txtvarices text, gangliosanexo7c_txtganglios text, lenguageanexo7c_txtlenguage text, observacionesfichamedicaanexo7c_txtobservacionesfm text, conclusionanexo7c_txtconclusion text, tetanoanexo7c_tetano boolean, hepatitisbanexo7c_hepatitisb boolean, fiebreamarillaanexo7c_fiebreamarilla boolean, diagnosticoaudio2anexo7c_txtdiagnosticoaudio text, conclusionmedicoanexo7c_txtconclusionmed text, estadomentalanexo7c_txtestadomental text, anamnesisanexo7c_txtanamnesis text, antecedentespatologicos_ante_patologicos text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, campospulmonesradiografiatorax_txtcampospulm text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, norden_n_orden integer, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, codigoanexo7c_cod_anexo integer, pielanexo7c_piel boolean, pieldescripcionanexo7c_piel_descripcion text, usuariofirma text, conclusionmusculoesqueletica text, observacionesconduccioncertificado_conduccion text, conclusionradiografia_conclu text, notaDoctor text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
	SELECT 
	    d.cod_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    d.fecha_nacimiento_pa,
	    d.sexo_pa,
	    d.lugar_nac_pa,
	    d.direccion_pa,
	    d.tel_casa_pa,
	    d.cel_pa,
	    d.estado_civil_pa,
	    d.nivel_est_pa,
	    n.razon_empresa,
	    n.razon_contrata,
	    n.nom_examen,
	    n.nom_ex,
	    n.altura_po,
	    n.mineral_po,
	    n.cargo_de,
	    n.area_o,
	    ap.txtvhijosvivos,
	    ap.txtvhijosfallecidos,
	    ap.txtdhijosvivos,
	    ap.txtdhijosfallecidos,
	    triaje.talla,
	    triaje.peso,
	    triaje.imc,
	    triaje.sistolica,
	    triaje.diastolica,
	    triaje.f_respiratoria,
	    triaje.f_cardiaca,
	    triaje.sat_02,
	    triaje.temperatura,
	    triaje.cintura,
	    triaje.cadera,
	    triaje.icc,
	    triaje.perimetro_cuello,
-- 	    o.v_cerca_s_od,
-- 	    o.v_cerca_s_oi,
-- 	    o.v_cerca_c_od,
-- 	    o.v_cerca_c_oi,
-- 	    o.v_lejos_s_od,
-- 	    o.v_lejos_s_oi,
-- 	    o.v_lejos_c_od,
-- 	    o.v_lejos_c_oi,
-- 	    o.v_binocular,
-- 	    o.e_oculares,
-- 	    o.e_oculares1,
	    CASE WHEN oft.txtcercasincorregirod is not null THEN oft.txtcercasincorregirod else o.v_cerca_s_od end as v_cerca_s_od,
	    CASE WHEN oft.txtcercasincorregiroi is not null THEN oft.txtcercasincorregiroi else o.v_cerca_s_oi end as v_cerca_s_oi,
	    CASE WHEN oft.txtcercacorregidaod is not null THEN oft.txtcercacorregidaod
		 WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od
		 else ol.v_cerca_c_od end as ODCC,
	    CASE WHEN oft.txtcercacorregidaoi is not null THEN oft.txtcercacorregidaoi
		 WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi
		 else ol.v_cerca_c_oi end as OICC,
	    CASE WHEN oft.txtlejossincorregirod is not null THEN oft.txtlejossincorregirod else o.v_lejos_s_od end as v_lejos_s_od,
	    CASE WHEN oft.txtlejossincorregiroi is not null THEN oft.txtlejossincorregiroi else o.v_lejos_s_oi end as v_lejos_s_oi,
	    CASE WHEN oft.txtlejoscorregidaod is not null THEN oft.txtlejoscorregidaod
		 WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  ELSE ol.v_lejos_c_od  END as ODLC,
	    CASE WHEN oft.txtlejoscorregidaoi is not null THEN oft.txtlejoscorregidaoi
		 WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  ELSE ol.v_lejos_c_oi  END as OILC,
	    CASE WHEN oft.txtbinocularsincorregir IS not NULL THEN oft.txtbinocularsincorregir
		 WHEN ol.v_binocular IS NULL THEN o.v_binocular
		 ELSE ol.v_binocular  END as VB,
	    CASE WHEN oft.txtdiagnostico IS not NULL THEN oft.txtdiagnostico  else o.e_oculares end as e_oculares,
	    o.e_oculares1,
	    CASE WHEN ol.v_colores IS NULL THEN o.v_colores  ELSE ol.v_colores  END as VC,
	    CASE WHEN ol.r_pupilares IS NULL THEN o.r_pupilares  ELSE ol.r_pupilares  END as RP,
	    o.e_oculvisionlejos, 
	    odontograma.txtausentes,
	    odontograma.txtobservaciones,
	    odontograma.txtpiezasmalestado,
	    r.txtobservacionesrt,
	    l.txtobservacioneslb,
	    e.txtobservacionesrs,
	    l.txtglucosabio,
	    l.txtvsg,
	    l.txtcocaina,
	    l.txtmarihuana,
	    l.txtcreatininabio,
	    ----------------------------------------------------------------------------

	    CASE WHEN  au.o_d_500 is not null THEN au.o_d_500
		     WHEN  a25.o_d_500 is not null THEN a25.o_d_500 else m.o_d_500 end as o_d_500 ,
		CASE WHEN au.o_d_1000 is not null THEN au.o_d_1000
		     WHEN a25.o_d_1000 is not null THEN a25.o_d_1000 else m.o_d_1000 end as o_d_1000 ,
		CASE WHEN au.o_d_2000 is not null THEN au.o_d_2000
		     WHEN  a25.o_d_2000 is not null THEN a25.o_d_2000 else m.o_d_2000 end as o_d_2000 ,
		CASE WHEN au.o_d_3000 is not null THEN au.o_d_3000
		     WHEN  a25.o_d_3000 is not null THEN a25.o_d_3000 else m.o_d_3000 end as o_d_3000 ,
		CASE WHEN au.o_d_4000 is not null THEN au.o_d_4000
		     WHEN  a25.o_d_4000 is not null THEN a25.o_d_4000 else m.o_d_4000 end as o_d_4000 ,
		CASE WHEN au.o_d_6000 is not null THEN au.o_d_6000
		     WHEN  a25.o_d_6000 is not null THEN a25.o_d_6000 else m.o_d_6000 end as o_d_6000 ,
		CASE WHEN au.o_d_8000 is not null THEN au.o_d_8000
		     WHEN  a25.o_d_8000 is not null THEN a25.o_d_8000 else m.o_d_8000 end as o_d_8000 ,
		CASE WHEN au.o_i_500 is not null THEN au.o_i_500
		     WHEN a25.o_i_500 is not null THEN a25.o_i_500 else m.o_i_500 end as o_i_500 ,
		CASE WHEN au.o_i_1000 is not null THEN au.o_i_1000
		     WHEN a25.o_i_1000 is not null THEN a25.o_i_1000 else m.o_i_1000 end as o_i_1000 ,
		CASE WHEN au.o_i_2000 is not null THEN au.o_i_2000
		     WHEN a25.o_i_2000 is not null THEN a25.o_i_2000 else m.o_i_2000 end as o_i_2000 ,
		CASE WHEN au.o_i_3000 is not null THEN au.o_i_3000
		     WHEN a25.o_i_3000 is not null THEN a25.o_i_3000 else m.o_i_3000 end as o_i_3000 ,
		CASE WHEN au.o_i_4000 is not null THEN au.o_i_4000
		     WHEN a25.o_i_4000 is not null THEN a25.o_i_4000 else m.o_i_4000 end as o_i_4000 ,
		CASE WHEN au.o_i_6000 is not null THEN au.o_i_6000
		     WHEN a25.o_i_6000 is not null THEN a25.o_i_6000 else m.o_i_6000 end as o_i_6000 ,
		CASE WHEN au.o_i_8000 is not null THEN au.o_i_8000
		     WHEN a25.o_i_8000 is not null THEN a25.o_i_8000 else m.o_i_8000 end as o_i_8000 ,
		CASE WHEN m.diagnostico is null THEN '' else m.diagnostico end as diagnostico,


	    ----------------------------------------

	    au.chkdnormal,
	    au.chkdtaleveod,
	    au.chkdtaleveoi,
	    au.chkdtaavanzadood,
	    au.chkdtaavanzadooi,
	    au.chkdhrleveod,
	    au.chkdhrleveoi,
	    au.chkdhrmoderadood,
	    au.chkdhrmoderadooi,
	    au.chkdhravanzadaod,
	    au.chkdhravanzadaoi,
	    au.chkotrashipoacusias,
	    au.txtotrashipoacusias,

	    funcion_abs.fvc,
	    funcion_abs.fev1,
	    funcion_abs.fev1fvc,
	    funcion_abs.fef25_75,
	    funcion_abs.interpretacion,

	    a.fecha,
	    a.chkruido,
	a.chkpolvo,
	a.chkvidsegmentario,
	a.chkvidtotal,
	a.chkcancerigenos,
	a.chkmutagenicos,
	a.chksolventes,
	a.chkmetales,
	a.chktemperatura,
	a.chkbiologicos,
	a.chkposturas,
	a.chkturnos,
	a.chkcargas,
	a.chkmovrepet,
	a.chkpvd,
	a.electricos,
	a.vibraciones,
	a.chkotros,
	a.altura_estructura,
	a.altura_geog,
	a.quimicos,

	    -- CASE WHEN ap.ruido IS NULL THEN a.chkruido ELSE ap.ruido END,
-- 	    CASE WHEN ap.polvo IS NULL THEN a.chkpolvo ELSE ap.polvo END,
-- 	    CASE WHEN ap.vid_segmentario IS NULL THEN a.chkvidsegmentario ELSE ap.vid_segmentario END,
-- 	    CASE WHEN ap.vid_total IS NULL THEN a.chkvidtotal ELSE ap.vid_total END,
-- 	    CASE WHEN ap.cancerigenos IS NULL THEN a.chkcancerigenos ELSE ap.cancerigenos END,
-- 	    CASE WHEN ap.mutagenicos IS NULL THEN a.chkmutagenicos ELSE ap.mutagenicos END,
-- 	    CASE WHEN ap.solventes IS NULL THEN a.chksolventes ELSE ap.solventes END,
-- 	    CASE WHEN ap.metales IS NULL THEN a.chkmetales ELSE ap.metales END,
-- 	    CASE WHEN ap.temperatura IS NULL THEN a.chktemperatura ELSE ap.temperatura END,
-- 	    CASE WHEN ap.biologicos IS NULL THEN a.chkbiologicos ELSE ap.biologicos END,
-- 	    CASE WHEN ap.posturas IS NULL THEN a.chkposturas ELSE ap.posturas END,
-- 	    CASE WHEN ap.turnos IS NULL THEN a.chkturnos ELSE ap.turnos END,
-- 	    CASE WHEN ap.cargas IS NULL THEN a.chkcargas ELSE ap.cargas END,
-- 	    CASE WHEN ap.mov_repet IS NULL THEN a.chkmovrepet ELSE ap.mov_repet END,
-- 	    CASE WHEN ap.pvd IS NULL THEN a.chkpvd ELSE ap.pvd END,
-- 	    CASE WHEN ap.electricos IS NULL THEN a.electricos ELSE ap.electricos END,
-- 	    CASE WHEN ap.vibraciones IS NULL THEN a.vibraciones ELSE ap.vibraciones END,
-- 	    CASE WHEN ap.otros IS NULL THEN a.chkotros ELSE ap.otros END,
-- 	    CASE WHEN ap.altura_estructura IS NULL THEN a.altura_estructura ELSE ap.altura_estructura END,
-- 	    CASE WHEN ap.altura_geografica IS NULL THEN a.altura_geog ELSE ap.altura_geografica END,
-- 	    CASE WHEN ap.quimicos IS NULL THEN a.quimicos ELSE ap.quimicos END,
	    a.tbrsi,
	    a.rbrno,
	    a.chktnada,
	    a.chktpoco,
	    a.chkthabitual,
	    a.chktexcesivo,
	    a.chkanada,
	    a.chkapoco,
	    a.chkahabitual,
	    a.chkaexcesivo,
	    a.chkdnada,
	    a.chkdpoco,
	    a.chkdhabitual,
	    a.chkdexcesivo,
	    a.txtpuestoactual,
	    a.txttiempo,
	    a.txtantecedentespersonales,
	    a.txtantecedentespersonales2,
	    a.txtantecedentesfamiliares,
	    a.txtcabeza,
	    a.txtnariz,
	    a.txtcuello,
	    a.txtperimetro,
	    a.txtb_a_f_l,
	    a.txtvisioncolores,
	    a.txtenfermedadesoculares,
	    a.txtdiagnosticoaudio,
	    a.txtenfermedadesoculares2,
	    a.txtreflejospupilares,
	    a.txtbinocular,
	    a.txtod,
	    a.txtoi,
	    a.txttorax,
	    a.txtcorazon,
	    a.rbnormal,
	    a.rbanormal,
	    a.txtpulmones,
	    a.txtmiembrossuperiores,
	    a.txtmiembrosinferiores,
	    a.txtreflejososteotendinosos,
	    a.txtmarcha,
	    a.txtcolumnavertebral,
	    a.txtabdomen,
	    a.txtanillosinguinales,
	    a.txtorganosgenitales,
	    a.rbtnohizo,
	    a.rbtnormal,
	    a.rbtanormal,
	    a.chkdescribirobservacion,
	    a.txthernias,
	    a.txtvarices,
	    a.txtganglios,
	    a.txtlenguage,
	    a.txtobservacionesfm,
	    a.txtconclusion,
	    a.tetano,
	    a.hepatitisb,
	    fiebreamarilla,
	    txtdiagnosticoaudio,
	    txtconclusionmed,
	    a.txtestadomental,
	    a.txtanamnesis,
	    CASE 
		WHEN (
		    CASE WHEN ap.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN ap.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN ap.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN ap.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN ap.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN ap.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN ap.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN ap.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN ap.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN ap.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN ap.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN ap.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN ap.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN ap.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN ap.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN ap.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN ap.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN ap.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN ap.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN ap.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN ap.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN ap.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN ap.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN ap.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN ap.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN ap.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN ap.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN ap.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN ap.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN ap.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN ap.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN ap.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN ap.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN ap.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN ap.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN ap.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN ap.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN ap.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN ap.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN ap.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN ap.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN ap.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN ap.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN ap.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN ap.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN ap.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN ap.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN ap.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN ap.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN ap.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN ap.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN ap.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN ap.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN ap.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN ap.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN ap.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN ap.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN ap.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN ap.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN ap.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN ap.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN ap.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN ap.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN ap.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN ap.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN ap.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN ap.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN ap.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN ap.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN ap.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		) = '' 
		THEN 'NINGUNO'
		ELSE (
		    CASE WHEN ap.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN ap.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN ap.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN ap.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN ap.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN ap.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN ap.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN ap.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN ap.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN ap.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN ap.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN ap.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN ap.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN ap.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN ap.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN ap.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN ap.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN ap.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN ap.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN ap.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN ap.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN ap.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN ap.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN ap.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN ap.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN ap.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN ap.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN ap.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN ap.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN ap.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN ap.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN ap.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN ap.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN ap.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN ap.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN ap.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN ap.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN ap.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN ap.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN ap.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN ap.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN ap.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN ap.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN ap.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN ap.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN ap.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN ap.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN ap.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN ap.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN ap.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN ap.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN ap.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN ap.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN ap.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN ap.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN ap.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN ap.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN ap.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN ap.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN ap.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN ap.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN ap.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN ap.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN ap.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN ap.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN ap.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN ap.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN ap.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN ap.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN ap.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		)    
	    END AS ante_patologicos,
	    ----
	    l.chkpositivo,
	    l.chknegativo,
	    l.chko, 
	    l.chka, 
	    l.chkb, 
	    l.chkab,
	    l.rbrhpositivo, 
	    l.rbrhnegativo,
	    l.txthemoglobina,
	    -----
	    l.txtcoloref, 
	    l.txtdensidadef, 
	    l.txtaspectoef, 
	    l.txtphef, l.txtnitritoseq, 
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
	    ie.hallazgo, ie.recomendaciones,
	    r.txtvertices,
	    r.txthilios,
	    r.txtsenoscostofrenicos,
	    r.txtmediastinos,
	    r.txtsiluetacardiovascular,
	    r.txtosteomuscular,
	    r.txtconclusionesradiograficas,
	    r.txtcampospulm,
	    ab.txtcolesterol, ab.txtldlcolesterol, ab.txthdlcolesterol, ab.txtvldlcolesterol,
	    ab.txttrigliseridos,
	    n.n_orden,
	    e.cod_exra,
	    e.n_rx,
	    e.fecha_exra,
	    e.txtcalidad,
	    e.txtsimbolos,
	    e.ex_0,
	    e.ex_10,
	    e.ex_11,
	    e.ex_12,
	    e.ex_21,
	    e.ex_22,
	    e.ex_23,
	    e.ex_32,
	    e.ex_33,
	    e.ex_3mas,
	    e.ex_abc,
	    e.ex_st,
	    e.txtsinneumoconiosis,
	    e.txtconneumoconiosis,
	    e.txtirep,
	    e.txtotrosex,
	    e.apto_si,
	    e.apto_no,
	    e.apto_re,
	    a.cod_anexo,
	    a.piel,
	    a.piel_descripcion,
	    a.usuario_firma,
        CASE WHEN eme.n_orden IS NULL THEN eme21.txtconclusiones ELSE eme.txtdiagnostico END,
        bc.b_c_observaciones AS conduccion,
        ra.conclu,
        l.nota
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n ON (d.cod_pa = n.cod_pa)
	INNER JOIN antecedentes_patologicos AS ap ON (n.n_orden = ap.n_orden)
	INNER JOIN triaje ON (n.n_orden = triaje.n_orden)
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	INNER JOIN funcion_abs ON (n.n_orden = funcion_abs.n_orden)
	INNER JOIN radiografia_torax AS r ON (n.n_orden = r.n_orden)
	INNER JOIN lab_clinico AS l ON (n.n_orden = l.n_orden)
	LEFT JOIN ex_radiograficos_sanguineos AS e ON (n.n_orden = e.n_orden)
	INNER JOIN odontograma ON (n.n_orden = odontograma.n_orden)
	LEFT JOIN audiometria_po AS m ON (n.n_orden = m.n_orden)
	INNER JOIN anexo7c AS a ON (n.n_orden = a.n_orden)
	LEFT JOIN audiometria_2021 AS au ON (n.n_orden = au.n_orden)
	LEFT JOIN audiometria_2023 AS a25 ON (n.n_orden = a25.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	LEFT JOIN informe_electrocardiograma AS ie ON (n.n_orden = ie.n_orden)
	LEFT JOIN analisis_bioquimicos AS ab ON (n.n_orden = ab.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (ol.n_orden = n.n_orden)
    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON (n.n_orden = eme.n_orden)
    LEFT JOIN evaluacion_musculo_esqueletica2021 AS eme21 ON (n.n_orden = eme21.n_orden)
    LEFT JOIN radiografia AS ra ON (ra.n_orden = n.n_orden)
    LEFT JOIN b_certificado_conduccion AS bc ON (bc.n_orden = n.n_orden)
	WHERE a.n_orden = p_norden;

END;
$$;

alter function editar_anexo7c(integer) owner to pierola;




create function obtener_anexo7c(p_norden integer)
    returns TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiospaciente_nivel_est_pa text, norden_n_orden integer, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, area_area_o text, grupofactorsanguineo_grupofactorsan text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, dhijosvivosantecedentes_txtdhijosvivos text, dhijosfallecidosantecedentes_txtdhijosfallecidos text, antecedentes_rbfumarsi boolean, antecedentes_rblicorsi boolean, antecedentespatologicos_ante_patologicos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, vc_vc text, visionbinocular_v_binocular text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, visionlejosoftalmo_e_oculvisionlejos text, diagnosticooftalmologia2021_txtdiagnostico text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, observacionesradiografiatorax_txtobservacionesrt text, campospulmonesradiografiatorax_txtcampospulm text, observacioneslaboratorioclinico_txtobservacioneslb text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, creatininalaboratorioclinico_txtcreatininabio text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, grupofactorsanguineolaboratorioclinico_grupofactor text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, ordenalturacertificado_ordenaltura integer, observacionesalturacertificado_alturabarrick text, ordenconduccioncertificado_ordencond integer, observacionesconduccioncertificado_conduccion text, numeroalturacertificacion_numalt integer, observacionesalturacertificacion_certialtura text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, infogeneralradiografia_info_general text, conclusionradiografia_conclu text, anamnesisagroindustrial_txtanamnesis text, estadomentalagroindustrial_txtestadomental text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageoganexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, conclusionmusculoesqueletica text, notaDoctor text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
	SELECT 
	    -- TABLA: datos_paciente (Prefijo: d)
	    d.cod_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    d.fecha_nacimiento_pa,
	    d.sexo_pa,
	    d.lugar_nac_pa,
	    d.direccion_pa,
	    d.tel_casa_pa,
	    d.cel_pa,
	    d.estado_civil_pa,
	    d.nivel_est_pa,
	    
	    -- TABLA: n_orden_ocupacional (Prefijo: n)
	    n.n_orden,
	    n.razon_empresa,
	    n.razon_contrata,
	    n.nom_examen,
	    n.nom_ex,
	    n.altura_po,
	    n.mineral_po,
	    n.cargo_de,
	    n.area_o,
	    n.grupofactorsan,
	    
	    -- TABLA: antecedentes_patologicos (Prefijo: a)
	    a.txtvhijosvivos,
	    a.txtvhijosfallecidos,
	    a.txtdhijosvivos,
	    a.txtdhijosfallecidos,
	    a.rbfumarsi,
	    a.rblicorsi,
	    CASE 
		WHEN (
		    CASE WHEN a.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN a.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN a.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN a.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN a.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN a.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN a.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN a.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN a.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN a.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN a.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN a.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN a.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN a.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN a.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN a.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN a.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN a.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN a.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN a.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN a.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN a.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN a.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN a.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN a.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN a.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN a.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN a.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN a.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN a.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN a.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN a.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN a.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN a.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN a.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN a.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN a.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN a.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN a.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN a.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN a.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN a.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN a.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN a.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN a.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN a.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN a.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN a.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN a.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN a.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN a.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN a.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN a.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN a.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN a.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN a.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN a.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN a.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN a.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN a.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN a.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN a.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN a.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN a.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN a.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN a.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN a.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN a.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN a.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN a.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN a.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN a.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN a.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN a.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN a.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN a.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN a.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN a.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN a.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		) = '' 
		THEN 'NINGUNO'
		ELSE (
		    CASE WHEN a.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN a.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN a.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN a.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN a.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN a.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN a.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN a.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN a.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN a.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN a.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN a.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN a.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN a.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN a.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN a.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN a.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN a.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN a.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN a.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN a.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN a.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN a.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN a.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN a.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN a.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN a.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN a.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN a.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN a.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN a.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN a.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN a.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN a.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN a.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN a.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN a.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN a.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN a.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN a.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN a.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN a.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN a.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN a.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN a.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN a.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN a.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN a.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN a.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN a.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN a.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN a.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN a.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN a.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN a.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN a.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN a.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN a.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN a.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN a.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN a.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN a.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN a.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN a.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN a.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN a.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN a.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN a.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN a.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN a.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN a.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN a.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN a.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN a.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN a.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN a.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN a.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN a.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN a.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		)    
	    END AS ante_patologicos,
	    
	    -- TABLA: triaje (Prefijo: t)
	    t.talla,
	    t.peso,
	    t.imc,
	    t.sistolica,
	    t.diastolica,
	    t.f_respiratoria,
	    t.f_cardiaca,
	    t.sat_02,
	    t.temperatura,
	    t.cintura,
	    t.cadera,
	    t.icc,
	    t.perimetro_cuello,
	    
	    -- TABLA: oftalmologia (Prefijo: o)
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
	    o.e_oculares1,
	    o.e_oculvisionlejos,
	    
	    -- TABLA: oftalmologia2021 (Prefijo: oft)
	    oft.txtdiagnostico,
	    
	    -- TABLA: odontograma (Prefijo: od)
	    od.txtausentes,
	    od.txtobservaciones,
	    od.txtpiezasmalestado,
	    
	    -- TABLA: radiografia_torax (Prefijo: r)
	    r.txtvertices,
	    r.txthilios,
	    r.txtsenoscostofrenicos,
	    r.txtmediastinos,
	    r.txtsiluetacardiovascular,
	    r.txtosteomuscular,
	    r.txtconclusionesradiograficas,
	    r.txtobservacionesrt,
	    r.txtcampospulm,
	    
	    -- TABLA: lab_clinico (Prefijo: l)
	    l.txtobservacioneslb,
	    l.txtcocaina,
	    l.txtmarihuana,
	    l.txtglucosabio,
	    l.txtvsg,
	    l.txtcreatininabio,
	    ----
	    l.chkpositivo,
	    l.chknegativo,
	    l.chko, 
	    l.chka, 
	    l.chkb, 
	    l.chkab,
	    l.rbrhpositivo, 
	    l.rbrhnegativo,
	    l.txthemoglobina,
	    -----
	    l.txtcoloref, 
	    l.txtdensidadef, 
	    l.txtaspectoef, 
	    l.txtphef, l.txtnitritoseq, 
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
	    -- TABLA: lab_clinico - Grupo sanguíneo y factor RH (Prefijo: l)
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
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 500Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_500 IS NOT NULL THEN au.o_d_500
		WHEN a25.o_d_500 IS NOT NULL THEN a25.o_d_500
		ELSE m.o_d_500
	    END AS o_d_500,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 1000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_1000 IS NOT NULL THEN au.o_d_1000
		WHEN a25.o_d_1000 IS NOT NULL THEN a25.o_d_1000
		ELSE m.o_d_1000
	    END AS o_d_1000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 2000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_2000 IS NOT NULL THEN au.o_d_2000
		WHEN a25.o_d_2000 IS NOT NULL THEN a25.o_d_2000
		ELSE m.o_d_2000
	    END AS o_d_2000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 3000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_3000 IS NOT NULL THEN au.o_d_3000
		WHEN a25.o_d_3000 IS NOT NULL THEN a25.o_d_3000
		ELSE m.o_d_3000
	    END AS o_d_3000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 4000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_4000 IS NOT NULL THEN au.o_d_4000
		WHEN a25.o_d_4000 IS NOT NULL THEN a25.o_d_4000
		ELSE m.o_d_4000
	    END AS o_d_4000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 6000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_6000 IS NOT NULL THEN au.o_d_6000
		WHEN a25.o_d_6000 IS NOT NULL THEN a25.o_d_6000
		ELSE m.o_d_6000
	    END AS o_d_6000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 8000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_8000 IS NOT NULL THEN au.o_d_8000
		WHEN a25.o_d_8000 IS NOT NULL THEN a25.o_d_8000
		ELSE m.o_d_8000
	    END AS o_d_8000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 500Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_500 IS NOT NULL THEN au.o_i_500
		WHEN a25.o_i_500 IS NOT NULL THEN a25.o_i_500
		ELSE m.o_i_500
	    END AS o_i_500,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 1000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_1000 IS NOT NULL THEN au.o_i_1000
		WHEN a25.o_i_1000 IS NOT NULL THEN a25.o_i_1000
		ELSE m.o_i_1000
	    END AS o_i_1000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 2000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_2000 IS NOT NULL THEN au.o_i_2000
		WHEN a25.o_i_2000 IS NOT NULL THEN a25.o_i_2000
		ELSE m.o_i_2000
	    END AS o_i_2000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 3000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_3000 IS NOT NULL THEN au.o_i_3000
		WHEN a25.o_i_3000 IS NOT NULL THEN a25.o_i_3000
		ELSE m.o_i_3000
	    END AS o_i_3000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 4000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_4000 IS NOT NULL THEN au.o_i_4000
		WHEN a25.o_i_4000 IS NOT NULL THEN a25.o_i_4000
		ELSE m.o_i_4000
	    END AS o_i_4000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 6000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_6000 IS NOT NULL THEN au.o_i_6000
		WHEN a25.o_i_6000 IS NOT NULL THEN a25.o_i_6000
		ELSE m.o_i_6000
	    END AS o_i_6000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 8000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_8000 IS NOT NULL THEN au.o_i_8000
		WHEN a25.o_i_8000 IS NOT NULL THEN a25.o_i_8000
		ELSE m.o_i_8000
	    END AS o_i_8000,
	    ----
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Diagnóstico audiométrico (Prefijos: au, a25, m)
	    CASE 
		WHEN au.chkdnormal = 'true' THEN 'NORMAL'
		WHEN au.chkdtaleveod = 'true' AND au.chkdtaleveoi = 'true' THEN 'TRAUMA ACÚSTICO BILATERAL LEVE'
		WHEN au.chkdtaleveod = 'true' THEN 'TRAUMA ACÚSTICO LEVE OD'
		WHEN au.chkdtaleveoi = 'true' THEN 'TRAUMA ACÚSTICO LEVE OI'
		WHEN au.chkdtaavanzadood = 'true' AND au.chkdtaavanzadooi = 'true' THEN 'TRAUMA ACÚSTICO BILATERAL AVANZADO'
		WHEN au.chkdtaavanzadood = 'true' THEN 'TRAUMA ACÚSTICO AVANZADO OD'
		WHEN au.chkdtaavanzadooi = 'true' THEN 'TRAUMA ACÚSTICO AVANZADO OI'
		WHEN au.chkdhrleveod = 'true' AND au.chkdhrleveoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, BILATERAL LEVE'
		WHEN au.chkdhrleveod = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, LEVE OD'
		WHEN au.chkdhrleveoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, LEVE OI'
		WHEN au.chkdhrmoderadood = 'true' AND au.chkdhrmoderadooi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, BILATERAL MODERADA'
		WHEN au.chkdhrmoderadood = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, MODERADA OD'
		WHEN au.chkdhrmoderadooi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, MODERADA OI'
		WHEN au.chkdhravanzadaod = 'true' AND au.chkdhravanzadaoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, BILATERAL AVANZADA'
		WHEN au.chkdhravanzadaod = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, AVANZADA OD'
		WHEN au.chkdhravanzadaoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, AVANZADA OI'
		WHEN au.chkotrashipoacusias = 'true' THEN au.txtotrashipoacusias
		WHEN a25.txtdiag_od IS NOT NULL THEN CONCAT(a25.txtdiag_od, ' ', a25.txtdiag_oi)
		ELSE m.diagnostico
	    END AS diagnostico,
	    
	    -- TABLA: funcion_abs (Prefijo: fa)
	    fa.fvc,
	    fa.fev1,
	    fa.fev1fvc,
	    fa.fef25_75,
	    fa.interpretacion,
	    
	    -- TABLA: b_certificado_altura (Prefijo: ba)
	    ba.n_orden AS ordenaltura,
	    ba.b_c_observaciones AS alturabarrick,
	    
	    -- TABLA: b_certificado_conduccion (Prefijo: bc)
	    bc.n_orden AS ordencond,
	    bc.b_c_observaciones AS conduccion,
	    
	    -- TABLA: certificacion_medica_altura (Prefijo: ca)
	    ca.n_orden AS numalt,
	    ca.observaciones AS certialtura,
	    
	    -- TABLA: audiometria_2021 - Campos adicionales de diagnóstico (Prefijo: au)
	    au.chkdnormal,
	    au.chkdtaleveod,
	    au.chkdtaleveoi,
	    au.chkdtaavanzadood,
	    au.chkdtaavanzadooi,
	    au.chkdhrleveod,
	    au.chkdhrleveoi,
	    au.chkdhrmoderadood,
	    au.chkdhrmoderadooi,
	    au.chkdhravanzadaod,
	    au.chkdhravanzadaoi,
	    au.chkotrashipoacusias,
	    au.txtotrashipoacusias,
	    
	    -- TABLA: radiografia (Prefijo: ra)
	    ra.info_general,
	    ra.conclu,
	    
	    -- TABLA: anexo_agroindustrial (Prefijo: ag)
	    ag.txtanamnesis,
	    ag.txtestadomental,

	    -- TABLA: informe_electrocardiograma (Prefijo: ie)
	    ie.hallazgo, ie.recomendaciones,

	    -- TABLA: analisis_bioquimicos (Prefijo: ab)
	    ab.txtcolesterol, ab.txtldlcolesterol, ab.txthdlcolesterol, ab.txtvldlcolesterol,
	    ab.txttrigliseridos,

	    e.cod_exra,
	    e.n_rx,
	    e.fecha_exra,
	    e.txtcalidad,
	    e.txtsimbolos,
	    e.ex_0,
	    e.ex_10,
	    e.ex_11,
	    e.ex_12,
	    e.ex_21,
	    e.ex_22,
	    e.ex_23,
	    e.ex_32,
	    e.ex_33,
	    e.ex_3mas,
	    e.ex_abc,
	    e.ex_st,
	    e.txtsinneumoconiosis,
	    e.txtconneumoconiosis,
	    e.txtirep,
	    e.txtotrosex,
	    e.apto_si,
	    e.apto_no,
	    e.apto_re,
	    
	    a.ruido,
	    a.polvo,
	    a.vid_segmentario,
	    a.vid_total,
	    a.cancerigenos,
	    a.mutagenicos,
	    a.solventes,
	    a.metales,
	    a.temperatura,
	    a.biologicos,
	    a.posturas,
	    a.turnos,
	    a.cargas,
	    a.mov_repet,
	    a.pvd,
	    a.otros,
	    a.altura_estructura,
	    a.altura_geografica,
	    a.quimicos,
	    a.electricos,
	    a.vibraciones,
	    CASE WHEN eme.n_orden IS NULL THEN eme21.txtconclusiones ELSE eme.txtdiagnostico END,
	    l.nota
	FROM datos_paciente AS d
	    INNER JOIN n_orden_ocupacional AS n ON (d.cod_pa = n.cod_pa)
	    INNER JOIN antecedentes_patologicos AS a ON (n.n_orden = a.n_orden)
	    INNER JOIN triaje AS t ON (n.n_orden = t.n_orden)
	    LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	    LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	    INNER JOIN funcion_abs AS fa ON (n.n_orden = fa.n_orden)
	    INNER JOIN radiografia_torax AS r ON (n.n_orden = r.n_orden)
	    INNER JOIN lab_clinico AS l ON (n.n_orden = l.n_orden)
	    INNER JOIN odontograma AS od ON (n.n_orden = od.n_orden)
	    LEFT JOIN audiometria_po AS m ON (n.n_orden = m.n_orden)
	    LEFT JOIN audiometria_2021 AS au ON (n.n_orden = au.n_orden)
	    LEFT JOIN audiometria_2023 AS a25 ON (n.n_orden = a25.n_orden)
	    LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	    LEFT JOIN b_certificado_altura AS ba ON (ba.n_orden = n.n_orden)
	    LEFT JOIN b_certificado_conduccion AS bc ON (bc.n_orden = n.n_orden)
	    LEFT JOIN certificacion_medica_altura AS ca ON (ca.n_orden = n.n_orden)
	    LEFT JOIN radiografia AS ra ON (ra.n_orden = n.n_orden)
	    LEFT JOIN anexo_agroindustrial AS ag ON (n.n_orden = ag.n_orden)
	    LEFT JOIN informe_electrocardiograma AS ie ON (n.n_orden = ie.n_orden)
	    LEFT JOIN analisis_bioquimicos AS ab ON (n.n_orden = ab.n_orden)
	    LEFT JOIN ex_radiograficos_sanguineos AS e ON (n.n_orden = e.n_orden)
	    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON (n.n_orden = eme.n_orden)
	    LEFT JOIN evaluacion_musculo_esqueletica2021 AS eme21 ON (n.n_orden = eme21.n_orden)
	WHERE n.n_orden = p_norden;

END;
$$;

alter function obtener_anexo7c(integer) owner to pierola;





alter table lab_clinico add column nota text;

create function obtener_datos_lab_clinico_reporte(n_orden_param integer)
    returns TABLE(nombres text, empresa text, contrata text, cod_labclinico integer, tipo_servicio text, n_orden integer, fecha_lab date, chko boolean, chka boolean, chkb boolean, chkab boolean, rbrhpositivo boolean, rbrhnegativo boolean, txthemoglobina text, txthematocrito text, txtvsg text, txtleucocitosematologia text, txthematiesematologia text, txtneutrofilos text, txtabastonados text, txtsegmentadosematologia text, txtmonocitosematologia text, txteosinofiosematologia text, txtbasofilosematologia text, txtlinfocitosematologia text, txtglucosabio text, txtcreatininabio text, chkpositivo boolean, chknegativo boolean, txtvih text, txtcoloref text, txtdensidadef text, txtaspectoef text, txtphef text, txtnitritoseq text, txtproteinaseq text, txtcetonaseq text, txtleucocitoseq text, txturobilinogenoeq text, txtbilirubinaeq text, txtglucosaeq text, txtsangreeq text, txtleucocitossu text, txtcelepitelialessu text, txtcilindiossu text, txtbacteriassu text, txthematiessu text, txtcristalessu text, txtpussu text, txtotrossu text, txtcocaina text, txtmarihuana text, txtobservacioneslb text, res_lab text, txtplaquetas text, txtac_ascorbico text, user_registro text, color integer, sede text, direccion_sede4 text, email_sede4 text, telefono_sede4 text, celular_sede4 text, direccion_sede3 text, email_sede3 text, telefono_sede3 text, direccion_sede2 text, email_sede2 text, telefono_sede2 text, celular_sede2 text, direccion_sede1 text, email_sede1 text, telefono_sede1 text, usuario_firma text, dni_paciente integer, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, nombreexamen text, codigoclinica text, edadpaciente text, doctorasignado text, nota text)
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
               lbl.doctor_asignado,
               lbl.nota
        FROM lab_clinico lbl
                 INNER JOIN n_orden_ocupacional n ON n.n_orden = lbl.n_orden
                 INNER JOIN datos_paciente dp ON dp.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
        WHERE n.n_orden = n_orden_param;
END;
$$;

alter function obtener_datos_lab_clinico_reporte(integer) owner to pierola;



create function obtener_reporte_audiometriam(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, num_ticket integer, fecha_au date, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, diagnostico text, fecha_examen date, tiempo_trabajo integer, tiempo_exposicion_total_ponderado text, edad_fa text, chk_tapones boolean, chkgrajeras boolean, chkintenso boolean, chkmoderado boolean, chknomolesto boolean, txtmarca text, txtmodelo text, fechacalibracion date, chk1_si boolean, chk2_si boolean, chk3_si boolean, chk4_si boolean, chk5_si boolean, chk6_si boolean, chk7_si boolean, chk8_si boolean, chk9_si boolean, chk10_si boolean, chk11_si boolean, chk12_si boolean, chk1_no boolean, chk2_no boolean, chk3_no boolean, chk4_no boolean, chk5_no boolean, chk6_no boolean, chk7_no boolean, chk8_no boolean, chk9_no boolean, chk10_no boolean, chk11_no boolean, chk12_no boolean, txtdod250 text, txtdod500 text, txtdod1000 text, txtdoi250 text, txtdoi500 text, txtdoi1000 text, txtldumbraldiscriminacion text, txtliumbraldiscriminacion text, txtldporcentagediscriminacion text, txtliporcentagediscriminacion text, txtldconfort text, txtliconfort text, txtlddisconfort text, txtlidisconfort text, txtresponsable text, txtconclusiones text, txtmedico text, txtotoscopia text, txtmesestrabajo integer, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, empresa text, contrata text, nom_examen text, sexo_pa "char", ocupacion text, otros text, usuariofirma text, doctorasignado text, doctorextra text, fecha_nacimiento_pa date, area text)
    language plpgsql
as
$$
DECLARE
empresa_var text;
BEGIN

SELECT trim(razon_empresa) INTO empresa_var FROM n_orden_ocupacional n WHERE n.n_orden = p_norden;

RETURN QUERY
SELECT
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    fa.n_orden,
    noo.cod_pa,

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
    CASE
        WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN (select nombre_user || ' ' || apellido_user from usuarios where usuario_user = 'SGUTIERREZ')
        ELSE CASE WHEN fa.usuario_firma IS NULL THEN fa.txtresponsable
                  ELSE (select nombre_user || ' ' || apellido_user from usuarios where usuario_user = fa.usuario_firma) END
        END as txt_responsable,
    fa.txtconclusiones,
    CASE WHEN fa.txtmedico IS NULL THEN (select nombre_user || ' ' || apellido_user from usuarios where usuario_user = fa.doctor_asignado)
         ELSE fa.txtmedico END as doctor_asignado,
    fa.txtotoscopia,
    fa.txtmesestrabajo,


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
    noo.razon_empresa,
    noo.razon_contrata,
    noo.nom_examen,
    --dp.lugar_nac_pa,
    --dp.cel_pa,
    dp.sexo_pa,
    noo.cargo_de,
    fa.otros,
    fa.usuario_firma,
    fa.doctor_asignado,
    fa.doctor_extra,
    dp.fecha_nacimiento_pa,
    noo.area_o

FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
         INNER JOIN audiometria_po apo ON apo.n_orden = fa.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_audiometriam(integer) owner to pierola;


alter table audiometria_2023 add column doctor_asignado text;

create function obtener_reporte_audiometria(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, cod_au integer, fecha_au date, rbsasordera_si boolean, rbsasordera_no boolean, rbsaacufenos_si boolean, rbsaacufenos_no boolean, rbsavertigo_si boolean, rbsavertigo_no boolean, rbsaotalgia_si boolean, rbsaotalgia_no boolean, rbsasecrecion_si boolean, rbsasecrecion_no boolean, txtsaotrossintomas text, rbamrenitis_si boolean, rbamrenitis_no boolean, rbamsinusitis_si boolean, rbamsinusitis_no boolean, rbamotitis_si boolean, rbamotitis_no boolean, rbamototoxicos_si boolean, rbamototoxicos_no boolean, rbammeningitis_si boolean, rbammeningitis_no boolean, rbamtec_si boolean, rbamtec_no boolean, rbamsordera_si boolean, rbamsordera_no boolean, rbamparotiditis_si boolean, rbamparotiditis_no boolean, rbamsarampion_si boolean, rbamsarampion_no boolean, rbamtbc_si boolean, rbamtbc_no boolean, txtamcuales text, rbeoexposicion_si boolean, rbeoexposicion_no boolean, rbeoprotectores_si boolean, rbeoprotectores_no boolean, rbeosustancias_si boolean, rbeosustancias_no boolean, rbte0a2 boolean, rbte2a4 boolean, rbte4a6 boolean, rbte6a8 boolean, rbte8a10 boolean, rbte10a12 boolean, rbtem12 boolean, rbteeventual boolean, chktapones boolean, chkorejeras boolean, txthplomo text, txthmercurio text, txthtolueno text, txthxileno text, txthplaguic text, txthorganofos text, txttplomo text, txttmercurio text, txtttolueno text, txttxileno text, txttplaguic text, txttorganofos text, txteootros text, rbaepratica_si boolean, rbaepratica_no boolean, rbaeuso_si boolean, rbaeuso_no boolean, rbaeotros_si boolean, rbaeotros_no boolean, txtaecuales text, txtood text, txtooi text, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, txtdiag_od text, txtdiag_oi text, txtcomentarios text, chkrpasimple boolean, chkrpadoble boolean, chkcasemestral boolean, chkcaanual boolean, txtotrasrecomendaciones text, txtanios text, txtmeses text, formato character varying, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, fecha_nacimiento_pa date, sexo "char", areatrabajo text, ocupacion text, nom_examen text, usuario_firma text, apellidospaciente text, fechanacimientopaciente date, direccionpaciente text, lugarnacimientopaciente text, nivelestudiospaciente text, estadocivilpaciente text, codigoclinica text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.apellidos_pa || ' ' || dp.nombres_pa,
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
       aud.usuario_firma,
       dp.apellidos_pa,
       dp.fecha_nacimiento_pa,
       dp.direccion_pa AS direccionpaciente,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cod_clinica,
       aud.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN audiometria_2023 aud ON aud.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_audiometria(integer) owner to pierola;

