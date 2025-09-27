CREATE OR REPLACE FUNCTION obtener_reporte_ficha_anexo_2(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(
dniPaciente integer,
nombresPaciente text,
apellidosPaciente text,
direccionPaciente text,
sexoPaciente "char",
fechaNacimientoPaciente date,
ocupacionPaciente text,
cargoPaciente text,
areaPaciente text,
contrata text,
norden text,
empresa text,
nombreExamen text,
edadPaciente text,
observacionesFichaMedica text,
fechaDesde date,
restriccionesDescripcion text,
recomendaciones text,
conclusiones text,
fechaHasta date,
horaSalida time,
apto boolean,
aptoConRestriccion boolean,
noApto boolean,
nombreMedico text,
color integer,
sede text,
nombreSede text,
nameJasper text
  ) AS
$BODY$
BEGIN
    RETURN QUERY
    SELECT 
	    dp.cod_pa,
	    dp.nombres_pa,
	    dp.apellidos_pa,
	    dp.direccion_pa,
	    dp.sexo_pa,
	    dp.fecha_nacimiento_pa,
	    dp.ocupacion_pa,
	    n.cargo_de,
	    n.area_o,
	    n.razon_contrata,
	    n.n_orden,
	    n.razon_empresa,
	    n.nom_examen,
	    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
	    a.txtobservacionesfm,
	    a.fechadesde,
	    b.atxtrestricciones,
	    b.txtrecomendaciones,
	    b.txtconclusiones,
	    b.fecha_hasta,
	    b.horasalida,
	    b.chkapto,
	    b.chkapto_restriccion,
	    b.chkno_apto,
	    a.medico,
	    n.color,
    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
    CASE
        WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
        WHEN n.cod_sede = 1 THEN 'Trujillo'
        WHEN n.cod_sede = 2 THEN 'Huamachuco'
        WHEN n.cod_sede = 3 THEN 'Huancayo'
        WHEN n.cod_sede = 4 THEN 'Trujillo'
    END AS nom_sede
    --obtener_name_jasper(p_norden, name_service)
  FROM datos_paciente AS dp
	INNER JOIN n_orden_ocupacional AS n 
	    ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal AS sm ON n.cod_sede = sm.id
	INNER JOIN anexo_agroindustrial AS a 
	    ON a.n_orden = n.n_orden
	INNER JOIN aptitud_medico_ocupacional_agro AS b 
	    ON b.n_orden = n.n_orden
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;


ALTER TABLE antecedentes_patologicos
ADD COLUMN ruido BOOLEAN,
ADD COLUMN vid_total BOOLEAN,
ADD COLUMN cancerigenos BOOLEAN,
ADD COLUMN metales BOOLEAN,
ADD COLUMN biologicos BOOLEAN,
ADD COLUMN quimicos BOOLEAN,
ADD COLUMN pvd BOOLEAN,
ADD COLUMN polvo BOOLEAN,
ADD COLUMN altura_estructura BOOLEAN,
ADD COLUMN mutagenicos BOOLEAN,
ADD COLUMN altura_geografica BOOLEAN,
ADD COLUMN posturas BOOLEAN,
ADD COLUMN cargas BOOLEAN,
ADD COLUMN electricos BOOLEAN,
ADD COLUMN vid_segmentario BOOLEAN,
ADD COLUMN vibraciones BOOLEAN,
ADD COLUMN solventes BOOLEAN,
ADD COLUMN temperatura BOOLEAN,
ADD COLUMN turnos BOOLEAN,
ADD COLUMN mov_repet BOOLEAN,
ADD COLUMN otros BOOLEAN,
ADD COLUMN otros_descripcion TEXT;

CREATE OR REPLACE FUNCTION obtener_reporte_anexo16(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(fechaanexo7c_fecha date, telefonotrabajopaciente_tel_trabajo_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, dni_cod_pa integer, sexo_sexo_pa "char", numerocontacto_num_contacto text, direccionpaciente_direccion text, fechanacimientopaciente_fecha_nacimiento_pa date, lugarnacimientopaciente_lugar_nac_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiopaciente_nivel_est_pa text, cargo_cargo_de text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, empresa_razon_empresa text, explotacion_nom_ex text, altura_altura_po text, contrata_razon_contrata text, norden_n_orden integer, fechaapertura_fecha_apertura_po date, nombreexamen_nom_examen text, mineral_mineral_po text, nombres_nombres text, edad_edad text, perimetrocuellotriaje_perimetro_cuello text, imctriaje_imc text, pesotriaje_peso text, tallatriaje_talla text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, temperaturatriaje_temperatura text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, otrosanexo7c_chkotros boolean, reubicacionsianexo7c_tbrsi boolean, reubicacionnoanexo7c_rbrno boolean, puestoactualanexo7c_txtpuestoactual text, tiempoanexo7c_txttiempo text, antecedentespersonalesanexo7c_txtantecedentespersonales text, antecedentesfamiliaresanexo7c_txtantecedentesfamiliares text, tetanoanexo7c_tetano boolean, hepatitisbanexo7c_hepatitisb boolean, fiebreamarillaanexo7c_fiebreamarilla boolean, hijosvivosanexo7c_txthijosvivos text, hijosmuertosanexo7c text, tabaconadaaexo7c_chktnada boolean, tabacopocoanexo7c_chktpoco boolean, tabacohabitualanexo7c_chkthabitual boolean, tabacoexcesivoanexo7c_chktexcesivo boolean, alcoholnadaanexo7c_chkanada boolean, alcoholpocoanexo7c_chkapoco boolean, alcoholhabitualanexo7c_chkahabitual boolean, alcoholexcesivoanexo7c_chkaexcesivo boolean, drogasnadaanexo7c_chkdnada boolean, drogaspocoanexo7c_chkdpoco boolean, drogashabitualanexo7c_chkdhabitual boolean, drogasexcesivoanexo7c_chkdexcesivo boolean, conclusionanexo7c_txtconclusion text, cabezaanexo7c_txtcabeza text, narizanexo7c_txtnariz text, cuelloanexo7c_txtcuello text, perimetroanexo7c_txtperimetro text, baflanexo7c_txtb_a_f_l text, visioncoloresanexo7c_txtvisioncolores text, enfermedadesocularesanexo7c_txtenfermedadesoculares text, reflejospupilaresanexo7c_txtreflejospupilares text, binocularanexo7c_txtbinocular text, odanexo7c_txtod text, oianexo7c_txtoi text, toraxanexo7c_txttorax text, corazonanexo7c_txtcorazon text, pulmonesnormalanexo7c_rbnormal boolean, pulmonesanormalanexo7c_rbanormal boolean, pulmonesdescripcionanexo7c_txtpulmones text, miembrossuperioresanexo7c_txtmiembrossuperiores text, miembrosinferioresanexo7c_txtmiembrosinferiores text, ausentesodontograma_txtausentes integer, piezasmalestadoodontograma_txtpiezasmalestado integer, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, odcc_odcc text, oicc_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlc_odlc text, oilo_oilc text, vc_vc text, vb_vb text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, enfermedadesocularesvisionlejos_e_oculvisionlejos text, tecishiharanormal_rbtecishihara_normal boolean, tecishiharaanormal_rbtecishihara_anormal boolean, teccoleresnormal_rbteccoleres_normal boolean, teccoleresanormal_rbteccoleres_anormal boolean, tecestereopsianormal_rbtecestereopsia_normal boolean, tecestereopsiaanormal_rbtecestereopsia_anormal boolean, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, reflejososteotendinososanexo7c_txtreflejososteotendinosos text, marchaanexo7c_txtmarcha text, columnavertebralanexo7c_txtcolumnavertebral text, abdomenanexo7c_txtabdomen text, anillosinguinalesanexo7c_txtanillosinguinales text, organosgenitalesanexo7c_txtorganosgenitales text, tactorectalnohizoanexo7c_rbtnohizo boolean, tactorectalnormalanexo7c_rbtnormal boolean, tactorectalanormalanexo7c_rbtanormal boolean, describirobservacionanexo7c_chkdescribirobservacion boolean, herniasanexo7c_txthernias text, varicesanexo7c_txtvarices text, gangliosanexo7c_txtganglios text, lenguageanexo7c_txtlenguage text, observacionesfichamedicaanexo7c_txtobservacionesfm text, nrx_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, conclusionmedicoanexo7c_txtconclusionmed text, estadomentalanexo7c_txtestadomental text, anamnesisanexo7c_txtanamnesis text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, verticesradiografiatorax_txtvertices text, hilosradiografiatorax_txthilios text, senoscostofrenicos_txtsenoscostofrenicos text, meadiastinos_txtmediastinos text, siluetacardiovascular_txtsiluetacardiovascular text, conclusionesradiograficas_txtconclusionesradiograficas text, color integer, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, glucosalaboratorioclinico_txtglucosabio text, creatininalaboratorioclinico_txtcreatininabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, creatininaanalisisbioquimico_txtcreatinina text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliceridosanalisisbioquimico_txttrigliceridos text, sede text, nombresede text, numero text, codigoanexo7c_cod_anexo integer, namejasper text, pielanexo7c_piel boolean, pieldescripcionanexo7c_piel_descripcion text) AS
$BODY$
BEGIN
    RETURN QUERY
	SELECT 
	    a.fecha,
	    d.tel_trabajo_pa,
	    d.tel_casa_pa,
	    d.cel_pa,
	    d.cod_pa,
	    d.sexo_pa,
	    CASE
		WHEN LENGTH(TRIM(CAST(d.tel_casa_pa AS TEXT))) > 1 THEN d.tel_casa_pa
		ELSE d.cel_pa
	    END AS num_contacto,
	    d.direccion_pa ||'-'|| d.distrito_pa ||'-'|| d.provincia_pa ||'-'|| d.departamento_pa as direccion,
	    d.fecha_nacimiento_pa,
	    d.lugar_nac_pa,
	    d.estado_civil_pa,
	    d.nivel_est_pa,
	    n.cargo_de,
	    f.fvc,
	    f.fev1,
	    f.fev1fvc,
	    f.fef25_75,
	    n.razon_empresa,
	    n.nom_ex,
	    n.altura_po,
	    n.razon_contrata,
	    n.n_orden,
	    n.fecha_apertura_po,
	    e.nom_examen,
	    n.mineral_po,
	    d.apellidos_pa||' '||d.nombres_pa as nombres,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
	    t.perimetro_cuello,
	    t.imc,
	    t.peso,
	    t.talla,
	    t.cintura,
	    t.cadera,
	    t.icc,
	    t.temperatura,
	    t.f_respiratoria,
	    t.f_cardiaca,
	    t.sat_02,
	    t.sistolica,
	    t.diastolica,
	    CASE WHEN apt.ruido IS NULL THEN a.chkruido ELSE apt.ruido END,
	    CASE WHEN apt.polvo IS NULL THEN a.chkpolvo ELSE apt.polvo END,
	    CASE WHEN apt.vid_segmentario IS NULL THEN a.chkvidsegmentario ELSE apt.vid_segmentario END,
	    CASE WHEN apt.vid_total IS NULL THEN a.chkvidtotal ELSE apt.vid_total END,
	    CASE WHEN apt.cancerigenos IS NULL THEN a.chkcancerigenos ELSE apt.cancerigenos END,
	    CASE WHEN apt.mutagenicos IS NULL THEN a.chkmutagenicos ELSE apt.mutagenicos END,
	    CASE WHEN apt.solventes IS NULL THEN a.chksolventes ELSE apt.solventes END,
	    CASE WHEN apt.metales IS NULL THEN a.chkmetales ELSE apt.metales END,
	    CASE WHEN apt.temperatura IS NULL THEN a.chktemperatura ELSE apt.temperatura END,
	    CASE WHEN apt.biologicos IS NULL THEN a.chkbiologicos ELSE apt.biologicos END,
	    CASE WHEN apt.posturas IS NULL THEN a.chkposturas ELSE apt.posturas END,
	    CASE WHEN apt.turnos IS NULL THEN a.chkturnos ELSE apt.turnos END,
	    CASE WHEN apt.cargas IS NULL THEN a.chkcargas ELSE apt.cargas END,
	    CASE WHEN apt.mov_repet IS NULL THEN a.chkmovrepet ELSE apt.mov_repet END,
	    CASE WHEN apt.pvd IS NULL THEN a.chkpvd ELSE apt.pvd END,
	    CASE WHEN apt.otros IS NULL THEN a.chkotros ELSE apt.otros END,
	    a.tbrsi,
	    a.rbrno,
	    a.txtpuestoactual,
	    a.txttiempo,
	    a.txtantecedentespersonales,
	    a.txtantecedentesfamiliares,
	    a.tetano,
	    a.hepatitisb,
	    a.fiebreamarilla,
	    a.txthijosvivos,
	    a.txthijosmuertos,
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
	    a.txtconclusion,
	    a.txtcabeza,
	    a.txtnariz,
	    a.txtcuello,
	    a.txtperimetro,
	    a.txtb_a_f_l,
	    a.txtvisioncolores,
	    a.txtenfermedadesoculares,
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
	    od.txtausentes,
	    od.txtpiezasmalestado,
	    
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
	    CASE WHEN ol.v_colores IS NULL THEN o.v_colores  ELSE ol.v_colores  END as VC,
	    CASE WHEN oft.txtbinocularsincorregir IS not NULL THEN oft.txtbinocularsincorregir
		 WHEN ol.v_binocular IS NULL THEN o.v_binocular
		 ELSE ol.v_binocular  END as VB,
	    CASE WHEN ol.r_pupilares IS NULL THEN o.r_pupilares  ELSE ol.r_pupilares  END as RP,
	    CASE WHEN oft.txtdiagnostico IS not NULL THEN oft.txtdiagnostico  else o.e_oculares end as e_oculares,
	    o.e_oculares1,
	    o.e_oculvisionlejos, 
	    oft.rbtecishihara_normal,
	    oft.rbtecishihara_anormal,
	    oft.rbteccoleres_normal,
	    oft.rbteccoleres_anormal,
	    oft.rbtecestereopsia_normal,
	    oft.rbtecestereopsia_anormal,
	    
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
	    e2.n_rx,
	    e2.fecha_exra,
	    e2.txtcalidad,
	    e2.txtsimbolos,
	    a.txtconclusionmed,
	    a.txtestadomental,
	    a.txtanamnesis,
	    e2.ex_0,
	    e2.ex_10,
	    e2.ex_11,
	    e2.ex_12,
	    e2.ex_21,
	    e2.ex_22,
	    e2.ex_23,
	    e2.ex_32,
	    e2.ex_33,
	    e2.ex_3mas,
	    e2.ex_abc,
	    e2.ex_st,
	    e2.txtsinneumoconiosis,
	    e2.txtconneumoconiosis,
	    e2.txtirep,
	    e2.txtotrosex,
	    e2.apto_si,
	    e2.apto_no,
	    e2.apto_re,
	    r.txtvertices,
	    r.txthilios,
	    r.txtsenoscostofrenicos,
	    r.txtmediastinos,
	    r.txtsiluetacardiovascular,
	    r.txtconclusionesradiograficas,
	    n.color,
	    l.chko,
	    l.chka,
	    l.chkb,
	    l.chkab,
	    l.rbrhpositivo,
	    l.rbrhnegativo,
	    l.txthemoglobina,
	    l.chkpositivo,
	    l.chknegativo,
	    l.txtglucosabio,
	    l.txtcreatininabio,
	    l.txtvsg,
	    l.txtcocaina,
	    l.txtmarihuana,
	    ab.txtcreatinina,
	    ab.txtcolesterol,
	    ab.txtldlcolesterol,
	    ab.txthdlcolesterol,
	    ab.txtvldlcolesterol,
	    ab.txttrigliseridos,
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
	    CASE
		    WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
		    WHEN n.cod_sede = 1 THEN 'Trujillo'
		    WHEN n.cod_sede = 2 THEN 'Huamachuco'
		    WHEN n.cod_sede = 3 THEN 'Huancayo'
		    WHEN n.cod_sede = 4 THEN 'Trujillo'
	    END AS nombreSede,
	    (case when n.cod_sede=1 then CONCAT(n.n_orden,'-T')
		  when n.cod_sede=4 then CONCAT(n.n_orden,'-TP')
		  else CONCAT(n.n_orden,'-H') 
	     END) as numero,
	     a.cod_anexo,
	     obtener_name_jasper(p_norden, name_service),
	     a.piel,
	     a.piel_descripcion
	FROM n_orden_ocupacional AS n
	INNER JOIN datos_paciente AS d ON (n.cod_pa = d.cod_pa)
	INNER JOIN sede_multisucursal AS sm ON n.cod_sede = sm.id
	INNER JOIN examen_medico_ocupacional AS e ON (e.nom_examen = n.nom_examen)
	INNER JOIN anexo7c AS a ON (a.n_orden = n.n_orden)
	INNER JOIN triaje AS t ON (t.n_orden = n.n_orden)
	LEFT JOIN oftalmologia AS o ON (o.n_orden = n.n_orden)
	LEFT JOIN audiometria_2021 AS au ON (n.n_orden = au.n_orden)
	LEFT JOIN audiometria_2023 AS a25 ON (n.n_orden = a25.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	INNER JOIN funcion_abs AS f ON (f.n_orden = n.n_orden)
	INNER JOIN odontograma AS od ON (od.n_orden = n.n_orden)
	LEFT JOIN audiometria_po AS m ON (m.n_orden = n.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (ol.n_orden = n.n_orden)
	INNER JOIN radiografia_torax AS r ON (r.n_orden = n.n_orden)
	INNER JOIN lab_clinico AS l ON (l.n_orden = n.n_orden)
	INNER JOIN ex_radiograficos_sanguineos AS e2 ON (e2.n_orden = n.n_orden)
	LEFT JOIN analisis_bioquimicos AS ab ON (n.n_orden = ab.n_orden)
	LEFT JOIN antecedentes_patologicos AS apt ON (n.n_orden = apt.n_orden)
	WHERE n.n_orden = p_norden
	LIMIT 1;
END;
$BODY$
  LANGUAGE plpgsql;

drop FUNCTION obtener_anexo7c(IN p_norden integer)

CREATE OR REPLACE FUNCTION obtener_anexo7c(IN p_norden integer)
  RETURNS TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiospaciente_nivel_est_pa text, norden_n_orden integer, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, area_area_o text, grupofactorsanguineo_grupofactorsan text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, dhijosvivosantecedentes_txtdhijosvivos text, dhijosfallecidosantecedentes_txtdhijosfallecidos text, antecedentes_rbfumarsi boolean, antecedentes_rblicorsi boolean, antecedentespatologicos_ante_patologicos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, odcc_odcc text, oicc_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlc_odlc text, oilo_oilc text, vc_vc text, vb_vb text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, visionlejosoftalmo_e_oculvisionlejos text, diagnosticooftalmologia2021_txtdiagnostico text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, observacionesradiografiatorax_txtobservacionesrt text, campospulmonesradiografiatorax_txtcampospulm text, observacioneslaboratorioclinico_txtobservacioneslb text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, creatininalaboratorioclinico_txtcreatininabio text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, grupofactorsanguineolaboratorioclinico_grupofactor text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, ordenalturacertificado_ordenaltura integer, observacionesalturacertificado_alturabarrick text, ordenconduccioncertificado_ordencond integer, observacionesconduccioncertificado_conduccion text, numeroalturacertificacion_numalt integer, observacionesalturacertificacion_certialtura text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, infogeneralradiografia_info_general text, conclusionradiografia_conclu text, anamnesisagroindustrial_txtanamnesis text, estadomentalagroindustrial_txtestadomental text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean,
  ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, 
  mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, 
  temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean,
  turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean,
  otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageoganexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean,
  electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean) AS
$BODY$
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
	    a.vibraciones
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
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION editar_anexo7c(IN p_norden integer)
  RETURNS TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiopaciente_nivel_est_pa text, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, areaocupacional_area_o text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, detallehijosvivosantecedentes_txtdhijosvivos text, detallehijosfallecidosantecedentes_txtdhijosfallecidos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, visionbinocular_v_binocular text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, observacionesradiografiatorax_txtobservacionesrt text, observacioneslaboratorioclinico_txtobservacioneslb text, examenradiograficossanguineos_txtobservacionesrs text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, creatininalaboratorioclinico_txtcreatininabio text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, fechaanexo7c_fecha date, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, otrosanexo7c_chkotros boolean, reubicacionsianexo7c_tbrsi boolean, reubicacionnoanexo7c_rbrno boolean, tabaconadaaexo7c_chktnada boolean, tabacopocoanexo7c_chktpoco boolean, tabacohabitualanexo7c_chkthabitual boolean, tabacoexcesivoanexo7c_chktexcesivo boolean, alcoholnadaanexo7c_chkanada boolean, alcoholpocoanexo7c_chkapoco boolean, alcoholhabitualanexo7c_chkahabitual boolean, alcoholexcesivoanexo7c_chkaexcesivo boolean, drogasnadaanexo7c_chkdnada boolean, drogaspocoanexo7c_chkdpoco boolean, drogashabitualanexo7c_chkdhabitual boolean, drogasexcesivoanexo7c_chkdexcesivo boolean, puestoactualanexo7c_txtpuestoactual text, tiempoanexo7c_txttiempo text, antecedentespersonalesanexo7c_txtantecedentespersonales text, antecedentespersonales2anexo7c_txtantecedentespersonales2 text, antecedentesfamiliaresanexo7c_txtantecedentesfamiliares text, cabezaanexo7c_txtcabeza text, narizanexo7c_txtnariz text, cuelloanexo7c_txtcuello text, perimetroanexo7c_txtperimetro text, baflanexo7c_txtb_a_f_l text, visioncoloresanexo7c_txtvisioncolores text, enfermedadesocularesanexo7c_txtenfermedadesoculares text, diagnosticoaudioanexo7c_txtdiagnosticoaudio text, enfermedadesoculares2anexo7c_txtenfermedadesoculares2 text, reflejospupilaresanexo7c_txtreflejospupilares text, binocularanexo7c_txtbinocular text, odanexo7c_txtod text, oianexo7c_txtoi text, toraxanexo7c_txttorax text, corazonanexo7c_txtcorazon text, pulmonesnormalanexo7c_rbnormal boolean, pulmonesanormalanexo7c_rbanormal boolean, pulmonesdescripcionanexo7c_txtpulmones text, miembrossuperioresanexo7c_txtmiembrossuperiores text, miembrosinferioresanexo7c_txtmiembrosinferiores text, reflejososteotendinososanexo7c_txtreflejososteotendinosos text, marchaanexo7c_txtmarcha text, columnavertebralanexo7c_txtcolumnavertebral text, abdomenanexo7c_txtabdomen text, anillosinguinalesanexo7c_txtanillosinguinales text, organosgenitalesanexo7c_txtorganosgenitales text, tactorectalnohizoanexo7c_rbtnohizo boolean, tactorectalnormalanexo7c_rbtnormal boolean, tactorectalanormalanexo7c_rbtanormal boolean, describirobservacionanexo7c_chkdescribirobservacion boolean, herniasanexo7c_txthernias text, varicesanexo7c_txtvarices text, gangliosanexo7c_txtganglios text, lenguageanexo7c_txtlenguage text, observacionesfichamedicaanexo7c_txtobservacionesfm text, conclusionanexo7c_txtconclusion text, tetanoanexo7c_tetano boolean, hepatitisbanexo7c_hepatitisb boolean, fiebreamarillaanexo7c_fiebreamarilla boolean, diagnosticoaudio2anexo7c_txtdiagnosticoaudio text, conclusionmedicoanexo7c_txtconclusionmed text, estadomentalanexo7c_txtestadomental text, anamnesisanexo7c_txtanamnesis text, alturaestructuraanexo7c_altura_estructura boolean, alturageoganexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, antecedentespatologicos_ante_patologicos text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, campospulmonesradiografiatorax_txtcampospulm text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, norden_n_orden integer, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, codigoanexo7c_cod_anexo integer, pielanexo7c_piel boolean, pieldescripcionanexo7c_piel_descripcion text) AS
$BODY$
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
	    o.v_cerca_s_od,
	    o.v_cerca_s_oi,
	    o.v_cerca_c_od,
	    o.v_cerca_c_oi,
	    o.v_lejos_s_od,
	    o.v_lejos_s_oi,
	    o.v_lejos_c_od,
	    o.v_lejos_c_oi,
	    o.v_binocular,
	    o.e_oculares,
	    o.e_oculares1,
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

	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_d_500 ELSE m.o_d_500 END AS o_d_500,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_d_1000 ELSE m.o_d_1000 END AS o_d_1000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_d_2000 ELSE m.o_d_2000 END AS o_d_2000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_d_3000 ELSE m.o_d_3000 END AS o_d_3000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_d_4000 ELSE m.o_d_4000 END AS o_d_4000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_d_6000 ELSE m.o_d_6000 END AS o_d_6000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_d_8000 ELSE m.o_d_8000 END AS o_d_8000,

	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_i_500 ELSE m.o_i_500 END AS o_i_500,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_i_1000 ELSE m.o_i_1000 END AS o_i_1000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_i_2000 ELSE m.o_i_2000 END AS o_i_2000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_i_3000 ELSE m.o_i_3000 END AS o_i_3000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_i_4000 ELSE m.o_i_4000 END AS o_i_4000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_i_6000 ELSE m.o_i_6000 END AS o_i_6000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN au.o_i_8000 ELSE m.o_i_8000 END AS o_i_8000,
	    CASE WHEN n.razon_empresa='MINERA BOROO MISQUICHILCA S.A.' THEN '' ELSE m.diagnostico END AS diagnostico,

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
	    CASE WHEN apt.ruido IS NULL THEN a.chkruido ELSE apt.ruido END,
	    CASE WHEN apt.polvo IS NULL THEN a.chkpolvo ELSE apt.polvo END,
	    CASE WHEN apt.vid_segmentario IS NULL THEN a.chkvidsegmentario ELSE apt.vid_segmentario END,
	    CASE WHEN apt.vid_total IS NULL THEN a.chkvidtotal ELSE apt.vid_total END,
	    CASE WHEN apt.cancerigenos IS NULL THEN a.chkcancerigenos ELSE apt.cancerigenos END,
	    CASE WHEN apt.mutagenicos IS NULL THEN a.chkmutagenicos ELSE apt.mutagenicos END,
	    CASE WHEN apt.solventes IS NULL THEN a.chksolventes ELSE apt.solventes END,
	    CASE WHEN apt.metales IS NULL THEN a.chkmetales ELSE apt.metales END,
	    CASE WHEN apt.temperatura IS NULL THEN a.chktemperatura ELSE apt.temperatura END,
	    CASE WHEN apt.biologicos IS NULL THEN a.chkbiologicos ELSE apt.biologicos END,
	    CASE WHEN apt.posturas IS NULL THEN a.chkposturas ELSE apt.posturas END,
	    CASE WHEN apt.turnos IS NULL THEN a.chkturnos ELSE apt.turnos END,
	    CASE WHEN apt.cargas IS NULL THEN a.chkcargas ELSE apt.cargas END,
	    CASE WHEN apt.mov_repet IS NULL THEN a.chkmovrepet ELSE apt.mov_repet END,
	    CASE WHEN apt.pvd IS NULL THEN a.chkpvd ELSE apt.pvd END,
	    CASE WHEN apt.otros IS NULL THEN a.chkotros ELSE apt.otros END,
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
	    CASE WHEN apt.altura_estructura IS NULL THEN a.altura_estructura ELSE apt.altura_estructura END,
	    CASE WHEN apt.altura_geografica IS NULL THEN a.altura_geog ELSE apt.altura_geografica END,
	    CASE WHEN apt.quimicos IS NULL THEN a.quimicos ELSE apt.quimicos END,
	    CASE WHEN apt.electricos IS NULL THEN a.electricos ELSE apt.electricos END,
	    CASE WHEN apt.vibraciones IS NULL THEN a.vibraciones ELSE apt.vibraciones END,
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
	    a.piel_descripcion
	    
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
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	LEFT JOIN informe_electrocardiograma AS ie ON (n.n_orden = ie.n_orden)
	LEFT JOIN analisis_bioquimicos AS ab ON (n.n_orden = ab.n_orden)
	LEFT JOIN antecedentes_patologicos AS apt ON (n.n_orden = apt.n_orden)
	WHERE a.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION eliminar_antecedentes_patologicos_quirurgicos(cod_ap_param integer)
  RETURNS text AS
$BODY$

	BEGIN

	IF EXISTS (SELECT 1 FROM antecedentes_patologicos_quirurgicos WHERE cod_ap = cod_ap_param) THEN
		DELETE FROM antecedentes_patologicos_quirurgicos apq WHERE apq.cod_ap = cod_ap_param;
	END IF;

	RETURN 'OK';

	END;

$BODY$
  LANGUAGE plpgsql;

  CREATE OR REPLACE FUNCTION registrar_antecedentes_patologicos_quirurgicos(
    cod_ap_param integer,
    hospital_operacion_param text,
    operacion_param text,
    dias_hospitalizado_param text,
    complicaciones_param text,
    fecha_param text)
  RETURNS void AS
$BODY$
BEGIN
    INSERT INTO antecedentes_patologicos_quirurgicos (
        cod_ap, hospital_operacion, operacion, dias_hospitalizado,
        complicaciones, fecha
    ) VALUES (
        cod_ap_param, hospital_operacion_param, operacion_param, dias_hospitalizado_param,
        complicaciones_param, fecha_param
    );
END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_reporte_antecedentes_patologicos(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, direccionpaciente_direccion_pa text, sexo_sexo_pa "char", fechanacimientopaciente_fecha_nacimiento_pa date, cargo_cargo_de text, area_area_o text, contrata_razon_contrata text, n_orden integer, empresa_razon_empresa text, edad_edad text, color integer, codigoantecedentespatologicos_cod_ap integer, fechaantecedentespatologicos_fecha_ap date, dniusuario_dni_user integer, alergias_chk1 boolean, amigdalitiscronica_chk2 boolean, arritmiascardiacas_chk3 boolean, asma_chk4 boolean, bocio_chk5 boolean, bronconeumonia_chk6 boolean, bronquitisarepeticion_chk7 boolean, cariesogingivitis_chk8 boolean, colecistitis_chk9 boolean, dermatitis_chk10 boolean, diabetes_chk11 boolean, disenteria_chk12 boolean, enfermedadescorazon_chk13 boolean, enfermedadesoculares_chk14 boolean, epilsepsiaoconvulsiones_chk15 boolean, faringitiscronica_chk16 boolean, fiebremalta_chk17 boolean, fiebretifoidea_chk18 boolean, fiebrereumatica_chk19 boolean, foruncolois_chk20 boolean, gastritiscronica_chk21 boolean, gonorrea_chk22 boolean, gota_chk23 boolean, hemorroides_chk24 boolean, hepatitis_chk25 boolean, hernias_chk26 boolean, hipertencionarterial_chk27 boolean, urinariasrepetidas_chk28 boolean, intoxicaciones_chk29 boolean, insuficienciacardiaca_chk30 boolean, insuficienciacoronariacronica_chk31 boolean, insuficienciarenalcronica_chk32 boolean, litiasisurinaria_chk33 boolean, meningitis_chk34 boolean, neuritis_chk35 boolean, otitismedia_chk36 boolean, presionaltaobaja_chk37 boolean, paludismoomalaria_chk38 boolean, parasitosisintestinal_chk39 boolean, paratiditis_chk40 boolean, pleuresia_chk41 boolean, plumbismo_chk42 boolean, poliomielitis_chk43 boolean, portadormarcapasos_chk44 boolean, protesiscardiacasvalvulares_chk45 boolean, resfriosfrecuentes_chk46 boolean, reumatismo_chk47 boolean, sarampion_chk48 boolean, sifilis_chk49 boolean, silicosis_chk50 boolean, sinusitiscronica_chk51 boolean, tosconvulsiva_chk52 boolean, transtornosnerviosos_chk53 boolean, traumatismoencefalocraneano_chk54 boolean, tuberculosis_chk55 boolean, tumoresquistes_chk56 boolean, ulcerapeptica_chk57 boolean, varicela_chk58 boolean, varices_chk59 boolean, varicocele_chk60 boolean, perdidamemoria_chk61 boolean, preocupacionesangustia_chk62 boolean, doloresarticulares_chk63 boolean, aumentodisminucionpeso_chk64 boolean, dolorcabeza_chk65 boolean, diarrea_chk66 boolean, agitacionejercicio_chk67 boolean, dolorocular_chk68 boolean, doloropresivotorax_chk69 boolean, hinchazonpiesomanos_chk70 boolean, estrenimiento_chk71 boolean, vomitosconsangre_chk72 boolean, sangradopororina_chk73 boolean, tosconsangre_chk74 boolean, coloracionamarrillapiel_chk75 boolean, indigestionfrecuente_chk76 boolean, insomnio_chk77 boolean, lumbalgiaodolorcintura_chk78 boolean, mareos_chk79 boolean, hecesnegras_chk80 boolean, orinacondolor_chk81 boolean, orinainvoluntaria_chk82 boolean, doloroido_chk83 boolean, secrecionesoido_chk84 boolean, palpitaciones_chk85 boolean, adormecimientos_chk86 boolean, pesadillasfrecuentes_chk87 boolean, doloresmusculares_chk88 boolean, toscronica_chk89 boolean, sangradoencias_chk90 boolean, drogasno_rbdrogasno boolean, drogassi_rbdrogassi boolean, licorno_rblicorno boolean, licorsi_rblicorsi boolean, fumarno_rbfumarno boolean, fumarsi_rbfumarsi boolean, drogasfrecuencia_txtdrogasfrecuencia text, drogastipo_txtdrogastipo text, licorfrecuencia_txtlicorfrecuencia text, licortipofrecuente_txtlicortipofrecuente text, numerocigarrillos_txtncigarrillos text, precisarcausasvarones_txtvcausas text, hijosvivosvarones_txtvhijosvivos text, hijosfallecidosvarones_txtvhijosfallecidos text, abortosparejasvarones_txtvnabortosparejas text, iniciomestruaciondamas_txtdiniciomestruacion text, iniciovidasexualdamas_txtdiniciovidasexual text, numeroparejassexactualidaddamas_txtdnumparejassexactualidad text, hijosvivosdamas_txtdhijosvivos text, hijosfallecidosdamas_txtdhijosfallecidos text, numerosdeabortosdamas_txtdnumerosdeabortos text, precisarcausasdamas_txtdcausas text, otrosdescripcionantecedentespatologicos_txtotrosap text, otrosdescripcionindicarenfermedades_txtotros1ap text, covid_chkcovid boolean, fechacovid_fechacovid date, covidlevel_chkcovidl boolean, covidmoderado_chkcovidm boolean, covidsevero_chkcovids boolean, dosisvacunas_txtdosis text, userregistro_user_registro text, otrostipoindicarenfermedades_txtotros text, otrosfrecuenciaindicarenfermedades_txtotrosfrecuencia text, otrossiindicarenfermedades_rbotrossi boolean, otrosnoindicarenfermedades_rbotrosno boolean, imaboro_ima boolean, acvboro_acv boolean, tbcboro_tbc boolean, vihboro_vih boolean, fobiasboro_fobias boolean, vertigosboro_vertigos boolean, tifoideaboro_tifoidea boolean, neoplasiasboro_neoplasias boolean, quemadurasboro_quemaduras boolean, discopatiasboro_discopatias boolean, columnaboro_columna boolean, enfermedadespsiquiatricasboro_enf_psiquiatricas boolean, enfermedadesreumaticasboro_enf_reumatica boolean, enfermedadespulmonaresboro_enf_pulmonares boolean, enfermedadespielboro_enf_piel boolean, tendinitisboro_tendinitis boolean, onicomicosisboro_onicomicosis boolean, fracturasboro_fracturas boolean, anemiaboro_anemia boolean, obesidadboro_obesidad boolean, dislipidemiaboro_dislipidemia boolean, intoxicacionesboro_intoxicaciones boolean, amputacionboro_amputacion boolean, sorderaboro_sordera boolean, especifiquetratamientoboro_especifique_detalleenfermedades text, alergiasalimentosboro_alergias_medic_alim boolean, alergiasalimentosespecifiqueboro_alergias_medic_alimdetall text, accidentetrabajoboro_accitrabajo boolean, accidentetrabajofechaboro_accit_fecha date, descansomedicoboro_accit_descanso boolean, descansomedicoespecifiqueboro_accit_descanso_detal text, enfermedadesprofesionalesboro_enfe_prof boolean, enfermedadesprofesionalesfechaboro_enfe_profecha date, enfermedadeslaboralescalificacionboro_enfe_lab_calif boolean, enfermedadeslaboralesespecifiqueboro_enfe_lab_califdetal text, antitetanicaboro_antitetanica boolean, fiebreamarillaboro_fiebre_amarilla boolean, influenzaboro_influenza boolean, hepatitisaboro_hepatitisa boolean, hepatitisbboro_hepatitisb boolean, gripeinfluenzaboro_gripe_influenza boolean, neumococoboro_neumococo boolean, rabiaboro_rabia boolean, papilomahumanoboro_papiloma_humano boolean, cantidosisboro_cantidosis boolean, medicamentoboro_medicamento boolean, medicamentoespecifiqueboro_medicamento_detal text, actividadfisicaboro_activ_fisic boolean, actividadfisicaespecifiqueboro_activ_fisic_detal text, padreespecifiqueboro_padre_detall text, madreespecifiqueboro_madre_detall text, hermanosespecifiqueboro_hermanos_detall text, hijosespecifiqueboro_hijos_detall text, esposconyespecifiqueboro_espos_cony_detall text, conadisespecifiqueboro_conadisdetalle text, etsboro_ets boolean, migranaboro_migrana boolean, tiempoincapacidadboro_timeincapacidad text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, oftalodccmologia_odcc text, oiccoftalmologia_oicc text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, odlcoftalmologia_odlc text, oilcoftalmologia_oilc text, vcoftalmologia_vc text, vboftalmologia_vb text, rpoftalmologia_rp text, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, cancerigenosanexo7c_chkcancerigenos boolean, metalesanexo7c_chkmetales boolean, vibracionesanexo7c_vibraciones boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, cargasanexo7c_chkcargas boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageograficaanexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, electricosanexo7c_electricos boolean, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, direccionsede text, sede text, nombresede text, namejasper text, esBoro boolean) AS
$BODY$
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
	  a7.chkruido,
	  a7.chkpolvo,
	  a7.chkcancerigenos,
	  a7.chkmetales,
	  a7.vibraciones,
	  a7.chktemperatura,
	  a7.chkbiologicos,
	  a7.chkposturas,
	  a7.chkcargas,
	  a7.chkotros,
	  a7.altura_estructura,
	  a7.altura_geog,
	  a7.quimicos,
	  a7.electricos,
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
	    END AS esBoro
	FROM datos_paciente dp
	INNER JOIN n_orden_ocupacional n ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
	LEFT JOIN antecedentes_patologicos ap ON n.n_orden = ap.n_orden
	LEFT JOIN anexo7c AS a7 ON a7.n_orden = ap.n_orden
	LEFT JOIN lab_clinico l ON n.n_orden = l.n_orden
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql

;

  insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('antecedentes_patologicos','formulario de antecedentes patologicos',true,true,true,false,false);


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





-- PG ADMIN 3

CREATE OR REPLACE FUNCTION listado_pacientes_protocolo_busqueda_filtros(
	razon_empresa_param text,razon_contrata_param text, name_protocolo_param text, fecha_inicio_param date, fecha_fin_param date)
    RETURNS TABLE(protocolos text, nombres text, razon_empresa text, razon_contrata text, tipoexamen text, fechaexamen date) 
    LANGUAGE 'plpgsql'
AS $BODY$
	
BEGIN

	    RETURN QUERY 
	select  n.protocolo,dp.nombres_pa || ' ' || dp.apellidos_pa as nombres,n.razon_empresa, n.razon_contrata,n.nom_examen as tipoExamen,n.fecha_apertura_po as fechaExamen   
	from n_orden_ocupacional as n inner join datos_paciente as dp on n.cod_pa=dp.cod_pa
	where n.razon_empresa=razon_empresa_param and n.fecha_apertura_po BETWEEN fecha_inicio_param AND fecha_fin_param;

END; 
$BODY$;