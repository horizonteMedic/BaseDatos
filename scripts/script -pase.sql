SELECT  n_orden
FROM n_orden_ocupacional
LIMIT 1;

create function obtener_datos_generales(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, codigoclinica text, tipoexamen text, edadpaciente text, departamento text, provincia text, distrito text, talla text, peso text, gruposanguineo text, nombresede text, sede text, color integer, namejasper text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            d.cod_pa,
            d.nombres_pa,
            d.apellidos_pa,
            d.direccion_pa,
            d.sexo_pa,
            d.fecha_nacimiento_pa,
            d.ocupacion_pa,
            d.lugar_nac_pa,
            d.nivel_est_pa,
            d.estado_civil_pa,
            n.cargo_de,
            n.area_o,
            n.razon_contrata,
            n.n_orden,
            n.razon_empresa,
            n.cod_clinica,
            n.nom_examen,
            CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
            d.departamento_pa,
            d.provincia_pa,
            d.distrito_pa,
            t.talla,
            t.peso,
            CASE WHEN l.chko = 'TRUE' THEN 'O'
                 WHEN l.chka = 'TRUE' THEN 'A'
                 WHEN l.chkb = 'TRUE' THEN 'B'
                 WHEN l.chkab = 'TRUE' THEN 'AB' ELSE '.' END ||''||
            CASE WHEN l.rbrhpositivo ='TRUE' THEN '+'
                 WHEN l.rbrhnegativo = 'TRUE' THEN '-' END AS Grupoyfactor,
            CASE
                WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A'
                    THEN 'Huamachuco'
                ELSE (
                    SELECT nombre_sede
                    FROM sede
                    WHERE cod_sede = n.cod_sede
                )
                END AS nombre_sede,
            CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
            n.color,
            obtener_name_jasper(p_norden, name_service)
        FROM datos_paciente AS d
                 INNER JOIN n_orden_ocupacional AS n
                            ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal AS sm
                            ON n.cod_sede = sm.id
                 LEFT JOIN lab_clinico AS l
                            ON l.n_orden = n.n_orden
                 LEFT JOIN triaje  AS t
                            ON t.n_orden = n.n_orden
        WHERE n.n_orden = p_norden;

END;
$$;

alter function obtener_datos_generales(integer, text) owner to pierola;



create function obetner_reporte_espirometria(p_norden integer)
    returns TABLE(nombres text, edad text, cod_abs integer, n_orden integer, fecha_examen date, cod_exam integer, fvc text, fev1 text, fev1fvc text, fef25_75 text, interpretacion text, fvc_teorico text, fev1_teorico text, talla text, peso text, usuario_firma text, dnipaciente integer, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, contrata text, empresa text, codigoclinica text, tipoexamen text, departamento text, provincia text, distrito text, edadpaciente text)
    language plpgsql
as
$$
BEGIN
  RETURN QUERY
  SELECT 
  dp.nombres_pa || ' ' || dp.apellidos_pa,
  CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),    
  fbs.cod_abs  ,
  fbs.n_orden ,
  fbs.fecha_abs ,
  fbs.cod_exam ,
  fbs.fvc ,
  fbs.fev1 ,
  fbs.fev1fvc ,
  fbs.fef25_75 ,
  fbs.interpretacion ,
  fbs.fvc_teorico ,
  fbs.fev1_teorico ,
  trj.talla ,
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
  CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT)
  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN funcion_abs fbs ON fbs.n_orden = noo.n_orden
  INNER JOIN triaje trj ON noo.n_orden = trj.n_orden
  WHERE noo.n_orden = p_norden;
END;
$$;

alter function obetner_reporte_espirometria(integer) owner to pierola;



create function obtener_reporte_anexo2_completo(p_norden integer, name_service text)
    returns TABLE(telefonotrabajopaciente_tel_trabajo_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, dni_cod_pa integer, sexo_sexo_pa "char", direccionpaciente_direccion_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, lugarnacpaciente_lugar_nac_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiospaciente_nivel_est_pa text, departamentopaciente_departamento_pa text, provinciapaciente_provincia_pa text, distritopaciente_distrito_pa text, emailpaciente_email_pa text, nombres_nombres_pa text, apellidos_apellidos_pa text, edad_fecha_nacimiento_pa text, cargo_cargo_de text, empresa_razon_empresa text, explotacion_nom_ex text, altura_altura_po text, contrata_razon_contrata text, norden_n_orden integer, fechaapertura_fecha_apertura_po date, mineral_mineral_po text, color_color integer, gruposanguineoprevio_grupofactorsan text, area_area_o text, nombreexamen_nom_examen text, fechaanexo_fecha date, codigoanexo_cod_anexo integer, neoplasia_chkneoplasia boolean, neoplasiadescripcion_txtneoplasia text, its_chkits boolean, itsdescripcion_txtits text, quemaduras_chkquemaduras boolean, quemadurasdescripcion_txtquemaduras text, cirugias_chkcirugias boolean, cirugiasdescripcion_txtcirugias text, antecedentespersonalesotros_chkapotros boolean, antecedentespersonalesotrosdescripcion_txtotrosantecendetes text, residenciasi_chkresidenciasi boolean, residenciano_chkresidenciano boolean, residenciatiempo_txttiemporesidencia text, essalud_chkessalud boolean, eps_chkeps boolean, residenciatrabajootros_chkotros boolean, sctr_chksctr boolean, sctrotros_chkotros1 boolean, padre_txtpadre text, madre_txtmadre text, hermanos_txthermanos text, esposa_txtesposa text, totalhijos_txttotalhijos text, numerodependientes_txtndependientes text, puestoactual_txtpuestoactual text, tiempo_txttiempo text, medicamentossi_rbsimed boolean, medicamentosno_rbnomed boolean, tipomedicamento_txttipomedicamento text, frecuenciamedicamentos_txtfrecuenciamed text, cabeza_txtpelo text, nariz_txtnariz text, cuello_txtcuello text, perimetro_txtperimetro text, boca_txtboca text, oidos_txtoidos text, faringe_txtfaringe text, miembrossuperiores_txtmiembrossuperiores text, miembrosinferiores_txtmiembrosinferiores text, ectoscopia_txtectoscopia text, estadomental_txtestadomental text, anamnesis_txtanamnesis text, marcha_txtmarcha text, columnavertebral_txtcolumnavertebral text, aparatorespiratorio_txtaparatorespiratorio text, aparatocardiovascular_txtaparatocardiovascular text, aparatodigestivo_txtaparatodigestivo text, aparatogeiotourinario_txtaparatogeiotourinario text, aparatolocomotor_txtaparatolocomotor text, sistemalinfatico_txtsistemalinfatico text, piel_txtpiel text, observacionesfichamedica_txtobservacionesfm text, conclusion_txtconclusion text, enfermedadesocularesotros_txtenfermedadesoculares1 text, sistemanervioso_sistemanervioso text, otrosexamenes_txtotrosex text, restricciones_txtrestricciones text, esapto_apto_si boolean, noesapto_apto_no boolean, aptorestriccion_apto_re boolean, fechadesde_fechadesde date, fechahasta_fechahasta date, medico_medico text, hijosvivosanexo2_txthijosvivos text, hijosmuertosanexo2_txthijosmuertos text, fvc_fvc text, fev1_fev1 text, fev1fvc_fev1fvc text, fef2575_fef25_75 text, interpretacion_interpretacion text, perimetrocuello_perimetro_cuello text, imc_imc text, peso_peso text, talla_talla text, cintura_cintura text, cadera_cadera text, icc_icc text, temperatura_temperatura text, frespiratoria_f_respiratoria text, fcardiaca_f_cardiaca text, sat02_sat_02 text, sistolica_sistolica text, diastolica_diastolica text, codigoantecedentespatologicos_cod_ap integer, fechaantecedentes_fecha_ap date, hijosvivosantecedentespatologicos_txtvhijosvivos text, hijosfallecidosantecedentespatologicos_txtvhijosfallecidos text, hijasvivasantecedentespatologicos_txtdhijosvivos text, hijasfallecidasantecedentespatologicos_txtdhijosfallecidos text, padreantecedentespatologicos_padre_detall text, madreantecedentespatologicos_madre_detall text, hermanosantecedentespatologicos_hermanos_detall text, hijosantecedentespatologicos_hijos_detall text, esposaantecedentespatologicos_espos_cony_detall text, alergias boolean, asma boolean, bronquitis boolean, tbc boolean, convulsiones boolean, intoxicaciones boolean, hepatitis boolean, tifoidea boolean, hta boolean, diabetes boolean, alcohol boolean, tabaco boolean, drogas boolean, alcoholtipo text, tabacotipo text, drogastipo text, alcoholfrecuencia text, drogasfrecuencia text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, visioncolores_v_colores text, visionbinocular_v_binocular text, reflejospupilares_r_pupilares text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, odcc_odcc text, oicc_oicc text, odlc_odlc text, oilc_oilc text, vc_vc text, vb_vb text, rp_rp text, ausentes_txtausentes integer, piezasmalestado_txtpiezasmalestado integer, observacionesodonto_txtobservaciones text, oidoderecho500_o_d_500 text, oidoderecho1000_o_d_1000 text, oidoderecho2000_o_d_2000 text, oidoderecho3000_o_d_3000 text, oidoderecho4000_o_d_4000 text, oidoderecho6000_o_d_6000 text, oidoderecho8000_o_d_8000 text, oidoizquierdo500_o_i_500 text, oidoizquierdo1000_o_i_1000 text, oidoizquierdo2000_o_i_2000 text, oidoizquierdo3000_o_i_3000 text, oidoizquierdo4000_o_i_4000 text, oidoizquierdo6000_o_i_6000 text, oidoizquierdo8000_o_i_8000 text, diagnosticoaudiometria_diagnostico text, recomendacionesinfopsicologico_recomendaciones text, conclusionesradiograficas_txtconclusionesradiograficas text, verticesradiografiatorax_txtvertices text, hilosradiografiatorax_txthilios text, senoscostofrenicos_txtsenoscostofrenicos text, meadiastinos_txtmediastinos text, siluetacardiovascular_txtsiluetacardiovascular text, osteomuscular_txtosteomuscular text, observacionesradiografiatorax_txtobservacionesrt text, campospulmones_txtcampospulm text, observacioneslabclinico_txtobservacioneslb text, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, glucosa_txtglucosabio text, vsg_txtvsg text, cocaina_txtcocaina text, marihuana_txtmarihuana text, creatina_txtcreatininabio text, grupofactornuevo_grupo_factor_nuevo text, colesterol_txtcolesterol text, ldlcolesterol_txtldlcolesterol text, hdlcolesterol_txthdlcolesterol text, vldlcolesterol_txtvldlcolesterol text, trigliseridos_txttrigliseridos text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, informacionesgeneralradiografia_info_general text, conclusionesradiografia_conclu text, examenradiograficossanguineos_txtobservacionesrs text, usuariofirma text, sede text, nombresede text, namejasper text, conclusionmusculoesqueletica text, observacionesconduccioncertificado_conduccion text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
	SELECT 
	    -- 📌 datos_paciente (d)
	    d.tel_trabajo_pa, d.tel_casa_pa, d.cel_pa, d.cod_pa, 
	    d.sexo_pa, d.direccion_pa, d.fecha_nacimiento_pa, d.lugar_nac_pa, 
	    d.estado_civil_pa, d.nivel_est_pa, d.departamento_pa, d.provincia_pa, 
	    d.distrito_pa, d.email_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),

	    -- 📌 n_orden_ocupacional (n)
	    n.cargo_de, n.razon_empresa, n.nom_ex, n.altura_po, 
	    n.razon_contrata, n.n_orden, n.fecha_apertura_po, n.mineral_po, 
	    n.color,
	    --nuevo
	    n.grupofactorsan, n.area_o,

	    -- 📌 examen_medico_ocupacional (e)
	    e.nom_examen,
	    
	    -- 📌 anexo_agroindustrial (a)
	    a.fecha, 
		a.cod_anexo,
		a.chkneoplasia, a.txtneoplasia,
		a.chkits, a.txtits,
		a.chkquemaduras, a.txtquemaduras,
		a.chkcirugias, a.txtcirugias,
		a.chkapotros, a.txtotrosantecendetes,
		a.chkresidenciasi, a.chkresidenciano, a.txttiemporesidencia,
		a.chkessalud, a.chkeps, a.chkotros, a.chksctr, a.chkotros1,
		a.txtpadre, a.txtmadre, a.txthermanos, a.txtesposa,
		a.txttotalhijos, a.txtndependientes,
		a.txtpuestoactual, a.txttiempo,
		a.rbsimed, a.rbnomed, a.txttipomedicamento, a.txtfrecuenciamed,
		a.txtpelo, a.txtnariz, a.txtcuello, a.txtperimetro,
		a.txtboca, a.txtoidos, a.txtfaringe,
		a.txtmiembrossuperiores, a.txtmiembrosinferiores, a.txtectoscopia,
		a.txtestadomental, a.txtanamnesis, a.txtmarcha, a.txtcolumnavertebral,
		a.txtaparatorespiratorio, a.txtaparatocardiovascular, a.txtaparatodigestivo,
		a.txtaparatogeiotourinario, a.txtaparatolocomotor, a.txtsistemalinfatico,
		a.txtpiel, a.txtobservacionesfm,
		a.txtconclusion, a.txtenfermedadesoculares1, a.sistemanervioso,
		a.txtotrosex, a.txtrestricciones,
		a.apto_si, a.apto_no, a.apto_re,
		a.fechadesde, a.fechahasta, a.medico, a.txthijosvivos, a.txthijosmuertos,

	    -- 📌 funcion_abs (f)
	    f.fvc, f.fev1, f.fev1fvc, f.fef25_75, f.interpretacion,

	    -- 📌 triaje (t)
	    t.perimetro_cuello, t.imc, t.peso, t.talla, t.cintura, t.cadera, t.icc,
	    t.temperatura, t.f_respiratoria, t.f_cardiaca, t.sat_02, 
	    t.sistolica, t.diastolica,

	    -- 📌 antecedentes_patologicos (ap)
	    ap.cod_ap, ap.fecha_ap,
	    ap.txtvhijosvivos,    ap.txtvhijosfallecidos, ap.txtdhijosvivos, ap.txtdhijosfallecidos,
	    ap.padre_detall, ap.madre_detall,
	    ap.hermanos_detall, ap.hijos_detall, ap.espos_cony_detall,
        ap.chk1, ap.chk4, ap.chk7, ap.chk55, ap.chk15, ap.chk29, ap.chk25,
        ap.chk18, ap.chk27, ap.chk11, 
        ap.rblicorsi, ap.rbfumarsi, ap.rbdrogassi,
        ap.txtlicortipofrecuente, ap.txtncigarrillos, ap.txtdrogastipo, 
        ap.txtlicorfrecuencia, ap.txtdrogasfrecuencia,
        

	    -- 📌 oftalmologia (o) 
	    o.v_cerca_s_od, o.v_cerca_s_oi,
	    o.v_cerca_c_od, o.v_cerca_c_oi,
	    o.v_lejos_s_od, o.v_lejos_s_oi,
	    o.v_lejos_c_od, o.v_lejos_c_oi,
	    o.v_colores, o.v_binocular, o.r_pupilares,
	    o.e_oculares, o.e_oculares1,

	    -- 📌 oftalmologia_lo (ol)
	    CASE  WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od  ELSE ol.v_cerca_c_od  END as ODCC,
	    CASE  WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi  ELSE ol.v_cerca_c_oi  END as OICC,
	    CASE  WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  ELSE ol.v_lejos_c_od  END as ODLC,
	    CASE  WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  ELSE ol.v_lejos_c_oi  END as OILC,
	    CASE  WHEN ol.v_colores IS NULL THEN o.v_colores  ELSE ol.v_colores  END as VC,
	    CASE  WHEN ol.v_binocular IS NULL THEN o.v_binocular  ELSE ol.v_binocular  END as VB,
	    CASE  WHEN ol.r_pupilares IS NULL THEN o.r_pupilares  ELSE ol.r_pupilares  END as RP,

	    -- 📌 odontograma (od)
	    od.txtausentes, od.txtpiezasmalestado, od.txtobservaciones,

	    -- 📌 audiometria_po (m)
	    m.o_d_500, m.o_d_1000, m.o_d_2000, m.o_d_3000, m.o_d_4000, 
	    m.o_d_6000, m.o_d_8000, m.o_i_500, m.o_i_1000, m.o_i_2000, 
	    m.o_i_3000, m.o_i_4000, m.o_i_6000, m.o_i_8000, m.diagnostico,

	    -- 📌 informe_psicologico (ip)
	    ip.recomendaciones,

	    -- 📌 radiografia_torax (r) 
	    r.txtconclusionesradiograficas, r.txtvertices,r.txthilios,
	    r.txtsenoscostofrenicos, r.txtmediastinos, r.txtsiluetacardiovascular, r.txtosteomuscular,
	    r.txtobservacionesrt, r.txtcampospulm,

	    -- 📌 laboratorio clinico (la)
	    la.txtobservacioneslb,
	    --nuevo
	    la.chko, la.chka , la.chkb , la.chkab,la.rbrhpositivo, la.rbrhnegativo, la.txthemoglobina,
	    la.txtglucosabio, la.txtvsg, la.txtcocaina, la.txtmarihuana, la.txtcreatininabio,
	    CASE WHEN la.chko = 'TRUE' THEN 'O' WHEN la.chka = 'TRUE' THEN 'A' WHEN la.chkb = 'TRUE' THEN 'B' WHEN la.chkab = 'TRUE' THEN 'AB' ELSE '.' END ||''||
	    CASE WHEN la.rbrhpositivo ='TRUE' THEN '+' WHEN la.rbrhnegativo = 'TRUE' THEN '-' END AS grupo_factor_nuevo,

	    -- 📌 analisis_bioquimicos (ab)
	    ab.txtcolesterol, ab.txtldlcolesterol, ab.txthdlcolesterol, ab.txtvldlcolesterol,
	    ab.txttrigliseridos,

	    -- 📌 informe_electrocardiograma (ie)
	    ie.hallazgo, ie.recomendaciones,

	    -- 📌 radiografia (ra) nuevo
	    ra.info_general, ra.conclu,

	    -- 📌 ex_radiograficos_sanguineos (e)
	    ersa.txtobservacionesrs,
	    a.usuario_firma,

	    -- 📌 sede
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    CASE
		    WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
		    WHEN n.cod_sede = 1 THEN 'Trujillo'
		    WHEN n.cod_sede = 2 THEN 'Huamachuco'
		    WHEN n.cod_sede = 3 THEN 'Huancayo'
		    WHEN n.cod_sede = 4 THEN 'Trujillo'
	    END AS nombreSede,

	    -- 📌 nombre jasper
	    obtener_name_jasper(p_norden, name_service),
        CASE WHEN eme.n_orden IS NULL THEN eme21.txtconclusiones ELSE eme.txtdiagnostico END,
        bc.b_c_observaciones AS conduccion
	FROM n_orden_ocupacional AS n
	INNER JOIN datos_paciente AS d ON n.cod_pa = d.cod_pa
	INNER JOIN sede_multisucursal AS sm ON n.cod_sede = sm.id
	LEFT JOIN examen_medico_ocupacional AS e ON e.nom_examen = n.nom_examen
	LEFT JOIN anexo_agroindustrial AS a ON a.n_orden = n.n_orden
	LEFT JOIN triaje AS t ON t.n_orden = n.n_orden
	LEFT JOIN oftalmologia AS o ON o.n_orden = n.n_orden
	LEFT JOIN oftalmologia_lo AS ol ON ol.n_orden = n.n_orden
	LEFT JOIN funcion_abs AS f ON f.n_orden = n.n_orden
	LEFT JOIN odontograma AS od ON od.n_orden = n.n_orden
	LEFT JOIN antecedentes_patologicos AS ap ON ap.n_orden = n.n_orden
	LEFT JOIN audiometria_po AS m ON m.n_orden = n.n_orden
	LEFT JOIN informe_psicologico AS ip ON ip.n_orden = n.n_orden
	LEFT JOIN radiografia_torax AS r ON r.n_orden = n.n_orden
	LEFT JOIN lab_clinico AS la ON la.n_orden = n.n_orden
	LEFT JOIN analisis_bioquimicos AS ab ON ab.n_orden = n.n_orden
	LEFT JOIN informe_electrocardiograma AS ie ON ie.n_orden = n.n_orden
	LEFT JOIN radiografia AS ra on ra.n_orden = n.n_orden
	LEFT JOIN ex_radiograficos_sanguineos AS ersa ON(n.n_orden = ersa.n_orden)
    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON (n.n_orden = eme.n_orden)
    LEFT JOIN evaluacion_musculo_esqueletica2021 AS eme21 ON (n.n_orden = eme21.n_orden)
    LEFT JOIN b_certificado_conduccion AS bc ON (bc.n_orden = n.n_orden)
	WHERE n.n_orden = p_norden;
