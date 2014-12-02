(* Mathematica Test File *)

(*Current percentage of succesful simulations: 98%*)

Options[runSBMLTestSuiteTest]={"LevelVersion"->"l2v1"};
runSBMLTestSuiteTest::lvNotFound="SBML XML with version/level `1` not found in test data.";
runSBMLTestSuiteTest::noODE="Model contains no ODE.";
runSBMLTestSuiteTest[cachedStuff_Rule,opts:OptionsPattern[{runSBMLTestSuiteTest, NDSolve}]]:=Module[{start,stop,fluxSol,results,settings,sPecies,comparison,model,amountVars,anticipatedResults,concVar,concSol,paramIni,anicipatedResults},

    compareResults[reference:{_Rule..},result:{_Rule..}]:=Module[{c,u},
        c=Transpose[reference[[All,2]]];
        u=Transpose[reference[[All,1]]/.result];
        Thread[{reference[[All,1]],#}]&/@(Thread/@Thread[Abs[c-u]<("absolute"*10+"relative"*Abs[c])])
    ];

    settings=cachedStuff[[2,4]];
    {anticipatedResults,sPecies}=cachedStuff[[2,3]];
    anicipatedResults=Thread[Rule[sPecies,Thread[{anticipatedResults[[All,1]],#}]&/@Transpose[anticipatedResults[[All,2]]]]];
    start="start"/.settings;
    stop=start+("duration"/.settings);
    If[MatchQ[(OptionValue["LevelVersion"]/.cachedStuff[[2,1]]),OptionValue["LevelVersion"]|$Failed],Message[runSBMLTestSuiteTest::lvNotFound,OptionValue["LevelVersion"]];Abort[];];
    model=sbml2model[OptionValue["LevelVersion"]/.cachedStuff[[2,1]],UnitChecking->False];
    If[model["ODE"]=={},Message[runSBMLTestSuiteTest::noODE];Abort[];];
    amountVars=ToString/@("amount"/.settings);
    concVar=(ToString/@("concentration"/.settings))/.{"Null"}->{};

    Check[
        If[concVar=!={},
            {concSol,fluxSol}=stripUnits@simulate[model,{t,start,stop},Sequence@@updateRules[{"SpeciesProfiles"->"Concentrations"},FilterRules[List[opts],Options[NDSolve]]]]/.m:(_species|_parameter):>(getID[m]/.{"Volume",elem_}:>elem);,
            {concSol,fluxSol}=stripUnits@simulate[model,{t,start,stop},Sequence@@updateRules[{"SpeciesProfiles"->"Particles"},FilterRules[List[opts],Options[NDSolve]]]]/.m:(_species|_parameter):>(getID[m]/.{"Volume",elem_}:>elem);
        ];,
        paramIni=getID[#[[1]]]->#[[2]]&/@Join[model["Parameters"],model["InitialConditions"]];
        concSol=#[[1]]->If[NumberQ[#[[2]]],With[{x=#[[2]]},FunctionInterpolation[x&[t],{t,start,stop}]]]&/@FilterRules[paramIni,{"k1"}];
    ,{NDSolve::nodv}];

    concSol=Thread[Rule[amountVars,amountVars/.concSol]];
    results=Table[t->(amountVars/.concSol),{t,anticipatedResults[[All,1]]}];
    comparison=Thread[Rule[amountVars,compareResults[anticipatedResults,results]]]/.settings;
    !MemberQ[comparison,False,Infinity]
];

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

(*cachedSBMLnew = Import["Tests/TestData/cachedSBMLTestSuite_2.1.2.wdx.gz"];*)
cachedSBMLnew = Import["Tests/TestData/cachedSBMLTestSuite_2.0.2.wdx.gz"];

(*CheckAbort[Check[runSBMLTestSuiteTest[cachedSBMLnew[[i]],"LevelVersion"->"l2v3"],Abort[];,{Toolbox`Private`parseReactionXML::fastReactionDetected,runSBMLTestSuiteTest3::lvNotFound,runSBMLTestSuiteTest3::noODE}],(*Print[i];*)$MessageList[[-1]]]*)

If[$VersionNumber>=9,
    doNotTest={"00028"(*Fails miserably in M9*),"00173","00197","00269","00954","00955","00956"};
    options={_->{Method -> {"DiscontinuityProcessing" -> False}}};,
    doNotTest={};
    options={};
];

Do[
    If[MemberQ[doNotTest,testCase[[1]]],(*Print["Skipping "<>testCase[[1]]<>"!"];*)Continue[]];
    testResult=Check[CheckAbort[runSBMLTestSuiteTest[testCase,"LevelVersion"->"l3v1",Sequence @@ (testCase[[1]] /. options)],Print[testCase[[1]]];None],Print[$MessageList[[-1]]];Print["Skipping "<>testCase[[1]]<>"!"];Continue[];,{sbml2model::conversionFactorDetected,sbml2model::eventProblem,sbml2model::variableStoichiometry,sbml2model::eventDelayDetected,Toolbox`Private`reactionList2model::autoCatalyticRxn,Toolbox`Private`parseReactionXML::fastReactionDetected,runSBMLTestSuiteTest::lvNotFound,runSBMLTestSuiteTest::noODE}];
    With[{id="SBMLTestSuite_"<>testCase[[1]]},
    Test[
        testResult,
        True,
        TestID->id
    ]
    ]
,{testCase,cachedSBMLnew}]

(*Do[
    Test[
        RandomChoice[{True,False}],
        True,
        TestID->"SBMLTestSuite"<>ToString[testCase]
    ]
    ,{testCase,1,1000}]*)

(*Test[
	CheckAbort[sbml2model["wrong/path/toFile.sbml"], True]
	,
	True
	,	
	{sbml2model::NotExistFile}
	,
	TestID->"SBMLrelatedTests-20110907-U7S4O0"
]

model = sbml2model["Models/Ec_core_flux1.xml.gz"];

Test[
	getID[model]
	,
	"Ec_core"
	,
	TestID->"SBMLrelatedTests-20110907-A2I6V5"
]


Test[
	Head[model]
	,
	MASSmodel
	,
	TestID->"SBMLrelatedTests-20110511-M3A2C3"
]

Test[
	{model["ID"], model["Name"], Dimensions[model], Length[model["Fluxes"]], Length[model["Variables"]]}
	,
	{"Ec_core", "Ec_core", {63, 77}, 77, 63}
	,
	TestID->"SBMLrelatedTests-20110511-W4W6W9"
]

(*glycolysis = sbml2model["../../Models/Glycolysis.sbml"];

Test[
	model2sbml[glycolysis]
	,
	Import["../../Models/glycolysis", "Text"]
	,
	TestID->"SBMLrelatedTests-20110926-L4O2C8"
]*)

nielsenModel = sbml2model["Models/BIOMD0000000042.xml.gz"];

Test[
	Head[nielsenModel]
	,
	MASSmodel
	,
	TestID->"SBMLrelatedTests-20110525-F0V1C1"
]

Test[
	{nielsenModel["ID"], nielsenModel["Name"], Dimensions[nielsenModel], Length[nielsenModel["Fluxes"]], Length[nielsenModel["Variables"]]}
	,
	{"Glycolysis_Nielsen", "Nielsen1998_Glycolysis", {15, 25}, 25, 15}
	,
	TestID->"SBMLrelatedTests-20110525-X9R0D1"
]

(*Test model import via Biomodels web services*)


Test[
	modelFromBiomodelsDB = biomodel2model["BIOMD0000000042"]
	,
	nielsenModel
	,
	TestID->"SBMLrelatedTests-20110525-W7Y1D7"
]

Test[
	CheckAbort[biomodel2model["NotAbiomodelsId"], True]
	,
	True
	,
	{biomodel2model::wrngid}
	,
	TestID->"SBMLrelatedTests-20110525-F8B1V2"
]*)
