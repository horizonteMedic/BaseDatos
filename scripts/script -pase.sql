create function obtener_existencias_examenes(norden integer)
    returns TABLE(existe boolean, nameservice text, nombre text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT EXISTS(SELECT 1 FROM certificado_aptitud_medico_ocupacional WHERE n_orden = nOrden),
               'certificado_aptitud_medico_ocupacional',
               'fichaAnexo16'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM anexo7c WHERE n_orden = nOrden and cerrado = TRUE), 'anexo7c', 'anexo16'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM antece_enfermedades_altura WHERE n_orden = nOrden),
               'antece_enfermedades_altura',
               'antecedentesEfermedadesAltura'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM anexo16a WHERE n_orden = nOrden),
               'anexo16a',
               'anexo16A'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM b_uso_respiradores WHERE n_orden = nOrden),
               'b_uso_respiradores',
               'usoRespiradores'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM historia_oc_info WHERE n_orden = nOrden),
               'historia_oc_info',
               'historiaOcupacional'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM antecedentes_patologicos WHERE n_orden = nOrden),
               'antecedentes_patologicos',
               'antecedentesPatologicos'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM cuestionario_nordico WHERE n_orden = nOrden),
               'cuestionario_nordico',
               'cuestionarioNordico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM evaluacion_musculo_esqueletica WHERE n_orden = nOrden),
               'evaluacion_musculo_esqueletica',
               'evaluacionMusculoEsqueletica'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM lab_clinico WHERE n_orden = nOrden),
               'lab_clinico',
               'hematologia'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM lab_clinico
                      WHERE n_orden = nOrden
                        AND esorina IS NOT NULL
                        AND esorina = TRUE),
               'lab_clinico_examen_orina',
               'examenOrina'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM lab_clinico
                      WHERE n_orden = nOrden
                        AND eshemoblobina IS NOT NULL
                        AND eshemoblobina = TRUE),
               'lab_clinico_hemoglobina',
               'hemoglobina'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM analisis_bioquimicos WHERE n_orden = nOrden),
               'analisis_bioquimicos',
               'perfilLipidico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM analisis_bioquimicos WHERE n_orden = nOrden AND esglucosabasal = TRUE),
               'analisis_bioquimicos_glucosa_basal',
               'glucosaBasal'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM radiografia_torax WHERE n_orden = nOrden),
               'radiografia_torax',
               'radiografiaTorax'


        UNION ALL
        SELECT EXISTS(SELECT 1 FROM audiometria_po WHERE n_orden = nOrden),
               'audiometria_po',
               'audiometriaPo'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ficha_audiologica WHERE n_orden = nOrden),
               'ficha_audiologica',
               'fichaAudiologica'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_psicologico WHERE n_orden = nOrden),
               'informe_psicologico',
               'informePsicologico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM oftalmologia WHERE n_orden = nOrden),
               'oftalmologia',
               'oftalmologia'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consentimientoInformado WHERE n_orden = nOrden),
               'consentimientoInformado',
               'consentimientoInformado'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM triaje WHERE n_orden = nOrden),
               'triaje',
               'triaje'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_electrocardiograma WHERE n_orden = nOrden),
               'informe_electrocardiograma',
               'ekg'

        --         UNION ALL
