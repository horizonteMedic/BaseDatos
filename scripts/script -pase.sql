SELECT n_orden
FROM n_orden_ocupacional
LIMIT 1;

DROP FUNCTION obtener_reporte_anexo16(integer, text);



create function obtener_reporte_cuestionario_nordico(p_norden integer, name_service text)
    returns TABLE
            (
                nombres                                 text,
                dni                                     integer,
                sexo                                    "char",
                edad                                    text,
                codigo_cuestionario                     integer,
                norden                                  integer,
                horas_trabajadas                        text,
                meses                                   text,
                anios                                   text,
                es_diestro                              boolean,
                es_zurdo                                boolean,
                cuello_no                               boolean,
                cuello_si                               boolean,
                pregunta1_cuello_no                     boolean,
                pregunta1_cuello_si                     boolean,
                pregunta2_cuello_no                     boolean,
                pregunta2_cuello_si                     boolean,
                hombros_no                              boolean,
                hombro_derecho_si                       boolean,
                hombro_izquierdo_si                     boolean,
                ambos_hombros_si                        boolean,
                pregunta1_hombros_no                    boolean,
                pregunta1_hombros_si                    boolean,
                pregunta2_hombros_no                    boolean,
                pregunta2_hombros_si                    boolean,
                codos_no                                boolean,
                codo_derecho_si                         boolean,
                codo_izquierdo_no                       boolean,
                ambos_codos_si                          boolean,
                pregunta1_codos_no                      boolean,
                pregunta1_codos_si                      boolean,
                pregunta2_codos_no                      boolean,
                pregunta2_codos_si                      boolean,
                muneca_no                               boolean,
                muneca_derecha_si                       boolean,
                muneca_izquierda_si                     boolean,
                ambas_munecas_si                        boolean,
                pregunta1_munecas_no                    boolean,
                pregunta1_munecas_si                    boolean,
                pregunta2_munecas_no                    boolean,
                pregunta2_munecas_si                    boolean,
                espalda_alta_torax_no                   boolean,
                espalda_baja_lumbar_no                  boolean,
                caderas_o_muslos_no                     boolean,
                rodillas_no                             boolean,
                tobillos_o_pies_no                      boolean,
                pregunta1_espalda_alta_torax_no         boolean,
                pregunta1_espalda_baja_lumbar_no        boolean,
                pregunta1_caderas_o_muslos_no           boolean,
                pregunta1_rodillas_no                   boolean,
                pregunta1_tobillos_o_pies_no            boolean,
                pregunta2_espalda_alta_torax_no         boolean,
                pregunta2_espalda_baja_lumbar_no        boolean,
                pregunta2_caderas_o_muslos_no           boolean,
                pregunta2_rodillas_no                   boolean,
                pregunta2_tobillos_o_pies_no            boolean,
                espalda_alta_torax_si                   boolean,
                espalda_baja_lumbar_si                  boolean,
                caderas_o_muslos_si                     boolean,
                rodillas_si                             boolean,
                tobillos_o_pies_si                      boolean,
                pregunta1_espalda_alta_torax_si         boolean,
                pregunta1_espalda_baja_lumbar_si        boolean,
                pregunta1_caderas_o_muslos_si           boolean,
                pregunta1_rodillas_si                   boolean,
                pregunta1_tobillos_o_pies_si            boolean,
                pregunta2_espalda_alta_torax_si         boolean,
                pregunta2_espalda_baja_lumbar_si        boolean,
                pregunta2_caderas_o_muslos_si           boolean,
                pregunta2_rodillas_si                   boolean,
                pregunta2_tobillos_o_pies_si            boolean,
                pregunta1_espalda_baja_no               boolean,
                pregunta2_espalda_baja_no               boolean,
                pregunta3_espalda_baja_no               boolean,
                pregunta5a_espalda_baja_no              boolean,
                pregunta5b_espalda_baja_no              boolean,
                pregunta7_espalda_baja_no               boolean,
                pregunta8_espalda_baja_no               boolean,
                pregunta1_espalda_baja_si               boolean,
                pregunta2_espalda_baja_si               boolean,
                pregunta3_espalda_baja_si               boolean,
                pregunta5a_espalda_baja_si              boolean,
                pregunta5b_espalda_baja_si              boolean,
                pregunta7_espalda_baja_si               boolean,
                pregunta8_espalda_baja_si               boolean,
                pregunta4a_espalda_baja                 boolean,
                pregunta4b_espalda_baja                 boolean,
                pregunta4c_espalda_baja                 boolean,
                pregunta4d_espalda_baja                 boolean,
                pregunta4e_espalda_baja                 boolean,
                pregunta6a_espalda_baja                 boolean,
                pregunta6b_espalda_baja                 boolean,
                pregunta6c_espalda_baja                 boolean,
                pregunta6d_espalda_baja                 boolean,
                pregunta1_problemas_hombros_no          boolean,
                pregunta3_problemas_hombros_no          boolean,
                pregunta6a_problemas_hombros_no         boolean,
                pregunta6b_problemas_hombros_no         boolean,
                pregunta8_problemas_hombros_no          boolean,
                pregunta1_problemas_hombros_si          boolean,
                pregunta3_problemas_hombros_si          boolean,
                pregunta6a_problemas_hombros_si         boolean,
                pregunta6b_problemas_hombros_si         boolean,
                pregunta8_problemas_hombros_si          boolean,
                pregunta2_problemas_hombros_no          boolean,
                pregunta2_problemas_hombro_derecho_si   boolean,
                pregunta2_problemas_hombro_izquierdo_si boolean,
                pregunta2_problemas_ambos_hombros       boolean,
                pregunta4_problemas_hombros_no          boolean,
                pregunta4_problemas_hombro_derecho_si   boolean,
                pregunta4_problemas_hombro_izquierdo_si boolean,
                pregunta4_problemas_ambos_hombros       boolean,
                pregunta5a_problemas_hombros            boolean,
                pregunta5b_problemas_hombros            boolean,
                pregunta5c_problemas_hombros            boolean,
                pregunta5d_problemas_hombros            boolean,
                pregunta7a_problemas_hombros            boolean,
                pregunta7b_problemas_hombros            boolean,
                pregunta7c_problemas_hombros            boolean,
                pregunta7d_problemas_hombros            boolean,
                pregunta9_problemas_hombros_no          boolean,
                pregunta9_problemas_hombro_derecho_si   boolean,
                pregunta9_problemas_hombro_izquierdo_si boolean,
                pregunta9_problemas_ambos_hombros       boolean,
                pregunta1_problemas_cuello_no           boolean,
                pregunta2_problemas_cuello_no           boolean,
                pregunta3_problemas_cuello_no           boolean,
                pregunta5a_problemas_cuello_no          boolean,
                pregunta5b_problemas_cuello_no          boolean,
                pregunta7_problemas_cuello_no           boolean,
                pregunta8_problemas_cuello_no           boolean,
                pregunta1_problemas_cuello_si           boolean,
                pregunta2_problemas_cuello_si           boolean,
                pregunta3_problemas_cuello_si           boolean,
                pregunta5a_problemas_cuello_si          boolean,
                pregunta5b_problemas_cuello_si          boolean,
                pregunta7_problemas_cuello_si           boolean,
                pregunta8_problemas_cuello_si           boolean,
                pregunta4a_problemas_cuello             boolean,
                pregunta4b_problemas_cuello             boolean,
                pregunta4c_problemas_cuello             boolean,
                pregunta4d_problemas_cuello             boolean,
                pregunta4e_problemas_cuello             boolean,
                pregunta6a_problemas_cuello             boolean,
                pregunta6b_problemas_cuello             boolean,
                pregunta6c_problemas_cuello             boolean,
                pregunta6d_problemas_cuello             boolean,
                fecha_cuestionario                      date,
                color                                   integer,
                sede_descripcion                        text,
                nombre_jasper                           text,
                usuario_firma                           text,
                apellidos_paciente                      text,
                direccion_paciente                      text,
                fecha_nacimiento_paciente               date,
                ocupacion_paciente                      text,
                lugar_nacimiento_paciente               text,
                nivel_estudio_paciente                  text,
                estado_civil_paciente                   text,
                cargo                                   text,
                area                                    text,
                contrata                                text,
                empresa                                 text,
                codigo_clinica                          text,
                nombre_examen                           text,
                descripcion_digitalizacion              text,
                name_digitalizacion                     text,
                dni_digitalizacion                      integer
            )
    language plpgsql
as
$$
BEGIN

    -- Tabla temporal para los parametros digitalizados
    CREATE TEMP TABLE temp_digitalizados_cuestionario_nordico AS
    SELECT p_norden AS n_orden, *
    FROM obtener_parametros_digitalizados(p_norden, name_service);

    RETURN QUERY
        SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
               noo.cod_pa,
               dp.sexo_pa,
               CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
               cn.cod_cuestionario,
               cn.n_orden,
               cn.txthorastrabaja,
               cn.txttmeses,
               cn.txttanos,
               cn.chkdiestro,
               cn.chkzurdo,
               cn.chkcuellono,
               cn.chkcuellosi,
               cn.chkcno1,
               cn.chkcsi1,
               cn.chkcno2,
               cn.chkcsi2,
               cn.rbh1,
               cn.rbh2,
               cn.rbh3,
               cn.rbh4,
               cn.chkhno1,
               cn.chkhsi1,
               cn.chkhno2,
               cn.chkhsi2,
               cn.rbc1,
               cn.rbc2,
               cn.rbc3,
               cn.rbc4,
               cn.chkcono1,
               cn.chkcosi1,
               cn.chkcono2,
               cn.chkcosi2,
               cn.rbm1,
               cn.rbm2,
               cn.rbm3,
               cn.rbm4,
               cn.chkmno1,
               cn.chkmsi1,
               cn.chkmno2,
               cn.chkmsi2,
               cn.chkno1,
               cn.chkno2,
               cn.chkno3,
               cn.chkno4,
               cn.chkno5,
               cn.chkno6,
               cn.chkno7,
               cn.chkno8,
               cn.chkno9,
               cn.chkno10,
               cn.chkno11,
               cn.chkno12,
               cn.chkno13,
               cn.chkno14,
               cn.chkno15,
               cn.chksi1,
               cn.chksi2,
               cn.chksi3,
               cn.chksi4,
               cn.chksi5,
               cn.chksi6,
               cn.chksi7,
               cn.chksi8,
               cn.chksi9,
               cn.chksi10,
               cn.chksi11,
               cn.chksi12,
               cn.chksi13,
               cn.chksi14,
               cn.chksi15,
               cn.chkeno1,
               cn.chkeno2,
               cn.chkeno3,
               cn.chkeno4,
               cn.chkeno5,
               cn.chkeno6,
               cn.chkeno7,
               cn.chkesi1,
               cn.chkesi2,
               cn.chkesi3,
               cn.chkesi4,
               cn.chkesi5,
               cn.chkesi6,
               cn.chkesi7,
               cn.rbe1,
               cn.rbe2,
               cn.rbe3,
               cn.rbe4,
               cn.rbe5,
               cn.rbe6,
               cn.rbe7,
               cn.rbe8,
               cn.rbe9,
               cn.chkphno1,
               cn.chkphno2,
               cn.chkphno3,
               cn.chkphno4,
               cn.chkphno5,
               cn.chkphsi1,
               cn.chkphsi2,
               cn.chkphsi3,
               cn.chkphsi4,
               cn.chkphsi5,
               cn.chkph1,
               cn.chkph2,
               cn.chkph3,
               cn.chkph4,
               cn.chkph5,
               cn.chkph6,
               cn.chkph7,
               cn.chkph8,
               cn.chkph9,
               cn.chkph10,
               cn.chkph11,
               cn.chkph12,
               cn.chkph13,
               cn.chkph14,
               cn.chkph15,
               cn.chkph16,
               cn.chkph17,
               cn.chkph18,
               cn.chkph19,
               cn.chkph20,
               cn.chkpcno1,
               cn.chkpcno2,
               cn.chkpcno3,
               cn.chkpcno4,
               cn.chkpcno5,
               cn.chkpcno6,
               cn.chkpcno7,
               cn.chkpcsi1,
               cn.chkpcsi2,
               cn.chkpcsi3,
               cn.chkpcsi4,
               cn.chkpcsi5,
               cn.chkpcsi6,
               cn.chkpcsi7,
               cn.chkpc1,
               cn.chkpc2,
               cn.chkpc3,
               cn.chkpc4,
               cn.chkpc5,
               cn.chkpc6,
               cn.chkpc7,
               cn.chkpc8,
               cn.chkpc9,
               cn.fecha_cuestionario,
               noo.color,
               CASE
                   WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               obtener_name_jasper(p_norden, name_service),
               cn.usuario_firma,
               dp.apellidos_pa,
               dp.direccion_pa,
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
               td.descripcion,
               td.name_digitalizacion,
               td.dni
        FROM datos_paciente dp
                 INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
                 INNER JOIN cuestionario_nordico cn ON cn.n_orden = noo.n_orden
                 INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
                 INNER JOIN temp_digitalizados_cuestionario_nordico td ON cn.n_orden = td.n_orden
        WHERE noo.n_orden = p_norden;

    DROP TABLE IF EXISTS temp_digitalizados_cuestionario_nordico;
END;
$$;



create function obtener_reporte_evaluacion_musculo_esqueletica2021(p_norden integer, name_service text)
    returns TABLE
            (
                nombres                                   text,
                dni                                       integer,
                sexo                                      "char",
                edad                                      text,
                empresa                                   text,
                contrata                                  text,
                cargo                                     text,
                area                                      text,
                doctor                                    text,
                n_orden                                   integer,
                cod_evaluacion                            integer,
                tiempo_servicio                           text,
                fecha_examen                              date,
                aptitud_espalda_abdomen                   text,
                aptitud_espalda_cadera                    text,
                aptitud_espalda_muslo                     text,
                aptitud_espalda_abdomen_l                 text,
                total_puntos_aptitud_espalda              text,
                observacion_aptitud_espalda               text,
                rangos_articulares_abduccion_180          text,
                rangos_articulares_abduccion_60           text,
                rangos_articulares_rotacion_90            text,
                rangos_articulares_rotacion_interna       text,
                total_puntos_rangos_articulares           text,
                rangos_articulares_abduccion_180_si       boolean,
                rangos_articulares_abduccion_180_no       boolean,
                rangos_articulares_abduccion_60_si        boolean,
                rangos_articulares_abduccion_60_no        boolean,
                rangos_articulares_rotacion_90_si         boolean,
                rangos_articulares_rotacion_90_no         boolean,
                rangos_articulares_rotacion_interna_si    boolean,
                rangos_articulares_rotacion_interna_no    boolean,
                observacion_rangos_articulares            text,
                columna_vertebral_desviacion_si           boolean,
                columna_vertebral_desviacion_no           boolean,
                columna_vertebral_desviacion_descripcion  text,
                columna_vertebral_adams_positivo          boolean,
                columna_vertebral_adams_negativo          boolean,
                columna_vertebral_adams_descripcion       text,
                columna_vertebral_dandy_positivo          boolean,
                columna_vertebral_dandy_negativo          boolean,
                columna_vertebral_dandy_descripcion       text,
                columna_vertebral_lasegue_positivo        boolean,
                columna_vertebral_lasegue_negativo        boolean,
                columna_vertebral_lasegue_descripcion     text,
                columna_vertebral_contractura_si          boolean,
                columna_vertebral_contractura_no          boolean,
                columna_vertebral_contractura_descripcion text,
                columna_vertebral_cicatriz_si             boolean,
                columna_vertebral_cicatriz_no             boolean,
                columna_vertebral_cicatriz_descripcion    text,
                test_jobe_derecha_si                      boolean,
                test_jobe_derecha_no                      boolean,
                test_jobe_izquierda_si                    boolean,
                test_jobe_izquierda_no                    boolean,
                test_pate_derecha_si                      boolean,
                test_pate_derecha_no                      boolean,
                test_pate_izquierda_si                    boolean,
                test_pate_izquierda_no                    boolean,
                test_gerber_derecha_si                    boolean,
                test_gerber_derecha_no                    boolean,
                test_gerber_izquierda_si                  boolean,
                test_gerber_izquierda_no                  boolean,
                test_pulm_derecha_si                      boolean,
                test_pulm_derecha_no                      boolean,
                test_pulm_izquierda_si                    boolean,
                test_pulm_izquierda_no                    boolean,
                epicondilitis_derecha_si                  boolean,
                epicondilitis_derecha_no                  boolean,
                epicondilitis_izquierda_si                boolean,
                epicondilitis_izquierda_no                boolean,
                epitrocleitis_derecha_si                  boolean,
                epitrocleitis_derecha_no                  boolean,
                epitrocleitis_izquierda_si                boolean,
                epitrocleitis_izquierda_no                boolean,
                phalen_derecha_si                         boolean,
                phalen_derecha_no                         boolean,
                phalen_izquierda_si                       boolean,
                phalen_izquierda_no                       boolean,
                phalen_invertido_derecha_si               boolean,
                phalen_invertido_derecha_no               boolean,
                phalen_invertido_izquierda_si             boolean,
                phalen_invertido_izquierda_no             boolean,
                tinnel_derecha_si                         boolean,
                tinnel_derecha_no                         boolean,
                tinnel_izquierda_si                       boolean,
                tinnel_izquierda_no                       boolean,
                finkels_tein_derecha_si                   boolean,
                finkels_tein_derecha_no                   boolean,
                finkels_tein_izquierda_si                 boolean,
                finkels_tein_izquierda_no                 boolean,
                cadera_derecha_abduccion                  text,
                cadera_derecha_aduccion                   text,
                cadera_derecha_flexion                    text,
                cadera_derecha_extension                  text,
                cadera_derecha_rot_externa                text,
                cadera_derecha_rot_interna                text,
                cadera_derecha_irradiacion                text,
                cadera_derecha_masa_muscular              text,
                cadera_izquierda_abduccion                text,
                cadera_izquierda_aduccion                 text,
                cadera_izquierda_flexion                  text,
                cadera_izquierda_extension                text,
                cadera_izquierda_rot_externa              text,
                cadera_izquierda_rot_interna              text,
                cadera_izquierda_irradiacion              text,
                cadera_izquierda_masa_muscular            text,
                rodilla_derecha_flexion                   text,
                rodilla_derecha_extension                 text,
                rodilla_derecha_rot_externa               text,
                rodilla_derecha_rot_interna               text,
                rodilla_derecha_irradiacion               text,
                rodilla_derecha_masa_muscular             text,
                rodilla_izquierda_flexion                 text,
                rodilla_izquierda_extension               text,
                rodilla_izquierda_rot_externa             text,
                rodilla_izquierda_rot_interna             text,
                rodilla_izquierda_irradiacion             text,
                rodilla_izquierda_masa_muscular           text,
                tobillo_derecho_abduccion                 text,
                tobillo_derecho_aduccion                  text,
                tobillo_derecho_flexion                   text,
                tobillo_derecho_extension                 text,
                tobillo_derecho_rot_externa               text,
                tobillo_derecho_rot_interna               text,
                tobillo_derecho_irradiacion               text,
                tobillo_derecho_masa_muscular             text,
                tobillo_izquierdo_abduccion               text,
                tobillo_izquierdo_aduccion                text,
                tobillo_izquierdo_flexion                 text,
                tobillo_izquierdo_extension               text,
                tobillo_izquierdo_rot_externa             text,
                tobillo_izquierdo_rot_interna             text,
                tobillo_izquierdo_irradiacion             text,
                tobillo_izquierdo_masa_muscular           text,
                conclusiones                              text,
                cie10                                     text,
                recomendaciones                           text,
                medico                                    text,
                dni_user                                  integer,
                user_registro                             text,
                color                                     integer,
                sede_descripcion                          text,
                nombre_jasper                             text,
                usuario_firma                             text,
                apellidos_paciente                        text,
                direccion_paciente                        text,
                fecha_nacimiento_paciente                 date,
                ocupacion_paciente                        text,
                lugar_nacimiento_paciente                 text,
                nivel_estudio_paciente                    text,
                estado_civil_paciente                     text,
                codigo_clinica                            text,
                nombre_examen                             text,
                descripcion_digitalizacion                text,
                name_digitalizacion                       text,
                dni_digitalizacion                        integer
            )
    language plpgsql
as
$$
BEGIN

    -- Tabla temporal para los parametros digitalizados
    CREATE TEMP TABLE temp_digitalizados_evaluacion_musculo_esqueletica2021 AS
    SELECT p_norden AS n_orden, *
    FROM obtener_parametros_digitalizados(p_norden, name_service);

    RETURN QUERY
        SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
               noo.cod_pa,
               dp.sexo_pa,
               CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
               noo.razon_empresa,
               noo.razon_contrata,
               noo.cargo_de,
               noo.area_o,
               u.nombre_user || ' ' || u.apellido_user,
               ci.n_orden,
               ci.cod_eval,
               ci.t_servicio,
               ci.f_examen,
               ci.txtaeabdomen,
               ci.txtaecadera,
               ci.txtaemuslo,
               ci.txtaeabdomenl,
               ci.txttotalpuntosae,
               ci.txtobservae,
               ci.txtraabduccion180,
               ci.txtraabducion60,
               ci.txtrarotacion90,
               ci.txtrarotacionint,
               ci.txttotalpuntosra,
               ci.rbraabducion180_si,
               ci.rbraabducion180_no,
               ci.rbraabducion60_si,
               ci.rbraabducion60_no,
               ci.rbrarotacion90_si,
               ci.rbrarotacion90_no,
               ci.rbrarotacionint_si,
               ci.rbrarotacionint_no,
               ci.txtobservra,
               ci.rbcvdesviacion_si,
               ci.rbcvdesviacion_no,
               ci.txtcvdesviacion,
               ci.rbcvtest_pos,
               ci.rbcvtest_neg,
               ci.txtcvtest,
               ci.rbcvdandy_pos,
               ci.rbcvdandy_neg,
               ci.txtcvdandy,
               ci.rbcvlasegue_pos,
               ci.rbcvlasegue_neg,
               ci.txtcvlasegue,
               ci.rbcvcontractura_si,
               ci.rbcvcontractura_no,
               ci.txtcvcontractura,
               ci.rbcvcicatriz_si,
               ci.rbcvcicatriz_no,
               ci.txtcvcicatriz,
               ci.rbtjderecha_si,
               ci.rbtjderecha_no,
               ci.rbtjizquierda_si,
               ci.rbtjizquierda_no,
               ci.rbtpderecha_si,
               ci.rbtpderecha_no,
               ci.rbtpizquierda_si,
               ci.rbtpizquierda_no,
               ci.rbtgderecha_si,
               ci.rbtgderecha_no,
               ci.rbtgizquierda_si,
               ci.rbtgizquierda_no,
               ci.rbptderecha_si,
               ci.rbptderecha_no,
               ci.rbptizquierda_si,
               ci.rbptizquierda_no,
               ci.rbecderecha_si,
               ci.rbecderecha_no,
               ci.rbecizquierda_si,
               ci.rbecizquierda_no,
               ci.rbetderecha_si,
               ci.rbetderecha_no,
               ci.rbetizquierda_si,
               ci.rbetizquierda_no,
               ci.rbpderecha_si,
               ci.rbpderecha_no,
               ci.rbpizquierda_si,
               ci.rbpizquierda_no,
               ci.rbpiderecha_si,
               ci.rbpiderecha_no,
               ci.rbpiizquierda_si,
               ci.rbpiizquierda_no,
               ci.rbtderecha_si,
               ci.rbtderecha_no,
               ci.rbtizquierda_si,
               ci.rbtizquierda_no,
               ci.rbftderecha_si,
               ci.rbftderecha_no,
               ci.rbftizquierda_si,
               ci.rbftizquierda_no,
               ci.txtcdabduccion,
               ci.txtcdaduccion,
               ci.txtcdflexion,
               ci.txtcdextension,
               ci.txtcdrotexterna,
               ci.txtcdrotinterna,
               ci.txtcdirradiacion,
               ci.txtcdmasamusc,
               ci.txtciabduccion,
               ci.txtciaduccion,
               ci.txtciflexion,
               ci.txtciextension,
               ci.txtcirotexterna,
               ci.txtcirotinterna,
               ci.txtciirradiacion,
               ci.txtcimasamusc,
               ci.txtrdflexion,
               ci.txtrdextension,
               ci.txtrdrotexterna,
               ci.txtrdrotinterna,
               ci.txtrdirradiacion,
               ci.txtrdmasamusc,
               ci.txtriflexion,
               ci.txtriextension,
               ci.txtrirotexterna,
               ci.txtrirotinterna,
               ci.txtriirradiacion,
               ci.txtrimasamusc,
               ci.txttdabduccion,
               ci.txttdaduccion,
               ci.txttdflexion,
               ci.txttdextension,
               ci.txttdrotexterna,
               ci.txttdrotinterna,
               ci.txttdirradiacion,
               ci.txttdmasamusc,
               ci.txttiabduccion,
               ci.txttiaduccion,
               ci.txttiflexion,
               ci.txttiextension,
               ci.txttirotexterna,
               ci.txttirotinterna,
               ci.txttiirradiacion,
               ci.txttimasamusc,
               ci.txtconclusiones,
               ci.txtcie10,
               ci.txtrecomendaciones,
               ci.txtmedico,
               ci.dni_user,
               ci.user_registro,
               noo.color,
               CASE
                   WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               obtener_name_jasper(p_norden, name_service),
               ci.usuario_firma,
               dp.apellidos_pa,
               dp.direccion_pa,
               dp.fecha_nacimiento_pa,
               dp.ocupacion_pa,
               dp.lugar_nac_pa,
               dp.nivel_est_pa,
               dp.estado_civil_pa,
               noo.cod_clinica,
               noo.nom_examen,
               td.descripcion,
               td.name_digitalizacion,
               td.dni

        FROM datos_paciente dp
                 INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
                 INNER JOIN evaluacion_musculo_esqueletica2021 ci ON ci.n_orden = noo.n_orden
                 INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
                 LEFT JOIN usuarios u ON u.dni_user = ci.dni_user
                 INNER JOIN temp_digitalizados_evaluacion_musculo_esqueletica2021 td ON ci.n_orden = td.n_orden
        WHERE noo.n_orden = p_norden;

    DROP TABLE IF EXISTS temp_digitalizados_evaluacion_musculo_esqueletica2021;
END;
$$;


