--------------------------------------------------------------------------------
--n_orden_ocupacional
DROP FUNCTION backend_registro_historiaclinica_ocupacional(bigint, bigint, bigint, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, boolean, boolean, boolean, character varying, character varying, character varying, boolean, boolean, boolean, boolean, boolean, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, boolean, boolean, boolean, boolean, boolean, boolean);

CREATE OR REPLACE FUNCTION backend_registro_historiaclinica_ocupacional(
    IN tipo_operacion_exp bigint,
    IN n_orden_exp bigint,
    IN cod_pa_exp bigint,
    IN razon_empresa_exp character varying,
    IN razon_contrata_exp character varying,
    IN nom_ex_exp character varying,
    IN altura_po_exp character varying,
    IN mineral_po_exp character varying,
    IN fecha_apertura_po_exp character varying,
    IN precio_po_exp character varying,
    IN estado_ex_exp character varying,
    IN nom_examen_exp character varying,
    IN cargo_de_exp character varying,
    IN area_o_exp character varying,
    IN n_medico_exp character varying,
    IN n_hora_exp character varying,
    IN tipo_pago_exp character varying,
    IN n_fisttest_exp boolean,
    IN n_psicosen_exp boolean,
    IN n_testaltura_exp boolean,
    IN grupo_san_exp character varying,
    IN grupo_factor_san_exp character varying,
    IN cod_clinica_exp character varying,
    IN visual_compl_exp boolean,
    IN trab_calientes_exp boolean,
    IN chk_covid1_exp boolean,
    IN chk_covid2_exp boolean,
    IN manip_alimentos_exp boolean,
    IN txtobserv1_exp character varying,
    IN txtobserv2_exp character varying,
    IN cod_sede_exp character varying,
    IN tipo_prueba_covid_exp character varying,
    IN tipo_prueba_exp character varying,
    IN nombre_hotel_exp character varying,
    IN protocolo_exp character varying,
    IN precio_adic_exp character varying,
    IN autoriza_exp character varying,
    IN n_operacion_exp character varying,
    IN herra_manuales_exp boolean,
    IN rxc_dorso_lumbar_exp boolean,
    IN rxc_lumbar_exp boolean,
    IN rxc_lumbosacra_exp boolean,
    IN rxc_plomos_exp boolean,
    IN mercurioo_exp boolean,
    IN user_registro_exp text)
  RETURNS TABLE(id_resp bigint, mensaje text) AS
$BODY$
	DECLARE codigo_sede_param integer;
	DECLARE n_orden_hm integer;
	Declare color_varia integer;

