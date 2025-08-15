drop FUNCTION obtener_reporte_consentimiento_informado(IN p_norden integer)

CREATE OR REPLACE FUNCTION obtener_reporte_consentimiento_informado(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(n_orden integer, nombres text, dni integer, fechanac date, empresa text, contrata text, ocupacion text, fecha date, hora time without time zone, color integer, sede_descripcion text, nom_sede text, nombre_jasper text, descripcion_digitalizacion text, name_digitalizacion text, dni_digitalizacion integer) AS
$BODY$
BEGIN
    -- Tabla temporal para los parametros digitalizados
    CREATE TEMP TABLE temp_digitalizados_consentimiento_informado AS
    SELECT p_norden AS n_orden, *
    FROM obtener_parametros_digitalizados(p_norden, name_service);
    
    RETURN QUERY
    SELECT 
    CASE WHEN ci.n_orden IS NULL THEN noo.n_orden ELSE ci.n_orden END,
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    noo.cod_pa,
    dp.fecha_nacimiento_pa,
    --CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
    noo.razon_empresa,
    noo.razon_contrata,
    noo.cargo_de,
    ci.fecha,
    ci.hora,
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
    td.descripcion,
    td.name_digitalizacion,
    td.dni
  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN consentimientoInformado ci ON ci.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  INNER JOIN temp_digitalizados_consentimiento_informado td ON ci.n_orden = td.n_orden
  WHERE noo.n_orden = p_norden;

  DROP TABLE IF EXISTS temp_digitalizados_consentimiento_informado;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
