CREATE OR REPLACE FUNCTION buscar_radiografia_torax_pornombreonorden(
    IN n_orden_param integer,
    IN nombres_param text)
  RETURNS TABLE(codigo_radiografia integer, n_orden integer, nombres text, fecha_examen date) AS
$BODY$
BEGIN

 RETURN QUERY 
 SELECT 
  rt.cod_rat,
  rt.n_orden,
  dp.nombres_pa || ' ' || dp.apellidos_pa AS nombres,
  rt.fecha_examen
FROM datos_paciente dp
INNER JOIN n_orden_ocupacional noo ON dp.cod_pa = noo.cod_pa
INNER JOIN radiografia_torax rt ON noo.n_orden = rt.n_orden
WHERE 
  (n_orden_param IS NULL OR rt.n_orden = n_orden_param)
  AND (nombres_param IS NULL OR CONCAT(dp.nombres_pa, ' ', dp.apellidos_pa) ILIKE '%' || nombres_param || '%')
ORDER BY rt.fecha_examen DESC
LIMIT 100;

END; $BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_reporte_cuestionario_nordico(IN p_norden integer)
  RETURNS TABLE(
	nombres text,
	dni integer,
	sexo "char",
	edad text,

	codigo_cuestionario integer,
	norden integer,
	horas_trabajadas text,
	meses text,
	anios text,
	es_diestro boolean,
	es_zurdo boolean,
	cuello_no boolean,
	cuello_si boolean,
	pregunta1_cuello_no boolean,
	pregunta1_cuello_si boolean,
	pregunta2_cuello_no boolean,
	pregunta2_cuello_si boolean,
	hombros_no boolean,
	hombro_derecho_si boolean,
	hombro_izquierdo_si boolean,
	ambos_hombros_si boolean,
	pregunta1_hombros_no boolean,
	pregunta1_hombros_si boolean,
	pregunta2_hombros_no boolean,
	pregunta2_hombros_si boolean,
	codos_no boolean,
	codo_derecho_si boolean,
	codo_izquierdo_no boolean,
	ambos_codos_si boolean,
	pregunta1_codos_no boolean,
	pregunta1_codos_si boolean,
	pregunta2_codos_no boolean,
	pregunta2_codos_si boolean,
	muneca_no boolean,
	muneca_derecha_si boolean,
	muneca_izquierda_si boolean,
	ambas_munecas_si boolean,
	pregunta1_munecas_no boolean,
	pregunta1_munecas_si boolean,
	pregunta2_munecas_no boolean,
	pregunta2_munecas_si boolean,
	espalda_alta_torax_no boolean,
	espalda_baja_lumbar_no boolean,
	caderas_o_muslos_no boolean,
	rodillas_no boolean,
	tobillos_o_pies_no boolean,
	pregunta1_espalda_alta_torax_no boolean,
	pregunta1_espalda_baja_lumbar_no boolean,
	pregunta1_caderas_o_muslos_no boolean,
	pregunta1_rodillas_no boolean,
	pregunta1_tobillos_o_pies_no boolean,
	pregunta2_espalda_alta_torax_no boolean,
	pregunta2_espalda_baja_lumbar_no boolean,
	pregunta2_caderas_o_muslos_no boolean,
	pregunta2_rodillas_no boolean,
	pregunta2_tobillos_o_pies_no boolean,
	espalda_alta_torax_si boolean,
	espalda_baja_lumbar_si boolean,
	caderas_o_muslos_si boolean,
	rodillas_si boolean,
	tobillos_o_pies_si boolean,
	pregunta1_espalda_alta_torax_si boolean,
	pregunta1_espalda_baja_lumbar_si boolean,
	pregunta1_caderas_o_muslos_si boolean,
	pregunta1_rodillas_si boolean,
	pregunta1_tobillos_o_pies_si boolean,
	pregunta2_espalda_alta_torax_si boolean,
	pregunta2_espalda_baja_lumbar_si boolean,
	pregunta2_caderas_o_muslos_si boolean,
	pregunta2_rodillas_si boolean,
	pregunta2_tobillos_o_pies_si boolean,
	pregunta1_espalda_baja_no boolean,
	pregunta2_espalda_baja_no boolean,
	pregunta3_espalda_baja_no boolean,
	pregunta5a_espalda_baja_no boolean,
	pregunta5b_espalda_baja_no boolean,
	pregunta7_espalda_baja_no boolean,
	pregunta8_espalda_baja_no boolean,
	pregunta1_espalda_baja_si boolean,
	pregunta2_espalda_baja_si boolean,
	pregunta3_espalda_baja_si boolean,
	pregunta5a_espalda_baja_si boolean,
	pregunta5b_espalda_baja_si boolean,
	pregunta7_espalda_baja_si boolean,
	pregunta8_espalda_baja_si boolean,
	pregunta4a_espalda_baja boolean,
	pregunta4b_espalda_baja boolean,
	pregunta4c_espalda_baja boolean,
	pregunta4d_espalda_baja boolean,
	pregunta4e_espalda_baja boolean,
	pregunta6a_espalda_baja boolean,
	pregunta6b_espalda_baja boolean,
	pregunta6c_espalda_baja boolean,
	pregunta6d_espalda_baja boolean,
	pregunta1_problemas_hombros_no boolean,

	pregunta3_problemas_hombros_no boolean,
	pregunta6a_problemas_hombros_no boolean,
	pregunta6b_problemas_hombros_no boolean,
	pregunta8_problemas_hombros_no boolean,
	pregunta1_problemas_hombros_si boolean,
	pregunta3_problemas_hombros_si boolean,
	pregunta6a_problemas_hombros_si boolean,
	pregunta6b_problemas_hombros_si boolean,
	pregunta8_problemas_hombros_si boolean,
	pregunta2_problemas_hombros_no boolean,
	pregunta2_problemas_hombro_derecho_si boolean,
	pregunta2_problemas_hombro_izquierdo_si boolean,
	pregunta2_problemas_ambos_hombros boolean,
	pregunta4_problemas_hombros_no boolean,
	pregunta4_problemas_hombro_derecho_si boolean,
	pregunta4_problemas_hombro_izquierdo_si boolean,
	pregunta4_problemas_ambos_hombros boolean,
	pregunta5a_problemas_hombros boolean,
	pregunta5b_problemas_hombros boolean,
	pregunta5c_problemas_hombros boolean,
	pregunta5d_problemas_hombros boolean,
	pregunta7a_problemas_hombros boolean,
	pregunta7b_problemas_hombros boolean,
	pregunta7c_problemas_hombros boolean,
	pregunta7d_problemas_hombros boolean,
	pregunta9_problemas_hombros_no boolean,
	pregunta9_problemas_hombro_derecho_si boolean,
	pregunta9_problemas_hombro_izquierdo_si boolean,
	pregunta9_problemas_ambos_hombros boolean,
	pregunta1_problemas_cuello_no boolean,
	pregunta2_problemas_cuello_no boolean,
	pregunta3_problemas_cuello_no boolean,
	pregunta5a_problemas_cuello_no boolean,
	pregunta5b_problemas_cuello_no boolean,
	pregunta7_problemas_cuello_no boolean,
	pregunta8_problemas_cuello_no boolean,
	pregunta1_problemas_cuello_si boolean,
	pregunta2_problemas_cuello_si boolean,
	pregunta3_problemas_cuello_si boolean,
	pregunta5a_problemas_cuello_si boolean,
	pregunta5b_problemas_cuello_si boolean,
	pregunta7_problemas_cuello_si boolean,
	pregunta8_problemas_cuello_si boolean,
	pregunta4a_problemas_cuello boolean,
	pregunta4b_problemas_cuello boolean,
	pregunta4c_problemas_cuello boolean,
	pregunta4d_problemas_cuello boolean,
	pregunta4e_problemas_cuello boolean,
	pregunta6a_problemas_cuello boolean,
	pregunta6b_problemas_cuello boolean,
	pregunta6c_problemas_cuello boolean,
	pregunta6d_problemas_cuello boolean,
	fecha_cuestionario date,

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
	tel_sede1 text
  ) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
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
  INNER JOIN cuestionario_nordico cn ON cn.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --LEFT JOIN usuarios u ON u.dni_user = ci.dni_user
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('cuestionario_nordico','formulario de cuestionario nordico',true,true,true,false,false);

