select n_orden from n_orden_ocupacional limit 1

DROP FUNCTION obtener_reporte_pacientes_matriz_ohla_construccion(text, text, text);

CREATE OR REPLACE FUNCTION obtener_reporte_pacientes_matriz_ohla_gestor(
    IN p_ruc_empresa text,
    IN p_fecha_inicio text,
    IN p_fecha_fin text,
    IN p_sede text)
  RETURNS TABLE(n integer, fecha_evaluacion date, centro_costo text, razon_empresa text, razon_contrata text, nombres text, sexo_pa "char", dni integer, puesto text, edad text, grupo_factor_sanguineo text, tipodemo text, resultado text, txtobserv2 text, dx_audiometria text, dx_radiologico text, dx_radiologico_oit text, dx_espirometria text, dx_imc text, dx_oftalmologico text, glucosa text, conclusion_glucosa text, perfil_lipidico text, conclusion_perfil_lipidico text, conclusion_creatinina text, sistolica text, diastolica text, ekg_resultado text, conclusiones_ficha_anexo16 text, aptitud_ocupacional text, aptitud_psicologica text, diagnostico_musculo_esqueletico text) AS
$BODY$
BEGIN
    RETURN QUERY
    SELECT 
        n.n_orden,
        n.fecha_apertura_po AS fecha_evaluacion,
        n.txtobserv2 AS centro_costo,
        n.razon_empresa,
        n.razon_contrata,
        TRIM(d.apellidos_pa) || ' ' || TRIM(d.nombres_pa) AS nombres,
        d.sexo_pa,
        d.cod_pa AS dni,
        n.cargo_de AS puesto,
        CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT) AS edad,
        (
            CASE 
                WHEN lc.chko = 'TRUE' THEN 'O'
                WHEN lc.chka = 'TRUE' THEN 'A'
                WHEN lc.chkb = 'TRUE' THEN 'B'
                WHEN lc.chkab = 'TRUE' THEN 'AB' 
                ELSE '.' 
            END
            ||
            CASE 
                WHEN lc.rbrhpositivo = 'TRUE' THEN '+' 
                WHEN lc.rbrhnegativo = 'TRUE' THEN '-' 
            END
        ) AS grupo_factor_sanguineo,

        n.nom_examen AS tipodemo,
        (
            CASE 
                WHEN ob.n_orden IS NOT NULL THEN 'Observado'
                WHEN ca.chkapto = 'TRUE' THEN 'Apto'
                WHEN ap1.chkapto = 'TRUE' THEN 'Apto'
                WHEN ca.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
                WHEN ap1.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
                WHEN ca.chkno_apto = 'TRUE' THEN 'No Apto'
                WHEN ap1.chkno_apto = 'TRUE' THEN 'No Apto'
                WHEN ca.chkevaluado = 'TRUE' THEN 'Evaluado'
                WHEN ca.chkconobservacion = 'TRUE' THEN 'Con Observaciones'
                WHEN fi.n_orden IS NOT NULL THEN 'INTERCONSULTA PENDIENTE' || ':' || STRING_AGG(fi.especialidad, '-')
                WHEN ca.n_orden IS NULL THEN 'NO REGISTRO APTITUD'
            END
        ) AS resultado,
        n.txtobserv2,
        CASE WHEN au.diagnostico IS NOT NULL THEN au.diagnostico ELSE 'Sin registros' END AS dx_audiometria,
        CASE WHEN rt.txtconclusionesradiograficas IS NOT NULL THEN rt.txtconclusionesradiograficas ELSE 'Sin registros' END AS dx_radiologico,
        CASE WHEN rt.txtconclusionesradiograficas IS NOT NULL THEN rt.txtconclusionesradiograficas ELSE 'Sin registros' END AS dx_radiologico_oit,
        CASE WHEN f.interpretacion IS NOT NULL THEN f.interpretacion ELSE 'Sin registros' END AS dx_espirometria,
        CASE WHEN t.imc IS NOT NULL THEN t.imc ELSE 'Sin registros' END AS dx_imc,
        TRIM(
	    CASE
		WHEN oft.txtdiagnostico IS NOT NULL 
		     AND oft.txtdiagnostico <> '' THEN oft.txtdiagnostico
		WHEN o.e_oculares IS NOT NULL 
		     AND o.e_oculares1 IS NOT NULL THEN o.e_oculares || ' - ' || o.e_oculares1
		WHEN o.e_oculares IS NOT NULL THEN o.e_oculares
		WHEN o.e_oculares1 IS NOT NULL THEN o.e_oculares1
		ELSE 'Sin registros'
	    END
	) AS dx_oftalmologico,
        --CASE WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico ELSE 'Sin registros' END AS dx_oftalmologico,
        CASE
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$'
            THEN TRIM(lc.txtglucosabio)
            ELSE 'Sin registros'
        END AS glucosa,
        CASE 
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$' 
                AND CAST(TRIM(lc.txtglucosabio) AS DECIMAL) > 100 
                THEN 'HIPERGLUCEMIA'
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$' 
                AND CAST(TRIM(lc.txtglucosabio) AS DECIMAL) < 100 
                THEN 'NORMAL'
            ELSE 'Sin registros'
        END AS conclusion_glucosa,
        (
            '- Colesterol Total: ' || CASE WHEN TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- Triglicéridos: ' || CASE WHEN TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txttrigliseridos ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- HDL: ' || CASE WHEN TRIM(ab.txthdlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txthdlcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- LDL: ' || CASE WHEN TRIM(ab.txtldlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtldlcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- VLDL: ' || CASE WHEN TRIM(ab.txtvldlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtvldlcolesterol ELSE 'Sin registros' END
        ) AS perfil_lipidico,
        CASE 
            WHEN (TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' AND CAST(TRIM(ab.txtcolesterol) AS DECIMAL) > 200) 
             AND (TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' AND CAST(TRIM(ab.txttrigliseridos) AS DECIMAL) > 150) THEN 
                'HIPERLIPIDEMIA MIXTA'
            ELSE 
                '- Colesterol: ' || 
                CASE 
                    WHEN TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN 
                        CASE WHEN CAST(TRIM(ab.txtcolesterol) AS DECIMAL) > 200 THEN 'HIPERCOLESTEROLEMIA' ELSE 'NORMAL' END
                    ELSE 'Sin registros' 
                END 
                || chr(10) ||
                '- Trigliceridos: ' || 
                CASE 
                    WHEN TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' THEN 
                        CASE WHEN CAST(TRIM(ab.txttrigliseridos) AS DECIMAL) > 150 THEN 'HIPERTRIGLICERIDEMIA' ELSE 'NORMAL' END
                    ELSE 'Sin registros' 
                END
        END AS conclusion_perfil_lipidico,
        CASE WHEN lb.txtcreatinina IS NOT NULL THEN lb.txtcreatinina ELSE 'Sin registros' END AS conclusion_creatinina,
        CASE WHEN t.sistolica IS NOT NULL THEN t.sistolica ELSE 'Sin registros' END AS sistolica,
        CASE WHEN t.diastolica IS NOT NULL THEN t.diastolica ELSE 'Sin registros' END AS diastolica,
        COALESCE(ie.conclusion, ie.hallazgo, iep2.conclusion) AS ekg_resultado,
        CASE WHEN ap1.txtconclusiones IS NULL THEN ca.txtconclusiones ELSE ap1.txtconclusiones END AS conclusiones_ficha_anexo16,
        -- CASE 
--             WHEN ap1.chkapto THEN 'Apto'
--             WHEN ap1.chkapto_restriccion THEN 'Apto con restricción'
--             WHEN ap1.chkno_apto THEN 'No apto'
--             WHEN ca.chkapto THEN 'Apto'
--             WHEN ca.chkapto_restriccion THEN 'Apto con restricción'
--             WHEN ca.chkno_apto THEN 'No apto'
--             WHEN ca.chkevaluado THEN 'Evaluado'
--             WHEN ca.chkconobservacion THEN 'Con observacion'
--             ELSE 'NO REGISTRO APTITUD'
--         END AS aptitud_ocupacional,
	CASE
            WHEN 
		bc.chk_si = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%' 
		AND EXISTS (
		    SELECT 1 
		    FROM ficha_sas f 
		    WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 
		    FROM b_certificado_conduccion b
		    WHERE b.n_orden = n.n_orden
		)
	    THEN 'Apto' --nuevo
            WHEN 
		bc.chk_apto_r = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%'
		AND EXISTS (
		    SELECT 1 FROM ficha_sas f WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 FROM b_certificado_conduccion b WHERE b.n_orden = n.n_orden
		)
	    THEN 'Apto con Restriccion' --nuevo
            WHEN 
		bc.chk_observado = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%'
		AND EXISTS (
		    SELECT 1 FROM ficha_sas f WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 FROM b_certificado_conduccion b WHERE b.n_orden = n.n_orden
		)
	    THEN 'Con Observación' --nuevo
            WHEN 
		bc.chk_no = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%'
		AND EXISTS (
		    SELECT 1 FROM ficha_sas f WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 FROM b_certificado_conduccion b WHERE b.n_orden = n.n_orden
		)
	    THEN 'No Apto' --nuevo
            WHEN ama.chkapto = 'TRUE' THEN 'Apto'
            WHEN ama.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
            WHEN ama.chkno_apto = 'TRUE' THEN 'No Apto'
            WHEN ap1.chkapto = 'TRUE' THEN 'Apto'
            WHEN ap1.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
            WHEN ap1.chkno_apto = 'TRUE' THEN 'No Apto'
            WHEN ca.chkapto = 'TRUE' THEN 'Apto'
            WHEN ca.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
            WHEN ca.chkno_apto = 'TRUE' THEN 'No Apto'
            WHEN ca.chkevaluado = 'TRUE' THEN 'Evaluado'
            WHEN ca.chkconobservacion = 'TRUE' THEN 'Con Observación'
            WHEN fi.n_orden IS NOT NULL THEN 'INTERCONSULTA PENDIENTE: ' || string_agg(fi.especialidad, '-')
            WHEN ama.n_orden IS NULL THEN 'APTITUD PENDIENTE'
	    END AS aptitud_ocupacional,
        CASE 
            WHEN ps2.apto IS TRUE THEN 'Apto'
            WHEN ps2.apto IS FALSE THEN 'No apto'
            WHEN ip.aprobo_inf THEN 'Apto'
            WHEN ip.desaprobo_inf THEN 'No apto'
            ELSE 'NO REGISTRO APTITUD'
        END AS aptitud_psicologica,
        TRIM(
            COALESCE(eme.txtdiagnostico, '') 
            || 
            CASE 
            WHEN eme.txtdiagnostico IS NOT NULL 
                AND rg.conclu IS NOT NULL THEN ' - ' || rg.conclu
            ELSE COALESCE(rg.conclu, '')
            END
        ) AS diagnostico_musculo_esqueletico
    FROM datos_paciente AS d
    INNER JOIN n_orden_ocupacional AS n ON d.cod_pa = n.cod_pa
    LEFT JOIN triaje AS t ON t.n_orden = n.n_orden
    LEFT JOIN oftalmologia AS o ON o.n_orden = n.n_orden
    LEFT JOIN oftalmologia_lo AS ol ON ol.n_orden = n.n_orden
    LEFT JOIN audiometria_po AS au ON au.n_orden = n.n_orden
    LEFT JOIN funcion_abs AS f ON f.n_orden = n.n_orden
    LEFT JOIN ficha_audiologica AS fa ON fa.n_orden = n.n_orden
    LEFT JOIN informe_electrocardiograma AS ie ON ie.n_orden = n.n_orden
    LEFT JOIN informe_electrocardiograma_poderosa AS iep2 ON iep2.n_orden = n.n_orden
    LEFT JOIN ex_radiograficos_sanguineos AS er ON er.n_orden = n.n_orden
    LEFT JOIN radiografia_torax AS rt ON rt.n_orden = n.n_orden
    LEFT JOIN oit AS oi ON oi.n_orden = n.n_orden
    LEFT JOIN odontograma AS od ON od.n_orden = n.n_orden
    LEFT JOIN analisis_bioquimicos AS ab ON ab.n_orden = n.n_orden
    LEFT JOIN lab_clinico AS lc ON lc.n_orden = n.n_orden
    LEFT JOIN anexo7c AS a ON a.n_orden = n.n_orden
    LEFT JOIN anexo_agroindustrial AS aa ON aa.n_orden = n.n_orden
    LEFT JOIN aptitud_medico_ocupacional11 AS ca ON ca.n_orden = n.n_orden
    LEFT JOIN aptitud_medico_ocupacional_agro AS ama ON ama.n_orden = n.n_orden
    LEFT JOIN anexo7d AS ad ON ad.n_orden = n.n_orden
    LEFT JOIN anexoc AS ac ON ac.n_orden = n.n_orden
    LEFT JOIN observaciones AS ob ON ob.n_orden = n.n_orden
    LEFT JOIN b_certificado_conduccion AS bc ON bc.n_orden = n.n_orden
    LEFT JOIN b_certificado_altura AS ba ON ba.n_orden = n.n_orden
    LEFT JOIN certificacion_medica_altura AS cma ON cma.n_orden = n.n_orden
    LEFT JOIN informe_psicologico AS ip ON ip.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON eme.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica2021 AS emes ON emes.n_orden = n.n_orden
    LEFT JOIN ac_bioquimica2022 AS acu ON acu.n_orden = n.n_orden
    LEFT JOIN toxicologia AS tox ON tox.n_orden = n.n_orden
    LEFT JOIN oftalmologia2021 AS oft ON oft.n_orden = n.n_orden
    LEFT JOIN odontograma AS odo ON odo.n_orden = n.n_orden
    LEFT JOIN perfil_hepatico AS ph ON ph.n_orden = n.n_orden
    LEFT JOIN antecedentes_patologicos AS apa ON apa.n_orden = n.n_orden
    LEFT JOIN certificado_aptitud_medico_ocupacional AS ap1 ON ap1.n_orden = n.n_orden
    LEFT JOIN ficha_interconsulta AS fi ON fi.n_orden = n.n_orden
    LEFT JOIN l_bioquimica AS lb ON lb.n_orden = n.n_orden
    LEFT JOIN radiografia AS rg ON rg.n_orden = n.n_orden
    LEFT JOIN ficha_psicologica_anexo02 AS ps2 ON ps2.n_orden = n.n_orden
    LEFT JOIN empresas AS ep ON n.razon_empresa = ep.razon_empresa
    WHERE 
        ep.ruc_empresa = p_ruc_empresa
        AND EXISTS(
		SELECT 1
		FROM sede_multisucursal sm
		WHERE sm.id = n.cod_sede
		 AND sm.codigo_sucursal = p_sede
	)
        AND (n.txtobserv2 ILIKE '%GESTOR%' OR n.txtobserv2 ILIKE '%326%')
        AND n.fecha_apertura_po >= CAST(p_fecha_inicio AS DATE)
        AND n.fecha_apertura_po <= CAST(p_fecha_fin AS DATE)

    GROUP BY 
        n.n_orden, n.fecha_apertura_po, n.txtobserv2, n.razon_empresa, n.razon_contrata, 
        d.apellidos_pa, d.nombres_pa, d.sexo_pa, d.cod_pa,
        n.cargo_de, lc.chko, lc.chka, lc.chkb, lc.chkab, lc.rbrhpositivo, lc.rbrhnegativo,
        n.nom_examen, ob.n_orden, ca.chkapto, ap1.chkapto, ca.chkapto_restriccion, ap1.chkapto_restriccion,
        ca.chkno_apto, ap1.chkno_apto, ca.chkevaluado, ca.chkconobservacion,
        fi.n_orden, ca.n_orden, au.diagnostico, rt.txtconclusionesradiograficas, f.interpretacion,
        t.imc, oft.txtdiagnostico, lc.txtglucosabio, ab.txttrigliseridos, lb.txtcreatinina,
        t.sistolica, t.diastolica, ie.conclusion, ap1.txtconclusiones, ap1.chkapto, ap1.chkapto_restriccion,
        ap1.chkno_apto, eme.txtdiagnostico, rg.conclu, d.fecha_nacimiento_pa, ps2.apto, ab.txtColesterol,
        ab.txtCreatinina, ab.txthdlcolesterol, ab.txtldlcolesterol, ab.txtvldlcolesterol, o.e_oculares, o.e_oculares1,
        ip.aprobo_inf, ip.desaprobo_inf, iep2.conclusion, ie.hallazgo, bc.chk_si, bc.chk_apto_r, bc.chk_observado, bc.chk_no,
        ama.chkapto, ama.chkapto_restriccion, ama.chkno_apto, fi.n_orden, fi.especialidad, ama.n_orden

    ORDER BY n.n_orden ASC;
END;
$BODY$
  LANGUAGE plpgsql;

DROP FUNCTION obtener_reporte_pacientes_matriz_ohla_construccion(text, text, text);

CREATE OR REPLACE FUNCTION obtener_reporte_pacientes_matriz_ohla_construccion(
    IN p_ruc_empresa text,
    IN p_fecha_inicio text,
    IN p_fecha_fin text,
    IN p_sede text)
  RETURNS TABLE(n integer, fecha_evaluacion date, centro_costo text, razon_empresa text, razon_contrata text, nombres text, sexo_pa "char", dni integer, puesto text, edad text, grupo_factor_sanguineo text, tipodemo text, resultado text, txtobserv2 text, dx_audiometria text, dx_radiologico text, dx_radiologico_oit text, dx_espirometria text, dx_imc text, dx_oftalmologico text, glucosa text, conclusion_glucosa text, perfil_lipidico text, conclusion_perfil_lipidico text, conclusion_creatinina text, sistolica text, diastolica text, ekg_resultado text, conclusiones_ficha_anexo16 text, aptitud_ocupacional text, aptitud_psicologica text, diagnostico_musculo_esqueletico text) AS
$BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT 
        n.n_orden,
        n.fecha_apertura_po AS fecha_evaluacion,
        n.txtobserv2 AS centro_costo,
        n.razon_empresa,
        n.razon_contrata,
        TRIM(d.apellidos_pa) || ' ' || TRIM(d.nombres_pa) AS nombres,
        d.sexo_pa,
        d.cod_pa AS dni,
        n.cargo_de AS puesto,
        CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT) AS edad,
        (
            CASE 
                WHEN lc.chko = 'TRUE' THEN 'O'
                WHEN lc.chka = 'TRUE' THEN 'A'
                WHEN lc.chkb = 'TRUE' THEN 'B'
                WHEN lc.chkab = 'TRUE' THEN 'AB' 
                ELSE '.' 
            END
            ||
            CASE 
                WHEN lc.rbrhpositivo = 'TRUE' THEN '+' 
                WHEN lc.rbrhnegativo = 'TRUE' THEN '-' 
            END
        ) AS grupo_factor_sanguineo,

        n.nom_examen AS tipodemo,
        (
            CASE 
                WHEN ob.n_orden IS NOT NULL THEN 'Observado'
                WHEN ca.chkapto = 'TRUE' THEN 'Apto'
                WHEN ap1.chkapto = 'TRUE' THEN 'Apto'
                WHEN ca.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
                WHEN ap1.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
                WHEN ca.chkno_apto = 'TRUE' THEN 'No Apto'
                WHEN ap1.chkno_apto = 'TRUE' THEN 'No Apto'
                WHEN ca.chkevaluado = 'TRUE' THEN 'Evaluado'
                WHEN ca.chkconobservacion = 'TRUE' THEN 'Con Observaciones'
                WHEN fi.n_orden IS NOT NULL THEN 'INTERCONSULTA PENDIENTE' || ':' || STRING_AGG(fi.especialidad, '-')
                WHEN ca.n_orden IS NULL THEN 'NO REGISTRO APTITUD'
            END
        ) AS resultado,
        n.txtobserv2,
        CASE WHEN au.diagnostico IS NOT NULL THEN au.diagnostico ELSE 'Sin registros' END AS dx_audiometria,
        CASE WHEN rt.txtconclusionesradiograficas IS NOT NULL THEN rt.txtconclusionesradiograficas ELSE 'Sin registros' END AS dx_radiologico,
        CASE WHEN rt.txtconclusionesradiograficas IS NOT NULL THEN rt.txtconclusionesradiograficas ELSE 'Sin registros' END AS dx_radiologico_oit,
        CASE WHEN f.interpretacion IS NOT NULL THEN f.interpretacion ELSE 'Sin registros' END AS dx_espirometria,
        CASE WHEN t.imc IS NOT NULL THEN t.imc ELSE 'Sin registros' END AS dx_imc,
        TRIM(
	    CASE
		WHEN oft.txtdiagnostico IS NOT NULL 
		     AND oft.txtdiagnostico <> '' THEN oft.txtdiagnostico
		WHEN o.e_oculares IS NOT NULL 
		     AND o.e_oculares1 IS NOT NULL THEN o.e_oculares || ' - ' || o.e_oculares1
		WHEN o.e_oculares IS NOT NULL THEN o.e_oculares
		WHEN o.e_oculares1 IS NOT NULL THEN o.e_oculares1
		ELSE 'Sin registros'
	    END
	) AS dx_oftalmologico,
        --CASE WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico ELSE 'Sin registros' END AS dx_oftalmologico,
        CASE
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$'
            THEN TRIM(lc.txtglucosabio)
            ELSE 'Sin registros'
        END AS glucosa,
        CASE 
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$' 
                AND CAST(TRIM(lc.txtglucosabio) AS DECIMAL) > 100 
                THEN 'HIPERGLUCEMIA'
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$' 
                AND CAST(TRIM(lc.txtglucosabio) AS DECIMAL) < 100 
                THEN 'NORMAL'
            ELSE 'Sin registros'
        END AS conclusion_glucosa,
        (
            '- Colesterol Total: ' || CASE WHEN TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- Triglicéridos: ' || CASE WHEN TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txttrigliseridos ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- HDL: ' || CASE WHEN TRIM(ab.txthdlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txthdlcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- LDL: ' || CASE WHEN TRIM(ab.txtldlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtldlcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- VLDL: ' || CASE WHEN TRIM(ab.txtvldlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtvldlcolesterol ELSE 'Sin registros' END
        ) AS perfil_lipidico,
        CASE 
            WHEN (TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' AND CAST(TRIM(ab.txtcolesterol) AS DECIMAL) > 200) 
             AND (TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' AND CAST(TRIM(ab.txttrigliseridos) AS DECIMAL) > 150) THEN 
                'HIPERLIPIDEMIA MIXTA'
            ELSE 
                '- Colesterol: ' || 
                CASE 
                    WHEN TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN 
                        CASE WHEN CAST(TRIM(ab.txtcolesterol) AS DECIMAL) > 200 THEN 'HIPERCOLESTEROLEMIA' ELSE 'NORMAL' END
                    ELSE 'Sin registros' 
                END 
                || chr(10) ||
                '- Trigliceridos: ' || 
                CASE 
                    WHEN TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' THEN 
                        CASE WHEN CAST(TRIM(ab.txttrigliseridos) AS DECIMAL) > 150 THEN 'HIPERTRIGLICERIDEMIA' ELSE 'NORMAL' END
                    ELSE 'Sin registros' 
                END
        END AS conclusion_perfil_lipidico,
        CASE WHEN lb.txtcreatinina IS NOT NULL THEN lb.txtcreatinina ELSE 'Sin registros' END AS conclusion_creatinina,
        CASE WHEN t.sistolica IS NOT NULL THEN t.sistolica ELSE 'Sin registros' END AS sistolica,
        CASE WHEN t.diastolica IS NOT NULL THEN t.diastolica ELSE 'Sin registros' END AS diastolica,
        COALESCE(ie.conclusion, ie.hallazgo, iep2.conclusion) AS ekg_resultado,
        CASE WHEN ap1.txtconclusiones IS NULL THEN ca.txtconclusiones ELSE ap1.txtconclusiones END AS conclusiones_ficha_anexo16,
        -- CASE 
--             WHEN ap1.chkapto THEN 'Apto'
--             WHEN ap1.chkapto_restriccion THEN 'Apto con restricción'
--             WHEN ap1.chkno_apto THEN 'No apto'
--             WHEN ca.chkapto THEN 'Apto'
--             WHEN ca.chkapto_restriccion THEN 'Apto con restricción'
--             WHEN ca.chkno_apto THEN 'No apto'
--             WHEN ca.chkevaluado THEN 'Evaluado'
--             WHEN ca.chkconobservacion THEN 'Con observacion'
--             ELSE 'NO REGISTRO APTITUD'
--         END AS aptitud_ocupacional,
        CASE
            WHEN 
		bc.chk_si = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%' 
		AND EXISTS (
		    SELECT 1 
		    FROM ficha_sas f 
		    WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 
		    FROM b_certificado_conduccion b
		    WHERE b.n_orden = n.n_orden
		)
	    THEN 'Apto' --nuevo
            WHEN 
		bc.chk_apto_r = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%'
		AND EXISTS (
		    SELECT 1 FROM ficha_sas f WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 FROM b_certificado_conduccion b WHERE b.n_orden = n.n_orden
		)
	    THEN 'Apto con Restriccion' --nuevo
            WHEN 
		bc.chk_observado = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%'
		AND EXISTS (
		    SELECT 1 FROM ficha_sas f WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 FROM b_certificado_conduccion b WHERE b.n_orden = n.n_orden
		)
	    THEN 'Con Observación' --nuevo
            WHEN 
		bc.chk_no = 'TRUE'
		AND n.nom_examen ILIKE '%PSICOSENSOMETRIA%'
		AND EXISTS (
		    SELECT 1 FROM ficha_sas f WHERE f.n_orden = n.n_orden
		)
		AND EXISTS (
		    SELECT 1 FROM b_certificado_conduccion b WHERE b.n_orden = n.n_orden
		)
	    THEN 'No Apto' --nuevo
            WHEN ama.chkapto = 'TRUE' THEN 'Apto'
            WHEN ama.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
            WHEN ama.chkno_apto = 'TRUE' THEN 'No Apto'
            WHEN ap1.chkapto = 'TRUE' THEN 'Apto'
            WHEN ap1.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
            WHEN ap1.chkno_apto = 'TRUE' THEN 'No Apto'
            WHEN ca.chkapto = 'TRUE' THEN 'Apto'
            WHEN ca.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
            WHEN ca.chkno_apto = 'TRUE' THEN 'No Apto'
            WHEN ca.chkevaluado = 'TRUE' THEN 'Evaluado'
            WHEN ca.chkconobservacion = 'TRUE' THEN 'Con Observación'
            WHEN fi.n_orden IS NOT NULL THEN 'INTERCONSULTA PENDIENTE: ' || string_agg(fi.especialidad, '-')
            WHEN ama.n_orden IS NULL THEN 'APTITUD PENDIENTE'
	    END AS aptitud_ocupacional,
        CASE 
            WHEN ps2.apto IS TRUE THEN 'Apto'
            WHEN ps2.apto IS FALSE THEN 'No apto'
            WHEN ip.aprobo_inf THEN 'Apto'
            WHEN ip.desaprobo_inf THEN 'No apto'
            ELSE 'NO REGISTRO APTITUD'
        END AS aptitud_psicologica,
        TRIM(
            COALESCE(eme.txtdiagnostico, '') 
            || 
            CASE 
            WHEN eme.txtdiagnostico IS NOT NULL 
                AND rg.conclu IS NOT NULL THEN ' - ' || rg.conclu
            ELSE COALESCE(rg.conclu, '')
            END
        ) AS diagnostico_musculo_esqueletico
    FROM datos_paciente AS d
    INNER JOIN n_orden_ocupacional AS n ON d.cod_pa = n.cod_pa
    LEFT JOIN triaje AS t ON t.n_orden = n.n_orden
    LEFT JOIN oftalmologia AS o ON o.n_orden = n.n_orden
    LEFT JOIN oftalmologia_lo AS ol ON ol.n_orden = n.n_orden
    LEFT JOIN audiometria_po AS au ON au.n_orden = n.n_orden
    LEFT JOIN funcion_abs AS f ON f.n_orden = n.n_orden
    LEFT JOIN ficha_audiologica AS fa ON fa.n_orden = n.n_orden
    LEFT JOIN informe_electrocardiograma AS ie ON ie.n_orden = n.n_orden
    LEFT JOIN informe_electrocardiograma_poderosa AS iep2 ON iep2.n_orden = n.n_orden
    LEFT JOIN ex_radiograficos_sanguineos AS er ON er.n_orden = n.n_orden
    LEFT JOIN radiografia_torax AS rt ON rt.n_orden = n.n_orden
    LEFT JOIN oit AS oi ON oi.n_orden = n.n_orden
    LEFT JOIN odontograma AS od ON od.n_orden = n.n_orden
    LEFT JOIN analisis_bioquimicos AS ab ON ab.n_orden = n.n_orden
    LEFT JOIN lab_clinico AS lc ON lc.n_orden = n.n_orden
    LEFT JOIN anexo7c AS a ON a.n_orden = n.n_orden
    LEFT JOIN anexo_agroindustrial AS aa ON aa.n_orden = n.n_orden
    LEFT JOIN aptitud_medico_ocupacional11 AS ca ON ca.n_orden = n.n_orden
    LEFT JOIN aptitud_medico_ocupacional_agro AS ama ON ama.n_orden = n.n_orden
    LEFT JOIN anexo7d AS ad ON ad.n_orden = n.n_orden
    LEFT JOIN anexoc AS ac ON ac.n_orden = n.n_orden
    LEFT JOIN observaciones AS ob ON ob.n_orden = n.n_orden
    LEFT JOIN b_certificado_conduccion AS bc ON bc.n_orden = n.n_orden
    LEFT JOIN b_certificado_altura AS ba ON ba.n_orden = n.n_orden
    LEFT JOIN certificacion_medica_altura AS cma ON cma.n_orden = n.n_orden
    LEFT JOIN informe_psicologico AS ip ON ip.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON eme.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica2021 AS emes ON emes.n_orden = n.n_orden
    LEFT JOIN ac_bioquimica2022 AS acu ON acu.n_orden = n.n_orden
    LEFT JOIN toxicologia AS tox ON tox.n_orden = n.n_orden
    LEFT JOIN oftalmologia2021 AS oft ON oft.n_orden = n.n_orden
    LEFT JOIN odontograma AS odo ON odo.n_orden = n.n_orden
    LEFT JOIN perfil_hepatico AS ph ON ph.n_orden = n.n_orden
    LEFT JOIN antecedentes_patologicos AS apa ON apa.n_orden = n.n_orden
    LEFT JOIN certificado_aptitud_medico_ocupacional AS ap1 ON ap1.n_orden = n.n_orden
    LEFT JOIN ficha_interconsulta AS fi ON fi.n_orden = n.n_orden
    LEFT JOIN l_bioquimica AS lb ON lb.n_orden = n.n_orden
    LEFT JOIN radiografia AS rg ON rg.n_orden = n.n_orden
    LEFT JOIN ficha_psicologica_anexo02 AS ps2 ON ps2.n_orden = n.n_orden
    LEFT JOIN empresas AS ep ON n.razon_empresa = ep.razon_empresa
    INNER JOIN sede_multisucursal AS sm ON sm.id = n.cod_sede
    WHERE 
        ep.ruc_empresa = p_ruc_empresa
        AND EXISTS(
		SELECT 1
		FROM sede_multisucursal sm
		WHERE sm.id = n.cod_sede
		 AND sm.codigo_sucursal = p_sede
	)
        AND (n.txtobserv2 ILIKE '%CONSTRUCCION%'
            OR n.txtobserv2 SIMILAR TO '%(PAQ[.]? (6|7|8))%'
            OR n.txtobserv2 ILIKE '%911%')
        AND n.fecha_apertura_po >= CAST(p_fecha_inicio AS DATE)
        AND n.fecha_apertura_po <= CAST(p_fecha_fin AS DATE)

    GROUP BY 
        n.n_orden, n.fecha_apertura_po, n.txtobserv2, n.razon_empresa, n.razon_contrata, 
        d.apellidos_pa, d.nombres_pa, d.sexo_pa, d.cod_pa,
        n.cargo_de, lc.chko, lc.chka, lc.chkb, lc.chkab, lc.rbrhpositivo, lc.rbrhnegativo,
        n.nom_examen, ob.n_orden, ca.chkapto, ap1.chkapto, ca.chkapto_restriccion, ap1.chkapto_restriccion,
        ca.chkno_apto, ap1.chkno_apto, ca.chkevaluado, ca.chkconobservacion,
        fi.n_orden, ca.n_orden, au.diagnostico, rt.txtconclusionesradiograficas, f.interpretacion,
        t.imc, oft.txtdiagnostico, lc.txtglucosabio, ab.txttrigliseridos, lb.txtcreatinina,
        t.sistolica, t.diastolica, ie.conclusion, ap1.txtconclusiones, ap1.chkapto, ap1.chkapto_restriccion,
        ap1.chkno_apto, eme.txtdiagnostico, rg.conclu, d.fecha_nacimiento_pa, ps2.apto, ab.txtColesterol,
        ab.txtCreatinina, ab.txthdlcolesterol, ab.txtldlcolesterol, ab.txtvldlcolesterol, o.e_oculares, o.e_oculares1,
        ip.aprobo_inf, ip.desaprobo_inf, iep2.conclusion, ie.hallazgo, bc.chk_si, bc.chk_apto_r, bc.chk_observado, bc.chk_no,
        ama.chkapto, ama.chkapto_restriccion, ama.chkno_apto, fi.n_orden, fi.especialidad, ama.n_orden

    ORDER BY n.n_orden ASC;
END;
$BODY$
  LANGUAGE plpgsql;

DROP FUNCTION obtener_reporte_aptitud_altura_poderosa(integer, text);

CREATE OR REPLACE FUNCTION obtener_reporte_aptitud_altura_poderosa(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, fechaexamen date, fechahasta date, nombremedico text, apto boolean, aptorestriccion boolean, aptotemporal boolean, noapto boolean, observaciones text, horasalida time without time zone, hemoglobina_txthemoglobina text, hematocritolabclinico_txthematocrito text, vsglabclinico_txtvsg text, glucosalabclinico_txtglucosabio text, creatininalabclinico_txtcreatininabio text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, nombresede text, numerosede text, sede text, color integer, namejasper text, usuariofirma text, explotacion text) AS
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
	    ca.usuario_firma,
	    n.nom_ex
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

drop FUNCTION obtener_reporte_ficha_psicologica_anexo3(
    IN p_norden integer,
    IN name_service text)

CREATE OR REPLACE FUNCTION obtener_reporte_ficha_psicologica_anexo3(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, estadocivilpaciente text, mineralexp text, explotacionen text, alturalabor text, codigoanexo_cod_anexo03 integer, fechaexamen_fecha date, motivoevaluacion_motivo_eval text, tiempotrabajo_timpo_trab text, principalriesgo_princ_riesgo text, medidasseguridad_med_seguridad text, historialfamiliar_hist_familiar text, habitos_habitos text, otrasobservaciones_otras_observ text, presentacionadecuado_rb_adecuado boolean, presentacionindecuado_rb_indecuado boolean, posturaerguida_rb_erguida boolean, posturaencorvada_rb_encorvada boolean, ritmolento_rb_lento boolean, ritmorapido_rb_rapido boolean, ritmofluido_rb_fluido boolean, tonobajo_rb_bajo boolean, tonomoderado_rb_moderado boolean, tonoalto_rb_alto boolean, articulacioncondificultad_rb_condificultad boolean, articulacionsindificultad_rb_sindificultad boolean, tiempoorientado_rb_torientado boolean, tiempodesorientado_rb_tdesorientado boolean, espacioorientado_rb_eorientado boolean, espaciodesorientado_rb_edesorientado boolean, personaorientado_rb_porientado boolean, personadesorientado_rb_pdesorientado boolean, lucido_lucido text, pensamiento_pensamiento text, percepcion_percepcion text, memoriacortoplazo_rb_cortoplazo boolean, memoriamedianoplazo_rb_medianoplazo boolean, memorialargoplazo_rb_largoplazo boolean, inteligenciamuysuperior_rb_muysuperior boolean, inteligenciasuperior_rb_superior boolean, inteligencianormal_rb_normal boolean, inteligenciapromedio_rb_promedio boolean, inteligenciatorpe_rb_torpe boolean, inteligenciafronterizo_rb_fronterizo boolean, inteligenciarmleve_rb_rleve boolean, inteligenciarmmoderado_rb_rmoderado boolean, inteligenciarmsevero_rb_rsevero boolean, inteligenciarmprofundo_rb_rprofundo boolean, apetito_apetito text, sueno_sueno text, personalidad_personalidad text, afectividad_afectividad text, conductasexual_conducta_sexual text, puntajemips_puntaje1 text, puntajemps_puntaje2 text, puntajedna_puntaje3 text, puntajeeae_puntaje4 text, puntajeinventariobormout_puntaje5 text, puntajeclimalaboral_puntaje6 text, puntajebacteriaconductores_puntaje7 text, puntajewais_puntaje8 text, puntajebenton_puntaje9 text, puntajebender_puntaje10 text, puntajeansiedadzung_puntaje11 text, puntajedepresionzung_puntaje12 text, puntajeescalamemoriawechsler_puntaje13 text, areacognitiva_area_cognitiva text, areaemocional_area_emocional text, usuarioregistro_user_registro text, puntajeotraspruebas_puntaje14 text, nombresede text, sede text, color integer, namejasper text, tiempoExperiencia text) AS
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
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    n.nom_examen,
	    n.cod_clinica,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
	    d.estado_civil_pa,
	    n.mineral_po,
	    n.nom_ex,
	    n.altura_po,
	    fi.cod_anexo03,  
		fi.fecha,  
		fi.motivo_eval,  
		fi.timpo_trab,  
		fi.princ_riesgo,  
		fi.med_seguridad,  
		fi.hist_familiar,  
		fi.habitos,  
		fi.otras_observ,  
		fi.rb_adecuado,  
		fi.rb_indecuado,  
		fi.rb_erguida,  
		fi.rb_encorvada,  
		fi.rb_lento,  
		fi.rb_rapido,  
		fi.rb_fluido,  
		fi.rb_bajo,  
		fi.rb_moderado,  
		fi.rb_alto,  
		fi.rb_condificultad,  
		fi.rb_sindificultad,  
		fi.rb_torientado,  
		fi.rb_tdesorientado,  
		fi.rb_eorientado,  
		fi.rb_edesorientado,  
		fi.rb_porientado,  
		fi.rb_pdesorientado,  
		fi.lucido,  
		fi.pensamiento,  
		fi.percepcion,  
		fi.rb_cortoplazo,  
		fi.rb_medianoplazo,  
		fi.rb_largoplazo,  
		fi.rb_muysuperior,  
		fi.rb_superior,  
		fi.rb_normal,  
		fi.rb_promedio,  
		fi.rb_torpe,  
		fi.rb_fronterizo,  
		fi.rb_rleve,  
		fi.rb_rmoderado,  
		fi.rb_rsevero,  
		fi.rb_rprofundo,  
		fi.apetito,  
		fi.sueno,  
		fi.personalidad,  
		fi.afectividad,  
		fi.conducta_sexual,  
		fi.puntaje1,  
		fi.puntaje2,  
		fi.puntaje3,  
		fi.puntaje4,  
		fi.puntaje5,  
		fi.puntaje6,  
		fi.puntaje7,  
		fi.puntaje8,  
		fi.puntaje9,  
		fi.puntaje10,  
		fi.puntaje11,  
		fi.puntaje12,  
		fi.puntaje13,  
		fi.area_cognitiva,  
		fi.area_emocional,  
		fi.user_registro,  
		fi.puntaje14,
		
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
	    CASE
		    WHEN NULLIF(cn.txttanos, '') IS NOT NULL
			 AND NULLIF(cn.txttmeses, '') IS NOT NULL THEN
			cn.txttanos || ' años, ' || cn.txttmeses || ' meses'
		    WHEN NULLIF(cn.txttanos, '') IS NOT NULL THEN
			cn.txttanos || ' años'
		    WHEN NULLIF(cn.txttmeses, '') IS NOT NULL THEN
			cn.txttmeses || ' meses'
		    ELSE
			'Sin experiencia'
		END AS experiencia_laboral

	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN ficha_psicologica_anexo03 AS fi
	    ON fi.n_orden = n.n_orden
	INNER JOIN cuestionario_nordico AS cn
	    ON cn.n_orden = n.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_reporte_pacientes_matriz_ohla_construccion(
    p_ruc_empresa TEXT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE
)
RETURNS TABLE (
    n INTEGER,
    fecha_evaluacion DATE,
    centro_costo TEXT,
    razon_empresa_res TEXT,
    razon_contrata_res TEXT,
    nombres TEXT,
    sexo_pa "char",
    dni INTEGER,
    puesto TEXT,
    edad TEXT,
    grupo_factor_sanguineo TEXT,
    tipodemo TEXT,
    resultado TEXT,
    txtobserv2_res TEXT,
    dx_audiometria TEXT,
    dx_radiologico TEXT,
    dx_radiologico_oit TEXT,
    dx_espirometria TEXT,
    dx_imc TEXT,
    dx_oftalmologico TEXT,
    glucosa TEXT,
    conclusion_glucosa TEXT,
    perfil_lipidico TEXT,
    conclusion_perfil_lipidico TEXT,
    conclusion_creatinina TEXT,
    sistolica TEXT,
    diastolica TEXT,
    ekg_resultado TEXT,
    conclusiones_ficha_anexo16 TEXT,
    aptitud_ocupacional TEXT,
    aptitud_psicologica TEXT,
    diagnostico_musculo_esqueletico TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        n.n_orden,
        n.fecha_apertura_po AS fecha_evaluacion,
        n.txtobserv2 AS centro_costo,
        n.razon_empresa,
        n.razon_contrata,
        TRIM(d.apellidos_pa) || ' ' || TRIM(d.nombres_pa) AS nombres,
        d.sexo_pa,
        d.cod_pa AS dni,
        n.cargo_de AS puesto,
        CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT) AS edad,
        (
            CASE 
                WHEN lc.chko = 'TRUE' THEN 'O'
                WHEN lc.chka = 'TRUE' THEN 'A'
                WHEN lc.chkb = 'TRUE' THEN 'B'
                WHEN lc.chkab = 'TRUE' THEN 'AB' 
                ELSE '.' 
            END
            ||
            CASE 
                WHEN lc.rbrhpositivo = 'TRUE' THEN '+' 
                WHEN lc.rbrhnegativo = 'TRUE' THEN '-' 
            END
        ) AS grupo_factor_sanguineo,

        n.nom_examen AS tipodemo,
        (
            CASE 
                WHEN ob.n_orden IS NOT NULL THEN 'Observado'
                WHEN ca.chkapto = 'TRUE' THEN 'Apto'
                WHEN ap1.chkapto = 'TRUE' THEN 'Apto'
                WHEN ca.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
                WHEN ap1.chkapto_restriccion = 'TRUE' THEN 'Apto con Restriccion'
                WHEN ca.chkno_apto = 'TRUE' THEN 'No Apto'
                WHEN ap1.chkno_apto = 'TRUE' THEN 'No Apto'
                WHEN ca.chkevaluado = 'TRUE' THEN 'Evaluado'
                WHEN ca.chkconobservacion = 'TRUE' THEN 'Con Observaciones'
                WHEN fi.n_orden IS NOT NULL THEN 'INTERCONSULTA PENDIENTE' || ':' || STRING_AGG(fi.especialidad, '-')
                WHEN ca.n_orden IS NULL THEN 'NO REGISTRO APTITUD'
            END
        ) AS resultado,
        n.txtobserv2,
        CASE WHEN au.diagnostico IS NOT NULL THEN au.diagnostico ELSE 'Sin registros' END AS dx_audiometria,
        CASE WHEN rt.txtconclusionesradiograficas IS NOT NULL THEN rt.txtconclusionesradiograficas ELSE 'Sin registros' END AS dx_radiologico,
        CASE WHEN rt.txtconclusionesradiograficas IS NOT NULL THEN rt.txtconclusionesradiograficas ELSE 'Sin registros' END AS dx_radiologico_oit,
        CASE WHEN f.interpretacion IS NOT NULL THEN f.interpretacion ELSE 'Sin registros' END AS dx_espirometria,
        CASE WHEN t.imc IS NOT NULL THEN t.imc ELSE 'Sin registros' END AS dx_imc,
        CASE WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico ELSE 'Sin registros' END AS dx_oftalmologico,
        CASE
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$'
            THEN TRIM(lc.txtglucosabio)
            ELSE 'Sin registros'
        END AS glucosa,
        CASE 
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$' 
                AND CAST(TRIM(lc.txtglucosabio) AS DECIMAL) > 100 
                THEN 'HIPERGLUCEMIA'
            WHEN TRIM(lc.txtglucosabio) ~ '^[0-9]+(\.[0-9]+)?$' 
                AND CAST(TRIM(lc.txtglucosabio) AS DECIMAL) < 100 
                THEN 'NORMAL'
            ELSE 'Sin registros'
        END AS conclusion_glucosa,
        (
            '- Colesterol Total: ' || CASE WHEN TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- Triglicéridos: ' || CASE WHEN TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txttrigliseridos ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- HDL: ' || CASE WHEN TRIM(ab.txthdlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txthdlcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- LDL: ' || CASE WHEN TRIM(ab.txtldlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtldlcolesterol ELSE 'Sin registros' END
        ) || E'\n' ||
        (
            '- VLDL: ' || CASE WHEN TRIM(ab.txtvldlcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN ab.txtvldlcolesterol ELSE 'Sin registros' END
        ) AS perfil_lipidico,
        CASE 
            WHEN (TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' AND CAST(TRIM(ab.txtcolesterol) AS DECIMAL) > 200) 
             AND (TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' AND CAST(TRIM(ab.txttrigliseridos) AS DECIMAL) > 150) THEN 
                'HIPERLIPIDEMIA MIXTA'
            ELSE 
                '- Colesterol: ' || 
                CASE 
                    WHEN TRIM(ab.txtcolesterol) ~ '^[0-9]+(\.[0-9]+)?$' THEN 
                        CASE WHEN CAST(TRIM(ab.txtcolesterol) AS DECIMAL) > 200 THEN 'HIPERCOLESTEROLEMIA' ELSE 'NORMAL' END
                    ELSE 'Sin registros' 
                END 
                || chr(10) ||
                '- Trigliceridos: ' || 
                CASE 
                    WHEN TRIM(ab.txttrigliseridos) ~ '^[0-9]+(\.[0-9]+)?$' THEN 
                        CASE WHEN CAST(TRIM(ab.txttrigliseridos) AS DECIMAL) > 150 THEN 'HIPERTRIGLICERIDEMIA' ELSE 'NORMAL' END
                    ELSE 'Sin registros' 
                END
        END AS conclusion_perfil_lipidico,
        CASE WHEN lb.txtcreatinina IS NOT NULL THEN lb.txtcreatinina ELSE 'Sin registros' END AS conclusion_creatinina,
        CASE WHEN t.sistolica IS NOT NULL THEN t.sistolica ELSE 'Sin registros' END AS sistolica,
        CASE WHEN t.diastolica IS NOT NULL THEN t.diastolica ELSE 'Sin registros' END AS diastolica,
        CASE WHEN ie.conclusion IS NOT NULL THEN ie.conclusion ELSE 'Sin registros' END AS ekg_resultado,
        ap1.txtconclusiones as conclusiones_ficha_anexo16,
        CASE 
            WHEN ap1.chkapto THEN 'Apto'
            WHEN ap1.chkapto_restriccion THEN 'Apto con restricción'
            WHEN ap1.chkno_apto THEN 'No apto'
            ELSE 'NO REGISTRO APTITUD'
        END AS aptitud_ocupacional,
        CASE 
            WHEN ps2.apto IS TRUE THEN 'Apto'
            WHEN ps2.apto IS FALSE THEN 'No apto'
            ELSE 'NO REGISTRO APTITUD'
        END AS aptitud_psicologica,
        TRIM(
            COALESCE(eme.txtdiagnostico, '') 
            || 
            CASE 
            WHEN eme.txtdiagnostico IS NOT NULL 
                AND rg.conclu IS NOT NULL THEN ' - ' || rg.conclu
            ELSE COALESCE(rg.conclu, '')
            END
        ) AS diagnostico_musculo_esqueletico
    FROM datos_paciente AS d
    INNER JOIN n_orden_ocupacional AS n ON d.cod_pa = n.cod_pa
    LEFT JOIN triaje AS t ON t.n_orden = n.n_orden
    LEFT JOIN oftalmologia AS o ON o.n_orden = n.n_orden
    LEFT JOIN oftalmologia_lo AS ol ON ol.n_orden = n.n_orden
    LEFT JOIN audiometria_po AS au ON au.n_orden = n.n_orden
    LEFT JOIN funcion_abs AS f ON f.n_orden = n.n_orden
    LEFT JOIN ficha_audiologica AS fa ON fa.n_orden = n.n_orden
    LEFT JOIN informe_electrocardiograma AS ie ON ie.n_orden = n.n_orden
    LEFT JOIN ex_radiograficos_sanguineos AS er ON er.n_orden = n.n_orden
    LEFT JOIN radiografia_torax AS rt ON rt.n_orden = n.n_orden
    LEFT JOIN oit AS oi ON oi.n_orden = n.n_orden
    LEFT JOIN odontograma AS od ON od.n_orden = n.n_orden
    LEFT JOIN analisis_bioquimicos AS ab ON ab.n_orden = n.n_orden
    LEFT JOIN lab_clinico AS lc ON lc.n_orden = n.n_orden
    LEFT JOIN anexo7c AS a ON a.n_orden = n.n_orden
    LEFT JOIN anexo_agroindustrial AS aa ON aa.n_orden = n.n_orden
    LEFT JOIN aptitud_medico_ocupacional11 AS ca ON ca.n_orden = n.n_orden
    LEFT JOIN aptitud_medico_ocupacional_agro AS ama ON ama.n_orden = n.n_orden
    LEFT JOIN anexo7d AS ad ON ad.n_orden = n.n_orden
    LEFT JOIN anexoc AS ac ON ac.n_orden = n.n_orden
    LEFT JOIN observaciones AS ob ON ob.n_orden = n.n_orden
    LEFT JOIN b_certificado_conduccion AS bc ON bc.n_orden = n.n_orden
    LEFT JOIN b_certificado_altura AS ba ON ba.n_orden = n.n_orden
    LEFT JOIN certificacion_medica_altura AS cma ON cma.n_orden = n.n_orden
    LEFT JOIN informe_psicologico AS ip ON ip.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON eme.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica2021 AS emes ON emes.n_orden = n.n_orden
    LEFT JOIN ac_bioquimica2022 AS acu ON acu.n_orden = n.n_orden
    LEFT JOIN toxicologia AS tox ON tox.n_orden = n.n_orden
    LEFT JOIN oftalmologia2021 AS oft ON oft.n_orden = n.n_orden
    LEFT JOIN odontograma AS odo ON odo.n_orden = n.n_orden
    LEFT JOIN perfil_hepatico AS ph ON ph.n_orden = n.n_orden
    LEFT JOIN antecedentes_patologicos AS apa ON apa.n_orden = n.n_orden
    LEFT JOIN certificado_aptitud_medico_ocupacional AS ap1 ON ap1.n_orden = n.n_orden
    LEFT JOIN ficha_interconsulta AS fi ON fi.n_orden = n.n_orden
    LEFT JOIN l_bioquimica AS lb ON lb.n_orden = n.n_orden
    LEFT JOIN radiografia AS rg ON rg.n_orden = n.n_orden
    LEFT JOIN ficha_psicologica_anexo02 AS ps2 ON ps2.n_orden = n.n_orden
    LEFT JOIN empresas AS ep ON n.razon_empresa = ep.razon_empresa
    WHERE 
        ep.ruc_empresa = p_ruc_empresa
        AND (txtobserv2 ILIKE '%CONSTRUCCION%'
            OR txtobserv2 SIMILAR TO '%(PAQ[.]? (6|7|8))%'
            OR txtobserv2 ILIKE '%911%')
        AND n.fecha_apertura_po >= p_fecha_inicio
        AND n.fecha_apertura_po <= p_fecha_fin

    GROUP BY 
        n.n_orden, n.fecha_apertura_po, n.txtobserv2, n.razon_empresa, n.razon_contrata, 
        d.apellidos_pa, d.nombres_pa, d.sexo_pa, d.cod_pa,
        n.cargo_de, lc.chko, lc.chka, lc.chkb, lc.chkab, lc.rbrhpositivo, lc.rbrhnegativo,
        n.nom_examen, ob.n_orden, ca.chkapto, ap1.chkapto, ca.chkapto_restriccion, ap1.chkapto_restriccion,
        ca.chkno_apto, ap1.chkno_apto, ca.chkevaluado, ca.chkconobservacion,
        fi.n_orden, ca.n_orden, au.diagnostico, rt.txtconclusionesradiograficas, f.interpretacion,
        t.imc, oft.txtdiagnostico, lc.txtglucosabio, ab.txttrigliseridos, lb.txtcreatinina,
        t.sistolica, t.diastolica, ie.conclusion, ap1.txtconclusiones, ap1.chkapto, ap1.chkapto_restriccion,
        ap1.chkno_apto, eme.txtdiagnostico, rg.conclu, d.fecha_nacimiento_pa, ps2.apto, ab.txtColesterol,
        ab.txtCreatinina, ab.txthdlcolesterol, ab.txtldlcolesterol, ab.txtvldlcolesterol

    ORDER BY n.n_orden ASC;
END;
$$;

CREATE OR REPLACE FUNCTION obtener_existencias_examenes(nOrden INTEGER)
RETURNS TABLE (
    existe BOOLEAN,
    nameService TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY

    SELECT EXISTS(SELECT 1 FROM certificado_aptitud_medico_ocupacional WHERE n_orden = nOrden),
           'certificado_aptitud_medico_ocupacional'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM anexo7c WHERE n_orden = nOrden),
           'anexo7c'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM antece_enfermedades_altura WHERE n_orden = nOrden),
           'antece_enfermedades_altura'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM anexo16a WHERE n_orden = nOrden),
           'anexo16a'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM b_uso_respiradores WHERE n_orden = nOrden),
           'b_uso_respiradores'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM historia_oc_info WHERE n_orden = nOrden),
           'historia_oc_info'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM antecedentes_patologicos WHERE n_orden = nOrden),
           'antecedentes_patologicos'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM cuestionario_nordico WHERE n_orden = nOrden),
           'cuestionario_nordico'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM evaluacion_musculo_esqueletica WHERE n_orden = nOrden),
           'evaluacion_musculo_esqueletica'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM lab_clinico WHERE n_orden = nOrden),
           'lab_clinico'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM analisis_bioquimicos WHERE n_orden = nOrden),
           'analisis_bioquimicos'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM radiografia_torax WHERE n_orden = nOrden),
           'radiografia_torax'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM audiometria_po WHERE n_orden = nOrden),
           'audiometria_po'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM ficha_audiologica WHERE n_orden = nOrden),
           'ficha_audiologica'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM informe_psicologico WHERE n_orden = nOrden),
           'informe_psicologico'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM oftalmologia WHERE n_orden = nOrden),
           'oftalmologia'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM consentimientoInformado WHERE n_orden = nOrden),
           'consentimientoInformado'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM triaje WHERE n_orden = nOrden),
           'triaje'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM informe_electrocardiograma WHERE n_orden = nOrden),
           'informe_electrocardiograma'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM funcion_abs WHERE n_orden = nOrden),
           'funcion_abs'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM odontograma WHERE n_orden = nOrden),
           'odontograma'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM certificacion_medica_altura WHERE n_orden = nOrden),
           'certificacion_medica_altura'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM ficha_sas WHERE n_orden = nOrden),
           'ficha_sas'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM consentimiento_dosaje WHERE n_orden = nOrden),
           'consentimiento_dosaje'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM perimetro_toracico WHERE n_orden = nOrden),
           'perimetro_toracico'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM ex_radiograficos_sanguineos WHERE n_orden = nOrden),
           'ex_radiograficos_sanguineos'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM b_certificado_altura WHERE n_orden = nOrden),
           'b_certificado_altura'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM b_certificado_conduccion WHERE n_orden = nOrden),
           'b_certificado_conduccion'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM oit WHERE n_orden = nOrden),
           'oit'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM cuestionario_audiometria WHERE n_orden = nOrden),
           'cuestionario_audiometria'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM informe_audiometria WHERE n_orden = nOrden),
           'informe_audiometria'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM anexo7c2 WHERE n_orden = nOrden),
           'anexo7c2'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM certificado_aptitud_medico_ocupacional1 WHERE n_orden = nOrden),
           'certificado_aptitud_medico_ocupacional1'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM aptitud_medico_ocupacional_agro WHERE n_orden = nOrden),
           'aptitud_medico_ocupacional_agro'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM anexo_agroindustrial WHERE n_orden = nOrden),
           'anexo_agroindustrial'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM certificado_aptitud_anexo02 WHERE n_orden = nOrden),
           'certificado_aptitud_anexo02'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM anexo_02 WHERE n_orden = nOrden),
           'anexo_02'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM audiometria_2021 WHERE n_orden = nOrden),
           'audiometria_2021'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM evaluacion_musculo_esqueletica2021 WHERE n_orden = nOrden),
           'evaluacion_musculo_esqueletica2021'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM cuestionario_calidad_sueno WHERE n_orden = nOrden),
           'cuestionario_calidad_sueno'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM test_fatiga_somnolencia WHERE n_orden = nOrden),
           'test_fatiga_somnolencia'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM oftalmologia2021 WHERE n_orden = nOrden),
           'oftalmologia2021'

    UNION ALL
    SELECT EXISTS(SELECT 1 FROM certificado_manipuladores_barrick WHERE n_orden = nOrden),
           'certificado_manipuladores_barrick';

