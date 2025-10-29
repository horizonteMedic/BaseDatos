select n_orden from n_orden_ocupacional limit 1


alter table n_orden_ocupacional add column user_actualizacion text, add column fecha_actualizacion date, add column hora_actualizacion TIME

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
    IN user_registro_exp text,
    IN espacios_confinados_exp boolean,
    IN t_marihuana_exp boolean,
    IN t_cocaina_exp boolean)
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
		 rxc_lumbar=rxc_lumbar_exp, rxc_lumbosacra=rxc_lumbosacra_exp, rxc_plomos=rxc_plomos_exp, mercurioo=mercurioo_exp, user_registro=user_registro_exp, espacios_confinados=espacios_confinados_exp, t_marihuana=t_marihuana_exp, t_cocaina=t_cocaina_exp,
		 user_actualizacion=user_registro_exp
		 where n_orden=n_orden_exp;
		RETURN QUERY 
		select CAST(1 AS bigint) as id_resp, CAST('El usuario se actualizo con exito!' AS TEXT) as mensaje;

		else
		
		INSERT INTO n_orden_ocupacional(cod_pa, razon_empresa, razon_contrata,
                        nom_ex, altura_po,mineral_po, fecha_apertura_po,precio_po,estado_ex,nom_examen,cargo_de,area_o,n_medico,n_hora,
                        tipo_pago,n_fisttest,n_psicosen,n_testaltura,color,gruposan,grupofactorsan,visual_compl,
                        trab_calientes,chkcovid1,chkcovid2,manip_alimentos, txtobserv1,txtobserv2,cod_sede,tipo_prueba_covid,tipoPrueba,nombrehotel,protocolo,
                        precio_adic,autoriza,n_operacion, herra_manuales, rxc_dorso_lumbar, rxc_lumbar, rxc_lumbosacra, rxc_plomos,mercurioo,user_registro, espacios_confinados, t_marihuana, t_cocaina)
		values (cod_pa_exp, razon_empresa_exp, razon_contrata_exp,nom_ex_exp, altura_po_exp, mineral_po_exp, TO_DATE(fecha_apertura_po_exp,'YYYY-MM-DD'), CAST(precio_po_exp as money), estado_ex_exp,
	nom_examen_exp, cargo_de_exp, area_o_exp,n_medico_exp, CAST (n_hora_exp as time without time zone), tipo_pago_exp,n_fisttest_exp, n_psicosen_exp,n_testaltura_exp, color_varia, grupo_san_exp,grupo_factor_san_exp,
	visual_compl_exp, trab_calientes_exp,chk_covid1_exp,chk_covid2_exp,manip_alimentos_exp,txtobserv1_exp,txtobserv2_exp,codigo_sede_param,tipo_prueba_covid_exp ,tipo_prueba_exp,nombre_hotel_exp,
	protocolo_exp,CAST(precio_adic_exp AS money),autoriza_exp,n_operacion_exp,herra_manuales_exp, rxc_dorso_lumbar_exp, rxc_lumbar_exp,rxc_lumbosacra_exp ,rxc_plomos_exp, mercurioo_exp, user_registro_exp, espacios_confinados_exp, t_marihuana_exp, t_cocaina_exp ) RETURNING n_orden into n_orden_hm;
                        PERFORM  spAgregarPE(n_orden_hm);
                        PERFORM  spagregarconta(n_orden_hm);
		RETURN QUERY 
		select CAST(n_orden_hm as bigint) as id_resp, CAST('El usuario se registro con exito!' AS TEXT) as mensaje;
		end if;

END; $BODY$
  LANGUAGE plpgsql;

  CREATE OR REPLACE FUNCTION fecha_actualizacion_n_orden()
RETURNS TRIGGER AS $$
BEGIN
  NEW.fecha_actualizacion := CURRENT_TIMESTAMP;
  NEW.hora_actualizacion := CURRENT_TIME;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_actualizar_fecha_n_orden
BEFORE UPDATE ON n_orden_ocupacional
FOR EACH ROW
EXECUTE PROCEDURE fecha_actualizacion_n_orden();

DROP FUNCTION obtener_reporte_certificado_trabajo_altura_poderosa(
    IN p_norden integer,
    IN name_service text)

