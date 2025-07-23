CREATE OR REPLACE FUNCTION buscar_oftalmologia_pornombreonorden(
    IN n_orden_param integer,
    IN nombres_param text)
  RETURNS TABLE(nombres text, cod_of integer, n_orden integer, fecha_of date, f_actualizacion date) AS
$BODY$
BEGIN

 RETURN QUERY 
 SELECT 
    dp.nombres_pa || '' || dp.apellidos_pa AS nombres,
    o.cod_of,
    o.n_orden,
    o.fecha_of,
    o.f_actualizacion
FROM 
    datos_paciente dp
INNER JOIN 
    n_orden_ocupacional noo
    ON dp.cod_pa = noo.cod_pa
INNER JOIN 
    oftalmologia o
    ON noo.n_orden = o.n_orden
WHERE 
    (n_orden_param IS NULL OR o.n_orden = n_orden_param)
    AND (nombres_param IS NULL OR CONCAT(dp.nombres_pa,' ',dp.apellidos_pa) ILIKE '%' || nombres_param || '%')
ORDER BY 
    o.n_orden DESC
LIMIT 100;

END; $BODY$
  LANGUAGE plpgsql;