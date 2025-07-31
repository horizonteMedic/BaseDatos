drop FUNCTION obtener_reporte_evaluacionoftalmologica(IN p_norden integer)

CREATE OR REPLACE FUNCTION obtener_reporte_evaluacionoftalmologica(IN p_norden integer)
  RETURNS TABLE(nombre text, apellido text, edad text, n_orden integer, dni integer, fecha_nac date, empresa text, contrata text, nom_examen text, sexo "char", cod_of integer, fecha_of date, rbecptosisod boolean, rbecptosisoi boolean, rbecestrabismood boolean, rbecestrabismooi boolean, rbecconjuntivitisod boolean, rbecconjuntivitisoi boolean, rbeccataratasod boolean, rbeccataratasoi boolean, rbecpterigionod boolean, rbecpterigionoi boolean, rbecpingueculaod boolean, rbecpingueculaoi boolean, rbecclalacionod boolean, rbecclalacionoi boolean, rbecotrosod boolean, rbecotrosoi boolean, txtechallazgos text, rbfonormalod boolean, rbfonormaloi boolean, rbfoanormalod boolean, rbfoanormaloi boolean, txtfohallazgos text, txtpiood text, txtpiooi text, txtpiona text, rbco_si boolean, rbco_no boolean, rbco_cerca boolean, rbco_lejos boolean, chkntcc boolean, chkntcl boolean, txtcercasincorregirod text, txtcercasincorregiroi text, txtlejossincorregirod text, txtlejossincorregiroi text, txtcercacorregidaod text, txtcercacorregidaoi text, txtlejoscorregidaod text, txtlejoscorregidaoi text, txtcercaagujerood text, txtcercaagujerooi text, txtlejosagujerood text, txtlejosagujerooi text, txtbinocularsincorregir text, txtbinocularcorregida text, rbtecishihara_normal boolean, rbtecishihara_anormal boolean, rbtecishihara_nc boolean, rbteccoleres_normal boolean, rbteccoleres_anormal boolean, rbteccoleres_nc boolean, txttecestereopsia text, rbtecestereopsia_normal boolean, rbtecestereopsia_anormal boolean, rbtecestereopsia_nc boolean, chkrefraccionaplica boolean, chkrefraccionnoaplica boolean, txtlejosodsf text, txtlejosodcil text, txtlejosodeje text, txtlejosoisf text, txtlejosoicil text, txtlejosoieje text, txtlejosoddip text, txtcercaodsf text, txtcercaodcil text, txtcercaodeje text, txtcercaoisf text, txtcercaoicil text, txtcercaoieje text, txtcercaoddip text, txtavconrefraccionlejosod text, txtavconrefraccionlejosoi text, txtavconrefraccioncercaod text, txtavconrefraccioncercaoi text, txtdiagnostico text, chkininguna boolean, chki2 boolean, chki3 boolean, chki4_cerca boolean, chki4_lejos boolean, chki5 boolean, chki6 boolean, chki7 boolean, chkr1 boolean, chkr2_lejos boolean, chkr2_cerca boolean, chkr3 boolean, chkr4 boolean, txtrp text, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, txt_parpa_anex text, txt_corneas text, txt_otros_hallaz text, txt_conjuntivas text, txt_cristalino text, txt_ant_pers_imp text, txt_fam_imp text, area_o text, ocupacion text) AS
$BODY$
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
    noo.cargo_de

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN oftalmologia2021 o ON o.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql



drop FUNCTION obtener_informacion_oftalmologiaconobservaciones(IN p_norden integer)

select * from obtener_informacion_oftalmologiaconobservaciones(96639)

select * from oftalmologia where n_orden = 96639
delete from oftalmologia where cod_of = 58400
CREATE OR REPLACE FUNCTION obtener_informacion_oftalmologiaconobservaciones(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, fecha_nac date, empresa text, contrata text, nom_examen text, sexo "char", cod_of integer, num_ticket integer, v_cerca_s_od text, v_cerca_s_oi text, v_cerca_c_od text, v_cerca_c_oi text, v_lejos_s_od text, v_lejos_s_oi text, v_lejos_c_od text, v_lejos_c_oi text, v_colores text, v_binocular text, r_pupilares text, e_oculares text, e_oculares1 text, v_binocular_lo text) AS
$BODY$
BEGIN


  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
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
    o.num_ticket, 
    o.v_cerca_s_od, 
    o.v_cerca_s_oi, 
    CASE 
        WHEN ol.v_cerca_c_od IS NULL THEN o.v_cerca_c_od  
        ELSE ol.v_cerca_c_od  
    END AS ODCC,

    CASE  
        WHEN ol.v_cerca_c_oi IS NULL THEN o.v_cerca_c_oi  
        ELSE ol.v_cerca_c_oi  
    END AS OICC,

    o.v_lejos_s_od, 
    o.v_lejos_s_oi,

    CASE  
        WHEN ol.v_lejos_c_od IS NULL THEN o.v_lejos_c_od  
        ELSE ol.v_lejos_c_od  
    END AS ODLC,

    CASE  
        WHEN ol.v_lejos_c_oi IS NULL THEN o.v_lejos_c_oi  
        ELSE ol.v_lejos_c_oi  
    END AS OILC,

    CASE  
        WHEN ol.v_colores IS NULL THEN o.v_colores  
        ELSE ol.v_colores  
    END AS VC,
    o.v_binocular,
    CASE  
        WHEN ol.r_pupilares IS NULL THEN o.r_pupilares  
        ELSE ol.r_pupilares  
    END AS RP,

    o.e_oculares,
    o.e_oculares1,
    ol.v_binocular

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN oftalmologia o ON o.n_orden = noo.n_orden
  LEFT JOIN oftalmologia_lo ol ON ol.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
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
	IF name_empresa_busqueda_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		resultado := 'OIT_Digitalizado_boro';
	ELSE
		resultado := 'OIT_B_Digitalizado';
	END IF;
    END IF;
    RETURN resultado;
END;
$BODY$
  LANGUAGE plpgsql;