CREATE OR REPLACE FUNCTION obtener_reporte_certificado_trabajo_altura_poderosa(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dnipaciente integer, nombrespaciente text, apellidospaciente text, direccionpaciente text, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, cargopaciente text, areapaciente text, contrata text, norden integer, empresa text, nombreexamen text, codigoclinica text, edadpaciente text, codigocertificado_cod_certificado integer, fechaexamen_f_examen date, fechacaducidad_f_caducidad date, procedencia_procedencia text, tiempoexperiencia_t_experiencia text, lugarexperiencia_lugar_expe text, accidentestrabajo_txtaccidentes_trab text, antecedentesfamiliares_txtantecedente_familiares text, tecmoderadosi_chk_psico_si1 boolean, tecmoderadono_chk_psico_no1 boolean, convulsionessi_chk_psico_si2 boolean, convulsionesno_chk_psico_no2 boolean, mareossi_chk_psico_si3 boolean, mareosno_chk_psico_no3 boolean, problemasauditivossi_chk_psico_si4 boolean, problemasauditivosno_chk_psico_no4 boolean, problemasequilibriosi_chk_psico_si5 boolean, problemasequilibriono_chk_psico_no5 boolean, acrofobiasi_chk_psico_si6 boolean, acrofobiano_chk_psico_no6 boolean, agarofobiasi_chk_psico_si7 boolean, agarofobiano_chk_psico_no7 boolean, tecmoderadodescripcion_txt_antecpsico_1 text, convulsionesdescripcion_txt_antecpsico_2 text, mareosdescripcion_txt_antecpsico_3 text, problemasauditivosdescripcion_txt_antecpsico_4 text, problemasequilibriodescripcion_txt_antecpsico_5 text, acrofobiadescripcion_txt_antecpsico_6 text, agarofobiadescripcion_txt_antecpsico_7 text, tabacocantidad_txt_tabaco_cantiad text, tabacofrecuencia_txt_tabaco_frecuencia text, alcoholcantidad_txt_alcohol_cantiad text, alcoholfrecuencia_txt_alcohol_frecuencia text, drogascantidad_txt_drogas_cantiad text, drogasfrecuencia_txt_drogas_frecuencia text, hojacocacantidad_txt_hojacoca_cantiad text, hojacocafrecuencia_txt_hojacoca_frecuencia text, cafecantidad_txt_cafe_cantiad text, cafefrecuencia_txt_cafe_frecuencia text, gustadivertirsesi_chktest_si1 boolean, gustadivertirseno_chktest_no1 boolean, gustadivertirsepuntaje_txttest_p1 text, tardecompromisosi_chktest_si2 boolean, tardecompromisono_chktest_no2 boolean, tardecompromisopuntaje_txttest_p2 text, criticaformabebersi_chktest_si3 boolean, criticaformabeberno_chktest_no3 boolean, criticaformabeberpuntaje_txttest_p3 text, reuniondivertirsereanimasi_chktest_si4 boolean, reuniondivertirsereanimano_chktest_no4 boolean, reuniondivertirsereanimapuntaje_txttest_p4 text, impresionbebermenossi_chktest_si5 boolean, impresionbebermenosno_chktest_no5 boolean, impresionbebermenospuntaje_txttest_p5 text, duermebiensi_chktest_si6 boolean, duermebienno_chktest_no6 boolean, duermebienpuntaje_txttest_p6 text, costumbrebebersi_chktest_si7 boolean, costumbrebeberno_chktest_no7 boolean, costumbrebeberpuntaje_txttest_p7 text, nerviosoamenudosi_chktest_si8 boolean, nerviosoamenudono_chktest_no8 boolean, nerviosoamenudopuntaje_txttest_p8 text, bebercalmarnerviossi_chktest_si9 boolean, bebercalmarnerviosno_chktest_no9 boolean, bebercalmarnerviospuntaje_txttest_p9 text, doloresespaldasi_chktest_si10 boolean, doloresespaldano_chktest_no10 boolean, doloresespaldapuntaje_txttest_p10 text, anamnesis_txtanamnesis text, apreciaciongeneral_txtapresiaciongeneral text, cabeza_txtcabeza text, piel_txtpiel text, motilidadocular_txtmotilidadocular text, otoscopiaod_txtotoscopiaod text, otoscopiaoi_txtotoscopiaoi text, nariz_txtnariz text, aprespiratorio_txtaprespiratorio text, apcardiovascular_txtapcardiovascuar text, abdomen_txtabdomen text, musculoesqueletico_txtmusculoesqueletico text, columna_txtcolumna text, tesepworth_txttesepworth text, reflejos_txtreflejos text, dedonariznegativo_chkneuro_neg1 boolean, dedonarizpositivo_chkneuro_pos1 boolean, indicebaranynegativo_chkneuro_neg2 boolean, indicebaranypositivo_chkneuro_pos2 boolean, diadococinesianegativo_chkneuro_neg3 boolean, diadococinesiapositivo_chkneuro_pos3 boolean, rombergsimplenegativo_chkneuro_neg4 boolean, rombergsimplepositivo_chkneuro_pos4 boolean, rombergsensibilizadonegativo_chkneuro_neg5 boolean, rombergsensibilizadopositivo_chkneuro_pos5 boolean, marchatandemnegativo_chkneuro_neg6 boolean, marchatandempositivo_chkneuro_pos6 boolean, unterbergnegativo_chkneuro_neg7 boolean, unterbergpositivo_chkneuro_pos7 boolean, babinskinegativo_chkneuro_neg8 boolean, babinskipositivo_chkneuro_pos8 boolean, dixnegativo_chkneuro_neg9 boolean, dixpositivo_chkneuro_pos9 boolean, marchanegativo_chkneuro_neg10 boolean, marchapositivo_chkneuro_pos10 boolean, diagnostico_txtdiagnostico text, apto_chk_apto boolean, noapto_chk_no_apto boolean, aptorestriccion_chk_apto_r boolean, conclusiones_atxtobservaciones text, dniusuario_dni_user integer, otrosexameneslaboratorio_txtotrosexamlab text, altura_txtaltura text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, cinturatriaje_cintura text, icctriaje_icc text, caderatriaje_cadera text, temperaturatriaje_temperatura text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, perimetrocuellotriaje_perimetro_cuello text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, odcc_odcc text, oicc_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlc_odlc text, oilc_oilc text, vc_vc text, vb_vb text, rp_rp text, 
  enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesoftalmo_e_oculares1 text, maximainspiracionptoracico_p_max_inspiracion text, forazadaptoracico_p_ex_forzada text, hemoglobinalaboratorioclinico_txthemoglobina text, hematocritolaboratorioclinico_txthematocrito text, glucosalaboratorioclinico_txtglucosabio text, creatininalaboratorioclinico_txtcreatininabio text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, nombremedico text, cmpusuario text, nombresede text, sede text, color integer, namejasper text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text) AS
