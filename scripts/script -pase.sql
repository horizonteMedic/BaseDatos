CREATE OR REPLACE FUNCTION obtener_reporte_historiaocupacional(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_nac date, lugar_nacimiento text, cel_pa text, sexo "char", lugar_procedencia text, medico_asignado text, cod_ho integer, area_o text, fecha_ho date, na text, fecha text, empresa text, actividad text, area_empresa text, ocupacion text, superficie text, socavon text, riesgo text, proteccion text, altitud text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, orden integer) AS
$BODY$
DECLARE 
    empresa_var TEXT;
BEGIN


    SELECT trim(razon_empresa) INTO empresa_var FROM n_orden_ocupacional as n WHERE n.n_orden = p_norden;

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
			UPDATE historia_oc_info SET dni_user=42664426, user_registro='AGARCIA' where historia_oc_info.n_orden=p_norden;
		ELSIF(empresa_var='MONARCA GOLD S.A.C.') THEN
			UPDATE historia_oc_info SET dni_user=66666666, user_registro='SHNEIDER' where historia_oc_info.n_orden=p_norden;
		END IF;

  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    hoi.n_orden,
    noo.cod_pa,
    dp.fecha_nacimiento_pa,
    dp.lugar_nac_pa,
    dp.cel_pa,
    dp.sexo_pa,
    dp.direccion_pa ||'-'|| dp.distrito_pa ||'-'|| dp.provincia_pa ||'-'|| dp.departamento_pa,
    CAST(' ' as text),

    hoi.cod_ho,
    hoi.area_o,
    hoi.fecha_ho,
    hoi.na,

    hod.fecha,
    hod.empresa,
    hod.actividad,
    hod.area_empresa,
    hod.ocupacion,
    hod.superficie,
    hod.socavon,
    hod.riesgo,
    hod.proteccion,
    hod.altitud,


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
    hod.orden

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN historia_oc_info hoi ON hoi.n_orden = noo.n_orden
  INNER JOIN historia_oc_detalle hod ON hod.cod_ho = hoi.cod_ho
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;