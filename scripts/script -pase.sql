SELECT  n_orden
FROM n_orden_ocupacional
LIMIT 1;

alter table oftalmologia2021 add column usuario_firma text;
alter table oftalmologia2021 add column doctor_asignado text;

create function obtener_reporte_evaluacionoftalmologica(p_norden integer)
    returns TABLE(nombre text, apellido text, edad text, n_orden integer, dni integer, fecha_nac date, empresa text, contrata text, nom_examen text, sexo "char", cod_of integer, fecha_of date, rbecptosisod boolean, rbecptosisoi boolean, rbecestrabismood boolean, rbecestrabismooi boolean, rbecconjuntivitisod boolean, rbecconjuntivitisoi boolean, rbeccataratasod boolean, rbeccataratasoi boolean, rbecpterigionod boolean, rbecpterigionoi boolean, rbecpingueculaod boolean, rbecpingueculaoi boolean, rbecclalacionod boolean, rbecclalacionoi boolean, rbecotrosod boolean, rbecotrosoi boolean, txtechallazgos text, rbfonormalod boolean, rbfonormaloi boolean, rbfoanormalod boolean, rbfoanormaloi boolean, txtfohallazgos text, txtpiood text, txtpiooi text, txtpiona text, rbco_si boolean, rbco_no boolean, rbco_cerca boolean, rbco_lejos boolean, chkntcc boolean, chkntcl boolean, txtcercasincorregirod text, txtcercasincorregiroi text, txtlejossincorregirod text, txtlejossincorregiroi text, txtcercacorregidaod text, txtcercacorregidaoi text, txtlejoscorregidaod text, txtlejoscorregidaoi text, txtcercaagujerood text, txtcercaagujerooi text, txtlejosagujerood text, txtlejosagujerooi text, txtbinocularsincorregir text, txtbinocularcorregida text, rbtecishihara_normal boolean, rbtecishihara_anormal boolean, rbtecishihara_nc boolean, rbteccoleres_normal boolean, rbteccoleres_anormal boolean, rbteccoleres_nc boolean, txttecestereopsia text, rbtecestereopsia_normal boolean, rbtecestereopsia_anormal boolean, rbtecestereopsia_nc boolean, chkrefraccionaplica boolean, chkrefraccionnoaplica boolean, txtlejosodsf text, txtlejosodcil text, txtlejosodeje text, txtlejosoisf text, txtlejosoicil text, txtlejosoieje text, txtlejosoddip text, txtcercaodsf text, txtcercaodcil text, txtcercaodeje text, txtcercaoisf text, txtcercaoicil text, txtcercaoieje text, txtcercaoddip text, txtavconrefraccionlejosod text, txtavconrefraccionlejosoi text, txtavconrefraccioncercaod text, txtavconrefraccioncercaoi text, txtdiagnostico text, chkininguna boolean, chki2 boolean, chki3 boolean, chki4_cerca boolean, chki4_lejos boolean, chki5 boolean, chki6 boolean, chki7 boolean, chkr1 boolean, chkr2_lejos boolean, chkr2_cerca boolean, chkr3 boolean, chkr4 boolean, txtrp text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, txt_parpa_anex text, txt_corneas text, txt_otros_hallaz text, txt_conjuntivas text, txt_cristalino text, txt_ant_pers_imp text, txt_fam_imp text, area_o text, ocupacion text, usuarioFirma text, doctorAsignado text)
    language plpgsql
