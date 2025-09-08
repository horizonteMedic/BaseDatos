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
	telefonoTrabajoPaciente text,
	telefonoCasaPaciente text,
	celularPaciente text,
	dni integer,
	sexo "char",
	direccionPaciente text,
	fechaNacimientoPaciente date,
	lugarNacPaciente text,
	estadoCivilPaciente text,
	nivelEstudiosPaciente text,
	departamentoPaciente text,
	provinciaPaciente text,
	distritoPaciente text,
	emailPaciente text,
	nombres text,
	edad text,
	cargo text,
	empresa text,
	explotacion text,
	altura text,
	contrata text,
	nOrden integer,
	fechaApertura date,
	mineral text,
	color text,
	nombreExamen text,

	fechaAnexo date,
	codigoAnexo text,

	neoplasia boolean,
	neoplasiaDescripcion text,
	its boolean,
	itsDescripcion text,
	quemaduras boolean,
	quemadurasDescripcion text,
	cirugias boolean,
	cirugiasDescripcion text,
	antecedentesPersonalesOtros boolean,
	antecedentesPersonalesOtrosDescripcion text,

	residenciaSi boolean,
	residenciaNo boolean,
	residenciaTiempo text,
	essalud boolean,
	eps boolean,
	residenciaTrabajoOtros boolean,
	sctr boolean,
	sctrOtros boolean,
	padre text,
	madre text,
	hermanos text,
	esposa text,
	totalHijos text,
	numeroDependientes text,
	puestoActual text,
	tiempo text,
	medicamentosSi boolean,
	medicamentosNo boolean,
	tipoMedicamento text,
	frecuenciaMedicamentos text,

	cabeza text,
	nariz text,
	cuello text,
	perimetro text,
	boca text,
	oidos text,
	faringe text,
	miembrosSuperiores text,
	miembrosInferiores text,
	ectoscopia text,
	estadoMental text,
	anamnesis text,
	marcha text,
	columnaVertebral text,
	aparatoRespiratorio text,
	aparatoCardiovascular text,
	aparatoDigestivo text,
	aparatoGeiotourinario text,
	aparatoLocomotor text,
	sistemaLinfatico text,
	piel text,
	observacionesFichaMedica text,
	conclusion text,
	enfermedadesOcularesOtros text,
	sistemaNervioso text,
	otrosExamenes text,
	restricciones text,
	esApto boolean,
	noEsApto boolean,
	aptoRestriccion boolean,

	fvc text,
	fev1 text,
	fev1fvc text,
	fef2575 text,
	interpretacion text,

	perimetroCuello text,
	imc text,
	peso text,
	talla text,
	cintura text,
	cadera text,
	icc text,
	temperatura text,
	fRespiratoria text,
	fCardiaca text,
	sat02 text,
	sistolica text,
	diastolica text,

	codigoAntecedentesPatologicos integer,
	fechaAntecedentes date,
	hijosVivosAntecedentesPatologicos text,
	hijosFallecidosAntecedentesPatologicos text,
	padreAntecedentesPatologicos text,
	madreAntecedentesPatologicos text,
	hermanosAntecedentesPatologicos text,
	hijosAntecedentesPatologicos text,
	esposaAntecedentesPatologicos text,

	visionCercaSinCorregirOd text,
	visionCercaSinCorregirOi text,
	visionCercaCorregidaOd text,
	visionCercaCorregidaOi text,
	visionLejosSinCorregirOd text,
	visionLejosSinCorregirOi text,
	visionLejosCorregidaOd text,
	visionLejosCorregidaOi text,
	visionColores text,
	visionBinocular text,
	reflejosPupilares text,
	enfermedadesOcularesOftalmo text,
	enfermedadesOcularesOtrosOftalmo text,

	odcc text,
	oicc text,
	odlc text,
	oilc text,
	vc text,
	vb text,
	rp text,

	ausentes integer,
	piezasMalEstado integer,
	observaciones text,

	oidoDerecho500 text,
	oidoDerecho1000 text,
	oidoDerecho2000 text,
	oidoDerecho3000 text,
	oidoDerecho4000 text,
	oidoDerecho6000 text,
	oidoDerecho8000 text,
	oidoIzquierdo500 text,
	oidoIzquierdo1000 text,
	oidoIzquierdo2000 text,
	oidoIzquierdo3000 text,
	oidoIzquierdo4000 text,
	oidoIzquierdo6000 text,
	oidoIzquierdo8000 text,
	diagnostico text,

	recomendacionesInfoPsicologico text,

	conclusionesRadiograficas text,

	observacionesLabClinico text,

	colesterol text,
	ldlColesterol text,
	hdlColesterol text,
	vldlColesterol text,
	trigliseridos text,

	hallazgos text,
	recomendaciones text,

	sede text,
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
	    d.apellidos_pa || ' ' || d.nombres_pa AS nombres,
	    CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),

	    -- 📌 n_orden_ocupacional (n)
	    n.cargo_de, n.razon_empresa, n.nom_ex, n.altura_po, 
	    n.razon_contrata, n.n_orden, n.fecha_apertura_po, n.mineral_po, 
	    n.color,

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
	    a.chkresidenciasi, a.chkresidenciano,
	    a.txttiemporesidencia, 
	    a.chkessalud, a.chkeps, a.chkotros, a.chksctr, a.chkotros1,
	    a.txtpadre, a.txtmadre, a.txthermanos, a.txtesposa, 
	    a.txtpuestoactual, a.txttiempo,
	    a.rbsimed, a.rbnomed, a.txttipomedicamento, a.txtfrecuenciamed,
	    a.txttotalhijos, a.txtndependientes,
	    a.txtpelo, a.txtnariz, a.txtcuello, a.txtperimetro, 
	    a.txtboca, a.txtoidos, a.txtfaringe,
	    a.txtmiembrossuperiores, a.txtmiembrosinferiores, a.txtectoscopia,
	    a.txtestadomental, a.txtanamnesis, a.txtmarcha, a.txtcolumnavertebral,
	    a.txtaparatorespiratorio, a.txtaparatocardiovascular, a.txtaparatodigestivo,
	    a.txtaparatogeiotourinario, a.txtaparatolocomotor, a.txtsistemalinfatico,
	    a.txtpiel, a.txtobservacionesfm, a.txtconclusion, a.txtenfermedadesoculares1,
	    a.sistemanervioso, a.txtotrosex, a.txtrestricciones, 
	    a.apto_si, a.apto_no, a.apto_re,

	    -- 📌 funcion_abs (f)
	    f.fvc, f.fev1, f.fev1fvc, f.fef25_75,

	    -- 📌 triaje (t)
	    t.perimetro_cuello, t.imc, t.peso, t.talla, t.cintura, t.cadera, t.icc,
	    t.temperatura, t.f_respiratoria, t.f_cardiaca, t.sat_02, 
	    t.sistolica, t.diastolica,

	    -- 📌 antecedentes_patologicos (ap)
	    ap.cod_ap, ap.fecha_ap,
	    ap.txtvhijosvivos,    ap.txtvhijosfallecidos, ap.padre_detall, ap.madre_detall,
	    ap.hermanos_detall, ap.hijos_detall, ap.espos_cony_detall,

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
	    r.txtconclusionesradiograficas,

	    -- 📌 laboratorio clinico (la)
	    la.txtobservacioneslb,

	    -- 📌 analisis_bioquimicos (ab)
	    ab.txtcolesterol, ab.txtldlcolesterol, ab.txthdlcolesterol, ab.txtvldlcolesterol,
	    ab.txttrigliseridos,

	    -- 📌 informe_electrocardiograma (ie)
	    ie.hallazgo, ie.recomendaciones,

	    -- 📌 sede
	    CASE WHEN UPPER(TRIM(n.razon_empresa))= 'CIA MINERA PODEROSA S A' THEN 'Huamachuco' else (CAST(sm.descripcion AS TEXT)) end,

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
	WHERE n.n_orden = p_norden;
END;
$BODY$
  LANGUAGE plpgsql;