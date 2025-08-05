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
  LANGUAGE plpgsql;


-------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION obtener_reporte_evaluacion_musculo_esqueletica(IN p_norden integer)
  RETURNS TABLE(
nombres text,
sexo "char",
dni integer,
edad text,
empresa text,
contrata text,
area_trabajo text,
cod_eval integer,
  n_orden integer,
  t_servicio text,
  f_examen date,
  rbsintoma_si boolean,
  rbsintoma_no boolean,
  txtsintomas text,
  rbfaja_si boolean,
  rbfaja_no boolean,
  rbtecnicacarga_si boolean,
  rbtecnicacarga_no boolean,
  rbcapacitacioncarga_si boolean,
  rbcapacitacioncarga_no boolean,
  txtextencion_cabeza text,
  txtflexion_cabeza text,
  rbextension_cabeza_n boolean,
  rbextension_cabeza_r boolean,
  rbextension_cabeza_m boolean,
  rbflexion_cabeza_n boolean,
  rbflexion_cabeza_r boolean,
  rbflexion_cabeza_m boolean,
  rbflexion_hombro_n boolean,
  rbflexion_hombro_r boolean,
  rbflexion_hombro_m boolean,
  rbflexion_hombro_n1 boolean,
  rbflexion_hombro_r1 boolean,
  rbflexion_hombro_m1 boolean,
  rbextension_hombro_n boolean,
  rbextension_hombro_r boolean,
  rbextension_hombro_m boolean,
  rbextension_hombro_n1 boolean,
  rbextension_hombro_r1 boolean,
  rbextension_hombro_m1 boolean,
  rbabduccion_hombro_n boolean,
  rbabduccion_hombro_r boolean,
  rbabduccion_hombro_m boolean,
  rbabduccion_hombro_n1 boolean,
  rbabduccion_hombro_r1 boolean,
  rbabduccion_hombro_m1 boolean,
  rbaduccion_hombro_n boolean,
  rbaduccion_hombro_r boolean,
  rbaduccion_hombro_m boolean,
  rbaduccion_hombro_n1 boolean,
  rbaduccion_hombro_r1 boolean,
  rbaduccion_hombro_m1 boolean,
  rbrotacionint_hombro_n boolean,
  rbrotacionint_hombro_r boolean,
  rbrotacionint_hombro_m boolean,
  rbrotacionint_hombro_n1 boolean,
  rbrotacionint_hombro_r1 boolean,
  rbrotacionint_hombro_m1 boolean,
  rbrotacionext_hombro_n boolean,
  rbrotacionext_hombro_r boolean,
  rbrotacionext_hombro_m boolean,
  rbrotacionext_hombro_n1 boolean,
  rbrotacionext_hombro_r1 boolean,
  rbrotacionext_hombro_m1 boolean,
  rbflexion_brazo_n boolean,
  rbflexion_brazo_r boolean,
  rbflexion_brazo_m boolean,
  rbflexion_brazo_n1 boolean,
  rbflexion_brazo_r1 boolean,
  rbflexion_brazo_m1 boolean,
  rbextension_brazo_n boolean,
  rbextension_brazo_r boolean,
  rbextension_brazo_m boolean,
  rbextension_brazo_n1 boolean,
  rbextension_brazo_r1 boolean,
  rbextension_brazo_m1 boolean,
  rbpronacion_antebrazo_n boolean,
  rbpronacion_antebrazo_r boolean,
  rbpronacion_antebrazo_m boolean,
  rbpronacion_antebrazo_n1 boolean,
  rbpronacion_antebrazo_r1 boolean,
  rbpronacion_antebrazo_m1 boolean,
  rbsupinacion_antebrazo_n boolean,
  rbsupinacion_antebrazo_r boolean,
  rbsupinacion_antebrazo_m boolean,
  rbsupinacion_antebrazo_n1 boolean,
  rbsupinacion_antebrazo_r1 boolean,
  rbsupinacion_antebrazo_m1 boolean,
  rbflexion_munieca_n boolean,
  rbflexion_munieca_r boolean,
  rbflexion_munieca_m boolean,
  rbflexion_munieca_n1 boolean,
  rbflexion_munieca_r1 boolean,
  rbflexion_munieca_m1 boolean,
  rbextension_munieca_n boolean,
  rbextension_munieca_r boolean,
  rbextension_munieca_m boolean,
  rbextension_munieca_n1 boolean,
  rbextension_munieca_r1 boolean,
  rbextension_munieca_m1 boolean,
  rbdesvcubital_munieca_n boolean,
  rbdesvcubital_munieca_r boolean,
  rbdesvcubital_munieca_m boolean,
  rbdesvcubital_munieca_n1 boolean,
  rbdesvcubital_munieca_r1 boolean,
  rbdesvcubital_munieca_m1 boolean,
  rbdesvradial_munieca_n boolean,
  rbdesvradial_munieca_r boolean,
  rbdesvradial_munieca_m boolean,
  rbdesvradial_munieca_n1 boolean,
  rbdesvradial_munieca_r1 boolean,
  rbdesvradial_munieca_m1 boolean,
  rbphallen_si boolean,
  rbphallen_no boolean,
  rbtinel_si boolean,
  rbtinel_no boolean,
  rbflexion_torax_n boolean,
  rbflexion_torax_r boolean,
  rbflexion_torax_m boolean,
  rbflexion_torax_n1 boolean,
  rbflexion_torax_r1 boolean,
  rbflexion_torax_m1 boolean,
  rbextension_torax_n boolean,
  rbextension_torax_r boolean,
  rbextension_torax_m boolean,
  rbextension_torax_n1 boolean,
  rbextension_torax_r1 boolean,
  rbextension_torax_m1 boolean,
  rbrotacion_torax_n boolean,
  rbrotacion_torax_r boolean,
  rbrotacion_torax_m boolean,
  rbrotacion_torax_n1 boolean,
  rbrotacion_torax_r1 boolean,
  rbrotacion_torax_m1 boolean,
  rbflexion_cadera_n boolean,
  rbflexion_cadera_r boolean,
  rbflexion_cadera_m boolean,
  rbflexion_cadera_n1 boolean,
  rbflexion_cadera_r1 boolean,
  rbflexion_cadera_m1 boolean,
  rbextension_cadera_n boolean,
  rbextension_cadera_r boolean,
  rbextension_cadera_m boolean,
  rbextension_cadera_n1 boolean,
  rbextension_cadera_r1 boolean,
  rbextension_cadera_m1 boolean,
  rbabduccion_cadera_n boolean,
  rbabduccion_cadera_r boolean,
  rbabduccion_cadera_m boolean,
  rbabduccion_cadera_n1 boolean,
  rbabduccion_cadera_r1 boolean,
  rbabduccion_cadera_m1 boolean,
  rbaduccion_cadera_n boolean,
  rbaduccion_cadera_r boolean,
  rbaduccion_cadera_m boolean,
  rbaduccion_cadera_n1 boolean,
  rbaduccion_cadera_r1 boolean,
  rbaduccion_cadera_m1 boolean,
  rbrotacionint_cadera_n boolean,
  rbrotacionint_cadera_r boolean,
  rbrotacionint_cadera_m boolean,
  rbrotacionint_cadera_n1 boolean,
  rbrotacionint_cadera_r1 boolean,
  rbrotacionint_cadera_m1 boolean,
  rbrotacionext_cadera_n boolean,
  rbrotacionext_cadera_r boolean,
  rbrotacionext_cadera_m boolean,
  rbrotacionext_cadera_n1 boolean,
  rbrotacionext_cadera_r1 boolean,
  rbrotacionext_cadera_m1 boolean,
  rbflexion_pierna_n boolean,
  rbflexion_pierna_r boolean,
  rbflexion_pierna_m boolean,
  rbflexion_pierna_n1 boolean,
  rbflexion_pierna_r1 boolean,
  rbflexion_pierna_m1 boolean,
  rbextension_pierna_n boolean,
  rbextension_pierna_r boolean,
  rbextension_pierna_m boolean,
  rbextension_pierna_n1 boolean,
  rbextension_pierna_r1 boolean,
  rbextension_pierna_m1 boolean,
  rbflexion_rodilla_n boolean,
  rbflexion_rodilla_r boolean,
  rbflexion_rodilla_m boolean,
  rbflexion_rodilla_n1 boolean,
  rbflexion_rodilla_r1 boolean,
  rbflexion_rodilla_m1 boolean,
  rbextension_rodilla_n boolean,
  rbextension_rodilla_r boolean,
  rbextension_rodilla_m boolean,
  rbextension_rodilla_n1 boolean,
  rbextension_rodilla_r1 boolean,
  rbextension_rodilla_m1 boolean,
  rbrotacionint_rodilla_n boolean,
  rbrotacionint_rodilla_r boolean,
  rbrotacionint_rodilla_m boolean,
  rbrotacionint_rodilla_n1 boolean,
  rbrotacionint_rodilla_r1 boolean,
  rbrotacionint_rodilla_m1 boolean,
  rbrotacionext_rodilla_n boolean,
  rbrotacionext_rodilla_r boolean,
  rbrotacionext_rodilla_m boolean,
  rbrotacionext_rodilla_n1 boolean,
  rbrotacionext_rodilla_r1 boolean,
  rbrotacionext_rodilla_m1 boolean,
  rbflexion_tobillo_n boolean,
  rbflexion_tobillo_r boolean,
  rbflexion_tobillo_m boolean,
  rbflexion_tobillo_n1 boolean,
  rbflexion_tobillo_r1 boolean,
  rbflexion_tobillo_m1 boolean,
  rbextension_tobillo_n boolean,
  rbextension_tobillo_r boolean,
  rbextension_tobillo_m boolean,
  rbextension_tobillo_n1 boolean,
  rbextension_tobillo_r1 boolean,
  rbextension_tobillo_m1 boolean,
  rbfuerzamuscular_1 boolean,
  rbfuerzamuscular_2 boolean,
  rbfuerzamuscular_3 boolean,
  rbfuerzamuscular_4 boolean,
  rbfuerzamuscular_5 boolean,
  rbejecervical_normal boolean,
  rbejecervical_derecha boolean,
  rbejecervical_izq boolean,
  rbejedorsal_normal boolean,
  rbejedorsal_derecha boolean,
  rbejedorsal_izq boolean,
  rbejelumbar_normal boolean,
  rbejelumbar_derecha boolean,
  rbejelumbar_izq boolean,
  rbcifosis_si boolean,
  rbcifosis_no boolean,
  rbescoliosis_si boolean,
  rbescoliosis_no boolean,
  rblordosis_si boolean,
  rblordosis_no boolean,
  rbmixta_si boolean,
  rbmixta_no boolean,
  rbcervical_si boolean,
  rbcervical_no boolean,
  rbdorsal_si boolean,
  rbdorsal_no boolean,
  rblumbar_si boolean,
  rblumbra_no boolean,
  rblesagueder_si boolean,
  rblesagueder_no boolean,
  rblesagueizq_si boolean,
  rblesagueizq_no boolean,
  chktratamiento_si boolean,
  chktratamiento_no boolean,
  dni_user integer,
  txtdiagnostico text,
  chkconclusion_si boolean,
  chkconclusion_no boolean,
  txtrecomendaciones text,
color integer,
sede_descripcion text,
dir_sede4 text,
email_sede4 text,
tel_sede4 text,
cel_sede4 text,
dir_sede3 text,
email_sede3 text,
tel_sede3 text,
dir_sede2 text,
email_sede2 text,
tel_sede2 text,
cel_sede2 text,
dir_sede1 text,
email_sede1 text,
tel_sede1 text,
nom_medico text
  ) AS