create function obtener_reporte_evaluacion_musculo_esqueletica(p_norden integer, name_service text)
    returns TABLE
            (
                nombres                    text,
                sexo                       "char",
                dni                        integer,
                edad                       text,
                empresa                    text,
                contrata                   text,
                area_trabajo               text,
                cod_eval                   integer,
                n_orden                    integer,
                t_servicio                 text,
                f_examen                   date,
                rbsintoma_si               boolean,
                rbsintoma_no               boolean,
                txtsintomas                text,
                rbfaja_si                  boolean,
                rbfaja_no                  boolean,
                rbtecnicacarga_si          boolean,
                rbtecnicacarga_no          boolean,
                rbcapacitacioncarga_si     boolean,
                rbcapacitacioncarga_no     boolean,
                txtextencion_cabeza        text,
                txtflexion_cabeza          text,
                rbextension_cabeza_n       boolean,
                rbextension_cabeza_r       boolean,
                rbextension_cabeza_m       boolean,
                rbflexion_cabeza_n         boolean,
                rbflexion_cabeza_r         boolean,
                rbflexion_cabeza_m         boolean,
                rbflexion_hombro_n         boolean,
                rbflexion_hombro_r         boolean,
                rbflexion_hombro_m         boolean,
                rbflexion_hombro_n1        boolean,
                rbflexion_hombro_r1        boolean,
                rbflexion_hombro_m1        boolean,
                rbextension_hombro_n       boolean,
                rbextension_hombro_r       boolean,
                rbextension_hombro_m       boolean,
                rbextension_hombro_n1      boolean,
                rbextension_hombro_r1      boolean,
                rbextension_hombro_m1      boolean,
                rbabduccion_hombro_n       boolean,
                rbabduccion_hombro_r       boolean,
                rbabduccion_hombro_m       boolean,
                rbabduccion_hombro_n1      boolean,
                rbabduccion_hombro_r1      boolean,
                rbabduccion_hombro_m1      boolean,
                rbaduccion_hombro_n        boolean,
                rbaduccion_hombro_r        boolean,
                rbaduccion_hombro_m        boolean,
                rbaduccion_hombro_n1       boolean,
                rbaduccion_hombro_r1       boolean,
                rbaduccion_hombro_m1       boolean,
                rbrotacionint_hombro_n     boolean,
                rbrotacionint_hombro_r     boolean,
                rbrotacionint_hombro_m     boolean,
                rbrotacionint_hombro_n1    boolean,
                rbrotacionint_hombro_r1    boolean,
                rbrotacionint_hombro_m1    boolean,
                rbrotacionext_hombro_n     boolean,
                rbrotacionext_hombro_r     boolean,
                rbrotacionext_hombro_m     boolean,
                rbrotacionext_hombro_n1    boolean,
                rbrotacionext_hombro_r1    boolean,
                rbrotacionext_hombro_m1    boolean,
                rbflexion_brazo_n          boolean,
                rbflexion_brazo_r          boolean,
                rbflexion_brazo_m          boolean,
                rbflexion_brazo_n1         boolean,
                rbflexion_brazo_r1         boolean,
                rbflexion_brazo_m1         boolean,
                rbextension_brazo_n        boolean,
                rbextension_brazo_r        boolean,
                rbextension_brazo_m        boolean,
                rbextension_brazo_n1       boolean,
                rbextension_brazo_r1       boolean,
                rbextension_brazo_m1       boolean,
                rbpronacion_antebrazo_n    boolean,
                rbpronacion_antebrazo_r    boolean,
                rbpronacion_antebrazo_m    boolean,
                rbpronacion_antebrazo_n1   boolean,
                rbpronacion_antebrazo_r1   boolean,
                rbpronacion_antebrazo_m1   boolean,
                rbsupinacion_antebrazo_n   boolean,
                rbsupinacion_antebrazo_r   boolean,
                rbsupinacion_antebrazo_m   boolean,
                rbsupinacion_antebrazo_n1  boolean,
                rbsupinacion_antebrazo_r1  boolean,
                rbsupinacion_antebrazo_m1  boolean,
                rbflexion_munieca_n        boolean,
                rbflexion_munieca_r        boolean,
                rbflexion_munieca_m        boolean,
                rbflexion_munieca_n1       boolean,
                rbflexion_munieca_r1       boolean,
                rbflexion_munieca_m1       boolean,
                rbextension_munieca_n      boolean,
                rbextension_munieca_r      boolean,
                rbextension_munieca_m      boolean,
                rbextension_munieca_n1     boolean,
                rbextension_munieca_r1     boolean,
                rbextension_munieca_m1     boolean,
                rbdesvcubital_munieca_n    boolean,
                rbdesvcubital_munieca_r    boolean,
                rbdesvcubital_munieca_m    boolean,
                rbdesvcubital_munieca_n1   boolean,
                rbdesvcubital_munieca_r1   boolean,
                rbdesvcubital_munieca_m1   boolean,
                rbdesvradial_munieca_n     boolean,
                rbdesvradial_munieca_r     boolean,
                rbdesvradial_munieca_m     boolean,
                rbdesvradial_munieca_n1    boolean,
                rbdesvradial_munieca_r1    boolean,
                rbdesvradial_munieca_m1    boolean,
                rbphallen_si               boolean,
                rbphallen_no               boolean,
                rbtinel_si                 boolean,
                rbtinel_no                 boolean,
                rbflexion_torax_n          boolean,
                rbflexion_torax_r          boolean,
                rbflexion_torax_m          boolean,
                rbflexion_torax_n1         boolean,
                rbflexion_torax_r1         boolean,
                rbflexion_torax_m1         boolean,
                rbextension_torax_n        boolean,
                rbextension_torax_r        boolean,
                rbextension_torax_m        boolean,
                rbextension_torax_n1       boolean,
                rbextension_torax_r1       boolean,
                rbextension_torax_m1       boolean,
                rbrotacion_torax_n         boolean,
                rbrotacion_torax_r         boolean,
                rbrotacion_torax_m         boolean,
                rbrotacion_torax_n1        boolean,
                rbrotacion_torax_r1        boolean,
                rbrotacion_torax_m1        boolean,
                rbflexion_cadera_n         boolean,
                rbflexion_cadera_r         boolean,
                rbflexion_cadera_m         boolean,
                rbflexion_cadera_n1        boolean,
                rbflexion_cadera_r1        boolean,
                rbflexion_cadera_m1        boolean,
                rbextension_cadera_n       boolean,
                rbextension_cadera_r       boolean,
                rbextension_cadera_m       boolean,
                rbextension_cadera_n1      boolean,
                rbextension_cadera_r1      boolean,
                rbextension_cadera_m1      boolean,
                rbabduccion_cadera_n       boolean,
                rbabduccion_cadera_r       boolean,
                rbabduccion_cadera_m       boolean,
                rbabduccion_cadera_n1      boolean,
                rbabduccion_cadera_r1      boolean,
                rbabduccion_cadera_m1      boolean,
                rbaduccion_cadera_n        boolean,
                rbaduccion_cadera_r        boolean,
                rbaduccion_cadera_m        boolean,
                rbaduccion_cadera_n1       boolean,
                rbaduccion_cadera_r1       boolean,
                rbaduccion_cadera_m1       boolean,
                rbrotacionint_cadera_n     boolean,
                rbrotacionint_cadera_r     boolean,
                rbrotacionint_cadera_m     boolean,
                rbrotacionint_cadera_n1    boolean,
                rbrotacionint_cadera_r1    boolean,
                rbrotacionint_cadera_m1    boolean,
                rbrotacionext_cadera_n     boolean,
                rbrotacionext_cadera_r     boolean,
                rbrotacionext_cadera_m     boolean,
                rbrotacionext_cadera_n1    boolean,
                rbrotacionext_cadera_r1    boolean,
                rbrotacionext_cadera_m1    boolean,
                rbflexion_pierna_n         boolean,
                rbflexion_pierna_r         boolean,
                rbflexion_pierna_m         boolean,
                rbflexion_pierna_n1        boolean,
                rbflexion_pierna_r1        boolean,
                rbflexion_pierna_m1        boolean,
                rbextension_pierna_n       boolean,
                rbextension_pierna_r       boolean,
                rbextension_pierna_m       boolean,
                rbextension_pierna_n1      boolean,
                rbextension_pierna_r1      boolean,
                rbextension_pierna_m1      boolean,
                rbflexion_rodilla_n        boolean,
                rbflexion_rodilla_r        boolean,
                rbflexion_rodilla_m        boolean,
                rbflexion_rodilla_n1       boolean,
                rbflexion_rodilla_r1       boolean,
                rbflexion_rodilla_m1       boolean,
                rbextension_rodilla_n      boolean,
                rbextension_rodilla_r      boolean,
                rbextension_rodilla_m      boolean,
                rbextension_rodilla_n1     boolean,
                rbextension_rodilla_r1     boolean,
                rbextension_rodilla_m1     boolean,
                rbrotacionint_rodilla_n    boolean,
                rbrotacionint_rodilla_r    boolean,
                rbrotacionint_rodilla_m    boolean,
                rbrotacionint_rodilla_n1   boolean,
                rbrotacionint_rodilla_r1   boolean,
                rbrotacionint_rodilla_m1   boolean,
                rbrotacionext_rodilla_n    boolean,
                rbrotacionext_rodilla_r    boolean,
                rbrotacionext_rodilla_m    boolean,
                rbrotacionext_rodilla_n1   boolean,
                rbrotacionext_rodilla_r1   boolean,
                rbrotacionext_rodilla_m1   boolean,
                rbflexion_tobillo_n        boolean,
                rbflexion_tobillo_r        boolean,
                rbflexion_tobillo_m        boolean,
                rbflexion_tobillo_n1       boolean,
                rbflexion_tobillo_r1       boolean,
                rbflexion_tobillo_m1       boolean,
                rbextension_tobillo_n      boolean,
                rbextension_tobillo_r      boolean,
                rbextension_tobillo_m      boolean,
                rbextension_tobillo_n1     boolean,
                rbextension_tobillo_r1     boolean,
                rbextension_tobillo_m1     boolean,
                rbfuerzamuscular_1         boolean,
                rbfuerzamuscular_2         boolean,
                rbfuerzamuscular_3         boolean,
                rbfuerzamuscular_4         boolean,
                rbfuerzamuscular_5         boolean,
                rbejecervical_normal       boolean,
                rbejecervical_derecha      boolean,
                rbejecervical_izq          boolean,
                rbejedorsal_normal         boolean,
                rbejedorsal_derecha        boolean,
                rbejedorsal_izq            boolean,
                rbejelumbar_normal         boolean,
                rbejelumbar_derecha        boolean,
                rbejelumbar_izq            boolean,
                rbcifosis_si               boolean,
                rbcifosis_no               boolean,
                rbescoliosis_si            boolean,
                rbescoliosis_no            boolean,
                rblordosis_si              boolean,
                rblordosis_no              boolean,
                rbmixta_si                 boolean,
                rbmixta_no                 boolean,
                rbcervical_si              boolean,
                rbcervical_no              boolean,
                rbdorsal_si                boolean,
                rbdorsal_no                boolean,
                rblumbar_si                boolean,
                rblumbra_no                boolean,
                rblesagueder_si            boolean,
                rblesagueder_no            boolean,
                rblesagueizq_si            boolean,
                rblesagueizq_no            boolean,
                chktratamiento_si          boolean,
                chktratamiento_no          boolean,
                dni_user                   integer,
                txtdiagnostico             text,
                chkconclusion_si           boolean,
                chkconclusion_no           boolean,
                txtrecomendaciones         text,
                color                      integer,
                sede_descripcion           text,
                nom_medico                 text,
                nombre_jasper              text,
                usuario_firma              text,
                apellidos_paciente         text,
                direccion_paciente         text,
                fecha_nacimiento_paciente  date,
                ocupacion_paciente         text,
                lugar_nacimiento_paciente  text,
                nivel_estudio_paciente     text,
                estado_civil_paciente      text,
                codigo_clinica             text,
                nombre_examen              text,
                descripcion_digitalizacion text,
                name_digitalizacion        text,
                dni_digitalizacion         integer
            )
    language plpgsql
as
$$
BEGIN
    -- Tabla temporal para los parametros digitalizados
    CREATE TEMP TABLE temp_digitalizados_evaluacion_musculo_esqueletica AS
    SELECT p_norden AS n_orden, *
    FROM obtener_parametros_digitalizados(p_norden, name_service);

    RETURN QUERY
        SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
               dp.sexo_pa,
               noo.cod_pa,
               CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
               noo.razon_empresa,
               noo.razon_contrata,
               noo.area_o,

               eme.cod_eval,
               eme.n_orden,
               eme.t_servicio,
               eme.f_examen,
               eme.rbsintoma_si,
               eme.rbsintoma_no,
               eme.txtsintomas,
               eme.rbfaja_si,
               eme.rbfaja_no,
               eme.rbtecnicacarga_si,
               eme.rbtecnicacarga_no,
               eme.rbcapacitacioncarga_si,
               eme.rbcapacitacioncarga_no,
               eme.txtextencion_cabeza,
               eme.txtflexion_cabeza,
               eme.rbextension_cabeza_n,
               eme.rbextension_cabeza_r,
               eme.rbextension_cabeza_m,
               eme.rbflexion_cabeza_n,
               eme.rbflexion_cabeza_r,
               eme.rbflexion_cabeza_m,
               eme.rbflexion_hombro_n,
               eme.rbflexion_hombro_r,
               eme.rbflexion_hombro_m,
               eme.rbflexion_hombro_n1,
               eme.rbflexion_hombro_r1,
               eme.rbflexion_hombro_m1,
               eme.rbextension_hombro_n,
               eme.rbextension_hombro_r,
               eme.rbextension_hombro_m,
               eme.rbextension_hombro_n1,
               eme.rbextension_hombro_r1,
               eme.rbextension_hombro_m1,
               eme.rbabduccion_hombro_n,
               eme.rbabduccion_hombro_r,
               eme.rbabduccion_hombro_m,
               eme.rbabduccion_hombro_n1,
               eme.rbabduccion_hombro_r1,
               eme.rbabduccion_hombro_m1,
               eme.rbaduccion_hombro_n,
               eme.rbaduccion_hombro_r,
               eme.rbaduccion_hombro_m,
               eme.rbaduccion_hombro_n1,
               eme.rbaduccion_hombro_r1,
               eme.rbaduccion_hombro_m1,
               eme.rbrotacionint_hombro_n,
               eme.rbrotacionint_hombro_r,
               eme.rbrotacionint_hombro_m,
               eme.rbrotacionint_hombro_n1,
               eme.rbrotacionint_hombro_r1,
               eme.rbrotacionint_hombro_m1,
               eme.rbrotacionext_hombro_n,
               eme.rbrotacionext_hombro_r,
               eme.rbrotacionext_hombro_m,
               eme.rbrotacionext_hombro_n1,
               eme.rbrotacionext_hombro_r1,
               eme.rbrotacionext_hombro_m1,
               eme.rbflexion_brazo_n,
               eme.rbflexion_brazo_r,
               eme.rbflexion_brazo_m,
               eme.rbflexion_brazo_n1,
               eme.rbflexion_brazo_r1,
               eme.rbflexion_brazo_m1,
               eme.rbextension_brazo_n,
               eme.rbextension_brazo_r,
               eme.rbextension_brazo_m,
               eme.rbextension_brazo_n1,
               eme.rbextension_brazo_r1,
               eme.rbextension_brazo_m1,
               eme.rbpronacion_antebrazo_n,
               eme.rbpronacion_antebrazo_r,
               eme.rbpronacion_antebrazo_m,
               eme.rbpronacion_antebrazo_n1,
               eme.rbpronacion_antebrazo_r1,
               eme.rbpronacion_antebrazo_m1,
               eme.rbsupinacion_antebrazo_n,
               eme.rbsupinacion_antebrazo_r,
               eme.rbsupinacion_antebrazo_m,
               eme.rbsupinacion_antebrazo_n1,
               eme.rbsupinacion_antebrazo_r1,
               eme.rbsupinacion_antebrazo_m1,
               eme.rbflexion_munieca_n,
               eme.rbflexion_munieca_r,
               eme.rbflexion_munieca_m,
               eme.rbflexion_munieca_n1,
               eme.rbflexion_munieca_r1,
               eme.rbflexion_munieca_m1,
               eme.rbextension_munieca_n,
               eme.rbextension_munieca_r,
               eme.rbextension_munieca_m,
               eme.rbextension_munieca_n1,
               eme.rbextension_munieca_r1,
               eme.rbextension_munieca_m1,
               eme.rbdesvcubital_munieca_n,
               eme.rbdesvcubital_munieca_r,
               eme.rbdesvcubital_munieca_m,
               eme.rbdesvcubital_munieca_n1,
               eme.rbdesvcubital_munieca_r1,
               eme.rbdesvcubital_munieca_m1,
               eme.rbdesvradial_munieca_n,
               eme.rbdesvradial_munieca_r,
               eme.rbdesvradial_munieca_m,
               eme.rbdesvradial_munieca_n1,
               eme.rbdesvradial_munieca_r1,
               eme.rbdesvradial_munieca_m1,
               eme.rbphallen_si,
               eme.rbphallen_no,
               eme.rbtinel_si,
               eme.rbtinel_no,
               eme.rbflexion_torax_n,
               eme.rbflexion_torax_r,
               eme.rbflexion_torax_m,
               eme.rbflexion_torax_n1,
               eme.rbflexion_torax_r1,
               eme.rbflexion_torax_m1,
               eme.rbextension_torax_n,
               eme.rbextension_torax_r,
               eme.rbextension_torax_m,
               eme.rbextension_torax_n1,
               eme.rbextension_torax_r1,
               eme.rbextension_torax_m1,
               eme.rbrotacion_torax_n,
               eme.rbrotacion_torax_r,
               eme.rbrotacion_torax_m,
               eme.rbrotacion_torax_n1,
               eme.rbrotacion_torax_r1,
               eme.rbrotacion_torax_m1,
               eme.rbflexion_cadera_n,
               eme.rbflexion_cadera_r,
               eme.rbflexion_cadera_m,
               eme.rbflexion_cadera_n1,
               eme.rbflexion_cadera_r1,
               eme.rbflexion_cadera_m1,
               eme.rbextension_cadera_n,
               eme.rbextension_cadera_r,
               eme.rbextension_cadera_m,
               eme.rbextension_cadera_n1,
               eme.rbextension_cadera_r1,
               eme.rbextension_cadera_m1,
               eme.rbabduccion_cadera_n,
               eme.rbabduccion_cadera_r,
               eme.rbabduccion_cadera_m,
               eme.rbabduccion_cadera_n1,
               eme.rbabduccion_cadera_r1,
               eme.rbabduccion_cadera_m1,
               eme.rbaduccion_cadera_n,
               eme.rbaduccion_cadera_r,
               eme.rbaduccion_cadera_m,
               eme.rbaduccion_cadera_n1,
               eme.rbaduccion_cadera_r1,
               eme.rbaduccion_cadera_m1,
               eme.rbrotacionint_cadera_n,
               eme.rbrotacionint_cadera_r,
               eme.rbrotacionint_cadera_m,
               eme.rbrotacionint_cadera_n1,
               eme.rbrotacionint_cadera_r1,
               eme.rbrotacionint_cadera_m1,
               eme.rbrotacionext_cadera_n,
               eme.rbrotacionext_cadera_r,
               eme.rbrotacionext_cadera_m,
               eme.rbrotacionext_cadera_n1,
               eme.rbrotacionext_cadera_r1,
               eme.rbrotacionext_cadera_m1,
               eme.rbflexion_pierna_n,
               eme.rbflexion_pierna_r,
               eme.rbflexion_pierna_m,
               eme.rbflexion_pierna_n1,
               eme.rbflexion_pierna_r1,
               eme.rbflexion_pierna_m1,
               eme.rbextension_pierna_n,
               eme.rbextension_pierna_r,
               eme.rbextension_pierna_m,
               eme.rbextension_pierna_n1,
               eme.rbextension_pierna_r1,
               eme.rbextension_pierna_m1,
               eme.rbflexion_rodilla_n,
               eme.rbflexion_rodilla_r,
               eme.rbflexion_rodilla_m,
               eme.rbflexion_rodilla_n1,
               eme.rbflexion_rodilla_r1,
               eme.rbflexion_rodilla_m1,
               eme.rbextension_rodilla_n,
               eme.rbextension_rodilla_r,
               eme.rbextension_rodilla_m,
               eme.rbextension_rodilla_n1,
               eme.rbextension_rodilla_r1,
               eme.rbextension_rodilla_m1,
               eme.rbrotacionint_rodilla_n,
               eme.rbrotacionint_rodilla_r,
               eme.rbrotacionint_rodilla_m,
               eme.rbrotacionint_rodilla_n1,
               eme.rbrotacionint_rodilla_r1,
               eme.rbrotacionint_rodilla_m1,
               eme.rbrotacionext_rodilla_n,
               eme.rbrotacionext_rodilla_r,
               eme.rbrotacionext_rodilla_m,
               eme.rbrotacionext_rodilla_n1,
               eme.rbrotacionext_rodilla_r1,
               eme.rbrotacionext_rodilla_m1,
               eme.rbflexion_tobillo_n,
               eme.rbflexion_tobillo_r,
               eme.rbflexion_tobillo_m,
               eme.rbflexion_tobillo_n1,
               eme.rbflexion_tobillo_r1,
               eme.rbflexion_tobillo_m1,
               eme.rbextension_tobillo_n,
               eme.rbextension_tobillo_r,
               eme.rbextension_tobillo_m,
               eme.rbextension_tobillo_n1,
               eme.rbextension_tobillo_r1,
               eme.rbextension_tobillo_m1,
               eme.rbfuerzamuscular_1,
               eme.rbfuerzamuscular_2,
               eme.rbfuerzamuscular_3,
               eme.rbfuerzamuscular_4,
               eme.rbfuerzamuscular_5,
               eme.rbejecervical_normal,
               eme.rbejecervical_derecha,
               eme.rbejecervical_izq,
               eme.rbejedorsal_normal,
               eme.rbejedorsal_derecha,
               eme.rbejedorsal_izq,
               eme.rbejelumbar_normal,
               eme.rbejelumbar_derecha,
               eme.rbejelumbar_izq,
               eme.rbcifosis_si,
               eme.rbcifosis_no,
               eme.rbescoliosis_si,
               eme.rbescoliosis_no,
               eme.rblordosis_si,
               eme.rblordosis_no,
               eme.rbmixta_si,
               eme.rbmixta_no,
               eme.rbcervical_si,
               eme.rbcervical_no,
               eme.rbdorsal_si,
               eme.rbdorsal_no,
               eme.rblumbar_si,
               eme.rblumbra_no,
               eme.rblesagueder_si,
               eme.rblesagueder_no,
               eme.rblesagueizq_si,
               eme.rblesagueizq_no,
               eme.chktratamiento_si,
               eme.chktratamiento_no,
               eme.dni_user,
               eme.txtdiagnostico,
               eme.chkconclusion_si,
               eme.chkconclusion_no,
               eme.txtrecomendaciones,
               noo.color,
               CASE
                   WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               u.nombre_user || ' ' || u.apellido_user AS nom_medico,
               obtener_name_jasper(p_norden, name_service),
               eme.usuario_firma,
               dp.apellidos_pa,
               dp.direccion_pa,
               dp.fecha_nacimiento_pa,
               dp.ocupacion_pa,
               dp.lugar_nac_pa,
               dp.nivel_est_pa,
               dp.estado_civil_pa,
               noo.cod_clinica,
               noo.nom_examen,
               td.descripcion,
               td.name_digitalizacion,
               td.dni
        FROM datos_paciente dp
                 INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
                 INNER JOIN evaluacion_musculo_esqueletica eme ON eme.n_orden = noo.n_orden
                 INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
                 INNER JOIN usuarios u ON (u.dni_user = eme.dni_user)
                 INNER JOIN temp_digitalizados_evaluacion_musculo_esqueletica td ON eme.n_orden = td.n_orden
        WHERE noo.n_orden = p_norden;

    DROP TABLE IF EXISTS temp_digitalizados_evaluacion_musculo_esqueletica;

END;
$$;


create function sp_listar_registro_triaje(p_n_orden bigint)
    returns TABLE
            (
                n_orden             integer,
                nom_examen          text,
                razon_empresa       text,
                razon_contrata      text,
                nombres_pa          text,
                apellidos_pa        text,
                fecha_nacimiento_pa text,
                sexo_pa             text,
                fecha_triaje        text,
                talla               text,
                peso                text,
                imc                 text,
                cintura             text,
                icc                 text,
                cadera              text,
                temperatura         text,
                f_cardiaca          text,
                sat_02              text,
                perimetro_cuello    text,
                sistolica           text,
                diastolica          text,
                f_respiratoria      text,
                conclusion          text,
                sede                text,
                dir_tru_pierola     text,
                email_tru_pierola   text,
                telf_tru_pierola    text,
                cel_trujillo_pie    text,
                dir_huancayo        text,
                email_huancayo      text,
                telf_huancayo       text,
                dir_huamachuco      text,
                email_huamachuco    text,
                telf_huamachuco     text,
                cel_huamachuco      text,
                dir_trujillo        text,
                email_trujillo      text,
                telf_trujillo       text,
                color               integer,
                edad                text,
                cod_pa              integer,
                direccion_pa        text,
                ocupacion_pa        text,
                lugar_nac_pa        text,
                nivel_est_pa        text,
                estado_civil_pa     text,
                cargo_de            text,
                area_o              text,
                cod_clinica         text
            )
    language plpgsql
as
$$
begin

    RETURN query
        select noo.n_orden,
               noo.nom_examen,
               noo.razon_empresa,
               noo.razon_contrata,
               dp.nombres_pa,
               dp.apellidos_pa,
               CAST(dp.fecha_nacimiento_pa AS TEXT)                             AS fecha_nacimiento_pa,
               CAST(dp.sexo_pa AS TEXT)                                         as sexo_pa,
               CAST(tj.fecha_triaje AS TEXT)                                    AS fecha_triaje,
               tj.talla,
               tj.peso,
               tj.imc,
               tj.cintura,
               tj.icc,
               tj.cadera,
               tj.temperatura,
               tj.f_cardiaca,
               tj.sat_02,
               tj.perimetro_cuello,
               tj.sistolica,
               tj.diastolica,
               tj.f_respiratoria,
               tj.conclusion,
               CAST(sm.descripcion AS TEXT)                                     as sede,
               (SELECT direccion FROM sede WHERE cod_sede = 4)                  AS dir_tru_pierola,
               (SELECT email FROM sede WHERE cod_sede = 4)                      AS email_tru_pierola,
               (SELECT telefono FROM sede WHERE cod_sede = 4)                   AS telf_tru_pierola,
               (SELECT celular FROM sede WHERE cod_sede = 4)                    AS cel_trujillo_pie,
               (SELECT direccion FROM sede WHERE cod_sede = 3)                  AS dir_huancayo,
               (SELECT email FROM sede WHERE cod_sede = 3)                      AS email_huancayo,
               (SELECT telefono FROM sede WHERE cod_sede = 3)                   AS telf_huancayo,
               (SELECT direccion FROM sede WHERE cod_sede = 2)                  AS dir_huamachuco,
               (SELECT email FROM sede WHERE cod_sede = 2)                      AS email_huamachuco,
               (SELECT telefono FROM sede WHERE cod_sede = 2)                   AS telf_huamachuco,
               (SELECT celular FROM sede WHERE cod_sede = 2)                    AS cel_huamachuco,
               (SELECT direccion FROM sede WHERE cod_sede = 1)                  AS dir_trujillo,
               (SELECT email FROM sede WHERE cod_sede = 1)                      AS email_trujillo,
               (SELECT telefono FROM sede WHERE cod_sede = 1)                   AS telf_trujillo,
               noo.color,
               CAST(obtener_edad(dp.fecha_nacimiento_pa, CURRENT_DATE) AS TEXT) as edad,
               dp.cod_pa,
               dp.direccion_pa,
               dp.ocupacion_pa,
               dp.lugar_nac_pa,
               dp.nivel_est_pa,
               dp.estado_civil_pa,
               noo.cargo_de,
               noo.area_o,
               noo.cod_clinica
        from datos_paciente as dp
                 inner join n_orden_ocupacional as noo on dp.cod_pa = noo.cod_pa
                 inner join triaje as tj
                            on noo.n_orden = tj.n_orden
                 inner join sede_multisucursal as sm on noo.cod_sede = sm.id
        where noo.n_orden = p_n_orden
        limit 1;