END;
$$;

alter function obtener_reporte_anexo2_completo(integer, text) owner to pierola;


create function editar_anexo7c(p_norden integer)
    returns TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiopaciente_nivel_est_pa text, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, areaocupacional_area_o text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, detallehijosvivosantecedentes_txtdhijosvivos text, detallehijosfallecidosantecedentes_txtdhijosfallecidos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, visionbinocular_v_binocular text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, vc_vc text, rp_rp text, enfermedadesocularesvisionlejos_e_oculvisionlejos text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, observacionesradiografiatorax_txtobservacionesrt text, observacioneslaboratorioclinico_txtobservacioneslb text, examenradiograficossanguineos_txtobservacionesrs text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, creatininalaboratorioclinico_txtcreatininabio text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, fechaanexo7c_fecha date, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageograficaanexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, reubicacionsianexo7c_tbrsi boolean, reubicacionnoanexo7c_rbrno boolean, tabaconadaaexo7c_chktnada boolean, tabacopocoanexo7c_chktpoco boolean, tabacohabitualanexo7c_chkthabitual boolean, tabacoexcesivoanexo7c_chktexcesivo boolean, alcoholnadaanexo7c_chkanada boolean, alcoholpocoanexo7c_chkapoco boolean, alcoholhabitualanexo7c_chkahabitual boolean, alcoholexcesivoanexo7c_chkaexcesivo boolean, drogasnadaanexo7c_chkdnada boolean, drogaspocoanexo7c_chkdpoco boolean, drogashabitualanexo7c_chkdhabitual boolean, drogasexcesivoanexo7c_chkdexcesivo boolean, puestoactualanexo7c_txtpuestoactual text, tiempoanexo7c_txttiempo text, antecedentespersonalesanexo7c_txtantecedentespersonales text, antecedentespersonales2anexo7c_txtantecedentespersonales2 text, antecedentesfamiliaresanexo7c_txtantecedentesfamiliares text, cabezaanexo7c_txtcabeza text, narizanexo7c_txtnariz text, cuelloanexo7c_txtcuello text, perimetroanexo7c_txtperimetro text, baflanexo7c_txtb_a_f_l text, visioncoloresanexo7c_txtvisioncolores text, enfermedadesocularesanexo7c_txtenfermedadesoculares text, diagnosticoaudioanexo7c_txtdiagnosticoaudio text, enfermedadesoculares2anexo7c_txtenfermedadesoculares2 text, reflejospupilaresanexo7c_txtreflejospupilares text, binocularanexo7c_txtbinocular text, odanexo7c_txtod text, oianexo7c_txtoi text, toraxanexo7c_txttorax text, corazonanexo7c_txtcorazon text, pulmonesnormalanexo7c_rbnormal boolean, pulmonesanormalanexo7c_rbanormal boolean, pulmonesdescripcionanexo7c_txtpulmones text, miembrossuperioresanexo7c_txtmiembrossuperiores text, miembrosinferioresanexo7c_txtmiembrosinferiores text, reflejososteotendinososanexo7c_txtreflejososteotendinosos text, marchaanexo7c_txtmarcha text, columnavertebralanexo7c_txtcolumnavertebral text, abdomenanexo7c_txtabdomen text, anillosinguinalesanexo7c_txtanillosinguinales text, organosgenitalesanexo7c_txtorganosgenitales text, tactorectalnohizoanexo7c_rbtnohizo boolean, tactorectalnormalanexo7c_rbtnormal boolean, tactorectalanormalanexo7c_rbtanormal boolean, describirobservacionanexo7c_chkdescribirobservacion boolean, herniasanexo7c_txthernias text, varicesanexo7c_txtvarices text, gangliosanexo7c_txtganglios text, lenguageanexo7c_txtlenguage text, observacionesfichamedicaanexo7c_txtobservacionesfm text, conclusionanexo7c_txtconclusion text, tetanoanexo7c_tetano boolean, hepatitisbanexo7c_hepatitisb boolean, fiebreamarillaanexo7c_fiebreamarilla boolean, diagnosticoaudio2anexo7c_txtdiagnosticoaudio text, conclusionmedicoanexo7c_txtconclusionmed text, estadomentalanexo7c_txtestadomental text, anamnesisanexo7c_txtanamnesis text, antecedentespatologicos_ante_patologicos text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, campospulmonesradiografiatorax_txtcampospulm text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, norden_n_orden integer, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, codigoanexo7c_cod_anexo integer, pielanexo7c_piel boolean, pieldescripcionanexo7c_piel_descripcion text, usuariofirma text, conclusionmusculoesqueletica text, observacionesconduccioncertificado_conduccion text, conclusionradiografia_conclu text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
	SELECT 
	    d.cod_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    d.fecha_nacimiento_pa,
	    d.sexo_pa,
	    d.lugar_nac_pa,
	    d.direccion_pa,
	    d.tel_casa_pa,
	    d.cel_pa,
	    d.estado_civil_pa,
	    d.nivel_est_pa,
	    n.razon_empresa,
	    n.razon_contrata,
	    n.nom_examen,
	    n.nom_ex,
	    n.altura_po,
	    n.mineral_po,
	    n.cargo_de,
	    n.area_o,
	    ap.txtvhijosvivos,
	    ap.txtvhijosfallecidos,
	    ap.txtdhijosvivos,
	    ap.txtdhijosfallecidos,
	    triaje.talla,
	    triaje.peso,
	    triaje.imc,
	    triaje.sistolica,
	    triaje.diastolica,
	    triaje.f_respiratoria,
	    triaje.f_cardiaca,
	    triaje.sat_02,
	    triaje.temperatura,
	    triaje.cintura,
	    triaje.cadera,
	    triaje.icc,
	    triaje.perimetro_cuello,
-- 	    o.v_cerca_s_od,
-- 	    o.v_cerca_s_oi,
-- 	    o.v_cerca_c_od,
-- 	    o.v_cerca_c_oi,
-- 	    o.v_lejos_s_od,
-- 	    o.v_lejos_s_oi,
-- 	    o.v_lejos_c_od,
-- 	    o.v_lejos_c_oi,
-- 	    o.v_binocular,
-- 	    o.e_oculares,
-- 	    o.e_oculares1,
	    CASE WHEN oft.txtcercasincorregirod is not null THEN oft.txtcercasincorregirod else o.v_cerca_s_od end as v_cerca_s_od,
	    CASE WHEN oft.txtcercasincorregiroi is not null THEN oft.txtcercasincorregiroi else o.v_cerca_s_oi end as v_cerca_s_oi,
	    CASE WHEN oft.txtcercacorregidaod is not null THEN oft.txtcercacorregidaod
		 WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od
		 else ol.v_cerca_c_od end as ODCC,
	    CASE WHEN oft.txtcercacorregidaoi is not null THEN oft.txtcercacorregidaoi
		 WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi
		 else ol.v_cerca_c_oi end as OICC,
	    CASE WHEN oft.txtlejossincorregirod is not null THEN oft.txtlejossincorregirod else o.v_lejos_s_od end as v_lejos_s_od,
	    CASE WHEN oft.txtlejossincorregiroi is not null THEN oft.txtlejossincorregiroi else o.v_lejos_s_oi end as v_lejos_s_oi,
	    CASE WHEN oft.txtlejoscorregidaod is not null THEN oft.txtlejoscorregidaod
		 WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  ELSE ol.v_lejos_c_od  END as ODLC,
	    CASE WHEN oft.txtlejoscorregidaoi is not null THEN oft.txtlejoscorregidaoi
		 WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  ELSE ol.v_lejos_c_oi  END as OILC,
	    CASE WHEN oft.txtbinocularsincorregir IS not NULL THEN oft.txtbinocularsincorregir
		 WHEN ol.v_binocular IS NULL THEN o.v_binocular
		 ELSE ol.v_binocular  END as VB,
	    CASE WHEN oft.txtdiagnostico IS not NULL THEN oft.txtdiagnostico  else o.e_oculares end as e_oculares,
	    o.e_oculares1,
	    CASE WHEN ol.v_colores IS NULL THEN o.v_colores  ELSE ol.v_colores  END as VC,
	    CASE WHEN ol.r_pupilares IS NULL THEN o.r_pupilares  ELSE ol.r_pupilares  END as RP,
	    o.e_oculvisionlejos, 
	    odontograma.txtausentes,
	    odontograma.txtobservaciones,
	    odontograma.txtpiezasmalestado,
	    r.txtobservacionesrt,
	    l.txtobservacioneslb,
	    e.txtobservacionesrs,
	    l.txtglucosabio,
	    l.txtvsg,
	    l.txtcocaina,
	    l.txtmarihuana,
	    l.txtcreatininabio,
	    ----------------------------------------------------------------------------

	    CASE WHEN  au.o_d_500 is not null THEN au.o_d_500
		     WHEN  a25.o_d_500 is not null THEN a25.o_d_500 else m.o_d_500 end as o_d_500 ,
		CASE WHEN au.o_d_1000 is not null THEN au.o_d_1000
		     WHEN a25.o_d_1000 is not null THEN a25.o_d_1000 else m.o_d_1000 end as o_d_1000 ,
		CASE WHEN au.o_d_2000 is not null THEN au.o_d_2000
		     WHEN  a25.o_d_2000 is not null THEN a25.o_d_2000 else m.o_d_2000 end as o_d_2000 ,
		CASE WHEN au.o_d_3000 is not null THEN au.o_d_3000
		     WHEN  a25.o_d_3000 is not null THEN a25.o_d_3000 else m.o_d_3000 end as o_d_3000 ,
		CASE WHEN au.o_d_4000 is not null THEN au.o_d_4000
		     WHEN  a25.o_d_4000 is not null THEN a25.o_d_4000 else m.o_d_4000 end as o_d_4000 ,
		CASE WHEN au.o_d_6000 is not null THEN au.o_d_6000
		     WHEN  a25.o_d_6000 is not null THEN a25.o_d_6000 else m.o_d_6000 end as o_d_6000 ,
		CASE WHEN au.o_d_8000 is not null THEN au.o_d_8000
		     WHEN  a25.o_d_8000 is not null THEN a25.o_d_8000 else m.o_d_8000 end as o_d_8000 ,
		CASE WHEN au.o_i_500 is not null THEN au.o_i_500
		     WHEN a25.o_i_500 is not null THEN a25.o_i_500 else m.o_i_500 end as o_i_500 ,
		CASE WHEN au.o_i_1000 is not null THEN au.o_i_1000
		     WHEN a25.o_i_1000 is not null THEN a25.o_i_1000 else m.o_i_1000 end as o_i_1000 ,
		CASE WHEN au.o_i_2000 is not null THEN au.o_i_2000
		     WHEN a25.o_i_2000 is not null THEN a25.o_i_2000 else m.o_i_2000 end as o_i_2000 ,
		CASE WHEN au.o_i_3000 is not null THEN au.o_i_3000
		     WHEN a25.o_i_3000 is not null THEN a25.o_i_3000 else m.o_i_3000 end as o_i_3000 ,
		CASE WHEN au.o_i_4000 is not null THEN au.o_i_4000
		     WHEN a25.o_i_4000 is not null THEN a25.o_i_4000 else m.o_i_4000 end as o_i_4000 ,
		CASE WHEN au.o_i_6000 is not null THEN au.o_i_6000
		     WHEN a25.o_i_6000 is not null THEN a25.o_i_6000 else m.o_i_6000 end as o_i_6000 ,
		CASE WHEN au.o_i_8000 is not null THEN au.o_i_8000
		     WHEN a25.o_i_8000 is not null THEN a25.o_i_8000 else m.o_i_8000 end as o_i_8000 ,
		CASE WHEN m.diagnostico is null THEN '' else m.diagnostico end as diagnostico,


	    ----------------------------------------

	    au.chkdnormal,
	    au.chkdtaleveod,
	    au.chkdtaleveoi,
	    au.chkdtaavanzadood,
	    au.chkdtaavanzadooi,
	    au.chkdhrleveod,
	    au.chkdhrleveoi,
	    au.chkdhrmoderadood,
	    au.chkdhrmoderadooi,
	    au.chkdhravanzadaod,
	    au.chkdhravanzadaoi,
	    au.chkotrashipoacusias,
	    au.txtotrashipoacusias,

	    funcion_abs.fvc,
	    funcion_abs.fev1,
	    funcion_abs.fev1fvc,
	    funcion_abs.fef25_75,
	    funcion_abs.interpretacion,

	    a.fecha,
	    a.chkruido,
	a.chkpolvo,
	a.chkvidsegmentario,
	a.chkvidtotal,
	a.chkcancerigenos,
	a.chkmutagenicos,
	a.chksolventes,
	a.chkmetales,
	a.chktemperatura,
	a.chkbiologicos,
	a.chkposturas,
	a.chkturnos,
	a.chkcargas,
	a.chkmovrepet,
	a.chkpvd,
	a.electricos,
	a.vibraciones,
	a.chkotros,
	a.altura_estructura,
	a.altura_geog,
	a.quimicos,

	    -- CASE WHEN ap.ruido IS NULL THEN a.chkruido ELSE ap.ruido END,