$BODY$
BEGIN

  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
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
    u.nombre_user||' '||u.apellido_user AS nom_medico

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN evaluacion_musculo_esqueletica eme ON eme.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  INNER JOIN usuarios u ON (u.dni_user = eme.dni_user)
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

  insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('evaluacion_musculo_esqueletica','formulario de evaluacion musculo esqueletica',true,true,true,false,false);


CREATE OR REPLACE FUNCTION obtener_name_jasper(
    norden_param bigint,
    name_service_param text)
  RETURNS text AS
$BODY$
DECLARE
    resultado text;
    name_empresa_busqueda_var text;
    name_valor_microbiologia_var text;
    name_valor_hepatitisa_var text;
    valor_coproparasitologico_var boolean;
    valor_cuantitativo_antigeno_var boolean;
    valor_formato_marsa_var boolean;
BEGIN
   -- Obtener el nombre de la empresa de la historia clinica a registrar;
    SELECT trim(razon_empresa) INTO name_empresa_busqueda_var from n_orden_ocupacional where n_orden=norden_param;

   -- obtener el valor del txt en microbiologia
    SELECT trim(txtkoh) INTO name_valor_microbiologia_var from microbiologia where n_orden=norden_param;

   -- obtener el valor del txt en hepatitis
    SELECT trim(txthepatitisa) INTO name_valor_hepatitisa_var from lhepatitis where n_orden=norden_param;

   -- obtener el valor del boolean en coproparasitologico
    SELECT tipo_coproparasitologico INTO valor_coproparasitologico_var from ac_coproparasitologico where n_orden=norden_param;

   -- obtener los valores de los booleanos en examen inmunologico
    SELECT cuantitativo_antigeno, formato_marsa INTO valor_cuantitativo_antigeno_var, valor_formato_marsa_var from examen_inmunologico where n_orden=norden_param;

    IF name_service_param = 'con_panel10D' THEN
        resultado := 'Consentimiento_Panel10D_Digitalizado';

    ELSIF name_service_param = 'con_panel5D' THEN
        IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'Consentimiento_Panel5D_ohla_Digitalizado';
        ELSE
            resultado := 'Consentimiento_Panel5D_Digitalizado';
        END IF;

    ELSIF name_service_param = 'con_panel3D' THEN
        resultado := 'Consentimiento_Panel3D_Digitalizado';

    ELSIF name_service_param = 'con_panel2D' THEN
        resultado := 'Consentimiento_Panel2D_Digitalizado';

    ELSIF name_service_param = 'consent_Muestra_Sangre' THEN
        resultado := 'Consentimiento_Muestra_Sangre_Digitalizado';

    ELSIF name_service_param = 'consent_marihuana' THEN
        resultado := 'Consentimiento_Marihuana_Digitalizado';

    ELSIF name_service_param = 'consent_Boro' THEN
        resultado := 'Consentimiento_Boro_Digitalizado';
        
    ELSIF name_service_param = 'analisis_bioquimicos' THEN
        resultado := 'AnalisisBioquimicos_Digitalizado';

    ELSIF name_service_param = 'lab_clinico' THEN
        resultado := 'LaboratorioClinico_Digitalizado'; 

    ELSIF name_service_param = 'hemograma_autom' THEN
        resultado := 'Hematologia_Digitalizado'; 

    ELSIF name_service_param = 'lgonadotropina' THEN
        resultado := 'LGonadotropina_Digitalizado'; 

    ELSIF name_service_param = 'panel2d' THEN
        resultado := 'Panel2d_Digitalizado';  

    ELSIF name_service_param = 'panel3d' THEN
        resultado := 'Panel3d_Digitalizado';                                      

    ELSIF name_service_param = 'toxicologia' THEN
        IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
            resultado := 'ResultadosPanel5d_ohla_Digitalizado';
        ELSE
            resultado := 'ResultadosPanel5d_Digitalizado';
        END IF;

    ELSIF name_service_param = 'panel10d' THEN
        resultado := 'Panel10d_Digitalizado';                                      

    ELSIF name_service_param = 'inmunologia' THEN
        resultado := 'InmunologiaLab_Digitalizado';     

    ELSIF name_service_param = 'microbiologia' THEN
	IF name_valor_microbiologia_var IS NOT NULL AND LENGTH(name_valor_microbiologia_var) > 0 THEN
	resultado :=  'Microbiologia1_Digitalizado';
	ELSE
	resultado :=  'Microbiologia_Digitalizado';
	END IF;      


    ELSIF name_service_param = 'lhepatitis' THEN
	IF name_valor_hepatitisa_var IS NOT NULL AND LENGTH(name_valor_hepatitisa_var) > 0 THEN
	resultado :=  'LHepatitisA_Digitalizado';
	ELSE
	resultado :=  'LHepatitisB_Digitalizado';
	END IF;      

    ELSIF name_service_param = 'l_bioquimica' THEN
        resultado := 'LBioquimica_Digitalizado';     

    ELSIF name_service_param = 'ac_bioquimica2022' THEN
        resultado := 'AnalisisClinicosB_Digitalizado';     

    ELSIF name_service_param = 'perfil_hepatico' THEN
        resultado := 'PerfilHepatico_Digitalizado';     

    ELSIF name_service_param = 'ac_coprocultivo' THEN
        resultado := 'coprocultivo_digitalizado';           

    ELSIF name_service_param = 'ac_coproparasitologico' THEN
        IF valor_coproparasitologico_var = true THEN
            resultado := 'Coproparasitologico_Digitalizado';
        ELSE
            resultado := 'ParasitologiaSeriado_Digitalizado';
        END IF;

    ELSIF name_service_param = 'examen_inmunologico' THEN
        IF valor_cuantitativo_antigeno_var = true THEN
	        resultado := 'pcuantiantigeno';
	ELSE
            IF valor_formato_marsa_var = true THEN
                resultado := 'pcualitativaantigenoMarsa';
            ELSE
                resultado := 'pcualitativaantigeno';
            END IF;
	END IF;
    ELSIF name_service_param = 'audiometria_2023' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'Audiometria2021-_Digitalizado_boro'; 
        ELSE
            resultado := 'Audiometria2021-_Digitalizado';
        END IF;
    ELSIF name_service_param = 'historia_oc_info' THEN
        IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'HistoriaOcupacional_Digitalizado_boro'; 
        ELSE
            resultado := 'HistoriaOcupacional_Digitalizado';
        END IF;
    ELSIF name_service_param = 'audiometria_po' THEN
        resultado := 'FichaAudiologica_Digitalizado';
    ELSIF name_service_param = 'cuestionario_audiometria' THEN
        resultado := 'CuestionarioAudiometria_Digitalizado';
    ELSIF name_service_param = 'oftalmologia_lo' THEN
        resultado := 'OftalmologiaLO';
    ELSIF name_service_param = 'oftalmologia' THEN
        resultado := 'Oftalmologia';
    ELSIF name_service_param = 'oftalmologia_reporte' THEN
        resultado := 'ReporteOftalmologico';
    ELSIF name_service_param = 'oftalmologia2021' THEN
	IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'EvaluacionOftalmologica2021_Digitalizado_boro';
        ELSIF name_empresa_busqueda_var LIKE 'OBRASCÓN HUARTE LAIN S.A' THEN
	    resultado := 'EvaluacionOftalmologica2021_Digitalizado_ohla';
        ELSE
            resultado := 'EvaluacionOftalmologica2021_Digitalizado';
        END IF;
    ELSIF name_service_param = 'odontograma' THEN
        resultado := 'Odontograma_Digitalizado';
    ELSIF name_service_param = 'odontograma_lo' THEN
        resultado := 'Odontograma_lo_Digitalizado';
    ELSIF name_service_param = 'radiografia_torax' THEN
        resultado := 'RagiografiaToraxPA_Digitalizado';
    ELSIF name_service_param = 'radiografia_fechas' THEN
        resultado := 'ReporteFechasRadiografia_Digitalizado';
    ELSIF name_service_param = 'radiografia' THEN
        resultado := 'RAYOSXXXOFI_Digitalizado';
    ELSIF name_service_param = 'oit' THEN
	IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		resultado := 'OIT_Digitalizado_boro';
	ELSE
		resultado := 'OIT_B_Digitalizado';
	END IF;
    ELSIF name_service_param = 'evaluacion_musculo_esqueletica' THEN
        resultado := 'EvaluacionMuscoloEsqueletica';
    END IF;
    RETURN resultado;
