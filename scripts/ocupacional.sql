create function obtener_reporte_audiometriam(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, num_ticket integer, fecha_au date, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, diagnostico text, fecha_examen date, tiempo_trabajo integer, tiempo_exposicion_total_ponderado text, edad_fa text, chk_tapones boolean, chkgrajeras boolean, chkintenso boolean, chkmoderado boolean, chknomolesto boolean, txtmarca text, txtmodelo text, fechacalibracion date, chk1_si boolean, chk2_si boolean, chk3_si boolean, chk4_si boolean, chk5_si boolean, chk6_si boolean, chk7_si boolean, chk8_si boolean, chk9_si boolean, chk10_si boolean, chk11_si boolean, chk12_si boolean, chk1_no boolean, chk2_no boolean, chk3_no boolean, chk4_no boolean, chk5_no boolean, chk6_no boolean, chk7_no boolean, chk8_no boolean, chk9_no boolean, chk10_no boolean, chk11_no boolean, chk12_no boolean, txtdod250 text, txtdod500 text, txtdod1000 text, txtdoi250 text, txtdoi500 text, txtdoi1000 text, txtldumbraldiscriminacion text, txtliumbraldiscriminacion text, txtldporcentagediscriminacion text, txtliporcentagediscriminacion text, txtldconfort text, txtliconfort text, txtlddisconfort text, txtlidisconfort text, txtresponsable text, txtconclusiones text, txtmedico text, txtotoscopia text, txtmesestrabajo integer, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, empresa text, contrata text, nom_examen text, sexo_pa "char", ocupacion text, otros text, usuariofirma text, doctorasignado text, doctorextra text, fecha_nacimiento_pa date, area text)
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
    CASE
        WHEN empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN (select nombre_user || ' ' || apellido_user from usuarios where usuario_user = 'SGUTIERREZ')
        ELSE CASE WHEN fa.usuario_firma IS NULL THEN fa.txtresponsable
                  ELSE (select nombre_user || ' ' || apellido_user from usuarios where usuario_user = fa.usuario_firma) END
        END as txt_responsable,
    fa.txtconclusiones,
    CASE WHEN fa.txtmedico IS NULL THEN (select nombre_user || ' ' || apellido_user from usuarios where usuario_user = fa.doctor_asignado)
         ELSE fa.txtmedico END as doctor_asignado,
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
    fa.doctor_extra,
    dp.fecha_nacimiento_pa,
    noo.area_o

FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN ficha_audiologica fa ON fa.n_orden = noo.n_orden
         INNER JOIN audiometria_po apo ON apo.n_orden = fa.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_audiometriam(integer) owner to pierola;


alter table audiometria_2023 add column doctor_asignado text;

create function obtener_reporte_audiometria(p_norden integer)
    returns TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, cod_au integer, fecha_au date, rbsasordera_si boolean, rbsasordera_no boolean, rbsaacufenos_si boolean, rbsaacufenos_no boolean, rbsavertigo_si boolean, rbsavertigo_no boolean, rbsaotalgia_si boolean, rbsaotalgia_no boolean, rbsasecrecion_si boolean, rbsasecrecion_no boolean, txtsaotrossintomas text, rbamrenitis_si boolean, rbamrenitis_no boolean, rbamsinusitis_si boolean, rbamsinusitis_no boolean, rbamotitis_si boolean, rbamotitis_no boolean, rbamototoxicos_si boolean, rbamototoxicos_no boolean, rbammeningitis_si boolean, rbammeningitis_no boolean, rbamtec_si boolean, rbamtec_no boolean, rbamsordera_si boolean, rbamsordera_no boolean, rbamparotiditis_si boolean, rbamparotiditis_no boolean, rbamsarampion_si boolean, rbamsarampion_no boolean, rbamtbc_si boolean, rbamtbc_no boolean, txtamcuales text, rbeoexposicion_si boolean, rbeoexposicion_no boolean, rbeoprotectores_si boolean, rbeoprotectores_no boolean, rbeosustancias_si boolean, rbeosustancias_no boolean, rbte0a2 boolean, rbte2a4 boolean, rbte4a6 boolean, rbte6a8 boolean, rbte8a10 boolean, rbte10a12 boolean, rbtem12 boolean, rbteeventual boolean, chktapones boolean, chkorejeras boolean, txthplomo text, txthmercurio text, txthtolueno text, txthxileno text, txthplaguic text, txthorganofos text, txttplomo text, txttmercurio text, txtttolueno text, txttxileno text, txttplaguic text, txttorganofos text, txteootros text, rbaepratica_si boolean, rbaepratica_no boolean, rbaeuso_si boolean, rbaeuso_no boolean, rbaeotros_si boolean, rbaeotros_no boolean, txtaecuales text, txtood text, txtooi text, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, txtdiag_od text, txtdiag_oi text, txtcomentarios text, chkrpasimple boolean, chkrpadoble boolean, chkcasemestral boolean, chkcaanual boolean, txtotrasrecomendaciones text, txtanios text, txtmeses text, formato character varying, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, fecha_nacimiento_pa date, sexo "char", areatrabajo text, ocupacion text, nom_examen text, usuario_firma text, apellidospaciente text, fechanacimientopaciente date, direccionpaciente text, lugarnacimientopaciente text, nivelestudiospaciente text, estadocivilpaciente text, codigoclinica text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
SELECT dp.apellidos_pa || ' ' || dp.nombres_pa,
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
       (SELECT telefono FROM sede WHERE cod_sede = 1),
       dp.fecha_nacimiento_pa,
       dp.sexo_pa,
       noo.area_o,
       noo.cargo_de,
       noo.nom_examen,
       aud.usuario_firma,
       dp.apellidos_pa,
       dp.fecha_nacimiento_pa,
       dp.direccion_pa AS direccionpaciente,
       dp.lugar_nac_pa,
       dp.nivel_est_pa,
       dp.estado_civil_pa,
       noo.cod_clinica,
       aud.doctor_asignado
FROM datos_paciente dp
         INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
         INNER JOIN audiometria_2023 aud ON aud.n_orden = noo.n_orden
         INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
WHERE noo.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_audiometria(integer) owner to pierola;