BEGIN
			Select id into codigo_sede_param from sede_multisucursal where codigo_sucursal=cod_sede_exp;
			SELECT (CASE WHEN max(color)>0 THEN max(color)+1 ELSE 1 END) into color_varia from n_orden_ocupacional where fecha_apertura_po = TO_DATE(fecha_apertura_po_exp, 'YYYY-MM-DD');
			if(tipo_operacion_exp=2) then
		update n_orden_ocupacional set cod_pa=cod_pa_exp,razon_empresa=razon_empresa_exp,razon_contrata=razon_contrata_exp,nom_ex=nom_ex_exp,
		altura_po=altura_po_exp,mineral_po=mineral_po_exp,fecha_apertura_po=TO_DATE(fecha_apertura_po_exp,'YYYY-MM-DD'),precio_po=CAST(precio_po_exp as money),
		estado_ex=estado_ex_exp,nom_examen=nom_examen_exp,cargo_de=cargo_de_exp,area_o=area_o_exp,n_medico=n_medico_exp,n_hora=CAST (n_hora_exp as time without time zone),
		tipo_pago=tipo_pago_exp,n_fisttest=n_fisttest_exp,n_psicosen=n_psicosen_exp,n_testaltura=n_testaltura_exp,gruposan=grupo_san_exp,grupofactorsan=grupo_factor_san_exp,
		cod_clinica=cod_clinica_exp,visual_compl=visual_compl_exp,trab_calientes=trab_calientes_exp,chkcovid1=chk_covid1_exp,chkcovid2=chk_covid2_exp,manip_alimentos=manip_alimentos_exp,
		txtobserv1=txtobserv1_exp,txtobserv2=txtobserv2_exp,cod_sede=codigo_sede_param,tipo_prueba_covid=tipo_prueba_covid_exp,tipoPrueba=tipo_prueba_exp,nombrehotel=nombre_hotel_exp,
		protocolo=protocolo_exp,precio_adic=CAST(precio_adic_exp AS money),autoriza=autoriza_exp,n_operacion=n_operacion_exp, herra_manuales=herra_manuales_exp, rxc_dorso_lumbar=rxc_dorso_lumbar_exp,
		 rxc_lumbar=rxc_lumbar_exp, rxc_lumbosacra=rxc_lumbosacra_exp, rxc_plomos=rxc_plomos_exp, mercurioo=mercurioo_exp where n_orden=n_orden_exp;
		RETURN QUERY 
		select CAST(1 AS bigint) as id_resp, CAST('El usuario se actualizo con exito!' AS TEXT) as mensaje;

		else
		
		INSERT INTO n_orden_ocupacional(cod_pa, razon_empresa, razon_contrata,
                        nom_ex, altura_po,mineral_po, fecha_apertura_po,precio_po,estado_ex,nom_examen,cargo_de,area_o,n_medico,n_hora,
                        tipo_pago,n_fisttest,n_psicosen,n_testaltura,color,gruposan,grupofactorsan,visual_compl,
                        trab_calientes,chkcovid1,chkcovid2,manip_alimentos, txtobserv1,txtobserv2,cod_sede,tipo_prueba_covid,tipoPrueba,nombrehotel,protocolo,
                        precio_adic,autoriza,n_operacion, herra_manuales, rxc_dorso_lumbar, rxc_lumbar, rxc_lumbosacra, rxc_plomos,mercurioo,user_registro)
		values (cod_pa_exp, razon_empresa_exp, razon_contrata_exp,nom_ex_exp, altura_po_exp, mineral_po_exp, TO_DATE(fecha_apertura_po_exp,'YYYY-MM-DD'), CAST(precio_po_exp as money), estado_ex_exp,
	nom_examen_exp, cargo_de_exp, area_o_exp,n_medico_exp, CAST (n_hora_exp as time without time zone), tipo_pago_exp,n_fisttest_exp, n_psicosen_exp,n_testaltura_exp, color_varia, grupo_san_exp,grupo_factor_san_exp,
	visual_compl_exp, trab_calientes_exp,chk_covid1_exp,chk_covid2_exp,manip_alimentos_exp,txtobserv1_exp,txtobserv2_exp,codigo_sede_param,tipo_prueba_covid_exp ,tipo_prueba_exp,nombre_hotel_exp,
	protocolo_exp,CAST(precio_adic_exp AS money),autoriza_exp,n_operacion_exp,herra_manuales_exp, rxc_dorso_lumbar_exp, rxc_lumbar_exp,rxc_lumbosacra_exp ,rxc_plomos_exp, mercurioo_exp, user_registro_exp  ) RETURNING n_orden into n_orden_hm;
                        PERFORM  spAgregarPE(n_orden_hm);
                        PERFORM  spagregarconta(n_orden_hm);
		RETURN QUERY 
		select CAST(n_orden_hm as bigint) as id_resp, CAST('El usuario se registro con exito!' AS TEXT) as mensaje;
		end if;

END; $BODY$
  LANGUAGE plpgsql;
--------------------------------------------------------------------------------
--AUDIOMETRIA
DROP FUNCTION obtener_reporte_audiometria(integer);