$BODY$
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
	    ca.f_examen,
	    ca.f_caducidad,
	    ca.procedencia,
	    ca.t_experiencia,
	    ca.lugar_expe,
	    ca.txtaccidentes_trab,
	    ca.txtantecedente_familiares,

	    ca.chk_psico_si1, ca.chk_psico_no1,
	    ca.chk_psico_si2, ca.chk_psico_no2,
	    ca.chk_psico_si3, ca.chk_psico_no3,
	    ca.chk_psico_si4, ca.chk_psico_no4,
	    ca.chk_psico_si5, ca.chk_psico_no5,
	    ca.chk_psico_si6, ca.chk_psico_no6,
	    ca.chk_psico_si7, ca.chk_psico_no7,

	    ca.txt_antecpsico_1,
	    ca.txt_antecpsico_2,
	    ca.txt_antecpsico_3,
	    ca.txt_antecpsico_4,
	    ca.txt_antecpsico_5,
	    ca.txt_antecpsico_6,
	    ca.txt_antecpsico_7,

	    ca.txt_tabaco_cantiad,
	    ca.txt_tabaco_frecuencia,
	    ca.txt_alcohol_cantiad,
	    ca.txt_alcohol_frecuencia,
	    ca.txt_drogas_cantiad,
	    ca.txt_drogas_frecuencia,
	    ca.txt_hojacoca_cantiad,
	    ca.txt_hojacoca_frecuencia,
	    ca.txt_cafe_cantiad,
	    ca.txt_cafe_frecuencia,

	    ca.chktest_si1,  ca.chktest_no1,  ca.txttest_p1,
	    ca.chktest_si2,  ca.chktest_no2,  ca.txttest_p2,
	    ca.chktest_si3,  ca.chktest_no3,  ca.txttest_p3,
	    ca.chktest_si4,  ca.chktest_no4,  ca.txttest_p4,
	    ca.chktest_si5,  ca.chktest_no5,  ca.txttest_p5,
	    ca.chktest_si6,  ca.chktest_no6,  ca.txttest_p6,
	    ca.chktest_si7,  ca.chktest_no7,  ca.txttest_p7,
	    ca.chktest_si8,  ca.chktest_no8,  ca.txttest_p8,
	    ca.chktest_si9,  ca.chktest_no9,  ca.txttest_p9,
	    ca.chktest_si10, ca.chktest_no10, ca.txttest_p10,
	    --
	    ca.txtanamnesis,
	    ca.txtapresiaciongeneral,
	    ca.txtcabeza,
	    ca.txtpiel,
	    ca.txtmotilidadocular,
	    ca.txtotoscopiaod,
	    ca.txtotoscopiaoi,
	    ca.txtnariz,
	    ca.txtaprespiratorio,
	    ca.txtapcardiovascuar,
	    ca.txtabdomen,
	    ca.txtmusculoesqueletico,
	    ca.txtcolumna,
	    ca.txttesepworth,
	    ca.txtreflejos,

	    ca.chkneuro_neg1,  ca.chkneuro_pos1,
	    ca.chkneuro_neg2,  ca.chkneuro_pos2,
	    ca.chkneuro_neg3,  ca.chkneuro_pos3,
	    ca.chkneuro_neg4,  ca.chkneuro_pos4,
	    ca.chkneuro_neg5,  ca.chkneuro_pos5,
	    ca.chkneuro_neg6,  ca.chkneuro_pos6,
	    ca.chkneuro_neg7,  ca.chkneuro_pos7,
	    ca.chkneuro_neg8,  ca.chkneuro_pos8,
	    ca.chkneuro_neg9,  ca.chkneuro_pos9,
	    ca.chkneuro_neg10, ca.chkneuro_pos10,

	    ca.txtdiagnostico,
	    ca.chk_apto,
	    ca.chk_no_apto,
	    ca.chk_apto_r,
	    ca.atxtobservaciones,
	    ca.dni_user,
	    ca.txtotrosexamlab,
	    ca.txtaltura,

	    t.talla,
	    t.peso,
	    t.imc,
	    t.cintura,
	    t.icc,
	    t.cadera,
	    t.temperatura,
	    t.f_cardiaca,
	    t.sat_02,
	    t.perimetro_cuello,
	    t.sistolica,
	    t.diastolica,
	    t.f_respiratoria,
	    CASE 
		WHEN oft.txtcercasincorregirod IS NOT NULL THEN oft.txtcercasincorregirod
		ELSE o.v_cerca_s_od
	    END AS v_cerca_s_od,

	    CASE 
		WHEN oft.txtcercasincorregiroi IS NOT NULL THEN oft.txtcercasincorregiroi
		ELSE o.v_cerca_s_oi
	    END AS v_cerca_s_oi,

	    -- Visión cerca corregida
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

	    -- Visión lejos sin corregir
	    CASE 
		WHEN oft.txtlejossincorregirod IS NOT NULL THEN oft.txtlejossincorregirod
		ELSE o.v_lejos_s_od
	    END AS v_lejos_s_od,

	    CASE 
		WHEN oft.txtlejossincorregiroi IS NOT NULL THEN oft.txtlejossincorregiroi
		ELSE o.v_lejos_s_oi
	    END AS v_lejos_s_oi,

	    -- Visión lejos corregida
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

	    -- Colores
	    CASE  
		WHEN oft.rbtecishihara_normal = 'TRUE' THEN 'NORMAL'
		WHEN oft.rbtecishihara_anormal = 'TRUE' THEN 'ANORMAL'
		WHEN ol.v_colores IS NULL THEN o.v_colores
		ELSE ol.v_colores
	    END AS VC,

	    -- Binocular
	    CASE  
		WHEN oft.txtbinocularsincorregir IS NOT NULL THEN oft.txtbinocularsincorregir
		WHEN ol.v_binocular IS NULL THEN o.v_binocular
		ELSE ol.v_binocular
	    END AS VB,

	    -- Reflejos Pupilares
	    CASE  
		WHEN oft.txtrp IS NOT NULL THEN oft.txtrp
		WHEN ol.r_pupilares IS NULL THEN o.r_pupilares
		ELSE ol.r_pupilares
	    END AS RP,

	    -- Diagnóstico
	    CASE  
		WHEN oft.txtdiagnostico IS NOT NULL THEN oft.txtdiagnostico
		ELSE o.e_oculares
	    END AS e_oculares,
	    o.e_oculares1,
	    pt.p_max_inspiracion,
	    pt.p_ex_forzada,
	    l.txthemoglobina, l.txthematocrito, l.txtglucosabio, l.txtcreatininabio,
	    l.txtcocaina,l.txtmarihuana,
	    a.txtcolesterol, a.txtldlcolesterol, a.txthdlcolesterol, a.txtvldlcolesterol, a.txttrigliseridos,
	    u.nombre_user||' '||u.apellido_user AS nom_medico, u.cmp_user,
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
	    au.o_d_500, au.o_d_1000, au.o_d_2000,au.o_d_3000, au.o_d_4000, au.o_d_6000, au.o_d_8000, au.o_i_500, au.o_i_1000, au.o_i_2000, 
	    au.o_i_3000, au.o_i_4000, au.o_i_6000, au.o_i_8000,au.diagnostico
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON d.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm 
	    ON n.cod_sede = sm.id
	INNER JOIN triaje AS t 
	    ON n.n_orden = t.n_orden
	LEFT JOIN certificado_altura_poderosa AS ca 
	    ON n.n_orden = ca.n_orden
	LEFT JOIN oftalmologia AS o 
	    ON n.n_orden = o.n_orden
	LEFT JOIN oftalmologia_lo AS ol 
	    ON n.n_orden = ol.n_orden
	LEFT JOIN oftalmologia2021 AS oft 
	    ON n.n_orden = oft.n_orden
	LEFT JOIN perimetro_toracico AS pt
	    ON n.n_orden = pt.n_orden
	LEFT JOIN lab_clinico AS l 
	    ON l.n_orden=n.n_orden
	LEFT JOIN analisis_bioquimicos AS a 
	    ON (a.n_orden=n.n_orden)
	LEFT JOIN audiometria_po AS au 
	    ON (au.n_orden=n.n_orden)
	LEFT JOIN usuarios AS u 
	    ON (u.dni_user = ca.dni_user)
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;


-- insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
-- 			values('informe_psicolaboral','formulario de informe psicolaboral',false,false,true,false,false);








CREATE OR REPLACE FUNCTION obtener_antecedentes_patologicos_quirurgicos(
    IN p_norden integer	)
  RETURNS TABLE(
  codigoAntecedentesPatologicosQuirurgicos integer,
  hospitalOperacion text,
  operacion text,
  diasHospitalizado text,
  complicaciones text,
  fechaAntecedentesPatologicosQuirurgicos text
  ) AS
$BODY$
DECLARE
	existeAntecedente boolean;
BEGIN
    SELECT CASE WHEN  COUNT(*) >0 THEN TRUE ELSE FALSE END INTO existeAntecedente
    FROM antecedentes_patologicos
    WHERE n_orden = p_norden;
    RETURN QUERY
	SELECT 
	    apq.cod_ap AS codigoAntecedentesPatologicosQuirurgicos,
	    apq.hospital_operacion AS hospitalOperacion,
	    apq.operacion,
	    apq.dias_hospitalizado AS diasHospitalizado,
	    apq.complicaciones,
	    apq.fecha AS fechaAntecedentesPatologicosQuirurgicos
	FROM datos_paciente AS d
	INNER JOIN n_orden_ocupacional AS n 
	    ON n.cod_pa = d.cod_pa
	INNER JOIN antecedentes_patologicos AS ap
	    ON ap.n_orden = n.n_orden
	LEFT JOIN antecedentes_patologicos_quirurgicos AS apq 
	    ON ap.cod_ap = apq.cod_ap
	WHERE 
	    (existeAntecedente = TRUE AND ap.n_orden = p_norden)
	    OR
	    (
	     existeAntecedente = FALSE AND
	     n.n_orden IN (
			SELECT DISTINCT nno.n_orden
			FROM datos_paciente AS dp
			INNER JOIN n_orden_ocupacional AS nno
			    ON nno.cod_pa = dp.cod_pa
			INNER JOIN antecedentes_patologicos AS ap2
			    ON ap2.n_orden = nno.n_orden
			INNER JOIN antecedentes_patologicos_quirurgicos AS apq2
			    ON ap2.cod_ap = apq2.cod_ap
			WHERE dp.cod_pa = (
			     SELECT nnno.cod_pa FROM n_orden_ocupacional nnno WHERE nnno.n_orden = p_norden
			)
	        )
	    )
	    ORDER BY apq.fecha DESC;

