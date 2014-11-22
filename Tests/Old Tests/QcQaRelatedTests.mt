(* Mathematica Test File *)

Needs["Toolbox`"]

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

ecolicoreNew = sbml2model["Models/EcoliCore.xml.gz",  Method->"Light"];
ecolicoreOld = sbml2model["Models/Ec_core_flux1.xml.gz",  Method->"Light"];

Test[
	stoichiometricallyConsistentQ[ecolicoreNew]
	,
	True
	,
	TestID->"QcQaRelatedTests-20111201-Q6W3T3"
]

Test[
	stoichiometricallyConsistentQ[ecolicoreOld]
	,
	False
	,
	TestID->"QcQaRelatedTests-20111201-I9J9K8"
]

Print[detectUnconservedMetabolites[ecolicoreOld]];

Test[
	detectUnconservedMetabolites[ecolicoreNew]
	,
	{}
	,
	TestID->"QcQaRelatedTests-20111201-D0W2K0"
]

Test[
	Sort@detectUnconservedMetabolites[ecolicoreOld]
	,
	Sort@{metabolite["M_13dpg_c", "Cytosol"], metabolite["M_2pg_c", "Cytosol"], metabolite["M_3pg_c", "Cytosol"], metabolite["M_6pgc_c", "Cytosol"], metabolite["M_6pgl_c", "Cytosol"], metabolite["M_ac_c", "Cytosol"], metabolite["M_ac_e", "Extra_organism"], metabolite["M_actp_c", "Cytosol"], metabolite["M_akg_c", "Cytosol"], metabolite["M_akg_e", "Extra_organism"], metabolite["M_cit_c", "Cytosol"], metabolite["M_co2_c", "Cytosol"], metabolite["M_co2_e", "Extra_organism"], metabolite["M_dhap_c", "Cytosol"], metabolite["M_e4p_c", "Cytosol"], metabolite["M_etoh_c", "Cytosol"], metabolite["M_etoh_e", "Extra_organism"], metabolite["M_f6p_c", "Cytosol"], metabolite["M_fdp_c", "Cytosol"], metabolite["M_for_c", "Cytosol"], metabolite["M_for_e", "Extra_organism"], metabolite["M_fum_c", "Cytosol"], metabolite["M_fum_e", "Extra_organism"], metabolite["M_g3p_c", "Cytosol"], metabolite["M_g6p_c", "Cytosol"], metabolite["M_glc_D_e", "Extra_organism"], metabolite["M_glx_c", "Cytosol"], metabolite["M_h2o_c", "Cytosol"], metabolite["M_h2o_e", "Extra_organism"], metabolite["M_h_c", "Cytosol"], metabolite["M_h_e", "Extra_organism"], metabolite["M_icit_c", "Cytosol"], metabolite["M_lac_D_c", "Cytosol"], metabolite["M_lac_D_e", "Extra_organism"], metabolite["M_mal_L_c", "Cytosol"], metabolite["M_o2_c", "Cytosol"], metabolite["M_o2_e", "Extra_organism"], metabolite["M_oaa_c", "Cytosol"], metabolite["M_pep_c", "Cytosol"], metabolite["M_pi_c", "Cytosol"], metabolite["M_pi_e", "Extra_organism"], metabolite["M_pyr_c", "Cytosol"], metabolite["M_pyr_e", "Extra_organism"], metabolite["M_r5p_c", "Cytosol"], metabolite["M_ru5p_D_c", "Cytosol"], metabolite["M_succ_c", "Cytosol"], metabolite["M_s7p_c", "Cytosol"], metabolite["M_succ_e", "Extra_organism"], metabolite["M_xu5p_D_c", "Cytosol"]}
	,
	TestID->"QcQaRelatedTests-20111201-I1T2Q3"
]