end;
$$;

create function obtener_reporte_audiometria(p_norden integer)
    returns TABLE
            (
                nombres                 text,
                edad                    text,
                n_orden                 integer,
                dni                     integer,
                empresa                 text,
                contrata                text,
                cod_au                  integer,
                fecha_au                date,
                rbsasordera_si          boolean,
                rbsasordera_no          boolean,
                rbsaacufenos_si         boolean,
                rbsaacufenos_no         boolean,
                rbsavertigo_si          boolean,
                rbsavertigo_no          boolean,
                rbsaotalgia_si          boolean,
                rbsaotalgia_no          boolean,
                rbsasecrecion_si        boolean,
                rbsasecrecion_no        boolean,
                txtsaotrossintomas      text,
                rbamrenitis_si          boolean,
                rbamrenitis_no          boolean,
                rbamsinusitis_si        boolean,
                rbamsinusitis_no        boolean,
                rbamotitis_si           boolean,
                rbamotitis_no           boolean,
                rbamototoxicos_si       boolean,
                rbamototoxicos_no       boolean,
                rbammeningitis_si       boolean,
                rbammeningitis_no       boolean,
                rbamtec_si              boolean,
                rbamtec_no              boolean,
                rbamsordera_si          boolean,
                rbamsordera_no          boolean,
                rbamparotiditis_si      boolean,
                rbamparotiditis_no      boolean,
                rbamsarampion_si        boolean,
                rbamsarampion_no        boolean,
                rbamtbc_si              boolean,
                rbamtbc_no              boolean,
                txtamcuales             text,
                rbeoexposicion_si       boolean,
                rbeoexposicion_no       boolean,
                rbeoprotectores_si      boolean,
                rbeoprotectores_no      boolean,
                rbeosustancias_si       boolean,
                rbeosustancias_no       boolean,
                rbte0a2                 boolean,
                rbte2a4                 boolean,
                rbte4a6                 boolean,
                rbte6a8                 boolean,
                rbte8a10                boolean,
                rbte10a12               boolean,
                rbtem12                 boolean,
                rbteeventual            boolean,
                chktapones              boolean,
                chkorejeras             boolean,
                txthplomo               text,
                txthmercurio            text,
                txthtolueno             text,
                txthxileno              text,
                txthplaguic             text,
                txthorganofos           text,
                txttplomo               text,
                txttmercurio            text,
                txtttolueno             text,
                txttxileno              text,
                txttplaguic             text,
                txttorganofos           text,
                txteootros              text,
                rbaepratica_si          boolean,
                rbaepratica_no          boolean,
                rbaeuso_si              boolean,
                rbaeuso_no              boolean,
                rbaeotros_si            boolean,
                rbaeotros_no            boolean,
                txtaecuales             text,
                txtood                  text,
                txtooi                  text,
                o_d_500                 text,
                o_d_1000                text,
                o_d_2000                text,
                o_d_3000                text,
                o_d_4000                text,
                o_d_6000                text,
                o_d_8000                text,
                o_i_500                 text,
                o_i_1000                text,
                o_i_2000                text,
                o_i_3000                text,
                o_i_4000                text,
                o_i_6000                text,
                o_i_8000                text,
                o_d1_500                text,
                o_d1_1000               text,
                o_d1_2000               text,
                o_d1_3000               text,
                o_d1_4000               text,
                o_d1_6000               text,
                o_d1_8000               text,
                o_i1_500                text,
                o_i1_1000               text,
                o_i1_2000               text,
                o_i1_3000               text,
                o_i1_4000               text,
                o_i1_6000               text,
                o_i1_8000               text,
                txtdiag_od              text,
                txtdiag_oi              text,
                txtcomentarios          text,
                chkrpasimple            boolean,
                chkrpadoble             boolean,
                chkcasemestral          boolean,
                chkcaanual              boolean,
                txtotrasrecomendaciones text,
                txtanios                text,
                txtmeses                text,
                formato                 character varying,
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
                fecha_nacimiento_pa     date,
                sexo                    "char",
                areatrabajo             text,
                ocupacion               text,
                nom_examen              text,
                usuario_firma           text,
                apellidospaciente       text,
                fechanacimientopaciente date,
                direccionpaciente       text,
                lugarnacimientopaciente text,
                nivelestudiospaciente   text,
                estadocivilpaciente     text,
                codigoclinica           text
            )
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
               noo.cod_clinica
        FROM datos_paciente dp
                 INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
                 INNER JOIN audiometria_2023 aud ON aud.n_orden = noo.n_orden
                 INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
        WHERE noo.n_orden = p_norden;
END;
$$;

-- ALTER TABLE DE LOS NUEVOS CAMPOS - PARAMETROS DIGITALIZADOS

-- Historia y Fatiga
ALTER TABLE historia_oc_info
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE test_fatiga_sonmolencia
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;

-- Laboratorio y Bioquimica
ALTER TABLE hemograma_autom
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE analisis_bioquimicos
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE l_bioquimica
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE ac_bioquimica2022
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE perfil_hepatico
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;

-- Inmunologia y Microbiologia
ALTER TABLE lgonadotropina
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE microbiologia
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE lhepatitis
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE examen_inmunologico
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;

-- Toxicologia y Paneles
ALTER TABLE toxicologia
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE panel2d
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE panel3d
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE panel4d
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE panel10d
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;

-- Consentimientos
ALTER TABLE consent_laboratorios
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE consent_muestra_sangre
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;

-- Manipuladores y Otros
ALTER TABLE ac_coprocultivo
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;
ALTER TABLE ac_coproparasitologico
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;

ALTER TABLE examen_inmunologico
    ADD COLUMN IF NOT EXISTS usuario_firma TEXT;


