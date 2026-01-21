create function obtener_parametros_digitalizados(norden_param bigint, name_servicio_param text)
    returns TABLE
            (
                descripcion         text,
                name_digitalizacion text,
                dni                 integer
            )
    language plpgsql
as
$$
DECLARE
dni_paciente_var         INTEGER;
    dni_user_registro_var
INTEGER;
    dni_user_doctor_asig_var
INTEGER;
    dni_user_doc_adic_var
INTEGER;
    empresa_var
TEXT;
    user_registro_var
TEXT;
    sede_var
INTEGER;
    completo_electro_var
BOOLEAN;
BEGIN
    -- Obtener DNI del paciente
    IF
name_servicio_param = 'ficha_interconsulta' THEN
SELECT cod_pa
INTO dni_paciente_var
FROM n_orden_ocupacional n
         INNER JOIN ficha_interconsulta f ON n.n_orden = f.n_orden
WHERE f.cod_fichaint = norden_param;
ELSE
SELECT cod_pa
INTO dni_paciente_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param;
END IF;

    IF
name_servicio_param = 'ficha_interconsulta' THEN
SELECT trim(razon_empresa)
INTO empresa_var
FROM n_orden_ocupacional n
         INNER JOIN ficha_interconsulta f ON n.n_orden = f.n_orden
WHERE f.cod_fichaint = norden_param;
ELSE
SELECT trim(razon_empresa)
INTO empresa_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param;
END IF;

SELECT COALESCE(informe_completo, FALSE)
INTO completo_electro_var
FROM informe_electrocardiograma
WHERE n_orden = norden_param;

-- Primera condición
IF
name_servicio_param = 'con_panel10D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    -- Segunda condición
    IF
name_servicio_param = 'con_panel5D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
((SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) and
            empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'con_panel4D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
((SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) and
            empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    -- Tercera condicion
    IF
name_servicio_param = 'con_panel3D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    -- Cuarta condición
    IF
name_servicio_param = 'con_panel2D' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;
    -- Quinta condición

    IF
name_servicio_param = 'consent_Muestra_Sangre' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM consent_laboratorios
WHERE n_orden = norden_param
  AND name_conset = name_servicio_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    -- Sexta condición
    IF
name_servicio_param = 'consent_marihuana' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    -- Septima condición
    IF
name_servicio_param = 'consent_Boro' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM consent_Boro
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;


    IF
name_servicio_param = 'analisis_bioquimicos' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM analisis_bioquimicos
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN analisis_bioquimicos h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_ab BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
ELSIF
sede_var = 3 THEN
                IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
                    dni_user_registro_var = 88888888;
ELSE
                    dni_user_registro_var := 1;
END IF;
ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 42664426;
                ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                    dni_user_registro_var := 66666666;
ELSE
                    dni_user_registro_var := 1;
END IF;
END IF;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'lab_clinico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM lab_clinico
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN lab_clinico h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_lab BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
ELSIF
sede_var = 3 THEN
                IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
                    dni_user_registro_var = 88888888;
ELSE
                    dni_user_registro_var := 1;
END IF;
ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 42664426;
                ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                    dni_user_registro_var := 66666666;
ELSE
                    dni_user_registro_var := 1;
END IF;
END IF;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'hemograma_autom' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM hemograma_autom
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'lgonadotropina' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM lgonadotropina
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'panel2d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM panel2d
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'panel3d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM panel2d
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;

    IF
name_servicio_param = 'panel4d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM panel4d
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;

    IF
name_servicio_param = 'toxicologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM toxicologia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'panel10d' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM panel10d
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'inmunologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM inmunologia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'microbiologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM microbiologia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


    IF
name_servicio_param = 'lhepatitis' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM lhepatitis
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


-- perfil renal
    IF
name_servicio_param = 'l_bioquimica' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM l_bioquimica
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


-- acido urino
    IF
name_servicio_param = 'ac_bioquimica2022' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM ac_bioquimica2022
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


-- perfil hepatico
    IF
name_servicio_param = 'perfil_hepatico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM perfil_hepatico
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

END IF;


-- coprocultivo
    IF
name_servicio_param = 'ac_coprocultivo' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM ac_coprocultivo
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
END IF;

END IF;

-- coproparasitologico

    IF
name_servicio_param = 'ac_coproparasitologico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM ac_coproparasitologico
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

-- examen inmunologico

IF name_servicio_param = 'examen_inmunologico' THEN IF
  (SELECT firma_p
   FROM config_general_service_digital
   WHERE name_service = name_servicio_param) THEN descripcion := 'FIRMA DEL PACIENTE';

name_digitalizacion := 'FIRMAP';

dni := dni_paciente_var;

RETURN NEXT;

END IF;

IF
(SELECT huella_p
 FROM config_general_service_digital
 WHERE name_service = name_servicio_param) THEN descripcion := 'HUELLA DEL PACIENTE';

name_digitalizacion := 'HUELLA';

dni := dni_paciente_var;

RETURN NEXT;

END IF;

IF
(SELECT sello_prof_s
 FROM config_general_service_digital
 WHERE name_service = name_servicio_param) THEN
SELECT CASE
           WHEN usuario_firma IS NULL THEN user_registro
           ELSE usuario_firma
           END INTO user_registro_var
FROM examen_inmunologico
WHERE n_orden = norden_param;


SELECT dni_user INTO dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);

descripcion := 'SELLO DEL PROFESIONAL DE SALUD';

name_digitalizacion := 'SELLOFIRMA';

dni := dni_user_registro_var;

RETURN NEXT;

END IF;

IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT doctor_asignado
INTO user_registro_var
FROM examen_inmunologico
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
END IF;

END IF;



    IF
name_servicio_param = 'audiometria_2023' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM audiometria_2023
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                dni_user_registro_var := 42664426;
ELSE
                dni_user_registro_var := 1;
end if;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'historia_oc_info' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM historia_oc_info
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'audiometria_po' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM ficha_audiologica
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 74723311;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN ficha_audiologica h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_examen BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
ELSE
                IF EXISTS (
                    SELECT 1
                    FROM ficha_audiologica
                    WHERE n_orden = norden_param
                      AND doctor_asignado IS NOT NULL
                ) THEN
SELECT doctor_asignado
INTO user_registro_var
FROM ficha_audiologica
WHERE n_orden = norden_param;
SELECT dni_user
INTO dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);
ELSE
                    IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                        dni_user_registro_var := 42664426;
                    ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                        dni_user_registro_var := 66666666;