DROP FUNCTION buscar_odontograma_pornombreonorden(
    IN n_orden_param integer,
    IN nombres_param text)


CREATE OR REPLACE FUNCTION buscar_odontograma_pornombreonorden(
    IN n_orden_param integer,
    IN nombres_param text)
  RETURNS TABLE(cod_od integer, nombres text, n_orden integer, fecha_od date, empresa text, tipo_examen text, color text) AS
$BODY$
BEGIN

 RETURN QUERY 
 SELECT
    o.cod_od,
    dp.nombres_pa || ' ' || dp.apellidos_pa AS nombres,
    CASE WHEN o.cod_od IS NULL THEN noo.n_orden ELSE o.n_orden END AS n_orden,
    noo.fecha_apertura_po,
    noo.razon_empresa,
    noo.nom_examen,
    CASE WHEN o.cod_od IS NULL THEN '#ff6767' ELSE '#00ff00' END AS cod_color
FROM
    n_orden_ocupacional noo
INNER JOIN 
    datos_paciente dp
    ON dp.cod_pa = noo.cod_pa
LEFT JOIN 
    odontograma o
    ON noo.n_orden = o.n_orden
WHERE 
    (n_orden_param IS NULL OR o.n_orden = n_orden_param)
    AND (nombres_param IS NULL OR CONCAT(dp.nombres_pa,' ',dp.apellidos_pa) ILIKE '%' || nombres_param || '%')