-- INSERT de config service

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('analisis_bioquimicos', 'examen de laboratorio analisis bioquimico', false, false, true, true, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('trastornos_personalidad', 'formulario de trastornos de personalidad', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('infor_conductores', 'Formularios de informe de conductores', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('alto_riesgo', 'Formulario para trabajos de alto riesgo', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('especificos', 'Formulario para trabajos especificos', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('cuestionario_berlin', 'Formulario para Cuestionario de Berlin Psicología', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('exam_complementarios', 'Formulario para Cuestionario de Examen Complementarios', false, false, true, false,
        false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('psi_brigadistas', 'Formulario de Informe de Brigadistas', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('bombaelectrica', 'Formulario de Informe de Bomba Electrica', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('cuadradorvigia', 'Formulario de Informe Psicologico Cuadrador Vigia', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('riesgocoronario', 'Informe de laboratorio para Riesgo Coronario', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('fobias', 'Informe de Psicologico de fobias', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('aversionalriesgo', 'Formulario de Informe Psicologico Aversion Al riesgo', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('glucosatolerancia', 'Informe de laboratorio para Glucosa Tolerancia', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('inmunologia_vdrl', 'examen de laboratorio inmunologia vdrl', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('vih', 'examen de laboratorio inmunologia VIH', false, false, true, false, false);

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('thevenon', 'examen de laboratorio inmunologia THEVENON', false, false, true, false, false);


-- Thevenon

create function obtener_reporte_thevenon(p_norden integer, name_service text)
    returns TABLE
            (
                cod_pa                 integer,
                nombres_pa             text,
                apellidos_pa           text,
                direccion_pa           text,
                sexo_pa                text,
                dni_pa                 integer,
                fecha_nacimiento_pa    date,
                ocupacion_pa           text,
                lugar_nac_pa           text,
                nivel_est_pa           text,
                estado_civil_pa        text,
                edad_pa                text,
                n_orden                integer,
                razon_empresa          text,
                cargo_de               text,
                area_o                 text,
                razon_contrata         text,
                fecha_apertura_po      date,
                cod_clinica            text,
                tipo_examen            text,
                fecha_examen           date,
                muestra                text,
                color_examen           text,
                aspecto                text,
                sangre_visible         text,
                resultado_thevenon     text,
                user_registro          text,
                usuario_firma          text,
                especialista_certifica text,
                fecha_registro         date,
                user_actualizacion     text,
                fecha_actualizacion    timestamp without time zone,
                color                  integer,
                nombre_sede            text,
                sede                   text,
                namejasper             text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               CAST(d.nombres_pa AS TEXT),
               CAST(d.apellidos_pa AS TEXT),
               CAST(d.direccion_pa AS TEXT),
               CAST(d.sexo_pa AS TEXT),
               d.cod_pa,
               d.fecha_nacimiento_pa,
               CAST(d.ocupacion_pa AS TEXT),
               CAST(d.lugar_nac_pa AS TEXT),
               CAST(d.nivel_est_pa AS TEXT),
               CAST(d.estado_civil_pa AS TEXT),
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               n.n_orden,
               CAST(n.razon_empresa AS TEXT),
               CAST(n.cargo_de AS TEXT),
               CAST(n.area_o AS TEXT),
               CAST(n.razon_contrata AS TEXT),
               n.fecha_apertura_po,
               CAST(n.cod_clinica AS TEXT),
               CAST(n.nom_examen AS TEXT),
               t.fecha_examen,
               t.muestra,
               t.color,
               t.aspecto,
               t.sangre_visible,
               t.resultado_thevenon,
               t.user_registro,
               t.usuario_firma,
               CAST(u.nombre_user || ' ' || u.apellido_user AS TEXT),
               CAST(t.fecha_registro AS DATE),
               t.user_actualizacion,
               t.fecha_actualizacion,
               n.color,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1),
               CAST(sm.descripcion AS TEXT),
               obtener_name_jasper(p_norden, name_service)
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN thevenon t ON t.n_orden = n.n_orden
                 LEFT JOIN usuarios u ON UPPER(TRIM(t.user_registro)) = UPPER(TRIM(u.usuario_user))
        WHERE n.n_orden = p_norden;
END;
$$;

-- Vih

create function obtener_reporte_vih(p_norden integer, name_service text)
    returns TABLE
            (
                cod_pa                 integer,
                nombres_pa             text,
                apellidos_pa           text,
                direccion_pa           text,
                sexo_pa                text,
                dni_pa                 integer,
                fecha_nacimiento_pa    date,
                ocupacion_pa           text,
                lugar_nac_pa           text,
                nivel_est_pa           text,
                estado_civil_pa        text,
                edad_pa                text,
                n_orden                integer,
                razon_empresa          text,
                cargo_de               text,
                area_o                 text,
                razon_contrata         text,
                fecha_apertura_po      date,
                cod_clinica            text,
                tipo_examen            text,
                fecha_examen           date,
                muestra                text,
                vih                    text,
                user_registro          text,
                usuario_firma          text,
                especialista_certifica text,
                fecha_registro         date,
                user_actualizacion     text,
                fecha_actualizacion    timestamp without time zone,
                color                  integer,
                nombre_sede            text,
                sede                   text,
                namejasper             text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               CAST(d.nombres_pa AS TEXT),
               CAST(d.apellidos_pa AS TEXT),
               CAST(d.direccion_pa AS TEXT),
               CAST(d.sexo_pa AS TEXT),
               d.cod_pa,
               d.fecha_nacimiento_pa,
               CAST(d.ocupacion_pa AS TEXT),
               CAST(d.lugar_nac_pa AS TEXT),
               CAST(d.nivel_est_pa AS TEXT),
               CAST(d.estado_civil_pa AS TEXT),
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               n.n_orden,
               CAST(n.razon_empresa AS TEXT),
               CAST(n.cargo_de AS TEXT),
               CAST(n.area_o AS TEXT),
               CAST(n.razon_contrata AS TEXT),
               n.fecha_apertura_po,
               CAST(n.cod_clinica AS TEXT),
               CAST(n.nom_examen AS TEXT),
               v.fecha_examen,
               v.muestra,
               v.vih,
               v.user_registro,
               v.usuario_firma,
               CAST(u.nombre_user || ' ' || u.apellido_user AS TEXT),
               CAST(v.fecha_registro AS DATE),
               v.user_actualizacion,
               v.fecha_actualizacion,
               n.color,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1),
               CAST(sm.descripcion AS TEXT),
               obtener_name_jasper(p_norden, name_service)
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN vih v ON v.n_orden = n.n_orden
                 LEFT JOIN usuarios u ON UPPER(TRIM(v.user_registro)) = UPPER(TRIM(u.usuario_user))
        WHERE n.n_orden = p_norden;
END;
$$;

-- Inmunologia Vdrl
CREATE
    OR REPLACE FUNCTION obtener_reporte_inmunologia_vdrl(p_norden integer, name_service text)
    RETURNS TABLE
            (
                cod_pa              integer,
                nombres_pa          text,
                apellidos_pa        text,
                direccion_pa        text,
                sexo_pa             text,
                dni_pa              integer,
                fecha_nacimiento_pa date,
                ocupacion_pa        text,
                lugar_nac_pa        text,
                nivel_est_pa        text,
                estado_civil_pa     text,
                edadpaciente        text,
                n_orden             integer,
                razon_empresa       text,
                cargo_de            text,
                area_o              text,
                razon_contrata      text,
                fecha_apertura_po   date,
                cod_clinica         text,
                tipo_examen         text,
                fecha_examen        date,
                muestra             text,
                examen              text,
                metodo              text,
                vdrl                text,
                user_registro       text,
                usuario_firma       text,
                fecha_registro      date,
                user_actualizacion  text,
                fecha_actualizacion timestamp,
                color               integer,
                nombre_sede         text,
                sede                text,
                namejasper          text
            )
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               CAST(d.nombres_pa AS TEXT),
               CAST(d.apellidos_pa AS TEXT),
               CAST(d.direccion_pa AS TEXT),
               CAST(d.sexo_pa AS TEXT),
               d.cod_pa,
               d.fecha_nacimiento_pa,
               CAST(d.ocupacion_pa AS TEXT),
               CAST(d.lugar_nac_pa AS TEXT),
               CAST(d.nivel_est_pa AS TEXT),
               CAST(d.estado_civil_pa AS TEXT),
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT), -- edadpaciente


               n.n_orden,
               CAST(n.razon_empresa AS TEXT),
               CAST(n.cargo_de AS TEXT),
               CAST(n.area_o AS TEXT),
               CAST(n.razon_contrata AS TEXT),
               n.fecha_apertura_po,
               CAST(n.cod_clinica AS TEXT),
               CAST(n.nom_examen AS TEXT),

               v.fecha_examen,
               v.muestra,
               v.examen,
               v.metodo,
               v.vdrl,


               v.user_registro,
               v.usuario_firma,
               CAST(v.fecha_registro AS DATE),
               v.user_actualizacion,
               v.fecha_actualizacion,


               n.color,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1),
               CAST(sm.descripcion AS TEXT),                                    -- sede (ciudad)
               obtener_name_jasper(p_norden, name_service)

        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN inmunologia_vdrl v ON v.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Trastorno de personalidad
create function obtener_reporte_informe_trastorno_personalidad(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente               integer,
                nombrespaciente           text,
                apellidospaciente         text,
                direccionpaciente         text,
                sexopaciente              "char",
                fechanacimientopaciente   date,
                ocupacionpaciente         text,
                lugarnacimientopaciente   text,
                nivelestudiopaciente      text,
                estadocivilpaciente       text,
                cargopaciente             text,
                areapaciente              text,
                contrata                  text,
                norden                    integer,
                empresa                   text,
                codigoclinica             text,
                tipoexamen                text,
                edadpaciente              text,
                paranoide_bajo            boolean,
                paranoide_medio           boolean,
                paranoide_alto            boolean,
                esquizoide_bajo           boolean,
                esquizoide_medio          boolean,
                esquizoide_alto           boolean,
                esquizotipico_bajo        boolean,
                esquizotipico_medio       boolean,
                esquizotipico_alto        boolean,
                histrionico_bajo          boolean,
                histrionico_medio         boolean,
                histrionico_alto          boolean,
                antisocial_bajo           boolean,
                antisocial_medio          boolean,
                antisocial_alto           boolean,
                narcicista_bajo           boolean,
                narcicista_medio          boolean,
                narcicista_alto           boolean,
                impulsivo_bajo            boolean,
                impulsivo_medio           boolean,
                impulsivo_alto            boolean,
                limite_bajo               boolean,
                limite_medio              boolean,
                limite_alto               boolean,
                anancastico_bajo          boolean,
                anancastico_medio         boolean,
                anancastico_alto          boolean,
                dependiente_bajo          boolean,
                dependiente_medio         boolean,
                dependiente_alto          boolean,
                ansioso_bajo              boolean,
                ansioso_medio             boolean,
                ansioso_alto              boolean,
                observaciones             text,
                recomendacion             text,
                apto                      boolean,
                noapto                    boolean,
                interpretacion_parainoide text,
                usuario_firma             text,
                user_registro             text,
                fecha_registro            date,
                nombrespede               text,
                sede                      text,
                color                     integer,
                namejasper                text
            )
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
               n.cod_clinica,
               n.nom_examen,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),

               tp.grup_a_paranoide_bajo,
               tp.grup_a_paranoide_medio,
               tp.grup_a_paranoide_alto,

               tp.grup_a_esquizoide_bajo,
               tp.grup_a_esquizoide_medio,
               tp.grup_a_esquizoide_alto,

               tp.grup_a_esquizotipico_bajo,
               tp.grup_a_esquizotipico_medio,
               tp.grup_a_esquizotipico_alto,

               tp.grup_b_histrionico_bajo,
               tp.grup_b_histrionico_medio,
               tp.grup_b_histrionico_alto,

               tp.grup_b_antisocial_bajo,
               tp.grup_b_antisocial_medio,
               tp.grup_b_antisocial_alto,

               tp.grup_b_narcicista_bajo,
               tp.grup_b_narcicista_medio,
               tp.grup_b_narcicista_alto,

               tp.grup_b_inesta_emoci_subtip_impul_bajo,
               tp.grup_b_inesta_emoci_subtip_impul_medio,
               tp.grup_b_inesta_emoci_subtip_impul_alto,

               tp.grup_b_emoci_subtip_lim_bajo,
               tp.grup_b_emoci_subtip_lim_medio,
               tp.grup_b_emoci_subtip_lim_alto,

               tp.grup_c_anancastico_bajo,
               tp.grup_c_anancastico_medio,
               tp.grup_c_anancastico_alto,

               tp.grup_c_dependiente_bajo,
               tp.grup_c_dependiente_medio,
               tp.grup_c_dependiente_alto,

               tp.grup_c_ansioso_bajo,
               tp.grup_c_ansioso_medio,
               tp.grup_c_ansioso_alto,

               tp.analisis_resulta,
               tp.recomendacion,
               tp.perf_cumple,
               tp.perf_no_cumple,

               tp.interpretacion_parainoide,
               tp.usuario_firma,
               tp.user_registro,  -- <--- SELECCIONADO DE LA TABLA
               tp.fecha_registro, -- <--- SELECCIONADO DE LA TABLA

               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                       THEN 'Huamachuco'
                   ELSE (SELECT s.nombre_sede
                         FROM sede s
                         WHERE s.cod_sede = n.cod_sede)
                   END,

               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                       THEN 'Huamachuco'
                   ELSE CAST(sm.descripcion AS TEXT)
                   END,

               n.color,
               obtener_name_jasper(p_norden, name_service)

        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN trastornos_personalidad tp ON tp.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Informa de conductores
create function obtener_reporte_informe_conductores(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente                 integer,
                nombrespaciente             text,
                apellidospaciente           text,
                direccionpaciente           text,
                sexopaciente                "char",
                fechanacimientopaciente     date,
                ocupacionpaciente           text,
                lugarnacimientopaciente     text,
                nivelestudiopaciente        text,
                estadocivilpaciente         text,
                cargopaciente               text,
                areapaciente                text,
                contrata                    text,
                norden                      integer,
                empresa                     text,
                codigoclinica               text,
                tipoexamen                  text,
                edadpaciente                text,
                crit_atencion               text,
                crit_concetracion           text,
                crit_segurid_control_conduc text,
                anali_foda_forta_oport      text,
                anali_foda_amenaz_debili    text,
                observacion                 text,
                recomendacion               text,
                perf_cumple                 boolean,
                perf_no_cumple              boolean,
                user_registro               text,
                fecha_registro              date,
                usuario_firma               text,
                nombresede                  text,
                sede                        text,
                color                       integer,
                namejasper                  text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            -- ===== PACIENTE =====
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

            -- ===== LABORALES =====
            n.cargo_de,
            n.area_o,
            n.razon_contrata,
            n.n_orden,
            n.razon_empresa,
            n.cod_clinica,
            n.nom_examen,
            CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),

            -- ===== INFORME CONDUCTORES =====
            ic.crit_atencion,
            ic.crit_concetracion,
            ic.crit_segurid_control_conduc,
            ic.anali_foda_forta_oport,
            ic.anali_foda_amenaz_debili,
            ic.observacion,
            ic.recomendacion,
            ic.perf_cumple,
            ic.perf_no_cumple,
            ic.user_registro,
            ic.fecha_registro, -- <--- SELECCIONADO DE LA TABLA infor_conductores
            ic.usuario_firma,

            -- ===== SEDE / JASPER =====
            CASE
                WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                    THEN 'Huamachuco'
                ELSE (SELECT nombre_sede FROM sede WHERE cod_sede = n.cod_sede)
                END AS nombresede,

            CASE
                WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                    THEN 'Huamachuco'
                ELSE (CAST(sm.descripcion AS TEXT))
                END AS sede,

            n.color,
            obtener_name_jasper(p_norden, name_service)

        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm
                            ON n.cod_sede = sm.id
                 INNER JOIN infor_conductores ic
                            ON ic.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Alto riesgo

create function obtener_reporte_alto_riesgo(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente                 integer,
                nombrespaciente             text,
                apellidospaciente           text,
                direccionpaciente           text,
                sexopaciente                "char",
                fechanacimientopaciente     date,
                ocupacionpaciente           text,
                lugarnacimientopaciente     text,
                nivelestudiopaciente        text,
                estadocivilpaciente         text,
                cargopaciente               text,
                areapaciente                text,
                contrata                    text,
                norden                      integer,
                empresa                     text,
                codigoclinica               text,
                tipoexamen                  text,
                edadpaciente                text,
                crit_temor_riesgo_electrico text,
                crit_temor_alturas_izaje    text,
                crit_temor_espac_confi      text,
                anali_foda_forta_oport      text,
                anali_foda_amenaz_debili    text,
                observaciones               text,
                recomendaciones             text,
                perf_cumple                 boolean,
                perf_no_cumple              boolean,
                user_registro               text,
                fecha_registro              date,
                usuario_firma               text,
                nombresede                  text,
                sede                        text,
                color                       integer,
                namejasper                  text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            -- ===== DATOS DEL PACIENTE (Desde datos_paciente) =====
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

            -- ===== DATOS LABORALES (Desde n_orden_ocupacional) =====
            n.cargo_de,
            n.area_o,
            n.razon_contrata,
            n.n_orden,
            n.razon_empresa,
            n.cod_clinica,
            n.nom_examen,
            CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),

            -- ===== DATOS DE ALTO RIESGO (Desde alto_riesgo) =====
            ar.crit_temor_riesgo_electrico,
            ar.crit_temor_alturas_izaje,
            ar.crit_temor_espac_confi,
            ar.anali_foda_forta_oport,
            ar.anali_foda_amenaz_debili,
            ar.observaciones,
            ar.recomendaciones,
            ar.perf_cumple,
            ar.perf_no_cumple,
            ar.user_registro,
            ar.fecha_registro, -- <--- SELECCIONADO DE LA TABLA alto_riesgo
            ar.usuario_firma,

            -- ===== LÓGICA DE SEDE Y JASPER =====
            CASE
                WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                    THEN 'Huamachuco'
                ELSE (SELECT nombre_sede FROM sede WHERE cod_sede = n.cod_sede)
                END AS nombresede,

            CASE
                WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                    THEN 'Huamachuco'
                ELSE (CAST(sm.descripcion AS TEXT))
                END AS sede,

            n.color,
            obtener_name_jasper(p_norden, name_service)

        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN alto_riesgo ar ON ar.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Trabajos especificos
create function obtener_reporte_trabajos_especificos(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente                    integer,
                nombrespaciente                text,
                apellidospaciente              text,
                direccionpaciente              text,
                sexopaciente                   "char",
                fechanacimientopaciente        date,
                ocupacionpaciente              text,
                lugarnacimientopaciente        text,
                nivelestudiopaciente           text,
                estadocivilpaciente            text,
                cargopaciente                  text,
                areapaciente                   text,
                contrata                       text,
                norden                         integer,
                empresa                        text,
                codigoclinica                  text,
                tipoexamen                     text,
                edadpaciente                   text,
                criterio_nivel_alert_riesgo    text,
                criterio_nivel_psicomotrocidad text,
                analisis_foda_forta_oport      text,
                analisis_foda_amenaz_debili    text,
                observaciones                  text,
                recomendaciones                text,
                perf_cumple                    boolean,
                perf_no_cumple                 boolean,
                user_registro                  text,
                fecha_registro                 date,
                usuario_firma                  text,
                nombresede                     text,
                sede                           text,
                color                          integer,
                namejasper                     text
            )
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
               n.cod_clinica,
               n.nom_examen,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               e.criterio_nivel_alert_riesgo,
               e.criterio_nivel_psicomotrocidad,
               e.analisis_foda_forta_oport,
               e.analisis_foda_amenaz_debili,
               e.observaciones,
               e.recomendaciones,
               e.perf_cumple,
               e.perf_no_cumple,
               e.user_registro,
               e.fecha_registro, -- <--- SELECCIONADO DE LA TABLA especificos
               e.usuario_firma,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede) AS nombresede,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede) AS sede,
               n.color,
               obtener_name_jasper(p_norden, name_service)
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n ON d.cod_pa = n.cod_pa
                 INNER JOIN especificos AS e ON e.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;


-- Cuestionario Berlin

create function obtener_reporte_cuestionario_berlin(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente                      integer,
                nombrespaciente                  text,
                apellidospaciente                text,
                direccionpaciente                text,
                sexopaciente                     "char",
                fechanacimientopaciente          date,
                ocupacionpaciente                text,
                lugarnacimientopaciente          text,
                nivelestudiopaciente             text,
                estadocivilpaciente              text,
                cargopaciente                    text,
                areapaciente                     text,
                contrata                         text,
                norden                           integer,
                empresa                          text,
                codigoclinica                    text,
                tipoexamen                       text,
                edadpaciente                     text,
                criterio_apnea_obstructiva_sueno text,
                criterio_fatiga_somnolencia      text,
                criterio_hipertension_arterial   text,
                analisis_foda_forta_oport        text,
                analisis_foda_amenaz_debili      text,
                observaciones                    text,
                recomendaciones                  text,
                perf_cumple                      boolean,
                perf_no_cumple                   boolean,
                usuario_firma                    text,
                user_registro                    text,
                fecha_registro                   date,
                nombresede                       text,
                sede                             text,
                color                            integer,
                namejasper                       text
            )
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
               n.cod_clinica,
               n.nom_examen,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               -- Datos de la tabla cuestionario_berlin
               cb.criterio_apnea_obstructiva_sueño,
               cb.criterio_fatiga_somnolencia,
               cb.criterio_hipertension_arterial,
               cb.analisis_foda_forta_oport,
               cb.analisis_foda_amenaz_debili,
               cb.observaciones,
               cb.recomendaciones,
               cb.perf_cumple,
               cb.perf_no_cumple,
               cb.usuario_firma,
               cb.user_registro,
               cb.fecha_registro,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   ELSE (SELECT nombre_sede FROM sede WHERE cod_sede = n.cod_sede)
                   END AS nombre_sede,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   ELSE (CAST(sm.descripcion AS TEXT))
                   END AS sede,
               n.color,
               obtener_name_jasper(p_norden, name_service)
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal AS sm ON n.cod_sede = sm.id
                 INNER JOIN cuestionario_berlin AS cb ON cb.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Examenes complementarios

create function obtener_reporte_examen_complementario(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente             integer,
                nombrespaciente         text,
                apellidospaciente       text,
                direccionpaciente       text,
                sexopaciente            "char",
                fechanacimientopaciente date,
                ocupacionpaciente       text,
                lugarnacimientopaciente text,
                nivelestudiopaciente    text,
                estadocivilpaciente     text,
                edadpaciente            text,
                norden                  integer,
                empresa                 text,
                cargopaciente           text,
                areapaciente            text,
                contrata                text,
                codigoclinica           text,
                tipoexamen              text,
                fecha_apertura_po       date,
                level_autoconciencia    text,
                level_autoconfianza     text,
                level_autorregula       text,
                level_motiva            text,
                level_empatia           text,
                level_compt_social      text,
                foda_for_opor           text,
                foda_amen_debi          text,
                observacion             text,
                recomenda               text,
                cumple_perfil           boolean,
                user_registro           text,
                fecha_registro          date,
                usuario_firma           text,
                nombresede              text,
                sede                    text,
                color                   integer,
                namejasper              text
            )
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
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               n.n_orden,
               n.razon_empresa,
               n.cargo_de,
               n.area_o,
               n.razon_contrata,
               n.cod_clinica,
               n.nom_examen,
               n.fecha_apertura_po,
               -- Datos de la tabla de examen complementario (ip)
               ip.level_autoconciencia,
               ip.level_autoconfianza,
               ip.level_autorregula,
               ip.level_motiva,
               ip.level_empatia,
               ip.level_compt_social,
               ip.foda_for_opor,
               ip.foda_amen_debi,
               ip.observacion,
               ip.recomenda,
               ip.cumple_perfil,
               ip.user_registro,
               ip.fecha_registro,
               ip.usuario_firma,
               -- Sede y Jasper (Alias corregidos para coincidir con el RETURNS TABLE)
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede)::text AS nombresede,
               (SELECT CAST(sm.descripcion AS TEXT)
                FROM sede_multisucursal sm
                WHERE sm.id = n.cod_sede)                                             AS sede,
               n.color,
               obtener_name_jasper(p_norden, name_service)::text                      AS namejasper -- Alias explícito
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n ON d.cod_pa = n.cod_pa
                 INNER JOIN exam_complementarios AS ip ON ip.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;


-- Brigadistas

create function obtener_reporte_brigadistas(p_norden integer, name_service text)
    returns TABLE
            (
                cod_pa              integer,
                nombre              text,
                apellidos_pa        text,
                direccion_pa        text,
                sexo_pa             "char",
                fecha_nacimiento_pa date,
                fec_nac             text,
                lugar_nac_pa        text,
                estado_civil_pa     text,
                ocupacion_pa        text,
                n_orden             integer,
                razon_empresa       text,
                razon_contrata      text,
                cargo_de            text,
                area_o              text,
                nivel_est_pa        text,
                tipo_examen         text,
                fecha_apertura_po   date,
                afron_tdd           text,
                estilo_conflicto    text,
                afron_sit_riesgo    text,
                level_ansiedad      text,
                foda_for_opor       text,
                foda_amen_debi      text,
                observacion         text,
                recomenda           text,
                cumple_perfil       boolean,
                user_registro       text,
                fecha_registro      date,
                usuario_firma       text,
                color               integer,
                nombre_sede         text,
                sede                text,
                namejasper          text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               d.nombres_pa::text                                                                        AS nombre,
               d.apellidos_pa,
               d.direccion_pa,
               d.sexo_pa,
               d.fecha_nacimiento_pa,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT)                           AS fec_nac,
               d.lugar_nac_pa,
               d.estado_civil_pa,
               d.ocupacion_pa,
               n.n_orden,
               n.razon_empresa,
               n.razon_contrata,
               n.cargo_de,
               n.area_o,
               d.nivel_est_pa,
               n.nom_examen,
               n.fecha_apertura_po,
               ip.afron_tdd,
               ip.estilo_conflicto,
               ip.afron_sit_riesgo,
               ip.level_ansiedad,
               ip.foda_for_opor,
               ip.foda_amen_debi,
               ip.observacion,
               ip.recomenda,
               ip.cumple_perfil,
               ip.user_registro,
               ip.fecha_registro,
               ip.usuario_firma,
               -- Sede y Jasper
               n.color,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1)::text            AS nombre_sede,
               (SELECT CAST(sm.descripcion AS TEXT) FROM sede_multisucursal sm WHERE sm.id = n.cod_sede) AS sede,
               obtener_name_jasper(p_norden, name_service)::text                                         AS namejasper
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN psi_brigadistas AS ip ON ip.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Bomba electrica

create function obtener_reporte_bomba_electrica(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente             integer,
                nombres                 text,
                apellidospaciente       text,
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
                norden                  integer,
                empresa                 text,
                codigoclinica           text,
                tipoexamen              text,
                edadpaciente            text,
                t_riesgo_electrico      text,
                t_tareas_altura         text,
                t_espacios_confinados   text,
                manejo_herramientas     text,
                foda_for_opor           text,
                foda_amen_debi          text,
                observacion             text,
                recomenda               text,
                cumple_perfil           boolean,
                user_registro           text,
                usuario_firma           text,
                fecha_registro          date,
                nombresede              text,
                sede                    text,
                color                   integer,
                namejasper              text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               d.nombres_pa::text,
               d.apellidos_pa::text,
               d.direccion_pa::text,
               d.sexo_pa,
               d.fecha_nacimiento_pa,
               d.ocupacion_pa::text,
               d.lugar_nac_pa::text,
               d.nivel_est_pa::text,
               d.estado_civil_pa::text,
               n.cargo_de::text,
               n.area_o::text,
               n.razon_contrata::text,
               n.n_orden,
               n.razon_empresa::text,
               n.cod_clinica::text,
               n.nom_examen::text,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               -- Resultados
               b.t_riesgo_electrico,
               b.t_tareas_altura,
               b.t_espacios_confinados,
               b.manejo_herramientas,
               b.foda_for_opor,
               b.foda_amen_debi,
               b.observacion,
               b.recomenda,
               b.cumple_perfil,
               -- Auditoría
               b.user_registro,
               b.usuario_firma,
               b.fecha_registro,
               -- Lógica de Sede
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   ELSE (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede) END,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   ELSE CAST(sm.descripcion AS TEXT) END,
               n.color,
               obtener_name_jasper(p_norden, name_service) ::text
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal AS sm ON n.cod_sede = sm.id
                 INNER JOIN bombaelectrica AS b ON b.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;


-- Vigia

create function obtener_reporte_cuadrador_vigia(p_norden integer, name_service text)
    returns TABLE
            (
                cod_pa                integer,
                dni                   integer,
                nombre                text,
                sexo                  text,
                fecha_nacimiento_pa   date,
                lugar_nac_pa          text,
                estado_civil_pa       text,
                nivel_est_pa          text,
                edad                  text,
                ocupacion_pa          text,
                n_orden               integer,
                tipo_examen           text,
                razon_empresa         text,
                razon_contrata        text,
                cargo_de              text,
                area_o                text,
                fecha_apertura_po     date,
                t_riesgo_electrico    text,
                t_tareas_altura       text,
                t_espacios_confinados text,
                manejo_herramientas   text,
                foda_for_opor         text,
                foda_amen_debi        text,
                observacion           text,
                recomenda             text,
                cumple_perfil         boolean,
                user_registro         text,
                usuario_firma         text,
                fecha_registro        date,
                color                 integer,
                nombre_sede           text,
                sede                  text,
                namejasper            text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               d.cod_pa                                                        as dni,
               (d.nombres_pa || ' ' || d.apellidos_pa)::text,
               d.sexo_pa::text,
               d.fecha_nacimiento_pa,
               d.lugar_nac_pa::text,
               d.estado_civil_pa::text,
               d.nivel_est_pa::text,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT) as edad,
               d.ocupacion_pa::text,
               n.n_orden,
               n.nom_examen::text,
               n.razon_empresa,
               n.razon_contrata::text,
               n.cargo_de,
               n.area_o::text,
               n.fecha_apertura_po,
               ip.t_riesgo_electrico,
               ip.t_tareas_altura,
               ip.t_espacios_confinados,
               ip.manejo_herramientas,
               ip.foda_for_opor,
               ip.foda_amen_debi,
               ip.observacion,
               ip.recomenda,
               ip.cumple_perfil,
               ip.user_registro,
               ip.usuario_firma,
               ip.fecha_registro,
               n.color,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede)::text,
               (SELECT CAST(sm.descripcion AS TEXT)
                FROM sede_multisucursal sm
                WHERE sm.id = n.cod_sede),
               obtener_name_jasper(p_norden, name_service) ::text
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
                 INNER JOIN cuadradorvigia ip ON ip.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;


-- Fobias


create function obtener_reporte_fobias(p_norden integer, name_service text)
    returns TABLE
            (
                cod_pa                      integer,
                nombres_pa                  text,
                apellidos_pa                text,
                direccion_pa                text,
                sexo_pa                     text,
                fecha_nacimiento_pa         date,
                ocupacion_pa                text,
                lugar_nac_pa                text,
                nivel_est_pa                text,
                estado_civil_pa             text,
                fec_nac                     text,
                n_orden                     integer,
                razon_empresa               text,
                cargo_de                    text,
                area_o                      text,
                razon_contrata              text,
                fecha_apertura_po           date,
                cod_clinica                 text,
                tipo_examen                 text,
                criterio_inteligencia       text,
                criterio_fobias             text,
                analisis_foda_forta_oport   text,
                analisis_foda_amenaz_debili text,
                observaciones               text,
                recomendaciones             text,
                conclusiones_apto           boolean,
                conclusiones_no_apto        boolean,
                usuario_firma               text,
                fecha_registro              date,
                color                       integer,
                nombre_sede                 text,
                sede                        text,
                namejasper                  text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               d.nombres_pa::text,
               d.apellidos_pa::text,
               d.direccion_pa::text,
               d.sexo_pa::text,
               d.fecha_nacimiento_pa,
               d.ocupacion_pa::text,
               d.lugar_nac_pa::text,
               d.nivel_est_pa::text,
               d.estado_civil_pa::text,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               n.n_orden,
               n.razon_empresa::text,
               n.cargo_de::text,
               n.area_o::text,
               n.razon_contrata::text,
               n.fecha_apertura_po,
               n.n_orden::text    AS cod_clinica,
               n.nom_examen::text AS tipo_examen,
               f.criterio_inteligencia,
               f.criterio_fobias,
               f.analisis_foda_forta_oport,
               f.analisis_foda_amenaz_debili,
               f.observaciones,
               f.recomendaciones,
               f.conclusiones_apto,
               f.conclusiones_no_apto,
               f.usuario_firma,
               f.fecha_registro,
               n.color,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede)::text,
               (SELECT CAST(sm.descripcion AS TEXT)
                FROM sede_multisucursal sm
                WHERE sm.id = n.cod_sede),
               obtener_name_jasper(p_norden, name_service) ::text
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
                 INNER JOIN fobias f ON f.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Aversion al riesgo

create function obtener_reporte_aversion_riesgo(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente                               integer,
                nombres                                   text,
                apellidospaciente                         text,
                direccionpaciente                         text,
                sexopaciente                              "char",
                fechanacimientopaciente                   date,
                edadpaciente                              text,
                lugar_nac_pa                              text,
                estado_civil_pa                           text,
                nivel_est_pa                              text,
                ocupacion_pa                              text,
                norden                                    integer,
                empresa                                   text,
                contrata                                  text,
                cargopaciente                             text,
                areapaciente                              text,
                tipo_examen                               text,
                fecha_apertura_po                         date,
                asp_intel_pract_func_bajo                 boolean,
                asp_intel_pract_func_medio                boolean,
                asp_intel_pract_func_alto                 boolean,
                asp_intel_recur_bajo                      boolean,
                asp_intel_recur_medio                     boolean,
                asp_intel_recur_alto                      boolean,
                asp_intel_atenci_conc_bajo                boolean,
                asp_intel_atenci_conc_medio               boolean,
                asp_intel_atenci_conc_alto                boolean,
                asp_emoc_estabil_emoc_mad_bajo            boolean,
                asp_emoc_estabil_emoc_mad_medio           boolean,
                asp_emoc_estabil_emoc_mad_alto            boolean,
                asp_flexib_manj_emoc_bajo                 boolean,
                asp_flexib_manj_emoc_medio                boolean,
                asp_flexib_manj_emoc_alto                 boolean,
                asp_ctrl_impul_bajo                       boolean,
                asp_ctrl_impul_medio                      boolean,
                asp_ctrl_impul_alto                       boolean,
                comp_especf_cap_subor_bajo                boolean,
                comp_especf_cap_subor_medio               boolean,
                comp_especf_cap_subor_alto                boolean,
                comp_especf_adec_nor_proced_bajo          boolean,
                comp_especf_adec_nor_proced_medio         boolean,
                comp_especf_adec_nor_proced_alto          boolean,
                comp_especf_considera_terceros_bajo       boolean,
                comp_especf_considera_terceros_medio      boolean,
                comp_especf_considera_terceros_alto       boolean,
                comp_especf_autonomia_trabajar_bajo       boolean,
                comp_especf_autonomia_trabajar_medio      boolean,
                comp_especf_autonomia_trabajar_alto       boolean,
                comp_especf_proactividad_bajo             boolean,
                comp_especf_proactividad_medio            boolean,
                comp_especf_proactividad_alto             boolean,
                comp_especf_cap_trabjo_bajo_presion_bajo  boolean,
                comp_especf_cap_trabjo_bajo_presion_medio boolean,
                comp_especf_cap_trabjo_bajo_presion_alto  boolean,
                comp_especf_cap_evaluar_riesgos_bajo      boolean,
                comp_especf_cap_evaluar_riesgos_medio     boolean,
                comp_especf_cap_evaluar_riesgos_alto      boolean,
                comp_especf_mot_por_car_bajo              boolean,
                comp_especf_mot_por_car_medio             boolean,
                comp_especf_mot_por_car_alto              boolean,
                analisis_resultados                       text,
                recomenda                                 text,
                conclusiones_cumple                       boolean,
                user_registro                             text,
                usuario_firma                             text,
                fecha_registro                            date,
                nombrespede                               text,
                sede                                      text,
                color                                     integer,
                namejasper                                text
            )
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
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               d.lugar_nac_pa,
               d.estado_civil_pa,
               d.nivel_est_pa,
               d.ocupacion_pa,
               n.n_orden,
               n.razon_empresa,
               n.razon_contrata,
               n.cargo_de,
               n.area_o,
               n.nom_examen,
               n.fecha_apertura_po,
               ar.asp_Intel_Pract_Func_bajo,
               ar.asp_Intel_Pract_Func_medio,
               ar.asp_Intel_Pract_Func_alto,
               ar.asp_Intel_Recur_bajo,
               ar.asp_Intel_Recur_medio,
               ar.asp_Intel_Recur_alto,
               ar.asp_Intel_atenci_conc_bajo,
               ar.asp_Intel_atenci_conc_medio,
               ar.asp_Intel_atenci_conc_alto,
               ar.asp_emoc_estabil_emoc_mad_bajo,
               ar.asp_emoc_estabil_emoc_mad_medio,
               ar.asp_emoc_estabil_emoc_mad_alto,
               ar.asp_Flexib_manj_emoc_bajo,
               ar.asp_Flexib_manj_emoc_medio,
               ar.asp_Flexib_manj_emoc_alto,
               ar.asp_ctrl_impul_bajo,
               ar.asp_ctrl_impul_medio,
               ar.asp_ctrl_impul_alto,
               ar.comp_especf_cap_subor_bajo,
               ar.comp_especf_cap_subor_medio,
               ar.comp_especf_cap_subor_alto,
               ar.comp_especf_Adec_nor_proced_bajo,
               ar.comp_especf_Adec_nor_proced_medio,
               ar.comp_especf_Adec_nor_proced_alto,
               ar.comp_especf_Considera_terceros_bajo,
               ar.comp_especf_Considera_terceros_medio,
               ar.comp_especf_Considera_terceros_alto,
               ar.comp_especf_Autonomia_trabajar_bajo,
               ar.comp_especf_Autonomia_trabajar_medio,
               ar.comp_especf_Autonomia_trabajar_alto,
               ar.comp_especf_proactividad_bajo,
               ar.comp_especf_proactividad_medio,
               ar.comp_especf_proactividad_alto,
               ar.comp_especf_Cap_trabjo_bajo_presion_bajo,
               ar.comp_especf_Cap_trabjo_bajo_presion_medio,
               ar.comp_especf_Cap_trabjo_bajo_presion_alto,
               ar.comp_especf_Cap_Evaluar_riesgos_bajo,
               ar.comp_especf_Cap_Evaluar_riesgos_medio,
               ar.comp_especf_Cap_Evaluar_riesgos_alto,
               ar.comp_especf_Mot_por_car_bajo,
               ar.comp_especf_Mot_por_car_medio,
               ar.comp_especf_Mot_por_car_alto,
               ar.analisis_resultados,
               ar.recomendaciones,
               ar.conclusiones_cumple,
               ar.user_registro,
               ar.usuario_firma,
               ar.fecha_registro,
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1),
               CAST(sm.descripcion AS TEXT),
               n.color,
               obtener_name_jasper(p_norden, name_service)
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN aversionalriesgo ar ON ar.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Riesgo coronario

create function obtener_reporte_riesgo_coronario(p_norden integer, name_service text)
    returns TABLE
            (
                cod_pa                    integer,
                nombres_pa                text,
                apellidos_pa              text,
                direccion_pa              text,
                sexo_pa                   text,
                fecha_nacimiento_pa       date,
                ocupacion_pa              text,
                lugar_nac_pa              text,
                nivel_est_pa              text,
                estado_civil_pa           text,
                fec_nac                   text,
                n_orden                   integer,
                razon_empresa             text,
                cargo_de                  text,
                area_o                    text,
                razon_contrata            text,
                fecha_apertura_po         date,
                cod_clinica               text,
                tipo_examen               text,
                fecha_examen              date,
                muestra                   text,
                resultado_riesgocoronario integer,
                user_registro             text,
                usuario_firma             text,
                fecha_registro            timestamp without time zone,
                color                     integer,
                nombre_sede               text,
                sede                      text,
                namejasper                text
            )
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa,
               d.nombres_pa::text,
               d.apellidos_pa::text,
               d.direccion_pa::text,
               d.sexo_pa::text,
               d.fecha_nacimiento_pa,
               d.ocupacion_pa::text,
               d.lugar_nac_pa::text,
               d.nivel_est_pa::text,
               d.estado_civil_pa::text,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               n.n_orden,
               n.razon_empresa::text,
               n.cargo_de::text,
               n.area_o::text,
               n.razon_contrata::text,
               n.fecha_apertura_po,
               n.n_orden::text AS cod_clinica, -- Usamos n_orden como código clínica n.nom_examen::text AS tipo_examen, -- <--- CORREGIDO: nom_examen en lugar de tipo_examen r.fecha_examen, r.muestra, r.resultado_riesgocoronario, r.user_registro, r.usuario_firma, r.fecha_registro, n.color, (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede)::text, (SELECT CAST(sm.descripcion AS TEXT)
        FROM sede_multisucursal sm
        WHERE sm.id = n.cod_sede),
       obtener_name_jasper(p_norden, name_service) ::text
FROM datos_paciente d
    INNER JOIN n_orden_ocupacional n
ON d.
    cod_pa = n.cod_pa INNER JOIN riesgocoronario r ON r.n_orden = n.n_orden
              WHERE n.n_orden = p_norden;
END;
$$;

-- Glucosa tolerancia

create function obtener_reporte_glucosa_tolerancia(p_norden integer, name_service text)
    returns TABLE
            (
                dnipaciente             integer,
                nombres                 text,
                apellidospaciente       text,
                direccionpaciente       text,
                sexopaciente            "char",
                fechanacimientopaciente date,
                ocupacionpaciente       text,
                lugarnacimientopaciente text,
                nivelestudiopaciente    text,
                estadocivilpaciente     text,
                edadpaciente            text,
                norden                  integer,
                empresa                 text,
                cargopaciente           text,
                areapaciente            text,
                contrata                text,
                codigoclinica           text,
                tipoexamen              text,
                fecha_examen            date,
                muestra                 text,
                serica                  integer,
                tolera60                integer,
                tolera120               integer,
                user_registro           text,
                fecha_registro          timestamp without time zone,
                usuario_firma           text,
                nombrespede             text,
                sede                    text,
                color                   integer,
                namejasper              text
            )
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
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),

               n.n_orden,
               n.razon_empresa,
               n.cargo_de,
               n.area_o,
               n.razon_contrata,
               n.cod_clinica,
               n.nom_examen,


               gt.fecha_examen,
               gt.muestra,
               gt.serica,
               gt.tolera60,
               gt.tolera120,

               gt.user_registro,
               gt.fecha_registro,
               gt.user_actualizacion,


               (SELECT nombre_sede FROM sede WHERE cod_sede = n.cod_sede) AS nombrespede,
               CAST(sm.descripcion AS TEXT)                               AS sede,
               CAST(n.color AS INTEGER),
               obtener_name_jasper(p_norden, name_service)

        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 LEFT JOIN glucosatolerancia gt ON gt.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$$;

-- Glucosa basal
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
                user_medico_ocup         text
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
               (SELECT telefono FROM sede WHERE cod_sede = 1)::text
-- Datos adicionales n.color, d.cod_pa, d.sexo_pa, d.fecha_nacimiento_pa, d.ocupacion_pa::text, d.lugar_nac_pa::text, d.nivel_est_pa::text, d.estado_civil_pa::text, n.cargo_de::text, n.area_o::text, n.nom_examen::text, n.cod_clinica::text, CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT), n.razon_empresa::text, n.razon_contrata::text, ab.gluc_basal, ab.fecha_ab, ab.usuario_firma, ab.user_medico_ocup
        FROM analisis_bioquimicos AS ab
                 INNER JOIN n_orden_ocupacional AS n ON n.n_orden = ab.n_orden
                 INNER JOIN datos_paciente AS d ON n.cod_pa = d.cod_pa
        WHERE ab.n_orden = norden_param;
END;
$$;


CREATE
    OR REPLACE FUNCTION obtener_name_jasper(norden_param bigint, name_service_param text) RETURNS text AS
$BODY$
DECLARE
    resultado text; name_empresa_busqueda_var
              text; name_valor_microbiologia_var
              text; name_valor_hepatitisa_var
              text; name_valor_hepatitisc_var
              text; valor_coproparasitologico_var
              boolean; valor_cuantitativo_antigeno_var
              boolean; valor_formato_marsa_var
              boolean; valor_electro_cardiograma
              boolean;
BEGIN -- Obtener el nombre de la empresa de la historia clinica a registrar;

    SELECT trim(razon_empresa)
    INTO name_empresa_busqueda_var
    FROM n_orden_ocupacional
    WHERE n_orden = norden_param;
-- obtener el valor del txt en microbiologia
    SELECT trim(txtkoh)
    INTO name_valor_microbiologia_var
    FROM microbiologia
    WHERE n_orden = norden_param;
-- obtener el valor del txt en hepatitis
    SELECT trim(txthepatitisa)
    INTO name_valor_hepatitisa_var
    FROM lhepatitis
    WHERE n_orden = norden_param;

    SELECT trim(hepatitisc)
    INTO name_valor_hepatitisc_var
    FROM lhepatitis
    WHERE n_orden = norden_param;
-- obtener el valor del boolean en coproparasitologico
    SELECT tipo_coproparasitologico
    INTO valor_coproparasitologico_var
    FROM ac_coproparasitologico
    WHERE n_orden = norden_param;
-- obtener los valores de los booleanos en examen inmunologico
    SELECT cuantitativo_antigeno
         , formato_marsa
    INTO valor_cuantitativo_antigeno_var
        ,valor_formato_marsa_var
    FROM examen_inmunologico
    WHERE n_orden = norden_param;
-- obtener valor boolean del campo informe_completo de electro cardiograma
    SELECT CASE WHEN informe_completo IS NULL THEN TRUE ELSE informe_completo END AS informe_completo
    INTO valor_electro_cardiograma
    FROM informe_electrocardiograma
    WHERE n_orden = norden_param;
    IF
        name_service_param = 'con_panel10D' THEN
        resultado := 'Consentimiento_Panel10D_Digitalizado';
    ELSIF
        name_service_param = 'con_panel5D' THEN
        IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'Consentimiento_Panel5D_ohla_Digitalizado';
        ELSE
            resultado := 'Consentimiento_Panel5D_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'con_panel3D' THEN
        resultado := 'Consentimiento_Panel3D_Digitalizado';
    ELSIF
        name_service_param = 'con_panel2D' THEN
        resultado := 'Consentimiento_Panel2D_Digitalizado';
    ELSIF
        name_service_param = 'consent_Muestra_Sangre' THEN
        resultado := 'Consentimiento_Muestra_Sangre_Digitalizado';
    ELSIF
        name_service_param = 'consent_marihuana' THEN
        resultado := 'Consentimiento_Marihuana_Digitalizado';
    ELSIF
        name_service_param = 'consent_Boro' THEN
        resultado := 'Consentimiento_Boro_Digitalizado';
    ELSIF
        name_service_param = 'analisis_bioquimicos' THEN

        IF EXISTS (SELECT 1
                   FROM analisis_bioquimicos
                   WHERE n_orden = norden_param
                     AND gluc_basal IS NOT NULL) THEN
            resultado := 'Informe_Lab_Glucosa_Basal';
        ELSE
            resultado := 'AnalisisBioquimicos_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'lab_clinico' THEN
        resultado := 'LaboratorioClinico_Digitalizado';
    ELSIF
        name_service_param = 'hemograma_autom' THEN
        resultado := 'Hematologia_Digitalizado';
    ELSIF
        name_service_param = 'lgonadotropina' THEN
        resultado := 'LGonadotropina_Digitalizado';
    ELSIF
        name_service_param = 'panel2d' THEN
        resultado := 'Panel2d_Digitalizado';
    ELSIF
        name_service_param = 'panel3d' THEN
        resultado := 'Panel3d_Digitalizado';
    ELSIF
        name_service_param = 'toxicologia' THEN
        IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'ResultadosPanel5d_ohla_Digitalizado';
        ELSE
            resultado := 'ResultadosPanel5d_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'panel10d' THEN
        resultado := 'Panel10d_Digitalizado';
    ELSIF
        name_service_param = 'inmunologia' THEN
        resultado := 'InmunologiaLab_Digitalizado';
    ELSIF
        name_service_param = 'microbiologia' THEN
        IF name_valor_microbiologia_var IS NOT NULL
            AND LENGTH(name_valor_microbiologia_var) > 0 THEN
            resultado := 'Microbiologia1_Digitalizado';
        ELSE
            resultado := 'Microbiologia_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'lhepatitis' THEN
        IF name_valor_hepatitisa_var IS NOT NULL
            AND LENGTH(name_valor_hepatitisa_var) > 0 THEN
            resultado := 'LHepatitisA_Digitalizado';
        ELSIF
            name_valor_hepatitisc_var IS NOT NULL
                AND LENGTH(name_valor_hepatitisc_var) > 0 THEN
            resultado := 'LHepatitisC_Digitalizado';
        ELSE
            resultado := 'LHepatitisB_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'l_bioquimica' THEN
        resultado := 'LBioquimica_Digitalizado';
    ELSIF
        name_service_param = 'ac_bioquimica2022' THEN
        resultado := 'AnalisisClinicosB_Digitalizado';
    ELSIF
        name_service_param = 'perfil_hepatico' THEN
        resultado := 'PerfilHepatico_Digitalizado';
    ELSIF
        name_service_param = 'ac_coprocultivo' THEN
        resultado := 'coprocultivo_digitalizado';
    ELSIF
        name_service_param = 'ac_coproparasitologico' THEN
        IF valor_coproparasitologico_var = true THEN
            resultado := 'Coproparasitologico_Digitalizado';
        ELSE
            resultado := 'ParasitologiaSeriado_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'examen_inmunologico' THEN
        IF valor_cuantitativo_antigeno_var = true THEN
            resultado := 'pcuantiantigeno';
        ELSE
            IF valor_formato_marsa_var = true THEN
                resultado := 'pcualitativaantigenoMarsa';
            ELSE
                resultado := 'pcualitativaantigeno';
            END IF;
        END IF;
    ELSIF
        name_service_param = 'audiometria_2023' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'Audiometria2021-_Digitalizado_boro';
        ELSE
            resultado := 'Audiometria2021-_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'historia_oc_info' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'HistoriaOcupacional_Digitalizado_boro';
        ELSE
            resultado := 'HistoriaOcupacional_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'audiometria_po' THEN
        resultado := 'FichaAudiologica_Digitalizado';
    ELSIF
        name_service_param = 'cuestionario_audiometria' THEN
        resultado := 'CuestionarioAudiometria_Digitalizado';
    ELSIF
        name_service_param = 'oftalmologia_lo' THEN
        resultado := 'OftalmologiaLO';
    ELSIF
        name_service_param = 'oftalmologia' THEN
        resultado := 'Oftalmologia';
    ELSIF
        name_service_param = 'oftalmologia_reporte' THEN
        resultado := 'ReporteOftalmologico';
    ELSIF
        name_service_param = 'oftalmologia2021' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'EvaluacionOftalmologica2021_Digitalizado_boro';
        ELSIF
            name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'EvaluacionOftalmologica2021_Digitalizado_ohla';
        ELSE
            resultado := 'EvaluacionOftalmologica2021_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'odontograma' THEN
        resultado := 'Odontograma_Digitalizado';
    ELSIF
        name_service_param = 'odontograma_lo' THEN
        resultado := 'Odontograma_lo_Digitalizado';
    ELSIF
        name_service_param = 'radiografia_torax' THEN
        resultado := 'RagiografiaToraxPA_Digitalizado';
    ELSIF
        name_service_param = 'radiografia_fechas' THEN
        resultado := 'ReporteFechasRadiografia_Digitalizado';
    ELSIF
        name_service_param = 'radiografia' THEN
        resultado := 'RAYOSXXXOFI_Digitalizado';
    ELSIF
        name_service_param = 'oit' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'OIT_Digitalizado_boro';
        ELSE
            resultado := 'OIT_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'evaluacion_musculo_esqueletica' THEN
        resultado := 'EvaluacionMuscoloEsqueletica';
    ELSIF
        name_service_param = 'evaluacion_musculo_esqueletica2021' THEN
        resultado := 'EvaluacionMuscoloEsqueletica2021_Digitalizado_boro';
    ELSIF
        name_service_param = 'consentimientoInformado' THEN
        resultado := 'conInformadoOcupacional_Digitalizado';
    ELSIF
        name_service_param = 'cuestionario_nordico' THEN
        resultado := 'CuestionarioNordico';
    ELSIF
        name_service_param = 'consentimiento_rayosx' THEN
        resultado := 'ConsentimientoRayosX_Digitalizado';
    ELSIF
        name_service_param = 'test_fatiga_somnolencia' THEN
        resultado := 'TestFatigaSomnolenia_Digitalizado_boro';
    ELSIF
        name_service_param = 'informe_electrocardiograma' THEN
        IF valor_electro_cardiograma = TRUE THEN
            resultado := 'InformeElectrocardiograma2023';
        ELSE
            resultado := 'InformeElectrocardiograma_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'antece_enfermedades_altura' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'AnexoCB_boro_Digitalizado';
        ELSE
            resultado := 'AnexoCB_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'anexo_agroindustrial' THEN
        resultado := 'Anexo2';
    ELSIF
        name_service_param = 'consentimientobuenasalud' THEN
        resultado := 'ConsentimientoBuenaSalud2021_Digitalizado';
    ELSIF
        name_service_param = 'anexo7c' THEN
        resultado := 'Anexo7C_Boro';
    ELSIF
        name_service_param = 'anexo16a' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'Anexo16ABoro_Digitalizado';
        ELSE
            resultado := 'Anexo16A_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'antecedentes_patologicos' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'ficha_antecedente_patologico_boro';
        ELSE
            resultado := 'ficha_antecedente_patologico_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'aptitud_medico_ocupacional_agro' THEN
        resultado := 'Aptitud_Agroindustrial';
    ELSIF
        name_service_param = 'certificado_aptitud_medico_ocupacional' THEN
        IF name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'Aptitud_medico_ocupacional_11';
        ELSE
            resultado := 'Aptitud_medico_ocupacional_F';
        END IF;
    ELSIF
        name_service_param = 'ficha_sas' THEN
        resultado := 'FichaDetencionSAS_boro_Digitalizado';
    ELSIF
        name_service_param = 'certificado_aptitud_medico_resumen' THEN
        resultado := 'Aptitud_medico_resumen_Digitalizado';
    ELSIF
        name_service_param = 'b_certificado_conduccion' THEN
        resultado := 'certificaciondeconduccion_Digitalizado_boro';
    ELSIF
        name_service_param = 'ficha_interconsulta' THEN
        resultado := 'Ficha_interconsulta_Digitalizado';
    ELSIF
        name_service_param = 'b_certificado_altura' THEN
        resultado := 'Certificacion_suficiencia_trabajos_en_altura_boro_Digitalizado';
    ELSIF
        name_service_param = 'informe_psicologico' THEN
        resultado := 'InformePsicologico_Digitalizado';
    ELSIF
        name_service_param = 'b_uso_respiradores' THEN
        resultado := 'UsoRespiradores';
    ELSIF
        name_service_param = 'ficha_psicologica_anexo02' THEN
        resultado := 'InformePsicologico_Anexo02_Digitalizado';
    ELSIF
        name_service_param = 'ficha_psicologica_anexo03' THEN
        resultado := 'FichaPsicologicaOcupacional_Digitalizado';
    ELSIF
        name_service_param = 'certificado_altura_poderosa' THEN
        resultado := 'CertificadoAlturaPoderosa_Digitalizado';
    ELSIF
        name_service_param = 'hoja_consulta_externa' THEN
        resultado := 'Hoja_Consulta_Externa';
    ELSIF
        name_service_param = 'aptitud_altura_poderosa' THEN
        resultado := 'Aptitud_Poderosa_Digitalizado';
    ELSIF
        name_service_param = 'aptitud_trabajos_encaliente' THEN
        resultado := 'Aptitud_Trabajos_EnCaliente_Digitalizado';
    ELSIF
        name_service_param = 'aptitud_licencia_conduciri' THEN
        resultado := 'Aptitud_Licencia_Conducir_Interna_Digitalizado';
    ELSIF
        name_service_param = 'certificado_aptitud_herramientas_manuales' THEN
        resultado := 'Certificado_Aptitud_Herramientas_Manuales_Digitalizado';
    ELSIF
        name_service_param = 'informe_psicolaboral' THEN
        resultado := 'Informe_PsicolaboralBoroo_Digitalizado';
    ELSIF
        name_service_param = 'certificado_manipuladores_barrick' THEN
        resultado := 'CertificadoMedicoManipuladores_Barrick_Digitalizado';
    ELSIF
        name_service_param = 'informe_psicologico_estres' THEN
        resultado := 'InformePsicologicoAdecoEstres_Digitalizado';
    ELSIF
        name_service_param = 'evaluacion_psicologica_poderosa' THEN
        resultado := 'InformePsicologico_Digitalizado';
    ELSIF
        name_service_param = 'psicologia_espacios_confinados' THEN
        resultado := 'formatPsicologia_SuficienciaEspaciosC';
    ELSIF
        name_service_param = 'informe_riesgos_psicosociales' THEN
        resultado := 'Informe_Riesgos_Psicosociales_Digitalizado';
    ELSIF
        name_service_param = 'informe_burnout' THEN
        resultado := 'Informe_burnout_Digitalizado';
    ELSIF
        name_service_param = 'psicologiafobias' THEN
        resultado := 'formatPsicologia_Digitalizado';
    ELSIF
        name_service_param = 'calidad_sueño' THEN
        resultado := 'CUESTIONARIO_CALIDAD_DE_SUEÑO_Digitalizado';
    ELSIF
        name_service_param = 'trastornos_personalidad' THEN
        resultado := 'Informe_Psico_Test_Personalidad';
    ELSIF
        name_service_param = 'infor_conductores' THEN
        resultado := 'Informe_Psico_Conductores';
    ELSIF
        name_service_param = 'certificacion_medica_altura' THEN
        resultado := 'A_CertificacionMedicaPTA_Digitalizado';
    ELSIF
        name_service_param = 'alto_riesgo' THEN
        resultado := 'Informe_Psico_Alto_Riesgo';
    ELSIF
        name_service_param = 'especificos' THEN
        resultado := 'Informe_Psico_Especificos';
    ELSIF
        name_service_param = 'cuestionario_berlin' THEN
        resultado := 'Informe_Psico_Cuestionario_Berlin';
    ELSIF
        name_service_param = 'exam_complementarios' THEN
        resultado := 'Informe_Psico_Exam_Complementario';
    ELSIF
        name_service_param = 'psi_brigadistas' THEN
        resultado := 'Informe_Psico_Brigadista';
    ELSIF
        name_service_param = 'bombaelectrica' THEN
        resultado := 'Informe_Psico_BombaElectrica';
    ELSIF
        name_service_param = 'cuadradorvigia' THEN
        resultado := 'Informe_Psico_CuadradorVigia';
    ELSIF
        name_service_param = 'riesgocoronario' THEN
        resultado := 'Informe_Lab_Riesgo_Coronario';
    ELSIF
        name_service_param = 'fobias' THEN
        resultado := 'Informe_Psico_Fobias';
    ELSIF
        name_service_param = 'aversionalriesgo' THEN
        resultado := 'Informe_Psico_AversioRiesgo';
    ELSIF
        UPPER(name_service_param) = 'CONSENT_SINTOMATICO' THEN
        resultado := 'Consent_Admision_DeclaracionSintomaticoRespiratorio';
    ELSIF
        UPPER(name_service_param) = 'CONSENT_INFORMADO_MEDICA' THEN
        resultado := 'Consent_Admision_EvaluacionMedica';
    ELSIF
        UPPER(name_service_param) = 'CONSENT_RECOM_MEDIC' THEN
        resultado := 'Consent_Admision_ExamenMedicoPeru';
    ELSIF
        UPPER(name_service_param) = 'DECLA_JURA_ANTECE_PERSON_FAM' THEN
        resultado := 'Consent_Admision_DeclacionAntecePatologicos';
    ELSIF
        UPPER(name_service_param) = 'DECLA_INFO_APTITUD_MO' THEN
        resultado := 'Consent_Admision_InformacionAptitudMedicoOcupacional';
    ELSIF
        name_service_param = 'glucosatolerancia' THEN
        resultado := 'Informe_Lab_Glucosa_Tolerancia';
    ELSIF
        name_service_param = 'inmunologia_vdrl' THEN
        resultado := 'Informe_Lab_VRDL';
    ELSIF
        name_service_param = 'vih' THEN
        resultado := 'Informe_Lab_Vih';
    ELSIF
        name_service_param = 'thevenon' THEN
        resultado := 'Informe_Lab_Thevenon';
    END IF;
    RETURN resultado;
END;
$BODY$
    LANGUAGE plpgsql;


CREATE
    OR REPLACE FUNCTION obtener_reporte_anexo16(IN p_norden integer, IN name_service text)
    RETURNS TABLE
            (
                fechaanexo7c_fecha                                        date,
                telefonotrabajopaciente_tel_trabajo_pa                    text,
                telefonocasapaciente_tel_casa_pa                          text,
                celularpaciente_cel_pa                                    text,
                dni_cod_pa                                                integer,
                sexo_sexo_pa                                              "char",
                numerocontacto_num_contacto                               text,
                direccionpaciente_direccion                               text,
                fechanacimientopaciente_fecha_nacimiento_pa               date,
                lugarnacimientopaciente_lugar_nac_pa                      text,
                estadocivilpaciente_estado_civil_pa                       text,
                nivelestudiopaciente_nivel_est_pa                         text,
                cargo_cargo_de                                            text,
                fvcfuncionrespiratoria_fvc                                text,
                fev1funcionrespiratoria_fev1                              text,
                fev1fvcfuncionrespiratoria_fev1fvc                        text,
                fef2575funcionrespiratoria_fef25_75                       text,
                empresa_razon_empresa                                     text,
                explotacion_nom_ex                                        text,
                altura_altura_po                                          text,
                contrata_razon_contrata                                   text,
                norden_n_orden                                            integer,
                fechaapertura_fecha_apertura_po                           date,
                nombreexamen_nom_examen                                   text,
                mineral_mineral_po                                        text,
                nombres_nombres                                           text,
                edad_edad                                                 text,
                perimetrocuellotriaje_perimetro_cuello                    text,
                imctriaje_imc                                             text,
                pesotriaje_peso                                           text,
                tallatriaje_talla                                         text,
                cinturatriaje_cintura                                     text,
                caderatriaje_cadera                                       text,
                icctriaje_icc                                             text,
                temperaturatriaje_temperatura                             text,
                frecuenciarespiratoriatriaje_f_respiratoria               text,
                frecuenciacardiacatriaje_f_cardiaca                       text,
                saturacionoxigenotriaje_sat_02                            text,
                sistolicatriaje_sistolica                                 text,
                diastolicatriaje_diastolica                               text,
                ruidoanexo7c_chkruido                                     boolean,
                polvoanexo7c_chkpolvo                                     boolean,
                vidsegmentarioanexo7c_chkvidsegmentario                   boolean,
                vidtotalanexo7c_chkvidtotal                               boolean,
                cancerigenosanexo7c_chkcancerigenos                       boolean,
                mutagenicosanexo7c_chkmutagenicos                         boolean,
                solventesanexo7c_chksolventes                             boolean,
                metalesanexo7c_chkmetales                                 boolean,
                temperaturaanexo7c_chktemperatura                         boolean,
                biologicosanexo7c_chkbiologicos                           boolean,
                posturasanexo7c_chkposturas                               boolean,
                turnosanexo7c_chkturnos                                   boolean,
                cargasanexo7c_chkcargas                                   boolean,
                movrepetanexo7c_chkmovrepet                               boolean,
                pvdanexo7c_chkpvd                                         boolean,
                electricosanexo7c_electricos                              boolean,
                vibracionesanexo7c_vibraciones                            boolean,
                otrosanexo7c_chkotros                                     boolean,
                alturaestructuraanexo7c_altura_estructura                 boolean,
                alturageograficaanexo7c_altura_geog                       boolean,
                quimicosanexo7c_quimicos                                  boolean,
                reubicacionsianexo7c_tbrsi                                boolean,
                reubicacionnoanexo7c_rbrno                                boolean,
                puestoactualanexo7c_txtpuestoactual                       text,
                tiempoanexo7c_txttiempo                                   text,
                antecedentespersonalesanexo7c_txtantecedentespersonales   text,
                antecedentesfamiliaresanexo7c_txtantecedentesfamiliares   text,
                tetanoanexo7c_tetano                                      boolean,
                hepatitisbanexo7c_hepatitisb                              boolean,
                fiebreamarillaanexo7c_fiebreamarilla                      boolean,
                hijosvivosanexo7c_txthijosvivos                           text,
                hijosmuertosanexo7c                                       text,
                tabaconadaaexo7c_chktnada                                 boolean,
                tabacopocoanexo7c_chktpoco                                boolean,
                tabacohabitualanexo7c_chkthabitual                        boolean,
                tabacoexcesivoanexo7c_chktexcesivo                        boolean,
                alcoholnadaanexo7c_chkanada                               boolean,
                alcoholpocoanexo7c_chkapoco                               boolean,
                alcoholhabitualanexo7c_chkahabitual                       boolean,
                alcoholexcesivoanexo7c_chkaexcesivo                       boolean,
                drogasnadaanexo7c_chkdnada                                boolean,
                drogaspocoanexo7c_chkdpoco                                boolean,
                drogashabitualanexo7c_chkdhabitual                        boolean,
                drogasexcesivoanexo7c_chkdexcesivo                        boolean,
                conclusionanexo7c_txtconclusion                           text,
                cabezaanexo7c_txtcabeza                                   text,
                narizanexo7c_txtnariz                                     text,
                cuelloanexo7c_txtcuello                                   text,
                perimetroanexo7c_txtperimetro                             text,
                baflanexo7c_txtb_a_f_l                                    text,
                visioncoloresanexo7c_txtvisioncolores                     text,
                enfermedadesocularesanexo7c_txtenfermedadesoculares       text,
                reflejospupilaresanexo7c_txtreflejospupilares             text,
                binocularanexo7c_txtbinocular                             text,
                odanexo7c_txtod                                           text,
                oianexo7c_txtoi                                           text,
                toraxanexo7c_txttorax                                     text,
                corazonanexo7c_txtcorazon                                 text,
                pulmonesnormalanexo7c_rbnormal                            boolean,
                pulmonesanormalanexo7c_rbanormal                          boolean,
                pulmonesdescripcionanexo7c_txtpulmones                    text,
                miembrossuperioresanexo7c_txtmiembrossuperiores           text,
                miembrosinferioresanexo7c_txtmiembrosinferiores           text,
                ausentesodontograma_txtausentes                           integer,
                piezasmalestadoodontograma_txtpiezasmalestado             integer,
                visioncercasincorregirod_v_cerca_s_od                     text,
                visioncercasincorregiroi_v_cerca_s_oi                     text,
                odcc_odcc                                                 text,
                oicc_oicc                                                 text,
                visionlejossincorregirod_v_lejos_s_od                     text,
                visionlejossincorregiroi_v_lejos_s_oi                     text,
                odlc_odlc                                                 text,
                oilc_oilc                                                 text,
                vc_vc                                                     text,
                vb_vb                                                     text,
                rp_rp                                                     text,
                enfermedadesocularesoftalmo_e_oculares                    text,
                enfermedadesocularesotrosoftalmo_e_oculares1              text,
                enfermedadesocularesvisionlejos_e_oculvisionlejos         text,
                tecishiharanormal_rbtecishihara_normal                    boolean,
                tecishiharaanormal_rbtecishihara_anormal                  boolean,
                teccoleresnormal_rbteccoleres_normal                      boolean,
                teccoleresanormal_rbteccoleres_anormal                    boolean,
                tecestereopsianormal_rbtecestereopsia_normal              boolean,
                tecestereopsiaanormal_rbtecestereopsia_anormal            boolean,
                oidoderecho500audiometria_o_d_500                         text,
                oidoderecho1000audiometria_o_d_1000                       text,
                oidoderecho2000audiometria_o_d_2000                       text,
                oidoderecho3000audiometria_o_d_3000                       text,
                oidoderecho4000audiometria_o_d_4000                       text,
                oidoderecho6000audiometria_o_d_6000                       text,
                oidoderecho8000audiometria_o_d_8000                       text,
                oidoizquierdo500audiometria_o_i_500                       text,
                oidoizquierdo1000audiometria_o_i_1000                     text,
                oidoizquierdo2000audiometria_o_i_2000                     text,
                oidoizquierdo3000audiometria_o_i_3000                     text,
                oidoizquierdo4000audiometria_o_i_4000                     text,
                oidoizquierdo6000audiometria_o_i_6000                     text,
                oidoizquierdo8000audiometria_o_i_8000                     text,
                diagnosticoaudiometricocompleto_diagnostico               text,
                reflejososteotendinososanexo7c_txtreflejososteotendinosos text,
                marchaanexo7c_txtmarcha                                   text,
                columnavertebralanexo7c_txtcolumnavertebral               text,
                abdomenanexo7c_txtabdomen                                 text,
                anillosinguinalesanexo7c_txtanillosinguinales             text,
                organosgenitalesanexo7c_txtorganosgenitales               text,
                tactorectalnohizoanexo7c_rbtnohizo                        boolean,
                tactorectalnormalanexo7c_rbtnormal                        boolean,
                tactorectalanormalanexo7c_rbtanormal                      boolean,
                describirobservacionanexo7c_chkdescribirobservacion       boolean,
                herniasanexo7c_txthernias                                 text,
                varicesanexo7c_txtvarices                                 text,
                gangliosanexo7c_txtganglios                               text,
                lenguageanexo7c_txtlenguage                               text,
                observacionesfichamedicaanexo7c_txtobservacionesfm        text,
                nrx_n_rx                                                  integer,
                fechaexamenradiografico_fecha_exra                        date,
                calidadexamenradiografico_txtcalidad                      text,
                simbolosexamenradiografico_txtsimbolos                    text,
                conclusionmedicoanexo7c_txtconclusionmed                  text,
                estadomentalanexo7c_txtestadomental                       text,
                anamnesisanexo7c_txtanamnesis                             text,
                examenradiografico0_ex_0                                  boolean,
                examenradiografico10_ex_10                                boolean,
                examenradiografico11_ex_11                                boolean,
                examenradiografico12_ex_12                                boolean,
                examenradiografico21_ex_21                                boolean,
                examenradiografico22_ex_22                                boolean,
                examenradiografico23_ex_23                                boolean,
                examenradiografico32_ex_32                                boolean,
                examenradiografico33_ex_33                                boolean,
                examenradiografico3mas_ex_3mas                            boolean,
                examenradiograficoabc_ex_abc                              boolean,
                examenradiograficost_ex_st                                boolean,
                examenradiograficosinneumoconiosis_txtsinneumoconiosis    text,
                examenradiograficoconneumoconiosis_txtconneumoconiosis    text,
                examenradiograficoirep_txtirep                            text,
                examenradiograficootros_txtotrosex                        text,
                examenradiograficoaptosi_apto_si                          boolean,
                examenradiograficoaptono_apto_no                          boolean,
                examenradiograficoaptore_apto_re                          boolean,
                verticesradiografiatorax_txtvertices                      text,
                hilosradiografiatorax_txthilios                           text,
                senoscostofrenicos_txtsenoscostofrenicos                  text,
                meadiastinos_txtmediastinos                               text,
                siluetacardiovascular_txtsiluetacardiovascular            text,
                conclusionesradiograficas_txtconclusionesradiograficas    text,
                color                                                     integer,
                gruposanguineoo_chko                                      boolean,
                gruposanguineoa_chka                                      boolean,
                gruposanguineob_chkb                                      boolean,
                gruposanguineoab_chkab                                    boolean,
                gruposanguineorhpositivo_rbrhpositivo                     boolean,
                gruposanguineorhnegativo_rbrhnegativo                     boolean,
                hemoglobina_txthemoglobina                                text,
                positivolaboratorioclinico_chkpositivo                    boolean,
                negativolaboratorioclinico_chknegativo                    boolean,
                glucosalaboratorioclinico_txtglucosabio                   text,
                creatininalaboratorioclinico_txtcreatininabio             text,
                vsglaboratorioclinico_txtvsg                              text,
                cocainalaboratorioclinico_txtcocaina                      text,
                marihuanalaboratorioclinico_txtmarihuana                  text,
                leucocitos_txtleucocitosematologia                        text,
                hematies_txthematiesematologia                            text,
                plaquetas_txtplaquetas                                    text,
                neutrofilos_txtneutrofilos                                text,
                abastonados_txtabastonados                                text,
                segmentados_txtsegmentadosematologia                      text,
                monocitos_txtmonocitosematologia                          text,
                eosinofilos_txteosinofiosematologia                       text,
                basofilos_txtbasofilosematologia                          text,
                linfocitos_txtlinfocitosematologia                        text,
                creatininaanalisisbioquimico_txtcreatinina                text,
                colesterolanalisisbioquimico_txtcolesterol                text,
                ldlcolesterolanalisisbioquimico_txtldlcolesterol          text,
                hdlcolesterolanalisisbioquimico_txthdlcolesterol          text,
                vldlcolesterolanalisisbioquimico_txtvldlcolesterol        text,
                trigliceridosanalisisbioquimico_txttrigliceridos          text,
                sede                                                      text,
                nombresede                                                text,
                numero                                                    text,
                codigoanexo7c_cod_anexo                                   integer,
                namejasper                                                text,
                pielanexo7c_piel                                          boolean,
                pieldescripcionanexo7c_piel_descripcion                   text,
                usuariofirma                                              text,
                interpretacionfuncionrespiratoria_interpretacion          text,
                hematocritoLaboratorioClinico_txthematocrito              text,
                creatininaPerfilRenal_txtcreatinina                       text,
                ureaAsericaPerfilRenal_txtureaserica                      text,
                acidoUricoPerfilRenal_txtacidourico                       text
            )
AS
$BODY$
BEGIN
    RETURN QUERY
        SELECT a.fecha
             , d.tel_trabajo_pa
             , d.tel_casa_pa
             , d.cel_pa
             , d.cod_pa
             , d.sexo_pa
             , CASE
                   WHEN LENGTH(TRIM(CAST(d.tel_casa_pa AS TEXT))) > 1 THEN d.tel_casa_pa
                   ELSE d.cel_pa END                                                       AS num_contacto
             , d.direccion_pa || '-' || d.distrito_pa || '-' || d.provincia_pa || '-' ||
               d.departamento_pa                                                           AS direccion
             , d.fecha_nacimiento_pa
             , d.lugar_nac_pa
             , d.estado_civil_pa
             , d.nivel_est_pa
             , n.cargo_de
             , f.fvc
             , f.fev1
             , f.fev1fvc
             , f.fef25_75
             , n.razon_empresa
             , n.nom_ex
             , n.altura_po
             , n.razon_contrata
             , n.n_orden
             , n.fecha_apertura_po
             , e.nom_examen
             , n.mineral_po
             , d.apellidos_pa || ' ' || d.nombres_pa                                       AS nombres
             , CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT)
             , t.perimetro_cuello
             , t.imc
             , t.peso
             , t.talla
             , t.cintura
             , t.cadera
             , t.icc
             , t.temperatura
             , t.f_respiratoria
             , t.f_cardiaca
             , t.sat_02
             , t.sistolica
             , t.diastolica
             , CASE WHEN apt.ruido IS NULL THEN a.chkruido ELSE apt.ruido END
             , CASE WHEN apt.polvo IS NULL THEN a.chkpolvo ELSE apt.polvo END
             , CASE WHEN apt.vid_segmentario IS NULL THEN a.chkvidsegmentario ELSE apt.vid_segmentario END
             , CASE WHEN apt.vid_total IS NULL THEN a.chkvidtotal ELSE apt.vid_total END
             , CASE WHEN apt.cancerigenos IS NULL THEN a.chkcancerigenos ELSE apt.cancerigenos END
             , CASE WHEN apt.mutagenicos IS NULL THEN a.chkmutagenicos ELSE apt.mutagenicos END
             , CASE WHEN apt.solventes IS NULL THEN a.chksolventes ELSE apt.solventes END
             , CASE WHEN apt.metales IS NULL THEN a.chkmetales ELSE apt.metales END
             , CASE WHEN apt.temperatura IS NULL THEN a.chktemperatura ELSE apt.temperatura END
             , CASE WHEN apt.biologicos IS NULL THEN a.chkbiologicos ELSE apt.biologicos END
             , CASE WHEN apt.posturas IS NULL THEN a.chkposturas ELSE apt.posturas END
             , CASE WHEN apt.turnos IS NULL THEN a.chkturnos ELSE apt.turnos END
             , CASE WHEN apt.cargas IS NULL THEN a.chkcargas ELSE apt.cargas END
             , CASE WHEN apt.mov_repet IS NULL THEN a.chkmovrepet ELSE apt.mov_repet END
             , CASE WHEN apt.pvd IS NULL THEN a.chkpvd ELSE apt.pvd END
             , CASE WHEN apt.electricos IS NULL THEN a.electricos ELSE apt.electricos END
             , CASE WHEN apt.vibraciones IS NULL THEN a.vibraciones ELSE apt.vibraciones END
             , CASE WHEN apt.otros IS NULL THEN a.chkotros ELSE apt.otros END
             , CASE WHEN apt.altura_estructura IS NULL THEN a.altura_estructura ELSE apt.altura_estructura END
             , CASE WHEN apt.altura_geografica IS NULL THEN a.altura_geog ELSE apt.altura_geografica END
             , CASE WHEN apt.quimicos IS NULL THEN a.quimicos ELSE apt.quimicos END
             , a.tbrsi
             , a.rbrno
             , a.txtpuestoactual
             , a.txttiempo
             , a.txtantecedentespersonales
             , a.txtantecedentesfamiliares
             , a.tetano
             , a.hepatitisb
             , a.fiebreamarilla
             , a.txthijosvivos
             , a.txthijosmuertos
             , a.chktnada
             , a.chktpoco
             , a.chkthabitual
             , a.chktexcesivo
             , a.chkanada
             , a.chkapoco
             , a.chkahabitual
             , a.chkaexcesivo
             , a.chkdnada
             , a.chkdpoco
             , a.chkdhabitual
             , a.chkdexcesivo
             , a.txtconclusion
             , a.txtcabeza
             , a.txtnariz
             , a.txtcuello
             , a.txtperimetro
             , a.txtb_a_f_l
             , a.txtvisioncolores
             , a.txtenfermedadesoculares
             , a.txtreflejospupilares
             , a.txtbinocular
             , a.txtod
             , a.txtoi
             , a.txttorax
             , a.txtcorazon
             , a.rbnormal
             , a.rbanormal
             , a.txtpulmones
             , a.txtmiembrossuperiores
             , a.txtmiembrosinferiores
             , od.txtausentes
             , od.txtpiezasmalestado
             , CASE
                   WHEN oft.txtcercasincorregirod is not null THEN oft.txtcercasincorregirod
                   ELSE o.v_cerca_s_od END                                                 AS v_cerca_s_od
             , CASE
                   WHEN oft.txtcercasincorregiroi is not null THEN oft.txtcercasincorregiroi
                   ELSE o.v_cerca_s_oi END                                                 AS v_cerca_s_oi
             , CASE
                   WHEN oft.txtcercacorregidaod is not null THEN oft.txtcercacorregidaod
                   WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od
                   ELSE ol.v_cerca_c_od END                                                AS ODCC
             , CASE
                   WHEN oft.txtcercacorregidaoi is not null THEN oft.txtcercacorregidaoi
                   WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi
                   ELSE ol.v_cerca_c_oi END                                                AS OICC
             , CASE
                   WHEN oft.txtlejossincorregirod is not null THEN oft.txtlejossincorregirod
                   ELSE o.v_lejos_s_od END                                                 AS v_lejos_s_od
             , CASE
                   WHEN oft.txtlejossincorregiroi is not null THEN oft.txtlejossincorregiroi
                   ELSE o.v_lejos_s_oi END                                                 AS v_lejos_s_oi
             , CASE
                   WHEN oft.txtlejoscorregidaod is not null THEN oft.txtlejoscorregidaod
                   WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od
                   ELSE ol.v_lejos_c_od END                                                AS ODLC
             , CASE
                   WHEN oft.txtlejoscorregidaoi is not null THEN oft.txtlejoscorregidaoi
                   WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi
                   ELSE ol.v_lejos_c_oi END                                                AS OILC
             , CASE WHEN ol.v_colores IS NULL THEN o.v_colores ELSE ol.v_colores END       AS VC
             , CASE
                   WHEN oft.txtbinocularsincorregir IS not NULL THEN oft.txtbinocularsincorregir
                   WHEN ol.v_binocular IS NULL THEN o.v_binocular
                   ELSE ol.v_binocular END                                                 AS VB
             , CASE WHEN ol.r_pupilares IS NULL THEN o.r_pupilares ELSE ol.r_pupilares END AS RP
             , CASE
                   WHEN oft.txtdiagnostico IS not NULL THEN oft.txtdiagnostico
                   ELSE o.e_oculares END                                                   AS e_oculares
             , o.e_oculares1
             , o.e_oculvisionlejos
             , oft.rbtecishihara_normal
             , oft.rbtecishihara_anormal
             , oft.rbteccoleres_normal
             , oft.rbteccoleres_anormal
             , oft.rbtecestereopsia_normal
             , oft.rbtecestereopsia_anormal
             , CASE
                   WHEN au.o_d_500 is not null THEN au.o_d_500
                   WHEN a25.o_d_500 is not null THEN a25.o_d_500
                   ELSE m.o_d_500 END                                                      AS o_d_500
             , CASE
                   WHEN au.o_d_1000 is not null THEN au.o_d_1000
                   WHEN a25.o_d_1000 is not null THEN a25.o_d_1000
                   ELSE m.o_d_1000 END                                                     AS o_d_1000
             , CASE
                   WHEN au.o_d_2000 is not null THEN au.o_d_2000
                   WHEN a25.o_d_2000 is not null THEN a25.o_d_2000
                   ELSE m.o_d_2000 END                                                     AS o_d_2000
             , CASE
                   WHEN au.o_d_3000 is not null THEN au.o_d_3000
                   WHEN a25.o_d_3000 is not null THEN a25.o_d_3000
                   ELSE m.o_d_3000 END                                                     AS o_d_3000
             , CASE
                   WHEN au.o_d_4000 is not null THEN au.o_d_4000
                   WHEN a25.o_d_4000 is not null THEN a25.o_d_4000
                   ELSE m.o_d_4000 END                                                     AS o_d_4000
             , CASE
                   WHEN au.o_d_6000 is not null THEN au.o_d_6000
                   WHEN a25.o_d_6000 is not null THEN a25.o_d_6000
                   ELSE m.o_d_6000 END                                                     AS o_d_6000
             , CASE
                   WHEN au.o_d_8000 is not null THEN au.o_d_8000
                   WHEN a25.o_d_8000 is not null THEN a25.o_d_8000
                   ELSE m.o_d_8000 END                                                     AS o_d_8000
             , CASE
                   WHEN au.o_i_500 is not null THEN au.o_i_500
                   WHEN a25.o_i_500 is not null THEN a25.o_i_500
                   ELSE m.o_i_500 END                                                      AS o_i_500
             , CASE
                   WHEN au.o_i_1000 is not null THEN au.o_i_1000
                   WHEN a25.o_i_1000 is not null THEN a25.o_i_1000
                   ELSE m.o_i_1000 END                                                     AS o_i_1000
             , CASE
                   WHEN au.o_i_2000 is not null THEN au.o_i_2000
                   WHEN a25.o_i_2000 is not null THEN a25.o_i_2000
                   ELSE m.o_i_2000 END                                                     AS o_i_2000
             , CASE
                   WHEN au.o_i_3000 is not null THEN au.o_i_3000
                   WHEN a25.o_i_3000 is not null THEN a25.o_i_3000
                   ELSE m.o_i_3000 END                                                     AS o_i_3000
             , CASE
                   WHEN au.o_i_4000 is not null THEN au.o_i_4000
                   WHEN a25.o_i_4000 is not null THEN a25.o_i_4000
                   ELSE m.o_i_4000 END                                                     AS o_i_4000
             , CASE
                   WHEN au.o_i_6000 is not null THEN au.o_i_6000
                   WHEN a25.o_i_6000 is not null THEN a25.o_i_6000
                   ELSE m.o_i_6000 END                                                     AS o_i_6000
             , CASE
                   WHEN au.o_i_8000 is not null THEN au.o_i_8000
                   WHEN a25.o_i_8000 is not null THEN a25.o_i_8000
                   ELSE m.o_i_8000 END                                                     AS o_i_8000
             , CASE WHEN m.diagnostico is null THEN '' ELSE m.diagnostico END              AS diagnostico
             , a.txtreflejososteotendinosos
             , a.txtmarcha
             , a.txtcolumnavertebral
             , a.txtabdomen
             , a.txtanillosinguinales
             , a.txtorganosgenitales
             , a.rbtnohizo
             , a.rbtnormal
             , a.rbtanormal
             , a.chkdescribirobservacion
             , a.txthernias
             , a.txtvarices
             , a.txtganglios
             , a.txtlenguage
             , a.txtobservacionesfm
             , e2.n_rx
             , e2.fecha_exra
             , e2.txtcalidad
             , e2.txtsimbolos
             , a.txtconclusionmed
             , a.txtestadomental
             , a.txtanamnesis
             , e2.ex_0
             , e2.ex_10
             , e2.ex_11
             , e2.ex_12
             , e2.ex_21
             , e2.ex_22
             , e2.ex_23
             , e2.ex_32
             , e2.ex_33
             , e2.ex_3mas
             , e2.ex_abc
             , e2.ex_st
             , e2.txtsinneumoconiosis
             , e2.txtconneumoconiosis
             , e2.txtirep
             , e2.txtotrosex
             , e2.apto_si
             , e2.apto_no
             , e2.apto_re
             , r.txtvertices
             , r.txthilios
             , r.txtsenoscostofrenicos
             , r.txtmediastinos
             , r.txtsiluetacardiovascular
             , r.txtconclusionesradiograficas
             , n.color
             , l.chko
             , l.chka
             , l.chkb
             , l.chkab
             , l.rbrhpositivo
             , l.rbrhnegativo
             , l.txthemoglobina
             , l.chkpositivo
             , l.chknegativo
             , l.txtglucosabio
             , l.txtcreatininabio
             , l.txtvsg
             , l.txtcocaina
             , l.txtmarihuana
             , l.txtleucocitosematologia
             , l.txthematiesematologia
             , l.txtplaquetas
             , l.txtneutrofilos
             , l.txtabastonados
             , l.txtsegmentadosematologia
             , l.txtmonocitosematologia
             , l.txteosinofiosematologia
             , l.txtbasofilosematologia
             , l.txtlinfocitosematologia
             , ab.txtcreatinina
             , ab.txtcolesterol
             , ab.txtldlcolesterol
             , ab.txthdlcolesterol
             , ab.txtvldlcolesterol
             , ab.txttrigliseridos
             , CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' AND n.cod_sede <> 3 THEN 'Huamachuco'
                   ELSE (CAST(sm.descripcion AS TEXT)) END
             , CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   WHEN n.cod_sede = 1 THEN 'Trujillo'
                   WHEN n.cod_sede = 2 THEN 'Huamachuco'
                   WHEN n.cod_sede = 3 THEN 'Huancayo'
                   WHEN n.cod_sede = 4
                       THEN 'Trujillo' END                                                 AS nombreSede
             , (CASE
                    WHEN n.cod_sede = 1 THEN CONCAT(n.n_orden, '-T')
                    WHEN n.cod_sede = 4 THEN CONCAT(n.n_orden, '-TP')
                    else CONCAT(n.n_orden, '-H') END)                                      AS numero
             , a.cod_anexo
             , obtener_name_jasper(p_norden, name_service)
             , a.piel
             , a.piel_descripcion
             , a.usuario_firma
             , f.interpretacion
             , l.txthematocrito
             , lbi.txtcreatinina
             , lbi.txtureaserica
             , lbi.txtacidourico
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
        LIMIT 1;
END;
$BODY$
    LANGUAGE plpgsql;

CREATE
    OR REPLACE FUNCTION sp_validar_existencia_servicios(IN p_historia_clinica bigint, IN p_examen_med text)
    RETURNS TABLE
            (
                id_resp integer,
                mensaje text
            )
AS
$BODY$
declare
    v_mensaje                        text; declare
    v_id_existencia                  integer; declare
    v_triaje_existencia_espirometria integer; declare
    v_agudeza_visual_existencia      integer; declare
    v_tabla_necesaria_existencia     integer;
begin
    if
        (p_examen_med = 'triaje') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM triaje
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'con_panel10D') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consent_laboratorios
        WHERE n_orden = p_historia_clinica
          AND name_conset = p_examen_med
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'con_panel5D') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consent_laboratorios
        WHERE n_orden = p_historia_clinica
          AND name_conset = p_examen_med
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'con_panel3D') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consent_laboratorios
        WHERE n_orden = p_historia_clinica
          AND name_conset = p_examen_med
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'con_panel2D') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consent_laboratorios
        WHERE n_orden = p_historia_clinica
          AND name_conset = p_examen_med
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'consent_Muestra_Sangre') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consent_laboratorios
        WHERE n_orden = p_historia_clinica
          AND name_conset = p_examen_med
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'consent_marihuana') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consent_laboratorios
        WHERE n_orden = p_historia_clinica
          AND name_conset = p_examen_med
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'consent_Boro') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consent_Boro
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'panel10d') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM panel10d
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'toxicologia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM toxicologia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'panel3d') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM panel3d
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'panel2d') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM panel2d
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'analisis_bioquimicos') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM analisis_bioquimicos
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'lab_clinico') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM lab_clinico
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'examen_inmunologico') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM examen_inmunologico
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'microbiologia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM microbiologia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'inmunologia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM inmunologia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'parasitologia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM parasitologia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'ac_bioquimica2022') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ac_bioquimica2022
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'ac_coprocultivo') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ac_coprocultivo
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'ac_coproparasitologico') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ac_coproparasitologico
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'perfil_hepatico') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM perfil_hepatico
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'l_bioquimica') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM l_bioquimica
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'lhepatitis') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM lhepatitis
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'hemograma_autom') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM hemograma_autom
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'ltest_altura') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ltest_altura
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'lanexo16a') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM lanexo16a
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'lpsiconsensometria') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM lpsiconsensometria
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'lgonadotropina') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM lgonadotropina
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'consen_digit') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consen_digit
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'audiometria_2023') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM audiometria_2023
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'historia_oc_info') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM historia_oc_info
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'audiometria_po') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM audiometria_po
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'ficha_audiologica') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ficha_audiologica
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'cuestionario_audiometria') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM cuestionario_audiometria
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'funcion_abs') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM funcion_abs
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_triaje_existencia_espirometria
        FROM triaje
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_triaje_existencia_espirometria = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'oftalmologia_lo') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM oftalmologia_lo
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'oftalmologia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM oftalmologia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'oftalmologia2021') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM oftalmologia2021
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'odontograma') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM odontograma
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'odontograma_lo') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM odontograma_lo
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'radiografia_torax') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM radiografia_torax
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'radiografia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM radiografia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'oit') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM oit
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'consentimientoInformado') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consentimientoInformado
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'radiografia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM radiografia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'radiografia_torax') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM radiografia_torax
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'evaluacion_musculo_esqueletica') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM evaluacion_musculo_esqueletica
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'evaluacion_musculo_esqueletica2021') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM evaluacion_musculo_esqueletica2021
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'cuestionario_nordico') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM cuestionario_nordico
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'consentimiento_rayosx') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consentimiento_rayosx
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'test_fatiga_somnolencia') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM test_fatiga_somnolencia
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'informe_electrocardiograma') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM informe_electrocardiograma
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'antece_enfermedades_altura') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM antece_enfermedades_altura
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'anexo_agroindustrial') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM anexo_agroindustrial
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'consentimientobuenasalud') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM consentimientobuenasalud
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'anexo7c') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM anexo7c
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'anexo16a') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM anexo16a
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_triaje_existencia_espirometria
        FROM triaje
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_triaje_existencia_espirometria = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'antecedentes_patologicos') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM antecedentes_patologicos
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT CASE
                   WHEN EXISTS (SELECT 1
                                FROM oftalmologia2021
                                WHERE n_orden = p_historia_clinica) OR EXISTS (SELECT 1
                                                                               FROM oftalmologia
                                                                               WHERE n_orden = p_historia_clinica) OR
                        EXISTS (SELECT 1
                                FROM oftalmologia_lo
                                WHERE n_orden = p_historia_clinica) THEN 1
                   ELSE 0 END
        INTO v_agudeza_visual_existencia;
        IF
            (v_agudeza_visual_existencia = 1) THEN
            IF (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR AGUDEZA VISUAL PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'aptitud_medico_ocupacional_agro') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM aptitud_medico_ocupacional_agro
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
        FROM anexo_agroindustrial
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_tabla_necesaria_existencia = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR ANEXO 2 PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'certificado_aptitud_medico_ocupacional') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM certificado_aptitud_medico_ocupacional
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
        FROM anexo7c
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_tabla_necesaria_existencia = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR ANEXO 16 PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'ficha_sas') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ficha_sas
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
--
        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
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
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'certificado_aptitud_medico_resumen') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM certificado_aptitud_medico_resumen
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'b_certificado_conduccion') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM b_certificado_conduccion
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
        FROM ficha_sas
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_tabla_necesaria_existencia = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR FICHA SAS PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'ficha_interconsulta') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ficha_interconsulta
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
        FROM triaje
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_tabla_necesaria_existencia = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'b_certificado_altura') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM b_certificado_altura
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT CASE
                   WHEN EXISTS (SELECT 1
                                FROM audiometria_2023
                                WHERE n_orden = p_historia_clinica) OR EXISTS (SELECT 1
                                                                               FROM audiometria_po
                                                                               WHERE n_orden = p_historia_clinica)
                       THEN 1
                   ELSE 0 END
        INTO v_tabla_necesaria_existencia;
        IF
            (v_tabla_necesaria_existencia = 1) THEN
            IF (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR AUDIOMETRIA PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'informe_psicologico') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM informe_psicologico
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'b_uso_respiradores') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM b_uso_respiradores
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'ficha_psicologica_anexo02') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ficha_psicologica_anexo02
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'ficha_psicologica_anexo03') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM ficha_psicologica_anexo03
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'certificado_altura_poderosa') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM certificado_altura_poderosa
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
        FROM triaje
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_tabla_necesaria_existencia = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'hoja_consulta_externa') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM hoja_consulta_externa
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
        FROM anexo7c
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_tabla_necesaria_existencia = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR ANEXO 16 PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'aptitud_altura_poderosa') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM aptitud_altura_poderosa
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'aptitud_trabajos_encaliente') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM aptitud_trabajos_encaliente
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'aptitud_licencia_conduciri') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM aptitud_licencia_conduciri
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'certificado_aptitud_herramientas_manuales') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM certificado_aptitud_herramientas_manuales
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'informe_psicolaboral') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM informe_psicolaboral
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'informe_psicologico_estres') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM informe_psicologico_estres
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'certificado_manipuladores_barrick') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM certificado_manipuladores_barrick
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'evaluacion_psicologica_poderosa') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM evaluacion_psicologica_poderosa
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'psicologia_espacios_confinados') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM psicologia_espacios_confinados
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'informe_riesgos_psicosociales') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM informe_riesgos_psicosociales
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'informe_burnout') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM informe_burnout
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'psicologiafobias') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM psicologiafobias
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'calidad_sueño') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM calidad_sueño
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'trastornos_personalidad') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM trastornos_personalidad
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'infor_conductores') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM infor_conductores
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'certificacion_medica_altura') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM certificacion_medica_altura
        WHERE n_orden = p_historia_clinica
        LIMIT 1;

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_tabla_necesaria_existencia
        FROM triaje
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_tabla_necesaria_existencia = 1) THEN
            if (v_id_existencia = 0) THEN
                v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
            else
                v_mensaje := 'YA FUE REGISTRADO';
            end if;
        else
            v_mensaje := 'DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)';
            v_id_existencia
                := 2;
        end if;
    end if;
    if
        (p_examen_med = 'alto_riesgo') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM alto_riesgo
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'especificos') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM especificos
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'cuestionario_berlin') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM cuestionario_berlin
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'exam_complementarios') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM exam_complementarios
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;
    if
        (p_examen_med = 'bombaelectrica') THEN

        SELECT (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        FROM bombaelectrica
        WHERE n_orden = p_historia_clinica
        LIMIT 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';
        end if;
    end if;


    if
        (p_examen_med = 'cuadradorvigia') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from cuadradorvigia
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;

    if
        (p_examen_med = 'riesgocoronario') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from riesgocoronario
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;

    if
        (p_examen_med = 'fobias') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from fobias
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;
    if
        (p_examen_med = 'aversionalriesgo') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from aversionalriesgo
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;
    if
        (p_examen_med = 'glucosatolerancia') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from glucosatolerancia
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;

    if
        (p_examen_med = 'inmunologia_vdrl') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from inmunologia_vdrl
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;

    if
        (p_examen_med = 'vih') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from vih
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;
    if
        (p_examen_med = 'thevenon') THEN
        select (CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END)
        into v_id_existencia
        from thevenon
        where n_orden = p_historia_clinica
        limit 1;
        if
            (v_id_existencia = 0) THEN
            v_mensaje := 'SIN REGISTROS EN EL SISTEMA';
        else
            v_mensaje := 'YA FUE REGISTRADO';

        end if;

    end if;


    RETURN query
        SELECT v_id_existencia AS id_resp
             , v_mensaje       AS mensaje;
end;
$BODY$
    LANGUAGE plpgsql

-- Obtener parametros digitalizados

create function obtener_parametros_digitalizados(norden_param bigint, name_servicio_param text)
    returns TABLE
            (
                descripcion         text,
                name_digitalizacion text,
                dni                 integer
            )
    language plpgsql
as
$$
DECLARE
    dni_paciente_var         INTEGER;
    dni_user_registro_var    INTEGER;
    dni_user_doctor_asig_var INTEGER;
    dni_user_doc_adic_var    INTEGER;
    empresa_var              TEXT;
    user_registro_var        TEXT;
    sede_var                 INTEGER;
    completo_electro_var     BOOLEAN;
BEGIN
    -- Obtener DNI del paciente
    IF name_servicio_param = 'ficha_interconsulta' THEN
        SELECT cod_pa
        INTO dni_paciente_var
        FROM n_orden_ocupacional n
                 INNER JOIN ficha_interconsulta f ON n.n_orden = f.n_orden
        WHERE f.cod_fichaint = norden_param;
    ELSE
        SELECT cod_pa INTO dni_paciente_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
    END IF;

    IF name_servicio_param = 'ficha_interconsulta' THEN
        SELECT trim(razon_empresa)
        INTO empresa_var
        FROM n_orden_ocupacional n
                 INNER JOIN ficha_interconsulta f ON n.n_orden = f.n_orden
        WHERE f.cod_fichaint = norden_param;
    ELSE
        SELECT trim(razon_empresa) INTO empresa_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
    END IF;

    SELECT COALESCE(informe_completo, FALSE)
    INTO completo_electro_var
    FROM informe_electrocardiograma
    WHERE n_orden = norden_param;

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

        IF ((SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) and
            empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
            end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'con_panel4D' THEN
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

        IF ((SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) and
            empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM consent_laboratorios
            WHERE n_orden = norden_param
              AND name_conset = name_servicio_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM consent_Boro
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;


    IF name_servicio_param = 'analisis_bioquimicos' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM analisis_bioquimicos
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM lab_clinico
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM hemograma_autom
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'lgonadotropina' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM lgonadotropina
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
            end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'panel2d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM panel2d
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
            end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'panel3d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM panel2d
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
            end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;

    IF name_servicio_param = 'panel4d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM panel4d
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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

    IF name_servicio_param = 'toxicologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM toxicologia
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
            end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'panel10d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM panel10d
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
            end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'inmunologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM inmunologia
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'microbiologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM microbiologia
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'lhepatitis' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM lhepatitis
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


-- perfil renal
    IF name_servicio_param = 'l_bioquimica' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM l_bioquimica
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM ac_bioquimica2022
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM perfil_hepatico
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM ac_coprocultivo
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;


    END IF;

-- coproparasitologico

    IF name_servicio_param = 'ac_coproparasitologico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM ac_coproparasitologico
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM examen_inmunologico
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM audiometria_2023
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
            ELSE
                dni_user_registro_var := 1;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM historia_oc_info
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM ficha_audiologica
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 55555555;
            ELSE
                dni_user_registro_var := 1;
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
            SELECT user_registro
            INTO user_registro_var
            FROM cuestionario_audiometria
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'oftalmologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM oftalmologia
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM oftalmologia_lo
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM oftalmologia2021
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM odontograma
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT o.user_registro
            INTO user_registro_var
            FROM odontograma_lo olo
                     INNER JOIN odontograma o on olo.n_orden = o.n_orden
            WHERE olo.n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'radiografia_torax' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM radiografia_torax
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'radiografia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM radiografia
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'oit' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM oit
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM evaluacion_musculo_esqueletica
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM evaluacion_musculo_esqueletica2021
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM cuestionario_nordico
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM test_fatiga_somnolencia
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_electrocardiograma' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM informe_electrocardiograma
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM antece_enfermedades_altura
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM anexo_agroindustrial
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM anexo7c
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM anexo16a
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM antecedentes_patologicos
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
                    dni_user_registro_var := 88888888;
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
-- 	FROM certificado_aptitud_medico_ocupacional WHERE n_orden = norden_param;
-- 	select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
            IF sede_var = 3 THEN
                dni_user_registro_var = 88888888;
            ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 88888888;
                ELSE
                    dni_user_registro_var := 66666666;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM ficha_sas
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM certificado_aptitud_medico_resumen
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
            IF sede_var = 3 THEN
                dni_user_registro_var = 88888888;
            ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 88888888;
                ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
                    dni_user_registro_var := 66666666;
                END IF;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM b_certificado_conduccion
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT dni_user
            INTO dni_user_registro_var
            FROM ficha_interconsulta
            WHERE cod_fichaint = norden_param;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM b_certificado_altura
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM informe_psicologico
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
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
            SELECT user_registro
            INTO user_registro_var
            FROM b_uso_respiradores
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM ficha_psicologica_anexo02
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'ficha_psicologica_anexo03' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM ficha_psicologica_anexo03
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM certificado_altura_poderosa
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM aptitud_altura_poderosa
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM aptitud_trabajos_encaliente
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM aptitud_licencia_conduciri
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM hoja_consulta_externa
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM certificado_aptitud_herramientas_manuales
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM anexo7c
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 88888888;
            END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_psicolaboral' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM informe_psicolaboral
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'certificado_manipuladores_barrick' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM certificado_manipuladores_barrick
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM informe_psicologico_estres
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
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
            SELECT user_registro
            INTO user_registro_var
            FROM evaluacion_psicologica_poderosa
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'psicologia_espacios_confinados' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM psicologia_espacios_confinados
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_riesgos_psicosociales' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM informe_riesgos_psicosociales
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_burnout' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM informe_burnout
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'psicologiafobias' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT user_registro
            INTO user_registro_var
            FROM psicologiafobias
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            -- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
            -- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
    IF name_servicio_param = 'trastornos_personalidad' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM trastornos_personalidad
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

    IF name_servicio_param = 'infor_conductores' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM infor_conductores
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

    IF name_servicio_param = 'alto_riesgo' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM alto_riesgo
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

    IF name_servicio_param = 'certificacion_medica_altura' THEN
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM certificacion_medica_altura
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;


    IF name_servicio_param = 'especificos' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM especificos
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
    IF name_servicio_param = 'cuestionario_berlin' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM cuestionario_berlin
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


    IF name_servicio_param = 'exam_complementarios' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM exam_complementarios
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

    IF name_servicio_param = 'psi_brigadistas' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM psi_brigadistas
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
    IF name_servicio_param = 'bombaelectrica' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM bombaelectrica
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


    IF name_servicio_param = 'riesgocoronario' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM riesgocoronario
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
    IF name_servicio_param = 'fobias' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM fobias
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
    IF name_servicio_param = 'aversionalriesgo' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM aversionalriesgo
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

    IF UPPER(name_servicio_param) = 'CONSENT_SINTOMATICO' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF UPPER(name_servicio_param) = 'CONSENT_INFORMADO_MEDICA' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF UPPER(name_servicio_param) = 'CONSENT_RECOM_MEDIC' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF UPPER(name_servicio_param) = 'DECLA_JURA_ANTECE_PERSON_FAM' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF UPPER(name_servicio_param) = 'DECLA_INFO_APTITUD_MO' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion := 'FIRMAP';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;

        IF (SELECT huella_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
            name_digitalizacion := 'HUELLA';
            dni := dni_paciente_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'glucosatolerancia' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM glucosatolerancia
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

    IF name_servicio_param = 'inmunologia_vdrl' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM inmunologia_vdrl
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
    IF name_servicio_param = 'vih' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM vih
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
    IF name_servicio_param = 'thevenon' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM thevenon
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


END;
$$;



INSERT INTO config_general_service_digital (name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig,
                                            sello_doc_adic)
values ('trastornos_personalidad', 'formulario de trastornos de personalidad', false, false, true, false, false);

CREATE
    OR REPLACE FUNCTION obtener_reporte_informe_trastorno_personalidad(IN p_norden integer, IN name_service text)
    RETURNS TABLE
            (
                dnipaciente             integer,
                nombrespaciente         text,
                apellidospaciente       text,
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
                norden                  integer,
                empresa                 text,
                codigoclinica           text,
                tipoexamen              text,
                edadpaciente            text,
                paranoide_bajo          boolean,
                paranoide_medio         boolean,
                paranoide_alto          boolean,
                esquizoide_bajo         boolean,
                esquizoide_medio        boolean,
                esquizoide_alto         boolean,
                esquizotipico_bajo      boolean,
                esquizotipico_medio     boolean,
                esquizotipico_alto      boolean,
                histrionico_bajo        boolean,
                histrionico_medio       boolean,
                histrionico_alto        boolean,
                antisocial_bajo         boolean,
                antisocial_medio        boolean,
                antisocial_alto         boolean,
                narcicista_bajo         boolean,
                narcicista_medio        boolean,
                narcicista_alto         boolean,
                impulsivo_bajo          boolean,
                impulsivo_medio         boolean,
                impulsivo_alto          boolean,
                limite_bajo             boolean,
                limite_medio            boolean,
                limite_alto             boolean,
                anancastico_bajo        boolean,
                anancastico_medio       boolean,
                anancastico_alto        boolean,
                dependiente_bajo        boolean,
                dependiente_medio       boolean,
                dependiente_alto        boolean,
                ansioso_bajo            boolean,
                ansioso_medio           boolean,
                ansioso_alto            boolean,
                observaciones           text,
                recomendacion           text,
                apto                    boolean,
                noapto                  boolean,
                nombresede              text,
                sede                    text,
                color                   integer,
                namejasper              text
            )
AS
$BODY$
BEGIN
    RETURN QUERY
        SELECT d.cod_pa
             , d.nombres_pa
             , d.apellidos_pa
             , d.direccion_pa
             , d.sexo_pa
             , d.fecha_nacimiento_pa
             , d.ocupacion_pa
             , d.lugar_nac_pa
             , d.nivel_est_pa
             , d.estado_civil_pa
             , n.cargo_de
             , n.area_o
             , n.razon_contrata
             , n.n_orden
             , n.razon_empresa
             , n.cod_clinica
             , n.nom_examen
             , CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT) -- =  =  =  =  = TRASTORNO PERSONALIDAD =  =  =  =  =
             , tp.grup_a_paranoide_bajo
             , tp.grup_a_paranoide_medio
             , tp.grup_a_paranoide_alto
             , tp.grup_a_esquizoide_bajo
             , tp.grup_a_esquizoide_medio
             , tp.grup_a_esquizoide_alto
             , tp.grup_a_esquizotipico_bajo
             , tp.grup_a_esquizotipico_medio
             , tp.grup_a_esquizotipico_alto
             , tp.grup_b_histrionico_bajo
             , tp.grup_b_histrionico_medio
             , tp.grup_b_histrionico_alto
             , tp.grup_b_antisocial_bajo
             , tp.grup_b_antisocial_medio
             , tp.grup_b_antisocial_alto
             , tp.grup_b_narcicista_bajo
             , tp.grup_b_narcicista_medio
             , tp.grup_b_narcicista_alto
             , tp.grup_b_inesta_emoci_subtip_impul_bajo
             , tp.grup_b_inesta_emoci_subtip_impul_medio
             , tp.grup_b_inesta_emoci_subtip_impul_alto
             , tp.grup_b_emoci_subtip_lim_bajo
             , tp.grup_b_emoci_subtip_lim_medio
             , tp.grup_b_emoci_subtip_lim_alto
             , tp.grup_c_anancastico_bajo
             , tp.grup_c_anancastico_medio
             , tp.grup_c_anancastico_alto
             , tp.grup_c_dependiente_bajo
             , tp.grup_c_dependiente_medio
             , tp.grup_c_dependiente_alto
             , tp.grup_c_ansioso_bajo
             , tp.grup_c_ansioso_medio
             , tp.grup_c_ansioso_alto
             , tp.analisis_resulta
             , tp.recomendacion
             , tp.perf_cumple
             , tp.perf_no_cumple
             , CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   ELSE (SELECT nombre_sede
                         FROM sede
                         WHERE cod_sede = n.cod_sede) END
             , CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   ELSE CAST(sm.descripcion AS TEXT) END
             , n.color
             , obtener_name_jasper(p_norden, name_service)
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm
                            ON n.cod_sede = sm.id
                 INNER JOIN trastornos_personalidad tp
                            ON tp.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;
END;
$BODY$
    LANGUAGE plpgsql;

CREATE
    OR REPLACE FUNCTION obtener_name_jasper(norden_param bigint, name_service_param text) RETURNS text AS
$BODY$
DECLARE
    resultado text; name_empresa_busqueda_var
              text; name_valor_microbiologia_var
              text; name_valor_hepatitisa_var
              text; name_valor_hepatitisc_var
              text; valor_coproparasitologico_var
              boolean; valor_cuantitativo_antigeno_var
              boolean; valor_formato_marsa_var
              boolean; valor_electro_cardiograma
              boolean;
BEGIN -- Obtener el nombre de la empresa de la historia clinica a registrar;

    SELECT trim(razon_empresa)
    INTO name_empresa_busqueda_var
    FROM n_orden_ocupacional
    WHERE n_orden = norden_param;
-- obtener el valor del txt en microbiologia
    SELECT trim(txtkoh)
    INTO name_valor_microbiologia_var
    FROM microbiologia
    WHERE n_orden = norden_param;
-- obtener el valor del txt en hepatitis
    SELECT trim(txthepatitisa)
    INTO name_valor_hepatitisa_var
    FROM lhepatitis
    WHERE n_orden = norden_param;

    SELECT trim(hepatitisc)
    INTO name_valor_hepatitisc_var
    FROM lhepatitis
    WHERE n_orden = norden_param;
-- obtener el valor del boolean en coproparasitologico
    SELECT tipo_coproparasitologico
    INTO valor_coproparasitologico_var
    FROM ac_coproparasitologico
    WHERE n_orden = norden_param;
-- obtener los valores de los booleanos en examen inmunologico
    SELECT cuantitativo_antigeno
         , formato_marsa
    INTO valor_cuantitativo_antigeno_var
        ,valor_formato_marsa_var
    FROM examen_inmunologico
    WHERE n_orden = norden_param;
-- obtener valor boolean del campo informe_completo de electro cardiograma
    SELECT CASE WHEN informe_completo IS NULL THEN TRUE ELSE informe_completo END AS informe_completo
    INTO valor_electro_cardiograma
    FROM informe_electrocardiograma
    WHERE n_orden = norden_param;
    IF
        name_service_param = 'con_panel10D' THEN
        resultado := 'Consentimiento_Panel10D_Digitalizado';
    ELSIF
        name_service_param = 'con_panel5D' THEN
        IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'Consentimiento_Panel5D_ohla_Digitalizado';
        ELSE
            resultado := 'Consentimiento_Panel5D_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'con_panel3D' THEN
        resultado := 'Consentimiento_Panel3D_Digitalizado';
    ELSIF
        name_service_param = 'con_panel2D' THEN
        resultado := 'Consentimiento_Panel2D_Digitalizado';
    ELSIF
        name_service_param = 'consent_Muestra_Sangre' THEN
        resultado := 'Consentimiento_Muestra_Sangre_Digitalizado';
    ELSIF
        name_service_param = 'consent_marihuana' THEN
        resultado := 'Consentimiento_Marihuana_Digitalizado';
    ELSIF
        name_service_param = 'consent_Boro' THEN
        resultado := 'Consentimiento_Boro_Digitalizado';
    ELSIF
        name_service_param = 'analisis_bioquimicos' THEN
        resultado := 'AnalisisBioquimicos_Digitalizado';
    ELSIF
        name_service_param = 'lab_clinico' THEN
        resultado := 'LaboratorioClinico_Digitalizado';
    ELSIF
        name_service_param = 'hemograma_autom' THEN
        resultado := 'Hematologia_Digitalizado';
    ELSIF
        name_service_param = 'lgonadotropina' THEN
        resultado := 'LGonadotropina_Digitalizado';
    ELSIF
        name_service_param = 'panel2d' THEN
        resultado := 'Panel2d_Digitalizado';
    ELSIF
        name_service_param = 'panel3d' THEN
        resultado := 'Panel3d_Digitalizado';
    ELSIF
        name_service_param = 'toxicologia' THEN
        IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'ResultadosPanel5d_ohla_Digitalizado';
        ELSE
            resultado := 'ResultadosPanel5d_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'panel10d' THEN
        resultado := 'Panel10d_Digitalizado';
    ELSIF
        name_service_param = 'inmunologia' THEN
        resultado := 'InmunologiaLab_Digitalizado';
    ELSIF
        name_service_param = 'microbiologia' THEN
        IF name_valor_microbiologia_var IS NOT NULL
            AND LENGTH(name_valor_microbiologia_var) > 0 THEN
            resultado := 'Microbiologia1_Digitalizado';
        ELSE
            resultado := 'Microbiologia_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'lhepatitis' THEN
        IF name_valor_hepatitisa_var IS NOT NULL
            AND LENGTH(name_valor_hepatitisa_var) > 0 THEN
            resultado := 'LHepatitisA_Digitalizado';
        ELSIF
            name_valor_hepatitisc_var IS NOT NULL
                AND LENGTH(name_valor_hepatitisc_var) > 0 THEN
            resultado := 'LHepatitisC_Digitalizado';
        ELSE
            resultado := 'LHepatitisB_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'l_bioquimica' THEN
        resultado := 'LBioquimica_Digitalizado';
    ELSIF
        name_service_param = 'ac_bioquimica2022' THEN
        resultado := 'AnalisisClinicosB_Digitalizado';
    ELSIF
        name_service_param = 'perfil_hepatico' THEN
        resultado := 'PerfilHepatico_Digitalizado';
    ELSIF
        name_service_param = 'ac_coprocultivo' THEN
        resultado := 'coprocultivo_digitalizado';
    ELSIF
        name_service_param = 'ac_coproparasitologico' THEN
        IF valor_coproparasitologico_var = true THEN
            resultado := 'Coproparasitologico_Digitalizado';
        ELSE
            resultado := 'ParasitologiaSeriado_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'examen_inmunologico' THEN
        IF valor_cuantitativo_antigeno_var = true THEN
            resultado := 'pcuantiantigeno';
        ELSE
            IF valor_formato_marsa_var = true THEN
                resultado := 'pcualitativaantigenoMarsa';
            ELSE
                resultado := 'pcualitativaantigeno';
            END IF;
        END IF;
    ELSIF
        name_service_param = 'audiometria_2023' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'Audiometria2021-_Digitalizado_boro';
        ELSE
            resultado := 'Audiometria2021-_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'historia_oc_info' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'HistoriaOcupacional_Digitalizado_boro';
        ELSE
            resultado := 'HistoriaOcupacional_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'audiometria_po' THEN
        resultado := 'FichaAudiologica_Digitalizado';
    ELSIF
        name_service_param = 'cuestionario_audiometria' THEN
        resultado := 'CuestionarioAudiometria_Digitalizado';
    ELSIF
        name_service_param = 'oftalmologia_lo' THEN
        resultado := 'OftalmologiaLO';
    ELSIF
        name_service_param = 'oftalmologia' THEN
        resultado := 'Oftalmologia';
    ELSIF
        name_service_param = 'oftalmologia_reporte' THEN
        resultado := 'ReporteOftalmologico';
    ELSIF
        name_service_param = 'oftalmologia2021' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'EvaluacionOftalmologica2021_Digitalizado_boro';
        ELSIF
            name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'EvaluacionOftalmologica2021_Digitalizado_ohla';
        ELSE
            resultado := 'EvaluacionOftalmologica2021_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'odontograma' THEN
        resultado := 'Odontograma_Digitalizado';
    ELSIF
        name_service_param = 'odontograma_lo' THEN
        resultado := 'Odontograma_lo_Digitalizado';
    ELSIF
        name_service_param = 'radiografia_torax' THEN
        resultado := 'RagiografiaToraxPA_Digitalizado';
    ELSIF
        name_service_param = 'radiografia_fechas' THEN
        resultado := 'ReporteFechasRadiografia_Digitalizado';
    ELSIF
        name_service_param = 'radiografia' THEN
        resultado := 'RAYOSXXXOFI_Digitalizado';
    ELSIF
        name_service_param = 'oit' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'OIT_Digitalizado_boro';
        ELSE
            resultado := 'OIT_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'evaluacion_musculo_esqueletica' THEN
        resultado := 'EvaluacionMuscoloEsqueletica';
    ELSIF
        name_service_param = 'evaluacion_musculo_esqueletica2021' THEN
        resultado := 'EvaluacionMuscoloEsqueletica2021_Digitalizado_boro';
    ELSIF
        name_service_param = 'consentimientoInformado' THEN
        resultado := 'conInformadoOcupacional_Digitalizado';
    ELSIF
        name_service_param = 'cuestionario_nordico' THEN
        resultado := 'CuestionarioNordico';
    ELSIF
        name_service_param = 'consentimiento_rayosx' THEN
        resultado := 'ConsentimientoRayosX_Digitalizado';
    ELSIF
        name_service_param = 'test_fatiga_somnolencia' THEN
        resultado := 'TestFatigaSomnolenia_Digitalizado_boro';
    ELSIF
        name_service_param = 'informe_electrocardiograma' THEN
        IF valor_electro_cardiograma = TRUE THEN
            resultado := 'InformeElectrocardiograma2023';
        ELSE
            resultado := 'InformeElectrocardiograma_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'antece_enfermedades_altura' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'AnexoCB_boro_Digitalizado';
        ELSE
            resultado := 'AnexoCB_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'anexo_agroindustrial' THEN
        resultado := 'Anexo2';
    ELSIF
        name_service_param = 'consentimientobuenasalud' THEN
        resultado := 'ConsentimientoBuenaSalud2021_Digitalizado';
    ELSIF
        name_service_param = 'anexo7c' THEN
        resultado := 'Anexo7C_Boro';
    ELSIF
        name_service_param = 'anexo16a' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'Anexo16ABoro_Digitalizado';
        ELSE
            resultado := 'Anexo16A_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'antecedentes_patologicos' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR
           name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%' OR
           name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'ficha_antecedente_patologico_boro';
        ELSE
            resultado := 'ficha_antecedente_patologico_Digitalizado';
        END IF;
    ELSIF
        name_service_param = 'aptitud_medico_ocupacional_agro' THEN
        resultado := 'Aptitud_Agroindustrial';
    ELSIF
        name_service_param = 'certificado_aptitud_medico_ocupacional' THEN
        IF name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'Aptitud_medico_ocupacional_11';
        ELSE
            resultado := 'Aptitud_medico_ocupacional_F';
        END IF;
    ELSIF
        name_service_param = 'ficha_sas' THEN
        resultado := 'FichaDetencionSAS_boro_Digitalizado';
    ELSIF
        name_service_param = 'certificado_aptitud_medico_resumen' THEN
        resultado := 'Aptitud_medico_resumen_Digitalizado';
    ELSIF
        name_service_param = 'b_certificado_conduccion' THEN
        resultado := 'certificaciondeconduccion_Digitalizado_boro';
    ELSIF
        name_service_param = 'ficha_interconsulta' THEN
        resultado := 'Ficha_interconsulta_Digitalizado';
    ELSIF
        name_service_param = 'b_certificado_altura' THEN
        resultado := 'Certificacion_suficiencia_trabajos_en_altura_boro_Digitalizado';
    ELSIF
        name_service_param = 'informe_psicologico' THEN
        resultado := 'InformePsicologico_Digitalizado';
    ELSIF
        name_service_param = 'b_uso_respiradores' THEN
        resultado := 'UsoRespiradores';
    ELSIF
        name_service_param = 'ficha_psicologica_anexo02' THEN
        resultado := 'InformePsicologico_Anexo02_Digitalizado';
    ELSIF
        name_service_param = 'ficha_psicologica_anexo03' THEN
        resultado := 'FichaPsicologicaOcupacional_Digitalizado';
    ELSIF
        name_service_param = 'certificado_altura_poderosa' THEN
        resultado := 'CertificadoAlturaPoderosa_Digitalizado';
    ELSIF
        name_service_param = 'hoja_consulta_externa' THEN
        resultado := 'Hoja_Consulta_Externa';
    ELSIF
        name_service_param = 'aptitud_altura_poderosa' THEN
        resultado := 'Aptitud_Poderosa_Digitalizado';
    ELSIF
        name_service_param = 'aptitud_trabajos_encaliente' THEN
        resultado := 'Aptitud_Trabajos_EnCaliente_Digitalizado';
    ELSIF
        name_service_param = 'aptitud_licencia_conduciri' THEN
        resultado := 'Aptitud_Licencia_Conducir_Interna_Digitalizado';
    ELSIF
        name_service_param = 'certificado_aptitud_herramientas_manuales' THEN
        resultado := 'Certificado_Aptitud_Herramientas_Manuales_Digitalizado';
    ELSIF
        name_service_param = 'informe_psicolaboral' THEN
        resultado := 'Informe_PsicolaboralBoroo_Digitalizado';
    ELSIF
        name_service_param = 'certificado_manipuladores_barrick' THEN
        resultado := 'CertificadoMedicoManipuladores_Barrick_Digitalizado';
    ELSIF
        name_service_param = 'informe_psicologico_estres' THEN
        resultado := 'InformePsicologicoAdecoEstres_Digitalizado';
    ELSIF
        name_service_param = 'evaluacion_psicologica_poderosa' THEN
        resultado := 'InformePsicologico_Digitalizado';
    ELSIF
        name_service_param = 'psicologia_espacios_confinados' THEN
        resultado := 'formatPsicologia_SuficienciaEspaciosC';
    ELSIF
        name_service_param = 'informe_riesgos_psicosociales' THEN
        resultado := 'Informe_Riesgos_Psicosociales_Digitalizado';
    ELSIF
        name_service_param = 'informe_burnout' THEN
        resultado := 'Informe_burnout_Digitalizado';
    ELSIF
        name_service_param = 'psicologiafobias' THEN
        resultado := 'formatPsicologia_Digitalizado';
    ELSIF
        name_service_param = 'calidad_sueño' THEN
        resultado := 'CUESTIONARIO_CALIDAD_DE_SUEÑO_Digitalizado';
    ELSIF
        name_service_param = 'trastornos_personalidad' THEN
        resultado := 'Informe_Psico_Test_Personalidad';
    ELSIF
        name_service_param = 'infor_conductores' THEN
        resultado := 'Informe_Psico_Conductores';
    ELSIF
        name_service_param = 'certificacion_medica_altura' THEN
        resultado := 'A_CertificacionMedicaPTA_Digitalizado';
    ELSIF
        name_service_param = 'alto_riesgo' THEN
        resultado := 'Informe_Psico_Alto_Riesgo';
    ELSIF
        name_service_param = 'especificos' THEN
        resultado := 'Informe_Psico_Especificos';
    ELSIF
        name_service_param = 'cuestionario_berlin' THEN
        resultado := 'Informe_Psico_Cuestionario_Berlin';
    END IF;
    RETURN resultado;
END;
$BODY$
    LANGUAGE plpgsql VOLATILE
                     COST 100;

ALTER FUNCTION obtener_name_jasper(bigint, text) OWNER TO pierola;

CREATE
    OR REPLACE FUNCTION obtener_existencias_examenes(nOrden INTEGER)
    RETURNS TABLE
            (
                existe      BOOLEAN,
                nameService TEXT
            )
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
        SELECT EXISTS(SELECT 1
                      FROM certificado_aptitud_medico_ocupacional
                      WHERE n_orden = nOrden),
               'certificado_aptitud_medico_ocupacional'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM anexo7c
                      WHERE n_orden = nOrden),
               'anexo7c'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM antece_enfermedades_altura
                      WHERE n_orden = nOrden),
               'antece_enfermedades_altura'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM anexo16a
                      WHERE n_orden = nOrden),
               'anexo16a'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM b_uso_respiradores
                      WHERE n_orden = nOrden),
               'b_uso_respiradores'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM historia_oc_info
                      WHERE n_orden = nOrden),
               'historia_oc_info'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM antecedentes_patologicos
                      WHERE n_orden = nOrden),
               'antecedentes_patologicos'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM cuestionario_nordico
                      WHERE n_orden = nOrden),
               'cuestionario_nordico'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM evaluacion_musculo_esqueletica
                      WHERE n_orden = nOrden),
               'evaluacion_musculo_esqueletica'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM lab_clinico
                      WHERE n_orden = nOrden),
               'lab_clinico'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM analisis_bioquimicos
                      WHERE n_orden = nOrden),
               'analisis_bioquimicos'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM radiografia_torax
                      WHERE n_orden = nOrden),
               'radiografia_torax'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM audiometria_po
                      WHERE n_orden = nOrden),
               'audiometria_po'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM ficha_audiologica
                      WHERE n_orden = nOrden),
               'ficha_audiologica'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM informe_psicologico
                      WHERE n_orden = nOrden),
               'informe_psicologico'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM oftalmologia
                      WHERE n_orden = nOrden),
               'oftalmologia'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientoInformado
                      WHERE n_orden = nOrden),
               'consentimientoInformado'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM triaje
                      WHERE n_orden = nOrden),
               'triaje'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM informe_electrocardiograma
                      WHERE n_orden = nOrden),
               'informe_electrocardiograma'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM funcion_abs
                      WHERE n_orden = nOrden),
               'funcion_abs'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM odontograma
                      WHERE n_orden = nOrden),
               'odontograma'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM certificacion_medica_altura
                      WHERE n_orden = nOrden),
               'certificacion_medica_altura'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM ficha_sas
                      WHERE n_orden = nOrden),
               'ficha_sas'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimiento_dosaje
                      WHERE n_orden = nOrden),
               'consentimiento_dosaje'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM perimetro_toracico
                      WHERE n_orden = nOrden),
               'perimetro_toracico'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM ex_radiograficos_sanguineos
                      WHERE n_orden = nOrden),
               'ex_radiograficos_sanguineos'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM b_certificado_altura
                      WHERE n_orden = nOrden),
               'b_certificado_altura'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM b_certificado_conduccion
                      WHERE n_orden = nOrden),
               'b_certificado_conduccion'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM oit
                      WHERE n_orden = nOrden),
               'oit'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM cuestionario_audiometria
                      WHERE n_orden = nOrden),
               'cuestionario_audiometria'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM informe_audiometria
                      WHERE n_orden = nOrden),
               'informe_audiometria'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM anexo7c2
                      WHERE n_orden = nOrden),
               'anexo7c2'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM certificado_aptitud_medico_ocupacional1
                      WHERE n_orden = nOrden),
               'certificado_aptitud_medico_ocupacional1'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM aptitud_medico_ocupacional_agro
                      WHERE n_orden = nOrden),
               'aptitud_medico_ocupacional_agro'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM anexo_agroindustrial
                      WHERE n_orden = nOrden),
               'anexo_agroindustrial'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM certificado_aptitud_anexo02
                      WHERE n_orden = nOrden),
               'certificado_aptitud_anexo02'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM anexo_02
                      WHERE n_orden = nOrden),
               'anexo_02'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM audiometria_2021
                      WHERE n_orden = nOrden),
               'audiometria_2021'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM evaluacion_musculo_esqueletica2021
                      WHERE n_orden = nOrden),
               'evaluacion_musculo_esqueletica2021'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM cuestionario_calidad_sueno
                      WHERE n_orden = nOrden),
               'cuestionario_calidad_sueno'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM test_fatiga_somnolencia
                      WHERE n_orden = nOrden),
               'test_fatiga_somnolencia'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM oftalmologia2021
                      WHERE n_orden = nOrden),
               'oftalmologia2021'
        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM certificado_manipuladores_barrick
                      WHERE n_orden = nOrden),
               'certificado_manipuladores_barrick';