END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_parametros_digitalizados(
    IN norden_param bigint,
    IN name_servicio_param text)
  RETURNS TABLE(descripcion text, name_digitalizacion text, dni integer) AS
$BODY$
DECLARE 
    dni_paciente_var INTEGER;
    dni_user_registro_var INTEGER;
    dni_user_doctor_asig_var INTEGER;
    dni_user_doc_adic_var INTEGER;
    empresa_var TEXT;
    user_registro_var TEXT;
BEGIN
    -- Obtener DNI del paciente
    SELECT cod_pa INTO dni_paciente_var FROM n_orden_ocupacional WHERE n_orden = norden_param;
    SELECT trim(razon_empresa) INTO empresa_var FROM n_orden_ocupacional WHERE n_orden = norden_param;

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

        IF ((SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) and empresa_var='OBRASCÓN HUARTE LAIN S.A')THEN 
		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
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
            SELECT user_registro INTO user_registro_var 
            FROM consent_laboratorios WHERE n_orden = norden_param AND name_conset = name_servicio_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM consent_Boro WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;        
    END IF;     


    IF name_servicio_param = 'analisis_bioquimicos' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM analisis_bioquimicos WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM lab_clinico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM hemograma_autom WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  

    END IF; 


    IF name_servicio_param = 'lgonadotropina' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM lgonadotropina WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 


    IF name_servicio_param = 'panel2d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM panel2d WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 
    

    IF name_servicio_param = 'panel3d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM panel2d WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 

     IF name_servicio_param = 'toxicologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM toxicologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 


     IF name_servicio_param = 'panel10d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM panel10d WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
              
    END IF; 



     IF name_servicio_param = 'inmunologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM inmunologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
              
    END IF;


     IF name_servicio_param = 'microbiologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM microbiologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
         
    END IF;       



     IF name_servicio_param = 'lhepatitis' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM lhepatitis WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
         
    END IF;   