END;
$BODY$
  LANGUAGE plpgsql;








-----------------------------------------------------------------------------
--PGADMIN 4

CREATE TABLE area_secuencia (
    prefijo VARCHAR(10) PRIMARY KEY,
    ultimo_numero INTEGER NOT NULL DEFAULT 0
);

create table area (
	id_area SERIAL PRIMARY KEY,
	prefijo VARCHAR(10) NOT NULL,
	codigo VARCHAR(15),
	descripcion TEXT,
	estado BOOLEAN NOT NULL
);

create table examen (
	id_examen SERIAL PRIMARY KEY,
	id_area INTEGER NOT NULL,
	orden INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	descripcion TEXT,
	estado BOOLEAN,
	precio_referencial NUMERIC(10,2),
	FOREIGN KEY (id_area) REFERENCES area(id_area)
);

ALTER TABLE examen
ADD COLUMN prefijo VARCHAR(50);

create table protocolo (
	id_protocolo SERIAL PRIMARY KEY,
	nombre TEXT NOT NULL,
	descripcion TEXT,
	precio INTEGER,
	estado BOOLEAN NOT NULL
)

create table protocolo_examenes (
	id_protocolo_examen SERIAL PRIMARY KEY,
	id_protocolo INTEGER NOT NULL,
	id_examen INTEGER NOT NULL,
	precio NUMERIC(10,2),
	estado BOOLEAN NOT NULL,
	orden INTEGER,
	FOREIGN KEY (id_protocolo) REFERENCES protocolo(id_protocolo),
	FOREIGN KEY (id_examen) REFERENCES examen(id_examen)
)

create table protocolo_empresa (
	id_protocolo_empresa SERIAL PRIMARY KEY,
	id_protocolo INTEGER NOT NULL,
	ruc_empresa TEXT NOT NULL,
	estado BOOLEAN NOT NULL,
	FOREIGN KEY (id_protocolo) REFERENCES protocolo(id_protocolo)
)

