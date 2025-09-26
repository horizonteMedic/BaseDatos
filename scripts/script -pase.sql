

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
  RETURNS TABLE(
dni_cod_pa integer,
nombres_nombres_pa text,
apellidos_apellidos_pa text,
direccionpaciente_direccion_pa text,
sexo_sexo_pa "char",
fechanacimientopaciente_fecha_nacimiento_pa date,
cargo_cargo_de text,
area_area_o text,
contrata_razon_contrata text,
n_orden integer,
empresa_razon_empresa text,
edad_edad text,
color integer,
codigoAntecedentesPatologicos_cod_ap integer,
fechaAntecedentesPatologicos_fecha_ap date,
dniUsuario_dni_user integer,
alergias_chk1 boolean,
amigdalitisCronica_chk2 boolean,
arritmiasCardiacas_chk3 boolean,
asma_chk4 boolean,
bocio_chk5 boolean,
bronconeumonia_chk6 boolean,
bronquitisARepeticion_chk7 boolean,
cariesOGingivitis_chk8 boolean,
colecistitis_chk9 boolean,
dermatitis_chk10 boolean,
diabetes_chk11 boolean,
disenteria_chk12 boolean,
enfermedadesCorazon_chk13 boolean,
enfermedadesOculares_chk14 boolean,
epilsepsiaOConvulsiones_chk15 boolean,
faringitisCronica_chk16 boolean,
fiebreMalta_chk17 boolean,
fiebreTifoidea_chk18 boolean,
fiebreReumatica_chk19 boolean,
foruncolois_chk20 boolean,
gastritisCronica_chk21 boolean,
gonorrea_chk22 boolean,
gota_chk23 boolean,
hemorroides_chk24 boolean,
hepatitis_chk25 boolean,
hernias_chk26 boolean,
hipertencionArterial_chk27 boolean,
urinariasRepetidas_chk28 boolean,
intoxicaciones_chk29 boolean,
insuficienciaCardiaca_chk30 boolean,
insuficienciaCoronariaCronica_chk31 boolean,
insuficienciaRenalCronica_chk32 boolean,
litiasisUrinaria_chk33 boolean,
meningitis_chk34 boolean,
neuritis_chk35 boolean,
otitisMedia_chk36 boolean,
presionAltaOBaja_chk37 boolean,
paludismoOMalaria_chk38 boolean,
parasitosisIntestinal_chk39 boolean,
paratiditis_chk40 boolean,
pleuresia_chk41 boolean,
plumbismo_chk42 boolean,
poliomielitis_chk43 boolean,
portadorMarcapasos_chk44 boolean,
protesisCardiacasValvulares_chk45 boolean,
resfriosFrecuentes_chk46 boolean,
reumatismo_chk47 boolean,
sarampion_chk48 boolean,
sifilis_chk49 boolean,
silicosis_chk50 boolean,
sinusitisCronica_chk51 boolean,
tosConvulsiva_chk52 boolean,
transtornosNerviosos_chk53 boolean,
traumatismoEncefalocraneano_chk54 boolean,
tuberculosis_chk55 boolean,
tumoresQuistes_chk56 boolean,
ulceraPeptica_chk57 boolean,
varicela_chk58 boolean,
varices_chk59 boolean,
varicocele_chk60 boolean,
perdidaMemoria_chk61 boolean,
preocupacionesAngustia_chk62 boolean,
doloresArticulares_chk63 boolean,
aumentoDisminucionPeso_chk64 boolean,
dolorCabeza_chk65 boolean,
diarrea_chk66 boolean,
agitacionEjercicio_chk67 boolean,
dolorOcular_chk68 boolean,
dolorOpresivoTorax_chk69 boolean,
hinchazonPiesOManos_chk70 boolean,
estrenimiento_chk71 boolean,
vomitosConSangre_chk72 boolean,
sangradoPorOrina_chk73 boolean,
tosConSangre_chk74 boolean,
coloracionAmarrillaPiel_chk75 boolean,
indigestionFrecuente_chk76 boolean,
insomnio_chk77 boolean,
lumbalgiaODolorCintura_chk78 boolean,
mareos_chk79 boolean,
hecesNegras_chk80 boolean,
orinaConDolor_chk81 boolean,
orinaInvoluntaria_chk82 boolean,
dolorOido_chk83 boolean,
secrecionesOido_chk84 boolean,
palpitaciones_chk85 boolean,
adormecimientos_chk86 boolean,
pesadillasFrecuentes_chk87 boolean,
doloresMusculares_chk88 boolean,
tosCronica_chk89 boolean,
sangradoEncias_chk90 boolean,
drogasNo_rbdrogasno boolean,
drogasSi_rbdrogassi boolean,
licorNo_rblicorno boolean,
licorSi_rblicorsi boolean,
fumarNo_rbfumarno boolean,
fumarSi_rbfumarsi boolean,
drogasFrecuencia_txtdrogasfrecuencia text,
drogasTipo_txtdrogastipo text,
licorFrecuencia_txtlicorfrecuencia text,
licorTipoFrecuente_txtlicortipofrecuente text,
numeroCigarrillos_txtncigarrillos text,
precisarCausasVarones_txtvcausas text,
hijosVivosVarones_txtvhijosvivos text,
hijosFallecidosVarones_txtvhijosfallecidos text,
abortosParejasVarones_txtvnabortosparejas text,
inicioMestruacionDamas_txtdiniciomestruacion text,
inicioVidaSexualDamas_txtdiniciovidasexual text,
numeroParejasSexActualidadDamas_txtdnumparejassexactualidad text,
hijosVivosDamas_txtdhijosvivos text,
hijosFallecidosDamas_txtdhijosfallecidos text,
numerosDeAbortosDamas_txtdnumerosdeabortos text,
precisarCausasDamas_txtdcausas text,
otrosDescripcionAntecedentesPatologicos_txtotrosap text,
otrosDescripcionIndicarEnfermedades_txtotros1ap text,
covid_chkcovid boolean,
fechaCovid_fechacovid date,
covidLevel_chkcovidl boolean,
covidModerado_chkcovidm boolean,
covidSevero_chkcovids boolean,
dosisVacunas_txtdosis text,
userRegistro_user_registro text,
otrosTipoIndicarEnfermedades_txtotros text,
otrosFrecuenciaIndicarEnfermedades_txtotrosfrecuencia text,
otrosSiIndicarEnfermedades_rbotrossi boolean,
otrosNoIndicarEnfermedades_rbotrosno boolean,
imaBoro_ima boolean,
acvBoro_acv boolean,
tbcBoro_tbc boolean,
vihBoro_vih boolean,
fobiasBoro_fobias boolean,
vertigosBoro_vertigos boolean,
tifoideaBoro_tifoidea boolean,
neoplasiasBoro_neoplasias boolean,
quemadurasBoro_quemaduras boolean,
discopatiasBoro_discopatias boolean,
columnaBoro_columna boolean,
enfermedadesPsiquiatricasBoro_enf_psiquiatricas boolean,
enfermedadesReumaticasBoro_enf_reumatica boolean,
enfermedadesPulmonaresBoro_enf_pulmonares boolean,
enfermedadesPielBoro_enf_piel boolean,
tendinitisBoro_tendinitis boolean,
onicomicosisBoro_onicomicosis boolean,
fracturasBoro_fracturas boolean,
anemiaBoro_anemia boolean,
obesidadBoro_obesidad boolean,
dislipidemiaBoro_dislipidemia boolean,
intoxicacionesBoro_intoxicaciones boolean,
amputacionBoro_amputacion boolean,
sorderaBoro_sordera boolean,
especifiqueTratamientoBoro_especifique_detalleenfermedades text,
alergiasAlimentosBoro_alergias_medic_alim boolean,
alergiasAlimentosEspecifiqueBoro_alergias_medic_alimdetall text,
accidenteTrabajoBoro_accitrabajo boolean,
accidenteTrabajoFechaBoro_accit_fecha date,
descansoMedicoBoro_accit_descanso boolean,
descansoMedicoEspecifiqueBoro_accit_descanso_detal text,
enfermedadesProfesionalesBoro_enfe_prof boolean,
enfermedadesProfesionalesFechaBoro_enfe_profecha date,
enfermedadesLaboralesCalificacionBoro_enfe_lab_calif boolean,
enfermedadesLaboralesEspecifiqueBoro_enfe_lab_califdetal text,
antitetanicaBoro_antitetanica boolean,
fiebreAmarillaBoro_fiebre_amarilla boolean,
influenzaBoro_influenza boolean,
hepatitisABoro_hepatitisa boolean,
hepatitisBBoro_hepatitisb boolean,
gripeInfluenzaBoro_gripe_influenza boolean,
neumococoBoro_neumococo boolean,
rabiaBoro_rabia boolean,
papilomaHumanoBoro_papiloma_humano boolean,
cantidosisBoro_cantidosis boolean,
medicamentoBoro_medicamento boolean,
medicamentoEspecifiqueBoro_medicamento_detal text,
actividadFisicaBoro_activ_fisic boolean,
actividadFisicaEspecifiqueBoro_activ_fisic_detal text,
padreEspecifiqueBoro_padre_detall text,
madreEspecifiqueBoro_madre_detall text,
hermanosEspecifiqueBoro_hermanos_detall text,
hijosEspecifiqueBoro_hijos_detall text,
esposConyEspecifiqueBoro_espos_cony_detall text,
conadisEspecifiqueBoro_conadisdetalle text,
etsBoro_ets boolean,
migranaBoro_migrana boolean,
tiempoIncapacidadBoro_timeincapacidad text,
enfermedadesocularesoftalmo_e_oculares text,
enfermedadesOcularesOtrosOftalmo_e_oculares1 text,
visioncercasincorregirod_v_cerca_s_od text,
visioncercasincorregiroi_v_cerca_s_oi text,
oftalodccmologia_odcc text,
oiccoftalmologia_oicc text,
visionlejossincorregirod_v_lejos_s_od text,
visionlejossincorregiroi_v_lejos_s_oi text,
odlcoftalmologia_odlc text,
oilcoftalmologia_oilc text,
vcoftalmologia_vc text,
vboftalmologia_vb text,
rpoftalmologia_rp text,
ruidoAnexo7c_chkruido boolean,
polvoAnexo7c_chkpolvo boolean,
cancerigenosAnexo7c_chkcancerigenos boolean,
metalesAnexo7c_chkmetales boolean,
vibracionesAnexo7c_vibraciones boolean,
temperaturaAnexo7c_chktemperatura boolean,
biologicosAnexo7c_chkbiologicos boolean,
posturasAnexo7c_chkposturas boolean,
cargasAnexo7c_chkcargas boolean,
otrosAnexo7c_chkotros boolean,
alturaEstructuraAnexo7c_altura_estructura boolean,
alturaGeograficaAnexo7c_altura_geog boolean,
quimicosAnexo7c_quimicos boolean,
electricosAnexo7c_electricos boolean,
cocainaLaboratorioClinico_txtcocaina text,
marihuanaLaboratorioClinico_txtmarihuana text,
direccionsede text,
sede text,
nombresede text,
namejasper text

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
	    obtener_name_jasper(p_norden, name_service)
	FROM datos_paciente dp
	INNER JOIN n_orden_ocupacional n ON dp.cod_pa = n.cod_pa
	INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
	LEFT JOIN antecedentes_patologicos ap ON n.n_orden = ap.n_orden
	LEFT JOIN anexo7c AS a7 ON a7.n_orden = ap.n_orden
	LEFT JOIN lab_clinico l ON n.n_orden = l.n_orden
	LEFT JOIN oftalmologia AS o ON (n.n_orden = o.n_orden)
	LEFT JOIN oftalmologia_lo AS ol ON (n.n_orden = ol.n_orden)
	LEFT JOIN oftalmologia2021 AS oft ON (n.n_orden = oft.n_orden)
	WHERE n.n_orden = 148033;

END;
$BODY$
  LANGUAGE plpgsql;

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