-- perfil renal
     IF name_servicio_param = 'l_bioquimica' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM l_bioquimica WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
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
            SELECT user_registro INTO user_registro_var 
            FROM ac_bioquimica2022 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
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
            SELECT user_registro INTO user_registro_var 
            FROM perfil_hepatico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
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
            SELECT user_registro INTO user_registro_var 
            FROM ac_coprocultivo WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  
        
              
    END IF; 
    
-- coproparasitologico

    IF name_servicio_param = 'ac_coproparasitologico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM ac_coproparasitologico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM examen_inmunologico WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM audiometria_2023 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;  

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
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
            SELECT user_registro INTO user_registro_var 
            FROM historia_oc_info WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM ficha_audiologica WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
            dni_user_registro_var :=55555555;
            ELSE
            dni_user_registro_var:=1;
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
            SELECT user_registro INTO user_registro_var 
            FROM cuestionario_audiometria WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'oftalmologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM oftalmologia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'oftalmologia_lo' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM oftalmologia_lo WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
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
            SELECT user_registro INTO user_registro_var 
            FROM oftalmologia2021 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 

        IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 

		IF(empresa_var='OBRASCÓN HUARTE LAIN S.A') THEN
		dni_user_registro_var :=42664426;
		ELSE
		dni_user_registro_var:=1;
		end if;
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
            SELECT user_registro INTO user_registro_var 
            FROM odontograma WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT o.user_registro INTO user_registro_var 
            FROM odontograma_lo olo 
            INNER JOIN odontograma o on olo.n_orden = o.n_orden
            WHERE olo.n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'radiografia_torax' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM radiografia_torax WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'radiografia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM radiografia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF; 
    END IF;

    IF name_servicio_param = 'oit' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM oit WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM evaluacion_musculo_esqueletica WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

                 