--         SELECT EXISTS(SELECT 1 FROM informe_electrocardiograma WHERE n_orden = nOrden AND informe_completo = TRUE),
--                'informe_electrocardiograma',
--                'ekgCompleto'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM funcion_abs WHERE n_orden = nOrden),
               'funcion_abs',
               'espirometria'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM odontograma WHERE n_orden = nOrden),
               'odontograma',
               'odontograma'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM certificacion_medica_altura WHERE n_orden = nOrden),
               'certificacion_medica_altura',
               'altura1.8'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ficha_sas WHERE n_orden = nOrden),
               'ficha_sas',
               'fichaSas'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consentimiento_dosaje WHERE n_orden = nOrden),
               'consentimiento_dosaje',
               'consentimientoDosaje'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM perimetro_toracico WHERE n_orden = nOrden),
               'perimetro_toracico',
               'perimetroToracico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ex_radiograficos_sanguineos WHERE n_orden = nOrden),
               'ex_radiograficos_sanguineos',
               'examenRadiograficoSanguineo'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM b_certificado_altura WHERE n_orden = nOrden),
               'b_certificado_altura',
               'fichaCertificadoAltura'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM b_certificado_conduccion WHERE n_orden = nOrden),
               'b_certificado_conduccion',
               'fichaConduccionVehiculos'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM oit WHERE n_orden = nOrden),
               'oit',
               'oit'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM cuestionario_audiometria WHERE n_orden = nOrden),
               'cuestionario_audiometria',
               'CuestionarioAudiometria'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_audiometria WHERE n_orden = nOrden),
               'informe_audiometria',
               'informeAudiometria'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_laboratorios WHERE n_orden = nOrden AND name_conset = 'consent_marihuana'),
               'consent_marihuana',
               'consentimientoMarihuana'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_laboratorios WHERE n_orden = nOrden AND name_conset = 'con_panel2D'),
               'con_panel2D',
               'consentimientoPanel2D'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_laboratorios WHERE n_orden = nOrden AND name_conset = 'con_panel10D'),
               'con_panel10D',
               'consentimientoPanel10D'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM aptitud_medico_ocupacional_agro WHERE n_orden = nOrden),
               'aptitud_medico_ocupacional_agro',
               'fichaAnexo2'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM anexo_agroindustrial WHERE n_orden = nOrden and cerrado = TRUE),
               'anexo_agroindustrial',
               'anexo2'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM hoja_consulta_externa WHERE n_orden = nOrden),
               'hoja_consulta_externa',
               'hojaConsultaExterna'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM aptitud_licencia_conduciri WHERE n_orden = nOrden),
               'aptitud_licencia_conduciri',
               'licenciaConducirInternaPoderosa'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND UPPER(tipo_reporte) = 'ADM'),
               'ADM',
               'admision'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND UPPER(tipo_reporte) = 'CONSENT_SINTOMATICO'),
               'CONSENT_SINTOMATICO',
               'consentimientoSintomatico'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND UPPER(tipo_reporte) = 'CONSENT_INFORMADO_MEDICA'),
               'CONSENT_INFORMADO_MEDICA',
               'consentimientoInformadoMedica'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND UPPER(tipo_reporte) = 'CONSENT_RECOM_MEDIC'),
               'CONSENT_RECOM_MEDIC',
               'consentimientoRecomendacionesMedicas'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND UPPER(tipo_reporte) = 'DECLA_INFO_APTITUD_MO'),
               'DECLA_INFO_APTITUD_MO',
               'declaracionInformacionAptitudMedicoOcup'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND UPPER(tipo_reporte) = 'DECLA_JURA_ANTECE_PERSON_FAM'),
               'DECLA_JURA_ANTECE_PERSON_FAM',
               'declaracionJuradaAntecedentesPatologicos'


        UNION ALL
        SELECT EXISTS(SELECT 1 FROM evaluacion_musculo_esqueletica2021 WHERE n_orden = nOrden),
               'evaluacion_musculo_esqueletica2021',
               'evaluacionMusculoEsqueleticaBooro'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consent_laboratorios
                      WHERE n_orden = nOrden
                        AND name_conset = 'consent_Muestra_Sangre'),
               'consent_Muestra_Sangre',
               'consentimientoMuestraSangre'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM test_fatiga_somnolencia WHERE n_orden = nOrden),
               'test_fatiga_somnolencia',
               'testFatiga'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM lgonadotropina WHERE n_orden = nOrden),
               'lgonadotropina',
               'inmunologiaGenodotropina'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM certificado_manipuladores_barrick WHERE n_orden = nOrden),
               'certificado_manipuladores_barrick',
               'certificadoManipuladoresAlimentos'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM certificado_aptitud_medico_ocupacional WHERE n_orden = nOrden),
               'resumen_medico_poderosa',
               'resumenMedico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM certificado_aptitud_medico_resumen WHERE n_orden = nOrden),
               'certificado_aptitud_medico_resumen',
               'constanciaCertificadoMedicoOcupacional'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM aptitud_altura_poderosa WHERE n_orden = nOrden),
               'aptitud_altura_poderosa',
               'aptitudAlturaPoderosa'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_boro WHERE n_orden = nOrden),
               'consent_Boro',
               'consentimientoDrogasBoro'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM radiografia WHERE n_orden = nOrden),
               'radiografia',
               'informeRadiografico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM audiometria_2023 WHERE n_orden = nOrden),
               'audiometria_2023',
               'fichaAudiometria'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM cuestionario_audiometria WHERE n_orden = nOrden),
               'cuestionario_audiometria',
               'cuestionarioAudiometria'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ficha_psicologica_anexo03 WHERE n_orden = nOrden),
               'ficha_psicologica_anexo03',
               'psicologiaAnexo03'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_psicologico_estres WHERE n_orden = nOrden),
               'informe_psicologico_estres',
               'testFatigaSomnolencia'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM evaluacion_psicologica_poderosa
                      WHERE n_orden = nOrden
                        AND (chktrabcalientes IS DISTINCT FROM true
                          AND chklicencia IS DISTINCT FROM true)),
               'evaluacion_psicologica_poderosa_normal',
               'informePsicologicoPoderosaNormal'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM evaluacion_psicologica_poderosa
                      WHERE n_orden = nOrden
                        AND chklicencia = true),
               'evaluacion_psicologica_poderosa_licencia',
               'informePsicologicoPoderosaLicencia'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM evaluacion_psicologica_poderosa
                      WHERE n_orden = nOrden
                        AND chktrabcalientes = true),
               'evaluacion_psicologica_poderosa_caliente',
               'informePsicologicoPoderosaCaliente'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ficha_psicologica_anexo02 WHERE n_orden = nOrden),
               'ficha_psicologica_anexo02',
               'psicologiaAnexo02'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM fobias WHERE n_orden = nOrden),
               'fobias',
               'informePsicologiaFobias'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_psicolaboral WHERE n_orden = nOrden),
               'informe_psicolaboral',
               'informePsicolaboral'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM Especificos WHERE n_orden = nOrden),
               'especificos',
               'trabajoEspecifico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM psicologiafobias WHERE n_orden = nOrden),
               'psicologiafobias',
               'trabajoAltura'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM oftalmologia2021 WHERE n_orden = nOrden),
               'oftalmologia2021',
               'oftalmologia2021'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND tipo_reporte = 'CONSENT_SINTOMATICO'),
               'CONSENT_SINTOMATICO',
               'declaracionSintomaticoRespiratorio'

        UNION ALL
        SELECT EXISTS(SELECT 1
                      FROM consentimientos_admision
                      WHERE n_orden = nOrden
                        AND tipo_reporte = 'CONSENT_INFORMADO_MEDICA'),
               'CONSENT_INFORMADO_MEDICA',
               'consentimientoEvaluacionMedica'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consentimientobuenasalud WHERE n_orden = nOrden),
               'consentimientobuenasalud',
               'consentimientoBuenaSalud'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consentimientoInformado WHERE n_orden = nOrden),
               'consentimientoInformado',
               'consentimientoAutorizarMedicoOcupacional'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consen_digit WHERE n_orden = nOrden),
               'consen_digit',
               'declaracionFirma'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM l_bioquimica WHERE n_orden = nOrden),
               'l_bioquimica',
               'perfilRenal'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM perfil_hepatico WHERE n_orden = nOrden),
               'perfil_hepatico',
               'perfilHepatico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM cuestionario_berlin WHERE n_orden = nOrden),
               'cuestionario_berlin',
               'cuestionarioBerlin'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM toxicologia WHERE n_orden = nOrden),
               'toxicologia',
               'toxicologia'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM exam_complementarios WHERE n_orden = nOrden),
               'exam_complementarios',
               'examenComplementario'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM psicologia_espacios_confinados WHERE n_orden = nOrden),
               'psicologia_espacios_confinados',
               'psicologiaEspaciosConfinados'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM certificado_altura_poderosa WHERE n_orden = nOrden),
               'certificado_altura_poderosa',
               'certificadoAlturaPoderosa'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM calidad_sueño WHERE n_orden = nOrden),
               'calidad_sueño',
               'calidadSueno'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM hemograma_autom WHERE n_orden = nOrden),
               'hemograma_autom',
               'hemogramaAutomatizado'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ac_bioquimica2022 WHERE n_orden = nOrden),
               'ac_bioquimica2022',
               'acidoUrico'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_laboratorios WHERE n_orden = nOrden AND name_conset = 'con_panel5D'),
               'con_panel5D',
               'consentimientoPanel5D'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM microbiologia WHERE n_orden = nOrden),
               'microbiologia',
               'microbiologia'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM koh WHERE n_orden = nOrden),
               'koh',
               'koh'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM inmunologia WHERE n_orden = nOrden),
               'inmunologia',
               'inmunologia'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM lhepatitis WHERE n_orden = nOrden),
               'lhepatitis',
               'lhepatitis'
        UNION ALL
        SELECT EXISTS (SELECT 1
                       FROM hepatitis_b
                       WHERE n_orden = nOrden)
                   OR
               EXISTS (SELECT 1
                       FROM lhepatitis
                       WHERE n_orden = nOrden
                         AND NULLIF(TRIM(txthepatitisb), '') IS NOT NULL),
               'hepatitis_b',
               'hepatitisB'
        UNION ALL
        SELECT EXISTS (SELECT 1
                       FROM hepatitis_c
                       WHERE n_orden = nOrden)
                   OR
               EXISTS (SELECT 1
                       FROM lhepatitis
                       WHERE n_orden = nOrden
                         AND NULLIF(TRIM(hepatitisc), '') IS NOT NULL),
               'hepatitis_c',
               'hepatitisC'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM inmunologia_vdrl WHERE n_orden = nOrden),
               'inmunologia_vdrl',
               'InmunologiaVdrl'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM panel2d WHERE n_orden = nOrden),
               'panel2d',
               'Panel2D'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM panel3d WHERE n_orden = nOrden),
               'panel3d',
               'Panel3D'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM panel4d WHERE n_orden = nOrden),
               'panel4d',
               'Panel4D'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM panel10d WHERE n_orden = nOrden),
               'panel10d',
               'Panel10D'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ac_coprocultivo WHERE n_orden = nOrden),
               'ac_coprocultivo',
               'Coprocultivo'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ac_coproparasitologico WHERE n_orden = nOrden),
               'ac_coproparasitologico',
               'Parasitologia'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM examen_inmunologico WHERE n_orden = nOrden),
               'examen_inmunologico',
               'ExamenInmunologico'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_laboratorios WHERE n_orden = nOrden AND name_conset = 'con_panel3D'),
               'con_panel3D',
               'consentimientoPanel3D'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_laboratorios WHERE n_orden = nOrden AND name_conset = 'con_panel4D'),
               'con_panel4D',
               'consentimientoPanel4D'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_laboratorios WHERE n_orden = nOrden AND name_conset = 'consent_marihuana'),
               'consent_marihuana',
               'consentimientoMarihuana'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consent_boro WHERE n_orden = nOrden),
               'consent_boro',
               'consentimientoBoro'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_riesgos_psicosociales WHERE n_orden = nOrden),
               'informe_riesgos_psicosociales',
               'InformeRiesgosPsicosociales'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_burnout WHERE n_orden = nOrden),
               'informe_burnout',
               'InformeBurnout'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM informe_psicologico_estres WHERE n_orden = nOrden),
               'informe_psicologico_estres',
               'InformePsicologicoEstres'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM trastornos_personalidad WHERE n_orden = nOrden),
               'trastornos_personalidad',
               'TrastornosDePersonalidad'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM alto_riesgo WHERE n_orden = nOrden),
               'alto_riesgo',
               'AltoRiesgo'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM psi_brigadistas WHERE n_orden = nOrden),
               'psi_brigadistas',
               'InformePsicologicoBrigadistas'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM bombaelectrica WHERE n_orden = nOrden),
               'bombaelectrica',
               'BombaElectrica'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM cuadradorvigia WHERE n_orden = nOrden),
               'cuadradorvigia',
               'CuadradorVigia'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM aversionalriesgo WHERE n_orden = nOrden),
               'aversionalriesgo',
               'AversionAlRiesgo'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM vih WHERE n_orden = nOrden),
               'vih',
               'vih'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM glucosatolerancia WHERE n_orden = nOrden),
               'glucosatolerancia',
               'glucosaTolerancia'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM riesgocoronario WHERE n_orden = nOrden),
               'riesgocoronario',
               'riesgoCoronario'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM thevenon WHERE n_orden = nOrden),
               'thevenon',
               'thevenon'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM infor_conductores WHERE n_orden = nOrden),
               'infor_conductores',
               'informeConductores'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM certificado_aptitud_herramientas_manuales WHERE n_orden = nOrden),
               'certificado_aptitud_herramientas_manuales',
               'CertificadoAptitudHerramientasManuales'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM etanol_saliva WHERE n_orden = nOrden),
               'etanol_saliva',
               'EtanolEnSaliva'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM pcr_ultrasensible WHERE n_orden = nOrden),
               'pcr_ultrasensible',
               'PcrUltrasensible'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM certificado_aptitud_brigadista WHERE n_orden = nOrden),
               'certificado_aptitud_brigadista',
               'CertificadoAptitudBrigadista'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM ministerio_energia_minas WHERE n_orden = nOrden),
               'ministerio_energia_minas',
               'MinisterioEnergiaMinas'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM hoja_ruta_emo WHERE n_orden = nOrden),
               'hoja_ruta_emo',
               'HojaRutaEmo'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM hoja_ruta_emo WHERE n_orden = nOrden),
               'ficha_datos_paciente',
               'FichaDatosPaciente'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM examen_inmunologico WHERE n_orden = nOrden),
               'examen_inmunologico',
               'ExamenInmunologico'

        UNION ALL
        SELECT EXISTS(SELECT 1 FROM consta_brigadista WHERE n_orden = nOrden),
               'consta_brigadista',
               'ConstaBrigadista'
        UNION ALL
        SELECT EXISTS(SELECT 1 FROM registro_conformidad_emo WHERE n_orden = nOrden),
               'conformidad_emo',
               'RegistroConformidadEmo';