as
$$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa,
    dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    o.n_orden,
    noo.cod_pa,
    dp.fecha_nacimiento_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    noo.nom_examen,
    --dp.lugar_nac_pa,
    --dp.cel_pa,
    dp.sexo_pa,
    --dp.direccion_pa ||'-'|| dp.distrito_pa ||'-'|| dp.provincia_pa ||'-'|| dp.departamento_pa,
    --u.nombre_user||' '||u.apellido_user,
    o.cod_of,
    o.fecha_of,
    o.rbecptosisod,
    o.rbecptosisoi,
    o.rbecestrabismood,
    o.rbecestrabismooi,
    o.rbecconjuntivitisod,
    o.rbecconjuntivitisoi,
    o.rbeccataratasod,
    o.rbeccataratasoi,
    o.rbecpterigionod,
    o.rbecpterigionoi,
    o.rbecpingueculaod,
    o.rbecpingueculaoi,
    o.rbecclalacionod,
    o.rbecclalacionoi,
    o.rbecotrosod,
    o.rbecotrosoi,
    o.txtechallazgos,
    o.rbfonormalod,
    o.rbfonormaloi,
    o.rbfoanormalod,
    o.rbfoanormaloi,
    o.txtfohallazgos,
    o.txtpiood,
    o.txtpiooi,
    o.txtpiona,
    o.rbco_si,
    o.rbco_no,
    o.rbco_cerca,
    o.rbco_lejos,
    o.chkntcc,
    o.chkntcl,
    o.txtcercasincorregirod,
    o.txtcercasincorregiroi,
    o.txtlejossincorregirod,
    o.txtlejossincorregiroi,
    o.txtcercacorregidaod,
    o.txtcercacorregidaoi,
    o.txtlejoscorregidaod,
    o.txtlejoscorregidaoi,
    o.txtcercaagujerood,
    o.txtcercaagujerooi,
    o.txtlejosagujerood,
    o.txtlejosagujerooi,
    o.txtbinocularsincorregir,
    o.txtbinocularcorregida,
    o.rbtecishihara_normal,
    o.rbtecishihara_anormal,
    o.rbtecishihara_nc,
    o.rbteccoleres_normal,
    o.rbteccoleres_anormal,
    o.rbteccoleres_nc,
    o.txttecestereopsia,
    o.rbtecestereopsia_normal,
    o.rbtecestereopsia_anormal,
    o.rbtecestereopsia_nc,
    o.chkrefraccionaplica,
    o.chkrefraccionnoaplica,
    o.txtlejosodsf,
    o.txtlejosodcil,
    o.txtlejosodeje,
    o.txtlejosoisf,
    o.txtlejosoicil,
    o.txtlejosoieje,
    o.txtlejosoddip,
    o.txtcercaodsf,
    o.txtcercaodcil,
    o.txtcercaodeje,
    o.txtcercaoisf,
    o.txtcercaoicil,
    o.txtcercaoieje,
    o.txtcercaoddip,
    o.txtavconrefraccionlejosod,
    o.txtavconrefraccionlejosoi,
    o.txtavconrefraccioncercaod,
    o.txtavconrefraccioncercaoi,
    o.txtdiagnostico,
    o.chkininguna,
    o.chki2,
    o.chki3,
    o.chki4_cerca,
    o.chki4_lejos,
    o.chki5,
    o.chki6,
    o.chki7,
    o.chkr1,
    o.chkr2_lejos,
    o.chkr2_cerca,
    o.chkr3,
    o.chkr4,
    o.txtrp,


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
    o.txt_parpa_anex,
    o.txt_corneas,
    o.txt_otros_hallaz,
    o.txt_conjuntivas,
    o.txt_cristalino,
    o.txt_ant_pers_imp,
    o.txt_fam_imp,
    noo.area_o,
    noo.cargo_de,
    o.usuario_firma,
    o.doctor_asignado
  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN oftalmologia2021 o ON o.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
  WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_evaluacionoftalmologica(integer) owner to pierola;



alter table ficha_audiologica add column doctor_asignado text;
alter table ficha_audiologica add column doctor_extra text;

create function obtener_reporte_audiometriam(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, num_ticket integer, fecha_au date, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, diagnostico text, fecha_examen date, tiempo_trabajo integer, tiempo_exposicion_total_ponderado text, edad_fa text, chk_tapones boolean, chkgrajeras boolean, chkintenso boolean, chkmoderado boolean, chknomolesto boolean, txtmarca text, txtmodelo text, fechacalibracion date, chk1_si boolean, chk2_si boolean, chk3_si boolean, chk4_si boolean, chk5_si boolean, chk6_si boolean, chk7_si boolean, chk8_si boolean, chk9_si boolean, chk10_si boolean, chk11_si boolean, chk12_si boolean, chk1_no boolean, chk2_no boolean, chk3_no boolean, chk4_no boolean, chk5_no boolean, chk6_no boolean, chk7_no boolean, chk8_no boolean, chk9_no boolean, chk10_no boolean, chk11_no boolean, chk12_no boolean, txtdod250 text, txtdod500 text, txtdod1000 text, txtdoi250 text, txtdoi500 text, txtdoi1000 text, txtldumbraldiscriminacion text, txtliumbraldiscriminacion text, txtldporcentagediscriminacion text, txtliporcentagediscriminacion text, txtldconfort text, txtliconfort text, txtlddisconfort text, txtlidisconfort text, txtresponsable text, txtconclusiones text, txtmedico text, txtotoscopia text, txtmesestrabajo integer, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, empresa text, contrata text, nom_examen text, sexo_pa "char", ocupacion text, otros text, usuariofirma text, doctorasignado text, doctorextra text)
    language plpgsql
