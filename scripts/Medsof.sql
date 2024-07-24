#Cambios Psicologia 
create table calidad_sueño(
     n_orden integer,
     criterio_1 text,
     criterio_2_1 boolean,
     criterio_2_2 boolean,
     criterio_2_3 boolean,
     criterio_2_4 boolean,
     criterio_3 text,
     criterio_4 text,
     criterio_5a1 boolean,
     criterio_5a2 boolean,
     criterio_5a3 boolean,
     criterio_5a4 boolean,
     criterio_5b_1 boolean,
     criterio_5b_2 boolean,
     criterio_5b_3 boolean,
     criterio_5b_4 boolean,
     criterio_5c_1 boolean,
     criterio_5c_2 boolean,
     criterio_5c_3 boolean,
     criterio_5c_4 boolean,
     criterio_5d_1 boolean,
     criterio_5d_2 boolean,
     criterio_5d_3 boolean,
     criterio_5d_4 boolean,
     criterio_5e_1 boolean,
     criterio_5e_2 boolean,
     criterio_5e_3 boolean,
     criterio_5e_4 boolean,
     criterio_5f_1 boolean,
     criterio_5f_2 boolean,
     criterio_5f_3 boolean,
     criterio_5f_4 boolean,
     criterio_5g_1 boolean,
     criterio_5g_2 boolean,
     criterio_5g_3 boolean,
     criterio_5g_4 boolean,
     criterio_5h_1 boolean,
     criterio_5h_2 boolean,
     criterio_5h_3 boolean,
     criterio_5h_4 boolean,
     criterio_5i_1 boolean,
     criterio_5i_2 boolean,
     criterio_5i_3 boolean,
     criterio_5i_4 boolean,
     criterio_5j_1 boolean,
     criterio_5j_2 boolean,
     criterio_5j_3 boolean,
     criterio_5j_4 boolean,
     criterio_6_1 boolean,
     criterio_6_2 boolean,
     criterio_6_3 boolean,
     criterio_6_4 boolean,
     criterio_7_1 boolean,
     criterio_7_2 boolean,
     criterio_7_3 boolean,
     criterio_7_4 boolean,
     criterio_8_1 boolean,
     criterio_8_2 boolean,
     criterio_8_3 boolean,
     criterio_8_4 boolean,
     criterio_9_1 boolean,
     criterio_9_2 boolean,
     criterio_9_3 boolean,
     criterio_9_4 boolean,
     criterio_10_1 boolean,
     criterio_10_2 boolean,
     criterio_10_3 boolean,
     criterio_10_4 boolean,
     criterio_11_1 boolean,
     criterio_11_2 boolean,
     criterio_11_3 boolean,
     criterio_11_4 boolean
)

create table fobias (
  n_orden integer,
  fecha date,
  criterio_inteligencia text,  
  criterio_fobias text,
  analisis_foda_forta_oport text,
  analisis_foda_amenaz_debili text,
  observaciones text,
  recomendaciones text,
  conclusiones_apto boolean,
  conclusiones_no_apto boolean
)

create table Aversionalriesgo (
  n_orden integer,
	asp_Intel_Pract_Func_bajo boolean,
  asp_Intel_Pract_Func_medio boolean,
  asp_Intel_Pract_Func_alto boolean,

	asp_Intel_Recur_bajo boolean,
  asp_Intel_Recur_medio boolean,
  asp_Intel_Recur_alto boolean,

	asp_Intel_atenci_conc_bajo boolean,
  asp_Intel_atenci_conc_medio boolean,
  asp_Intel_atenci_conc_alto boolean,

	asp_emoc_estabil_emoc_mad_bajo boolean,
  asp_emoc_estabil_emoc_mad_medio boolean,
  asp_emoc_estabil_emoc_mad_alto boolean,

	asp_Flexib_manj_emoc_bajo boolean,
  asp_Flexib_manj_emoc_medio boolean,
  asp_Flexib_manj_emoc_alto boolean,

	asp_ctrl_impul_bajo boolean,
  asp_ctrl_impul_medio boolean,
  asp_ctrl_impul_alto boolean,

	comp_especf_cap_subor_bajo boolean,
  comp_especf_cap_subor_medio boolean,
  comp_especf_cap_subor_alto boolean,

	comp_especf_Adec_nor_proced_bajo boolean,
  comp_especf_Adec_nor_proced_medio boolean,
  comp_especf_Adec_nor_proced_alto boolean,

	comp_especf_Considera_terceros_bajo boolean,
  comp_especf_Considera_terceros_medio boolean,
  comp_especf_Considera_terceros_alto boolean,

	comp_especf_Autonomia_trabajar_bajo boolean,
  comp_especf_Autonomia_trabajar_medio boolean,
  comp_especf_Autonomia_trabajar_alto boolean,

	comp_especf_proactividad_bajo boolean,
  comp_especf_proactividad_medio boolean,
  comp_especf_proactividad_alto boolean,

	comp_especf_Cap_trabjo_bajo_presion_bajo boolean,
  comp_especf_Cap_trabjo_bajo_presion_medio boolean,
  comp_especf_Cap_trabjo_bajo_presion_alto boolean,

	comp_especf_Cap_Evaluar_riesgos_bajo boolean,
  comp_especf_Cap_Evaluar_riesgos_medio boolean,
  comp_especf_Cap_Evaluar_riesgos_alto boolean,

	comp_especf_Mot_por_car_bajo boolean,
  comp_especf_Mot_por_car_medio boolean,
  comp_especf_Mot_por_car_alto boolean,

	analisis_resultados text,
	recomendaciones text,
	conclusiones_cumple boolean,
  conclusiones_no_cumple boolean
)


