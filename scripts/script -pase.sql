drop FUNCTION obtener_reporte_informe_electro_cardiograma(
    IN p_norden integer,
    IN name_service text)

CREATE OR REPLACE FUNCTION obtener_reporte_informe_electro_cardiograma(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(nombres text, sexo "char", dni integer, edad text, empresa text, contrata text, codigo_electrocardiograma integer, n_orden integer, fecha_informe date, mensaje_ritmo text, mensaje_pr text, mensaje_fc text, mensaje_qtc text, mensaje_qrs text, mensaje_eje text, hallazgo text, conclusion text, recomendaciones text, color integer, sede text, codigo_sede text, name_jasper text, onda_p text, s_t text, onda_t text, q_t text, fecha_nacimiento date, informe_completo boolean, presion_arterial text, procedencia text, descripcion_digitalizacion text, name_digitalizacion text, dni_digitalizacion integer) AS
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