ORDER BY 
    noo.fecha_apertura_po DESC
LIMIT 100;

END; $BODY$
  LANGUAGE plpgsql;

drop FUNCTION obtener_reporte_evaluacion_musculo_esqueletica(IN p_norden integer);

CREATE OR REPLACE FUNCTION obtener_reporte_evaluacion_musculo_esqueletica(IN p_norden integer)
  RETURNS TABLE(nombres text, sexo "char", dni integer, edad text, empresa text, contrata text, area_trabajo text, cod_eval integer, n_orden integer, t_servicio text, f_examen date, rbsintoma_si boolean, rbsintoma_no boolean, txtsintomas text, rbfaja_si boolean, rbfaja_no boolean, rbtecnicacarga_si boolean, rbtecnicacarga_no boolean, rbcapacitacioncarga_si boolean, rbcapacitacioncarga_no boolean, txtextencion_cabeza text, txtflexion_cabeza text, rbextension_cabeza_n boolean, rbextension_cabeza_r boolean, rbextension_cabeza_m boolean, rbflexion_cabeza_n boolean, rbflexion_cabeza_r boolean, rbflexion_cabeza_m boolean, rbflexion_hombro_n boolean, rbflexion_hombro_r boolean, rbflexion_hombro_m boolean, rbflexion_hombro_n1 boolean, rbflexion_hombro_r1 boolean, rbflexion_hombro_m1 boolean, rbextension_hombro_n boolean, rbextension_hombro_r boolean, rbextension_hombro_m boolean, rbextension_hombro_n1 boolean, rbextension_hombro_r1 boolean, rbextension_hombro_m1 boolean, rbabduccion_hombro_n boolean, rbabduccion_hombro_r boolean, rbabduccion_hombro_m boolean, rbabduccion_hombro_n1 boolean, rbabduccion_hombro_r1 boolean, rbabduccion_hombro_m1 boolean, rbaduccion_hombro_n boolean, rbaduccion_hombro_r boolean, rbaduccion_hombro_m boolean, rbaduccion_hombro_n1 boolean, rbaduccion_hombro_r1 boolean, rbaduccion_hombro_m1 boolean, rbrotacionint_hombro_n boolean, rbrotacionint_hombro_r boolean, rbrotacionint_hombro_m boolean, rbrotacionint_hombro_n1 boolean, rbrotacionint_hombro_r1 boolean, rbrotacionint_hombro_m1 boolean, rbrotacionext_hombro_n boolean, rbrotacionext_hombro_r boolean, rbrotacionext_hombro_m boolean, rbrotacionext_hombro_n1 boolean, rbrotacionext_hombro_r1 boolean, rbrotacionext_hombro_m1 boolean, rbflexion_brazo_n boolean, rbflexion_brazo_r boolean, rbflexion_brazo_m boolean, rbflexion_brazo_n1 boolean, rbflexion_brazo_r1 boolean, rbflexion_brazo_m1 boolean, rbextension_brazo_n boolean, rbextension_brazo_r boolean, rbextension_brazo_m boolean, rbextension_brazo_n1 boolean, rbextension_brazo_r1 boolean, rbextension_brazo_m1 boolean, rbpronacion_antebrazo_n boolean, rbpronacion_antebrazo_r boolean, rbpronacion_antebrazo_m boolean, rbpronacion_antebrazo_n1 boolean, rbpronacion_antebrazo_r1 boolean, rbpronacion_antebrazo_m1 boolean, rbsupinacion_antebrazo_n boolean, rbsupinacion_antebrazo_r boolean, rbsupinacion_antebrazo_m boolean, rbsupinacion_antebrazo_n1 boolean, rbsupinacion_antebrazo_r1 boolean, rbsupinacion_antebrazo_m1 boolean, rbflexion_munieca_n boolean, rbflexion_munieca_r boolean, rbflexion_munieca_m boolean, rbflexion_munieca_n1 boolean, rbflexion_munieca_r1 boolean, rbflexion_munieca_m1 boolean, rbextension_munieca_n boolean, rbextension_munieca_r boolean, rbextension_munieca_m boolean, rbextension_munieca_n1 boolean, rbextension_munieca_r1 boolean, rbextension_munieca_m1 boolean, rbdesvcubital_munieca_n boolean, rbdesvcubital_munieca_r boolean, rbdesvcubital_munieca_m boolean, rbdesvcubital_munieca_n1 boolean, rbdesvcubital_munieca_r1 boolean, rbdesvcubital_munieca_m1 boolean, rbdesvradial_munieca_n boolean, rbdesvradial_munieca_r boolean, rbdesvradial_munieca_m boolean, rbdesvradial_munieca_n1 boolean, rbdesvradial_munieca_r1 boolean, rbdesvradial_munieca_m1 boolean, rbphallen_si boolean, rbphallen_no boolean, rbtinel_si boolean, rbtinel_no boolean, rbflexion_torax_n boolean, rbflexion_torax_r boolean, rbflexion_torax_m boolean, rbflexion_torax_n1 boolean, rbflexion_torax_r1 boolean, rbflexion_torax_m1 boolean, rbextension_torax_n boolean, rbextension_torax_r boolean, rbextension_torax_m boolean, rbextension_torax_n1 boolean, rbextension_torax_r1 boolean, rbextension_torax_m1 boolean, rbrotacion_torax_n boolean, rbrotacion_torax_r boolean, rbrotacion_torax_m boolean, rbrotacion_torax_n1 boolean, rbrotacion_torax_r1 boolean, rbrotacion_torax_m1 boolean, rbflexion_cadera_n boolean, rbflexion_cadera_r boolean, rbflexion_cadera_m boolean, rbflexion_cadera_n1 boolean, rbflexion_cadera_r1 boolean, rbflexion_cadera_m1 boolean, rbextension_cadera_n boolean, rbextension_cadera_r boolean, rbextension_cadera_m boolean, rbextension_cadera_n1 boolean, rbextension_cadera_r1 boolean, rbextension_cadera_m1 boolean, rbabduccion_cadera_n boolean, rbabduccion_cadera_r boolean, rbabduccion_cadera_m boolean, rbabduccion_cadera_n1 boolean, rbabduccion_cadera_r1 boolean, rbabduccion_cadera_m1 boolean, rbaduccion_cadera_n boolean, rbaduccion_cadera_r boolean, rbaduccion_cadera_m boolean, rbaduccion_cadera_n1 boolean, rbaduccion_cadera_r1 boolean, rbaduccion_cadera_m1 boolean, rbrotacionint_cadera_n boolean, rbrotacionint_cadera_r boolean, rbrotacionint_cadera_m boolean, rbrotacionint_cadera_n1 boolean, rbrotacionint_cadera_r1 boolean, rbrotacionint_cadera_m1 boolean, rbrotacionext_cadera_n boolean, rbrotacionext_cadera_r boolean, rbrotacionext_cadera_m boolean, rbrotacionext_cadera_n1 boolean, rbrotacionext_cadera_r1 boolean, rbrotacionext_cadera_m1 boolean, rbflexion_pierna_n boolean, rbflexion_pierna_r boolean, rbflexion_pierna_m boolean, rbflexion_pierna_n1 boolean, rbflexion_pierna_r1 boolean, rbflexion_pierna_m1 boolean, rbextension_pierna_n boolean, rbextension_pierna_r boolean, rbextension_pierna_m boolean, rbextension_pierna_n1 boolean, rbextension_pierna_r1 boolean, rbextension_pierna_m1 boolean, rbflexion_rodilla_n boolean, rbflexion_rodilla_r boolean, rbflexion_rodilla_m boolean, rbflexion_rodilla_n1 boolean, rbflexion_rodilla_r1 boolean, rbflexion_rodilla_m1 boolean, rbextension_rodilla_n boolean, rbextension_rodilla_r boolean, rbextension_rodilla_m boolean, rbextension_rodilla_n1 boolean, rbextension_rodilla_r1 boolean, rbextension_rodilla_m1 boolean, rbrotacionint_rodilla_n boolean, rbrotacionint_rodilla_r boolean, rbrotacionint_rodilla_m boolean, rbrotacionint_rodilla_n1 boolean, rbrotacionint_rodilla_r1 boolean, rbrotacionint_rodilla_m1 boolean, rbrotacionext_rodilla_n boolean, rbrotacionext_rodilla_r boolean, rbrotacionext_rodilla_m boolean, rbrotacionext_rodilla_n1 boolean, rbrotacionext_rodilla_r1 boolean, rbrotacionext_rodilla_m1 boolean, rbflexion_tobillo_n boolean, rbflexion_tobillo_r boolean, rbflexion_tobillo_m boolean, rbflexion_tobillo_n1 boolean, rbflexion_tobillo_r1 boolean, rbflexion_tobillo_m1 boolean, rbextension_tobillo_n boolean, rbextension_tobillo_r boolean, rbextension_tobillo_m boolean, rbextension_tobillo_n1 boolean, rbextension_tobillo_r1 boolean, rbextension_tobillo_m1 boolean, rbfuerzamuscular_1 boolean, rbfuerzamuscular_2 boolean, rbfuerzamuscular_3 boolean, rbfuerzamuscular_4 boolean, rbfuerzamuscular_5 boolean, rbejecervical_normal boolean, rbejecervical_derecha boolean, rbejecervical_izq boolean, rbejedorsal_normal boolean, rbejedorsal_derecha boolean, rbejedorsal_izq boolean, rbejelumbar_normal boolean, rbejelumbar_derecha boolean, rbejelumbar_izq boolean, rbcifosis_si boolean, rbcifosis_no boolean, rbescoliosis_si boolean, rbescoliosis_no boolean, rblordosis_si boolean, rblordosis_no boolean, rbmixta_si boolean, rbmixta_no boolean, rbcervical_si boolean, rbcervical_no boolean, rbdorsal_si boolean, rbdorsal_no boolean, rblumbar_si boolean, rblumbra_no boolean, rblesagueder_si boolean, rblesagueder_no boolean, rblesagueizq_si boolean, rblesagueizq_no boolean, chktratamiento_si boolean, chktratamiento_no boolean, dni_user integer, txtdiagnostico text, chkconclusion_si boolean, chkconclusion_no boolean, txtrecomendaciones text, color integer, sede_descripcion text, nom_medico text) AS
