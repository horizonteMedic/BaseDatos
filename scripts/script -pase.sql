CREATE OR REPLACE FUNCTION eliminar_accidentes_trabajo(cod_anexo_param integer)
  RETURNS text AS
$BODY$

	BEGIN

	IF EXISTS (SELECT 1 FROM accidentes_trabajo WHERE cod_anexo = cod_anexo_param) THEN
		DELETE FROM accidentes_trabajo atr WHERE atr.cod_anexo = cod_anexo_param;
	END IF;

	RETURN 'OK';

	END;

$BODY$
  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION registrar_accidente_trabajo(
    cod_anexo_param INTEGER,
    enfermedad_param TEXT,
    asociadotrabajo_param TEXT,
    anio_param TEXT,
    diasdescanso_param TEXT,
    fecha_param TEXT,
    user_registro_param TEXT
)
RETURNS VOID AS
$$
BEGIN
    INSERT INTO accidentes_trabajo (
        cod_anexo, enfermedad, asociadotrabajo, anio,
        diasdescanso, fecha, user_registro
    ) VALUES (
        cod_anexo_param, enfermedad_param, asociadotrabajo_param, anio_param,
        diasdescanso_param, fecha_param, user_registro_param
    );
END;
$$ LANGUAGE plpgsql;


  CREATE OR REPLACE FUNCTION obtener_reporte_anexo2_completo(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(
	telefonoTrabajoPaciente_tel_trabajo_pa text,
	telefonoCasaPaciente_tel_casa_pa text,
	celularPaciente_cel_pa text,
	dni_cod_pa integer,
	sexo_sexo_pa "char",
	direccionPaciente_direccion_pa text,
	fechaNacimientoPaciente_fecha_nacimiento_pa date,
	lugarNacPaciente_lugar_nac_pa text,
	estadoCivilPaciente_estado_civil_pa text,
	nivelEstudiosPaciente_nivel_est_pa text,
	departamentoPaciente_departamento_pa text,
	provinciaPaciente_provincia_pa text,
	distritoPaciente_distrito_pa text,
	emailPaciente_email_pa text,
	nombres_nombres_pa text,
	apellidos_apellidos_pa text,
	edad_fecha_nacimiento_pa text,
	cargo_cargo_de text,
	empresa_razon_empresa text,
	explotacion_nom_ex text,
	altura_altura_po text,
	contrata_razon_contrata text,
	nOrden_n_orden integer,
	fechaApertura_fecha_apertura_po date,
	mineral_mineral_po text,
	color_color integer,
	grupoSanguineoPrevio_grupofactorsan text,
	area_area_o text,
	nombreExamen_nom_examen text,

	fechaAnexo_fecha date,
	codigoAnexo_cod_anexo integer,
	neoplasia_chkneoplasia boolean,
	neoplasiaDescripcion_txtneoplasia text,
	its_chkits boolean,
	itsDescripcion_txtits text,
	quemaduras_chkquemaduras boolean,
	quemadurasDescripcion_txtquemaduras text,
	cirugias_chkcirugias boolean,
	cirugiasDescripcion_txtcirugias text,
	antecedentesPersonalesOtros_chkapotros boolean,
	antecedentesPersonalesOtrosDescripcion_txtotrosantecendetes text,
	residenciaSi_chkresidenciasi boolean,
	residenciaNo_chkresidenciano boolean,
	residenciaTiempo_txttiemporesidencia text,
	essalud_chkessalud boolean,
	eps_chkeps boolean,
	residenciaTrabajoOtros_chkotros boolean,
	sctr_chksctr boolean,
	sctrOtros_chkotros1 boolean,
	padre_txtpadre text,
	madre_txtmadre text,
	hermanos_txthermanos text,
	esposa_txtesposa text,
	totalHijos_txttotalhijos text,
	numeroDependientes_txtndependientes text,
	puestoActual_txtpuestoactual text,
	tiempo_txttiempo text,
	medicamentosSi_rbsimed boolean,
	medicamentosNo_rbnomed boolean,
	tipoMedicamento_txttipomedicamento text,
	frecuenciaMedicamentos_txtfrecuenciamed text,
	cabeza_txtpelo text,
	nariz_txtnariz text,
	cuello_txtcuello text,
	perimetro_txtperimetro text,
	boca_txtboca text,
	oidos_txtoidos text,
	faringe_txtfaringe text,
	miembrosSuperiores_txtmiembrossuperiores text,
	miembrosInferiores_txtmiembrosinferiores text,
	ectoscopia_txtectoscopia text,
	estadoMental_txtestadomental text,
	anamnesis_txtanamnesis text,
	marcha_txtmarcha text,
	columnaVertebral_txtcolumnavertebral text,
	aparatoRespiratorio_txtaparatorespiratorio text,
	aparatoCardiovascular_txtaparatocardiovascular text,
	aparatoDigestivo_txtaparatodigestivo text,
	aparatoGeiotourinario_txtaparatogeiotourinario text,
	aparatoLocomotor_txtaparatolocomotor text,
	sistemaLinfatico_txtsistemalinfatico text,
	piel_txtpiel text,
	observacionesFichaMedica_txtobservacionesfm text,
	conclusion_txtconclusion text,
	enfermedadesOcularesOtros_txtenfermedadesoculares1 text,
	sistemaNervioso_sistemanervioso text,
	otrosExamenes_txtotrosex text,
	restricciones_txtrestricciones text,
	esApto_apto_si boolean,
	noEsApto_apto_no boolean,
	aptoRestriccion_apto_re boolean,
	fechaDesde_fechadesde date,
	fechaHasta_fechahasta date,
	medico_medico text,
	hijosVivosAnexo2_txthijosvivos text,
	hijosMuertosAnexo2_txthijosmuertos text,

	fvc_fvc text,
	fev1_fev1 text,
	fev1fvc_fev1fvc text,
	fef2575_fef25_75 text,
	interpretacion_interpretacion text,

	perimetroCuello_perimetro_cuello text,
	imc_imc text,
	peso_peso text,
	talla_talla text,
	cintura_cintura text,
	cadera_cadera text,
	icc_icc text,
	temperatura_temperatura text,
	fRespiratoria_f_respiratoria text,
	fCardiaca_f_cardiaca text,
	sat02_sat_02 text,
	sistolica_sistolica text,
	diastolica_diastolica text,

	codigoAntecedentesPatologicos_cod_ap integer,
	fechaAntecedentes_fecha_ap date,
	hijosVivosAntecedentesPatologicos_txtvhijosvivos text,
	hijosFallecidosAntecedentesPatologicos_txtvhijosfallecidos text,
	padreAntecedentesPatologicos_padre_detall text,
	madreAntecedentesPatologicos_madre_detall text,
	hermanosAntecedentesPatologicos_hermanos_detall text,
	hijosAntecedentesPatologicos_hijos_detall text,
	esposaAntecedentesPatologicos_espos_cony_detall text,
    alergias boolean,
    asma boolean,
    bronquitis boolean,
    tbc boolean,
    convulsiones boolean,
    intoxicaciones boolean,
    hepatitis boolean,
    tifoidea boolean,
    hta boolean,
    diabetes boolean,
    alcohol boolean,
    tabaco boolean,
    drogas boolean,
    alcoholTipo text,
    tabacoTipo text,
    drogasTipo text,
    alcoholFrecuencia text,
    drogasFrecuencia text,

	visionCercaSinCorregirOd_v_cerca_s_od text,
	visionCercaSinCorregirOi_v_cerca_s_oi text,
	visionCercaCorregidaOd_v_cerca_c_od text,
	visionCercaCorregidaOi_v_cerca_c_oi text,
	visionLejosSinCorregirOd_v_lejos_s_od text,
	visionLejosSinCorregirOi_v_lejos_s_oi text,
	visionLejosCorregidaOd_v_lejos_c_od text,
	visionLejosCorregidaOi_v_lejos_c_oi text,
	visionColores_v_colores text,
	visionBinocular_v_binocular text,
	reflejosPupilares_r_pupilares text,
	enfermedadesOcularesOftalmo_e_oculares text,
	enfermedadesOcularesOtrosOftalmo_e_oculares1 text,

	odcc_ODCC text,
	oicc_OICC text,
	odlc_ODLC text,
	oilc_OILC text,
	vc_VC text,
	vb_VB text,
	rp_RP text,


	ausentes_txtausentes integer,
	piezasMalEstado_txtpiezasmalestado integer,
	observacionesOdonto_txtobservaciones text,

	oidoDerecho500_o_d_500 text,
	oidoDerecho1000_o_d_1000 text,
	oidoDerecho2000_o_d_2000 text,
	oidoDerecho3000_o_d_3000 text,
	oidoDerecho4000_o_d_4000 text,
	oidoDerecho6000_o_d_6000 text,
	oidoDerecho8000_o_d_8000 text,

	oidoIzquierdo500_o_i_500 text,
	oidoIzquierdo1000_o_i_1000 text,
	oidoIzquierdo2000_o_i_2000 text,
	oidoIzquierdo3000_o_i_3000 text,
	oidoIzquierdo4000_o_i_4000 text,
	oidoIzquierdo6000_o_i_6000 text,
	oidoIzquierdo8000_o_i_8000 text,
	diagnosticoAudiometria_diagnostico text,

	recomendacionesInfoPsicologico_recomendaciones text,
	    
	conclusionesRadiograficas_txtconclusionesradiograficas text,
	verticesRadiografiaTorax_txtvertices text,
	hilosRadiografiaTorax_txthilios text,
	senosCostoFrenicos_txtsenoscostofrenicos text,
	meadiastinos_txtmediastinos text,
	siluetaCardioVascular_txtsiluetacardiovascular text,
	osteoMuscular_txtosteomuscular text,
	observacionesRadiografiaTorax_txtobservacionesrt text,
	camposPulmones_txtcampospulm text,

	observacionesLabClinico_txtobservacioneslb text,
	grupoSanguineoO_chko boolean,
	grupoSanguineoA_chka boolean,
	grupoSanguineoB_chkb boolean,
	grupoSanguineoAB_chkab boolean,
	grupoSanguineoRhPositivo_rbrhpositivo boolean,
	grupoSanguineoRhNegativo_rbrhnegativo boolean,
	hemoglobina_txthemoglobina text,
	glucosa_txtglucosabio text,
	vSG_txtvsg text,
	cocaina_txtcocaina text,
	marihuana_txtmarihuana text,
	creatina_txtcreatininabio text,
	grupoFactorNuevo_grupo_factor_nuevo text,

	colesterol_txtcolesterol text,
	ldlColesterol_txtldlcolesterol text,
	hdlColesterol_txthdlcolesterol text,
	vldlColesterol_txtvldlcolesterol text,
	trigliseridos_txttrigliseridos text,

	hallazgosInformeElectroCardiograma_hallazgo text,
	recomendacionesInformeElectroCardiograma_recomendaciones text,

	informacionesGeneralRadiografia_info_general text,
	conclusionesRadiografia_conclu text,

	examenRadiograficosSanguineos_txtobservacionesrs text,

	sede text,
	nombreSede text,
	nameJasper text
  ) AS
$BODY$
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
	    ap.txtvhijosvivos,    ap.txtvhijosfallecidos, ap.padre_detall, ap.madre_detall,
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
	    obtener_name_jasper(p_norden, name_service)
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
	WHERE n.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;


insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('anexo_agroindustrial','formulario de anexo 2',true,true,true,false,false);


---------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION obtener_anexo7c(
    IN p_norden integer)
  RETURNS TABLE(
-- datos_paciente 
dni_cod_pa integer,
nombres_nombres_pa text,
apellidos_apellidos_pa text,
fechaNacimientoPaciente_fecha_nacimiento_pa date,
sexo_sexo_pa "char",
lugarNacimientoPaciente_lugar_nac_pa text,
direccionPaciente_direccion_pa text,
telefonoCasaPaciente_tel_casa_pa text,
celularPaciente_cel_pa text,
estadoCivilPaciente_estado_civil_pa text,
nivelEstudiosPaciente_nivel_est_pa text,
-- n_orden_ocupacional
norden_n_orden integer,
empresa_razon_empresa text,
contrata_razon_contrata text,
nombreExamen_nom_examen text,
explotacion_nom_ex text,
altura_altura_po text,
mineral_mineral_po text,
cargo_cargo_de text,
area_area_o text,
grupoFactorSanguineo_grupofactorsan text,
-- aecedentes_patologicos
hijosVivosaecedentes_txtvhijosvivos text,
hijosFallecidosaecedentes_txtvhijosfallecidos text,
dHijosVivosAntecedentes_txtdhijosvivos text,
dHijosFallecidosAntecedentes_txtdhijosfallecidos text,
antecedentes_rbfumarsi boolean,
antecedentes_rblicorsi boolean,
antecedentesPatologicos_ante_patologicos text,

-- triaje
tallaTriaje_talla text,
pesoTriaje_peso text,
imcTriaje_imc text,
sistolicaTriaje_sistolica text,
diastolicaTriaje_diastolica text,
frecuenciaRespiratoriaTriaje_f_respiratoria text,
frecuenciaCardiacaTriaje_f_cardiaca text,
saturacionOxigenoTriaje_sat_02 text,
temperaturaTriaje_temperatura text,
cinturaTriaje_cintura text,
caderaTriaje_cadera text,
iccTriaje_icc text,
perimetroCuelloTriaje_perimetro_cuello text,

-- oftalmologia (
visionCercaSinCorregirOd_v_cerca_s_od text,
visionCercaSinCorregirOi_v_cerca_s_oi TEXT,
odcc_odcc text,
oicc_oicc text,
visionLejosSinCorregirOd_v_lejos_s_od text,
visionLejosSinCorregirOi_v_lejos_s_oi text,
odlc_odlc text,
oilo_oilc text,
vc_vc text,
vb_vb text,
rp_rp text,
enfermedadesOcularesOftalmo_e_oculares text,
enfermedadesOcularesOtrosOftalmo_e_oculares1 text,
visionLejosOftalmo_e_oculvisionlejos text,

-- ftalmologia2021
diagnosticoOftalmologia2021_txtdiagnostico text,

-- odontograma
ausentesOdontograma_txtausentes integer,
observacionesOdontograma_txtobservaciones text,
piezasMalEstadoOdontograma_txtpiezasmalestado integer,

-- radiografia_torax
verticesRadiografiaTorax_txtvertices text,
hiliosRadiografiaTorax_txthilios text,
senosCostoFrenicosRadiografiaTorax_txtsenoscostofrenicos text,
mediastinosRadiografiaTorax_txtmediastinos text,
siluetaCardioVascularRadiografiaTorax_txtsiluetacardiovascular text,
osteomuscularRadiografiaTorax_txtosteomuscular text,
conclusionesRadiograficasTorax_txtconclusionesradiograficas text,
observacionesRadiografiaTorax_txtobservacionesrt text,
camposPulmonesRadiografiaTorax_txtcampospulm text,

-- lab_clinico
observacionesLaboratorioClinico_txtobservacioneslb text,
cocainaLaboratorioClinico_txtcocaina text,
marihuanaLaboratorioClinico_txtmarihuana text,
glucosaLaboratorioClinico_txtglucosabio text,
vsgLaboratorioClinico_txtvsg text,
creatininaLaboratorioClinico_txtcreatininabio text,
positivoLaboratorioClinico_chkpositivo boolean,
negativoLaboratorioClinico_chknegativo boolean,
grupoSanguineoO_chko boolean,
grupoSanguineoA_chka boolean,
grupoSanguineoB_chkb boolean,
grupoSanguineoAB_chkab boolean,
grupoSanguineoRhPositivo_rbrhpositivo boolean,
grupoSanguineoRhNegativo_rbrhnegativo boolean,
hemoglobina_txthemoglobina text,
examenFisicoColor_txtcoloref text,
examenFisicoDensidad_txtdensidadef text, 
examenFisicoAspecto_txtaspectoef text, 
examenFisicoPh_txtphef text, 
examenQuimicoNitritos_txtnitritoseq text, 
examenQuimicoProteinas_txtproteinaseq text, 
examenQuimicoCetonas_txtcetonaseq text,
examenQuimicoLeucocitos_txtleucocitoseq text, 
examenQuimicoUrobilinogeno_txturobilinogenoeq text, 
examenQuimicoBilirubina_txtbilirubinaeq text, 
examenQuimicoGlucosa_txtglucosaeq text, 
examenQuimicoSangre_txtsangreeq text, 
sedimientoUrinarioLeucocitos_txtleucocitossu text,
sedimientoUrinarioEpiteliales_txtcelepitelialessu text, 
sedimientoUrinarioCilindios_txtcilindiossu text, 
sedimientoUrinarioBacterias_txtbacteriassu text, 
sedimientoUrinarioHematies_txthematiessu text, 
sedimientoUrinarioCristales_txtcristalessu text, 
sedimientoUrinarioPus_txtpussu text, 
sedimientoUrinarioOtros_txtotrossu text,
grupoFactorSanguineoLaboratorioClinico_Grupofactor text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoDerecho500Audiometria_o_d_500 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoDerecho1000Audiometria_o_d_1000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoDerecho2000Audiometria_o_d_2000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoDerecho3000Audiometria_o_d_3000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoDerecho4000Audiometria_o_d_4000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoDerecho6000Audiometria_o_d_6000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoDerecho8000Audiometria_o_d_8000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoIzquierdo500Audiometria_o_i_500 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoIzquierdo1000Audiometria_o_i_1000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoIzquierdo2000Audiometria_o_i_2000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoIzquierdo3000Audiometria_o_i_3000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoIzquierdo4000Audiometria_o_i_4000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoIzquierdo6000Audiometria_o_i_6000 text,

-- audiometria_2021, audiometria_2023, audiometria_po
oidoIzquierdo8000Audiometria_o_i_8000 text,

-- audiometria_2021, audiometria_2023, audiometria_po - Diagnóstico audiométrico (Prefijos: au, a25, m)
diagnosticoAudiometricoCompleto_diagnostico text,

-- funcion_abs
fvcFuncionRespiratoria_fvc text,
fev1FuncionRespiratoria_fev1 text,
fev1FvcFuncionRespiratoria_fev1fvc text,
fef2575FuncionRespiratoria_fef25_75 text,
interpretacionFuncionRespiratoria_interpretacion text,

-- b_certificado_altura
ordenAlturaCertificado_ordenaltura integer,
observacionesAlturaCertificado_alturabarrick text,

-- b_certificado_conduccion
ordenConduccionCertificado_ordencond integer,
observacionesConduccionCertificado_conduccion text,

-- certificacion_medica_altura
numeroAlturaCertificacion_numalt integer,
observacionesAlturaCertificacion_certialtura text,

-- audiometria_2021 - Campos adicionales de diagnóstico 
normalAudiometria_chkdnormal boolean,
traumaLeveOdAudiometria_chkdtaleveod boolean,
traumaLeveOiAudiometria_chkdtaleveoi boolean,
traumaAvanzadoOdAudiometria_chkdtaavanzadood boolean,
traumaAvanzadoOiAudiometria_chkdtaavanzadooi boolean,
hipoacusiaLeveOdAudiometria_chkdhrleveod boolean,
hipoacusiaLeveOiAudiometria_chkdhrleveoi boolean,
hipoacusiaModeradaOdAudiometria_chkdhrmoderadood boolean,
hipoacusiaModeradaOiAudiometria_chkdhrmoderadooi boolean,
hipoacusiaAvanzadaOdAudiometria_chkdhravanzadaod boolean,
hipoacusiaAvanzadaOiAudiometria_chkdhravanzadaoi boolean,
otrasHipoacusiasAudiometria_chkotrashipoacusias boolean,
otrasHipoacusiasAudiometria_txtotrashipoacusias text,

-- radiografia
infoGeneralRadiografia_info_general text,
conclusionRadiografia_conclu text,

-- anexo_agroindustrial 
anamnesisAgroindustrial_txtanamnesis text,
estadoMentalAgroindustrial_txtestadomental text,

-- electro_cardiograma
hallazgosInformeElectroCardiograma_hallazgo text,
recomendacionesInformeElectroCardiograma_recomendaciones text,

-- analisis_bioquimico
colesterolAnalisisBioquimico_txtcolesterol text,
ldlcolesterolAnalisisBioquimico_txtldlcolesterol text,
hdlcolesterolAnalisisBioquimico_txthdlcolesterol text, 
vldlcolesterolAnalisisBioquimico_txtvldlcolesterol text,
trigliseridosAnalisisBioquimico_txttrigliseridos text
  ) AS
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
	    ab.txttrigliseridos

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
	WHERE n.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION editar_anexo7c(IN p_norden integer)
  RETURNS TABLE(dni_cod_pa integer, nombres_nombres_pa text, apellidos_apellidos_pa text, fechanacimientopaciente_fecha_nacimiento_pa date, sexo_sexo_pa "char", lugarnacimientopaciente_lugar_nac_pa text, direccionpaciente_direccion_pa text, telefonocasapaciente_tel_casa_pa text, celularpaciente_cel_pa text, estadocivilpaciente_estado_civil_pa text, nivelestudiopaciente_nivel_est_pa text, empresa_razon_empresa text, contrata_razon_contrata text, nombreexamen_nom_examen text, explotacion_nom_ex text, altura_altura_po text, mineral_mineral_po text, cargo_cargo_de text, areaocupacional_area_o text, hijosvivosantecedentes_txtvhijosvivos text, hijosfallecidosantecedentes_txtvhijosfallecidos text, detallehijosvivosantecedentes_txtdhijosvivos text, detallehijosfallecidosantecedentes_txtdhijosfallecidos text, tallatriaje_talla text, pesotriaje_peso text, imctriaje_imc text, sistolicatriaje_sistolica text, diastolicatriaje_diastolica text, frecuenciarespiratoriatriaje_f_respiratoria text, frecuenciacardiacatriaje_f_cardiaca text, saturacionoxigenotriaje_sat_02 text, temperaturatriaje_temperatura text, cinturatriaje_cintura text, caderatriaje_cadera text, icctriaje_icc text, perimetrocuellotriaje_perimetro_cuello text, visioncercasincorregirod_v_cerca_s_od text, visioncercasincorregiroi_v_cerca_s_oi text, visioncercacorregidaod_v_cerca_c_od text, visioncercacorregidaoi_v_cerca_c_oi text, visionlejossincorregirod_v_lejos_s_od text, visionlejossincorregiroi_v_lejos_s_oi text, visionlejoscorregidaod_v_lejos_c_od text, visionlejoscorregidaoi_v_lejos_c_oi text, visionbinocular_v_binocular text, enfermedadesocularesoftalmo_e_oculares text, enfermedadesocularesotrosoftalmo_e_oculares1 text, ausentesodontograma_txtausentes integer, observacionesodontograma_txtobservaciones text, piezasmalestadoodontograma_txtpiezasmalestado integer, observacionesradiografiatorax_txtobservacionesrt text, observacioneslaboratorioclinico_txtobservacioneslb text, examenradiograficossanguineos_txtobservacionesrs text, glucosalaboratorioclinico_txtglucosabio text, vsglaboratorioclinico_txtvsg text, cocainalaboratorioclinico_txtcocaina text, marihuanalaboratorioclinico_txtmarihuana text, creatininalaboratorioclinico_txtcreatininabio text, oidoderecho500audiometria_o_d_500 text, oidoderecho1000audiometria_o_d_1000 text, oidoderecho2000audiometria_o_d_2000 text, oidoderecho3000audiometria_o_d_3000 text, oidoderecho4000audiometria_o_d_4000 text, oidoderecho6000audiometria_o_d_6000 text, oidoderecho8000audiometria_o_d_8000 text, oidoizquierdo500audiometria_o_i_500 text, oidoizquierdo1000audiometria_o_i_1000 text, oidoizquierdo2000audiometria_o_i_2000 text, oidoizquierdo3000audiometria_o_i_3000 text, oidoizquierdo4000audiometria_o_i_4000 text, oidoizquierdo6000audiometria_o_i_6000 text, oidoizquierdo8000audiometria_o_i_8000 text, diagnosticoaudiometricocompleto_diagnostico text, normalaudiometria_chkdnormal boolean, traumaleveodaudiometria_chkdtaleveod boolean, traumaleveoiaudiometria_chkdtaleveoi boolean, traumaavanzadoodaudiometria_chkdtaavanzadood boolean, traumaavanzadooiaudiometria_chkdtaavanzadooi boolean, hipoacusialeveodaudiometria_chkdhrleveod boolean, hipoacusialeveoiaudiometria_chkdhrleveoi boolean, hipoacusiamoderadaodaudiometria_chkdhrmoderadood boolean, hipoacusiamoderadaoiaudiometria_chkdhrmoderadooi boolean, hipoacusiaavanzadaodaudiometria_chkdhravanzadaod boolean, hipoacusiaavanzadaoiaudiometria_chkdhravanzadaoi boolean, otrashipoacusiasaudiometria_chkotrashipoacusias boolean, otrashipoacusiasaudiometria_txtotrashipoacusias text, fvcfuncionrespiratoria_fvc text, fev1funcionrespiratoria_fev1 text, fev1fvcfuncionrespiratoria_fev1fvc text, fef2575funcionrespiratoria_fef25_75 text, interpretacionfuncionrespiratoria_interpretacion text, fechaanexo7c_fecha date, ruidoanexo7c_chkruido boolean, polvoanexo7c_chkpolvo boolean, vidsegmentarioanexo7c_chkvidsegmentario boolean, vidtotalanexo7c_chkvidtotal boolean, cancerigenosanexo7c_chkcancerigenos boolean, mutagenicosanexo7c_chkmutagenicos boolean, solventesanexo7c_chksolventes boolean, metalesanexo7c_chkmetales boolean, temperaturaanexo7c_chktemperatura boolean, biologicosanexo7c_chkbiologicos boolean, posturasanexo7c_chkposturas boolean, turnosanexo7c_chkturnos boolean, cargasanexo7c_chkcargas boolean, movrepetanexo7c_chkmovrepet boolean, pvdanexo7c_chkpvd boolean, otrosanexo7c_chkotros boolean, reubicacionsianexo7c_tbrsi boolean, reubicacionnoanexo7c_rbrno boolean, tabaconadaaexo7c_chktnada boolean, tabacopocoanexo7c_chktpoco boolean, tabacohabitualanexo7c_chkthabitual boolean, tabacoexcesivoanexo7c_chktexcesivo boolean, alcoholnadaanexo7c_chkanada boolean, alcoholpocoanexo7c_chkapoco boolean, alcoholhabitualanexo7c_chkahabitual boolean, alcoholexcesivoanexo7c_chkaexcesivo boolean, drogasnadaanexo7c_chkdnada boolean, drogaspocoanexo7c_chkdpoco boolean, drogashabitualanexo7c_chkdhabitual boolean, drogasexcesivoanexo7c_chkdexcesivo boolean, puestoactualanexo7c_txtpuestoactual text, tiempoanexo7c_txttiempo text, antecedentespersonalesanexo7c_txtantecedentespersonales text, antecedentespersonales2anexo7c_txtantecedentespersonales2 text, antecedentesfamiliaresanexo7c_txtantecedentesfamiliares text, cabezaanexo7c_txtcabeza text, narizanexo7c_txtnariz text, cuelloanexo7c_txtcuello text, perimetroanexo7c_txtperimetro text, baflanexo7c_txtb_a_f_l text, visioncoloresanexo7c_txtvisioncolores text, enfermedadesocularesanexo7c_txtenfermedadesoculares text, diagnosticoaudioanexo7c_txtdiagnosticoaudio text, enfermedadesoculares2anexo7c_txtenfermedadesoculares2 text, reflejospupilaresanexo7c_txtreflejospupilares text, binocularanexo7c_txtbinocular text, odanexo7c_txtod text, oianexo7c_txtoi text, toraxanexo7c_txttorax text, corazonanexo7c_txtcorazon text, pulmonesnormalanexo7c_rbnormal boolean, pulmonesanormalanexo7c_rbanormal boolean, pulmonesdescripcionanexo7c_txtpulmones text, miembrossuperioresanexo7c_txtmiembrossuperiores text, miembrosinferioresanexo7c_txtmiembrosinferiores text, reflejososteotendinososanexo7c_txtreflejososteotendinosos text, marchaanexo7c_txtmarcha text, columnavertebralanexo7c_txtcolumnavertebral text, abdomenanexo7c_txtabdomen text, anillosinguinalesanexo7c_txtanillosinguinales text, organosgenitalesanexo7c_txtorganosgenitales text, tactorectalnohizoanexo7c_rbtnohizo boolean, tactorectalnormalanexo7c_rbtnormal boolean, tactorectalanormalanexo7c_rbtanormal boolean, describirobservacionanexo7c_chkdescribirobservacion boolean, herniasanexo7c_txthernias text, varicesanexo7c_txtvarices text, gangliosanexo7c_txtganglios text, lenguageanexo7c_txtlenguage text, observacionesfichamedicaanexo7c_txtobservacionesfm text, conclusionanexo7c_txtconclusion text, tetanoanexo7c_tetano boolean, hepatitisbanexo7c_hepatitisb boolean, fiebreamarillaanexo7c_fiebreamarilla boolean, diagnosticoaudio2anexo7c_txtdiagnosticoaudio text, conclusionmedicoanexo7c_txtconclusionmed text, estadomentalanexo7c_txtestadomental text, anamnesisanexo7c_txtanamnesis text, alturaestructuraanexo7c_altura_estructura boolean, alturageoganexo7c_altura_geog boolean, quimicosanexo7c_quimicos boolean, electricosanexo7c_electricos boolean, vibracionesanexo7c_vibraciones boolean,
antecedentesPatologicos_ante_patologicos text,
positivoLaboratorioClinico_chkpositivo boolean,
negativoLaboratorioClinico_chknegativo boolean,
grupoSanguineoO_chko boolean,
grupoSanguineoA_chka boolean,
grupoSanguineoB_chkb boolean,
grupoSanguineoAB_chkab boolean,
grupoSanguineoRhPositivo_rbrhpositivo boolean,
grupoSanguineoRhNegativo_rbrhnegativo boolean,
hemoglobina_txthemoglobina text,
examenFisicoColor_txtcoloref text,
examenFisicoDensidad_txtdensidadef text, 
examenFisicoAspecto_txtaspectoef text,
examenFisicoPh_txtphef text, 
examenQuimicoNitritos_txtnitritoseq text,
examenQuimicoProteinas_txtproteinaseq text, 
examenQuimicoCetonas_txtcetonaseq text,
examenQuimicoLeucocitos_txtleucocitoseq text, 
examenQuimicoUrobilinogeno_txturobilinogenoeq text, 
examenQuimicoBilirubina_txtbilirubinaeq text, 
examenQuimicoGlucosa_txtglucosaeq text,
examenQuimicoSangre_txtsangreeq text,
sedimientoUrinarioLeucocitos_txtleucocitossu text,
sedimientoUrinarioEpiteliales_txtcelepitelialessu text, 
sedimientoUrinarioCilindios_txtcilindiossu text, 
sedimientoUrinarioBacterias_txtbacteriassu text, 
sedimientoUrinarioHematies_txthematiessu text, 
sedimientoUrinarioCristales_txtcristalessu text, 
sedimientoUrinarioPus_txtpussu text, 
sedimientoUrinarioOtros_txtotrossu text,
hallazgosInformeElectroCardiograma_hallazgo text,
recomendacionesInformeElectroCardiograma_recomendaciones text,
verticesRadiografiaTorax_txtvertices text,
hiliosRadiografiaTorax_txthilios text,
senosCostoFrenicosRadiografiaTorax_txtsenoscostofrenicos text,
mediastinosRadiografiaTorax_txtmediastinos text,
siluetaCardioVascularRadiografiaTorax_txtsiluetacardiovascular text,
osteomuscularRadiografiaTorax_txtosteomuscular text,
conclusionesRadiograficasTorax_txtconclusionesradiograficas text,
camposPulmonesRadiografiaTorax_txtcampospulm text,
colesterolAnalisisBioquimico_txtcolesterol text, 
ldlcolesterolAnalisisBioquimico_txtldlcolesterol text,
hdlcolesterolAnalisisBioquimico_txthdlcolesterol text, 
vldlcolesterolAnalisisBioquimico_txtvldlcolesterol text,
trigliseridosAnalisisBioquimico_txttrigliseridos text,
norden_n_orden integer
  ) AS
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
	    a.chkotros,
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
	    a.altura_estructura,
	    a.altura_geog,
	    a.quimicos,
	    a.electricos,
	    a.vibraciones,
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
	    n.n_orden
	    
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
	WHERE a.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_reporte_anexo16(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(
fechaAnexo7c_fecha date,
telefonoTrabajoPaciente_tel_trabajo_pa text,
telefonoCasaPaciente_tel_casa_pa text,
celularPaciente_cel_pa text,
dni_cod_pa integer,
sexo_sexo_pa "char",
numeroContacto_num_contacto text,
direccionPaciente_direccion text,
fechaNacimientoPaciente_fecha_nacimiento_pa date,
lugarNacimientoPaciente_lugar_nac_pa text,
estadoCivilPaciente_estado_civil_pa text,
nivelEstudioPaciente_nivel_est_pa text,
cargo_cargo_de text,
fvcFuncionRespiratoria_fvc text,
fev1FuncionRespiratoria_fev1 text,
fev1FvcFuncionRespiratoria_fev1fvc text,
fef2575FuncionRespiratoria_fef25_75 text,
empresa_razon_empresa text,
explotacion_nom_ex text,
altura_altura_po text,
contrata_razon_contrata text,
norden_n_orden integer,
fechaApertura_fecha_apertura_po date,
nombreExamen_nom_examen text,
mineral_mineral_po text,
nombres_nombres text,
edad_edad text,
perimetroCuelloTriaje_perimetro_cuello text,
imcTriaje_imc text,
pesoTriaje_peso text,
tallaTriaje_talla text,
cinturaTriaje_cintura text,
caderaTriaje_cadera text,
iccTriaje_icc text,
temperaturaTriaje_temperatura text,
frecuenciaRespiratoriaTriaje_f_respiratoria text,
frecuenciaCardiacaTriaje_f_cardiaca text,
saturacionOxigenoTriaje_sat_02 text,
sistolicaTriaje_sistolica text,
diastolicaTriaje_diastolica text,

ruidoAnexo7c_chkruido boolean,
polvoAnexo7c_chkpolvo boolean,
vidSegmentarioAnexo7c_chkvidsegmentario boolean,
vidTotalAnexo7c_chkvidtotal boolean,
cancerigenosAnexo7c_chkcancerigenos boolean,
mutagenicosAnexo7c_chkmutagenicos boolean,
solventesAnexo7c_chksolventes boolean,
metalesAnexo7c_chkmetales boolean,
temperaturaAnexo7c_chktemperatura boolean,
biologicosAnexo7c_chkbiologicos boolean,
posturasAnexo7c_chkposturas boolean,
turnosAnexo7c_chkturnos boolean,
cargasAnexo7c_chkcargas boolean,
movRepetAnexo7c_chkmovrepet boolean,
pvdAnexo7c_chkpvd boolean,
otrosAnexo7c_chkotros boolean,
reubicacionSiAnexo7c_tbrsi boolean,
reubicacionNoAnexo7c_rbrno boolean,
puestoActualAnexo7c_txtpuestoactual text,
tiempoAnexo7c_txttiempo text,
antecedentesPersonalesAnexo7c_txtantecedentespersonales text,
antecedentesFamiliaresAnexo7c_txtantecedentesfamiliares text,
tetanoAnexo7c_tetano boolean,
hepatitisBAnexo7c_hepatitisb boolean,
fiebreAmarillaAnexo7c_fiebreamarilla boolean,
hijosVivosAnexo7c_txthijosvivos text,
hijosMuertosAnexo7c text,
tabacoNadaAexo7c_chktnada boolean,
tabacoPocoAnexo7c_chktpoco boolean,
tabacoHabitualAnexo7c_chkthabitual boolean,
tabacoExcesivoAnexo7c_chktexcesivo boolean,
alcoholNadaAnexo7c_chkanada boolean,
alcoholPocoAnexo7c_chkapoco boolean,
alcoholHabitualAnexo7c_chkahabitual boolean,
alcoholExcesivoAnexo7c_chkaexcesivo boolean,
drogasNadaAnexo7c_chkdnada boolean,
drogasPocoAnexo7c_chkdpoco boolean,
drogasHabitualAnexo7c_chkdhabitual boolean,
drogasExcesivoAnexo7c_chkdexcesivo boolean,
conclusionAnexo7c_txtconclusion text,
cabezaAnexo7c_txtcabeza text,
narizAnexo7c_txtnariz text,
cuelloAnexo7c_txtcuello text,
perimetroAnexo7c_txtperimetro text,
baflAnexo7c_txtb_a_f_l text,
visionColoresAnexo7c_txtvisioncolores text,
enfermedadesOcularesAnexo7c_txtenfermedadesoculares text,
reflejosPupilaresAnexo7c_txtreflejospupilares text,
binocularAnexo7c_txtbinocular text,
odAnexo7c_txtod text,
oiAnexo7c_txtoi text,
toraxAnexo7c_txttorax text,
corazonAnexo7c_txtcorazon text,
pulmonesNormalAnexo7c_rbnormal boolean,
pulmonesAnormalAnexo7c_rbanormal boolean,
pulmonesDescripcionAnexo7c_txtpulmones text,
miembrosSuperioresAnexo7c_txtmiembrossuperiores text,
miembrosInferioresAnexo7c_txtmiembrosinferiores text,
ausentesOdontograma_txtausentes integer,
piezasMalEstadoOdontograma_txtpiezasmalestado integer,

visionCercaSinCorregirOd_v_cerca_s_od text,
visionCercaSinCorregirOi_v_cerca_s_oi text,
odcc_odcc text,
oicc_oicc text,
visionLejosSinCorregirOd_v_lejos_s_od text,
visionLejosSinCorregirOi_v_lejos_s_oi text,
odlc_odlc text,
oilo_oilc text,
vc_vc text,
vb_vb text,
rp_rp text,
enfermedadesOcularesOftalmo_e_oculares text,
enfermedadesOcularesOtrosOftalmo_e_oculares1 text,
enfermedadesOcularesVisionLejos_e_oculvisionlejos text,
tecishiharaNormal_rbtecishihara_normal boolean,
tecishiharaAnormal_rbtecishihara_anormal boolean,
teccoleresNormal_rbteccoleres_normal boolean,
teccoleresAnormal_rbteccoleres_anormal boolean,
tecestereopsiaNormal_rbtecestereopsia_normal boolean,
tecestereopsiaAnormal_rbtecestereopsia_anormal boolean,

oidoDerecho500Audiometria_o_d_500 text,

reflejosOsteotendinososAnexo7c_txtreflejososteotendinosos text,
marchaAnexo7c_txtmarcha text,
columnaVertebralAnexo7c_txtcolumnavertebral text,
abdomenAnexo7c_txtabdomen text,
anillosInguinalesAnexo7c_txtanillosinguinales text,
organosGenitalesAnexo7c_txtorganosgenitales text,
tactoRectalNoHizoAnexo7c_rbtnohizo boolean,
tactoRectalNormalAnexo7c_rbtnormal boolean,
tactoRectalAnormalAnexo7c_rbtanormal boolean,
describirObservacionAnexo7c_chkdescribirobservacion boolean,
herniasAnexo7c_txthernias text,
varicesAnexo7c_txtvarices text,
gangliosAnexo7c_txtganglios text,
lenguageAnexo7c_txtlenguage text,
observacionesFichaMedicaAnexo7c_txtobservacionesfm text,
nRx_n_rx integer,
fechaExamenRadiografico_fecha_exra date,
calidadExamenRadiografico_txtcalidad text,
simbolosExamenRadiografico_txtsimbolos text,
conclusionMedicoAnexo7c_txtconclusionmed text,
estadoMentalAnexo7c_txtestadomental text,
anamnesisAnexo7c_txtanamnesis text,
examenRadiografico0_ex_0 boolean,
examenRadiografico10_ex_10 boolean,
examenRadiografico11_ex_11 boolean,
examenRadiografico12_ex_12 boolean,
examenRadiografico21_ex_21 boolean,
examenRadiografico22_ex_22 boolean,
examenRadiografico23_ex_23 boolean,
examenRadiografico32_ex_32 boolean,
examenRadiografico33_ex_33 boolean,
examenRadiografico3mas_ex_3mas boolean,
examenRadiograficoAbc_ex_abc boolean,
examenRadiograficoSt_ex_st boolean,
examenRadiograficoSinNeumoconiosis_txtsinneumoconiosis text,
examenRadiograficoConNeumoconiosis_txtconneumoconiosis text,
examenRadiograficoIrep_txtirep text,
examenRadiograficoOtros_txtotrosex text,
examenRadiograficoAptoSi_apto_si boolean,
examenRadiograficoAptoNo_apto_no boolean,
examenRadiograficoAptoRe_apto_re boolean,
verticesRadiografiaTorax_txtvertices text,
hilosRadiografiaTorax_txthilios text,
senosCostoFrenicos_txtsenoscostofrenicos text,
Meadiastinos_txtmediastinos text,
siluetaCardioVascular_txtsiluetacardiovascular text,
conclusionesRadiograficas_txtconclusionesradiograficas text,
color integer,
grupoSanguineoO_chko boolean,
grupoSanguineoA_chka boolean,
grupoSanguineoB_chkb boolean,
grupoSanguineoAB_chkab boolean,
grupoSanguineoRhPositivo_rbrhpositivo boolean,
grupoSanguineoRhNegativo_rbrhnegativo boolean,
hemoglobina_txthemoglobina text,
positivoLaboratorioClinico_chkpositivo boolean,
negativoLaboratorioClinico_chknegativo boolean,
glucosaLaboratorioClinico_txtglucosabio text,
creatininaLaboratorioClinico_txtcreatininabio text,
vsgLaboratorioClinico_txtvsg text,
cocainaLaboratorioClinico_txtcocaina text,
marihuanaLaboratorioClinico_txtmarihuana text,
creatininaAnalisisBioquimico_txtcreatinina text,
colesterolAnalisisBioquimico_txtcolesterol text,
ldlcolesterolAnalisisBioquimico_txtldlcolesterol text,
hdlcolesterolAnalisisBioquimico_txthdlcolesterol text,
vldlcolesterolAnalisisBioquimico_txtvldlcolesterol text,
trigliceridosAnalisisBioquimico_txttrigliceridos text,
sede text,
nombreSede text,
numero text,
nameJasper text
  ) AS
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
	    a.chkotros,
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
	    
	    CASE WHEN au.o_d_500 is not null THEN au.o_d_500
		 WHEN a25.o_d_500 is not null THEN a25.o_d_500 else m.o_d_500 end as o_d_500,
	    
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
	     obtener_name_jasper(p_norden, name_service)
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
	WHERE n.n_orden = p_norden
	LIMIT 1;
END;
$BODY$
  LANGUAGE plpgsql;

-----------------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION obtener_reporte_consentimiento_buena_salud(
    IN p_norden integer,
    IN name_service text)
  RETURNS TABLE(
nombres text,
dni integer,
sexo "char",
edad text,
fechaNac date,
empresa text,
contrata text,
ocupacion text,
area text,
norden integer,
fecha date,
hora time without time zone,
usuarioRegistro text,
color integer,
sede_descripcion text,
nom_sede text,
nombre_jasper text
  ) AS
$BODY$
BEGIN
    RETURN QUERY
    SELECT 
    dp.nombres_pa || ' ' || dp.apellidos_pa,
    noo.cod_pa,
    dp.sexo_pa,
    CAST(obtener_edad(dp.fecha_nacimiento_pa, current_date) AS TEXT),
    dp.fecha_nacimiento_pa,
    noo.razon_empresa,
    noo.razon_contrata,
    noo.cargo_de,
    noo.area_o,
    CASE WHEN cb.n_orden IS NULL THEN noo.n_orden ELSE cb.n_orden END,
    cb.fecha,
    cb.hora,
    cb.user_registro,
    noo.color,
    CASE WHEN UPPER(TRIM(noo.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,
    CASE
        WHEN UPPER(TRIM(noo.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
        WHEN noo.cod_sede = 1 THEN 'Trujillo'
        WHEN noo.cod_sede = 2 THEN 'Huamachuco'
        WHEN noo.cod_sede = 3 THEN 'Huancayo'
        WHEN noo.cod_sede = 4 THEN 'Trujillo'
    END AS nom_sede,
    obtener_name_jasper(p_norden, name_service)
  FROM datos_paciente dp
  INNER JOIN n_orden_ocupacional noo ON noo.cod_pa = dp.cod_pa
  LEFT JOIN consentimientobuenasalud cb ON cb.n_orden = noo.n_orden
  INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
  WHERE noo.n_orden = p_norden;

END;
$BODY$
  LANGUAGE plpgsql;


------------------------------------------------------------------------------------------------------


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
    valor_electro_cardiograma boolean;
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

   -- obtener valor boolean del campo informe_completo de electro cardiograma
    SELECT CASE WHEN informe_completo IS NULL THEN TRUE ELSE informe_completo END AS informe_completo INTO valor_electro_cardiograma from informe_electrocardiograma where n_orden=norden_param;

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
    ELSIF name_service_param = 'consentimiento_rayosx' THEN
	resultado := 'ConsentimientoRayosX_Digitalizado';
    ELSIF name_service_param = 'test_fatiga_somnolencia' THEN
	resultado := 'TestFatigaSomnolenia_Digitalizado_boro';
    ELSIF name_service_param = 'informe_electrocardiograma' THEN
	IF valor_electro_cardiograma = TRUE THEN
		resultado := 'InformeElectrocardiograma2023';
	ELSE
		resultado := 'InformeElectrocardiograma_Digitalizado';
	END IF;
    ELSIF name_service_param = 'antece_enfermedades_altura' THEN
	IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
		resultado := 'AnexoCB_boro_Digitalizado';
	ELSE
		resultado := 'AnexoCB_Digitalizado';
	END IF;
    ELSIF name_service_param = 'anexo_agroindustrial' THEN
	resultado := 'Anexo2';
    ELSIF name_service_param = 'consentimientobuenasalud' THEN
	resultado := 'ConsentimientoBuenaSalud2021_Digitalizado';
    ELSIF name_service_param = 'anexo7c' THEN
	IF name_empresa_busqueda_var LIKE '%MINERA BOROO MISQUICHILCA S.A.%' OR name_empresa_busqueda_var ILIKE '%EMPRESA DE TRANSPORTES N & V S.A.C.%'
		OR name_empresa_busqueda_var ILIKE '%DEYFOR EIRL%' THEN
		resultado := 'Anexo7C_Boro';
	ELSE
		resultado := 'Anexo7C';
	END IF;
  END IF; 
    RETURN resultado;
END;
$BODY$
  LANGUAGE plpgsql;

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('anexo_agroindustrial','formulario de anexo 2',true,true,true,false,false);

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('consentimientobuenasalud','formulario de consentimiento de buena salud',true,true,false,false,false);

insert into config_general_service_digital (name_service,descripcion,firma_p,huella_p,sello_prof_s,sello_doc_asig,sello_doc_adic)
			values('anexo7c','formulario de anexo 16',true,true,true,false,false);

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
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
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
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'consentimiento_rayosx' THEN
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


IF name_servicio_param = 'test_fatiga_somnolencia' THEN
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
            FROM test_fatiga_somnolencia WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'informe_electrocardiograma' THEN
        
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN 
            SELECT user_registro INTO user_registro_var 
            FROM informe_electrocardiograma WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'antece_enfermedades_altura' THEN
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
            FROM antece_enfermedades_altura WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'anexo_agroindustrial' THEN
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
            FROM anexo_agroindustrial WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
            descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
        END IF;
    END IF;

    IF name_servicio_param = 'consentimientobuenasalud' THEN
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

    IF name_servicio_param = 'anexo7c' THEN
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
            FROM anexo7c WHERE n_orden = norden_param;
            select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
		IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
		    dni_user_registro_var := 42664426;
		ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
		    dni_user_registro_var := 66666666;
		END IF;
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

        if(p_examen_med='consentimiento_rayosx') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consentimiento_rayosx where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;


        if(p_examen_med='test_fatiga_somnolencia') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from test_fatiga_somnolencia where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='informe_electrocardiograma') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from informe_electrocardiograma where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='antece_enfermedades_altura') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from antece_enfermedades_altura where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='anexo_agroindustrial') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from anexo_agroindustrial where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='consentimientobuenasalud') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from consentimientobuenasalud where n_orden=p_historia_clinica limit 1;
		if(v_id_existencia=0) THEN
			v_mensaje:='SIN REGISTROS EN EL SISTEMA';
		else
			v_mensaje:='YA FUE REGISTRADO';
				
		end if;
		
        end if;

        if(p_examen_med='anexo7c') THEN
	   select (CASE WHEN COUNT(*) >0 THEN 1 ELSE 0 END) into v_id_existencia  from anexo7c where n_orden=p_historia_clinica limit 1;
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


CREATE OR REPLACE FUNCTION obtener_anexo2_examenes_realizados(IN p_norden integer)
  RETURNS TABLE(nombresPaciente text, nombreExamen text, triaje boolean, laboratorioclinico boolean, electrocardiograma boolean, radiografiatorax boolean, fichaaudiologica boolean, espirometria boolean, odontograma boolean, psicologia boolean, anexo7d boolean, historiaocupacional boolean, fichaantecedentespatologicos boolean, cuestionarionordico boolean, certificadotrabajoaltura boolean, detencionsas boolean, consentimientodosaje boolean, examenradiografiasanguineos boolean, perimetrotoraxico boolean, oftalmologia boolean, audiometriapo boolean) AS
$BODY$
BEGIN
    
    RETURN QUERY
    SELECT 
	dp.apellidos_pa || ' ' || dp.nombres_pa,
	noo.nom_examen,
        CASE WHEN t.n_orden IS NULL THEN FALSE ELSE TRUE END AS triaje,
        CASE WHEN lc.n_orden IS NULL THEN FALSE ELSE TRUE END AS laboratorioClinico,
        CASE WHEN ie.n_orden IS NULL THEN FALSE ELSE TRUE END AS electroCardiograma,
        CASE WHEN rt.n_orden IS NULL THEN FALSE ELSE TRUE END AS radiografiaTorax,
        CASE WHEN fau.n_orden IS NULL THEN FALSE ELSE TRUE END AS fichaAudiologica,
        CASE WHEN fa.n_orden IS NULL THEN FALSE ELSE TRUE END AS espirometria,
        CASE WHEN od.n_orden IS NULL THEN FALSE ELSE TRUE END AS odontograma,
        CASE WHEN ip.n_orden IS NULL THEN FALSE ELSE TRUE END AS psicologia,
        CASE WHEN a7.n_orden IS NULL THEN FALSE ELSE TRUE END AS anexo7D,
        CASE WHEN hoi.n_orden IS NULL THEN FALSE ELSE TRUE END AS historiaOcupacional,
        CASE WHEN apa.n_orden IS NULL THEN FALSE ELSE TRUE END AS fichaAntecedentesPatologicos,
        CASE WHEN cn.n_orden IS NULL THEN FALSE ELSE TRUE END AS cuestionarioNordico,
        CASE WHEN cma.n_orden IS NULL THEN FALSE ELSE TRUE END AS certificadoTrabajoAltura,
        CASE WHEN fsas.n_orden IS NULL THEN FALSE ELSE TRUE END AS detencionSAS,
        CASE WHEN cl.n_orden IS NULL THEN FALSE ELSE TRUE END AS consentimientoDosaje,
        CASE WHEN ers.n_orden IS NULL THEN FALSE ELSE TRUE END AS examenRadiografiaSanguineos,
        CASE WHEN pto.n_orden IS NULL THEN FALSE ELSE TRUE END AS perimetroToraxico,
        CASE WHEN oft.n_orden IS NULL THEN FALSE ELSE TRUE END AS oftalmologia,
        CASE WHEN apo.n_orden IS NULL THEN FALSE ELSE TRUE END AS audiometriaPo
    FROM n_orden_ocupacional noo
    INNER JOIN datos_paciente dp ON noo.cod_pa = dp.cod_pa
    LEFT JOIN triaje t ON t.n_orden = noo.n_orden
    LEFT JOIN lab_clinico lc ON lc.n_orden = noo.n_orden
    LEFT JOIN informe_electrocardiograma ie ON ie.n_orden = noo.n_orden
    LEFT JOIN radiografia_torax rt ON rt.n_orden = noo.n_orden
    LEFT JOIN ficha_audiologica fau ON fau.n_orden = noo.n_orden
    LEFT JOIN funcion_abs fa ON fa.n_orden = noo.n_orden
    LEFT JOIN odontograma od ON od.n_orden = noo.n_orden
    LEFT JOIN informe_psicologico ip ON ip.n_orden = noo.n_orden
    LEFT JOIN anexo7d a7 ON a7.n_orden = noo.n_orden
    LEFT JOIN historia_oc_info hoi ON hoi.n_orden = noo.n_orden
    LEFT JOIN antecedentes_patologicos apa ON apa.n_orden = noo.n_orden
    LEFT JOIN cuestionario_nordico cn ON cn.n_orden = noo.n_orden
    LEFT JOIN certificacion_medica_altura cma ON cma.n_orden = noo.n_orden
    LEFT JOIN ficha_sas fsas ON fsas.n_orden = noo.n_orden
    LEFT JOIN consent_laboratorios cl ON cl.n_orden = noo.n_orden
    LEFT JOIN ex_radiograficos_sanguineos ers ON ers.n_orden = noo.n_orden
    LEFT JOIN perimetro_toracico pto ON pto.n_orden = noo.n_orden
    LEFT JOIN oftalmologia oft ON oft.n_orden = noo.n_orden
    LEFT JOIN audiometria_po apo ON apo.n_orden = noo.n_orden
    INNER JOIN sede_multisucursal sm ON noo.cod_sede = sm.id
    WHERE noo.n_orden = p_norden;

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