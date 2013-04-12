(* Mathematica Test File *)

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];
Print[Directory[]];

(*int2keggRxnID="R"<>StringJoin[Sequence@@Table["0",{5-StringLength[ToString@#]}]]<>ToString[#]&;

kegg2equilibrator=Import["Tests/TestData/kegg2equilibrator.m.gz"];
*)
basicBiochemData3=Import["Tests/TestData/AlbertyBasicBiochemData3.m"];
oldFormat = #[[1]] -> equilibrator2albertyFormat[#[[2]]] & /@ stripUnits[basicBiochemData3];

derivetrGibbsT[speciesmat_]:=Module[{dGzero,dGzeroT,dHzero,zi,nH,gibbscoeff
,pHterm, isterm,gpfnsp,istermG},(*This program derives the function of T (in Kelvin), 
pH, and ionic strength (is) that gives the standard transformed Gibbs energy 
of formation of a reactant (sum of species).  The input speciesmat is a matrix 
that gives the standard Gibbs energy of formation in kJ mol^-1 at 298.15 K and 
zero ionic strength, the standard enthalpy of formation in kJ mol^-1 at 298.15 K 
and zero ionic strength, the electric charge, and the number of hydrogen atoms in 
each species.  There is a row in the matrix for each species of the reactant. 
gpfnsp is a list of the functions for the standard transformed Gibbs energies 
of the species. The corresponding functions for other transformed properties 
can be obtained by taking partial derivatives.  The standard transformed Gibbs 
energy of formation of a reactant in kJ mol^-1 can be calculated at any temperature 
in the range 273.15 K to 313.15 K, any pH in the range 5 to 9, and any ionic 
strength in the range 0 to 0.35 M by use of ReplaceAll (/.).*) 
{dGzero,dHzero,zi,nH}=Transpose[speciesmat]; 
gibbscoeff=(9.20483*T)/10^3-(1.284668*T^2)/10^5+(4.95199*T^3)/10^8; 
dGzeroT=(dGzero*T)/298.15+dHzero*(1-T/298.15); 
pHterm=(nH*8.31451*T*Log[10^(-pH)])/1000;
istermG=(gibbscoeff*(zi^2-nH)*is^0.5)/(1+1.6*is^0.5); 
gpfnsp=dGzeroT-pHterm-istermG; 
-((8.31451*T*Log[Plus@@(E^(-(gpfnsp/((8.31451*T)/1000))))])/1000)]

If[$VersionNumber > 7,
(*Test pH invalid range warning, lower bound*)
Test[
	calcDeltaG[basicBiochemData3[[1,2]], pH->4.99, is->0]
	,
	AutomaticUnits`Unit[-25.0680017713172, "Kilojoule"/"Mole"]
	,
	{calcDeltaG::pHandISandTrange}
	,
	TestID->"ThermodynamicsTests-20121106-B9N1E0"
]


(*Test pH invalid range warning, upper bound*)
Test[
    calcDeltaG[basicBiochemData3[[1,2]], pH->9.1, is->0]
    ,
    AutomaticUnits`Unit[68.77178033687645, "Kilojoule"/"Mole"]
    ,
    {calcDeltaG::pHandISandTrange}
    ,
    TestID->"ThermodynamicsTests-20121106-Z9H3B1"
]


(*Test ionic strength invalid range warning, upper bound*)
Test[
    calcDeltaG[basicBiochemData3[[1,2]], is->0.36, pH->7]
    ,
    AutomaticUnits`Unit[24.393698300677702`, "Kilojoule"/"Mole"]
    ,
    {calcDeltaG::pHandISandTrange}
    ,
    TestID->"ThermodynamicsTests-20121106-D6A7R4"
]

(*Test temperature invalid range warning, lower bound*)
Test[
    calcDeltaG[basicBiochemData3[[1,2]], is->0., pH->7, T->273.14]
    ,
    AutomaticUnits`Unit[1.2749186424346133, "Kilojoule"/"Mole"]
    ,
    {calcDeltaG::pHandISandTrange}
    ,
    TestID->"ThermodynamicsTests-20121106-D7F2S0"
]


(*Test temperature invalid range warning, upper bound*)
Test[
    calcDeltaG[basicBiochemData3[[1,2]], is->0., pH->7, T->313.16]
    ,
    AutomaticUnits`Unit[32.55728974908408, "Kilojoule"/"Mole"]
    ,
    {calcDeltaG::pHandISandTrange}
    ,
    TestID->"ThermodynamicsTests-20121106-C0J3M8"
]
]


If[$VersionNumber > 7,
(* pH and is corrections *)
Test[
	toolboxResult=stripUnits[#[[1]]->(calcDeltaG[#[[2]],R->8.31451Joule (Mole Kelvin)^-1 (*Alberty's slightly wrong gas constant*),is->0.25,pH->7.])&/@basicBiochemData3];
	albertyResult=#[[1]]->(derivetrGibbsT[#[[2]]]/.{is->0.25,pH->7.,T->298.15})&/@oldFormat;
	scatter=scatterFromDicts[toolboxResult,albertyResult];
	Total[Abs[Subtract @@ #[[2]]] & /@ scatter]<1*^-10
	,
	True
	,
	TestID->"ThermodynamicsTests-20121106-R8G2O2"
]
]
(* pH and is corrections *)
Test[
    toolboxResult=stripUnits[#[[1]]->(calcDeltaG[#[[2]],R->8.31451Joule (Mole Kelvin)^-1 (*Alberty's slightly wrong gas constant*),is->0.25,pH->7.])&/@basicBiochemData3];
    albertyResult=#[[1]]->(derivetrGibbsT[#[[2]]]/.{is->0.25,pH->7.,T->298.15})&/@oldFormat;
    scatter=Chop@scatterFromDicts[toolboxResult,albertyResult];
    Total[Abs[Subtract @@ #[[2]]] & /@ scatter]<1*^-10
    ,
    True
    ,
    TestID->"ThermodynamicsTests-20121106-V5N3W7"
]

(* T corrections *)
Test[
    toolboxResult=#[[1]]->(stripUnits@calcDeltaG[#[[2]],T->310 Kelvin,R->8.31451Joule (Mole Kelvin)^-1]/.{is->0,pH->7.})&/@stripUnits[Select[basicBiochemData3,!MemberQ[#,_Missing,\[Infinity]]&]];
    albertyResult=#[[1]]->(derivetrGibbsT[#[[2]]]/.{is -> 0, pH -> 7., T -> 310})&/@Select[oldFormat,!MemberQ[#,_Missing,\[Infinity]]&];
    scatter=scatterFromDicts[toolboxResult,albertyResult];
    Total[Abs[Subtract @@ #[[2]]] & /@ scatter]<1*^-10
    ,
    True
    ,
    TestID->"ThermodynamicsTests-20121106-M3C6L7"
]


(*Test[
	rawImport=Import["kegg_reactions_alberty_ph7.0.csv.gz"];
	referenceData=FilterRules[int2keggRxnID[#[[1]]]->#[[2]]Kilo Joule Mole^-1&/@DeleteCases[rawImport[[2;;]],{_,"",__}],keggRxns[[All,1]]];
	AbsoluteTiming[result=ParallelTable[
	    referenceData[[i,1]]->{
	        stripUnits@referenceData[[i,2]],
	        stripUnits@calcDeltaG[referenceData[[i,1]]/.keggRxns,kegg2equilibrator,IonicStrength->.1 Mole Liter^-1, pH->9.][[2]]},{i,1,Length[referenceData]},DistributedContexts->Automatic]]
	,
	1
	,
	TestID->"ThermodynamicsTests-20120322-R8K8K2"
]*)