END;
$$;

alter function obtener_existencias_examenes(integer) owner to pierola;



alter table certificacion_medica_altura add column doctor_asignado text

--cambiar en config_general_service_digital y agregar el doctor_asignado


alter table b_certificado_conduccion add column doctor_asignado text

--cambiar en config_general_service_digital y agregar el doctor_asignado


alter table b_certificado_altura add column doctor_asignado text

--cambiar en config_general_service_digital y agregar el doctor_asignado


------------------------------------------------------------------------------------------------------

alter table plantilla_correo add column adicional boolean default false;
alter table plantilla_correo add column anulado boolean default false;

alter table archivo_plantilla add column anulado boolean default false;

alter table empresa_contrata add column anulado boolean default false;

alter table email_log add column anulado boolean default false;

alter table email_log add column n_orden integer;

create function obtener_tipos_archivo_plantilla_correo()
    returns TABLE(id_tipo_archivo bigint, nombre_tipo_archivo character varying, nomenclatura character varying)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT ta.id_tipo_archivo, ta.nombre_tipo_archivo, ta.nomenclatura FROM tipo_archivo ta
        WHERE ta.nomenclatura
                  IN ('CAMO ADM', 'INFORME RADIOGRAFICO', 'INFORME RADIOGRAFICO 2',
                      'EMPO', 'RAYOS X TORAX', 'CAMO',
                      'EMOA', 'EMOR', 'TEST ALTURA', 'PSICOSENSOMETRICO',
                      'MANIPULADOR ALIMENTOS', 'ANEXO 16A', 'INFORME EMO',
                      'RX TORAX', 'RX CL', 'RX CL2', 'MTR');

