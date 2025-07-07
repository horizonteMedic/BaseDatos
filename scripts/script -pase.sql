--Ficha audiologica
CREATE OR REPLACE FUNCTION obtener_informacion_FichaAudiologica(p_norden INTEGER)
RETURNS TABLE (
  nombres TEXT,
  edad TEXT,
  n_orden integer,
  dni integer,

  cod_fa integer,
  fecha_examen date,
  tiempo_trabajo integer,
  tiempo_exposicion_total_ponderado text,
  edad_fa text,
  chk_tapones boolean,
  chkgrajeras boolean,
  chkintenso boolean,
  chkmoderado boolean,
  chknomolesto boolean,
  txtmarca text,
  txtmodelo text,
  fechacalibracion date,
  chk1_si boolean,
  chk2_si boolean,
  chk3_si boolean,
  chk4_si boolean,
  chk5_si boolean,
  chk6_si boolean,
  chk7_si boolean,
  chk8_si boolean,
  chk9_si boolean,
  chk10_si boolean,
  chk11_si boolean,
  chk12_si boolean,
  chk1_no boolean,
  chk2_no boolean,
  chk3_no boolean,
  chk4_no boolean,
  chk5_no boolean,
  chk6_no boolean,
  chk7_no boolean,
  chk8_no boolean,
  chk9_no boolean,
  chk10_no boolean,
  chk11_no boolean,
  chk12_no boolean,
  txtdod250 text,
  txtdod500 text,
  txtdod1000 text,
  txtdoi250 text,
  txtdoi500 text,
  txtdoi1000 text,
  txtldumbraldiscriminacion text,
  txtliumbraldiscriminacion text,
  txtldporcentagediscriminacion text,
  txtliporcentagediscriminacion text,
  txtldconfort text,
  txtliconfort text,
  txtlddisconfort text,
  txtlidisconfort text,
  txtresponsable text,
  txtconclusiones text,
  txtmedico text,
  txtotoscopia text,
  txtmesestrabajo integer,
  user_registro text
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    fa.n_orden,
    noo.cod_pa,

    fa.cod_fa,
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
    fa.txtresponsable,
    fa.txtconclusiones,
    fa.txtmedico,
    fa.txtotoscopia,
    fa.txtmesestrabajo,
    fa.user_registro

    
  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$$ LANGUAGE plpgsql;

----------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION obtener_reporte_AudiometriaM(p_norden INTEGER)
RETURNS TABLE (
  nombres TEXT,
  edad TEXT,
  n_orden integer,
  dni integer,
  
  num_ticket integer,
  fecha_au date,
  o_d_500 text,
  o_d_1000 text,
  o_d_2000 text,
  o_d_3000 text,
  o_d_4000 text,
  o_d_6000 text,
  o_d_8000 text,
  o_i_500 text,
  o_i_1000 text,
  o_i_2000 text,
  o_i_3000 text,
  o_i_4000 text,
  o_i_6000 text,
  o_i_8000 text,
  o_d1_500 text,
  o_d1_1000 text,
  o_d1_2000 text,
  o_d1_3000 text,
  o_d1_4000 text,
  o_d1_6000 text,
  o_d1_8000 text,
  o_i1_500 text,
  o_i1_1000 text,
  o_i1_2000 text,
  o_i1_3000 text,
  o_i1_4000 text,
  o_i1_6000 text,
  o_i1_8000 text,
  diagnostico text,

  fecha_examen date,
  tiempo_trabajo integer,
  tiempo_exposicion_total_ponderado text,
  edad_fa text,
  chk_tapones boolean,
  chkgrajeras boolean,
  chkintenso boolean,
  chkmoderado boolean,
  chknomolesto boolean,
  txtmarca text,
  txtmodelo text,
  fechacalibracion date,
  chk1_si boolean,
  chk2_si boolean,
  chk3_si boolean,
  chk4_si boolean,
  chk5_si boolean,
  chk6_si boolean,
  chk7_si boolean,
  chk8_si boolean,
  chk9_si boolean,
  chk10_si boolean,
  chk11_si boolean,
  chk12_si boolean,
  chk1_no boolean,
  chk2_no boolean,
  chk3_no boolean,
  chk4_no boolean,
  chk5_no boolean,
  chk6_no boolean,
  chk7_no boolean,
  chk8_no boolean,
  chk9_no boolean,
  chk10_no boolean,
  chk11_no boolean,
  chk12_no boolean,
  txtdod250 text,
  txtdod500 text,
  txtdod1000 text,
  txtdoi250 text,
  txtdoi500 text,
  txtdoi1000 text,
  txtldumbraldiscriminacion text,
  txtliumbraldiscriminacion text,
  txtldporcentagediscriminacion text,
  txtliporcentagediscriminacion text,
  txtldconfort text,
  txtliconfort text,
  txtlddisconfort text,
  txtlidisconfort text,
  txtresponsable text,
  txtconclusiones text,
  txtmedico text,
  txtotoscopia text,
  txtmesestrabajo integer,

  color INTEGER,
  sede_descripcion TEXT,

  dir_sede4 TEXT,
  email_sede4 TEXT,
  tel_sede4 TEXT,
  cel_sede4 TEXT,

  dir_sede3 TEXT,
  email_sede3 TEXT,
  tel_sede3 TEXT,

  dir_sede2 TEXT,
  email_sede2 TEXT,
  tel_sede2 TEXT,
  cel_sede2 TEXT,

  dir_sede1 TEXT,
  email_sede1 TEXT,
  tel_sede1 TEXT
  
)
AS $$
BEGIN
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
    fa.txtresponsable,
    fa.txtconclusiones,
    fa.txtmedico,
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
    (SELECT telefono FROM sede WHERE cod_sede = 1)

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
  INNER JOIN audiometria_po apo ON apo.n_orden = fa.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION buscar_AudiometriaPo_PorNombreONOrden(n_orden_param INTEGER, nombres_param TEXT)
RETURNS TABLE(
 nombres TEXT,
 cod_au INTEGER,
 n_orden INTEGER,
 fecha_au DATE
) AS
$BODY$
BEGIN

 RETURN QUERY 
 SELECT 
  dp.nombres_pa || ' ' || dp.apellidos_pa AS nombres, 
  apo.cod_au,
  apo.n_orden,
  apo.fecha_au
FROM datos_paciente dp
INNER JOIN n_orden_ocupacional noo ON dp.cod_pa = noo.cod_pa
INNER JOIN audiometria_po apo ON noo.n_orden = apo.n_orden
WHERE 
  (n_orden_param IS NULL OR apo.n_orden = n_orden_param)
  AND (nombres_param IS NULL OR CONCAT(dp.nombres_pa, ' ', dp.apellidos_pa) ILIKE '%' || nombres_param || '%')
ORDER BY apo.fecha_au DESC
LIMIT 100;

END; $BODY$
  LANGUAGE plpgsql;