(* Mathematica Test File *)

Needs["Toolbox`"]

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

rxns = {
   r["1", {e["E1"], m["A", "c"]}, {e["E3"]}, {1, 1, 1}, True],
   r["6", {e["E1"], m["P", "c"]}, {e["E2"]}, {1, 1, 1}, True],
   r["3", {e["E1"], m["B", "c"]}, {e["E5"]}, {1, 1, 1}, True],
   r["2", {e["E3"], m["B", "c"]}, {e["E4"]}, {1, 1, 1}, True],
   r["5", {e["E2"], m["C", "c"]}, {e["E4"]}, {1, 1, 1}, True],
   r["4", {e["E5"], m["A", "c"]}, {e["E4"]}, {1, 1, 1}, True]
   };
   
enz=constructModel[rxns];
setModelAttribute[enz,"Parameters",#->RandomReal[]&/@Join[enz["ForwardRateConstants"],enz["ReverseRateConstants"]]];
eForms=Cases[enz["Species"],_enzyme];
mets=Complement[enz["Species"],eForms];
setModelAttribute[enz,"InitialConditions",Join[{eForms[[1]]->1},Thread[Rule[eForms[[2;;]],0]],Thread[Rule[mets,1]]]]
ic=(#->RandomReal[{0,1}]&/@enz["Species"])
param=(#->RandomReal[]&/@Join[enz["ForwardRateConstants"],enz["ReverseRateConstants"]])
ss = findSteadyState[enz, InitialConditions -> ic, 
   Parameters -> param, Strategy -> simulate][[1]]

numEtot = (Plus @@ eForms /. ic);
kaPatterns = KingAltmanPatterns[enz];

ssKA = #[[1]] -> (#[[2]] /. param /. ss)*numEtot & /@ kaPatterns

Test[
	Chop[Abs[Thread[Subtract[ssKA[[All, 1]] /. FilterRules[ss, _enzyme],ssKA[[All, 2]]]]], 1*^-6]
	,
	{0, 0, 0, 0, 0}
	,
	TestID->"RegulationRelatedTests-20120529-O4Y3U2"
]

enzymeModules = {"Sequential_Ordered_BiBi" -> 
    constructEnzymeModule[
     Mechanism -> {"E_E[c] + A[c] <=> E_E[c]&A", 
       "E_E[c]&A + B[c] <=> E_E[c]&A&B", "E_E[c]&A&B <=> E_E[c]&Q&P", 
       "E_E[c]&Q&P <=> E_E[c]&Q + P[c]", 
       "E_E[c]&Q <=> E_E[c] + Q[c]"}, Activators -> {}, 
     ActivationSites -> 0, Inhibitors -> {}, InhibitionSites -> 0]
   };
   
Test[
	getEnzymeSteadyStateEquations[enzymeModules[[1, 2]]]
	,
	Import["Tests/TestData/enzModuleSSequations.m"]
	,
	TestID->"RegulationRelatedTests-20140209-S6U4N2"
]

Test[
	solveEnzymeSteadyStateEquations[enzymeModules[[1, 2]]]
	,
	Import["Tests/TestData/enzModuleSSsolution.m"]
	,
	TestID->"RegulationRelatedTests-20140209-A7L1C8"
]