END;
$$;

create table empresa_contrata
(
    id               serial primary key,
    ruc_empresa      text not null,
    ruc_contrata     text,
    usuario_registro text,
    fecha_registro   timestamp
);

drop table plantilla_correo;

create table plantilla_correo
(
    id                  serial primary key,
    id_empresa_contrata integer,
    destino             text,
    con_copia           text,
    asunto              text,
    mensaje             text,
    usuario_registro    text,
    fecha_registro      timestamp,
    CONSTRAINT fk_empresa_contrata
        FOREIGN KEY (id_empresa_contrata)
            REFERENCES empresa_contrata (id)
);

create table archivo_plantilla
(
    id                  serial primary key,
    id_tipo_archivo     integer,
    id_plantilla_correo integer,
    usuario_registro    text,
    fecha_registro      timestamp,
    CONSTRAINT fk_tipo_archivo
        FOREIGN KEY (id_tipo_archivo)
            REFERENCES tipo_archivo (id_tipo_archivo),
    CONSTRAINT fk_plantilla_correo
        FOREIGN KEY (id_plantilla_correo)
            REFERENCES plantilla_correo (id)
);


CREATE INDEX IF NOT EXISTS idx_pc_id_empresa_contrata ON plantilla_correo(id_empresa_contrata);
CREATE INDEX IF NOT EXISTS idx_ap_id_plantilla_correo ON archivo_plantilla(id_plantilla_correo);
CREATE INDEX IF NOT EXISTS idx_ec_ruc_empresa ON empresa_contrata(ruc_empresa);
CREATE INDEX IF NOT EXISTS idx_ec_ruc_contrata ON empresa_contrata(ruc_contrata);

