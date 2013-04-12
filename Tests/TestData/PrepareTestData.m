(* ::Package:: *)

<<Toolbox`


SetDirectory[NotebookDirectory[]];
json=parseJSON["equilibrator.json.gz"];


kegg2equilibrator=DeleteCases[metabolite["CID"/.#,_]->"pmaps"/.#&/@json,r_Rule/;r[[2]]==="pmaps"]/.("dG0_f"->n_?NumberQ):>("dG0_f"->n Kilo Joule Mole ^-1);
SetDirectory[NotebookDirectory[]];
Export["kegg2equilibrator.m.gz",kegg2equilibrator];


SetDirectory[NotebookDirectory[]];
keggRxns=Import["AllParsableKEGGreactions.m.gz"];


int2keggRxnID="R"<>StringJoin[Sequence@@Table["0",{5-StringLength[ToString@#]}]]<>ToString[#]&;
SetDirectory[NotebookDirectory[]];
rawImport=Import["kegg_reactions_alberty_ph7.0.csv.gz"];
referenceData=FilterRules[int2keggRxnID[#[[1]]]->#[[2]]Kilo Joule Mole^-1&/@DeleteCases[rawImport[[2;;]],{_,"",__}],keggRxns[[All,1]]];


kegg2equilibrator[[1]]


result=ParallelTable[referenceData[[i,1]]->{stripUnits@referenceData[[i,2]], stripUnits@calcDeltaG[referenceData[[i,1]]/.keggRxns,kegg2equilibrator,IonicStrength->.1 Mole Liter^-1, pH->9.][[2]]},{i,1,Length[referenceData]},DistributedContexts->Automatic]


int2keggRxnID="R"<>StringJoin[Sequence@@Table["0",{5-StringLength[ToString@#]}]]<>ToString[#]&;
SetDirectory[NotebookDirectory[]];
rawImport=Import["kegg_reactions_alberty_ph9.0.csv.gz"];
referenceData=FilterRules[int2keggRxnID[#[[1]]]->#[[2]]Kilo Joule Mole^-1&/@DeleteCases[rawImport[[2;;]],{_,"",__}],keggRxns[[All,1]]];


AbsoluteTiming[result=ParallelTable[referenceData[[i,1]]->{stripUnits@referenceData[[i,2]], stripUnits@calcDeltaG[referenceData[[i,1]]/.keggRxns,kegg2equilibrator,IonicStrength->.1 Mole Liter^-1, pH->9.][[2]]},{i,1,Length[referenceData]},DistributedContexts->Automatic];]


ListPlot[Abs[Subtract@@@result[[All,2]]],Filling->Bottom]


int2keggRxnID="R"<>StringJoin[Sequence@@Table["0",{5-StringLength[ToString@#]}]]<>ToString[#]&;
SetDirectory[NotebookDirectory[]];
rawImport=Import["kegg_reactions_alberty_ph7.0.csv.gz"];
referenceData=FilterRules[int2keggRxnID[#[[1]]]->#[[2]]Kilo Joule Mole^-1&/@DeleteCases[rawImport[[2;;]],{_,"",__}],keggRxns[[All,1]]];


AbsoluteTiming[result=ParallelTable[referenceData[[i,1]]->{stripUnits@referenceData[[i,2]], stripUnits@calcDeltaG[referenceData[[i,1]]/.keggRxns,kegg2equilibrator,IonicStrength->.1 Mole Liter^-1, pH->7.][[2]]},{i,1,Length[referenceData]},DistributedContexts->Automatic];]


ListPlot[Abs[Subtract@@@result[[All,2]]],Filling->Bottom]