-- 	    CASE WHEN ap.polvo IS NULL THEN a.chkpolvo ELSE ap.polvo END,
-- 	    CASE WHEN ap.vid_segmentario IS NULL THEN a.chkvidsegmentario ELSE ap.vid_segmentario END,
-- 	    CASE WHEN ap.vid_total IS NULL THEN a.chkvidtotal ELSE ap.vid_total END,
-- 	    CASE WHEN ap.cancerigenos IS NULL THEN a.chkcancerigenos ELSE ap.cancerigenos END,
-- 	    CASE WHEN ap.mutagenicos IS NULL THEN a.chkmutagenicos ELSE ap.mutagenicos END,
-- 	    CASE WHEN ap.solventes IS NULL THEN a.chksolventes ELSE ap.solventes END,
-- 	    CASE WHEN ap.metales IS NULL THEN a.chkmetales ELSE ap.metales END,
-- 	    CASE WHEN ap.temperatura IS NULL THEN a.chktemperatura ELSE ap.temperatura END,
-- 	    CASE WHEN ap.biologicos IS NULL THEN a.chkbiologicos ELSE ap.biologicos END,
-- 	    CASE WHEN ap.posturas IS NULL THEN a.chkposturas ELSE ap.posturas END,
-- 	    CASE WHEN ap.turnos IS NULL THEN a.chkturnos ELSE ap.turnos END,
-- 	    CASE WHEN ap.cargas IS NULL THEN a.chkcargas ELSE ap.cargas END,
-- 	    CASE WHEN ap.mov_repet IS NULL THEN a.chkmovrepet ELSE ap.mov_repet END,
-- 	    CASE WHEN ap.pvd IS NULL THEN a.chkpvd ELSE ap.pvd END,
-- 	    CASE WHEN ap.electricos IS NULL THEN a.electricos ELSE ap.electricos END,
-- 	    CASE WHEN ap.vibraciones IS NULL THEN a.vibraciones ELSE ap.vibraciones END,
-- 	    CASE WHEN ap.otros IS NULL THEN a.chkotros ELSE ap.otros END,
-- 	    CASE WHEN ap.altura_estructura IS NULL THEN a.altura_estructura ELSE ap.altura_estructura END,
-- 	    CASE WHEN ap.altura_geografica IS NULL THEN a.altura_geog ELSE ap.altura_geografica END,
-- 	    CASE WHEN ap.quimicos IS NULL THEN a.quimicos ELSE ap.quimicos END,
	    a.tbrsi,
	    a.rbrno,
	    a.chktnada,
	    a.chktpoco,
	    a.chkthabitual,
	    a.chktexcesivo,
	    a.chkanada,
	    a.chkapoco,
	    a.chkahabitual,
	    a.chkaexcesivo,
	    a.chkdnada,
	    a.chkdpoco,
	    a.chkdhabitual,
	    a.chkdexcesivo,
	    a.txtpuestoactual,
	    a.txttiempo,
	    a.txtantecedentespersonales,
	    a.txtantecedentespersonales2,
	    a.txtantecedentesfamiliares,
	    a.txtcabeza,
	    a.txtnariz,
	    a.txtcuello,
	    a.txtperimetro,
	    a.txtb_a_f_l,
	    a.txtvisioncolores,
	    a.txtenfermedadesoculares,
	    a.txtdiagnosticoaudio,
	    a.txtenfermedadesoculares2,
	    a.txtreflejospupilares,
	    a.txtbinocular,
	    a.txtod,
	    a.txtoi,
	    a.txttorax,
	    a.txtcorazon,
	    a.rbnormal,
	    a.rbanormal,
	    a.txtpulmones,
	    a.txtmiembrossuperiores,
	    a.txtmiembrosinferiores,
	    a.txtreflejososteotendinosos,
	    a.txtmarcha,
	    a.txtcolumnavertebral,
	    a.txtabdomen,
	    a.txtanillosinguinales,
	    a.txtorganosgenitales,
	    a.rbtnohizo,
	    a.rbtnormal,
	    a.rbtanormal,
	    a.chkdescribirobservacion,
	    a.txthernias,
	    a.txtvarices,
	    a.txtganglios,
	    a.txtlenguage,
	    a.txtobservacionesfm,
	    a.txtconclusion,
	    a.tetano,
	    a.hepatitisb,
	    fiebreamarilla,
	    txtdiagnosticoaudio,
	    txtconclusionmed,
	    a.txtestadomental,
	    a.txtanamnesis,
	    CASE 
		WHEN (
		    CASE WHEN ap.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN ap.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN ap.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN ap.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN ap.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN ap.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN ap.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN ap.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN ap.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN ap.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN ap.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN ap.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN ap.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN ap.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN ap.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN ap.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN ap.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN ap.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN ap.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN ap.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN ap.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN ap.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN ap.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN ap.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN ap.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN ap.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN ap.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN ap.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN ap.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN ap.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN ap.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN ap.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN ap.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN ap.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN ap.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN ap.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN ap.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN ap.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN ap.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN ap.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN ap.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN ap.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN ap.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN ap.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN ap.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN ap.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN ap.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN ap.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN ap.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN ap.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN ap.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN ap.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN ap.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN ap.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN ap.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN ap.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN ap.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN ap.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN ap.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN ap.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN ap.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN ap.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN ap.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN ap.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN ap.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN ap.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN ap.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN ap.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN ap.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN ap.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		) = '' 
		THEN 'NINGUNO'
		ELSE (
		    CASE WHEN ap.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN ap.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN ap.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN ap.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN ap.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN ap.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN ap.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN ap.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN ap.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN ap.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN ap.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN ap.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN ap.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN ap.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN ap.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN ap.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN ap.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN ap.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN ap.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN ap.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN ap.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN ap.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN ap.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN ap.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN ap.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN ap.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN ap.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN ap.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN ap.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN ap.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN ap.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN ap.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN ap.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN ap.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN ap.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN ap.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN ap.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN ap.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN ap.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN ap.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN ap.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN ap.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN ap.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN ap.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN ap.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN ap.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN ap.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN ap.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN ap.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN ap.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN ap.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN ap.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN ap.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN ap.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN ap.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN ap.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN ap.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN ap.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN ap.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN ap.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN ap.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN ap.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN ap.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN ap.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN ap.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN ap.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN ap.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN ap.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN ap.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN ap.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN ap.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN ap.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN ap.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN ap.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN ap.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN ap.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN ap.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		)    
	    END AS ante_patologicos,
	    ----
	    l.chkpositivo,
	    l.chknegativo,
	    l.chko, 
	    l.chka, 
	    l.chkb, 
	    l.chkab,
	    l.rbrhpositivo, 
	    l.rbrhnegativo,
	    l.txthemoglobina,
	    -----
	    l.txtcoloref, 
	    l.txtdensidadef, 
	    l.txtaspectoef, 
	    l.txtphef, l.txtnitritoseq, 
	    l.txtproteinaseq, 
	    l.txtcetonaseq,
	    l.txtleucocitoseq, 
	    l.txturobilinogenoeq, 
	    l.txtbilirubinaeq, 
	    l.txtglucosaeq, 
	    l.txtsangreeq, 
	    l.txtleucocitossu,
	    l.txtcelepitelialessu, 
	    l.txtcilindiossu, 
	    l.txtbacteriassu, 
	    l.txthematiessu, 
	    l.txtcristalessu, 
	    l.txtpussu, 
	    l.txtotrossu,
	    ie.hallazgo, ie.recomendaciones,
	    r.txtvertices,
	    r.txthilios,
	    r.txtsenoscostofrenicos,
	    r.txtmediastinos,
	    r.txtsiluetacardiovascular,
	    r.txtosteomuscular,
	    r.txtconclusionesradiograficas,
	    r.txtcampospulm,
	    ab.txtcolesterol, ab.txtldlcolesterol, ab.txthdlcolesterol, ab.txtvldlcolesterol,
	    ab.txttrigliseridos,
	    n.n_orden,
	    e.cod_exra,
	    e.n_rx,
	    e.fecha_exra,
	    e.txtcalidad,
	    e.txtsimbolos,
	    e.ex_0,
	    e.ex_10,
	    e.ex_11,
	    e.ex_12,
	    e.ex_21,
	    e.ex_22,
	    e.ex_23,
	    e.ex_32,
	    e.ex_33,
	    e.ex_3mas,
	    e.ex_abc,
	    e.ex_st,
	    e.txtsinneumoconiosis,
	    e.txtconneumoconiosis,
	    e.txtirep,
	    e.txtotrosex,
	    e.apto_si,
	    e.apto_no,
	    e.apto_re,
	    a.cod_anexo,
	    a.piel,
	    a.piel_descripcion,
	    a.usuario_firma,
        CASE WHEN eme.n_orden IS NULL THEN eme21.txtconclusiones ELSE eme.txtdiagnostico END,
        bc.b_c_observaciones AS conduccion,
        ra.conclu
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n ON (d.cod_pa = n.cod_pa)
	INNER JOIN antecedentes_patologicos AS ap ON (n.n_orden = ap.n_orden)
	INNER JOIN triaje ON (n.n_orden = triaje.n_orden)
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	INNER JOIN funcion_abs ON (n.n_orden = funcion_abs.n_orden)
	INNER JOIN radiografia_torax AS r ON (n.n_orden = r.n_orden)
	INNER JOIN lab_clinico AS l ON (n.n_orden = l.n_orden)
	LEFT JOIN ex_radiograficos_sanguineos AS e ON (n.n_orden = e.n_orden)
	INNER JOIN odontograma ON (n.n_orden = odontograma.n_orden)
	LEFT JOIN audiometria_po AS m ON (n.n_orden = m.n_orden)
	INNER JOIN anexo7c AS a ON (n.n_orden = a.n_orden)
	LEFT JOIN audiometria_2021 AS au ON (n.n_orden = au.n_orden)
	LEFT JOIN audiometria_2023 AS a25 ON (n.n_orden = a25.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	LEFT JOIN informe_electrocardiograma AS ie ON (n.n_orden = ie.n_orden)
	LEFT JOIN analisis_bioquimicos AS ab ON (n.n_orden = ab.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (ol.n_orden = n.n_orden)
    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON (n.n_orden = eme.n_orden)
    LEFT JOIN evaluacion_musculo_esqueletica2021 AS eme21 ON (n.n_orden = eme21.n_orden)
    LEFT JOIN radiografia AS ra ON (ra.n_orden = n.n_orden)
    LEFT JOIN b_certificado_conduccion AS bc ON (bc.n_orden = n.n_orden)
	WHERE a.n_orden = p_norden;

END;
$$;

alter function editar_anexo7c(integer) owner to pierola;



create function obtener_anexo7c(p_norden integer)
    returns TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiospaciente_nivel_est_pa text, norden_n_orden integer, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, area_area_o text, grupofactorsanguineo_grupofactorsan text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, dhijosvivosantecedentes_txtdhijosvivos text, dhijosfallecidosantecedentes_txtdhijosfallecidos text, antecedentes_rbfumarsi boolean, antecedentes_rblicorsi boolean, antecedentespatologicos_ante_patologicos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, vc_vc text, visionbinocular_v_binocular text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, visionlejosoftalmo_e_oculvisionlejos text, diagnosticooftalmologia2021_txtdiagnostico text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, observacionesradiografiatorax_txtobservacionesrt text, campospulmonesradiografiatorax_txtcampospulm text, observacioneslaboratorioclinico_txtobservacioneslb text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, creatininalaboratorioclinico_txtcreatininabio text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, grupofactorsanguineolaboratorioclinico_grupofactor text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, ordenalturacertificado_ordenaltura integer, observacionesalturacertificado_alturabarrick text, ordenconduccioncertificado_ordencond integer, observacionesconduccioncertificado_conduccion text, numeroalturacertificacion_numalt integer, observacionesalturacertificacion_certialtura text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, infogeneralradiografia_info_general text, conclusionradiografia_conclu text, anamnesisagroindustrial_txtanamnesis text, estadomentalagroindustrial_txtestadomental text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageoganexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, conclusionmusculoesqueletica text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
	SELECT 
	    -- TABLA: datos_paciente (Prefijo: d)
	    d.cod_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    d.fecha_nacimiento_pa,
	    d.sexo_pa,
	    d.lugar_nac_pa,
	    d.direccion_pa,
	    d.tel_casa_pa,
	    d.cel_pa,
	    d.estado_civil_pa,
	    d.nivel_est_pa,
	    
	    -- TABLA: n_orden_ocupacional (Prefijo: n)
	    n.n_orden,
	    n.razon_empresa,
	    n.razon_contrata,
	    n.nom_examen,
	    n.nom_ex,
	    n.altura_po,
	    n.mineral_po,
	    n.cargo_de,
	    n.area_o,
	    n.grupofactorsan,
	    
	    -- TABLA: antecedentes_patologicos (Prefijo: a)
	    a.txtvhijosvivos,
	    a.txtvhijosfallecidos,
	    a.txtdhijosvivos,
	    a.txtdhijosfallecidos,
	    a.rbfumarsi,
	    a.rblicorsi,
	    CASE 
		WHEN (
		    CASE WHEN a.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN a.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN a.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN a.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN a.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN a.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN a.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN a.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN a.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN a.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN a.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN a.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN a.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN a.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN a.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN a.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN a.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN a.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN a.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN a.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN a.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN a.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN a.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN a.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN a.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN a.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN a.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN a.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN a.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN a.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN a.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN a.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN a.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN a.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN a.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN a.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN a.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN a.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN a.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN a.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN a.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN a.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN a.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN a.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN a.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN a.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN a.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN a.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN a.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN a.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN a.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN a.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN a.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN a.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN a.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN a.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN a.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN a.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN a.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN a.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN a.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN a.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN a.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN a.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN a.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN a.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN a.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN a.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN a.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN a.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN a.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN a.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN a.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN a.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN a.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN a.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN a.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN a.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN a.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		) = '' 
		THEN 'NINGUNO'
		ELSE (
		    CASE WHEN a.chk1 = 'TRUE' THEN 'Alergias, ' ELSE '' END ||
		    CASE WHEN a.chk2 = 'TRUE' THEN 'Amigdalitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk3 = 'TRUE' THEN 'Arritmias cardíacas, ' ELSE '' END ||
		    CASE WHEN a.chk4 = 'TRUE' THEN 'Asma, ' ELSE '' END ||
		    CASE WHEN a.chk5 = 'TRUE' THEN 'Bocio, ' ELSE '' END ||
		    CASE WHEN a.chk6 = 'TRUE' THEN 'Bronconeumonía, ' ELSE '' END ||
		    CASE WHEN a.chk7 = 'TRUE' THEN 'Bronquitis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk8 = 'TRUE' THEN 'Caries o gingivitis, ' ELSE '' END ||
		    CASE WHEN a.chk9 = 'TRUE' THEN 'Colecistitis, ' ELSE '' END ||
		    CASE WHEN a.chk10 = 'TRUE' THEN 'Dermatitis, ' ELSE '' END ||
		    CASE WHEN a.chk11 = 'TRUE' THEN 'Diabetes, ' ELSE '' END ||
		    CASE WHEN a.chk12 = 'TRUE' THEN 'Disentería, ' ELSE '' END ||
		    CASE WHEN a.chk13 = 'TRUE' THEN 'Enfermedades del corazón, ' ELSE '' END ||
		    CASE WHEN a.chk14 = 'TRUE' THEN 'Enfermedades oculares, ' ELSE '' END ||
		    CASE WHEN a.chk15 = 'TRUE' THEN 'Epilepsia o convulsiones, ' ELSE '' END ||
		    CASE WHEN a.chk16 = 'TRUE' THEN 'Faringitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk17 = 'TRUE' THEN 'Fiebre malta, ' ELSE '' END ||
		    CASE WHEN a.chk18 = 'TRUE' THEN 'Fiebre tifoidea, ' ELSE '' END ||
		    CASE WHEN a.chk19 = 'TRUE' THEN 'Fiebre reumática, ' ELSE '' END ||
		    CASE WHEN a.chk20 = 'TRUE' THEN 'Forunculosis, ' ELSE '' END ||
		    CASE WHEN a.chk21 = 'TRUE' THEN 'Gastritis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk22 = 'TRUE' THEN 'Gonorrea, ' ELSE '' END ||
		    CASE WHEN a.chk23 = 'TRUE' THEN 'Gota, ' ELSE '' END ||
		    CASE WHEN a.chk24 = 'TRUE' THEN 'Hemorroides, ' ELSE '' END ||
		    CASE WHEN a.chk25 = 'TRUE' THEN 'Hepatitis, ' ELSE '' END ||
		    CASE WHEN a.chk26 = 'TRUE' THEN 'Hernias, ' ELSE '' END ||
		    CASE WHEN a.chk27 = 'TRUE' THEN 'Hipertensión arterial, ' ELSE '' END ||
		    CASE WHEN a.chk28 = 'TRUE' THEN 'Infecciones urinarias repetidas, ' ELSE '' END ||
		    CASE WHEN a.chk29 = 'TRUE' THEN 'Intoxicaciones, ' ELSE '' END ||
		    CASE WHEN a.chk30 = 'TRUE' THEN 'Insuficiencia cardíaca, ' ELSE '' END ||
		    CASE WHEN a.chk31 = 'TRUE' THEN 'Insuficiencia coronaria crónica, ' ELSE '' END ||
		    CASE WHEN a.chk32 = 'TRUE' THEN 'Insuficiencia renal crónica, ' ELSE '' END ||
		    CASE WHEN a.chk33 = 'TRUE' THEN 'Litiasis urinaria, ' ELSE '' END ||
		    CASE WHEN a.chk34 = 'TRUE' THEN 'Meningitis, ' ELSE '' END ||
		    CASE WHEN a.chk35 = 'TRUE' THEN 'Neuritis a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk36 = 'TRUE' THEN 'Otitis media, ' ELSE '' END ||
		    CASE WHEN a.chk37 = 'TRUE' THEN 'Presión alta o baja, ' ELSE '' END ||
		    CASE WHEN a.chk38 = 'TRUE' THEN 'Paludismo o malaria, ' ELSE '' END ||
		    CASE WHEN a.chk39 = 'TRUE' THEN 'Parasitosis intestinal, ' ELSE '' END ||
		    CASE WHEN a.chk40 = 'TRUE' THEN 'Parotiditis, ' ELSE '' END ||
		    CASE WHEN a.chk41 = 'TRUE' THEN 'Pleuresia, ' ELSE '' END ||
		    CASE WHEN a.chk42 = 'TRUE' THEN 'Plumbismo, ' ELSE '' END ||
		    CASE WHEN a.chk43 = 'TRUE' THEN 'Poliomielitis, ' ELSE '' END ||
		    CASE WHEN a.chk44 = 'TRUE' THEN 'Portador de marcapasos, ' ELSE '' END ||
		    CASE WHEN a.chk45 = 'TRUE' THEN 'Prótesis cardíacas valvulares, ' ELSE '' END ||
		    CASE WHEN a.chk46 = 'TRUE' THEN 'Resfriados frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk47 = 'TRUE' THEN 'Reumatismo a repetición, ' ELSE '' END ||
		    CASE WHEN a.chk48 = 'TRUE' THEN 'Sarampión, ' ELSE '' END ||
		    CASE WHEN a.chk49 = 'TRUE' THEN 'Sífilis, ' ELSE '' END ||
		    CASE WHEN a.chk50 = 'TRUE' THEN 'Silicosis, ' ELSE '' END ||
		    CASE WHEN a.chk51 = 'TRUE' THEN 'Sinusitis crónica, ' ELSE '' END ||
		    CASE WHEN a.chk52 = 'TRUE' THEN 'Tos convulsiva, ' ELSE '' END ||
		    CASE WHEN a.chk53 = 'TRUE' THEN 'Trastornos nerviosos, ' ELSE '' END ||
		    CASE WHEN a.chk54 = 'TRUE' THEN 'Traumatismo encefalocraneano, ' ELSE '' END ||
		    CASE WHEN a.chk55 = 'TRUE' THEN 'Tuberculosis, ' ELSE '' END ||
		    CASE WHEN a.chk56 = 'TRUE' THEN 'Tumores - quistes, ' ELSE '' END ||
		    CASE WHEN a.chk57 = 'TRUE' THEN 'Úlcera péptica, ' ELSE '' END ||
		    CASE WHEN a.chk58 = 'TRUE' THEN 'Varicela, ' ELSE '' END ||
		    CASE WHEN a.chk59 = 'TRUE' THEN 'Várices, ' ELSE '' END ||
		    CASE WHEN a.chk60 = 'TRUE' THEN 'Varicocele, ' ELSE '' END ||
		    CASE WHEN a.chk61 = 'TRUE' THEN 'Pérdida de memoria, ' ELSE '' END ||
		    CASE WHEN a.chk62 = 'TRUE' THEN 'Preocupaciones o angustia, ' ELSE '' END ||
		    CASE WHEN a.chk63 = 'TRUE' THEN 'Dolores articulares y/o huesos, ' ELSE '' END ||
		    CASE WHEN a.chk64 = 'TRUE' THEN 'Aumento o disminución de peso, ' ELSE '' END ||
		    CASE WHEN a.chk65 = 'TRUE' THEN 'Dolor de cabeza, ' ELSE '' END ||
		    CASE WHEN a.chk66 = 'TRUE' THEN 'Diarrea, ' ELSE '' END ||
		    CASE WHEN a.chk67 = 'TRUE' THEN 'Agitación al hacer ejercicios, ' ELSE '' END ||
		    CASE WHEN a.chk68 = 'TRUE' THEN 'Dolor ocular, ' ELSE '' END ||
		    CASE WHEN a.chk69 = 'TRUE' THEN 'Dolor Opresivo Torax, ' ELSE '' END ||
		    CASE WHEN a.chk70 = 'TRUE' THEN 'Hinchazón de pies o manos, ' ELSE '' END ||
		    CASE WHEN a.chk71 = 'TRUE' THEN 'Estreñimiento, ' ELSE '' END ||
		    CASE WHEN a.chk72 = 'TRUE' THEN 'Vómitos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk73 = 'TRUE' THEN 'Sangrado por orina, ' ELSE '' END ||
		    CASE WHEN a.chk74 = 'TRUE' THEN 'Tos con sangre, ' ELSE '' END ||
		    CASE WHEN a.chk75 = 'TRUE' THEN 'Coloración amarilla de la piel, ' ELSE '' END ||
		    CASE WHEN a.chk76 = 'TRUE' THEN 'Indigestión frecuente, ' ELSE '' END ||
		    CASE WHEN a.chk77 = 'TRUE' THEN 'Insomnio, ' ELSE '' END ||
		    CASE WHEN a.chk78 = 'TRUE' THEN 'Lumbalgias o dolor de cintura, ' ELSE '' END ||
		    CASE WHEN a.chk79 = 'TRUE' THEN 'Mareos- Desmayos- Vertigos, ' ELSE '' END ||
		    CASE WHEN a.chk80 = 'TRUE' THEN 'Heces negras, ' ELSE '' END ||
		    CASE WHEN a.chk81 = 'TRUE' THEN 'Orina con dolor o ardor, ' ELSE '' END ||
		    CASE WHEN a.chk82 = 'TRUE' THEN 'Orina involuntaria, ' ELSE '' END ||
		    CASE WHEN a.chk83 = 'TRUE' THEN 'Dolor de oído, ' ELSE '' END ||
		    CASE WHEN a.chk84 = 'TRUE' THEN 'Secreciones por el oído, ' ELSE '' END ||
		    CASE WHEN a.chk85 = 'TRUE' THEN 'Palpitaciones, ' ELSE '' END ||
		    CASE WHEN a.chk86 = 'TRUE' THEN 'Adormecimientos, ' ELSE '' END ||
		    CASE WHEN a.chk87 = 'TRUE' THEN 'Pesadillas frecuentes, ' ELSE '' END ||
		    CASE WHEN a.chk88 = 'TRUE' THEN 'Dolores musculares, ' ELSE '' END ||
		    CASE WHEN a.chk89 = 'TRUE' THEN 'Tos crónica, ' ELSE '' END ||
		    CASE WHEN a.chk90 = 'TRUE' THEN 'Sangrado por encías' ELSE '' END
		)    
	    END AS ante_patologicos,
	    
	    -- TABLA: triaje (Prefijo: t)
	    t.talla,
	    t.peso,
	    t.imc,
	    t.sistolica,
	    t.diastolica,
	    t.f_respiratoria,
	    t.f_cardiaca,
	    t.sat_02,
	    t.temperatura,
	    t.cintura,
	    t.cadera,
	    t.icc,
	    t.perimetro_cuello,
	    
	    -- TABLA: oftalmologia (Prefijo: o)
	    CASE 
		WHEN oft.txtcercasincorregirod IS NOT NULL THEN oft.txtcercasincorregirod 
		ELSE o.v_cerca_s_od 
	    END AS v_cerca_s_od,
	    
	    CASE 
		WHEN oft.txtcercasincorregiroi IS NOT NULL THEN oft.txtcercasincorregiroi 
		ELSE o.v_cerca_s_oi 
	    END AS v_cerca_s_oi,
	    
	    CASE 
		WHEN oft.txtcercacorregidaod IS NOT NULL THEN oft.txtcercacorregidaod 
		WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od
		ELSE ol.v_cerca_c_od 
	    END AS ODCC,
	    
	    CASE 
		WHEN oft.txtcercacorregidaoi IS NOT NULL THEN oft.txtcercacorregidaoi 
		WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi
		ELSE ol.v_cerca_c_oi 
	    END AS OICC,
	    
	    CASE 
		WHEN oft.txtlejossincorregirod IS NOT NULL THEN oft.txtlejossincorregirod 
		ELSE o.v_lejos_s_od 
	    END AS v_lejos_s_od,
	    
	    CASE 
		WHEN oft.txtlejossincorregiroi IS NOT NULL THEN oft.txtlejossincorregiroi 
		ELSE o.v_lejos_s_oi 
	    END AS v_lejos_s_oi,
	    
	    CASE 
		WHEN oft.txtlejoscorregidaod IS NOT NULL THEN oft.txtlejoscorregidaod 
		WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  
		ELSE ol.v_lejos_c_od  
	    END AS ODLC, 
	    
	    CASE 
		WHEN oft.txtlejoscorregidaoi IS NOT NULL THEN oft.txtlejoscorregidaoi 
		WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  
		ELSE ol.v_lejos_c_oi  
	    END AS OILC,
	    
	    CASE  
		WHEN oft.rbtecishihara_normal = 'TRUE' THEN 'NORMAL'
		WHEN oft.rbtecishihara_anormal = 'TRUE' THEN 'ANORMAL'
		WHEN ol.v_colores IS NULL THEN o.v_colores  
		ELSE ol.v_colores  
	    END AS VC,
	    
	    CASE  
		WHEN oft.txtbinocularsincorregir IS NOT NULL THEN oft.txtbinocularsincorregir  
		WHEN ol.v_binocular IS NULL THEN o.v_binocular  
		ELSE ol.v_binocular 
	    END AS VB,
	    
	    CASE  
		WHEN oft.txtrp IS NOT NULL THEN oft.txtrp
		WHEN ol.r_pupilares IS NULL THEN o.r_pupilares
		ELSE ol.r_pupilares  
	    END AS RP,
	    
	    CASE  
		WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico  
		ELSE o.e_oculares 
	    END AS e_oculares,
	    o.e_oculares1,
	    o.e_oculvisionlejos,
	    
	    -- TABLA: oftalmologia2021 (Prefijo: oft)
	    oft.txtdiagnostico,
	    
	    -- TABLA: odontograma (Prefijo: od)
	    od.txtausentes,
	    od.txtobservaciones,
	    od.txtpiezasmalestado,
	    
	    -- TABLA: radiografia_torax (Prefijo: r)
	    r.txtvertices,
	    r.txthilios,
	    r.txtsenoscostofrenicos,
	    r.txtmediastinos,
	    r.txtsiluetacardiovascular,
	    r.txtosteomuscular,
	    r.txtconclusionesradiograficas,
	    r.txtobservacionesrt,
	    r.txtcampospulm,
	    
	    -- TABLA: lab_clinico (Prefijo: l)
	    l.txtobservacioneslb,
	    l.txtcocaina,
	    l.txtmarihuana,
	    l.txtglucosabio,
	    l.txtvsg,
	    l.txtcreatininabio,
	    ----
	    l.chkpositivo,
	    l.chknegativo,
	    l.chko, 
	    l.chka, 
	    l.chkb, 
	    l.chkab,
	    l.rbrhpositivo, 
	    l.rbrhnegativo,
	    l.txthemoglobina,
	    -----
	    l.txtcoloref, 
	    l.txtdensidadef, 
	    l.txtaspectoef, 
	    l.txtphef, l.txtnitritoseq, 
	    l.txtproteinaseq, 
	    l.txtcetonaseq,
	    l.txtleucocitoseq, 
	    l.txturobilinogenoeq, 
	    l.txtbilirubinaeq, 
	    l.txtglucosaeq, 
	    l.txtsangreeq, 
	    l.txtleucocitossu,
	    l.txtcelepitelialessu, 
	    l.txtcilindiossu, 
	    l.txtbacteriassu, 
	    l.txthematiessu, 
	    l.txtcristalessu, 
	    l.txtpussu, 
	    l.txtotrossu,
	    -- TABLA: lab_clinico - Grupo sanguíneo y factor RH (Prefijo: l)
	    CASE 
		WHEN l.chko = 'TRUE' THEN 'O'
		WHEN l.chka = 'TRUE' THEN 'A'
		WHEN l.chkb = 'TRUE' THEN 'B'
		WHEN l.chkab = 'TRUE' THEN 'AB'
		ELSE '.'
	    END || '' ||
	    CASE 
		WHEN l.rbrhpositivo = 'TRUE' THEN '+'
		WHEN l.rbrhnegativo = 'TRUE' THEN '-'
	    END AS Grupofactor,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 500Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_500 IS NOT NULL THEN au.o_d_500
		WHEN a25.o_d_500 IS NOT NULL THEN a25.o_d_500
		ELSE m.o_d_500
	    END AS o_d_500,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 1000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_1000 IS NOT NULL THEN au.o_d_1000
		WHEN a25.o_d_1000 IS NOT NULL THEN a25.o_d_1000
		ELSE m.o_d_1000
	    END AS o_d_1000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 2000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_2000 IS NOT NULL THEN au.o_d_2000
		WHEN a25.o_d_2000 IS NOT NULL THEN a25.o_d_2000
		ELSE m.o_d_2000
	    END AS o_d_2000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 3000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_3000 IS NOT NULL THEN au.o_d_3000
		WHEN a25.o_d_3000 IS NOT NULL THEN a25.o_d_3000
		ELSE m.o_d_3000
	    END AS o_d_3000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 4000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_4000 IS NOT NULL THEN au.o_d_4000
		WHEN a25.o_d_4000 IS NOT NULL THEN a25.o_d_4000
		ELSE m.o_d_4000
	    END AS o_d_4000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 6000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_6000 IS NOT NULL THEN au.o_d_6000
		WHEN a25.o_d_6000 IS NOT NULL THEN a25.o_d_6000
		ELSE m.o_d_6000
	    END AS o_d_6000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído derecho 8000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_d_8000 IS NOT NULL THEN au.o_d_8000
		WHEN a25.o_d_8000 IS NOT NULL THEN a25.o_d_8000
		ELSE m.o_d_8000
	    END AS o_d_8000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 500Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_500 IS NOT NULL THEN au.o_i_500
		WHEN a25.o_i_500 IS NOT NULL THEN a25.o_i_500
		ELSE m.o_i_500
	    END AS o_i_500,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 1000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_1000 IS NOT NULL THEN au.o_i_1000
		WHEN a25.o_i_1000 IS NOT NULL THEN a25.o_i_1000
		ELSE m.o_i_1000
	    END AS o_i_1000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 2000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_2000 IS NOT NULL THEN au.o_i_2000
		WHEN a25.o_i_2000 IS NOT NULL THEN a25.o_i_2000
		ELSE m.o_i_2000
	    END AS o_i_2000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 3000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_3000 IS NOT NULL THEN au.o_i_3000
		WHEN a25.o_i_3000 IS NOT NULL THEN a25.o_i_3000
		ELSE m.o_i_3000
	    END AS o_i_3000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 4000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_4000 IS NOT NULL THEN au.o_i_4000
		WHEN a25.o_i_4000 IS NOT NULL THEN a25.o_i_4000
		ELSE m.o_i_4000
	    END AS o_i_4000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 6000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_6000 IS NOT NULL THEN au.o_i_6000
		WHEN a25.o_i_6000 IS NOT NULL THEN a25.o_i_6000
		ELSE m.o_i_6000
	    END AS o_i_6000,
	    
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Oído izquierdo 8000Hz (Prefijos: au, a25, m)
	    CASE 
		WHEN au.o_i_8000 IS NOT NULL THEN au.o_i_8000
		WHEN a25.o_i_8000 IS NOT NULL THEN a25.o_i_8000
		ELSE m.o_i_8000
	    END AS o_i_8000,
	    ----
	    -- TABLA: audiometria_2021, audiometria_2023, audiometria_po - Diagnóstico audiométrico (Prefijos: au, a25, m)
	    CASE 
		WHEN au.chkdnormal = 'true' THEN 'NORMAL'
		WHEN au.chkdtaleveod = 'true' AND au.chkdtaleveoi = 'true' THEN 'TRAUMA ACÚSTICO BILATERAL LEVE'
		WHEN au.chkdtaleveod = 'true' THEN 'TRAUMA ACÚSTICO LEVE OD'
		WHEN au.chkdtaleveoi = 'true' THEN 'TRAUMA ACÚSTICO LEVE OI'
		WHEN au.chkdtaavanzadood = 'true' AND au.chkdtaavanzadooi = 'true' THEN 'TRAUMA ACÚSTICO BILATERAL AVANZADO'
		WHEN au.chkdtaavanzadood = 'true' THEN 'TRAUMA ACÚSTICO AVANZADO OD'
		WHEN au.chkdtaavanzadooi = 'true' THEN 'TRAUMA ACÚSTICO AVANZADO OI'
		WHEN au.chkdhrleveod = 'true' AND au.chkdhrleveoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, BILATERAL LEVE'
		WHEN au.chkdhrleveod = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, LEVE OD'
		WHEN au.chkdhrleveoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, LEVE OI'
		WHEN au.chkdhrmoderadood = 'true' AND au.chkdhrmoderadooi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, BILATERAL MODERADA'
		WHEN au.chkdhrmoderadood = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, MODERADA OD'
		WHEN au.chkdhrmoderadooi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, MODERADA OI'
		WHEN au.chkdhravanzadaod = 'true' AND au.chkdhravanzadaoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, BILATERAL AVANZADA'
		WHEN au.chkdhravanzadaod = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, AVANZADA OD'
		WHEN au.chkdhravanzadaoi = 'true' THEN 'HIPOACUSIA INDUCIDA POR RUIDO, AVANZADA OI'
		WHEN au.chkotrashipoacusias = 'true' THEN au.txtotrashipoacusias
		WHEN a25.txtdiag_od IS NOT NULL THEN CONCAT(a25.txtdiag_od, ' ', a25.txtdiag_oi)
		ELSE m.diagnostico
	    END AS diagnostico,
	    
	    -- TABLA: funcion_abs (Prefijo: fa)
	    fa.fvc,
	    fa.fev1,
	    fa.fev1fvc,
	    fa.fef25_75,
	    fa.interpretacion,
	    
	    -- TABLA: b_certificado_altura (Prefijo: ba)
	    ba.n_orden AS ordenaltura,
	    ba.b_c_observaciones AS alturabarrick,
	    
	    -- TABLA: b_certificado_conduccion (Prefijo: bc)
	    bc.n_orden AS ordencond,
	    bc.b_c_observaciones AS conduccion,
	    
	    -- TABLA: certificacion_medica_altura (Prefijo: ca)
	    ca.n_orden AS numalt,
	    ca.observaciones AS certialtura,
	    
	    -- TABLA: audiometria_2021 - Campos adicionales de diagnóstico (Prefijo: au)
	    au.chkdnormal,
	    au.chkdtaleveod,
	    au.chkdtaleveoi,
	    au.chkdtaavanzadood,
	    au.chkdtaavanzadooi,
	    au.chkdhrleveod,
	    au.chkdhrleveoi,
	    au.chkdhrmoderadood,
	    au.chkdhrmoderadooi,
	    au.chkdhravanzadaod,
	    au.chkdhravanzadaoi,
	    au.chkotrashipoacusias,
	    au.txtotrashipoacusias,
	    
	    -- TABLA: radiografia (Prefijo: ra)
	    ra.info_general,
	    ra.conclu,
	    
	    -- TABLA: anexo_agroindustrial (Prefijo: ag)
	    ag.txtanamnesis,
	    ag.txtestadomental,

	    -- TABLA: informe_electrocardiograma (Prefijo: ie)
	    ie.hallazgo, ie.recomendaciones,

	    -- TABLA: analisis_bioquimicos (Prefijo: ab)
	    ab.txtcolesterol, ab.txtldlcolesterol, ab.txthdlcolesterol, ab.txtvldlcolesterol,
	    ab.txttrigliseridos,

	    e.cod_exra,
	    e.n_rx,
	    e.fecha_exra,
	    e.txtcalidad,
	    e.txtsimbolos,
	    e.ex_0,
	    e.ex_10,
	    e.ex_11,
	    e.ex_12,
	    e.ex_21,
	    e.ex_22,
	    e.ex_23,
	    e.ex_32,
	    e.ex_33,
	    e.ex_3mas,
	    e.ex_abc,
	    e.ex_st,
	    e.txtsinneumoconiosis,
	    e.txtconneumoconiosis,
	    e.txtirep,
	    e.txtotrosex,
	    e.apto_si,
	    e.apto_no,
	    e.apto_re,
	    
	    a.ruido,
	    a.polvo,
	    a.vid_segmentario,
	    a.vid_total,
	    a.cancerigenos,
	    a.mutagenicos,
	    a.solventes,
	    a.metales,
	    a.temperatura,
	    a.biologicos,
	    a.posturas,
	    a.turnos,
	    a.cargas,
	    a.mov_repet,
	    a.pvd,
	    a.otros,
	    a.altura_estructura,
	    a.altura_geografica,
	    a.quimicos,
	    a.electricos,
	    a.vibraciones,
	    CASE WHEN eme.n_orden IS NULL THEN eme21.txtconclusiones ELSE eme.txtdiagnostico END
	FROM datos_paciente AS d
	    INNER JOIN n_orden_ocupacional AS n ON (d.cod_pa = n.cod_pa)
	    INNER JOIN antecedentes_patologicos AS a ON (n.n_orden = a.n_orden)
	    INNER JOIN triaje AS t ON (n.n_orden = t.n_orden)
	    LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	    LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	    INNER JOIN funcion_abs AS fa ON (n.n_orden = fa.n_orden)
	    INNER JOIN radiografia_torax AS r ON (n.n_orden = r.n_orden)
	    INNER JOIN lab_clinico AS l ON (n.n_orden = l.n_orden)
	    INNER JOIN odontograma AS od ON (n.n_orden = od.n_orden)
	    LEFT JOIN audiometria_po AS m ON (n.n_orden = m.n_orden)
	    LEFT JOIN audiometria_2021 AS au ON (n.n_orden = au.n_orden)
	    LEFT JOIN audiometria_2023 AS a25 ON (n.n_orden = a25.n_orden)
	    LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	    LEFT JOIN b_certificado_altura AS ba ON (ba.n_orden = n.n_orden)
	    LEFT JOIN b_certificado_conduccion AS bc ON (bc.n_orden = n.n_orden)
	    LEFT JOIN certificacion_medica_altura AS ca ON (ca.n_orden = n.n_orden)
	    LEFT JOIN radiografia AS ra ON (ra.n_orden = n.n_orden)
	    LEFT JOIN anexo_agroindustrial AS ag ON (n.n_orden = ag.n_orden)
	    LEFT JOIN informe_electrocardiograma AS ie ON (n.n_orden = ie.n_orden)
	    LEFT JOIN analisis_bioquimicos AS ab ON (n.n_orden = ab.n_orden)
	    LEFT JOIN ex_radiograficos_sanguineos AS e ON (n.n_orden = e.n_orden)
	    LEFT JOIN evaluacion_musculo_esqueletica AS eme ON (n.n_orden = eme.n_orden)
	    LEFT JOIN evaluacion_musculo_esqueletica2021 AS eme21 ON (n.n_orden = eme21.n_orden)
	WHERE n.n_orden = p_norden;

END;
$$;


create function obtener_reporte_certificado_trabajo_altura(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, tiempoexperiencia_t_experiencia text, primeraaptitud_chk_primera boolean, revalidacion_chk_revalidacion boolean, fechaexamen_f_examen date, antecedentestodasenfermedadessi_chk_1_si boolean, antecedentestodasenfermedadesno_chk_1_no boolean, antecedentesalcoholismocronicosi_chk_2_si boolean, antecedentesalcoholismocronicono_chk_2_no boolean, antecedentesenfermedadesinvoluntariossi_chk_3_si boolean, antecedentesenfermedadesinvoluntariosno_chk_3_no boolean, antecedentesperdidaconcienciasi_chk_4_si boolean, antecedentesperdidaconcienciano_chk_4_no boolean, chk5si_chk_5_si boolean, chk5no_chk_5_no boolean, antecedentesconsumesustanciassialteresi_chk_7_si boolean, antecedentesconsumesustanciassialtereno_chk_7_no boolean, antecedentesconsumesustanciasnoalteresi_chk_8_si boolean, antecedentesconsumesustanciasnoaltereno_chk_8_no boolean, antecedentesvariosefectossi_chk_9_si boolean, antecedentesvariosefectosno_chk_9_no boolean, antecedentesapneasi_chk_10_si boolean, antecedentesapneano_chk_10_no boolean, antecedentesobesidadsi_chk_11_si boolean, antecedentesobesidadno_chk_11_no boolean, pcomplementariashipoacusiasi_chk_13_si boolean, pcomplementariashipoacusiano_chk_13_no boolean, pcomplementariasalteracionagudezavisualsi_chk_14_si boolean, pcomplementariasalteracionagudezavisualno_chk_14_no boolean, pcomplementariastemoralturassi_chk_15_si boolean, pcomplementariastemoralturasno_chk_15_no boolean, pcomplementariasresfriadosi_chk_16_si boolean, pcomplementariasresfriadono_chk_16_no boolean, pcomplementariasvertigosi_chk_17_si boolean, pcomplementariasvertigono_chk_17_no boolean, pcomplementariacampimetriasi_chk_18_si boolean, pcomplementariacampimetriano_chk_18_no boolean, examenfisicolimitacionfuerzasi_chk_19_si boolean, examenfisicolimitacionfuerzano_chk_19_no boolean, examenfisicoalteracionequilibriosi_chk_20_si boolean, examenfisicoalteracionequilibriono_chk_20_no boolean, examenfisicoanormalidadmarchasi_chk_21_si boolean, examenfisicoanormalidadmarchano_chk_21_no boolean, examenfisicoalteracioncoordinacionsi_chk_22_si boolean, examenfisicoalteracioncoordinacionno_chk_22_no boolean, examenfisicoasimetriafacialsi_chk_23_si boolean, examenfisicoasimetriafacialno_chk_23_no boolean, examefisiconistagmussi_chk_24_si boolean, examefisiconistagmusno_chk_24_no boolean, examenfisicoanormalidadmovimientosi_chk_25_si boolean, examenfisicoanormalidadmovimientono_chk_25_no boolean, examenfisicocirlasi_chk_26_si boolean, examenfisicocirlano_chk_26_no boolean, examenfisicoanormalidadlenguajesi_chk_27_si boolean, examenfisicoanormalidadlenguajeno_chk_27_no boolean, examenfisicomovimientoinvoluntariosi_chk_28_si boolean, examenfisicomovimientoinvoluntariono_chk_28_no boolean, fechadesde_f_desde date, fechahasta_f_hasta date, apto_chk_si boolean, observado_chk_observado boolean, detallemedicina_d_medicina text, detalleinformacion_d_informacion text, noapto_chk_no_apto boolean, aptoconrestriccion_chk_apto_r boolean, observacionesrecomendaciones_b_c_observaciones text, antecedentescomentariosdetalles_comentariosdetalleantecedent text, antecedentesdiabetesmellitussi_chk_29_si boolean, antecedentesdiabetesmellitusno_chk_29_no boolean, chk30si_chk_30_si boolean, chk30no_chk_30_no boolean, examenfisicosustentacionpie_suste_pie_15 boolean, tallatriaje text, pesotriaje text, imctriaje text, cinturatriaje text, icctriaje text, caderatriaje text, temperatura text, frecuenciacardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje text, sistolica text, diastolica text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, conclusiontriaje text, frecuenciarespiratoriatriaje_f_respiratoria text, grado3fichasas_chkgradoiii boolean, grado4fichasas_chkgradoiiii boolean, aptocriterioesifichasas_chk1_apto_sie boolean, tiempolicenciabsas_t_licencia text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, diagnosticoaudiometria text, nombresede text, sede text, color integer, namejasper text, nombremedico text, cmpusuario text, dniusuario integer, usuariofirma text, laboratorioclinicohemoglobina text, medicamentos_anexo16a text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
    SELECT 
	    d.cod_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    d.direccion_pa,
	    d.sexo_pa,
	    d.fecha_nacimiento_pa,
	    d.ocupacion_pa,
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    n.nom_examen,
	    n.cod_clinica,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
	    ca.cod_certificado,
	    ca.t_experiencia,
	    ca.chk_primera,
	    ca.chk_revalidacion,
	    ca.f_examen,
	    ca.chk_1_si, ca.chk_1_no,
	    ca.chk_2_si, ca.chk_2_no,
	    ca.chk_3_si, ca.chk_3_no,
	    ca.chk_4_si, ca.chk_4_no,
	    ca.chk_5_si, ca.chk_5_no,
	    ca.chk_7_si, ca.chk_7_no,
	    ca.chk_8_si, ca.chk_8_no,
	    ca.chk_9_si, ca.chk_9_no,
	    ca.chk_10_si, ca.chk_10_no,
	    ca.chk_11_si, ca.chk_11_no,
	    ca.chk_13_si, ca.chk_13_no,
	    ca.chk_14_si, ca.chk_14_no,
	    ca.chk_15_si, ca.chk_15_no,
	    ca.chk_16_si, ca.chk_16_no,
	    ca.chk_17_si, ca.chk_17_no,
	    ca.chk_18_si, ca.chk_18_no,
	    ca.chk_19_si, ca.chk_19_no,
	    ca.chk_20_si, ca.chk_20_no,
	    ca.chk_21_si, ca.chk_21_no,
	    ca.chk_22_si, ca.chk_22_no,
	    ca.chk_23_si, ca.chk_23_no,
	    ca.chk_24_si, ca.chk_24_no,
	    ca.chk_25_si, ca.chk_25_no,
	    ca.chk_26_si, ca.chk_26_no,
	    ca.chk_27_si, ca.chk_27_no,
	    ca.chk_28_si, ca.chk_28_no,
	    ca.f_desde,
	    ca.f_hasta,
	    ca.chk_si,
	    ca.chk_observado,
	    ca.d_medicina,
	    ca.d_informacion,
	    ca.chk_no_apto,
	    ca.chk_apto_r,
	    ca.b_c_observaciones,
	    ca.ComentariosDetalleAntecedent,
	    ca.chk_29_si, ca.chk_29_no,
	    ca.chk_30_si, ca.chk_30_no,
	    ca.suste_pie_15,
	    c.talla,
	    c.peso,
	    c.imc,
	    c.cintura,
	    c.icc,
	    c.cadera,
	    c.temperatura,
	    c.f_cardiaca,
	    c.sat_02,
	    c.perimetro_cuello,
	    c.sistolica,
	    c.diastolica,
	    c.fvc, c.fev_1, c.fev1_fvc, c.fef25_75, c.conclusion,
	    c.f_respiratoria,
	    fsa.chkgradoiii, 
	    fsa.chkgradoiiii, 
	    fsa.chk1_apto_sie,
	    s.t_licencia,
	    p.p_max_inspiracion,
	    p.p_ex_forzada,
	    CASE 
		WHEN oft.txtcercasincorregirod IS NOT NULL THEN oft.txtcercasincorregirod 
		ELSE o.v_cerca_s_od 
	    END AS v_cerca_s_od,
	    
	    CASE 
		WHEN oft.txtcercasincorregiroi IS NOT NULL THEN oft.txtcercasincorregiroi 
		ELSE o.v_cerca_s_oi 
	    END AS v_cerca_s_oi,
	    
	    CASE 
		WHEN oft.txtcercacorregidaod IS NOT NULL THEN oft.txtcercacorregidaod
		WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od
		ELSE ol.v_cerca_c_od 
	    END AS ODCC,
	    
	    CASE 
		WHEN oft.txtcercacorregidaoi IS NOT NULL THEN oft.txtcercacorregidaoi
		WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi
		ELSE ol.v_cerca_c_oi 
	    END AS OICC,
	    
	    CASE 
		WHEN oft.txtlejossincorregirod IS NOT NULL THEN oft.txtlejossincorregirod 
		ELSE o.v_lejos_s_od 
	    END AS v_lejos_s_od,
	    
	    CASE 
		WHEN oft.txtlejossincorregiroi IS NOT NULL THEN oft.txtlejossincorregiroi 
		ELSE o.v_lejos_s_oi 
	    END AS v_lejos_s_oi,
	    
	    CASE 
		WHEN oft.txtlejoscorregidaod IS NOT NULL THEN oft.txtlejoscorregidaod 
		WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  
		ELSE ol.v_lejos_c_od  
	    END AS ODLC, 
	    
	    CASE 
		WHEN oft.txtlejoscorregidaoi IS NOT NULL THEN oft.txtlejoscorregidaoi 
		WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  
		ELSE ol.v_lejos_c_oi  
	    END AS OILC,
	    
	    CASE  
		WHEN oft.rbtecishihara_normal = 'TRUE' THEN 'NORMAL'
		WHEN oft.rbtecishihara_anormal = 'TRUE' THEN 'ANORMAL'
		WHEN ol.v_colores IS NULL THEN o.v_colores  
		ELSE ol.v_colores  
	    END AS VC,
	    
	    CASE  
		WHEN oft.txtbinocularsincorregir IS NOT NULL THEN oft.txtbinocularsincorregir  
		WHEN ol.v_binocular IS NULL THEN o.v_binocular  
		ELSE ol.v_binocular  
	    END AS VB,
	    
	    CASE  
		WHEN oft.txtrp IS NOT NULL THEN oft.txtrp
		WHEN ol.r_pupilares IS NULL THEN o.r_pupilares
		ELSE ol.r_pupilares  
	    END AS RP,
	    
	    CASE  
		WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico  
		ELSE o.e_oculares 
	    END AS e_oculares,
	    CASE 
		WHEN au.o_d_500 IS NOT NULL THEN au.o_d_500 
		ELSE m.o_d_500 
	    END AS o_d_500,
	    
	    CASE 
		WHEN au.o_d_1000 IS NOT NULL THEN au.o_d_1000 
		ELSE m.o_d_1000 
	    END AS o_d_1000,
	    
	    CASE 
		WHEN au.o_d_2000 IS NOT NULL THEN au.o_d_2000 
		ELSE m.o_d_2000 
	    END AS o_d_2000,
	    
	    CASE 
		WHEN au.o_i_500 IS NOT NULL THEN au.o_i_500 
		ELSE m.o_i_500 
	    END AS o_i_500,
	    
	    CASE 
		WHEN au.o_i_1000 IS NOT NULL THEN au.o_i_1000 
		ELSE m.o_i_1000 
	    END AS o_i_1000,
	    
	    CASE 
		WHEN au.o_i_2000 IS NOT NULL THEN au.o_i_2000 
		ELSE m.o_i_2000 
	    END AS o_i_2000,
	    CASE
		WHEN au.txtdiag_od IS NULL AND au.txtdiag_oi IS NULL THEN m.diagnostico
		ELSE au.txtdiag_od ||', '|| au.txtdiag_oi
	    END AS diagnosticoAudiometria,

	    CASE 
		WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' 
		    THEN 'Huamachuco'
		ELSE (
		    SELECT nombre_sede 
		    FROM sede 
		    WHERE cod_sede = n.cod_sede
		)
	    END AS nombre_sede,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    n.color,
	    obtener_name_jasper(p_norden, name_service),
	    u.nombre_user||' '||u.apellido_user AS nom_medico, 
	    u.cmp_user,
	    ca.dni_user,
	    ca.usuario_firma,
	    lc.txthemoglobina,
        a16.m_actual
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN 
	    triaje AS c ON n.n_orden = c.n_orden
	LEFT JOIN 
	    b_certificado_altura AS ca ON n.n_orden = ca.n_orden
	LEFT JOIN 
	    audiometria_po AS m ON n.n_orden = m.n_orden
	LEFT JOIN 
	    audiometria_2023 AS au ON n.n_orden = au.n_orden
	LEFT JOIN oftalmologia AS o ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft ON n.n_orden = oft.n_orden
	LEFT JOIN ficha_sas AS fsa ON n.n_orden = fsa.n_orden
	LEFT JOIN b_sas AS s ON s.n_orden = n.n_orden
	LEFT JOIN perimetro_toracico AS p ON p.n_orden=n.n_orden
	LEFT JOIN usuarios AS u ON (u.dni_user = ca.dni_user)
	LEFT JOIN lab_clinico AS lc ON lc.n_orden = n.n_orden
    LEFT JOIN anexo16a AS a16 ON n.n_orden = a16.n_orden
	WHERE n.n_orden = p_norden;

END;
$$;


create function obtener_reporte_certificado_conduccion(p_norden integer, name_service text)
    returns TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, tiempoexperiencia_t_experiencia text, primeraaptitud_chk_primera boolean, revalidacion_chk_revalidacion boolean, fechaexamen_f_examen date, antecedentestodasenfermedadessi_chk_1_si boolean, antecedentestodasenfermedadesno_chk_1_no boolean, antecedentesalcoholismocronicosi_chk_2_si boolean, antecedentesalcoholismocronicono_chk_2_no boolean, antecedentesenfermedadesinvoluntariossi_chk_3_si boolean, antecedentesenfermedadesinvoluntariosno_chk_3_no boolean, antecedentesperdidaconcienciasi_chk_4_si boolean, antecedentesperdidaconcienciano_chk_4_no boolean, antecedentesanemiagradosi_chk_5_si boolean, antecedentesanemiagradono_chk_5_no boolean, chk6si_chk_6_si boolean, chk6no_chk_6_no boolean, antecedentesvariosefectossi_chk_7_si boolean, antecedentesvariosefectosno_chk_7_no boolean, antecedentesconsumesustanciasnoalteresi_chk_8_si boolean, antecedentesconsumesustanciasnoaltereno_chk_8_no boolean, antecedentesconsumesustanciassialteresi_chk_9_si boolean, antecedentesconsumesustanciassialtereno_chk_9_no boolean, antecedentesapneasi_chk_10_si boolean, antecedentesapneano_chk_10_no boolean, antecedentesobesidadsi_chk_11_si boolean, antecedentesobesidadno_chk_11_no boolean, chk12si_chk_12_si boolean, chk12no_chk_12_no boolean, pcomplementariashipoacusiasi_chk_13_si boolean, pcomplementariashipoacusiano_chk_13_no boolean, pcomplementariasalteracionagudezavisualsi_chk_14_si boolean, pcomplementariasalteracionagudezavisualno_chk_14_no boolean, pcomplementariasampliometriaanormalsi_chk_15_si boolean, pcomplementariasampliometriaanormalno_chk_15_no boolean, chk16si_chk_16_si boolean, chk16no_chk_16_no boolean, pcomplementariasnocolorsi_chk_17_si boolean, pcomplementariasnocolorno_chk_17_no boolean, pcomplementariaspruebavisionsi_chk_18_si boolean, pcomplementariaspruebavisionno_chk_18_no boolean, pcomplementariaspsicosensometricaalteradasi_chk_19_si boolean, pcomplementariaspsicosensometricaalteradano_chk_19_no boolean, chk20si_chk_20_si boolean, chk20no_chk_20_no boolean, examenfisicolimitacionsi_chk_21_si boolean, examenfisicolimitacionno_chk_21_no boolean, examenfisicoaleracionpresentesi_chk_22_si boolean, examenfisicoaleracionpresenteno_chk_22_no boolean, examenfisicoanormalidadmarchasi_chk_23_si boolean, examenfisicoanormalidadmarchano_chk_23_no boolean, examenfisicoalteracioncoordinacionsi_chk_24_si boolean, examenfisicoalteracioncoordinacionno_chk_24_no boolean, examefisiconistagmussi_chk_25_si boolean, examefisiconistagmusno_chk_25_no boolean, examenfisicoanormalidadmovimientosi_chk_26_si boolean, examenfisicoanormalidadmovimientono_chk_26_no boolean, examenfisicocirlasi_chk_27_si boolean, examenfisicocirlano_chk_27_no boolean, examenfisicoanormalidadlenguajesi_chk_28_si boolean, examenfisicoanormalidadlenguajeno_chk_28_no boolean, examenfisicomovimientoinvoluntariosi_chk_29_si boolean, examenfisicomovimientoinvoluntariono_chk_29_no boolean, examenfisicoasimetriafacialsi_chk_30_si boolean, examenfisicoasimetriafacialno_chk_30_no boolean, fechadesde_f_desde date, fechahasta_f_hasta date, apto_chk_si boolean, noapto_chk_no boolean, observado_chk_observado boolean, observacionesrecomendaciones_b_c_observaciones text, detallemedicinas_d_medicina text, detalleinformacion_d_informacion text, aptoconrestriccion_chk_apto_r boolean, otrosdescripcion_txtotros text, antecedentesdiabetesmellitus_diabete_mellitus boolean, antecedentesinsuficienciarenal_insuficiencia_renaliv boolean, pcomplementariastestsas_testsas boolean, examenfisicosustentacionpie_sustentacionpie boolean, antecedentescomentariosdetalles_comendetalleantecedentes text, tallatriaje text, pesotriaje text, imctriaje text, cinturatriaje text, icctriaje text, caderatriaje text, temperatura text, frecuenciacardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje text, sistolica text, diastolica text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, conclusiontriaje text, frecuenciarespiratoriatriaje_f_respiratoria text, grado3fichasas_chkgradoiii boolean, grado4fichasas_chkgradoiiii boolean, aptocriterioesifichasas_chk1_apto_sie boolean, tiempolicenciabsas_t_licencia text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, enfermedadesocularesoftalmo_e_oculares text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, diagnosticoaudiometria text, nombresede text, sede text, color integer, namejasper text, usuariofirma text, laboratorioclinicohemoglobina text, medicamentos_anexo16a text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
    SELECT 
	    d.cod_pa,
	    d.nombres_pa,
	    d.apellidos_pa,
	    d.direccion_pa,
	    d.sexo_pa,
	    d.fecha_nacimiento_pa,
	    d.ocupacion_pa,
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    n.nom_examen,
	    n.cod_clinica,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
	    t.cod_certificado,
	    t.t_experiencia,
	    t.chk_primera,
	    t.chk_revalidacion,
	    t.f_examen,
	    t.chk_1_si, t.chk_1_no,
	    t.chk_2_si, t.chk_2_no,
	    t.chk_3_si, t.chk_3_no,
	    t.chk_4_si, t.chk_4_no,
	    t.chk_5_si, t.chk_5_no,
	    t.chk_6_si, t.chk_6_no,
	    t.chk_7_si, t.chk_7_no,
	    t.chk_8_si, t.chk_8_no,
	    t.chk_9_si, t.chk_9_no,
	    t.chk_10_si, t.chk_10_no,
	    t.chk_11_si, t.chk_11_no,
	    t.chk_12_si, t.chk_12_no,
	    t.chk_13_si, t.chk_13_no,
	    t.chk_14_si, t.chk_14_no,
	    t.chk_15_si, t.chk_15_no,
	    t.chk_16_si, t.chk_16_no,
	    t.chk_17_si, t.chk_17_no,
	    t.chk_18_si, t.chk_18_no,
	    t.chk_19_si, t.chk_19_no,
	    t.chk_20_si, t.chk_20_no,
	    t.chk_21_si, t.chk_21_no,
	    t.chk_22_si, t.chk_22_no,
	    t.chk_23_si, t.chk_23_no,
	    t.chk_24_si, t.chk_24_no,
	    t.chk_25_si, t.chk_25_no,
	    t.chk_26_si, t.chk_26_no,
	    t.chk_27_si, t.chk_27_no,
	    t.chk_28_si, t.chk_28_no,
	    t.chk_29_si, t.chk_29_no,
	    t.chk_30_si, t.chk_30_no,
	    t.f_desde,
	    t.f_hasta,
	    t.chk_si,
	    t.chk_no,
	    t.chk_observado,
	    t.b_c_observaciones,
	    t.d_medicina,
	    t.d_informacion,
	    t.chk_apto_r,
	    t.txtotros,
	    t.diabete_mellitus,
	    t.insuficiencia_renalIV,
	    t.testSAS,
	    t.sustentacionpie,
	    t.comenDetalleAntecedentes,
	    c.talla,
	    c.peso,
	    c.imc,
	    c.cintura,
	    c.icc,
	    c.cadera,
	    c.temperatura,
	    c.f_cardiaca,
	    c.sat_02,
	    c.perimetro_cuello,
	    c.sistolica,
	    c.diastolica,
	    c.fvc, c.fev_1, c.fev1_fvc, c.fef25_75, c.conclusion,
	    c.f_respiratoria,
	    fsa.chkgradoiii, 
	    fsa.chkgradoiiii, 
	    fsa.chk1_apto_sie,
	    s.t_licencia,
	    p.p_max_inspiracion,
	    p.p_ex_forzada,
	    CASE 
		WHEN oft.txtcercasincorregirod IS NOT NULL THEN oft.txtcercasincorregirod 
		ELSE o.v_cerca_s_od 
	    END AS v_cerca_s_od,
	    
	    CASE 
		WHEN oft.txtcercasincorregiroi IS NOT NULL THEN oft.txtcercasincorregiroi 
		ELSE o.v_cerca_s_oi 
	    END AS v_cerca_s_oi,
	    
	    CASE 
		WHEN oft.txtcercacorregidaod IS NOT NULL THEN oft.txtcercacorregidaod
		WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od
		ELSE ol.v_cerca_c_od 
	    END AS ODCC,
	    
	    CASE 
		WHEN oft.txtcercacorregidaoi IS NOT NULL THEN oft.txtcercacorregidaoi
		WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi
		ELSE ol.v_cerca_c_oi 
	    END AS OICC,
	    
	    CASE 
		WHEN oft.txtlejossincorregirod IS NOT NULL THEN oft.txtlejossincorregirod 
		ELSE o.v_lejos_s_od 
	    END AS v_lejos_s_od,
	    
	    CASE 
		WHEN oft.txtlejossincorregiroi IS NOT NULL THEN oft.txtlejossincorregiroi 
		ELSE o.v_lejos_s_oi 
	    END AS v_lejos_s_oi,
	    
	    CASE 
		WHEN oft.txtlejoscorregidaod IS NOT NULL THEN oft.txtlejoscorregidaod 
		WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  
		ELSE ol.v_lejos_c_od  
	    END AS ODLC, 
	    
	    CASE 
		WHEN oft.txtlejoscorregidaoi IS NOT NULL THEN oft.txtlejoscorregidaoi 
		WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  
		ELSE ol.v_lejos_c_oi  
	    END AS OILC,
	    
	    CASE  
		WHEN oft.rbtecishihara_normal = 'TRUE' THEN 'NORMAL'
		WHEN oft.rbtecishihara_anormal = 'TRUE' THEN 'ANORMAL'
		WHEN ol.v_colores IS NULL THEN o.v_colores  
		ELSE ol.v_colores  
	    END AS VC,
	    
	    CASE  
		WHEN oft.txtbinocularsincorregir IS NOT NULL THEN oft.txtbinocularsincorregir  
		WHEN ol.v_binocular IS NULL THEN o.v_binocular  
		ELSE ol.v_binocular  
	    END AS VB,
	    
	    CASE  
		WHEN oft.txtrp IS NOT NULL THEN oft.txtrp
		WHEN ol.r_pupilares IS NULL THEN o.r_pupilares
		ELSE ol.r_pupilares  
	    END AS RP,
	    
	    CASE  
		WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico  
		ELSE o.e_oculares 
	    END AS e_oculares,
	    CASE 
		WHEN au.o_d_500 IS NOT NULL THEN au.o_d_500 
		ELSE m.o_d_500 
	    END AS o_d_500,
	    
	    CASE 
		WHEN au.o_d_1000 IS NOT NULL THEN au.o_d_1000 
		ELSE m.o_d_1000 
	    END AS o_d_1000,
	    
	    CASE 
		WHEN au.o_d_2000 IS NOT NULL THEN au.o_d_2000 
		ELSE m.o_d_2000 
	    END AS o_d_2000,
	    
	    CASE 
		WHEN au.o_i_500 IS NOT NULL THEN au.o_i_500 
		ELSE m.o_i_500 
	    END AS o_i_500,
	    
	    CASE 
		WHEN au.o_i_1000 IS NOT NULL THEN au.o_i_1000 
		ELSE m.o_i_1000 
	    END AS o_i_1000,
	    
	    CASE 
		WHEN au.o_i_2000 IS NOT NULL THEN au.o_i_2000 
		ELSE m.o_i_2000 
	    END AS o_i_2000,
	    CASE
		WHEN au.txtdiag_od IS NULL AND au.txtdiag_oi IS NULL THEN m.diagnostico
		ELSE au.txtdiag_od ||', '|| au.txtdiag_oi
	    END AS diagnosticoAudiometria,

	    CASE 
		WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' 
		    THEN 'Huamachuco'
		ELSE (
		    SELECT nombre_sede 
		    FROM sede 
		    WHERE cod_sede = n.cod_sede
		)
	    END AS nombre_sede,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    n.color,
	    obtener_name_jasper(p_norden, name_service),
	    t.usuario_firma,
	    lc.txthemoglobina,
        a16.m_actual
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN 
	    triaje AS c ON n.n_orden = c.n_orden
	LEFT JOIN 
	    b_certificado_conduccion AS t ON n.n_orden = t.n_orden
	LEFT JOIN 
	    audiometria_po AS m ON n.n_orden = m.n_orden
	LEFT JOIN 
	    audiometria_2023 AS au ON n.n_orden = au.n_orden
	LEFT JOIN oftalmologia AS o ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft ON n.n_orden = oft.n_orden
	LEFT JOIN ficha_sas AS fsa ON n.n_orden = fsa.n_orden
	LEFT JOIN b_sas AS s ON s.n_orden = n.n_orden
	LEFT JOIN perimetro_toracico AS p ON p.n_orden=n.n_orden
	LEFT JOIN lab_clinico AS lc ON lc.n_orden = n.n_orden
    LEFT JOIN anexo16a AS a16 ON n.n_orden = a16.n_orden
	WHERE n.n_orden = p_norden;

END;
$$;

create function obtener_reporte_antecedentes_patologicos(p_norden integer, name_service text)
    returns TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, direccionpaciente_direccion_pa text, sexo_sexo_pa "char", fechanacimientopaciente_fecha_nacimiento_pa date, cargo_cargo_de text, area_area_o text, contrata_razon_contrata text, n_orden integer, empresa_razon_empresa text, edad_edad text, color integer, codigoantecedentespatologicos_cod_ap integer, fechaantecedentespatologicos_fecha_ap date, dniusuario_dni_user integer, alergias_chk1 boolean, amigdalitiscronica_chk2 boolean, arritmiascardiacas_chk3 boolean, asma_chk4 boolean, bocio_chk5 boolean, bronconeumonia_chk6 boolean, bronquitisarepeticion_chk7 boolean, cariesogingivitis_chk8 boolean, colecistitis_chk9 boolean, dermatitis_chk10 boolean, diabetes_chk11 boolean, disenteria_chk12 boolean, enfermedadescorazon_chk13 boolean, enfermedadesoculares_chk14 boolean, epilsepsiaoconvulsiones_chk15 boolean, faringitiscronica_chk16 boolean, fiebremalta_chk17 boolean, fiebretifoidea_chk18 boolean, fiebrereumatica_chk19 boolean, foruncolois_chk20 boolean, gastritiscronica_chk21 boolean, gonorrea_chk22 boolean, gota_chk23 boolean, hemorroides_chk24 boolean, hepatitis_chk25 boolean, hernias_chk26 boolean, hipertencionarterial_chk27 boolean, urinariasrepetidas_chk28 boolean, intoxicaciones_chk29 boolean, insuficienciacardiaca_chk30 boolean, insuficienciacoronariacronica_chk31 boolean, insuficienciarenalcronica_chk32 boolean, litiasisurinaria_chk33 boolean, meningitis_chk34 boolean, neuritis_chk35 boolean, otitismedia_chk36 boolean, presionaltaobaja_chk37 boolean, paludismoomalaria_chk38 boolean, parasitosisintestinal_chk39 boolean, paratiditis_chk40 boolean, pleuresia_chk41 boolean, plumbismo_chk42 boolean, poliomielitis_chk43 boolean, portadormarcapasos_chk44 boolean, protesiscardiacasvalvulares_chk45 boolean, resfriosfrecuentes_chk46 boolean, reumatismo_chk47 boolean, sarampion_chk48 boolean, sifilis_chk49 boolean, silicosis_chk50 boolean, sinusitiscronica_chk51 boolean, tosconvulsiva_chk52 boolean, transtornosnerviosos_chk53 boolean, traumatismoencefalocraneano_chk54 boolean, tuberculosis_chk55 boolean, tumoresquistes_chk56 boolean, ulcerapeptica_chk57 boolean, varicela_chk58 boolean, varices_chk59 boolean, varicocele_chk60 boolean, perdidamemoria_chk61 boolean, preocupacionesangustia_chk62 boolean, doloresarticulares_chk63 boolean, aumentodisminucionpeso_chk64 boolean, dolorcabeza_chk65 boolean, diarrea_chk66 boolean, agitacionejercicio_chk67 boolean, dolorocular_chk68 boolean, doloropresivotorax_chk69 boolean, hinchazonpiesomanos_chk70 boolean, estrenimiento_chk71 boolean, vomitosconsangre_chk72 boolean, sangradopororina_chk73 boolean, tosconsangre_chk74 boolean, coloracionamarrillapiel_chk75 boolean, indigestionfrecuente_chk76 boolean, insomnio_chk77 boolean, lumbalgiaodolorcintura_chk78 boolean, mareos_chk79 boolean, hecesnegras_chk80 boolean, orinacondolor_chk81 boolean, orinainvoluntaria_chk82 boolean, doloroido_chk83 boolean, secrecionesoido_chk84 boolean, palpitaciones_chk85 boolean, adormecimientos_chk86 boolean, pesadillasfrecuentes_chk87 boolean, doloresmusculares_chk88 boolean, toscronica_chk89 boolean, sangradoencias_chk90 boolean, drogasno_rbdrogasno boolean, drogassi_rbdrogassi boolean, licorno_rblicorno boolean, licorsi_rblicorsi boolean, fumarno_rbfumarno boolean, fumarsi_rbfumarsi boolean, drogasfrecuencia_txtdrogasfrecuencia text, drogastipo_txtdrogastipo text, licorfrecuencia_txtlicorfrecuencia text, licortipofrecuente_txtlicortipofrecuente text, numerocigarrillos_txtncigarrillos text, precisarcausasvarones_txtvcausas text, hijosvivosvarones_txtvhijosvivos text, hijosfallecidosvarones_txtvhijosfallecidos text, abortosparejasvarones_txtvnabortosparejas text, iniciomestruaciondamas_txtdiniciomestruacion text, iniciovidasexualdamas_txtdiniciovidasexual text, numeroparejassexactualidaddamas_txtdnumparejassexactualidad text, hijosvivosdamas_txtdhijosvivos text, hijosfallecidosdamas_txtdhijosfallecidos text, numerosdeabortosdamas_txtdnumerosdeabortos text, precisarcausasdamas_txtdcausas text, otrosdescripcionantecedentespatologicos_txtotrosap text, otrosdescripcionindicarenfermedades_txtotros1ap text, covid_chkcovid boolean, fechacovid_fechacovid date, covidlevel_chkcovidl boolean, covidmoderado_chkcovidm boolean, covidsevero_chkcovids boolean, dosisvacunas_txtdosis text, userregistro_user_registro text, otrostipoindicarenfermedades_txtotros text, otrosfrecuenciaindicarenfermedades_txtotrosfrecuencia text, otrossiindicarenfermedades_rbotrossi boolean, otrosnoindicarenfermedades_rbotrosno boolean, imaboro_ima boolean, acvboro_acv boolean, tbcboro_tbc boolean, vihboro_vih boolean, fobiasboro_fobias boolean, vertigosboro_vertigos boolean, tifoideaboro_tifoidea boolean, neoplasiasboro_neoplasias boolean, quemadurasboro_quemaduras boolean, discopatiasboro_discopatias boolean, columnaboro_columna boolean, enfermedadespsiquiatricasboro_enf_psiquiatricas boolean, enfermedadesreumaticasboro_enf_reumatica boolean, enfermedadespulmonaresboro_enf_pulmonares boolean, enfermedadespielboro_enf_piel boolean, tendinitisboro_tendinitis boolean, onicomicosisboro_onicomicosis boolean, fracturasboro_fracturas boolean, anemiaboro_anemia boolean, obesidadboro_obesidad boolean, dislipidemiaboro_dislipidemia boolean, intoxicacionesboro_intoxicaciones boolean, amputacionboro_amputacion boolean, sorderaboro_sordera boolean, especifiquetratamientoboro_especifique_detalleenfermedades text, alergiasalimentosboro_alergias_medic_alim boolean, alergiasalimentosespecifiqueboro_alergias_medic_alimdetall text, accidentetrabajoboro_accitrabajo boolean, accidentetrabajofechaboro_accit_fecha date, descansomedicoboro_accit_descanso boolean, descansomedicoespecifiqueboro_accit_descanso_detal text, enfermedadesprofesionalesboro_enfe_prof boolean, enfermedadesprofesionalesfechaboro_enfe_profecha date, enfermedadeslaboralescalificacionboro_enfe_lab_calif boolean, enfermedadeslaboralesespecifiqueboro_enfe_lab_califdetal text, antitetanicaboro_antitetanica boolean, fiebreamarillaboro_fiebre_amarilla boolean, influenzaboro_influenza boolean, hepatitisaboro_hepatitisa boolean, hepatitisbboro_hepatitisb boolean, gripeinfluenzaboro_gripe_influenza boolean, neumococoboro_neumococo boolean, rabiaboro_rabia boolean, papilomahumanoboro_papiloma_humano boolean, cantidosisboro_cantidosis boolean, medicamentoboro_medicamento boolean, medicamentoespecifiqueboro_medicamento_detal text, actividadfisicaboro_activ_fisic boolean, actividadfisicaespecifiqueboro_activ_fisic_detal text, padreespecifiqueboro_padre_detall text, madreespecifiqueboro_madre_detall text, hermanosespecifiqueboro_hermanos_detall text, hijosespecifiqueboro_hijos_detall text, esposconyespecifiqueboro_espos_cony_detall text, conadisespecifiqueboro_conadisdetalle text, etsboro_ets boolean, migranaboro_migrana boolean, tiempoincapacidadboro_timeincapacidad text, covidantecedentepatologicoboro_covid_antepatologico boolean, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageograficaanexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, direccionsede text, sede text, nombresede text, namejasper text, esboro boolean, tiempoexperiencia text, diastolica text, sistolica text, medicamentos_anexo16a text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
	SELECT 
	    dp.cod_pa,
	    dp.nombres_pa,
	    dp.apellidos_pa,
	    dp.direccion_pa,
	    dp.sexo_pa,
	    dp.fecha_nacimiento_pa,
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
	    n.color,
	    ap.cod_ap,
	    ap.fecha_ap,
	ap.dni_user,
    ap.chk1,
    ap.chk2,
    ap.chk3,
    ap.chk4,
    ap.chk5,
    ap.chk6,
    ap.chk7,
    ap.chk8,
    ap.chk9,
    ap.chk10,
    ap.chk11,
    ap.chk12,
    ap.chk13,
    ap.chk14,
    ap.chk15,
    ap.chk16,
    ap.chk17,
    ap.chk18,
    ap.chk19,
    ap.chk20,
    ap.chk21,
    ap.chk22,
    ap.chk23,
    ap.chk24,
    ap.chk25,
    ap.chk26,
    ap.chk27,
    ap.chk28,
    ap.chk29,
    ap.chk30,
    ap.chk31,
    ap.chk32,
    ap.chk33,
    ap.chk34,
    ap.chk35,
    ap.chk36,
    ap.chk37,
    ap.chk38,
    ap.chk39,
    ap.chk40,
    ap.chk41,
    ap.chk42,
    ap.chk43,
    ap.chk44,
    ap.chk45,
    ap.chk46,
    ap.chk47,
    ap.chk48,
    ap.chk49,
    ap.chk50,
    ap.chk51,
    ap.chk52,
    ap.chk53,
    ap.chk54,
    ap.chk55,
    ap.chk56,
    ap.chk57,
    ap.chk58,
    ap.chk59,
    ap.chk60,
    ap.chk61,
    ap.chk62,
    ap.chk63,
    ap.chk64,
    ap.chk65,
    ap.chk66,
    ap.chk67,
    ap.chk68,
    ap.chk69,
    ap.chk70,
    ap.chk71,
    ap.chk72,
    ap.chk73,
    ap.chk74,
    ap.chk75,
    ap.chk76,
    ap.chk77,
    ap.chk78,
    ap.chk79,
    ap.chk80,
    ap.chk81,
    ap.chk82,
    ap.chk83,
    ap.chk84,
    ap.chk85,
    ap.chk86,
    ap.chk87,
    ap.chk88,
    ap.chk89,
    ap.chk90,
    ap.rbdrogasno,
    ap.rbdrogassi,
    ap.rblicorno,
    ap.rblicorsi,
    ap.rbfumarno,
    ap.rbfumarsi,
    ap.txtdrogasfrecuencia,
    ap.txtdrogastipo,
    ap.txtlicorfrecuencia,
    ap.txtlicortipofrecuente,
    ap.txtncigarrillos,
    ap.txtvcausas,
    ap.txtvhijosvivos,
    ap.txtvhijosfallecidos,
    ap.txtvnabortosparejas,
    ap.txtdiniciomestruacion,
    ap.txtdiniciovidasexual,
    ap.txtdnumparejassexactualidad,
    ap.txtdhijosvivos,
    ap.txtdhijosfallecidos,
    ap.txtdnumerosdeabortos,
    ap.txtdcausas,
    ap.txtotrosap,
    ap.txtotros1ap,
    ap.chkcovid,
    ap.fechacovid,
    ap.chkcovidl,
    ap.chkcovidm,
    ap.chkcovids,
    ap.txtdosis,
    ap.user_registro,
    ap.txtotros,
    ap.txtotrosfrecuencia,
    ap.rbotrossi,
    ap.rbotrosno,
    ap.ima,
    ap.acv,
    ap.tbc,
    ap.vih,
    ap.fobias,
    ap.vertigos,
    ap.tifoidea,
    ap.neoplasias,
    ap.quemaduras,
    ap.discopatias,
    ap.columna,
    ap.enf_psiquiatricas,
    ap.enf_reumatica,
    ap.enf_pulmonares,
    ap.enf_piel,
    ap.tendinitis,
    ap.onicomicosis,
    ap.fracturas,
    ap.anemia,
    ap.obesidad,
    ap.dislipidemia,
    ap.intoxicaciones,
    ap.amputacion,
    ap.sordera,
    ap.especifique_detalleenfermedades,
    ap.alergias_medic_alim,
    ap.alergias_medic_alimdetall,
    ap.accitrabajo,
    ap.accit_fecha,
    ap.accit_descanso,
    ap.accit_descanso_detal,
    ap.enfe_prof,
    ap.enfe_profecha,
    ap.enfe_lab_calif,
    ap.enfe_lab_califdetal,
    ap.antitetanica,
    ap.fiebre_amarilla,
    ap.influenza,
    ap.hepatitisa,
    ap.hepatitisb,
    ap.gripe_influenza,
    ap.neumococo,
    ap.rabia,
    ap.papiloma_humano,
    ap.cantidosis,
    ap.medicamento,
    ap.medicamento_detal,
    ap.activ_fisic,
    ap.activ_fisic_detal,
    ap.padre_detall,
    ap.madre_detall,
    ap.hermanos_detall,
    ap.hijos_detall,
    ap.espos_cony_detall,
    ap.conadisdetalle,
    ap.ets,
    ap.migrana,
    ap.timeincapacidad,
    ap.covid_antepatologico,
	    CASE 
		WHEN oft.txtdiagnostico IS not NULL
		    THEN UPPER(oft.txtdiagnostico) 
		ELSE UPPER(o.e_oculares) 
	    END AS e_oculares, o.e_oculares1,
	    CASE 
		WHEN oft.txtcercasincorregirod IS NOT NULL 
		    THEN oft.txtcercasincorregirod 
		ELSE o.v_cerca_s_od 
	    END AS v_cerca_s_od,
	    
	    CASE 
		WHEN oft.txtcercasincorregiroi IS NOT NULL 
		    THEN oft.txtcercasincorregiroi 
		ELSE o.v_cerca_s_oi 
	    END AS v_cerca_s_oi,
	    
	    CASE 
		WHEN oft.txtcercacorregidaod IS NOT NULL 
		    THEN oft.txtcercacorregidaod
		WHEN ol.v_cerca_c_od IS NULL 
		    THEN o.v_cerca_c_od
		ELSE ol.v_cerca_c_od 
	    END AS ODCC,
	    
	    CASE 
		WHEN oft.txtcercacorregidaoi IS NOT NULL 
		    THEN oft.txtcercacorregidaoi
		WHEN ol.v_cerca_c_oi IS NULL 
		    THEN o.v_cerca_c_oi
		ELSE ol.v_cerca_c_oi 
	    END AS OICC,
	    
	    CASE 
		WHEN oft.txtlejossincorregirod IS NOT NULL 
		    THEN oft.txtlejossincorregirod 
		ELSE o.v_lejos_s_od 
	    END AS v_lejos_s_od,
	    
	    CASE 
		WHEN oft.txtlejossincorregiroi IS NOT NULL 
		    THEN oft.txtlejossincorregiroi 
		ELSE o.v_lejos_s_oi 
	    END AS v_lejos_s_oi,
	    
	    CASE 
		WHEN oft.txtlejoscorregidaod IS NOT NULL 
		    THEN oft.txtlejoscorregidaod
		WHEN ol.v_lejos_c_od IS NULL 
		    THEN o.v_lejos_c_od 
		ELSE ol.v_lejos_c_od 
	    END AS ODLC,
	    
	    CASE 
		WHEN oft.txtlejoscorregidaoi IS NOT NULL 
		    THEN oft.txtlejoscorregidaoi
		WHEN ol.v_lejos_c_oi IS NULL 
		    THEN o.v_lejos_c_oi 
		ELSE ol.v_lejos_c_oi 
	    END AS OILC,
	    
	    CASE  
		WHEN oft.rbtecishihara_normal = 'TRUE'  
		    THEN 'NORMAL'
		WHEN oft.rbtecishihara_anormal = 'TRUE' 
		    THEN 'ANORMAL'
		WHEN ol.v_colores IS NULL 
		    THEN o.v_colores  
		ELSE ol.v_colores  
	    END AS VC,
	    
	    CASE  
		WHEN oft.txtbinocularsincorregir IS NOT NULL 
		    THEN oft.txtbinocularsincorregir
		WHEN ol.v_binocular IS NULL 
		    THEN o.v_binocular  
		ELSE ol.v_binocular  
	    END AS VB,
	    
	    CASE  
		WHEN oft.txtrp IS NOT NULL 
		    THEN oft.txtrp
		WHEN ol.r_pupilares IS NULL 
		    THEN o.r_pupilares
		ELSE ol.r_pupilares  
	    END AS RP,
	    CASE WHEN ap.ruido IS NULL THEN a7.chkruido ELSE ap.ruido END,
	    CASE WHEN ap.polvo IS NULL THEN a7.chkpolvo ELSE ap.polvo END,
	    CASE WHEN ap.vid_segmentario IS NULL THEN a7.chkvidsegmentario ELSE ap.vid_segmentario END,
	    CASE WHEN ap.vid_total IS NULL THEN a7.chkvidtotal ELSE ap.vid_total END,
	    CASE WHEN ap.cancerigenos IS NULL THEN a7.chkcancerigenos ELSE ap.cancerigenos END,
	    CASE WHEN ap.mutagenicos IS NULL THEN a7.chkmutagenicos ELSE ap.mutagenicos END,
	    CASE WHEN ap.solventes IS NULL THEN a7.chksolventes ELSE ap.solventes END,
	    CASE WHEN ap.metales IS NULL THEN a7.chkmetales ELSE ap.metales END,
	    CASE WHEN ap.temperatura IS NULL THEN a7.chktemperatura ELSE ap.temperatura END,
	    CASE WHEN ap.biologicos IS NULL THEN a7.chkbiologicos ELSE ap.biologicos END,
	    CASE WHEN ap.posturas IS NULL THEN a7.chkposturas ELSE ap.posturas END,
	    CASE WHEN ap.turnos IS NULL THEN a7.chkturnos ELSE ap.turnos END,
	    CASE WHEN ap.cargas IS NULL THEN a7.chkcargas ELSE ap.cargas END,
	    CASE WHEN ap.mov_repet IS NULL THEN a7.chkmovrepet ELSE ap.mov_repet END,
	    CASE WHEN ap.pvd IS NULL THEN a7.chkpvd ELSE ap.pvd END,
	    CASE WHEN ap.electricos IS NULL THEN a7.electricos ELSE ap.electricos END,
	    CASE WHEN ap.vibraciones IS NULL THEN a7.vibraciones ELSE ap.vibraciones END,
	    CASE WHEN ap.otros IS NULL THEN a7.chkotros ELSE ap.otros END,
	    CASE WHEN ap.altura_estructura IS NULL THEN a7.altura_estructura ELSE ap.altura_estructura END,
	    CASE WHEN ap.altura_geografica IS NULL THEN a7.altura_geog ELSE ap.altura_geografica END,
	    CASE WHEN ap.quimicos IS NULL THEN a7.quimicos ELSE ap.quimicos END,
	  l.txtcocaina,
	  l.txtmarihuana,
	    CASE n.cod_sede
		WHEN 4 THEN 'Av. Nicolas de Piérola N°1106 Urb. San Fernando'
		WHEN 3 THEN 'Av. Huancavelica N°2225 - Distrito El Tambo'
		WHEN 2 THEN 'Jr. Leoncio Prado N°786'
		WHEN 1 THEN 'Cl.Guillermo Prescott N°127 Urb. Sto. Dominguito'
		ELSE ' '
	    END AS direccionSede,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    CASE
		    WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
		    WHEN n.cod_sede = 1 THEN 'Trujillo'
		    WHEN n.cod_sede = 2 THEN 'Huamachuco'
		    WHEN n.cod_sede = 3 THEN 'Huancayo'
		    WHEN n.cod_sede = 4 THEN 'Trujillo'
	    END AS nombreSede,
	    obtener_name_jasper(p_norden, name_service),
	    CASE 
		    WHEN n.razon_empresa ILIKE '%MINERA BOROO MISQUICHILCA S.A.%'
		      OR n.razon_empresa ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		      OR n.razon_empresa ILIKE '%DEYFOR EIRL%'
		    THEN TRUE 
		    ELSE FALSE 
	    END AS esBoro,
	    eme.t_servicio,
	    t.diastolica,
	    t.sistolica,
	    a16.m_actual
	FROM datos_paciente dp
	INNER JOIN n_orden_ocupacional n ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
	LEFT JOIN antecedentes_patologicos ap ON n.n_orden = ap.n_orden
	LEFT JOIN anexo7c AS a7 ON a7.n_orden = ap.n_orden
	LEFT JOIN lab_clinico l ON n.n_orden = l.n_orden
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	LEFT JOIN evaluacion_musculo_esqueletica2021 AS eme ON n.n_orden = eme.n_orden
	LEFT JOIN triaje AS t ON n.n_orden = t.n_orden
	LEFT JOIN anexo16a AS a16 ON n.n_orden = a16.n_orden
	WHERE n.n_orden = p_norden;

END;
$$;

create function sp_mostrar_info_paciente_filtros(norden_p integer, sucursal_p text)
    returns TABLE(n_orden integer, nombres_apellidos text, dni integer, fecha_examen date, nombres text, apellidos text, fecha_nac date, edad integer, empresa text, contrata text, nom_examen text, talla text, peso text, sexo_pa "char", area text, cargo text, direccion_pa text, estado_civil text, estudio_paciente text, lugar_nacimiento text, explotacion text, diastolica text, sistolica text)
    language plpgsql
as
$$
DECLARE
    codigo_sede_param INTEGER;
BEGIN
    SELECT id INTO codigo_sede_param FROM sede_multisucursal WHERE codigo_sucursal = sucursal_p;

    RETURN QUERY
SELECT n.n_orden,TRIM(dp.nombres_pa) || ' ' || TRIM(dp.apellidos_pa) as nombres_apellidos, dp.cod_pa as dni, n.fecha_apertura_po as fecha_examen,
	dp.nombres_pa as nombres, dp.apellidos_pa as apellidos, dp.fecha_nacimiento_pa as fecha_nac, obtener_edad(dp.fecha_nacimiento_pa,CURRENT_DATE) as edad, 
	n.razon_empresa as empresa, n.razon_contrata as contrata, n.nom_examen as nom_examn,trj.talla,trj.peso, dp.sexo_pa, n.area_o, n.cargo_de,
	dp.direccion_pa, dp.estado_civil_pa, dp.nivel_est_pa, dp.lugar_nac_pa, n.nom_ex, trj.diastolica, trj.sistolica
	FROM datos_paciente as dp inner join 
	n_orden_ocupacional as n on n.cod_pa=dp.cod_pa left join triaje as trj on  n.n_orden=trj.n_orden where n.n_orden=norden_p and n.cod_sede=codigo_sede_param;
END;
$$;

alter table funcion_abs add column usuario_firma text;
alter table funcion_abs add column user_registro text;

INSERT INTO config_general_service_digital
(name_service, descripcion, firma_p, huella_p, sello_prof_s, sello_doc_asig, sello_doc_adic)
VALUES ('funcion_abs', 'examen de espirometria', false, false, true, false, false);



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