create table sub_examen (
	id_sub_examen SERIAL PRIMARY KEY,
	id_examen INTEGER NOT NULL,
	descripcion TEXT,
	prefijo TEXT,
	precio NUMERIC(10,2),
	estado BOOLEAN DEFAULT 'true',
	FOREIGN KEY (id_examen) REFERENCES examen(id_examen)
)

create table protocolo_sub_examenes (
	id_protocolo_sub_examen SERIAL PRIMARY KEY,
	id_protocolo INTEGER NOT NULL,
	id_sub_examen INTEGER NOT NULL,
	estado BOOLEAN NOT NULL,
	FOREIGN KEY (id_protocolo) REFERENCES protocolo(id_protocolo),
	FOREIGN KEY (id_sub_examen) REFERENCES sub_examen(id_sub_examen)
)


-- Función para generar el código de área
CREATE OR REPLACE FUNCTION generar_codigo_area()
RETURNS TRIGGER AS $$
DECLARE
    nuevo_numero INTEGER;
BEGIN
    -- Se actualiza el contador para el prefijo
    UPDATE area_secuencia
    SET ultimo_numero = ultimo_numero + 1
    WHERE prefijo = NEW.prefijo
    RETURNING ultimo_numero INTO nuevo_numero;

    -- Si no existe el prefijo en la tabla de secuencias, lo insertamos
    IF NOT FOUND THEN
        INSERT INTO area_secuencia (prefijo, ultimo_numero)
        VALUES (NEW.prefijo, 1)
        RETURNING ultimo_numero INTO nuevo_numero;
    END IF;

    -- Generamos el código con el prefijo y el número en 3 dígitos
    NEW.codigo := NEW.prefijo || LPAD(nuevo_numero::TEXT, 3, '0');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generar_codigo_area
BEFORE INSERT ON area
FOR EACH ROW
EXECUTE FUNCTION generar_codigo_area();


-- Función para calcular el orden
CREATE OR REPLACE FUNCTION set_orden_examen()
RETURNS TRIGGER AS $$
DECLARE
    max_orden INTEGER;
BEGIN
    -- Buscar el máximo orden dentro del área considerando solo los activos
    SELECT COALESCE(MAX(orden), 0)
    INTO max_orden
    FROM examen
    WHERE id_area = NEW.id_area AND estado = TRUE;

    -- Asignar el nuevo orden
    NEW.orden := max_orden + 1;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que llama a la función antes de insertar
CREATE TRIGGER trigger_set_orden_examen
BEFORE INSERT ON examen
FOR EACH ROW
EXECUTE FUNCTION set_orden_examen();


-- Función para calcular el orden
CREATE OR REPLACE FUNCTION set_orden_protocolo_examenes()
RETURNS TRIGGER AS $$
DECLARE
    max_orden INTEGER;
BEGIN
    -- Buscar el máximo orden dentro del área considerando solo los activos
    SELECT COALESCE(MAX(orden), 0)
    INTO max_orden
    FROM protocolo_examenes
    WHERE id_protocolo = NEW.id_protocolo AND estado = TRUE;

    -- Asignar el nuevo orden
    NEW.orden := max_orden + 1;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que llama a la función antes de insertar
CREATE TRIGGER trigger_set_orden_protocolo_examenes
BEFORE INSERT ON protocolo_examenes
FOR EACH ROW
EXECUTE FUNCTION set_orden_protocolo_examenes();

-- LISTADO DE PROTOCOLO POR FILTROS, V01