END;
$BODY$
  LANGUAGE plpgsql;

drop FUNCTION obtener_reporte_odontograma(IN p_norden integer)

CREATE OR REPLACE FUNCTION obtener_reporte_odontograma(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, sexo "char", cod_od integer, fecha_od date, edad_od text, lbl_18 text, lbl_17 text, lbl_16 text, lbl_15 text, lbl_14 text, lbl_13 text, lbl_12 text, lbl_11 text, lbl_21 text, lbl_22 text, lbl_23 text, lbl_24 text, lbl_25 text, lbl_26 text, lbl_27 text, lbl_28 text, lbl_31 text, lbl_32 text, lbl_33 text, lbl_34 text, lbl_35 text, lbl_36 text, lbl_37 text, lbl_38 text, lbl_41 text, lbl_42 text, lbl_43 text, lbl_44 text, lbl_45 text, lbl_46 text, lbl_47 text, lbl_48 text, txtpiezasmalestado integer, txtausentes integer, txtcariadasoturar integer, txtporextraer integer, txtfracturada integer, txtobturacionesefectuadas integer, txtpuentes integer, txtpprmetalicas integer, txtppracrilicas integer, txtptotal integer, txtnormales integer, txtcoronas integer, txtobservaciones text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, nom_sede text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    o.n_orden,
    noo.cod_pa,
    --dp.fecha_nacimiento_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    --noo.nom_examen,
    --dp.lugar_nac_pa,
    --dp.cel_pa,
    dp.sexo_pa,
    --dp.direccion_pa ||'-'|| dp.distrito_pa ||'-'|| dp.provincia_pa ||'-'|| dp.departamento_pa,
    --u.nombre_user||' '||u.apellido_user,
    o.cod_od,
    o.fecha_od,
    o.edad_od,
    o.lbl_18,
    o.lbl_17,
    o.lbl_16,
    o.lbl_15,
    o.lbl_14,
    o.lbl_13,
    o.lbl_12,
    o.lbl_11,
    o.lbl_21,
    o.lbl_22,
    o.lbl_23,
    o.lbl_24,
    o.lbl_25,
    o.lbl_26,
    o.lbl_27,
    o.lbl_28,
    o.lbl_31,
    o.lbl_32,
    o.lbl_33,
    o.lbl_34,
    o.lbl_35,
    o.lbl_36,
    o.lbl_37,
    o.lbl_38,
    o.lbl_41,
    o.lbl_42,
    o.lbl_43,
    o.lbl_44,
    o.lbl_45,
    o.lbl_46,
    o.lbl_47,
    o.lbl_48,
    o.txtpiezasmalestado,
    o.txtausentes,
    o.txtcariadasoturar,
    o.txtporextraer,
    o.txtfracturada,
    o.txtobturacionesefectuadas,
    o.txtpuentes,
    o.txtpprmetalicas,
    o.txtppracrilicas,
    o.txtptotal,
    o.txtnormales,
    o.txtcoronas,
    o.txtobservaciones,

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
    CASE
        WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
        WHEN noo.cod_sede = 1 THEN 'Trujillo'
        WHEN noo.cod_sede = 2 THEN 'Huamachuco'
        WHEN noo.cod_sede = 3 THEN 'Huancayo'
        WHEN noo.cod_sede = 4 THEN 'Trujillo'
    END AS nom_sede
    

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN odontograma o ON o.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

drop FUNCTION obtener_reporte_odontogramalo(IN p_norden integer)

CREATE OR REPLACE FUNCTION obtener_reporte_odontogramalo(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, sexo "char", fecha_od date, edad_od text, lbl_18 text, lbl_17 text, lbl_16 text, lbl_15 text, lbl_14 text, lbl_13 text, lbl_12 text, lbl_11 text, lbl_21 text, lbl_22 text, lbl_23 text, lbl_24 text, lbl_25 text, lbl_26 text, lbl_27 text, lbl_28 text, lbl_31 text, lbl_32 text, lbl_33 text, lbl_34 text, lbl_35 text, lbl_36 text, lbl_37 text, lbl_38 text, lbl_41 text, lbl_42 text, lbl_43 text, lbl_44 text, lbl_45 text, lbl_46 text, lbl_47 text, lbl_48 text, txtpiezasmalestado integer, txtausentes integer, txtcariadasoturar integer, txtporextraer integer, txtfracturada integer, txtobturacionesefectuadas integer, txtpuentes integer, txtpprmetalicas integer, txtppracrilicas integer, txtptotal integer, txtnormales integer, txtcoronas integer, txtobservaciones text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, nom_sede text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    o.n_orden,
    noo.cod_pa,
    --dp.fecha_nacimiento_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    --noo.nom_examen,
    --dp.lugar_nac_pa,
    --dp.cel_pa,
    dp.sexo_pa,
    --dp.direccion_pa ||'-'|| dp.distrito_pa ||'-'|| dp.provincia_pa ||'-'|| dp.departamento_pa,
    --u.nombre_user||' '||u.apellido_user,
    o.fecha_od,
    o.edad_od,
    o.lbl_18,
    o.lbl_17,
    o.lbl_16,
    o.lbl_15,
    o.lbl_14,
    o.lbl_13,
    o.lbl_12,
    o.lbl_11,
    o.lbl_21,
    o.lbl_22,
    o.lbl_23,
    o.lbl_24,
    o.lbl_25,
    o.lbl_26,
    o.lbl_27,
    o.lbl_28,
    o.lbl_31,
    o.lbl_32,
    o.lbl_33,
    o.lbl_34,
    o.lbl_35,
    o.lbl_36,
    o.lbl_37,
    o.lbl_38,
    o.lbl_41,
    o.lbl_42,
    o.lbl_43,
    o.lbl_44,
    o.lbl_45,
    o.lbl_46,
    o.lbl_47,
    o.lbl_48,
    o.txtpiezasmalestado,
    o.txtausentes,
    o.txtcariadasoturar,
    o.txtporextraer,
    o.txtfracturada,
    o.txtobturacionesefectuadas,
    o.txtpuentes,
    o.txtpprmetalicas,
    o.txtppracrilicas,
    o.txtptotal,
    o.txtnormales,
    o.txtcoronas,
    o.txtobservaciones,


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
    CASE
        WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
        WHEN noo.cod_sede = 1 THEN 'Trujillo'
        WHEN noo.cod_sede = 2 THEN 'Huamachuco'
        WHEN noo.cod_sede = 3 THEN 'Huancayo'
        WHEN noo.cod_sede = 4 THEN 'Trujillo'
    END AS nom_sede

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN odontograma_lo o ON o.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;