as
$$
DECLARE
	empresa_var text;
BEGIN

SELECT trim(razon_empresa) INTO empresa_var FROM n_orden_ocupacional n WHERE n.n_orden = p_norden;

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
    CASE WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN (select nombre_user || ' ' || apellido_user from usuarios where usuario_user = 'SGUTIERREZ') ELSE fa.txtresponsable END as txt_responsable,
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
    (SELECT telefono FROM sede WHERE cod_sede = 1),
    noo.razon_empresa,
    noo.razon_contrata,
    noo.nom_examen,
    --dp.lugar_nac_pa,
    --dp.cel_pa,
    dp.sexo_pa,
    noo.cargo_de,
    fa.otros,
    fa.usuario_firma,
    fa.doctor_asignado,
    fa.doctor_extra

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
  INNER JOIN audiometria_po apo ON apo.n_orden = fa.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_audiometriam(integer) owner to pierola;

create function obtener_informacion_fichaaudiologica(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_nacimiento_pa date, empresa text, contrata text, nom_examen text, sexo_pa "char", area_o text, cod_fa integer, fecha_examen date, tiempo_trabajo integer, tiempo_exposicion_total_ponderado text, edad_fa text, chk_tapones boolean, chkgrajeras boolean, chkintenso boolean, chkmoderado boolean, chknomolesto boolean, txtmarca text, txtmodelo text, fechacalibracion date, chk1_si boolean, chk2_si boolean, chk3_si boolean, chk4_si boolean, chk5_si boolean, chk6_si boolean, chk7_si boolean, chk8_si boolean, chk9_si boolean, chk10_si boolean, chk11_si boolean, chk12_si boolean, chk1_no boolean, chk2_no boolean, chk3_no boolean, chk4_no boolean, chk5_no boolean, chk6_no boolean, chk7_no boolean, chk8_no boolean, chk9_no boolean, chk10_no boolean, chk11_no boolean, chk12_no boolean, txtdod250 text, txtdod500 text, txtdod1000 text, txtdoi250 text, txtdoi500 text, txtdoi1000 text, txtldumbraldiscriminacion text, txtliumbraldiscriminacion text, txtldporcentagediscriminacion text, txtliporcentagediscriminacion text, txtldconfort text, txtliconfort text, txtlddisconfort text, txtlidisconfort text, txtresponsable text, txtconclusiones text, txtmedico text, txtotoscopia text, txtmesestrabajo integer, user_registro text, otros text, usuariofirma text, doctorasignado text, doctorextra text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT dp.apellidos_pa || ' ' || dp.nombres_pa,
               CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

               fa.n_orden,
               noo.cod_pa,
               dp.fecha_nacimiento_pa,
               noo.razon_empresa,
               noo.razon_contrata,
               noo.nom_examen,
               dp.sexo_pa,
               noo.area_o,

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
               fa.user_registro,
               fa.otros,
               fa.usuario_firma,
               fa.doctor_asignado,
               fa.doctor_extra
        FROM datos_paciente dp
                 INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
                 INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
                 INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
        WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_informacion_fichaaudiologica(integer) owner to pierola;



alter table funcion_abs add column doctor_asignado text;
alter table funcion_abs add column doctor_extra text;

update config_general_service_digital
set firma_p = true,
    huella_p = true,
    sello_doc_asig = true,
    sello_doc_adic = true
where name_service = 'funcion_abs';

create function obetner_reporte_espirometria(p_norden integer)
    returns TABLE(nombres text, edad text, cod_abs integer, n_orden integer, fecha_examen date, cod_exam integer, fvc text, fev1 text, fev1fvc text, fef25_75 text, interpretacion text, fvc_teorico text, fev1_teorico text, talla text, peso text, usuario_firma text, dnipaciente integer, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, empresa text, codigoclinica text, tipoexamen text, departamento text, provincia text, distrito text, edadpaciente text, sistolica text, diastolica text, doctorasignado text, doctorextra text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT dp.nombres_pa || ' ' || dp.apellidos_pa,
               CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
               fbs.cod_abs,
               fbs.n_orden,
               fbs.fecha_abs,
               fbs.cod_exam,
               fbs.fvc,
               fbs.fev1,
               fbs.fev1fvc,
               fbs.fef25_75,
               fbs.interpretacion,
               fbs.fvc_teorico,
               fbs.fev1_teorico,
               trj.talla,
               trj.peso,
               fbs.usuario_firma,
               dp.cod_pa,
               dp.direccion_pa,
               dp.sexo_pa,
               dp.fecha_nacimiento_pa,
               dp.ocupacion_pa,
               dp.lugar_nac_pa,
               dp.nivel_est_pa,
               dp.estado_civil_pa,
               noo.cargo_de,
               noo.area_o,
               noo.razon_contrata,
               noo.razon_empresa,
               noo.cod_clinica,
               noo.nom_examen,
               dp.departamento_pa,
               dp.provincia_pa,
               dp.distrito_pa,
               CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
               trj.sistolica,
               trj.diastolica,
               fbs.doctor_asignado,
               fbs.doctor_extra
        FROM datos_paciente dp
                 INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
                 INNER JOIN funcion_abs fbs ON fbs.n_orden = noo.n_orden
                 INNER JOIN triaje trj ON noo.n_orden = trj.n_orden
        WHERE noo.n_orden = p_norden;
END;
$$;

alter function obetner_reporte_espirometria(integer) owner to pierola;



alter table ficha_audiologica add column usuario_firma text

create function obtener_informacion_fichaaudiologica(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_nacimiento_pa date, empresa text, contrata text, nom_examen text, sexo_pa "char", area_o text, cod_fa integer, fecha_examen date, tiempo_trabajo integer, tiempo_exposicion_total_ponderado text, edad_fa text, chk_tapones boolean, chkgrajeras boolean, chkintenso boolean, chkmoderado boolean, chknomolesto boolean, txtmarca text, txtmodelo text, fechacalibracion date, chk1_si boolean, chk2_si boolean, chk3_si boolean, chk4_si boolean, chk5_si boolean, chk6_si boolean, chk7_si boolean, chk8_si boolean, chk9_si boolean, chk10_si boolean, chk11_si boolean, chk12_si boolean, chk1_no boolean, chk2_no boolean, chk3_no boolean, chk4_no boolean, chk5_no boolean, chk6_no boolean, chk7_no boolean, chk8_no boolean, chk9_no boolean, chk10_no boolean, chk11_no boolean, chk12_no boolean, txtdod250 text, txtdod500 text, txtdod1000 text, txtdoi250 text, txtdoi500 text, txtdoi1000 text, txtldumbraldiscriminacion text, txtliumbraldiscriminacion text, txtldporcentagediscriminacion text, txtliporcentagediscriminacion text, txtldconfort text, txtliconfort text, txtlddisconfort text, txtlidisconfort text, txtresponsable text, txtconclusiones text, txtmedico text, txtotoscopia text, txtmesestrabajo integer, user_registro text, otros text, usuariofirma text)
    language plpgsql
as
$$
BEGIN
  RETURN QUERY
  SELECT 
    dp.apellidos_pa || ' ' || dp.nombres_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    fa.n_orden,
    noo.cod_pa,
    dp.fecha_nacimiento_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    noo.nom_examen,
    dp.sexo_pa,
    noo.area_o,

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
    fa.user_registro,
    fa.otros,
    fa.usuario_firma

    
  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_informacion_fichaaudiologica(integer) owner to pierola;




------------------------------------------------------------------------------------------------------
CREATE TABLE error_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo_error VARCHAR(50) NOT NULL,
    origen VARCHAR(100) NOT NULL,
    mensaje TEXT NOT NULL,
    detalle TEXT,
    payload JSONB,
    fecha TIMESTAMP NOT NULL DEFAULT NOW(),
    estado VARCHAR(20) NOT NULL, -- PENDIENTE / RESUELTO
    usuario VARCHAR(50),
    referencia VARCHAR(100),
    stacktrace TEXT
);

CREATE INDEX idx_error_log_codigo ON error_log(codigo_error);
CREATE INDEX idx_error_log_fecha ON error_log(fecha);
CREATE INDEX idx_error_log_estado ON error_log(estado);

ALTER TABLE error_log
    ADD COLUMN endpoint VARCHAR(150),
    ADD COLUMN metodo_http VARCHAR(10);

create table prospecto(
    id SERIAL PRIMARY KEY,
    estado TEXT,
    numero_documento bigint,
    nombre varchar(50),
    apellido varchar(50),
    telefono TEXT,
    correo TEXT,
    empresa TEXT,
    fecha_registro date,
    direccion TEXT,
    sexo TEXT,
    tipo_documento varchar(30),
    ubigeo varchar(6),
    usuario_actualizacion text,
    fecha_actualizacion date
);

CREATE TABLE n_orden_examen_adicional ( id SERIAL PRIMARY KEY, n_orden BIGINT NOT NULL, id_examen_adicional_protocolo BIGINT NOT NULL, version_registro INTEGER, usuario_registro text, fecha_registro date, hora_registro TIME, CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional(n_orden) );

CREATE TABLE configuracion_deposito ( id SERIAL PRIMARY KEY, codigo_transferencia TEXT, banco TEXT, monto numeric(38, 2), archivo TEXT, usuario_registro text, fecha_registro date, hora_registro TIME, usuario_actualizacion text, fecha_actualizacion date, hora_actualizacion TIME, estado boolean );

CREATE TABLE detalle_pago ( id SERIAL PRIMARY KEY, n_orden integer NOT NULL, version_registro INTEGER, monto_adicionales numeric(38, 2), monto_protocolo numeric(38, 2), monto_total numeric(38, 2), id_configuracion_deposito INTEGER, fecha_pago date, hora_pago TIME, forma_pago text, usuario_registro text, fecha_registro date, hora_registro TIME, usuario_actualizacion text, fecha_actualizacion date, hora_actualizacion TIME, estado boolean, CONSTRAINT fk_n_orden FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional(n_orden), CONSTRAINT fk_id_configuracion_deposito FOREIGN KEY (id_configuracion_deposito) REFERENCES configuracion_deposito(id) );

SELECT  CASE WHEN usuario_firma IS NULL THEN user_registro  ELSE usuario_firma END INTO user_registro_var
FROM certificado_aptitud_medico_resumen
WHERE n_orden = norden_param;
-----------------------------------------------------------------------------
--PGADMIN 4
CREATE OR REPLACE FUNCTION obtener_examenes_hoja_ruta(
    p_id_protocolo INTEGER,
    p_ids_adicionales INTEGER[]
)
    RETURNS JSONB
    LANGUAGE plpgsql
AS $$
DECLARE
    v_resultado JSONB;
BEGIN
    WITH
        -- 1. Exámenes Regulares con sus sub-exámenes
        examenes_regulares AS (
            SELECT
                a.id_area,
                jsonb_agg(
                        jsonb_build_object(
                                'id_examen', ex.id_examen,
                                'nombre', ex.nombre,
                                'sub_examenes', COALESCE(
                                        (
                                            SELECT jsonb_agg(
                                                           jsonb_build_object(
                                                                   'id_sub_examen', se.id_sub_examen,
                                                                   'nombre', se.descripcion
                                                           )
                                                   )
                                            FROM sub_examen se
                                                     INNER JOIN protocolo_sub_examenes pse
                                                                ON pse.id_sub_examen = se.id_sub_examen
                                                                    AND pse.estado = true
                                            WHERE se.id_examen = ex.id_examen
                                              AND se.estado = true
                                              AND pse.id_protocolo = p_id_protocolo
                                        ),
                                        '[]'::jsonb
                                                )
                        )
                ) AS lista_examenes
            FROM examen ex
                     INNER JOIN protocolo_examenes pe ON ex.id_examen = pe.id_examen
                     INNER JOIN area a ON ex.id_area = a.id_area
            WHERE pe.id_protocolo = p_id_protocolo
              AND ex.estado = true
            GROUP BY a.id_area
        ),

        -- 2. Exámenes Adicionales con sus sub-exámenes
        examenes_adicionales AS (
            SELECT
                a.id_area,
                jsonb_agg(
                        jsonb_build_object(
                                'id_examen', ex.id_examen,
                                'nombre', ex.nombre,
                                'id_examen_adicional_protocolo', pea.id_examen_adicional_protocolo,
                                'sub_examenes', COALESCE(
                                        (
                                            SELECT jsonb_agg(
                                                           jsonb_build_object(
                                                                   'id_sub_examen', se.id_sub_examen,
                                                                   'nombre', se.descripcion
                                                           )
                                                   )
                                            FROM sub_examen se
                                                     INNER JOIN protocolo_sub_examenes pse
                                                                ON pse.id_sub_examen = se.id_sub_examen
                                                                    AND pse.estado = true
                                            WHERE se.id_examen = ex.id_examen
                                              AND se.estado = true
                                              AND pse.id_protocolo = p_id_protocolo
                                        ),
                                        '[]'::jsonb
                                                )
                        )
                ) AS lista_adicionales
            FROM examen ex
                     INNER JOIN protocolo_examen_adicional pea ON ex.id_examen = pea.id_examen
                     INNER JOIN area a ON ex.id_area = a.id_area
            WHERE pea.id_protocolo = p_id_protocolo
              AND pea.id_examen_adicional_protocolo = ANY(p_ids_adicionales) -- Filtrado correcto por array
              AND ex.estado = true
            GROUP BY a.id_area
        )

    -- 3. Todo por Área
    SELECT
        jsonb_agg(
                jsonb_build_object(
                        'id_area', a.id_area,
                        'nombre_area', a.descripcion,
                        'examenes', COALESCE(er.lista_examenes, '[]'::jsonb),
                        'examenes_adicionales', COALESCE(ea.lista_adicionales, '[]'::jsonb)
                )
        ) INTO v_resultado
    FROM area a
             LEFT JOIN examenes_regulares er ON a.id_area = er.id_area
             LEFT JOIN examenes_adicionales ea ON a.id_area = ea.id_area
    WHERE er.id_area IS NOT NULL OR ea.id_area IS NOT NULL;

    -- Devolvemos array vacío si no hay resultados en lugar de NULL
    RETURN COALESCE(v_resultado, '[]'::jsonb);
END;
$$;


--verificar el id porque no es autoincremental 
INSERT INTO lista_parametros values (54, 'Acuerdos de pago') --verificar el id porque no es autoincremental 
INSERT INTO detalle_parametro values (49052, 'Credito', 54)
INSERT INTO detalle_parametro values (49053, 'No Credito', 54)

ALTER TABLE protocolo RENAME COLUMN forma_pago TO acuerdo_pago;

ALTER TABLE protocolo add column forma_pago TEXT -- 

-- CREATE TABLE forma_pago(
-- forma_pago_id serial primary key,
-- nombre text not null,
-- anulado boolean,
-- usuario_registro TEXT,
-- fecha_registro DATE,
-- hora_registro TIME,
-- usuario_actualizacion TEXT,
-- fecha_actualizacion DATE,
-- hora_actualizacion TIME
-- ) 

CREATE TABLE protocolo_sub_examen_adicional( id_sub_examen_adicional_protocolo serial primary key, id_sub_examen Integer not null, id_protocolo INTEGER NOT NULL, precio numeric(38, 2), estado boolean, usuario_registro TEXT, fecha_registro DATE, hora_registro TIME, usuario_actualizacion TEXT, fecha_actualizacion DATE, hora_actualizacion TIME, CONSTRAINT fk_sub_examen FOREIGN KEY (id_sub_examen) REFERENCES sub_examen (id_sub_examen), CONSTRAINT fk_protocolo FOREIGN KEY (id_protocolo) REFERENCES protocolo (id_protocolo) );

CREATE TABLE protocolo_examen_adicional( id_examen_adicional_protocolo serial primary key, id_examen Integer not null, id_protocolo INTEGER NOT NULL, precio numeric(38, 2), estado boolean, usuario_registro TEXT, fecha_registro DATE, hora_registro TIME, usuario_actualizacion TEXT, fecha_actualizacion DATE, hora_actualizacion TIME, CONSTRAINT fk_examen FOREIGN KEY (id_examen) REFERENCES examen (id_examen), CONSTRAINT fk_protocolo FOREIGN KEY (id_protocolo) REFERENCES protocolo (id_protocolo) );
-- BUSQUEDA DE EXAMENES SEGUN PROTOCOLO 

CREATE OR REPLACE FUNCTION listado_examenes_protocolos_paciente( protocolo_param text, historia_clinica_param integer ) RETURNS TABLE( id_archivos bigint, nombre text, ruta text, valor boolean ) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $BODY$ BEGIN RETURN QUERY
SELECT  cast ( 1                                                           AS bigint )
       ,cast(tb1.nombre AS text)                                           AS nombre
       ,cast (tb2.ruta_Archivo AS text)                                    AS ruta
       ,( CASE WHEN tb2.id_archivos is not null THEN true else false end ) AS valor
FROM
(
	SELECT  exam.prefijo
	       ,exam.nombre
	FROM protocolo AS prot
	INNER JOIN protocolo_examenes AS prot_exam
	ON prot.id_protocolo = prot_exam.id_protocolo
	INNER JOIN examen AS exam
	ON prot_exam.id_examen = exam.id_examen
	WHERE prot.nombre = protocolo_param
	AND exam.prefijo IS NOT NULL 
) AS tb1
LEFT JOIN
(
	SELECT  arch_Serv.id_archivos
	       ,arch_Serv.ruta_Archivo
	       ,tip_Arch.nomenclatura
	FROM archivos_servidores AS arch_Serv
	INNER JOIN tipo_archivo AS tip_Arch
	ON arch_Serv.id_tipo_archivo = tip_Arch.id_tipo_archivo
	WHERE arch_Serv.orden = historia_clinica_param 
) AS tb2
ON tb1.prefijo = tb2.nomenclatura; END; $BODY$;
-- PG ADMIN 3 

CREATE OR REPLACE FUNCTION listado_pacientes_protocolo_busqueda_filtros( razon_empresa_param text, razon_contrata_param text, name_protocolo_param text, fecha_inicio_param date, fecha_fin_param date ) RETURNS TABLE( protocolos text, nombres text, dni integer, n_orden integer, razon_empresa text, razon_contrata text, tipoexamen text, fechaexamen date ) LANGUAGE 'plpgsql' AS $BODY$ BEGIN RETURN QUERY
SELECT  n.protocolo
       ,dp.nombres_pa || ' ' || dp.apellidos_pa AS nombres
       ,n.cod_pa                                AS dni
       ,n.n_orden
       ,n.razon_empresa
       ,n.razon_contrata
       ,n.nom_examen                            AS tipoExamen
       ,n.fecha_apertura_po                     AS fechaExamen
FROM n_orden_ocupacional AS n
INNER JOIN datos_paciente AS dp
ON n.cod_pa = dp.cod_pa
WHERE n.razon_empresa = razon_empresa_param
AND n.fecha_apertura_po BETWEEN fecha_inicio_param AND fecha_fin_param; END; $BODY$;
------------------------------------------------------------------ 

CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(user_name text) RETURNS TABLE( id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying, empresas text, contratas text ) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $BODY$ DECLARE validar_empresa_hm BIGINT; BEGIN

SELECT  COUNT(emp.id_empleado) into validar_empresa_hm
FROM empleado AS emp
INNER JOIN usuario AS us
ON emp.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc = '20477167561'
AND us.username = user_name; IF(validar_empresa_hm > 0) THEN RETURN QUERY

SELECT  empl.id_empleado
       ,empl.apellidos
       ,empl.cargo
       ,empl.celular
       ,empl.cip
       ,empl.correo_elect
       ,empl.direccion
       ,empl.estado
       ,empl.fecha_actualizacion
       ,empl.fecha_nacimiento
       ,empl.fecha_registro
       ,empl.nombres
       ,empl.num_documento
       ,empl.tel_fijo
       ,empl.tipo_doc
       ,empl.ubigeo
       ,empl.user_actualizacion
       ,empl.user_registro
       ,empl.sexo
       ,(
SELECT  STRING_AGG(DISTINCT e1.razon_empresa,' - ') AS empresas
FROM empleado AS empl1
INNER JOIN usuario AS us1
ON empl1.id_empleado = us1.id_empleado
INNER JOIN usuario_empresa_contrada AS uec1
ON us1.id_user = uec1.id_user
INNER JOIN empresas AS e1
ON uec1.ruc = e1.ruc_empresa AND uec1.tipo = 'EMPRESA'
WHERE uec1.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado )
GROUP BY  empl1.id_empleado )
         ,(
SELECT  STRING_AGG(DISTINCT e1.razon_contrata,' - ') AS contratas
FROM empleado AS empl1
INNER JOIN usuario AS us1
ON empl1.id_empleado = us1.id_empleado
INNER JOIN usuario_empresa_contrada AS uec1
ON us1.id_user = uec1.id_user
INNER JOIN contratas AS e1
ON uec1.ruc = e1.ruc_contrata AND uec1.tipo = 'CONTRATA'
WHERE uec1.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado )
GROUP BY  empl1.id_empleado )
FROM empleado AS empl; else RETURN QUERY