ELSE
                        dni_user_registro_var := 1;
END IF;
END IF;
END IF;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_adic
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            IF EXISTS (
                SELECT 1
                FROM ficha_audiologica
                WHERE n_orden = norden_param
                  AND doctor_extra IS NOT NULL
            ) THEN
SELECT doctor_extra
INTO user_registro_var
FROM ficha_audiologica
WHERE n_orden = norden_param;
SELECT dni_user
INTO dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);
ELSE
                IF (empresa_var = 'OBRASCÓN HUARTE LAIN S.A') THEN
                    dni_user_registro_var := 55555555;
ELSE
                    dni_user_registro_var := 1;
end if;
END IF;
            descripcion
:= 'SELLO DEL DOCTOR ADICIONAL';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG-EXTRA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'cuestionario_audiometria' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM cuestionario_audiometria
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'oftalmologia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM oftalmologia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            IF EXISTS (SELECT 1
                       FROM n_orden_ocupacional n
                                INNER JOIN oftalmologia h ON n.n_orden = h.n_orden
                       WHERE n.cod_sede = 5
                         AND h.fecha_of BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
                         AND h.n_orden = norden_param) THEN
                dni_user_registro_var := 72537588;
ELSIF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
ELSE
                dni_user_registro_var := 1;
END IF;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'oftalmologia_lo' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM oftalmologia_lo
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN

            IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
ELSE
                dni_user_registro_var := 1;
END IF;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'oftalmologia2021' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM oftalmologia2021
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            IF EXISTS (
                SELECT 1
                FROM oftalmologia2021
                WHERE n_orden = norden_param
                  AND doctor_asignado IS NOT NULL
            ) THEN
SELECT doctor_asignado
INTO user_registro_var
FROM oftalmologia2021
WHERE n_orden = norden_param;
SELECT dni_user
INTO dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);
ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 42664426;
                ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                    dni_user_registro_var := 66666666;
ELSE
                    dni_user_registro_var := 1;
END IF;
END IF;
            descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'odontograma' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM odontograma
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'odontograma_lo' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT o.user_registro
INTO user_registro_var
FROM odontograma_lo olo
         INNER JOIN odontograma o on olo.n_orden = o.n_orden
WHERE olo.n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'radiografia_torax' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM radiografia_torax
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'radiografia' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM radiografia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'oit' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM oit
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'evaluacion_musculo_esqueletica' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM evaluacion_musculo_esqueletica
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'evaluacion_musculo_esqueletica2021' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM evaluacion_musculo_esqueletica2021
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'consentimientoInformado' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'cuestionario_nordico' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM cuestionario_nordico
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'consentimiento_rayosx' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;


    IF
name_servicio_param = 'test_fatiga_somnolencia' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM test_fatiga_somnolencia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'informe_electrocardiograma' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM informe_electrocardiograma
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            IF
completo_electro_var = TRUE THEN
                dni := 70436528;
