CREATE OR REPLACE FUNCTION obtener_reporte_fechasRadiografiaTorax(
    IN inicio date,
    IN fin date)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, sexo "char", cod_rat integer, fecha_examen date, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text) AS
$BODY$
BEGIN
  RETURN QUERY
  SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),

    rt.n_orden,
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
    rt.cod_rat,
    rt.fecha_examen,
    
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
  INNER JOIN radiografia_torax rt ON rt.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  --INNER JOIN usuarios u ON LOWER(u.usuario_user) = LOWER(hoi.user_registro)
  WHERE rt.fecha_examen>=inicio AND rt.fecha_examen<=fin;
END;
$BODY$
  LANGUAGE plpgsql;

----------------------------------------------------------------------------------------------------

drop FUNCTION obtener_reporte_audiometria(IN p_norden integer)

CREATE OR REPLACE FUNCTION obtener_reporte_audiometria(IN p_norden integer)
  RETURNS TABLE(nombres text, edad text, n_orden integer, dni integer, empresa text, contrata text, cod_au integer, fecha_au date, rbsasordera_si boolean, rbsasordera_no boolean, rbsaacufenos_si boolean, rbsaacufenos_no boolean, rbsavertigo_si boolean, rbsavertigo_no boolean, rbsaotalgia_si boolean, rbsaotalgia_no boolean, rbsasecrecion_si boolean, rbsasecrecion_no boolean, txtsaotrossintomas text, rbamrenitis_si boolean, rbamrenitis_no boolean, rbamsinusitis_si boolean, rbamsinusitis_no boolean, rbamotitis_si boolean, rbamotitis_no boolean, rbamototoxicos_si boolean, rbamototoxicos_no boolean, rbammeningitis_si boolean, rbammeningitis_no boolean, rbamtec_si boolean, rbamtec_no boolean, rbamsordera_si boolean, rbamsordera_no boolean, rbamparotiditis_si boolean, rbamparotiditis_no boolean, rbamsarampion_si boolean, rbamsarampion_no boolean, rbamtbc_si boolean, rbamtbc_no boolean, txtamcuales text, rbeoexposicion_si boolean, rbeoexposicion_no boolean, rbeoprotectores_si boolean, rbeoprotectores_no boolean, rbeosustancias_si boolean, rbeosustancias_no boolean, rbte0a2 boolean, rbte2a4 boolean, rbte4a6 boolean, rbte6a8 boolean, rbte8a10 boolean, rbte10a12 boolean, rbtem12 boolean, rbteeventual boolean, chktapones boolean, chkorejeras boolean, txthplomo text, txthmercurio text, txthtolueno text, txthxileno text, txthplaguic text, txthorganofos text, txttplomo text, txttmercurio text, txtttolueno text, txttxileno text, txttplaguic text, txttorganofos text, txteootros text, rbaepratica_si boolean, rbaepratica_no boolean, rbaeuso_si boolean, rbaeuso_no boolean, rbaeotros_si boolean, rbaeotros_no boolean, txtaecuales text, txtood text, txtooi text, o_d_500 text, o_d_1000 text, o_d_2000 text, o_d_3000 text, o_d_4000 text, o_d_6000 text, o_d_8000 text, o_i_500 text, o_i_1000 text, o_i_2000 text, o_i_3000 text, o_i_4000 text, o_i_6000 text, o_i_8000 text, o_d1_500 text, o_d1_1000 text, o_d1_2000 text, o_d1_3000 text, o_d1_4000 text, o_d1_6000 text, o_d1_8000 text, o_i1_500 text, o_i1_1000 text, o_i1_2000 text, o_i1_3000 text, o_i1_4000 text, o_i1_6000 text, o_i1_8000 text, txtdiag_od text, txtdiag_oi text, txtcomentarios text, chkrpasimple boolean, chkrpadoble boolean, chkcasemestral boolean, chkcaanual boolean, txtotrasrecomendaciones text, txtanios text, txtmeses text, formato character varying, color integer, sede_descripcion text, dir_sede4 text, email_sede4 text, tel_sede4 text, cel_sede4 text, dir_sede3 text, email_sede3 text, tel_sede3 text, dir_sede2 text, email_sede2 text, tel_sede2 text, cel_sede2 text, dir_sede1 text, email_sede1 text, tel_sede1 text, fecha_nacimiento_pa date, sexo "char", areaTrabajo text, ocupacion text) AS
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
    (SELECT telefono FROM sede WHERE cod_sede = 1),
    dp.fecha_nacimiento_pa,
    dp.sexo_pa,
    noo.area_o,
    noo.cargo_de

  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  INNER JOIN audiometria_2023 aud ON aud.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------

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
        resultado := 'OftalmologiaLO.jasper';
    ELSIF name_service_param = 'oftalmologia' THEN
        resultado := 'Oftalmologia.jasper';
    ELSIF name_service_param = 'oftalmologia_reporte' THEN
        resultado := 'ReporteOftalmologico';
    ELSIF name_service_param = 'oftalmologia2021' THEN
	IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
            resultado := 'EvaluacionOftalmologica2021_Digitalizado_boro'; 
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
    END IF;
    RETURN resultado;
END;
$BODY$
  LANGUAGE plpgsql;