CREATE OR REPLACE FUNCTION listado_protocolo_busqueda_filtros(
	user_name_param text,razon_empre_param text, razon_emp_cont text)
    RETURNS TABLE(id_resp bigint, mensaje text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	

BEGIN

	    RETURN QUERY 
SELECT DISTINCT 
       CAST(prot.id_protocolo AS bigint) AS id_resp,
       prot.nombre as mensaje
FROM protocolo AS prot
INNER JOIN protocolo_empresa AS prot_emp 
    ON prot.id_protocolo = prot_emp.id_protocolo
INNER JOIN usuario_empresa_contrada AS user_prot_empcont  -- corregí el nombre
    ON prot_emp.ruc_empresa = user_prot_empcont.ruc
INNER JOIN usuario AS us 
    ON user_prot_empcont.id_user = us.id_user
WHERE us.username = user_name_param;

END; 
$BODY$;


-- BUSQUEDA DE EXAMENES SEGUN PROTOCOLO
CREATE OR REPLACE FUNCTION listado_examenes_protocolos_paciente(
	protocolo_param text,historia_clinica_param integer)
    RETURNS TABLE(id_archivos bigint, nombre text,ruta text,valor boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	

BEGIN

	    RETURN QUERY 
select cast (1 as bigint),cast(tb1.nombre as text) as nombre, cast (tb2.ruta_Archivo as text)as ruta , ( case  when tb2.id_archivos is not null then  true else false end )as valor
FROM (
    SELECT exam.prefijo, exam.nombre
    FROM protocolo AS prot
    INNER JOIN protocolo_examenes AS prot_exam
        ON prot.id_protocolo = prot_exam.id_protocolo
    INNER JOIN examen AS exam
        ON prot_exam.id_examen = exam.id_examen
    WHERE prot.nombre = protocolo_param
      AND exam.prefijo IS NOT NULL
) as tb1
LEFT JOIN (
	select arch_Serv.id_archivos,arch_Serv.ruta_Archivo ,tip_Arch.nomenclatura 
	from archivos_servidores as arch_Serv 
	inner join tipo_archivo as tip_Arch 
	on arch_Serv.id_tipo_archivo=tip_Arch.id_tipo_archivo
	WHERE arch_Serv.orden=historia_clinica_param) 
	AS tb2 on tb1.prefijo =tb2.nomenclatura;

END; 
$BODY$;


-- PG ADMIN 3

CREATE OR REPLACE FUNCTION listado_pacientes_protocolo_busqueda_filtros(
	razon_empresa_param text,razon_contrata_param text, name_protocolo_param text, fecha_inicio_param date, fecha_fin_param date)
    RETURNS TABLE(protocolos text, nombres text,dni integer,n_orden integer, razon_empresa text, razon_contrata text, tipoexamen text, fechaexamen date) 
    LANGUAGE 'plpgsql'
AS $BODY$
	
BEGIN

	    RETURN QUERY 
	select  n.protocolo,dp.nombres_pa || ' ' || dp.apellidos_pa as nombres,n.cod_pa as dni,n.n_orden, n.razon_empresa, n.razon_contrata,n.nom_examen as tipoExamen,n.fecha_apertura_po as fechaExamen   
	from n_orden_ocupacional as n inner join datos_paciente as dp on n.cod_pa=dp.cod_pa
	where n.razon_empresa=razon_empresa_param and n.fecha_apertura_po BETWEEN fecha_inicio_param AND fecha_fin_param;

END; 
$BODY$;


------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(
	user_name text)
    RETURNS TABLE(id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying,
	empresas text, contratas text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	DECLARE validar_empresa_hm BIGINT;

BEGIN
	select count(emp.id_empleado) into validar_empresa_hm from empleado as emp inner join usuario as us on emp.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc='20477167561' and us.username=user_name;
		
	
	if(validar_empresa_hm>0) then
	RETURN QUERY 
		select empl.id_empleado, empl.apellidos , empl.cargo , empl.celular , empl.cip , empl.correo_elect, empl.direccion, empl.estado, 
		empl.fecha_actualizacion , empl.fecha_nacimiento , empl.fecha_registro , empl.nombres , empl.num_documento , 
		empl.tel_fijo, empl.tipo_doc, empl.ubigeo , empl.user_actualizacion, empl.user_registro,empl.sexo,
		(
			SELECT 
			    STRING_AGG(DISTINCT e1.razon_empresa, ' - ') AS empresas
			FROM empleado AS empl1
			INNER JOIN usuario AS us1 ON empl1.id_empleado = us1.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec1 ON us1.id_user = uec1.id_user
			INNER JOIN empresas AS e1 ON uec1.ruc = e1.ruc_empresa AND uec1.tipo = 'EMPRESA'
			WHERE uec1.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado
			)
			GROUP BY empl1.id_empleado
		),
		(
			SELECT 
			    STRING_AGG(DISTINCT e1.razon_contrata, ' - ') AS contratas
			FROM empleado AS empl1
			INNER JOIN usuario AS us1 ON empl1.id_empleado = us1.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec1 ON us1.id_user = uec1.id_user
			INNER JOIN contratas AS e1 ON uec1.ruc = e1.ruc_contrata AND uec1.tipo = 'CONTRATA'
			WHERE uec1.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us1.id_empleado = empl.id_empleado
			)
			GROUP BY empl1.id_empleado
		)
		from empleado as empl;
 	else
	    RETURN QUERY 
	
	select emp.id_empleado, emp.apellidos , emp.cargo , emp.celular , emp.cip , emp.correo_elect, emp.direccion, 
		emp.estado, emp.fecha_actualizacion, emp.fecha_nacimiento, emp.fecha_registro, emp.nombres, emp.num_documento, emp.tel_fijo, emp.tipo_doc, emp.ubigeo , emp.user_actualizacion, 
		emp.user_registro,emp.sexo,
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_empresa, ' - ') AS empresas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN empresas AS e ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		),
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_contrata, ' - ') AS contratas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN contratas AS e ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		)
		 from empleado as emp where emp.id_empleado in (select distinct(empl.id_empleado) from empleado as empl inner join usuario as us on empl.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc in (select distinct(ue.ruc) from usuario_empresa_contrada as ue inner join usuario as u on ue.id_user=u.id_user where u.username=user_name))
	union
	select e.id_empleado, e.apellidos , e.cargo , e.celular , e.cip , e.correo_elect, e.direccion, e.estado, e.fecha_actualizacion , e.fecha_nacimiento , 
		e.fecha_registro , e.nombres , e.num_documento , e.tel_fijo, e.tipo_doc, e.ubigeo , e.user_actualizacion, 
		e.user_registro,e.sexo,
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_empresa, ' - ') AS empresas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN empresas AS e ON uec.ruc = e.ruc_empresa AND uec.tipo = 'EMPRESA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		),
		(
			SELECT 
			    STRING_AGG(DISTINCT e.razon_contrata, ' - ') AS contratas
			FROM empleado AS empl
			INNER JOIN usuario AS us ON empl.id_empleado = us.id_empleado
			INNER JOIN usuario_empresa_contrada AS uec ON us.id_user = uec.id_user
			INNER JOIN contratas AS e ON uec.ruc = e.ruc_contrata AND uec.tipo = 'CONTRATA'
			WHERE uec.ruc IN (
			    SELECT DISTINCT ue.ruc
			    FROM usuario_empresa_contrada AS ue
			    INNER JOIN usuario AS u ON ue.id_user = u.id_user
			    WHERE u.username = user_name AND us.id_empleado = emp.id_empleado
			)
			GROUP BY empl.id_empleado
		)
		from empleado as e where e.user_registro=user_name;
	end if;