ELSE
                dni := dni_user_registro_var;
END IF;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'antece_enfermedades_altura' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM antece_enfermedades_altura
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT doctor_asignado
INTO user_registro_var
FROM antece_enfermedades_altura
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'anexo_agroindustrial' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM anexo_agroindustrial
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'consentimientobuenasalud' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'anexo7c' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM anexo7c
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'anexo16a' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM anexo16a
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'antecedentes_patologicos' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM antecedentes_patologicos
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'aptitud_medico_ocupacional_agro' THEN ---cambios por sede, por hacer
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            -- SELECT user_registro INTO user_registro_var
--             FROM aptitud_medico_ocupacional_agro WHERE n_orden = norden_param;
SELECT cod_sede
INTO sede_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param;
IF
sede_var = 3 THEN
                dni_user_registro_var = 88888888;
ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 88888888;
ELSE
                    dni_user_registro_var = 66666666;
END IF;
END IF;
            -- select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);

            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'certificado_aptitud_medico_ocupacional' THEN ---cambios por sede, por hacer
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            -- SELECT user_registro INTO user_registro_var
-- 	FROM certificado_aptitud_medico_ocupacional WHERE n_orden = norden_param;
-- 	select dni_user into dni_user_registro_var from usuarios where  UPPER(usuario_user)= UPPER(user_registro_var);
SELECT cod_sede
INTO sede_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param;
IF
sede_var = 3 THEN
                dni_user_registro_var = 88888888;
ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 88888888;
ELSE
                    dni_user_registro_var := 66666666;
END IF;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'ficha_sas' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM ficha_sas
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'certificado_aptitud_medico_resumen' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM certificado_aptitud_medico_resumen
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
SELECT cod_sede
INTO sede_var
FROM n_orden_ocupacional
WHERE n_orden = norden_param;
IF
sede_var = 3 THEN
                dni_user_registro_var = 88888888;
ELSE
                IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                    dni_user_registro_var := 88888888;
                ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                    dni_user_registro_var := 66666666;
END IF;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'b_certificado_conduccion' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM b_certificado_conduccion
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'ficha_interconsulta' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT dni_user
INTO dni_user_registro_var
FROM ficha_interconsulta
WHERE cod_fichaint = norden_param;
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'b_certificado_altura' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM b_certificado_altura
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'informe_psicologico' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM informe_psicologico
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'b_uso_respiradores' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM b_uso_respiradores
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'ficha_psicologica_anexo02' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM ficha_psicologica_anexo02
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'ficha_psicologica_anexo03' THEN

        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM ficha_psicologica_anexo03
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'certificado_altura_poderosa' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM certificado_altura_poderosa
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT doctor_asignado
INTO user_registro_var
FROM certificado_altura_poderosa
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
END IF;

END IF;

    IF
name_servicio_param = 'aptitud_altura_poderosa' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM aptitud_altura_poderosa
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT doctor_asignado
INTO user_registro_var
FROM aptitud_altura_poderosa
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion := 'SELLOFIRMADOCASIG';
            dni := dni_user_registro_var;
            RETURN NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'aptitud_trabajos_encaliente' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM aptitud_trabajos_encaliente
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'aptitud_licencia_conduciri' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM aptitud_licencia_conduciri
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'hoja_consulta_externa' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM hoja_consulta_externa
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'certificado_aptitud_herramientas_manuales' THEN

        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM certificado_aptitud_herramientas_manuales
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'resumen_medico_poderosa' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM anexo7c
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 88888888;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'informe_psicolaboral' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM informe_psicolaboral
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'certificado_manipuladores_barrick' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM certificado_manipuladores_barrick
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'informe_psicologico_estres' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM informe_psicologico_estres
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
            ELSIF
empresa_var = 'MONARCA GOLD S.A.C.' THEN
                dni_user_registro_var := 66666666;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'evaluacion_psicologica_poderosa' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM evaluacion_psicologica_poderosa
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'psicologia_espacios_confinados' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM psicologia_espacios_confinados
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'informe_riesgos_psicosociales' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM informe_riesgos_psicosociales
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'informe_burnout' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM informe_burnout
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'psicologiafobias' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT user_registro
INTO user_registro_var
FROM psicologiafobias
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
-- IF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'trastornos_personalidad' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM trastornos_personalidad
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'infor_conductores' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM infor_conductores
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'alto_riesgo' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM alto_riesgo
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'certificacion_medica_altura' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM certificacion_medica_altura
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
IF
empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
                dni_user_registro_var := 42664426;
END IF;
            descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;


    IF
name_servicio_param = 'especificos' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM especificos
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'cuestionario_berlin' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM cuestionario_berlin
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;


    IF
