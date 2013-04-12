(* Mathematica Test File *)

Needs["Toolbox`"]

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

model = Import["Models/Glycolysis.m"];
referenceConcSolution = {0.28999999999999926, 0.08672812499999963, 1.5999999999999996, 0.16000000000000028, 0.01980000000000001, 0.014600000000000057, 0.04860000000000002, 0.0072800000000000165, 1.0000000000000002, 0.00008997573444801929, 1., 1.36, 0.058899999999999994, 0.01700000000000004, 0.000243000000000001, 0.011300000000000022, 0.07730000000000015, 0.060301, 0.030099999999999995, 2.4999999999999982};
referenceFluxSolution = {1.1200000000000006, 1.1200000000000254, 1.12, 1.12, 1.1200000000000099, 2.2400000000000007, 2.239999999999966, 2.24, 2.239999999999997, 2.2400000000000007, 2.0160000000000013, 0.013999999999999829, -2.636779683484747*^-16, 0.22400000000000003, 2.0160000000000013, 2.2400000000000007, 0.22400000000000017, 1.12, 0.014, 2.6880000000000015, 0.};

Print[simulate[model, {t, 0, 1000}][[1]]];
Print[Chop[EuclideanDistance[model["Species"]/.stripUnits[simulate[model, {t, 0, 1000}][[1]]] /. t-> 10., referenceConcSolution]] == 0.];

Test[
	Chop[EuclideanDistance[model["Species"]/.stripUnits[simulate[model, {t, 0, 1000}][[1]]] /. t-> 10., referenceConcSolution]] == 0.
	,
	True
	,
	TestID->"SimulationRelatedTests-20120213-N7U1Q6"
]

Test[
	Chop[EuclideanDistance[stripUnits[simulate[model, {t, 0, 1000}][[2,All,2]]] /. t-> 10., referenceFluxSolution]] == 0.
	,
	True
	,
	TestID->"SimulationRelatedTests-20120213-K9U6M4"
]

model2 = model;
setInitialConditions[model2, model["InitialConditions"][[;; -5]]]

If[$VersionNumber > 7,
Test[
	CheckAbort[simulate[model2];, True]
	,
	True
	,
	{simulate::missingIC}
	,
	TestID->"SimulationRelatedTests-20120213-F7J6J3"
]
]

(*model3=model;
setModelAttribute[model3,"Parameters",model2["Parameters"][[;;-10]]]

Print["Hey"];

simulate[model3]

Print["Hey2"];

Test[
	CheckAbort[simulate[model3];, True]
	,
	True
	,
	{NDSolve::ndnum, simulate::missingParam}
	,
	TestID->"SimulationRelatedTests-20120213-F7J6J3"
]*)


(*Test[
	{concSol, fluxSol} = randomSimulation[model, Seed->1];
	{#[[1,0]] -> #[[2]] /. t -> .66 & /@ concSol, #[[1]] -> #[[2]] /. t -> .66 & /@ fluxSol}
	,
	{{metabolite["glu", "c"] -> 178.64522006536194, metabolite["g6p", "c"] -> 0.000998586317820776, metabolite["f6p", "c"] -> 0.7821041432182982, metabolite["fdp", "c"] -> 1.0250040001525384*^-8, metabolite["dhap", "c"] -> 5.2350002356748286*^-9, metabolite["gap", "c"] -> 8.351882218243867*^-8, metabolite["pg13", "c"] -> 0.0069777891737488286, metabolite["pg3", "c"] -> 0.000027157429342513525, metabolite["pg2", "c"] -> 0.00004326710580197233, metabolite["pep", "c"] -> 0.2115792271718952, metabolite["pyr", "c"] -> 0.004808598258951891, metabolite["lac", "c"] -> 0.0018655142310083253, metabolite["nad", "c"] -> 0.05898923875539543, metabolite["amp", "c"] -> 2.3257410311523548, metabolite["adp", "c"] -> 0.003852931377584693, metabolite["atp", "c"] -> 1.368470179626957*^-7, metabolite["h", "c"] -> 0.002635635638643225, metabolite["h2o", "c"] -> 0.0014544329816703191, metabolite["nadh", "c"] -> 7.369790525155212*^-7, metabolite["phos", "c"] -> 1.0251328510838191}, {"vhk" -> 0.019732674465111504, "vpgi" -> 0.019864512292178605, "vpfk" -> 1.2819894298633704*^-6, "vtpi" -> 1.3403345240076332*^-6, "vald" -> 1.3204187080049617*^-6, "vgapdh" -> 2.9962661535859663*^-6, "vpgk" -> 0.012337558784995753, "vpglm" -> 0.012426703263753567, "veno" -> 0.012554024197187933, "vpk" -> 0.0015631196982612116, "vldh" -> -0.0000824628274050399, "vamp" -> 709.9205203545574, "vapk" -> 0.005797557284830727, "vpyr" -> 0.0016490960124027605, "vlac" -> 0.006270296197698227, "vatp" -> -0.00003520282367697554, "vnadh" -> 0.00008592077580137712, "vgluin" -> 117.84525354530767, "vampin" -> 709.914665180556, "vh" -> 0.018662737472193398, "vh2o" -> 0.01267788363772583}}
	,
	TestID->"SimulationRelatedTests-20110907-I5P3A9"
]
*)
