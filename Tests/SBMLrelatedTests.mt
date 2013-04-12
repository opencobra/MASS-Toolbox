(* Mathematica Test File *)

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

Table[
    Test[
    i,
    i,
    TestID->ToString[i]
    ]
    ,{i,1,10}]

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
