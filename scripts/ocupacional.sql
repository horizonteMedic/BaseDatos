create function editar_anexo7c(p_norden integer)
    returns TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiopaciente_nivel_est_pa text, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, areaocupacional_area_o text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, detallehijosvivosantecedentes_txtdhijosvivos text, detallehijosfallecidosantecedentes_txtdhijosfallecidos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, visionbinocular_v_binocular text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, vc_vc text, rp_rp text, enfermedadesocularesvisionlejos_e_oculvisionlejos text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, observacionesradiografiatorax_txtobservacionesrt text, observacioneslaboratorioclinico_txtobservacioneslb text, examenradiograficossanguineos_txtobservacionesrs text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, creatininalaboratorioclinico_txtcreatininabio text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, fechaanexo7c_fecha date, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageograficaanexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, reubicacionsianexo7c_tbrsi boolean, reubicacionnoanexo7c_rbrno boolean, tabaconadaaexo7c_chktnada boolean, tabacopocoanexo7c_chktpoco boolean, tabacohabitualanexo7c_chkthabitual boolean, tabacoexcesivoanexo7c_chktexcesivo boolean, alcoholnadaanexo7c_chkanada boolean, alcoholpocoanexo7c_chkapoco boolean, alcoholhabitualanexo7c_chkahabitual boolean, alcoholexcesivoanexo7c_chkaexcesivo boolean, drogasnadaanexo7c_chkdnada boolean, drogaspocoanexo7c_chkdpoco boolean, drogashabitualanexo7c_chkdhabitual boolean, drogasexcesivoanexo7c_chkdexcesivo boolean, puestoactualanexo7c_txtpuestoactual text, tiempoanexo7c_txttiempo text, antecedentespersonalesanexo7c_txtantecedentespersonales text, antecedentespersonales2anexo7c_txtantecedentespersonales2 text, antecedentesfamiliaresanexo7c_txtantecedentesfamiliares text, cabezaanexo7c_txtcabeza text, narizanexo7c_txtnariz text, cuelloanexo7c_txtcuello text, perimetroanexo7c_txtperimetro text, baflanexo7c_txtb_a_f_l text, visioncoloresanexo7c_txtvisioncolores text, enfermedadesocularesanexo7c_txtenfermedadesoculares text, diagnosticoaudioanexo7c_txtdiagnosticoaudio text, enfermedadesoculares2anexo7c_txtenfermedadesoculares2 text, reflejospupilaresanexo7c_txtreflejospupilares text, binocularanexo7c_txtbinocular text, odanexo7c_txtod text, oianexo7c_txtoi text, toraxanexo7c_txttorax text, corazonanexo7c_txtcorazon text, pulmonesnormalanexo7c_rbnormal boolean, pulmonesanormalanexo7c_rbanormal boolean, pulmonesdescripcionanexo7c_txtpulmones text, miembrossuperioresanexo7c_txtmiembrossuperiores text, miembrosinferioresanexo7c_txtmiembrosinferiores text, reflejososteotendinososanexo7c_txtreflejososteotendinosos text, marchaanexo7c_txtmarcha text, columnavertebralanexo7c_txtcolumnavertebral text, abdomenanexo7c_txtabdomen text, anillosinguinalesanexo7c_txtanillosinguinales text, organosgenitalesanexo7c_txtorganosgenitales text, tactorectalnohizoanexo7c_rbtnohizo boolean, tactorectalnormalanexo7c_rbtnormal boolean, tactorectalanormalanexo7c_rbtanormal boolean, describirobservacionanexo7c_chkdescribirobservacion boolean, herniasanexo7c_txthernias text, varicesanexo7c_txtvarices text, gangliosanexo7c_txtganglios text, lenguageanexo7c_txtlenguage text, observacionesfichamedicaanexo7c_txtobservacionesfm text, conclusionanexo7c_txtconclusion text, tetanoanexo7c_tetano boolean, hepatitisbanexo7c_hepatitisb boolean, fiebreamarillaanexo7c_fiebreamarilla boolean, diagnosticoaudio2anexo7c_txtdiagnosticoaudio text, conclusionmedicoanexo7c_txtconclusionmed text, estadomentalanexo7c_txtestadomental text, anamnesisanexo7c_txtanamnesis text, antecedentespatologicos_ante_patologicos text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, campospulmonesradiografiatorax_txtcampospulm text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, norden_n_orden integer, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, codigoanexo7c_cod_anexo integer, pielanexo7c_piel boolean, pieldescripcionanexo7c_piel_descripcion text, usuariofirma text, conclusionmusculoesqueletica text, observacionesconduccioncertificado_conduccion text, conclusionradiografia_conclu text, notasdoctor text)
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
        ra.conclu,
        l.nota
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
    returns TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiospaciente_nivel_est_pa text, norden_n_orden integer, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, area_area_o text, grupofactorsanguineo_grupofactorsan text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, dhijosvivosantecedentes_txtdhijosvivos text, dhijosfallecidosantecedentes_txtdhijosfallecidos text, antecedentes_rbfumarsi boolean, antecedentes_rblicorsi boolean, antecedentespatologicos_ante_patologicos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, vc_vc text, visionbinocular_v_binocular text, rp_rp text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, visionlejosoftalmo_e_oculvisionlejos text, diagnosticooftalmologia2021_txtdiagnostico text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, verticesradiografiatorax_txtvertices text, hiliosradiografiatorax_txthilios text, senoscostofrenicosradiografiatorax_txtsenoscostofrenicos text, mediastinosradiografiatorax_txtmediastinos text, siluetacardiovascularradiografiatorax_txtsiluetacardiovascular text, osteomuscularradiografiatorax_txtosteomuscular text, conclusionesradiograficastorax_txtconclusionesradiograficas text, observacionesradiografiatorax_txtobservacionesrt text, campospulmonesradiografiatorax_txtcampospulm text, observacioneslaboratorioclinico_txtobservacioneslb text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, creatininalaboratorioclinico_txtcreatininabio text, positivolaboratorioclinico_chkpositivo boolean, negativolaboratorioclinico_chknegativo boolean, gruposanguineoo_chko boolean, gruposanguineoa_chka boolean, gruposanguineob_chkb boolean, gruposanguineoab_chkab boolean, gruposanguineorhpositivo_rbrhpositivo boolean, gruposanguineorhnegativo_rbrhnegativo boolean, hemoglobina_txthemoglobina text, examenfisicocolor_txtcoloref text, examenfisicodensidad_txtdensidadef text, examenfisicoaspecto_txtaspectoef text, examenfisicoph_txtphef text, examenquimiconitritos_txtnitritoseq text, examenquimicoproteinas_txtproteinaseq text, examenquimicocetonas_txtcetonaseq text, examenquimicoleucocitos_txtleucocitoseq text, examenquimicourobilinogeno_txturobilinogenoeq text, examenquimicobilirubina_txtbilirubinaeq text, examenquimicoglucosa_txtglucosaeq text, examenquimicosangre_txtsangreeq text, sedimientourinarioleucocitos_txtleucocitossu text, sedimientourinarioepiteliales_txtcelepitelialessu text, sedimientourinariocilindios_txtcilindiossu text, sedimientourinariobacterias_txtbacteriassu text, sedimientourinariohematies_txthematiessu text, sedimientourinariocristales_txtcristalessu text, sedimientourinariopus_txtpussu text, sedimientourinariootros_txtotrossu text, grupofactorsanguineolaboratorioclinico_grupofactor text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, ordenalturacertificado_ordenaltura integer, observacionesalturacertificado_alturabarrick text, ordenconduccioncertificado_ordencond integer, observacionesconduccioncertificado_conduccion text, numeroalturacertificacion_numalt integer, observacionesalturacertificacion_certialtura text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, infogeneralradiografia_info_general text, conclusionradiografia_conclu text, anamnesisagroindustrial_txtanamnesis text, estadomentalagroindustrial_txtestadomental text, hallazgosinformeelectrocardiograma_hallazgo text, recomendacionesinformeelectrocardiograma_recomendaciones text, colesterolanalisisbioquimico_txtcolesterol text, ldlcolesterolanalisisbioquimico_txtldlcolesterol text, hdlcolesterolanalisisbioquimico_txthdlcolesterol text, vldlcolesterolanalisisbioquimico_txtvldlcolesterol text, trigliseridosanalisisbioquimico_txttrigliseridos text, codigoexamenradiograficosanguineo_cod_exra integer, nrxexamenradiograficosanguineo_n_rx integer, fechaexamenradiografico_fecha_exra date, calidadexamenradiografico_txtcalidad text, simbolosexamenradiografico_txtsimbolos text, examenradiografico0_ex_0 boolean, examenradiografico10_ex_10 boolean, examenradiografico11_ex_11 boolean, examenradiografico12_ex_12 boolean, examenradiografico21_ex_21 boolean, examenradiografico22_ex_22 boolean, examenradiografico23_ex_23 boolean, examenradiografico32_ex_32 boolean, examenradiografico33_ex_33 boolean, examenradiografico3mas_ex_3mas boolean, examenradiograficoabc_ex_abc boolean, examenradiograficost_ex_st boolean, examenradiograficosinneumoconiosis_txtsinneumoconiosis text, examenradiograficoconneumoconiosis_txtconneumoconiosis text, examenradiograficoirep_txtirep text, examenradiograficootros_txtotrosex text, examenradiograficoaptosi_apto_si boolean, examenradiograficoaptono_apto_no boolean, examenradiograficoaptore_apto_re boolean, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, otrosanexo7c_chkotros boolean, alturaestructuraanexo7c_altura_estructura boolean, alturageoganexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean, conclusionmusculoesqueletica text, notasdoctor text)
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
	    CASE WHEN eme.n_orden IS NULL THEN eme21.txtconclusiones ELSE eme.txtdiagnostico END,
	    l.nota
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

alter function obtener_anexo7c(integer) owner to pierola;

