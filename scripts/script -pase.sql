create function obtener_parametros_digitalizados(norden_param bigint, name_servicio_param text)
    returns TABLE(descripcion text, name_digitalizacion text, dni integer)
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

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(cms.usuario_firma, ''),
                           NULLIF(cms.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
            WHERE cms.n_orden = norden_param
              AND cms.name_conset = name_servicio_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
                AND cms.name_conset = name_servicio_param
            WHERE nof.n_orden = norden_param
               OR (cms.n_orden = norden_param AND cms.name_conset = name_servicio_param)
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
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

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(cms.usuario_firma, ''),
                           NULLIF(cms.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
            WHERE cms.n_orden = norden_param
              AND cms.name_conset = name_servicio_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
                AND cms.name_conset = name_servicio_param
            WHERE nof.n_orden = norden_param
               OR (cms.n_orden = norden_param AND cms.name_conset = name_servicio_param)
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var END;
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

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(cms.usuario_firma, ''),
                           NULLIF(cms.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
            WHERE cms.n_orden = norden_param
              AND cms.name_conset = name_servicio_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
                AND cms.name_conset = name_servicio_param
            WHERE nof.n_orden = norden_param
               OR (cms.n_orden = norden_param AND cms.name_conset = name_servicio_param)
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var END;
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
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(cms.usuario_firma, ''),
                           NULLIF(cms.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
            WHERE cms.n_orden = norden_param
              AND cms.name_conset = name_servicio_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
                AND cms.name_conset = name_servicio_param
            WHERE nof.n_orden = norden_param
               OR (cms.n_orden = norden_param AND cms.name_conset = name_servicio_param)
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
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
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(cms.usuario_firma, ''),
                           NULLIF(cms.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
            WHERE cms.n_orden = norden_param
              AND cms.name_conset = name_servicio_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
                AND cms.name_conset = name_servicio_param
            WHERE nof.n_orden = norden_param
               OR (cms.n_orden = norden_param AND cms.name_conset = name_servicio_param)
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
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
            SELECT COALESCE(
                           NULLIF(cms.usuario_firma, ''),
                           NULLIF(cms.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
            WHERE cms.n_orden = norden_param
              AND cms.name_conset = name_servicio_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
                AND cms.name_conset = name_servicio_param
            WHERE nof.n_orden = norden_param
               OR (cms.n_orden = norden_param AND cms.name_conset = name_servicio_param)
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(cms.usuario_firma, ''),
                           NULLIF(cms.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
            WHERE cms.n_orden = norden_param
              AND cms.name_conset = name_servicio_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_laboratorios cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
                AND cms.name_conset = name_servicio_param
            WHERE nof.n_orden = norden_param
               OR (cms.n_orden = norden_param AND cms.name_conset = name_servicio_param)
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
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
            SELECT COALESCE(
                           NULLIF(cb.usuario_firma, ''),
                           NULLIF(cb.user_registro, '')
                   )
            INTO user_registro_var
            FROM consent_Boro cb
            WHERE cb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(cms.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM consent_boro cms
                     LEFT JOIN n_orden_firma nof ON cms.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR cms.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;


    IF name_servicio_param = 'analisis_bioquimicos' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(ab.usuario_firma, ''),
                           NULLIF(ab.user_registro, '')
                   )
            INTO user_registro_var
            FROM analisis_bioquimicos ab
            WHERE ab.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN analisis_bioquimicos h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_ab BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
            ELSE
                SELECT COALESCE(
                               NULLIF(nof.profesional, ''),
                               NULLIF(ab.doctor_asignado, '')
                       )
                INTO user_registro_var
                FROM analisis_bioquimicos ab
                         LEFT JOIN n_orden_firma nof ON ab.n_orden = nof.n_orden
                WHERE nof.n_orden = norden_param
                   OR ab.n_orden = norden_param
                LIMIT 1;
                SELECT dni_user
                INTO dni_user_registro_var
                FROM usuarios
                WHERE UPPER(usuario_user) = UPPER(user_registro_var);

                dni_user_registro_var := CASE
                                             WHEN sede_var = 3 AND empresa_var = 'MONARCA GOLD S.A.C.' THEN
                                                 88888888
                                             WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                                                 42664426
                                             WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN
                                                 66666666
                                             ELSE dni_user_registro_var
                    END;
            END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;

    IF name_servicio_param = 'analisis_bioquimicos_glucosa_basal' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(ab.usuario_firma, ''),
                           NULLIF(ab.user_registro, '')
                   )
            INTO user_registro_var
            FROM analisis_bioquimicos ab
            WHERE ab.n_orden = norden_param
              AND ab.esglucosabasal = TRUE
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN analisis_bioquimicos h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_ab BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
            ELSE
                SELECT COALESCE(
                               NULLIF(nof.profesional, ''),
                               NULLIF(ab.doctor_asignado, '')
                       )
                INTO user_registro_var
                FROM analisis_bioquimicos ab
                         LEFT JOIN n_orden_firma nof ON ab.n_orden = nof.n_orden AND ab.esglucosabasal = TRUE
                WHERE nof.n_orden = norden_param
                   OR ab.n_orden = norden_param
                LIMIT 1;
                SELECT dni_user
                INTO dni_user_registro_var
                FROM usuarios
                WHERE UPPER(usuario_user) = UPPER(user_registro_var);
                dni_user_registro_var := CASE
                                             WHEN sede_var = 3 AND empresa_var = 'MONARCA GOLD S.A.C.' THEN 88888888
                                             WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                                                 42664426
                                             WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN
                                                 66666666
                                             ELSE dni_user_registro_var
                    END;
            END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF (name_servicio_param = 'lab_clinico' OR
        name_servicio_param = 'lab_clinico_examen_orina' OR
        name_servicio_param = 'lab_clinico_hemoglobina') THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(lc.usuario_firma, ''),
                           NULLIF(lc.user_registro, '')
                   )
            INTO user_registro_var
            FROM lab_clinico lc
            WHERE lc.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN lab_clinico h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_lab BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
            ELSE
                SELECT COALESCE(
                               NULLIF(nof.profesional, ''),
                               NULLIF(lc.doctor_asignado, '')
                       )
                INTO user_registro_var
                FROM lab_clinico lc
                         LEFT JOIN n_orden_firma nof ON lc.n_orden = nof.n_orden
                WHERE nof.n_orden = norden_param
                   OR lc.n_orden = norden_param
                LIMIT 1;
                SELECT dni_user
                INTO dni_user_registro_var
                FROM usuarios
                WHERE UPPER(usuario_user) = UPPER(user_registro_var);
                dni_user_registro_var := CASE
                                             WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                             WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                             ELSE dni_user_registro_var
                    END;
            END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'hemograma_autom' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(ha.usuario_firma, ''),
                           NULLIF(ha.user_registro, '')
                   )
            INTO user_registro_var
            FROM hemograma_autom ha
            WHERE ha.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(ha.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM hemograma_autom ha
                     LEFT JOIN n_orden_firma nof ON ha.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR ha.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'lgonadotropina' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(lg.usuario_firma, ''),
                           NULLIF(lg.user_registro, '')
                   )
            INTO user_registro_var
            FROM lgonadotropina lg
            WHERE lg.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(lg.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM lgonadotropina lg
                     LEFT JOIN n_orden_firma nof ON lg.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR lg.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                                             42664426
                                         ELSE dni_user_registro_var
                END;

            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'panel2d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(p2d.usuario_firma, ''),
                           NULLIF(p2d.user_registro, '')
                   )
            INTO user_registro_var
            FROM panel2d p2d
            WHERE p2d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(p2d.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM panel2d p2d
                     LEFT JOIN n_orden_firma nof ON p2d.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR p2d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;

            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'panel3d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(p3d.usuario_firma, ''),
                           NULLIF(p3d.user_registro, '')
                   )
            INTO user_registro_var
            FROM panel3d p3d
            WHERE p3d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(p3d.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM panel3d p3d
                     LEFT JOIN n_orden_firma nof ON p3d.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR p3d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;

    IF name_servicio_param = 'panel4d' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(p4d.usuario_firma, ''),
                           NULLIF(p4d.user_registro, '')
                   )
            INTO user_registro_var
            FROM panel4d p4d
            WHERE p4d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(p4d.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM panel4d p4d
                     LEFT JOIN n_orden_firma nof ON p4d.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR p4d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'toxicologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(t.usuario_firma, ''),
                           NULLIF(t.user_registro, '')
                   )
            INTO user_registro_var
            FROM toxicologia t
            WHERE t.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN t.usuario_firma IS NULL THEN t.user_registro
                               ELSE t.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM toxicologia t
                     LEFT JOIN n_orden_firma nof ON t.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR t.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'panel10d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(p10d.usuario_firma, ''),
                           NULLIF(p10d.user_registro, '')
                   )
            INTO user_registro_var
            FROM panel10d p10d
            WHERE p10d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(p10d.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM panel10d p10d
                     LEFT JOIN n_orden_firma nof ON p10d.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR p10d.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;


    END IF;


    IF name_servicio_param = 'inmunologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(i.usuario_firma, ''),
                           NULLIF(i.user_registro, '')
                   )
            INTO user_registro_var
            FROM inmunologia i
            WHERE i.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(i.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM inmunologia i
                     LEFT JOIN n_orden_firma nof ON i.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR i.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


    IF name_servicio_param = 'microbiologia' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(mb.usuario_firma, ''),
                           NULLIF(mb.user_registro, '')
                   )
            INTO user_registro_var
            FROM microbiologia mb
            WHERE mb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(mb.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM microbiologia mb
                     LEFT JOIN n_orden_firma nof ON mb.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR mb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'koh' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(mb.usuario_firma, ''),
                           NULLIF(mb.user_registro, '')
                   )
            INTO user_registro_var
            FROM koh mb
            WHERE mb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(mb.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM koh mb
                     LEFT JOIN n_orden_firma nof ON mb.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR mb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'lhepatitis' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(lh.usuario_firma, ''),
                           NULLIF(lh.user_registro, '')
                   )
            INTO user_registro_var
            FROM lhepatitis lh
            WHERE lh.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(lh.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM lhepatitis lh
                     LEFT JOIN n_orden_firma nof ON lh.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR lh.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'hepatitis_b' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(lb.usuario_firma, ''),
                           NULLIF(lb.user_registro, ''),
                           NULLIF(lh.usuario_firma, ''),
                           NULLIF(lh.user_registro, '')
                   )
            INTO user_registro_var
            FROM hepatitis_b lb
                     FULL JOIN lhepatitis lh
                               ON lb.n_orden = lh.n_orden
            WHERE
                (
                    -- Prioridad 1: existe en hepatitis_c
                    lb.n_orden = 96639
                    )
               OR
                (
                    -- Prioridad 2: NO existe en hepatitis_c
                    lb.n_orden IS NULL
                        AND lh.n_orden = 96639
                        AND NULLIF(TRIM(lh.hepatitisc), '') IS NOT NULL
                    )
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           (SELECT NULLIF(profesional, '')
                            FROM n_orden_firma
                            WHERE n_orden = norden_param
                            LIMIT 1),
                           (SELECT NULLIF(doctor_asignado, '')
                            FROM hepatitis_b
                            WHERE n_orden = norden_param
                            LIMIT 1),
                           (SELECT NULLIF(doctor_asignado, '')
                            FROM lhepatitis
                            WHERE n_orden = norden_param
                              AND NULLIF(TRIM(txthepatitisb), '') IS NOT NULL
                            LIMIT 1)
                   )
            INTO user_registro_var;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'hepatitis_c' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(lb.usuario_firma, ''),
                           NULLIF(lb.user_registro, ''),
                           NULLIF(lh.usuario_firma, ''),
                           NULLIF(lh.user_registro, '')
                   )
            INTO user_registro_var
            FROM hepatitis_c lb
                     FULL JOIN lhepatitis lh
                               ON lb.n_orden = lh.n_orden
            WHERE
                (
                    -- Prioridad 1: existe en hepatitis_c
                    lb.n_orden = 96639
                    )
               OR
                (
                    -- Prioridad 2: NO existe en hepatitis_c
                    lb.n_orden IS NULL
                        AND lh.n_orden = 96639
                        AND NULLIF(TRIM(lh.hepatitisc), '') IS NOT NULL
                    )
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           (SELECT NULLIF(profesional, '')
                            FROM n_orden_firma
                            WHERE n_orden = norden_param
                            LIMIT 1),
                           (SELECT NULLIF(doctor_asignado, '')
                            FROM hepatitis_c
                            WHERE n_orden = norden_param
                            LIMIT 1),
                           (SELECT NULLIF(doctor_asignado, '')
                            FROM lhepatitis
                            WHERE n_orden = norden_param
                              AND NULLIF(TRIM(hepatitisc), '') IS NOT NULL
                            LIMIT 1)
                   )
            INTO user_registro_var;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

-- perfil renal
    IF name_servicio_param = 'l_bioquimica' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(lb.usuario_firma, ''),
                           NULLIF(lb.user_registro, '')
                   )
            INTO user_registro_var
            FROM l_bioquimica lb
            WHERE lb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(lb.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM l_bioquimica lb
                     LEFT JOIN n_orden_firma nof ON lb.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR lb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;


-- acido urino
    IF name_servicio_param = 'ac_bioquimica2022' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(ab22.usuario_firma, ''),
                           NULLIF(ab22.user_registro, '')
                   )
            INTO user_registro_var
            FROM ac_bioquimica2022 ab22
            WHERE ab22.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(ab22.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM ac_bioquimica2022 ab22
                     LEFT JOIN n_orden_firma nof ON ab22.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR ab22.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


-- perfil hepatico
    IF name_servicio_param = 'perfil_hepatico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(ph.usuario_firma, ''),
                           NULLIF(ph.user_registro, '')
                   )
            INTO user_registro_var
            FROM perfil_hepatico ph
            WHERE ph.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN ph.usuario_firma IS NULL THEN ph.user_registro
                               ELSE ph.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM perfil_hepatico ph
                     LEFT JOIN n_orden_firma nof ON ph.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR ph.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

    END IF;