END;
$$;

CREATE
    OR REPLACE FUNCTION obtener_existencias_examenes(p_n_orden BIGINT)
    RETURNS TABLE
            (
                tieneTriaje                           BOOLEAN,
                tieneLabClinico                       BOOLEAN,
                tieneInformeElectrocardiograma        BOOLEAN,
                tieneRadiografiaTorax                 BOOLEAN,
                tieneFichaAudiologica                 BOOLEAN,
                tieneAudiometriaPo                    BOOLEAN,
                tieneFuncionAbs                       BOOLEAN,
                tieneOdontograma                      BOOLEAN,
                tieneInformePsicologico               BOOLEAN,
                tieneAnexo16a                         BOOLEAN,
                tieneHistoriaOcInfo                   BOOLEAN,
                tieneAntecedentesPatologicos          BOOLEAN,
                tieneCuestionarioNordico              BOOLEAN,
                tieneCertificacionMedicaAltura        BOOLEAN,
                tieneFichaSas                         BOOLEAN,
                tieneConsentimientoDosaje             BOOLEAN,
                tienePerimetroToracico                BOOLEAN,
                tieneExRadiograficosSanguineos        BOOLEAN,
                tieneAnexo7c                          BOOLEAN,
                tieneOftalmologia                     BOOLEAN,
                tieneBCertificadoAltura               BOOLEAN,
                tieneBCertificadoConduccion           BOOLEAN,
                tieneBUsoRespiradores                 BOOLEAN,
                tieneCertificadoAptitudMoc            BOOLEAN,
                tieneOit                              BOOLEAN,
                tieneCuestionarioAudiometria          BOOLEAN,
                tieneInformeAudiometria               BOOLEAN,
                tieneEvaluacionMusculoEsqueletica     BOOLEAN,
                tieneAnexo7c2                         BOOLEAN,
                tieneCertificadoAptitudMoc1           BOOLEAN,
                tieneAptoAgroindustrial               BOOLEAN,
                tieneAnexoAgroindustrial              BOOLEAN,
                tieneCertificadoAnexo02               BOOLEAN,
                tieneAnexo02                          BOOLEAN,
                tieneAudiometria2021                  BOOLEAN,
                tieneEvaluacionMusculoEsqueletica2021 BOOLEAN,
                tieneCuestionarioCalidadSueno         BOOLEAN,
                tieneTestFatigaSomnolencia            BOOLEAN,
                tieneOftalmologia2021                 BOOLEAN,
                tieneCertificadoManipuladoresBarrick  BOOLEAN
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT CASE WHEN t.n_orden IS NULL THEN FALSE ELSE TRUE END     AS tieneTriaje
             , CASE WHEN lc.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneLabClinico
             , CASE WHEN ie.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneInformeElectrocardiograma
             , CASE WHEN rt.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneRadiografiaTorax
             , CASE WHEN fa.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneFichaAudiologica
             , CASE WHEN ap.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneAudiometriaPo
             , CASE WHEN fab.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneFuncionAbs
             , CASE WHEN od.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneOdontograma
             , CASE WHEN ip.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneInformePsicologico
             , CASE WHEN a16.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneAnexo16a
             , CASE WHEN hoi.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneHistoriaOcInfo
             , CASE WHEN ap2.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneAntecedentesPatologicos
             , CASE WHEN cn.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneCuestionarioNordico
             , CASE WHEN cma.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneCertificacionMedicaAltura
             , CASE WHEN fs.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneFichaSas
             , CASE WHEN cd.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneConsentimientoDosaje
             , CASE WHEN pt.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tienePerimetroToracico
             , CASE WHEN ers.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneExRadiograficosSanguineos
             , CASE WHEN a7.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneAnexo7c
             , CASE WHEN oft.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneOftalmologia
             , CASE WHEN bca.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneBCertificadoAltura
             , CASE WHEN bcc.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneBCertificadoConduccion
             , CASE WHEN bur.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneBUsoRespiradores
             , CASE WHEN camo.n_orden IS NULL THEN FALSE ELSE TRUE END  AS tieneCertificadoAptitudMoc
             , CASE WHEN oit.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneOit
             , CASE WHEN ca.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneCuestionarioAudiometria
             , CASE WHEN ia.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneInformeAudiometria
             , CASE WHEN eme.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneEvaluacionMusculoEsqueletica
             , CASE WHEN a7c2.n_orden IS NULL THEN FALSE ELSE TRUE END  AS tieneAnexo7c2
             , CASE WHEN camo1.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCertificadoAptitudMoc1
             , CASE WHEN amoag.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAptoAgroindustrial
             , CASE WHEN aa.n_orden IS NULL THEN FALSE ELSE TRUE END    AS tieneAnexoAgroindustrial
             , CASE WHEN caa02.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCertificadoAnexo02
             , CASE WHEN an02.n_orden IS NULL THEN FALSE ELSE TRUE END  AS tieneAnexo02
             , CASE WHEN a21.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneAudiometria2021
             , CASE WHEN eme21.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneEvaluacionMusculoEsqueletica2021
             , CASE WHEN ccs.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneCuestionarioCalidadSueno
             , CASE WHEN tfs.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneTestFatigaSomnolencia
             , CASE WHEN oft21.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneOftalmologia2021
             , CASE WHEN cmb.n_orden IS NULL THEN FALSE ELSE TRUE END   AS tieneCertificadoManipuladoresBarrick
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
        WHERE n.n_orden = p_n_orden;
END;
$$
    LANGUAGE plpgsql;

CREATE TABLE n_orden_examen_adicional
(
    id                            SERIAL PRIMARY KEY,
    n_orden                       BIGINT NOT NULL,
    id_examen_adicional_protocolo BIGINT NOT NULL,
    version_registro              INTEGER,
    usuario_registro              text,
    fecha_registro                date,
    hora_registro                 TIME,
    CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional (n_orden)
);

CREATE TABLE configuracion_deposito
(
    id                    SERIAL PRIMARY KEY,
    codigo_transferencia  TEXT,
    banco                 TEXT,
    monto                 numeric(38, 2),
    archivo               TEXT,
    usuario_registro      text,
    fecha_registro        date,
    hora_registro         TIME,
    usuario_actualizacion text,
    fecha_actualizacion   date,
    hora_actualizacion    TIME,
    estado                boolean
);

CREATE TABLE detalle_pago
(
    id                        SERIAL PRIMARY KEY,
    n_orden                   integer NOT NULL,
    version_registro          INTEGER,
    monto_adicionales         numeric(38, 2),
    monto_protocolo           numeric(38, 2),
    monto_total               numeric(38, 2),
    id_configuracion_deposito INTEGER,
    fecha_pago                date,
    hora_pago                 TIME,
    forma_pago                text,
    usuario_registro          text,
    fecha_registro            date,
    hora_registro             TIME,
    usuario_actualizacion     text,
    fecha_actualizacion       date,
    hora_actualizacion        TIME,
    estado                    boolean,
    CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional (n_orden),
    CONSTRAINT fk_id_configuracion_deposito FOREIGN KEY (id_configuracion_deposito) REFERENCES configuracion_deposito (id)
);

CREATE TABLE panel4d
(
    id            SERIAL PRIMARY KEY,
    n_orden       BIGINT NOT NULL UNIQUE,
    cocaina       BOOLEAN,
    marihuana     BOOLEAN,
    opiaceos      BOOLEAN,
    metanfetamina BOOLEAN,
    CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional (n_orden)
);

SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM certificado_aptitud_medico_resumen
WHERE n_orden = norden_param;
-----------------------------------------------------------------------------
--PGADMIN 4
--verificar el id porque no es autoincremental
INSERT INTO lista_parametros
values (54, 'Acuerdos de pago') --verificar el id porque no es autoincremental
INSERT
INTO detalle_parametro
values (49052, 'Credito', 54)
INSERT INTO detalle_parametro
values (49053, 'No Credito', 54)

ALTER TABLE protocolo
    RENAME COLUMN forma_pago TO acuerdo_pago;

ALTER TABLE protocolo
    add column forma_pago TEXT --

CREATE TABLE forma_pago
(
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

    CREATE TABLE protocolo_sub_examen_adicional( id_sub_examen_adicional_protocolo serial primary key, id_sub_examen Integer not null, id_protocolo INTEGER NOT NULL, precio numeric (38, 2), estado boolean, usuario_registro TEXT, fecha_registro DATE, hora_registro TIME, usuario_actualizacion TEXT, fecha_actualizacion DATE, hora_actualizacion TIME, CONSTRAINT fk_sub_examen FOREIGN KEY (id_sub_examen) REFERENCES sub_examen (id_sub_examen), CONSTRAINT fk_protocolo FOREIGN KEY (id_protocolo) REFERENCES protocolo (id_protocolo) );

CREATE TABLE protocolo_examen_adicional
(
    id_examen_adicional_protocolo serial primary key,
    id_examen                     Integer not null,
    id_protocolo                  INTEGER NOT NULL,
    precio                        numeric(38, 2),
    estado                        boolean,
    usuario_registro              TEXT,
    fecha_registro                DATE,
    hora_registro                 TIME,
    usuario_actualizacion         TEXT,
    fecha_actualizacion           DATE,
    hora_actualizacion            TIME,
    CONSTRAINT fk_examen FOREIGN KEY (id_examen) REFERENCES examen (id_examen),
    CONSTRAINT fk_protocolo FOREIGN KEY (id_protocolo) REFERENCES protocolo (id_protocolo)
);
-- BUSQUEDA DE EXAMENES SEGUN PROTOCOLO

CREATE
    OR REPLACE FUNCTION listado_examenes_protocolos_paciente(protocolo_param text, historia_clinica_param integer)
    RETURNS TABLE
            (
                id_archivos bigint,
                nombre      text,
                ruta        text,
                valor       boolean
            )
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000
AS
$BODY$
BEGIN
    RETURN QUERY
        SELECT cast(1 AS bigint)
             , cast(tb1.nombre AS text)                                         AS nombre
             , cast(tb2.ruta_Archivo AS text)                                   AS ruta
             , (CASE WHEN tb2.id_archivos is not null THEN true else false end) AS valor
        FROM (SELECT exam.prefijo
                   , exam.nombre
              FROM protocolo AS prot
                       INNER JOIN protocolo_examenes AS prot_exam
                                  ON prot.id_protocolo = prot_exam.id_protocolo
                       INNER JOIN examen AS exam
                                  ON prot_exam.id_examen = exam.id_examen
              WHERE prot.nombre = protocolo_param
                AND exam.prefijo IS NOT NULL) AS tb1
                 LEFT JOIN
             (SELECT arch_Serv.id_archivos
                   , arch_Serv.ruta_Archivo
                   , tip_Arch.nomenclatura
              FROM archivos_servidores AS arch_Serv
                       INNER JOIN tipo_archivo AS tip_Arch
                                  ON arch_Serv.id_tipo_archivo = tip_Arch.id_tipo_archivo
              WHERE arch_Serv.orden = historia_clinica_param) AS tb2
             ON tb1.prefijo = tb2.nomenclatura;
END;
$BODY$;
-- PG ADMIN 3

CREATE
    OR REPLACE FUNCTION listado_pacientes_protocolo_busqueda_filtros(razon_empresa_param text,
                                                                     razon_contrata_param text,
                                                                     name_protocolo_param text, fecha_inicio_param date,
                                                                     fecha_fin_param date)
    RETURNS TABLE
            (
                protocolos     text,
                nombres        text,
                dni            integer,
                n_orden        integer,
                razon_empresa  text,
                razon_contrata text,
                tipoexamen     text,
                fechaexamen    date
            )
    LANGUAGE 'plpgsql'
AS
$BODY$
BEGIN
    RETURN QUERY
        SELECT n.protocolo
             , dp.nombres_pa || ' ' || dp.apellidos_pa AS nombres
             , n.cod_pa                                AS dni
             , n.n_orden
             , n.razon_empresa
             , n.razon_contrata
             , n.nom_examen                            AS tipoExamen
             , n.fecha_apertura_po                     AS fechaExamen
        FROM n_orden_ocupacional AS n
                 INNER JOIN datos_paciente AS dp
                            ON n.cod_pa = dp.cod_pa
        WHERE n.razon_empresa = razon_empresa_param
          AND n.fecha_apertura_po BETWEEN fecha_inicio_param AND fecha_fin_param;
END;
$BODY$;
------------------------------------------------------------------

CREATE
    OR REPLACE FUNCTION public.listado_empleado_por_username(user_name text)
    RETURNS TABLE
            (
                id_empleado         bigint,
                apellidos           character varying,
                cargo               character varying,
                celular             character varying,
                cip                 character varying,
                correo_elect        character varying,
                direccion           character varying,
                estado              boolean,
                fecha_actualizacion date,
                fecha_nacimiento    date,
                fecha_registro      date,
                nombres             character varying,
                num_documento       bigint,
                tel_fijo            character varying,
                tipo_doc            character varying,
                ubigeo              character varying,
                user_actualizacion  character varying,
                user_registro       character varying,
                sexo                character varying,
                empresas            text,
                contratas           text
            )
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000
AS
$BODY$
DECLARE
    validar_empresa_hm BIGINT;
BEGIN

    SELECT COUNT(emp.id_empleado)
    into validar_empresa_hm
    FROM empleado AS emp
             INNER JOIN usuario AS us
                        ON emp.id_empleado = us.id_empleado
             INNER JOIN usuario_empresa_contrada AS uec
                        ON us.id_user = uec.id_user
    WHERE uec.ruc = '20477167561'
      AND us.username = user_name;
    IF
        (validar_empresa_hm > 0) THEN
        RETURN QUERY
            SELECT empl.id_empleado
                 , empl.apellidos
                 , empl.cargo
                 , empl.celular
                 , empl.cip
                 , empl.correo_elect
                 , empl.direccion
                 , empl.estado
                 , empl.fecha_actualizacion
                 , empl.fecha_nacimiento
                 , empl.fecha_registro
                 , empl.nombres
                 , empl.num_documento
                 , empl.tel_fijo
                 , empl.tipo_doc
                 , empl.ubigeo
                 , empl.user_actualizacion
                 , empl.user_registro
                 , empl.sexo
                 , (SELECT STRING_AGG(DISTINCT e1.razon_empresa, ' - ') AS empresas
                    FROM empleado AS empl1
                             INNER JOIN usuario AS us1
                                        ON empl1.id_empleado = us1.id_empleado
                             INNER JOIN usuario_empresa_contrada AS uec1
                                        ON us1.id_user = uec1.id_user
                             INNER JOIN empresas AS e1
                                        ON uec1.ruc = e1.ruc_empresa AND uec1.tipo = 'EMPRESA'
                    WHERE uec1.ruc IN (SELECT DISTINCT ue.ruc
                                       FROM usuario_empresa_contrada AS ue
                                                INNER JOIN usuario AS u ON ue.id_user = u.id_user
                                       WHERE u.username = user_name
                                         AND us1.id_empleado = empl.id_empleado)
                    GROUP BY empl1.id_empleado)
                 , (SELECT STRING_AGG(DISTINCT e1.razon_contrata, ' - ') AS contratas
                    FROM empleado AS empl1
                             INNER JOIN usuario AS us1
                                        ON empl1.id_empleado = us1.id_empleado
                             INNER JOIN usuario_empresa_contrada AS uec1
                                        ON us1.id_user = uec1.id_user
                             INNER JOIN contratas AS e1
                                        ON uec1.ruc = e1.ruc_contrata AND uec1.tipo = 'CONTRATA'
                    WHERE uec1.ruc IN (SELECT DISTINCT ue.ruc
                                       FROM usuario_empresa_contrada AS ue
                                                INNER JOIN usuario AS u ON ue.id_user = u.id_user
                                       WHERE u.username = user_name
                                         AND us1.id_empleado = empl.id_empleado)
                    GROUP BY empl1.id_empleado)
            FROM empleado AS empl;
    else
        RETURN QUERY
            SELECT emp.id_empleado
                 , emp.apellidos
                 , emp.cargo
                 , emp.celular
                 , emp.cip
                 , emp.correo_elect
                 , emp.direccion
                 , emp.estado
                 , emp.fecha_actualizacion
                 , emp.fecha_nacimiento
                 , emp.fecha_registro
                 , emp.nombres
                 , emp.num_documento
                 , emp.tel_fijo
                 , emp.tipo_doc
                 , emp.ubigeo
                 , emp.user_actualizacion
                 , emp.user_registro
                 , emp.sexo
                 , (SELECT STRING_AGG(DISTINCT e.razon_empresa, ' - ') AS empresas
                    FROM empleado AS empl
                             INNER JOIN usuario AS us
                                        ON empl.id_empleado = us.id_empleado
                             INNER JOIN usuario_empresa_contrada AS uec
                                        ON us.id_user = uec.id_user
                             INNER JOIN empresas AS e
                                        ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
                    WHERE uec.ruc IN (SELECT DISTINCT ue.ruc
                                      FROM usuario_empresa_contrada AS ue
                                               INNER JOIN usuario AS u ON ue.id_user = u.id_user
                                      WHERE u.username = user_name
                                        AND us.id_empleado = emp.id_empleado)
                    GROUP BY empl.id_empleado)
                 , (SELECT STRING_AGG(DISTINCT e.razon_contrata, ' - ') AS contratas
                    FROM empleado AS empl
                             INNER JOIN usuario AS us
                                        ON empl.id_empleado = us.id_empleado
                             INNER JOIN usuario_empresa_contrada AS uec
                                        ON us.id_user = uec.id_user
                             INNER JOIN contratas AS e
                                        ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
                    WHERE uec.ruc IN (SELECT DISTINCT ue.ruc
                                      FROM usuario_empresa_contrada AS ue
                                               INNER JOIN usuario AS u ON ue.id_user = u.id_user
                                      WHERE u.username = user_name
                                        AND us.id_empleado = emp.id_empleado)
                    GROUP BY empl.id_empleado)
            FROM empleado AS emp
            WHERE emp.id_empleado IN (SELECT distinct(empl.id_empleado)
                                      FROM empleado AS empl
                                               INNER JOIN usuario AS us
                                                          ON empl.id_empleado = us.id_empleado
                                               INNER JOIN usuario_empresa_contrada AS uec
                                                          ON us.id_user = uec.id_user
                                      WHERE uec.ruc IN (SELECT distinct(ue.ruc)
                                                        FROM usuario_empresa_contrada AS ue
                                                                 INNER JOIN usuario AS u
                                                                            ON ue.id_user = u.id_user
                                                        WHERE u.username = user_name))
            UNION
            SELECT e.id_empleado
                 , e.apellidos
                 , e.cargo
                 , e.celular
                 , e.cip
                 , e.correo_elect
                 , e.direccion
                 , e.estado
                 , e.fecha_actualizacion
                 , e.fecha_nacimiento
                 , e.fecha_registro
                 , e.nombres
                 , e.num_documento
                 , e.tel_fijo
                 , e.tipo_doc
                 , e.ubigeo
                 , e.user_actualizacion
                 , e.user_registro
                 , e.sexo
                 , (SELECT STRING_AGG(DISTINCT e.razon_empresa, ' - ') AS empresas
                    FROM empleado AS empl
                             INNER JOIN usuario AS us
                                        ON empl.id_empleado = us.id_empleado
                             INNER JOIN usuario_empresa_contrada AS uec
                                        ON us.id_user = uec.id_user
                             INNER JOIN empresas AS e
                                        ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
                    WHERE uec.ruc IN (SELECT DISTINCT ue.ruc
                                      FROM usuario_empresa_contrada AS ue
                                               INNER JOIN usuario AS u
                                                          ON ue.id_user = u.id_user
                                      WHERE u.username = user_name
                                        AND us.id_empleado = emp.id_empleado)
                    GROUP BY empl.id_empleado)
                 , (SELECT STRING_AGG(DISTINCT e.razon_contrata, ' - ') AS contratas
                    FROM empleado AS empl
                             INNER JOIN usuario AS us
                                        ON empl.id_empleado = us.id_empleado
                             INNER JOIN usuario_empresa_contrada AS uec
                                        ON us.id_user = uec.id_user
                             INNER JOIN contratas AS e
                                        ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
                    WHERE uec.ruc IN (SELECT DISTINCT ue.ruc
                                      FROM usuario_empresa_contrada AS ue
                                               INNER JOIN usuario AS u
                                                          ON ue.id_user = u.id_user
                                      WHERE u.username = user_name
                                        AND us.id_empleado = emp.id_empleado)
                    GROUP BY empl.id_empleado)
            FROM empleado AS e
            WHERE e.user_registro = user_name;
    end if;
END;
$BODY$;

ALTER FUNCTION public.listado_empleado_por_username(text) OWNER TO developerhm;
----- COPIA SEGURIDAD -----------
-- FUNCTION: public.listado_empleado_por_username(text)
-- DROP FUNCTION IF EXISTS public.listado_empleado_por_username(text);
CREATE
    OR REPLACE FUNCTION public.listado_empleado_por_username(user_name text)
    RETURNS TABLE
            (
                id_empleado         bigint,
                apellidos           character varying,
                cargo               character varying,
                celular             character varying,
                cip                 character varying,
                correo_elect        character varying,
                direccion           character varying,
                estado              boolean,
                fecha_actualizacion date,
                fecha_nacimiento    date,
                fecha_registro      date,
                nombres             character varying,
                num_documento       bigint,
                tel_fijo            character varying,
                tipo_doc            character varying,
                ubigeo              character varying,
                user_actualizacion  character varying,
                user_registro       character varying,
                sexo                character varying
            )
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000
AS
$BODY$
DECLARE
    validar_empresa_hm BIGINT;
BEGIN

    SELECT COUNT(emp.id_empleado)
    into validar_empresa_hm
    FROM empleado AS emp
             INNER JOIN usuario AS us
                        ON emp.id_empleado = us.id_empleado
             INNER JOIN usuario_empresa_contrada AS uec
                        ON us.id_user = uec.id_user
    WHERE uec.ruc = '20477167561'
      AND us.username = user_name;
    IF
        (validar_empresa_hm > 0) THEN
        RETURN QUERY
            SELECT empl.id_empleado
                 , empl.apellidos
                 , empl.cargo
                 , empl.celular
                 , empl.cip
                 , empl.correo_elect
                 , empl.direccion
                 , empl.estado
                 , empl.fecha_actualizacion
                 , empl.fecha_nacimiento
                 , empl.fecha_registro
                 , empl.nombres
                 , empl.num_documento
                 , empl.tel_fijo
                 , empl.tipo_doc
                 , empl.ubigeo
                 , empl.user_actualizacion
                 , empl.user_registro
                 , empl.sexo
            FROM empleado AS empl;
    else
        RETURN QUERY
            SELECT emp.id_empleado
                 , emp.apellidos
                 , emp.cargo
                 , emp.celular
                 , emp.cip
                 , emp.correo_elect
                 , emp.direccion
                 , emp.estado
                 , emp.fecha_actualizacion
                 , emp.fecha_nacimiento
                 , emp.fecha_registro
                 , emp.nombres
                 , emp.num_documento
                 , emp.tel_fijo
                 , emp.tipo_doc
                 , emp.ubigeo
                 , emp.user_actualizacion
                 , emp.user_registro
                 , emp.sexo
            FROM empleado AS emp
            WHERE emp.id_empleado IN (SELECT distinct(empl.id_empleado)
                                      FROM empleado AS empl
                                               INNER JOIN usuario AS us
                                                          ON empl.id_empleado = us.id_empleado
                                               INNER JOIN usuario_empresa_contrada AS uec
                                                          ON us.id_user = uec.id_user
                                      WHERE uec.ruc IN (SELECT distinct(ue.ruc)
                                                        FROM usuario_empresa_contrada AS ue
                                                                 INNER JOIN usuario AS u
                                                                            ON ue.id_user = u.id_user
                                                        WHERE u.username = user_name))
            UNION
            SELECT e.id_empleado
                 , e.apellidos
                 , e.cargo
                 , e.celular
                 , e.cip
                 , e.correo_elect
                 , e.direccion
                 , e.estado
                 , e.fecha_actualizacion
                 , e.fecha_nacimiento
                 , e.fecha_registro
                 , e.nombres
                 , e.num_documento
                 , e.tel_fijo
                 , e.tipo_doc
                 , e.ubigeo
                 , e.user_actualizacion
                 , e.user_registro
                 , e.sexo
            FROM empleado AS e
            WHERE e.user_registro = user_name;
    end if;
END;
$BODY$;

ALTER FUNCTION public.listado_empleado_por_username(text) OWNER TO developerhm;