SELECT  emp.id_empleado
       ,emp.apellidos
       ,emp.cargo
       ,emp.celular
       ,emp.cip
       ,emp.correo_elect
       ,emp.direccion
       ,emp.estado
       ,emp.fecha_actualizacion
       ,emp.fecha_nacimiento
       ,emp.fecha_registro
       ,emp.nombres
       ,emp.num_documento
       ,emp.tel_fijo
       ,emp.tipo_doc
       ,emp.ubigeo
       ,emp.user_actualizacion
       ,emp.user_registro
       ,emp.sexo
       ,(
SELECT  STRING_AGG(DISTINCT e.razon_empresa,' - ') AS empresas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN empresas AS e
ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
WHERE uec.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
         ,(
SELECT  STRING_AGG(DISTINCT e.razon_contrata,' - ') AS contratas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN contratas AS e
ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
WHERE uec.ruc IN ( SELECT DISTINCT ue.ruc FROM usuario_empresa_contrada AS ue INNER JOIN usuario AS u ON ue.id_user = u.id_user WHERE u.username = user_name AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
FROM empleado AS emp
WHERE emp.id_empleado IN (
SELECT  distinct(empl.id_empleado)
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc IN (
SELECT  distinct(ue.ruc)
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name ) )
UNION
SELECT  e.id_empleado
       ,e.apellidos
       ,e.cargo
       ,e.celular
       ,e.cip
       ,e.correo_elect
       ,e.direccion
       ,e.estado
       ,e.fecha_actualizacion
       ,e.fecha_nacimiento
       ,e.fecha_registro
       ,e.nombres
       ,e.num_documento
       ,e.tel_fijo
       ,e.tipo_doc
       ,e.ubigeo
       ,e.user_actualizacion
       ,e.user_registro
       ,e.sexo
       ,(
SELECT  STRING_AGG(DISTINCT e.razon_empresa,' - ') AS empresas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN empresas AS e
ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
WHERE uec.ruc IN (
SELECT  DISTINCT ue.ruc
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name
AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
         ,(
SELECT  STRING_AGG(DISTINCT e.razon_contrata,' - ') AS contratas
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
INNER JOIN contratas AS e
ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
WHERE uec.ruc IN (
SELECT  DISTINCT ue.ruc
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name
AND us.id_empleado = emp.id_empleado )
GROUP BY  empl.id_empleado )
FROM empleado AS e
WHERE e.user_registro = user_name; end if; END; $BODY$; 

ALTER FUNCTION public.listado_empleado_por_username(text) OWNER TO developerhm;
----- COPIA SEGURIDAD -----------
-- FUNCTION: public.listado_empleado_por_username(text)
-- DROP FUNCTION IF EXISTS public.listado_empleado_por_username(text); 
CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(user_name text) RETURNS TABLE( id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying ) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $BODY$ DECLARE validar_empresa_hm BIGINT; BEGIN

SELECT  COUNT(emp.id_empleado) into validar_empresa_hm
FROM empleado AS emp
INNER JOIN usuario AS us
ON emp.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc = '20477167561'
AND us.username = user_name; IF(validar_empresa_hm > 0) THEN RETURN QUERY

SELECT  empl.id_empleado
       ,empl.apellidos
       ,empl.cargo
       ,empl.celular
       ,empl.cip
       ,empl.correo_elect
       ,empl.direccion
       ,empl.estado
       ,empl.fecha_actualizacion
       ,empl.fecha_nacimiento
       ,empl.fecha_registro
       ,empl.nombres
       ,empl.num_documento
       ,empl.tel_fijo
       ,empl.tipo_doc
       ,empl.ubigeo
       ,empl.user_actualizacion
       ,empl.user_registro
       ,empl.sexo
FROM empleado AS empl; else RETURN QUERY

SELECT  emp.id_empleado
       ,emp.apellidos
       ,emp.cargo
       ,emp.celular
       ,emp.cip
       ,emp.correo_elect
       ,emp.direccion
       ,emp.estado
       ,emp.fecha_actualizacion
       ,emp.fecha_nacimiento
       ,emp.fecha_registro
       ,emp.nombres
       ,emp.num_documento
       ,emp.tel_fijo
       ,emp.tipo_doc
       ,emp.ubigeo
       ,emp.user_actualizacion
       ,emp.user_registro
       ,emp.sexo
FROM empleado AS emp
WHERE emp.id_empleado IN (
SELECT  distinct(empl.id_empleado)
FROM empleado AS empl
INNER JOIN usuario AS us
ON empl.id_empleado = us.id_empleado
INNER JOIN usuario_empresa_contrada AS uec
ON us.id_user = uec.id_user
WHERE uec.ruc IN (
SELECT  distinct(ue.ruc)
FROM usuario_empresa_contrada AS ue
INNER JOIN usuario AS u
ON ue.id_user = u.id_user
WHERE u.username = user_name ) )
UNION
SELECT  e.id_empleado
       ,e.apellidos
       ,e.cargo
       ,e.celular
       ,e.cip
       ,e.correo_elect
       ,e.direccion
       ,e.estado
       ,e.fecha_actualizacion
       ,e.fecha_nacimiento
       ,e.fecha_registro
       ,e.nombres
       ,e.num_documento
       ,e.tel_fijo
       ,e.tipo_doc
       ,e.ubigeo
       ,e.user_actualizacion
       ,e.user_registro
       ,e.sexo
FROM empleado AS e
WHERE e.user_registro = user_name; end if; END; $BODY$; 

ALTER FUNCTION public.listado_empleado_por_username(text) OWNER TO developerhm;