create table trastornos_personalidad(
  n_orden integer,
  grup_a_paranoide_bajo boolean,
  grup_a_paranoide_medio boolean,
  grup_a_paranoide_alto boolean,

  grup_a_esquizoide_bajo boolean,
  grup_a_esquizoide_medio boolean,
  grup_a_esquizoide_alto boolean,

  grup_a_esquizotipico_bajo boolean,
  grup_a_esquizotipico_medio boolean,
  grup_a_esquizotipico_alto boolean,

  grup_b_histrionico_bajo boolean,
  grup_b_histrionico_medio boolean,
  grup_b_histrionico_alto boolean,

  grup_b_antisocial_bajo boolean,
  grup_b_antisocial_medio boolean,
  grup_b_antisocial_alto boolean,

  grup_b_narcicista_bajo boolean,
  grup_b_narcicista_medio boolean,
  grup_b_narcicista_alto boolean,

  grup_b_inesta_emoci_subtip_impul_bajo boolean,
  grup_b_inesta_emoci_subtip_impul_medio boolean,
  grup_b_inesta_emoci_subtip_impul_alto boolean,

  grup_b_emoci_subtip_lim_bajo boolean,
  grup_b_emoci_subtip_lim_medio boolean,
  grup_b_emoci_subtip_lim_alto boolean,

  grup_c_anancastico_bajo boolean,
  grup_c_anancastico_medio boolean,
  grup_c_anancastico_alto boolean,

  grup_c_dependiente_bajo boolean,
  grup_c_dependiente_medio boolean,
  grup_c_dependiente_alto boolean,

  grup_c_ansioso_bajo boolean,
  grup_c_ansioso_medio boolean,
  grup_c_ansioso_alto boolean,
  
  analisis_resulta text,
  recomendacion text,
  perf_cumple boolean,
  perf_no_cumple boolean,
  interpretacion_parainoide text
)

create table infor_conductores(
  n_orden integer,
  crit_atencion text,
  crit_concetracion text,
  crit_segurid_control_conduc text,
  anali_foda_forta_oport text,
  anali_foda_amenaz_debili text,
  observacion text,
  recomendacion text,
  perf_cumple boolean,
  perf_no_cumple boolean
)

create table alto_riesgo(
  n_orden integer,
  crit_temor_riesgo_electrico text,
  crit_temor_alturas_izaje text,
  crit_temor_espac_confi text,
  anali_foda_forta_oport text,
  anali_foda_amenaz_debili text,
  observaciones text,
  recomendaciones text,
  perf_cumple boolean,
  perf_no_cumple boolean
)

create table Especificos(
  n_orden integer,
  criterio_Nivel_alert_riesgo text,
  criterio_Nivel_psicomotrocidad text,
  analisis_foda_forta_oport text,
  analisis_foda_amenaz_debili text,
  observaciones text,
  recomendaciones text,
  perf_cumple boolean,
  perf_no_cumple boolean
)

create table cuestionario_Berlin(
  n_orden integer,
  criterio_Apnea_obstructiva_sueño text,
  criterio_Fatiga_somnolencia text,
  criterio_Hipertension_arterial text,
  analisis_foda_forta_oport text,
  analisis_foda_amenaz_debili text,
  observaciones text,
  recomendaciones text,
  perf_cumple boolean,
  perf_no_cumple boolean
)

create table radiografia(
 n_orden integer,
 tipo_radio text,
 info_general text,
 conclu text
)

#Cambios 