name_servicio_param = 'exam_complementarios' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM exam_complementarios
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'psi_brigadistas' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM psi_brigadistas
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'bombaelectrica' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM bombaelectrica
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'cuadradorvigia' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM cuadradorvigia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;


    IF
name_servicio_param = 'riesgocoronario' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM riesgocoronario
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'fobias' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM fobias
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'aversionalriesgo' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM aversionalriesgo
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
UPPER(name_servicio_param) = 'CONSENT_SINTOMATICO' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
UPPER(name_servicio_param) = 'CONSENT_INFORMADO_MEDICA' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
UPPER(name_servicio_param) = 'CONSENT_RECOM_MEDIC' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
UPPER(name_servicio_param) = 'DECLA_JURA_ANTECE_PERSON_FAM' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
UPPER(name_servicio_param) = 'DECLA_INFO_APTITUD_MO' THEN
        IF (SELECT firma_p
            FROM config_general_service_digital
            WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE UPPER(name_service) = UPPER(name_servicio_param)) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'glucosatolerancia' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM glucosatolerancia
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'inmunologia_vdrl' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM inmunologia_vdrl
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'vih' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM vih
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'thevenon' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM thevenon
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'calidad_sueño' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM calidad_sueño
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
      IF name_servicio_param = 'registro_conformidad_emo' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM registro_conformidad_emo
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion := 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion := 'SELLOFIRMA';
            dni := dni_user_registro_var;
            RETURN NEXT;
END IF;
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
    IF
name_servicio_param = 'consta_brigadista' THEN
        IF (SELECT sello_prof_s FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM consta_brigadista
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
-- IF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             END IF;
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;
    IF
name_servicio_param = 'funcion_abs' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM funcion_abs
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_asig
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT doctor_asignado
INTO user_registro_var
FROM funcion_abs
WHERE n_orden = norden_param;
SELECT dni_user
INTO dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_doc_adic
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT doctor_extra
INTO user_registro_var
FROM funcion_abs
WHERE n_orden = norden_param;
SELECT dni_user
INTO dni_user_registro_var
FROM usuarios
WHERE UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL DOCTOR ADICIONAL';
            name_digitalizacion
:= 'SELLOFIRMADOCASIG-EXTRA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;
END IF;

    IF
name_servicio_param = 'ficha_datos_paciente' THEN
        IF (SELECT firma_p FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
            descripcion := 'FIRMA DEL PACIENTE';
            name_digitalizacion
:= 'FIRMAP';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT huella_p
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
            descripcion := 'HUELLA DEL PACIENTE';
name_digitalizacion
:= 'HUELLA';
            dni
:= dni_paciente_var;
            RETURN
NEXT;
END IF;

        IF
(
SELECT sello_prof_s
FROM config_general_service_digital
WHERE name_service = name_servicio_param) THEN
SELECT CASE WHEN usuario_firma IS NULL THEN user_registro ELSE usuario_firma END
INTO user_registro_var
FROM ficha_datos_personales
WHERE n_orden = norden_param;
select dni_user
into dni_user_registro_var
from usuarios
where UPPER(usuario_user) = UPPER(user_registro_var);
descripcion
:= 'SELLO DEL PROFESIONAL DE SALUD';
            name_digitalizacion
:= 'SELLOFIRMA';
            dni
:= dni_user_registro_var;
            RETURN
NEXT;
END IF;

--         IF (SELECT sello_doc_asig FROM config_general_service_digital WHERE name_service = name_servicio_param) THEN
--             IF EXISTS (SELECT 1
--                        FROM n_orden_ocupacional n
--                                 INNER JOIN ficha_audiologica h ON n.n_orden = h.n_orden
--                        WHERE n.cod_sede = 5
--                          AND h.fecha_examen BETWEEN DATE '2025-12-05' AND DATE '2026-01-06'
--                          AND h.n_orden = norden_param) THEN
--                 dni_user_registro_var := 72537588;
--             ELSIF empresa_var = 'OBRASCÓN HUARTE LAIN S.A' THEN
--                 dni_user_registro_var := 42664426;
--             ELSIF empresa_var = 'MONARCA GOLD S.A.C.' THEN
--                 dni_user_registro_var := 66666666;
--             ELSE
--                 dni_user_registro_var := 1;
--             END IF;
--             descripcion := 'SELLO DEL MEDICO OCUPACIONAL ASIGNADO';
--             name_digitalizacion := 'SELLOFIRMADOCASIG';
--             dni := dni_user_registro_var;
--             RETURN NEXT;
--         END IF;
END IF;


END;
$$;

alter function obtener_parametros_digitalizados(bigint, text) owner to pierola;