CREATE OR REPLACE FUNCTION obtener_reporte_audiometria(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, cod_au integer, fecha_au date, rbsasordera_si boolean, rbsasordera_no boolean, rbsaacufenos_si boolean, rbsaacufenos_no boolean, rbsavertigo_si boolean, rbsavertigo_no boolean, rbsaotalgia_si boolean, rbsaotalgia_no boolean, rbsasecrecion_si boolean, rbsasecrecion_no boolean, txtsaotrossintomas text, rbamrenitis_si boolean, rbamrenitis_no boolean, rbamsinusitis_si boolean, rbamsinusitis_no boolean, rbamotitis_si boolean, rbamotitis_no boolean, rbamototoxicos_si boolean, rbamototoxicos_no boolean, rbammeningitis_si boolean, rbammeningitis_no boolean, rbamtec_si boolean, rbamtec_no boolean, rbamsordera_si boolean, rbamsordera_no boolean, rbamparotiditis_si boolean, rbamparotiditis_no boolean, rbamsarampion_si boolean, rbamsarampion_no boolean, rbamtbc_si boolean, rbamtbc_no boolean, txtamcuales text, rbeoexposicion_si boolean, rbeoexposicion_no boolean, rbeoprotectores_si boolean, rbeoprotectores_no boolean, rbeosustancias_si boolean, rbeosustancias_no boolean, rbte0a2 boolean, rbte2a4 boolean, rbte4a6 boolean, rbte6a8 boolean, rbte8a10 boolean, rbte10a12 boolean, rbtem12 boolean, rbteeventual boolean, chktapones boolean, chkorejeras boolean, txthplomo text, txthmercurio text, txthtolueno text, txthxileno text, txthplaguic text, txthorganofos text, txttplomo text, txttmercurio text, txtttolueno text, txttxileno text, txttplaguic text, txttorganofos text, txteootros text, rbaepratica_si boolean, rbaepratica_no boolean, rbaeuso_si boolean, rbaeuso_no boolean, rbaeotros_si boolean, rbaeotros_no boolean, txtaecuales text, txtood text, txtooi text, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, txtdiag_od text, txtdiag_oi text, txtcomentarios text, chkrpasimple boolean, chkrpadoble boolean, chkcasemestral boolean, chkcaanual boolean, txtotrasrecomendaciones text, txtanios text, txtmeses text, formato character varying, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    aud.n_orden,
    noo.cod_pa,
    noo.razon_empresa,
    noo.razon_contrata,

    aud.cod_au,
    aud.fecha_au,
    aud.rbsasordera_si,
    aud.rbsasordera_no,
    aud.rbsaacufenos_si,
    aud.rbsaacufenos_no,
    aud.rbsavertigo_si,
    aud.rbsavertigo_no,
    aud.rbsaotalgia_si,
    aud.rbsaotalgia_no,
    aud.rbsasecrecion_si,
    aud.rbsasecrecion_no,
    aud.txtsaotrossintomas,
    aud.rbamrenitis_si,
    aud.rbamrenitis_no,
    aud.rbamsinusitis_si,
    aud.rbamsinusitis_no,
    aud.rbamotitis_si,
    aud.rbamotitis_no,
    aud.rbamototoxicos_si,
    aud.rbamototoxicos_no,
    aud.rbammeningitis_si,
    aud.rbammeningitis_no,
    aud.rbamtec_si,
    aud.rbamtec_no,
    aud.rbamsordera_si,
    aud.rbamsordera_no,
    aud.rbamparotiditis_si,
    aud.rbamparotiditis_no,
    aud.rbamsarampion_si,
    aud.rbamsarampion_no,
    aud.rbamtbc_si,
    aud.rbamtbc_no,
    aud.txtamcuales,
    aud.rbeoexposicion_si,
    aud.rbeoexposicion_no,
    aud.rbeoprotectores_si,
    aud.rbeoprotectores_no,
    aud.rbeosustancias_si,
    aud.rbeosustancias_no,
    aud.rbte0a2,
    aud.rbte2a4,
    aud.rbte4a6,
    aud.rbte6a8,
    aud.rbte8a10,
    aud.rbte10a12,
    aud.rbtem12,
    aud.rbteeventual,
    aud.chktapones,
    aud.chkorejeras,
    aud.txthplomo,
    aud.txthmercurio,
    aud.txthtolueno,
    aud.txthxileno,
    aud.txthplaguic,
    aud.txthorganofos,
    aud.txttplomo,
    aud.txttmercurio,
    aud.txtttolueno,
    aud.txttxileno,
    aud.txttplaguic,
    aud.txttorganofos,
    aud.txteootros,
    aud.rbaepratica_si,
    aud.rbaepratica_no,
    aud.rbaeuso_si,
    aud.rbaeuso_no,
    aud.rbaeotros_si,
    aud.rbaeotros_no,
    aud.txtaecuales,
    aud.txtood,
    aud.txtooi,
    aud.o_d_500,
    aud.o_d_1000,
    aud.o_d_2000,
    aud.o_d_3000,
    aud.o_d_4000,
    aud.o_d_6000,
    aud.o_d_8000,
    aud.o_i_500,
    aud.o_i_1000,
    aud.o_i_2000,
    aud.o_i_3000,
    aud.o_i_4000,
    aud.o_i_6000,
    aud.o_i_8000,
    aud.o_d1_500,
    aud.o_d1_1000,
    aud.o_d1_2000,
    aud.o_d1_3000,
    aud.o_d1_4000,
    aud.o_d1_6000,
    aud.o_d1_8000,
    aud.o_i1_500,
    aud.o_i1_1000,
    aud.o_i1_2000,
    aud.o_i1_3000,
    aud.o_i1_4000,
    aud.o_i1_6000,
    aud.o_i1_8000,
    aud.txtdiag_od,
    aud.txtdiag_oi,
    aud.txtcomentarios,
    aud.chkrpasimple,
    aud.chkrpadoble,
    aud.chkcasemestral,
    aud.chkcaanual,
    aud.txtotrasrecomendaciones,
    aud.txtanios,
    aud.txtmeses,
    aud.formato,
     

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
  INNER JOIN audiometria_2023 aud ON aud.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

---------------------------------------------------------------------
--Historia ocupacional

CREATE OR REPLACE FUNCTION eliminar_historiaOcupacionalDetalles(cod_ho_param INTEGER)
RETURNS text AS
$BODY$

	BEGIN

	DELETE FROM historia_oc_detalle hod WHERE hod.cod_ho = cod_ho_param;

	RETURN 'OK';

	END;

$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_reporte_historiaOcupacional(p_norden INTEGER)
RETURNS TABLE (
  nombres TEXT,
  edad TEXT,
  n_orden integer,
  dni integer,
  
  cod_ho integer,
  area_o text,
  fecha_ho date,
  na text,

  fecha text,
  empresa text,
  actividad text,
  area_empresa text,
  ocupacion text,
  superficie text,
  socavon text,
  riesgo text,
  proteccion text,
  altitud text,

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

    hoi.n_orden,
    noo.cod_pa,

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
    (SELECT telefono FROM sede WHERE cod_sede = 1)

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN historia_oc_info hoi ON hoi.n_orden = noo.n_orden
  INNER JOIN historia_oc_detalle hod ON hod.cod_ho = hoi.cod_ho
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$$ LANGUAGE plpgsql;

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('audiometria_2023','formulario de audiometria',true,true,true,true,false);


---------------------------------------------------------------------
--Historia ocupacional

CREATE OR REPLACE FUNCTION eliminar_historiaOcupacionalDetalles(cod_ho_param INTEGER)
RETURNS text AS
$BODY$

	BEGIN

	DELETE FROM historia_oc_detalle hod WHERE hod.cod_ho = cod_ho_param;

	RETURN 'OK';

	END;

$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_reporte_historiaOcupacional(p_norden INTEGER)
RETURNS TABLE (
  nombres TEXT,
  edad TEXT,
  n_orden integer,
  dni integer,
  
  cod_ho integer,
  area_o text,
  fecha_ho date,
  na text,

  fecha text,
  empresa text,
  actividad text,
  area_empresa text,
  ocupacion text,
  superficie text,
  socavon text,
  riesgo text,
  proteccion text,
  altitud text,

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

    hoi.n_orden,
    noo.cod_pa,

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
    (SELECT telefono FROM sede WHERE cod_sede = 1)

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN historia_oc_info hoi ON hoi.n_orden = noo.n_orden
  INNER JOIN historia_oc_detalle hod ON hod.cod_ho = hoi.cod_ho
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$$ LANGUAGE plpgsql;

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('historia_oc_info','formulario de historia ocupacional',true,true,true,false,false);

-------------------------------------------------------------------------------------------------------
--AudiometriaPo

CREATE OR REPLACE FUNCTION obtener_informacion_AudiometriaPo(p_norden INTEGER)
RETURNS TABLE (
  nombres TEXT,
  edad TEXT,
  n_orden integer,
  dni integer,

  cod_au integer,
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
  diagnostico text
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    apo.n_orden,
    noo.cod_pa,

    apo.cod_au,
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
    apo.diagnostico
    
  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN audiometria_po apo ON apo.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$$ LANGUAGE plpgsql;

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('audiometria_po','formulario de audiometria po',true,true,true,true,true);



-------------------------------------------------------------------------
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
                                 
END;
$BODY$
  LANGUAGE plpgsql;

-------------------------------------------------------------

CREATE OR REPLACE FUNCTION sp_validar_existencia_servicios(
    IN p_historia_clinica bigint,
    IN p_examen_med text)
  RETURNS TABLE(id_resp integer, mensaje text) AS
$BODY$
declare v_mensaje text;
declare v_id_existencia integer;

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
                                                                                              		                   	
	RETURN query

 SELECT v_id_existencia AS id_resp,v_mensaje as mensaje;
end;
$BODY$
  LANGUAGE plpgsql;