END; 
$BODY$;

ALTER FUNCTION public.listado_empleado_por_username(text)
    OWNER TO developerhm;


----- COPIA SEGURIDAD -----------
-- FUNCTION: public.listado_empleado_por_username(text)

-- DROP FUNCTION IF EXISTS public.listado_empleado_por_username(text);

CREATE OR REPLACE FUNCTION public.listado_empleado_por_username(
	user_name text)
    RETURNS TABLE(id_empleado bigint, apellidos character varying, cargo character varying, celular character varying, cip character varying, correo_elect character varying, direccion character varying, estado boolean, fecha_actualizacion date, fecha_nacimiento date, fecha_registro date, nombres character varying, num_documento bigint, tel_fijo character varying, tipo_doc character varying, ubigeo character varying, user_actualizacion character varying, user_registro character varying, sexo character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	DECLARE validar_empresa_hm BIGINT;

BEGIN
	select count(emp.id_empleado) into validar_empresa_hm from empleado as emp inner join usuario as us on emp.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc='20477167561' and us.username=user_name;
		
	
	if(validar_empresa_hm>0) then
	RETURN QUERY 
		select empl.id_empleado, empl.apellidos , empl.cargo , empl.celular , empl.cip , empl.correo_elect, empl.direccion, empl.estado, 
		empl.fecha_actualizacion , empl.fecha_nacimiento , empl.fecha_registro , empl.nombres , empl.num_documento , 
		empl.tel_fijo, empl.tipo_doc, empl.ubigeo , empl.user_actualizacion, empl.user_registro,empl.sexo
		from empleado as empl;
 	else
	    RETURN QUERY 
	
	select emp.id_empleado, emp.apellidos , emp.cargo , emp.celular , emp.cip , emp.correo_elect, emp.direccion, 
		emp.estado, emp.fecha_actualizacion, emp.fecha_nacimiento, emp.fecha_registro, emp.nombres, emp.num_documento, emp.tel_fijo, emp.tipo_doc, emp.ubigeo , emp.user_actualizacion, 
		emp.user_registro,emp.sexo
		 from empleado as emp where emp.id_empleado in (select distinct(empl.id_empleado) from empleado as empl inner join usuario as us on empl.id_empleado=us.id_empleado inner join
	usuario_empresa_contrada as uec on us.id_user=uec.id_user where uec.ruc in (select distinct(ue.ruc) from usuario_empresa_contrada as ue inner join usuario as u on ue.id_user=u.id_user where u.username=user_name))
	union
	select e.id_empleado, e.apellidos , e.cargo , e.celular , e.cip , e.correo_elect, e.direccion, e.estado, e.fecha_actualizacion , e.fecha_nacimiento , 
		e.fecha_registro , e.nombres , e.num_documento , e.tel_fijo, e.tipo_doc, e.ubigeo , e.user_actualizacion, 
		e.user_registro,e.sexo  from empleado as e where e.user_registro=user_name;
	end if;

END; 
$BODY$;

ALTER FUNCTION public.listado_empleado_por_username(text)
    OWNER TO developerhm;