create function obtener_plantilla_correo(id_empresa_contrata_var integer)
    returns TABLE(idplantillacorreo integer, idempresacontrata integer, destino text, concopia text, asunto text, mensaje text, anulado boolean, rucempresa character varying, razonempresa character varying, ruccontrata character varying, razoncontrata character varying, archivos json, adicional boolean)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT pc.id,
               ec.id,
               pc.destino,
               pc.con_copia,
               pc.asunto,
               pc.mensaje,
               pc.anulado,
               e.ruc_empresa,
               e.razon_empresa,
               c.ruc_contrata,
               c.razon_contrata,
               COALESCE(a.archivos, '[]'::JSON),
               pc.adicional
        FROM plantilla_correo pc
                 INNER JOIN empresa_contrata ec ON pc.id_empresa_contrata = ec.id and ec.anulado = false
                 INNER JOIN empresas e ON ec.ruc_empresa = e.ruc_empresa
                 LEFT JOIN contratas c ON ec.ruc_contrata = c.ruc_contrata
                 LEFT JOIN LATERAL (
            SELECT json_agg(
                           json_build_object(
                                   'idArchivoPlantilla', ap.id,
                                   'idTipoArchivo', ta.id_tipo_archivo,
                                   'extension', ta.extension,
                                   'nombreTipoArchivo', ta.nombre_tipo_archivo,
                                   'nomenclatura', ta.nomenclatura,
                                   'anulado', ap.anulado
                           )
                   ) AS archivos
            FROM archivo_plantilla ap
                     INNER JOIN tipo_archivo ta
                                ON ap.id_tipo_archivo = ta.id_tipo_archivo
            WHERE ap.id_plantilla_correo = pc.id
              and ap.anulado = false
            ) a ON TRUE
        where ec.id = id_empresa_contrata_var
          and pc.anulado = false;

END;
$$;






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

create table prospecto(
    id SERIAL PRIMARY KEY,
    estado TEXT,
    numero_documento bigint,
    nombre varchar(50),
    apellido varchar(50),
    telefono TEXT,
    correo TEXT,
    empresa TEXT,
    fecha_registro date,
    direccion TEXT,
    sexo TEXT,
    tipo_documento varchar(30),
    ubigeo varchar(6),
    usuario_actualizacion text,
    fecha_actualizacion date
);

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