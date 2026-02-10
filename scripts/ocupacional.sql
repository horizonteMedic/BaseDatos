alter table analisis_bioquimicos add column esGlucosaBasal boolean

create function laboratorio_obtener_analisis_bioquimico_detalle(norden_param bigint, name_service_param text)
    returns TABLE(nombres_retorn text, fecha_retorn date, n_orden_retorn integer, sede_retorn text, cod_ab_retorn integer, txtcreatinina_retorn text, txtcolesterol_retorn text, txtldlcolesterol_retorn text, txthdlcolesterol_retorn text, txtvldlcolesterol_retorn text, txttrigliseridos_retorn text, txtreponsable_retorn text, dir_tru_pierola text, email_tru_pierola text, telf_tru_pierola text, cel_trujillo_pie text, dir_huancayo text, email_huancayo text, telf_huancayo text, dir_huamachuco text, email_huamachuco text, telf_huamachuco text, cel_huamachuco text, dir_trujillo text, email_trujillo text, telf_trujillo text, color integer, dni_paciente integer, sexopaciente "char", fechanacimientopaciente date, ocupacionpaciente text, lugarnacimientopaciente text, nivelestudiopaciente text, estadocivilpaciente text, cargopaciente text, areapaciente text, nombreexamen text, codigoclinica text, edadpaciente text, empresa text, contrata text, gluc_basal_retorn text, fecha_registro date, usuario_firma text, user_medico_ocup text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT d.nombres_pa || ' ' || d.apellidos_pa,
               ab.fecha_ab, -- Este campo ab.fecha_ab es el que mapeas como 'fecha' en el índice 1
               ab.n_orden,
               CASE
                   WHEN UPPER(TRIM(n.razon_empresa)) = 'CIA MINERA PODEROSA S A' THEN 'Huamachuco'
                   else (CAST(sm.descripcion AS TEXT)) end,
               ab.cod_ab,
               ab.txtcreatinina,
               ab.txtcolesterol,
               ab.txtldlcolesterol,
               ab.txthdlcolesterol,
               ab.txtVldlColesterol,
               ab.txtTrigliseridos,
               ab.txtReponsable,
               -- Sedes
               (SELECT direccion FROM sede WHERE cod_sede = 4)::text,
               (SELECT email FROM sede WHERE cod_sede = 4)::text,
               (SELECT telefono FROM sede WHERE cod_sede = 4)::text,
               (SELECT celular FROM sede WHERE cod_sede = 4)::text,
               (SELECT direccion FROM sede WHERE cod_sede = 3)::text,
               (SELECT email FROM sede WHERE cod_sede = 3)::text,
               (SELECT telefono FROM sede WHERE cod_sede = 3)::text,
               (SELECT direccion FROM sede WHERE cod_sede = 2)::text,
               (SELECT email FROM sede WHERE cod_sede = 2)::text,
               (SELECT telefono FROM sede WHERE cod_sede = 2)::text,
               (SELECT celular FROM sede WHERE cod_sede = 2)::text,
               (SELECT direccion FROM sede WHERE cod_sede = 1)::text,
               (SELECT email FROM sede WHERE cod_sede = 1)::text,
               (SELECT telefono FROM sede WHERE cod_sede = 1)::text,
               -- Datos adicionales
               n.color,
               d.cod_pa,
               d.sexo_pa,
               d.fecha_nacimiento_pa,
               d.ocupacion_pa::text,
               d.lugar_nac_pa::text,
               d.nivel_est_pa::text,
               d.estado_civil_pa::text,
               n.cargo_de::text,
               n.area_o::text,
               n.nom_examen::text,
               n.cod_clinica::text,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               n.razon_empresa::text,
               n.razon_contrata::text,
               ab.gluc_basal,
               ab.fecha_ab,
               ab.usuario_firma,
               ab.user_medico_ocup,
               ab.doctor_asignado
        FROM analisis_bioquimicos AS ab
                 INNER JOIN n_orden_ocupacional AS n ON n.n_orden = ab.n_orden
                 INNER JOIN datos_paciente AS d ON n.cod_pa = d.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
        WHERE ab.n_orden = norden_param
          AND (
            name_service_param <> 'analisis_bioquimicos_glucosa_basal'
                OR ab.esglucosabasal = TRUE
            )
    ;
END;
$$;

alter function laboratorio_obtener_analisis_bioquimico_detalle(bigint, text) owner to pierola;




alter table lab_clinico add column esOrina boolean;

create function obtener_reporte_hemoglobina(p_norden integer, name_service text)
    returns TABLE(cod_labclinico integer, tipo_servicio text, n_orden integer, fecha_lab date, nom_examen text, nombres_pa text, apellidos_pa text, dni_pa integer, edad_pa text, sexo_pa text, fecha_nacimiento_pa date, lugar_nac_pa text, estado_civil_pa text, nivel_est_pa text, direccion_pa text, empresa text, contrata text, ocupacion_pa text, cargo_de text, area_o text, fecha_apertura_po date, chko boolean, chka boolean, chkb boolean, chkab boolean, rbrhpositivo boolean, rbrhnegativo boolean, txthemoglobina text, txthematocrito text, usuario_firma text, fecha_registro date, nombre_sede text, sede text, color integer, namejasper text, doctorasignado text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT l.cod_labclinico,
               CAST(l.tipo_servicio AS TEXT),
               n.n_orden,
               l.fecha_lab,
               n.nom_examen,
               CAST(d.nombres_pa AS TEXT),
               CAST(d.apellidos_pa AS TEXT),
               d.cod_pa,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               CAST(d.sexo_pa AS TEXT),
               d.fecha_nacimiento_pa,
               CAST(d.lugar_nac_pa AS TEXT),
               CAST(d.estado_civil_pa AS TEXT),
               CAST(d.nivel_est_pa AS TEXT),
               CAST(d.direccion_pa AS TEXT),
               CAST(n.razon_empresa AS TEXT),
               CAST(n.razon_contrata AS TEXT),
               CAST(d.ocupacion_pa AS TEXT),
               CAST(n.cargo_de AS TEXT),
               CAST(n.area_o AS TEXT),
               n.fecha_apertura_po,
               l.chko,
               l.chka,
               l.chkb,
               l.chkab,
               l.rbrhpositivo,
               l.rbrhnegativo,
               l.txthemoglobina,
               l.txthematocrito,
               l.usuario_firma,
               CAST(l.fecha_lab AS DATE),
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1),
               CAST(sm.descripcion AS TEXT),
               n.color,
               'Informe_Lab_hemoglobina'::text,
               l.doctor_asignado
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN lab_clinico l ON l.n_orden = n.n_orden
        WHERE n.n_orden = p_norden AND l.eshemoblobina = TRUE;
END;
$$;

alter function obtener_reporte_hemoglobina(integer, text) owner to pierola;

create function obtener_reporte_examen_orina(p_norden integer, name_service text)
    returns TABLE(cod_labclinico integer, tipo_servicio text, nombre_examen text, n_orden integer, fecha_lab date, nombres_pa text, apellidos_pa text, dni_pa integer, edad_pa text, sexo_pa text, fecha_nacimiento_pa date, lugar_nac_pa text, estado_civil_pa text, nivel_est_pa text, direccion_pa text, empresa text, contrata text, ocupacion_pa text, cargo_de text, area_o text, fecha_apertura_po date, txtcoloref text, txtaspectoef text, txtdensidadef text, txtphef text, txtnitritoseq text, txtcetonaseq text, txtac_ascorbico text, txtbilirubinaeq text, txtsangreeq text, txtproteinaseq text, txtleucocitoseq text, txturobilinogenoeq text, txtglucosaeq text, txtleucocitossu text, txtcelepitelialessu text, txtcilindiossu text, txthematiessu text, txtcristalessu text, txtpussu text, txtbacteriassu text, txtotrossu text, txtcocaina text, txtmarihuana text, txtobservacioneslb text, usuario_firma text, especialista_certifica text, fecha_registro date, nombre_sede text, sede text, color integer, namejasper text, doctorasignado text, almidon text, levadura text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT l.cod_labclinico,
               CAST(l.tipo_servicio AS TEXT),
               n.nom_examen,
               n.n_orden,
               l.fecha_lab,
               CAST(d.nombres_pa AS TEXT),
               CAST(d.apellidos_pa AS TEXT),
               d.cod_pa,
               CAST(obtener_edad(d.fecha_nacimiento_pa, current_date) AS TEXT),
               CAST(d.sexo_pa AS TEXT),
               d.fecha_nacimiento_pa,
               CAST(d.lugar_nac_pa AS TEXT),
               CAST(d.estado_civil_pa AS TEXT),
               CAST(d.nivel_est_pa AS TEXT),
               CAST(d.direccion_pa AS TEXT),
               CAST(n.razon_empresa AS TEXT),
               CAST(n.razon_contrata AS TEXT),
               CAST(d.ocupacion_pa AS TEXT),
               CAST(n.cargo_de AS TEXT),
               CAST(n.area_o AS TEXT),
               n.fecha_apertura_po,
               l.txtcoloref,
               l.txtaspectoef,
               l.txtdensidadef,
               l.txtphef,
               l.txtnitritoseq,
               l.txtcetonaseq,
               l.txtac_ascorbico,
               l.txtbilirubinaeq,
               l.txtsangreeq,
               l.txtproteinaseq,
               l.txtleucocitoseq,
               l.txturobilinogenoeq,
               l.txtglucosaeq,
               l.txtleucocitossu,
               l.txtcelepitelialessu,
               l.txtcilindiossu,
               l.txthematiessu,
               l.txtcristalessu,
               l.txtpussu,
               l.txtbacteriassu,
               l.txtotrossu,
               l.txtcocaina,
               l.txtmarihuana,
               l.txtobservacioneslb,
               l.usuario_firma,
               CAST(u.nombre_user || ' ' || u.apellido_user AS TEXT),
               CAST(l.fecha_lab AS DATE),
               (SELECT s.nombre_sede FROM sede s WHERE s.cod_sede = n.cod_sede LIMIT 1),
               CAST(sm.descripcion AS TEXT),
               n.color,
               'Informe_Lab_Eco'::text,
               l.doctor_asignado,
               l.almidon,
               l.levadura
        FROM datos_paciente d
                 INNER JOIN n_orden_ocupacional n ON d.cod_pa = n.cod_pa
                 INNER JOIN sede_multisucursal sm ON n.cod_sede = sm.id
                 INNER JOIN lab_clinico l ON l.n_orden = n.n_orden
                 LEFT JOIN usuarios u ON UPPER(TRIM(l.user_registro)) = UPPER(TRIM(u.usuario_user))
        WHERE n.n_orden = p_norden AND esorina = TRUE;
END;
$$;

alter function obtener_reporte_examen_orina(integer, text) owner to pierola;