END;
$$;


CREATE OR REPLACE FUNCTION obtener_existencias_examenes(p_n_orden BIGINT)
RETURNS TABLE (
    tieneTriaje BOOLEAN,
    tieneLabClinico BOOLEAN,
    tieneInformeElectrocardiograma BOOLEAN,
    tieneRadiografiaTorax BOOLEAN,
    tieneFichaAudiologica BOOLEAN,
    tieneAudiometriaPo BOOLEAN,
    tieneFuncionAbs BOOLEAN,
    tieneOdontograma BOOLEAN,
    tieneInformePsicologico BOOLEAN,
    tieneAnexo16a BOOLEAN,
    tieneHistoriaOcInfo BOOLEAN,
    tieneAntecedentesPatologicos BOOLEAN,
    tieneCuestionarioNordico BOOLEAN,
    tieneCertificacionMedicaAltura BOOLEAN,
    tieneFichaSas BOOLEAN,
    tieneConsentimientoDosaje BOOLEAN,
    tienePerimetroToracico BOOLEAN,
    tieneExRadiograficosSanguineos BOOLEAN,
    tieneAnexo7c BOOLEAN,
    tieneOftalmologia BOOLEAN,
    tieneBCertificadoAltura BOOLEAN,
    tieneBCertificadoConduccion BOOLEAN,
    tieneBUsoRespiradores BOOLEAN,
    tieneCertificadoAptitudMoc BOOLEAN,
    tieneOit BOOLEAN,
    tieneCuestionarioAudiometria BOOLEAN,
    tieneInformeAudiometria BOOLEAN,
    tieneEvaluacionMusculoEsqueletica BOOLEAN,
    tieneAnexo7c2 BOOLEAN,
    tieneCertificadoAptitudMoc1 BOOLEAN,
    tieneAptoAgroindustrial BOOLEAN,
    tieneAnexoAgroindustrial BOOLEAN,
    tieneCertificadoAnexo02 BOOLEAN,
    tieneAnexo02 BOOLEAN,
    tieneAudiometria2021 BOOLEAN,
    tieneEvaluacionMusculoEsqueletica2021 BOOLEAN,
    tieneCuestionarioCalidadSueno BOOLEAN,
    tieneTestFatigaSomnolencia BOOLEAN,
    tieneOftalmologia2021 BOOLEAN,
    tieneCertificadoManipuladoresBarrick BOOLEAN
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        CASE WHEN t.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneTriaje,
        CASE WHEN lc.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneLabClinico,
        CASE WHEN ie.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneInformeElectrocardiograma,
        CASE WHEN rt.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneRadiografiaTorax,
        CASE WHEN fa.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneFichaAudiologica,
        CASE WHEN ap.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAudiometriaPo,
        CASE WHEN fab.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneFuncionAbs,
        CASE WHEN od.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneOdontograma,
        CASE WHEN ip.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneInformePsicologico,
        CASE WHEN a16.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAnexo16a,
        CASE WHEN hoi.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneHistoriaOcInfo,
        CASE WHEN ap2.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAntecedentesPatologicos,
        CASE WHEN cn.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCuestionarioNordico,
        CASE WHEN cma.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCertificacionMedicaAltura,
        CASE WHEN fs.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneFichaSas,
        CASE WHEN cd.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneConsentimientoDosaje,
        CASE WHEN pt.n_orden IS NULL THEN FALSE ELSE TRUE END AS tienePerimetroToracico,
        CASE WHEN ers.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneExRadiograficosSanguineos,
        CASE WHEN a7.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAnexo7c,
        CASE WHEN oft.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneOftalmologia,
        CASE WHEN bca.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneBCertificadoAltura,
        CASE WHEN bcc.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneBCertificadoConduccion,
        CASE WHEN bur.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneBUsoRespiradores,
        CASE WHEN camo.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCertificadoAptitudMoc,
        CASE WHEN oit.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneOit,
        CASE WHEN ca.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCuestionarioAudiometria,
        CASE WHEN ia.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneInformeAudiometria,
        CASE WHEN eme.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneEvaluacionMusculoEsqueletica,
        CASE WHEN a7c2.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAnexo7c2,
        CASE WHEN camo1.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCertificadoAptitudMoc1,
        CASE WHEN amoag.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAptoAgroindustrial,
        CASE WHEN aa.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAnexoAgroindustrial,
        CASE WHEN caa02.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCertificadoAnexo02,
        CASE WHEN an02.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAnexo02,
        CASE WHEN a21.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneAudiometria2021,
        CASE WHEN eme21.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneEvaluacionMusculoEsqueletica2021,
        CASE WHEN ccs.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCuestionarioCalidadSueno,
        CASE WHEN tfs.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneTestFatigaSomnolencia,
        CASE WHEN oft21.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneOftalmologia2021,
        CASE WHEN cmb.n_orden IS NULL THEN FALSE ELSE TRUE END AS tieneCertificadoManipuladoresBarrick
    FROM n_orden_ocupacional AS n
    LEFT JOIN triaje t ON t.n_orden = n.n_orden
    LEFT JOIN lab_clinico lc ON lc.n_orden = n.n_orden
    LEFT JOIN informe_electrocardiograma ie ON ie.n_orden = n.n_orden
    LEFT JOIN radiografia_torax rt ON rt.n_orden = n.n_orden
    LEFT JOIN ficha_audiologica fa ON fa.n_orden = n.n_orden
    LEFT JOIN audiometria_po ap ON ap.n_orden = n.n_orden
    LEFT JOIN funcion_abs fab ON fab.n_orden = n.n_orden
    LEFT JOIN odontograma od ON od.n_orden = n.n_orden
    LEFT JOIN informe_psicologico ip ON ip.n_orden = n.n_orden
    LEFT JOIN anexo16a a16 ON a16.n_orden = n.n_orden
    LEFT JOIN historia_oc_info hoi ON hoi.n_orden = n.n_orden
    LEFT JOIN antecedentes_patologicos ap2 ON ap2.n_orden = n.n_orden
    LEFT JOIN cuestionario_nordico cn ON cn.n_orden = n.n_orden
    LEFT JOIN certificacion_medica_altura cma ON cma.n_orden = n.n_orden
    LEFT JOIN ficha_sas fs ON fs.n_orden = n.n_orden
    LEFT JOIN consentimiento_dosaje cd ON cd.n_orden = n.n_orden
    LEFT JOIN perimetro_toracico pt ON pt.n_orden = n.n_orden
    LEFT JOIN ex_radiograficos_sanguineos ers ON ers.n_orden = n.n_orden
    LEFT JOIN anexo7c a7 ON a7.n_orden = n.n_orden
    LEFT JOIN oftalmologia oft ON oft.n_orden = n.n_orden
    LEFT JOIN b_certificado_altura bca ON bca.n_orden = n.n_orden
    LEFT JOIN b_certificado_conduccion bcc ON bcc.n_orden = n.n_orden
    LEFT JOIN b_uso_respiradores bur ON bur.n_orden = n.n_orden
    LEFT JOIN certificado_aptitud_medico_ocupacional camo ON camo.n_orden = n.n_orden
    LEFT JOIN oit oit ON oit.n_orden = n.n_orden
    LEFT JOIN cuestionario_audiometria ca ON ca.n_orden = n.n_orden
    LEFT JOIN informe_audiometria ia ON ia.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica eme ON eme.n_orden = n.n_orden
    LEFT JOIN anexo7c2 a7c2 ON a7c2.n_orden = n.n_orden
    LEFT JOIN certificado_aptitud_medico_ocupacional1 camo1 ON camo1.n_orden = n.n_orden
    LEFT JOIN aptitud_medico_ocupacional_agro amoag ON amoag.n_orden = n.n_orden
    LEFT JOIN anexo_agroindustrial aa ON aa.n_orden = n.n_orden
    LEFT JOIN certificado_aptitud_anexo02 caa02 ON caa02.n_orden = n.n_orden
    LEFT JOIN anexo_02 an02 ON an02.n_orden = n.n_orden
    LEFT JOIN audiometria_2021 a21 ON a21.n_orden = n.n_orden
    LEFT JOIN evaluacion_musculo_esqueletica2021 eme21 ON eme21.n_orden = n.n_orden
    LEFT JOIN cuestionario_calidad_sueno ccs ON ccs.n_orden = n.n_orden
    LEFT JOIN test_fatiga_somnolencia tfs ON tfs.n_orden = n.n_orden
    LEFT JOIN oftalmologia2021 oft21 ON oft21.n_orden = n.n_orden
    LEFT JOIN certificado_manipuladores_barrick cmb ON cmb.n_orden = n.n_orden
    WHERE n.n_orden = p_n_orden;
END;
$$ LANGUAGE plpgsql;


CREATE TABLE n_orden_examen_adicional (
    id SERIAL PRIMARY KEY,
    n_orden BIGINT NOT NULL,
    id_examen_adicional_protocolo BIGINT NOT NULL,
    version_registro INTEGER,
    usuario_registro text,
    fecha_registro date,
    hora_registro TIME,
    CONSTRAINT fk_n_orden
        FOREIGN KEY (n_orden)
        REFERENCES n_orden_ocupacional(n_orden)
);

CREATE TABLE configuracion_deposito (
    id SERIAL PRIMARY KEY,
    codigo_transferencia TEXT,
    banco TEXT,
    monto numeric(38,2),
    archivo TEXT,
    usuario_registro text,
    fecha_registro date,
    hora_registro TIME,
    usuario_actualizacion text,
    fecha_actualizacion date,
    hora_actualizacion TIME,
    estado boolean
);

CREATE TABLE detalle_pago (
    id SERIAL PRIMARY KEY,
    n_orden integer NOT NULL,
    version_registro INTEGER,
    monto_adicionales numeric(38,2),
    monto_protocolo numeric(38,2),
    monto_total numeric(38,2),
    id_configuracion_deposito INTEGER,
    fecha_pago date,
    hora_pago TIME,
    forma_pago text,
    usuario_registro text,
    fecha_registro date,
    hora_registro TIME,
    usuario_actualizacion text,
    fecha_actualizacion date,
    hora_actualizacion TIME,
    estado boolean,
    CONSTRAINT fk_n_orden
        FOREIGN KEY (n_orden)
        REFERENCES n_orden_ocupacional(n_orden),
    CONSTRAINT fk_id_configuracion_deposito
        FOREIGN KEY (id_configuracion_deposito)
        REFERENCES configuracion_deposito(id)
);





CREATE TABLE panel4d (
    id SERIAL PRIMARY KEY,
    n_orden BIGINT NOT NULL UNIQUE,
    cocaina BOOLEAN,
    marihuana BOOLEAN,
    opiaceos BOOLEAN,
    metanfetamina BOOLEAN,
    CONSTRAINT fk_n_orden
        FOREIGN KEY (n_orden)
        REFERENCES n_orden_ocupacional (n_orden)
);




SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END INTO user_registro_var 
            FROM certificado_aptitud_medico_resumen WHERE n_orden = norden_param;



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