-- coprocultivo
    IF name_servicio_param = 'ac_coprocultivo' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(acc.usuario_firma, ''),
                           NULLIF(acc.user_registro, '')
                   )
            INTO user_registro_var
            FROM ac_coprocultivo acc
            WHERE acc.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(acc.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM ac_coprocultivo acc
                     LEFT JOIN n_orden_firma nof ON acc.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR acc.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         ELSE dni_user_registro_var END;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;


    END IF;

-- coproparasitologico

    IF name_servicio_param = 'ac_coproparasitologico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(acco.usuario_firma, ''),
                           NULLIF(acco.user_registro, '')
                   )
            INTO user_registro_var
            FROM ac_coproparasitologico acco
            WHERE acco.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(acc.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM ac_coprocultivo acc
                     LEFT JOIN n_orden_firma nof ON acc.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR acc.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
            SELECT COALESCE(
                           NULLIF(ei.usuario_firma, ''),
                           NULLIF(ei.user_registro, '')
                   )
            INTO user_registro_var
            FROM examen_inmunologico ei
            WHERE ei.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(ei.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM examen_inmunologico ei
                     LEFT JOIN n_orden_firma nof ON ei.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR ei.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
            SELECT COALESCE(
                           NULLIF(a23.usuario_firma, ''),
                           NULLIF(a23.user_registro, '')
                   )
            INTO user_registro_var
            FROM audiometria_2023 a23
            WHERE a23.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(fa.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM audiometria_2023 fa
                     LEFT JOIN n_orden_firma nof ON fa.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR fa.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         ELSE dni_user_registro_var
                END;
        END IF;
        descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
        name_digitalizacion := 'SELLOFIRMADOCASIG';
        dni := dni_user_registro_var;
        RETURN NEXT;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN hoi.usuario_firma IS NULL THEN hoi.user_registro
                               ELSE hoi.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM historia_oc_info hoi
                     LEFT JOIN n_orden_firma nof ON hoi.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR hoi.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(fa.usuario_firma, ''),
                           NULLIF(fa.user_registro, '')
                   )
            INTO user_registro_var
            FROM ficha_audiologica fa
            WHERE fa.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 74723311
                                         ELSE dni_user_registro_var
                END;

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;

        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN ficha_audiologica h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_examen BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
            ELSE
                SELECT COALESCE(
                               NULLIF(nof.profesional, ''),
                               NULLIF(fa.doctor_asignado, '')
                       )
                INTO user_registro_var
                FROM ficha_audiologica fa
                         LEFT JOIN n_orden_firma nof ON fa.n_orden = nof.n_orden
                WHERE nof.n_orden = norden_param
                   OR fa.n_orden = norden_param
                LIMIT 1;
                SELECT dni_user
                INTO dni_user_registro_var
                FROM usuarios
                WHERE UPPER(usuario_user) = UPPER(user_registro_var);

                dni_user_registro_var := CASE
                                             WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                             WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                             ELSE dni_user_registro_var
                    END;

            END IF;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_adic FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM ficha_audiologica
                       WHERE n_orden = norden_param
                         AND doctor_extra IS NOT NULL) THEN
                SELECT doctor_extra
                INTO user_registro_var
                FROM ficha_audiologica
                WHERE n_orden = norden_param;
                SELECT dni_user
                INTO dni_user_registro_var
                FROM usuarios
                WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            ELSE
                IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                    dni_user_registro_var := 55555555;
                ELSE
                    dni_user_registro_var := 1;
                end if;
            END IF;
            descripcion := 'SELLO DEL DOCTOR ADICIONAL';
            name_digitalizacion := 'SELLOFIRMADOCASIG-EXTRA';
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
            SELECT ca.user_registro
            INTO user_registro_var
            FROM cuestionario_audiometria ca
            WHERE ca.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'oftalmologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE
                       WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                       ELSE a7c.usuario_firma
                       END
            INTO user_registro_var
            FROM oftalmologia a7c
            WHERE a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN oftalmologia h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_of BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
            ELSE
                SELECT COALESCE(
                               NULLIF(nof.profesional, ''),
                               NULLIF(fa.doctor_asignado, '')
                       )
                INTO user_registro_var
                FROM oftalmologia fa
                         LEFT JOIN n_orden_firma nof ON fa.n_orden = nof.n_orden
                WHERE nof.n_orden = norden_param
                   OR fa.n_orden = norden_param
                LIMIT 1;
                SELECT dni_user
                INTO dni_user_registro_var
                FROM usuarios
                WHERE UPPER(usuario_user) = UPPER(user_registro_var);

                dni_user_registro_var := CASE
                                             WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                             WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                             ELSE dni_user_registro_var
                    END;
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
            SELECT COALESCE(
                           NULLIF(a7c.usuario_firma, ''),
                           NULLIF(a7c.user_registro, '')
                   )
            INTO user_registro_var
            FROM oftalmologia2021 a7c
            WHERE a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(fa.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM oftalmologia2021 fa
                     LEFT JOIN n_orden_firma nof ON fa.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR fa.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(a7c.usuario_firma, ''),
                           NULLIF(a7c.user_registro, '')
                   )
            INTO user_registro_var
            FROM radiografia_torax a7c
            WHERE a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'radiografia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(a7c.usuario_firma, ''),
                           NULLIF(a7c.user_registro, '')
                   )
            INTO user_registro_var
            FROM radiografia a7c
            WHERE a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'oit' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(a7c.usuario_firma, ''),
                           NULLIF(a7c.user_registro, '')
                   )
            INTO user_registro_var
            FROM oit a7c
            WHERE a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN eme.usuario_firma IS NULL THEN eme.user_registro
                               ELSE eme.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM evaluacion_musculo_esqueletica eme
                     LEFT JOIN n_orden_firma nof ON eme.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR eme.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN eme.usuario_firma IS NULL THEN eme.user_registro
                               ELSE eme.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM evaluacion_musculo_esqueletica2021 eme
                     LEFT JOIN n_orden_firma nof ON eme.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR eme.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN eme.usuario_firma IS NULL THEN eme.user_registro
                               ELSE eme.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM cuestionario_nordico eme
                     LEFT JOIN n_orden_firma nof ON eme.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR eme.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN tfs.usuario_firma IS NULL THEN tfs.user_registro
                               ELSE tfs.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM test_fatiga_somnolencia tfs
                     LEFT JOIN n_orden_firma nof ON tfs.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR tfs.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_electrocardiograma' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(a7c.usuario_firma, ''),
                           NULLIF(a7c.user_registro, '')
                   )
            INTO user_registro_var
            FROM informe_electrocardiograma a7c
            WHERE a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN completo_electro_var = TRUE THEN 70436528
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;

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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN aea.usuario_firma IS NULL THEN aea.user_registro
                               ELSE aea.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM antece_enfermedades_altura aea
                     LEFT JOIN n_orden_firma nof ON aea.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR aea.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT doctor_asignado
            INTO user_registro_var
            FROM antece_enfermedades_altura
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN aa.usuario_firma IS NULL THEN aa.user_registro
                               ELSE aa.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM anexo_agroindustrial aa
                     LEFT JOIN n_orden_firma nof ON aa.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR aa.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM anexo7c a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM anexo16a a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM antecedentes_patologicos a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'aptitud_medico_ocupacional_agro' THEN ---cambios por sede, por hacer
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            --             SELECT COALESCE(
--                            NULLIF(a7c.usuario_firma, ''),
--                            NULLIF(a7c.user_registro, '')
--                    )
--             INTO user_registro_var
--             FROM aptitud_medico_ocupacional_agro a7c
--             WHERE a7c.n_orden = norden_param
--             LIMIT 1;
--             SELECT dni_user
--             INTO dni_user_registro_var
--             FROM usuarios
--             WHERE UPPER(usuario_user) = UPPER(user_registro_var);
--             SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
            dni_user_registro_var := CASE
                                         WHEN sede_var = 3 THEN 88888888
                --                                          WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 88888888
