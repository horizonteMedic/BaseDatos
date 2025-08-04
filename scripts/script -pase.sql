CREATE OR REPLACE FUNCTION buscar_odontograma_pornombreonorden(
    IN n_orden_param integer,
    IN nombres_param text)
  RETURNS TABLE(cod_od integer, nombres text, n_orden integer, fecha_od date) AS
$BODY$
BEGIN

 RETURN QUERY 
 SELECT
    o.cod_od,
    dp.nombres_pa || '' || dp.apellidos_pa AS nombres,
    o.n_orden,
    o.fecha_od
FROM
    odontograma o
INNER JOIN 
    n_orden_ocupacional noo
    ON noo.n_orden = o.n_orden
INNER JOIN 
    datos_paciente dp
    ON dp.cod_pa = noo.cod_pa
WHERE 
    (n_orden_param IS NULL OR o.n_orden = n_orden_param)
    AND (nombres_param IS NULL OR CONCAT(dp.nombres_pa,' ',dp.apellidos_pa) ILIKE '%' || nombres_param || '%')
ORDER BY 
    o.n_orden DESC
LIMIT 100;

END; $BODY$
  LANGUAGE plpgsql;s