$BODY$
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
    u.nombre_user||' '||u.apellido_user AS nom_medico

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN evaluacion_musculo_esqueletica eme ON eme.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  INNER JOIN usuarios u ON (u.dni_user = eme.dni_user)
  WHERE noo.n_orden = $1;
  $BODY$
  LANGUAGE sql STABLE;

CREATE OR REPLACE FUNCTION obtener_reporte_evaluacion_musculo_esqueletica2021(IN p_norden integer)
  RETURNS TABLE(nombres text, dni integer, sexo "char", edad text, empresa text, contrata text, cargo text, area text, doctor text, n_orden integer, cod_evaluacion integer, tiempo_servicio text, fecha_examen date, aptitud_espalda_abdomen text, aptitud_espalda_cadera text, aptitud_espalda_muslo text, aptitud_espalda_abdomen_l text, total_puntos_aptitud_espalda text, observacion_aptitud_espalda text, rangos_articulares_abduccion_180 text, rangos_articulares_abduccion_60 text, rangos_articulares_rotacion_90 text, rangos_articulares_rotacion_interna text, total_puntos_rangos_articulares text, rangos_articulares_abduccion_180_si boolean, rangos_articulares_abduccion_180_no boolean, rangos_articulares_abduccion_60_si boolean, rangos_articulares_abduccion_60_no boolean, rangos_articulares_rotacion_90_si boolean, rangos_articulares_rotacion_90_no boolean, rangos_articulares_rotacion_interna_si boolean, rangos_articulares_rotacion_interna_no boolean, observacion_rangos_articulares text, columna_vertebral_desviacion_si boolean, columna_vertebral_desviacion_no boolean, columna_vertebral_desviacion_descripcion text, columna_vertebral_adams_positivo boolean, columna_vertebral_adams_negativo boolean, columna_vertebral_adams_descripcion text, columna_vertebral_dandy_positivo boolean, columna_vertebral_dandy_negativo boolean, columna_vertebral_dandy_descripcion text, columna_vertebral_lasegue_positivo boolean, columna_vertebral_lasegue_negativo boolean, columna_vertebral_lasegue_descripcion text, columna_vertebral_contractura_si boolean, columna_vertebral_contractura_no boolean, columna_vertebral_contractura_descripcion text, columna_vertebral_cicatriz_si boolean, columna_vertebral_cicatriz_no boolean, columna_vertebral_cicatriz_descripcion text, test_jobe_derecha_si boolean, test_jobe_derecha_no boolean, test_jobe_izquierda_si boolean, test_jobe_izquierda_no boolean, test_pate_derecha_si boolean, test_pate_derecha_no boolean, test_pate_izquierda_si boolean, test_pate_izquierda_no boolean, test_gerber_derecha_si boolean, test_gerber_derecha_no boolean, test_gerber_izquierda_si boolean, test_gerber_izquierda_no boolean, test_pulm_derecha_si boolean, test_pulm_derecha_no boolean, test_pulm_izquierda_si boolean, test_pulm_izquierda_no boolean, epicondilitis_derecha_si boolean, epicondilitis_derecha_no boolean, epicondilitis_izquierda_si boolean, epicondilitis_izquierda_no boolean, epitrocleitis_derecha_si boolean, epitrocleitis_derecha_no boolean, epitrocleitis_izquierda_si boolean, epitrocleitis_izquierda_no boolean, phalen_derecha_si boolean, phalen_derecha_no boolean, phalen_izquierda_si boolean, phalen_izquierda_no boolean, phalen_invertido_derecha_si boolean, phalen_invertido_derecha_no boolean, phalen_invertido_izquierda_si boolean, phalen_invertido_izquierda_no boolean, tinnel_derecha_si boolean, tinnel_derecha_no boolean, tinnel_izquierda_si boolean, tinnel_izquierda_no boolean, finkels_tein_derecha_si boolean, finkels_tein_derecha_no boolean, finkels_tein_izquierda_si boolean, finkels_tein_izquierda_no boolean, cadera_derecha_abduccion text, cadera_derecha_aduccion text, cadera_derecha_flexion text, cadera_derecha_extension text, cadera_derecha_rot_externa text, cadera_derecha_rot_interna text, cadera_derecha_irradiacion text, cadera_derecha_masa_muscular text, cadera_izquierda_abduccion text, cadera_izquierda_aduccion text, cadera_izquierda_flexion text, cadera_izquierda_extension text, cadera_izquierda_rot_externa text, cadera_izquierda_rot_interna text, cadera_izquierda_irradiacion text, cadera_izquierda_masa_muscular text, rodilla_derecha_flexion text, rodilla_derecha_extension text, rodilla_derecha_rot_externa text, rodilla_derecha_rot_interna text, rodilla_derecha_irradiacion text, rodilla_derecha_masa_muscular text, rodilla_izquierda_flexion text, rodilla_izquierda_extension text, rodilla_izquierda_rot_externa text, rodilla_izquierda_rot_interna text, rodilla_izquierda_irradiacion text, rodilla_izquierda_masa_muscular text, tobillo_derecho_abduccion text, tobillo_derecho_aduccion text, tobillo_derecho_flexion text, tobillo_derecho_extension text, tobillo_derecho_rot_externa text, tobillo_derecho_rot_interna text, tobillo_derecho_irradiacion text, tobillo_derecho_masa_muscular text, tobillo_izquierdo_abduccion text, tobillo_izquierdo_aduccion text, tobillo_izquierdo_flexion text, tobillo_izquierdo_extension text, tobillo_izquierdo_rot_externa text, tobillo_izquierdo_rot_interna text, tobillo_izquierdo_irradiacion text, tobillo_izquierdo_masa_muscular text, conclusiones text, cie10 text, recomendaciones text, medico text, dni_user integer, user_registro text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    noo.cod_pa,
    dp.sexo_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
    noo.razon_empresa,
    noo.razon_contrata,
    noo.cargo_de,
    noo.area_o,
    u.nombre_user||' '||u.apellido_user,
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
  INNER JOIN evaluacion_musculo_esqueletica2021 ci ON ci.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  LEFT JOIN usuarios u ON u.dni_user = ci.dni_user
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('evaluacion_musculo_esqueletica2021','formulario de evaluacion musculo esqueletica 2021',true,true,true,false,false);


DROP FUNCTION obtener_reporte_informeradiografico(integer);

CREATE OR REPLACE FUNCTION obtener_reporte_informeradiografico(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, sexo "char", fecha_nac date, nivel_est_pa text, tipo_radio text, info_general text, conclu text, fecha_ex date, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, cargo text) AS
$BODY$
BEGIN

  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
    r.n_orden,
    noo.cod_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    dp.sexo_pa,
    dp.fecha_nacimiento_pa,
    dp.nivel_est_pa,

    r.tipo_radio,
    r.info_general,
    r.conclu,
    r.fecha_ex,

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
    noo.cargo_de

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN radiografia r ON r.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;


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
	IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
		resultado := 'OIT_Digitalizado_boro';
	ELSE
		resultado := 'OIT_Digitalizado';
	END IF;
    ELSIF name_service_param = 'evaluacion_musculo_esqueletica' THEN
        resultado := 'EvaluacionMuscoloEsqueletica';
    ELSIF name_service_param = 'evaluacion_musculo_esqueletica2021' THEN
        resultado := 'EvaluacionMuscoloEsqueletica2021_Digitalizado_boro';
    ELSIF name_service_param = 'consentimientoInformado' THEN
	resultado := 'conInformadoOcupacional_Digitalizado';
    ELSIF name_service_param = 'cuestionario_nordico' THEN
	resultado := 'CuestionarioNordico';
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
            SELECT user_registro INTO user_registro_var 
            FROM oftalmologia_lo WHERE n_orden = norden_param;
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
            SELECT user_registro INTO user_registro_var 
            FROM evaluacion_musculo_esqueletica2021 WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
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
            SELECT user_registro INTO user_registro_var 
            FROM cuestionario_nordico WHERE n_orden = norden_param;
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


CREATE OR REPLACE FUNCTION sp_validar_existencia_servicios(
    IN p_historia_clinica bigint,
    IN p_examen_med text)
  RETURNS TABLE(id_resp integer, mensaje text) AS
$BODY$
declare v_mensaje text;
declare v_id_existencia integer;
declare v_triaje_existencia_espirometria integer;

begin
		

	if(p_examen_med='triaje') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from triaje where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;


 	if(p_examen_med='con_panel10D') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consent_laboratorios where n_orden=p_historia_clinica and name_conset=p_examen_med limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;       

        
 	if(p_examen_med='con_panel5D') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consent_laboratorios where n_orden=p_historia_clinica and name_conset=p_examen_med limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if; 


  	if(p_examen_med='con_panel3D') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consent_laboratorios where n_orden=p_historia_clinica and name_conset=p_examen_med limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if; 


        if(p_examen_med='con_panel2D') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consent_laboratorios where n_orden=p_historia_clinica and name_conset=p_examen_med limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if; 

        if(p_examen_med='consent_Muestra_Sangre') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consent_laboratorios where n_orden=p_historia_clinica and name_conset=p_examen_med limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if; 

        
       if(p_examen_med='consent_marihuana') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consent_laboratorios where n_orden=p_historia_clinica and name_conset=p_examen_med limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;     

        if(p_examen_med='consent_Boro') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consent_Boro where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   


        if(p_examen_med='panel10d') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from panel10d where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;


        if(p_examen_med='toxicologia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from toxicologia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;


        if(p_examen_med='panel3d') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from panel3d where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;       


         if(p_examen_med='panel2d') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from panel2d where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;      


        if(p_examen_med='analisis_bioquimicos') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from analisis_bioquimicos where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;      


        if(p_examen_med='lab_clinico') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from lab_clinico where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;     


        if(p_examen_med='examen_inmunologico') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from examen_inmunologico where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   


        if(p_examen_med='microbiologia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from microbiologia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;  


        if(p_examen_med='inmunologia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from inmunologia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;           



         if(p_examen_med='parasitologia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from parasitologia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;       


         if(p_examen_med='ac_bioquimica2022') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from ac_bioquimica2022 where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;


          if(p_examen_med='ac_coprocultivo') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from ac_coprocultivo where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;       


          if(p_examen_med='ac_coproparasitologico') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from ac_coproparasitologico where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;            


        if(p_examen_med='perfil_hepatico') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from perfil_hepatico where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;


        if(p_examen_med='l_bioquimica') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from l_bioquimica where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;    


        if(p_examen_med='lhepatitis') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from lhepatitis where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   


        if(p_examen_med='hemograma_autom') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from hemograma_autom where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   


        if(p_examen_med='ltest_altura') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from ltest_altura where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   



        if(p_examen_med='lanexo16a') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from lanexo16a where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   



        if(p_examen_med='lpsiconsensometria') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from lpsiconsensometria where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   


        if(p_examen_med='lgonadotropina') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from lgonadotropina where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;     

        if(p_examen_med='consen_digit') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consen_digit where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;    

        if(p_examen_med='audiometria_2023') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from audiometria_2023 where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;  

        if(p_examen_med='historia_oc_info') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from historia_oc_info where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;     

        if(p_examen_med='audiometria_po') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from audiometria_po where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if; 

        if(p_examen_med='ficha_audiologica') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from ficha_audiologica where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;   

        if(p_examen_med='cuestionario_audiometria') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from cuestionario_audiometria where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;  

        if(p_examen_med='funcion_abs') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from funcion_abs where n_orden=p_historia_clinica limit 1;
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_triaje_existencia_espirometria from triaje where n_orden=p_historia_clinica limit 1; 
		if(v_triaje_existencia_espirometria=1) THEN
			if(v_id_existencia=0) THEN
				v_mensaje:='SIN REGISTROS EN EL SISTEMA';
			else
				v_mensaje:='YA FUE REGISTRADO';
					
			end if;
		else 
			v_mensaje:='DEBE PASAR POR TRIAJE PRIMERO (OBLIGATORIO)';
			v_id_existencia:=2;
		end if;
		
        end if;  

        if(p_examen_med='oftalmologia_lo') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from oftalmologia_lo where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='oftalmologia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from oftalmologia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='oftalmologia2021') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from oftalmologia2021 where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='odontograma') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from odontograma where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='odontograma_lo') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from odontograma_lo where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='radiografia_torax') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from radiografia_torax where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='radiografia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from radiografia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='oit') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from oit where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='consentimientoInformado') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consentimientoInformado where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='radiografia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from radiografia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='radiografia_torax') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from radiografia_torax where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='evaluacion_musculo_esqueletica') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from evaluacion_musculo_esqueletica where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='evaluacion_musculo_esqueletica2021') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from evaluacion_musculo_esqueletica2021 where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='cuestionario_nordico') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from cuestionario_nordico where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;
                                                                                              		                   	
	RETURN query

 SELECT v_id_existencia AS id_resp,v_mensaje as mensaje;
end;
$BODY$
  LANGUAGE plpgsql;

  drop FUNCTION sp_mostrar_info_paciente_filtros(
    IN norden_p integer,
    IN sucursal_p text)
    
CREATE OR REPLACE FUNCTION sp_mostrar_info_paciente_filtros(
    IN norden_p integer,
    IN sucursal_p text)
  RETURNS TABLE(n_orden integer, nombres_apellidos text, dni integer, fecha_examen date, nombres text, apellidos text, fecha_nac date, edad integer, empresa text, contrata text, nom_examen text, talla text, peso text, sexo_pa "char", area text, cargo text) AS
$BODY$
DECLARE
    codigo_sede_param INTEGER;
BEGIN
    SELECT id INTO codigo_sede_param FROM sede_multisucursal WHERE codigo_sucursal = sucursal_p;

    RETURN QUERY
SELECT n.n_orden,TRIM(dp.nombres_pa) || ' ' || TRIM(dp.apellidos_pa) as nombres_apellidos, dp.cod_pa as dni, n.fecha_apertura_po as fecha_examen,
	dp.nombres_pa as nombres, dp.apellidos_pa as apellidos, dp.fecha_nacimiento_pa as fecha_nac, obtener_edad(dp.fecha_nacimiento_pa,CURRENT_DATE) as edad, 
	n.razon_empresa as empresa, n.razon_contrata as contrata, n.nom_examen as nom_examn,trj.talla,trj.peso, dp.sexo_pa, n.area_o, n.cargo_de FROM datos_paciente as dp inner join 
	n_orden_ocupacional as n on n.cod_pa=dp.cod_pa left join triaje as trj on  n.n_orden=trj.n_orden where n.n_orden=norden_p and n.cod_sede=codigo_sede_param;
END;
$BODY$
  LANGUAGE plpgsql;