--                                          WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE
                                             CASE
                                                 WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                                                     88888888
                                                 ELSE
                                                     66666666
                                                 END
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'certificado_aptitud_medico_ocupacional' THEN ---cambios por sede, por hacer
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            --             SELECT COALESCE(
--                            NULLIF(a7c.usuario_firma, ''),
--                            NULLIF(a7c.user_registro, '')
--                    )
--             INTO user_registro_var
--             FROM anexo7c a7c
--             WHERE a7c.n_orden = norden_param
--             LIMIT 1;
--             SELECT dni_user
--             INTO dni_user_registro_var
--             FROM usuarios
--             WHERE UPPER(usuario_user) = UPPER(user_registro_var);
--             SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
            dni_user_registro_var := CASE
                                         WHEN sede_var = 3 THEN 88888888
                --                                          WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 88888888
--                                          WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE
                                             CASE
                                                 WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                                                     88888888
                                                 ELSE
                                                     66666666
                                                 END
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM ficha_sas a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM certificado_aptitud_medico_resumen a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            SELECT cod_sede INTO sede_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
            dni_user_registro_var := CASE
                                         WHEN sede_var = 3 THEN 88888888
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM b_certificado_conduccion a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM b_certificado_altura a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM b_uso_respiradores a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'ficha_psicologica_anexo02' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM certificado_altura_poderosa a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT doctor_asignado
            INTO user_registro_var
            FROM certificado_altura_poderosa
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM aptitud_altura_poderosa a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT doctor_asignado
            INTO user_registro_var
            FROM aptitud_altura_poderosa
            WHERE n_orden = norden_param;
            select dni_user
            into dni_user_registro_var
            from usuarios
            where UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM aptitud_trabajos_encaliente a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM aptitud_licencia_conduciri a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM hoja_consulta_externa a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM certificado_aptitud_herramientas_manuales a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'resumen_medico_poderosa' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM anexo7c a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN sede_var = 3 AND empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 88888888
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 88888888
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM anexo7c a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_psicologico_estres' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM informe_psicologico_estres
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

    IF name_servicio_param = 'evaluacion_psicologica_poderosa_normal' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM evaluacion_psicologica_poderosa
            WHERE n_orden = norden_param
              AND (chktrabcalientes IS DISTINCT FROM true
                AND chklicencia IS DISTINCT FROM true);
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

    IF name_servicio_param = 'evaluacion_psicologica_poderosa_licencia' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM evaluacion_psicologica_poderosa
            WHERE n_orden = norden_param
              AND chklicencia = true;
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

    IF name_servicio_param = 'evaluacion_psicologica_poderosa_caliente' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM evaluacion_psicologica_poderosa
            WHERE n_orden = norden_param
              AND chktrabcalientes = true;
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
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
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM certificacion_medica_altura a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            dni_user_registro_var := CASE
                                         WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN 42664426
                                         WHEN empresa_var = 'MONARCA GOLD S.A.C.' THEN 66666666
                                         ELSE dni_user_registro_var
                END;
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
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(a7c.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM riesgocoronario a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
            SELECT COALESCE(
                           NULLIF(iv.usuario_firma, ''),
                           NULLIF(iv.user_registro, '')
                   )
            INTO user_registro_var
            FROM inmunologia_vdrl iv
            WHERE iv.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(iv.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM inmunologia_vdrl iv
                     LEFT JOIN n_orden_firma nof ON iv.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR iv.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(a7c.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM vih a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
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
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(a7c.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM vih a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'calidad_sueño' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM calidad_sueño
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
    IF name_servicio_param = 'registro_conformidad_emo' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN rce.usuario_firma IS NULL THEN rce.user_registro
                               ELSE rce.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM registro_conformidad_emo rce
                     LEFT JOIN n_orden_firma nof ON rce.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR rce.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);

            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
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
    IF name_servicio_param = 'consta_brigadista' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN cb.usuario_firma IS NULL THEN cb.user_registro
                               ELSE cb.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM consta_brigadista cb
                     LEFT JOIN n_orden_firma nof ON cb.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR cb.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
    IF name_servicio_param = 'funcion_abs' THEN
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
            FROM funcion_abs
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

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(fa.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM funcion_abs fa
                     LEFT JOIN n_orden_firma nof ON fa.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR fa.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := dni_user_registro_var;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
        IF (SELECT sello_doc_adic FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT doctor_extra
            INTO user_registro_var
            FROM funcion_abs
            WHERE n_orden = norden_param;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL DOCTOR ADICIONAL';
            name_digitalizacion := 'SELLOFIRMADOCASIG-EXTRA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
    

 IF name_servicio_param = 'etanol_saliva' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM etanol_saliva
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
       IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(fa.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM etanol_saliva fa
                     LEFT JOIN n_orden_firma nof ON fa.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR fa.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := dni_user_registro_var;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
    IF name_servicio_param = 'pcr_ultrasensible' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM pcr_ultrasensible
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
     IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(fa.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM etanol_saliva fa
                     LEFT JOIN n_orden_firma nof ON fa.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR fa.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            dni_user_registro_var := dni_user_registro_var;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
    IF name_servicio_param = 'certificado_aptitud_brigadista' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
            INTO user_registro_var
            FROM certificado_aptitud_brigadista
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
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           NULLIF(iv.doctor_asignado, '')
                   )
            INTO user_registro_var
            FROM certificado_aptitud_brigadista iv
                     LEFT JOIN n_orden_firma nof ON iv.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR iv.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;
    
    IF name_servicio_param = 'ficha_datos_paciente' THEN
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
            SELECT COALESCE(
                           NULLIF(nof.profesional, ''),
                           CASE
                               WHEN a7c.usuario_firma IS NULL THEN a7c.user_registro
                               ELSE a7c.usuario_firma
                               END
                   )
            INTO user_registro_var
            FROM ficha_datos_personales a7c
                     LEFT JOIN n_orden_firma nof ON a7c.n_orden = nof.n_orden
            WHERE nof.n_orden = norden_param
               OR a7c.n_orden = norden_param
            LIMIT 1;
            SELECT dni_user
            INTO dni_user_registro_var
            FROM usuarios
            WHERE UPPER(usuario_user) = UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;

        --         IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
--             IF EXISTS (SELECT 1
--                        FROM n_orden_ocupacional n
--                                 INNER JOIN ficha_audiologica h ON n.n_orden = h.n_orden
--                        WHERE n.cod_sede = 5
--                          AND h.fecha_examen BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
--                          AND h.n_orden = norden_param) THEN
--                 dni_user_registro_var := 72537588;
--             ELSIF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             ELSE
--                 dni_user_registro_var := 1;
--             END IF;
--             descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
--             name_digitalizacion := 'SELLOFIRMADOCASIG';
--             dni := dni_user_registro_var;
--             RETURN NEXT;
--         END IF;
    END IF;
END;
$$;

alter function obtener_parametros_digitalizados(bigint, text) owner to pierola;




alter table certificacion_medica_altura add column doctor_asignado text

--cambiar en config_general_service_digital y agregar el doctor_asignado


alter table b_certificado_conduccion add column doctor_asignado text

--cambiar en config_general_service_digital y agregar el doctor_asignado


alter table b_certificado_altura add column doctor_asignado text

--cambiar en config_general_service_digital y agregar el doctor_asignado


------------------------------------------------------------------------------------------------------
CREATE TABLE error_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo_error VARCHAR(50) NOT NULL,
    origen VARCHAR(100) NOT NULL,
    mensaje TEXT NOT NULL,
    detalle TEXT,
    payload JSONB,
    fecha TIMESTAMP NOT NULL DEFAULT NOW(),
    estado VARCHAR(20) NOT NULL, -- PENDIENTE / RESUELTO
    usuario VARCHAR(50),
    referencia VARCHAR(100),
    stacktrace TEXT
);

CREATE INDEX idx_error_log_codigo ON error_log(codigo_error);
CREATE INDEX idx_error_log_fecha ON error_log(fecha);
CREATE INDEX idx_error_log_estado ON error_log(estado);

ALTER TABLE error_log
    ADD COLUMN endpoint VARCHAR(150),
    ADD COLUMN metodo_http VARCHAR(10);

create table prospecto(
    id SERIAL PRIMARY KEY,
    estado TEXT,
    numero_documento bigint,
    nombre varchar(50),
    apellido varchar(50),
    telefono TEXT,
    correo TEXT,
    empresa TEXT,
    fecha_registro date,
    direccion TEXT,
    sexo TEXT,
    tipo_documento varchar(30),
    ubigeo varchar(6),
    usuario_actualizacion text,
    fecha_actualizacion date
);

CREATE TABLE n_orden_examen_adicional ( id SERIAL PRIMARY KEY, n_orden BIGINT NOT NULL, id_examen_adicional_protocolo BIGINT NOT NULL, version_registro INTEGER, usuario_registro text, fecha_registro date, hora_registro TIME, CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional(n_orden) );

CREATE TABLE configuracion_deposito ( id SERIAL PRIMARY KEY, codigo_transferencia TEXT, banco TEXT, monto numeric(38, 2), archivo TEXT, usuario_registro text, fecha_registro date, hora_registro TIME, usuario_actualizacion text, fecha_actualizacion date, hora_actualizacion TIME, estado boolean );

CREATE TABLE detalle_pago ( id SERIAL PRIMARY KEY, n_orden integer NOT NULL, version_registro INTEGER, monto_adicionales numeric(38, 2), monto_protocolo numeric(38, 2), monto_total numeric(38, 2), id_configuracion_deposito INTEGER, fecha_pago date, hora_pago TIME, forma_pago text, usuario_registro text, fecha_registro date, hora_registro TIME, usuario_actualizacion text, fecha_actualizacion date, hora_actualizacion TIME, estado boolean, CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional(n_orden), CONSTRAINT fk_id_configuracion_deposito FOREIGN KEY (id_configuracion_deposito) REFERENCES configuracion_deposito(id) );

SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificado_aptitud_medico_resumen
WHERE n_orden = norden_param;
-----------------------------------------------------------------------------
--PGADMIN 4
CREATE OR REPLACE FUNCTION obtener_examenes_hoja_ruta(
    p_id_protocolo INTEGER,
    p_ids_adicionales INTEGER[]
)
    RETURNS JSONB
    LANGUAGE plpgsql
AS $$
DECLARE
    v_resultado JSONB;
BEGIN
    WITH
        -- 1. Exámenes Regulares con sus sub-exámenes
        examenes_regulares AS (
            SELECT
                a.id_area,
                jsonb_agg(
                        jsonb_build_object(
                                'id_examen', ex.id_examen,
                                'nombre', ex.nombre,
                                'sub_examenes', COALESCE(
                                        (
                                            SELECT jsonb_agg(
                                                           jsonb_build_object(
                                                                   'id_sub_examen', se.id_sub_examen,
                                                                   'nombre', se.descripcion
                                                           )
                                                   )
                                            FROM sub_examen se
                                                     INNER JOIN protocolo_sub_examenes pse
                                                                ON pse.id_sub_examen = se.id_sub_examen
                                                                    AND pse.estado = true
                                            WHERE se.id_examen = ex.id_examen
                                              AND se.estado = true
                                              AND pse.id_protocolo = p_id_protocolo
                                        ),
                                        '[]'::jsonb
                                                )
                        )
                ) AS lista_examenes
            FROM examen ex
                     INNER JOIN protocolo_examenes pe ON ex.id_examen = pe.id_examen
                     INNER JOIN area a ON ex.id_area = a.id_area
            WHERE pe.id_protocolo = p_id_protocolo
              AND ex.estado = true
            GROUP BY a.id_area
        ),

        -- 2. Exámenes Adicionales con sus sub-exámenes
        examenes_adicionales AS (
            SELECT
                a.id_area,
                jsonb_agg(
                        jsonb_build_object(
                                'id_examen', ex.id_examen,
                                'nombre', ex.nombre,
                                'id_examen_adicional_protocolo', pea.id_examen_adicional_protocolo,
                                'sub_examenes', COALESCE(
                                        (
                                            SELECT jsonb_agg(
                                                           jsonb_build_object(
                                                                   'id_sub_examen', se.id_sub_examen,
                                                                   'nombre', se.descripcion
                                                           )
                                                   )
                                            FROM sub_examen se
                                                     INNER JOIN protocolo_sub_examenes pse
                                                                ON pse.id_sub_examen = se.id_sub_examen
                                                                    AND pse.estado = true
                                            WHERE se.id_examen = ex.id_examen
                                              AND se.estado = true
                                              AND pse.id_protocolo = p_id_protocolo
                                        ),
                                        '[]'::jsonb
                                                )
                        )
                ) AS lista_adicionales
            FROM examen ex
                     INNER JOIN protocolo_examen_adicional pea ON ex.id_examen = pea.id_examen
                     INNER JOIN area a ON ex.id_area = a.id_area
            WHERE pea.id_protocolo = p_id_protocolo
              AND pea.id_examen_adicional_protocolo = ANY(p_ids_adicionales) -- Filtrado correcto por array
              AND ex.estado = true
            GROUP BY a.id_area
        )

    -- 3. Todo por Área
    SELECT
        jsonb_agg(
                jsonb_build_object(
                        'id_area', a.id_area,
                        'nombre_area', a.descripcion,
                        'examenes', COALESCE(er.lista_examenes, '[]'::jsonb),
                        'examenes_adicionales', COALESCE(ea.lista_adicionales, '[]'::jsonb)
                )
        ) INTO v_resultado
    FROM area a
             LEFT JOIN examenes_regulares er ON a.id_area = er.id_area
             LEFT JOIN examenes_adicionales ea ON a.id_area = ea.id_area
    WHERE er.id_area IS NOT NULL OR ea.id_area IS NOT NULL;

    -- Devolvemos array vacío si no hay resultados en lugar de NULL
    RETURN COALESCE(v_resultado, '[]'::jsonb);
END;
$$;


--verificar el id porque no es autoincremental 
INSERT INTO lista_parametros values (54, 'Acuerdos de pago') --verificar el id porque no es autoincremental 
INSERT INTO detalle_parametro values (49052, 'Credito', 54)
INSERT INTO detalle_parametro values (49053, 'No Credito', 54)

ALTER TABLE protocolo RENAME COLUMN forma_pago TO acuerdo_pago;

ALTER TABLE protocolo add column forma_pago TEXT -- 

-- CREATE TABLE forma_pago(
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