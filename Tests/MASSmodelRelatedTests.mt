(* Mathematica Test File *)

compounds = {metabolite["glu","c"],metabolite["g6p","c"],metabolite["f6p","c"],metabolite["fdp","c"],metabolite["dhap","c"],metabolite["gap","c"],metabolite["pg13","c"],metabolite["pg3","c"],metabolite["pg2","c"],metabolite["pep","c"],metabolite["pyr","c"],metabolite["lac","c"],metabolite["nad","c"],metabolite["nadh","c"],metabolite["amp","c"],metabolite["adp","c"],metabolite["atp","c"],metabolite["phos","c"],metabolite["h","c"],metabolite["h2o","c"]}
expectedCompounds = {metabolite["glu", "c"], metabolite["g6p", "c"], metabolite["f6p", "c"], metabolite["fdp", "c"], metabolite["dhap", "c"], metabolite["gap", "c"], metabolite["pg13", "c"], metabolite["pg3", "c"], metabolite["pg2", "c"], metabolite["pep", "c"], metabolite["pyr", "c"], metabolite["lac", "c"], metabolite["nad", "c"], metabolite["nadh", "c"], metabolite["amp", "c"], metabolite["atp", "c"], metabolite["phos", "c"], metabolite["h", "c"], metabolite["adp", "c"], metabolite["h2o", "c"]}

fluxes = {"vhk", "vpgi", "vpfk", "vtpi", "vald", "vgapdh", "vpgk", 
   "vpglm", "veno", "vpk", "vldh", "vamp", "vapk", "vpyr", "vlac", 
   "vatp", "vnadh", "vgluin", "vampin", "vh", "vh2o"};

stoich = ( {{-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0}, {1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0}, {1, 0, 1, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0, 0, 0, 1, 1, 0, 0, -1, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1}, {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 1, 0, 0}, {1, 0, 1, 0, 0, 0, -1, 0, 0, -1, 0, 0, -2, 0, 0, 1, 0, 0, 0, 0, 0}, {-1, 0, -1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}} );
expectedStoich = {{-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0}, {1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0}, {1, 0, 1, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0, 0, 0, 1, 1, 0, 0, -1, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 1, 0, 0}, {1, 0, 1, 0, 0, 0, -1, 0, 0, -1, 0, 0, -2, 0, 0, 1, 0, 0, 0, 0, 0}, {-1, 0, -1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}};

expectedRxnList = {reaction["vhk", {metabolite["glu", "c"], metabolite["h", "c"]}, {metabolite["g6p", "c"], metabolite["nadh", "c"], metabolite["phos", "c"]}, {1, 1, 1, 1, 1}, True], reaction["vpgi", {metabolite["g6p", "c"]}, {metabolite["f6p", "c"]}, {1, 1}, True], reaction["vpfk", {metabolite["f6p", "c"], metabolite["h", "c"]}, {metabolite["fdp", "c"], metabolite["nadh", "c"], metabolite["phos", "c"]}, {1, 1, 1, 1, 1}, True], reaction["vtpi", {metabolite["dhap", "c"]}, {metabolite["gap", "c"]}, {1, 1}, True], reaction["vald", {metabolite["fdp", "c"]}, {metabolite["dhap", "c"], metabolite["gap", "c"]}, {1, 1, 1}, True], reaction["vgapdh", {metabolite["gap", "c"], metabolite["nad", "c"], metabolite["h2o", "c"]}, {metabolite["pg13", "c"], metabolite["nadh", "c"], metabolite["adp", "c"]}, {1, 1, 1, 1, 1, 1}, True], reaction["vpgk", {metabolite["pg13", "c"], metabolite["phos", "c"]}, {metabolite["pg3", "c"], metabolite["h", "c"]}, {1, 1, 1, 1}, True], reaction["vpglm", {metabolite["pg3", "c"]}, {metabolite["pg2", "c"]}, {1, 1}, True], reaction["veno", {metabolite["pg2", "c"]}, {metabolite["pep", "c"], metabolite["amp", "c"]}, {1, 1, 1}, True], reaction["vpk", {metabolite["pep", "c"], metabolite["nadh", "c"], metabolite["phos", "c"]}, {metabolite["pyr", "c"], metabolite["h", "c"]}, {1, 1, 1, 1, 1}, True], reaction["vldh", {metabolite["pyr", "c"], metabolite["nadh", "c"], metabolite["adp", "c"]}, {metabolite["lac", "c"], metabolite["nad", "c"]}, {1, 1, 1, 1, 1}, True], reaction["vamp", {metabolite["atp", "c"]}, {}, {1}, True], reaction["vapk", {metabolite["phos", "c"]}, {metabolite["atp", "c"], metabolite["h", "c"]}, {2, 1, 1}, True], reaction["vpyr", {metabolite["pyr", "c"]}, {}, {1}, True], reaction["vlac", {metabolite["lac", "c"]}, {}, {1}, True], reaction["vatp", {metabolite["amp", "c"], metabolite["h", "c"]}, {metabolite["nadh", "c"], metabolite["phos", "c"], metabolite["h2o", "c"]}, {1, 1, 1, 1, 1}, True], reaction["vnadh", {metabolite["adp", "c"]}, {metabolite["nad", "c"], metabolite["nadh", "c"]}, {1, 1, 1}, True], reaction["vgluin", {}, {metabolite["glu", "c"]}, {1}, True], reaction["vampin", {}, {metabolite["atp", "c"]}, {1}, True], reaction["vh", {metabolite["nadh", "c"]}, {}, {1}, True], reaction["vh2o", {metabolite["amp", "c"]}, {}, {1}, True]}

modelFromReactionList = constructModel[expectedRxnList];

Test[
	Union@Thread[Equal[expectedRxnList,Toolbox`Private`stoich2reactionList[modelFromReactionList["Stoichiometry"], modelFromReactionList["Species"], getID/@modelFromReactionList["Fluxes"], modelFromReactionList["ReversibleColumnIndices"]]]]
	,
	{True}
	,
	TestID->"MASSmodelRelatedTests-20110907-X4B1Q3"
]

Test[(*Test model construction*)
	model = constructModel[stoich, compounds, fluxes];
	Head[model]
	,
	MASSmodel
	,
	TestID->"MASSmodelRelatedTests-20110511-P6N5S8"
]

Test[
	MatrixRank[S[model][[1;;MatrixRank[model]]]]
	,
	MatrixRank[model]
	,
	TestID->"MASSmodelRelatedTests-20120119-U7L6Z4"
]

If[$VersionNumber > 7,
Test[(*Test if argument dimensions are checked and approprate messages are raised. Furthermore check Abort*)
	CheckAbort[constructModel[stoich, compounds[[;;-2]], fluxes], True]
	,
	True
	,
	{constructModel::wrongdim}
	,
	TestID->"MASSmodelRelatedTests-20110511-G5X9W7"
]
]

If[$VersionNumber > 7,
Test[(*Test if argument dimensions are checked and approprate messages are raised. Furthermore check Abort*)
    CheckAbort[constructModel[stoich, compounds, fluxes[[;;-2]]], True]
    ,
    True
    ,
    {constructModel::wrongdim}
    ,
    TestID->"MASSmodelRelatedTests-20110511-G1K6N5"
]
]



Test[(*Test Compounds accessor*)
	model["Species"]
	,
	expectedCompounds
	,
	TestID->"MASSmodelRelatedTests-20110511-W6Z4K6"
]

	
Test[(*Test Variables accessor*)

	model["Variables"]
	,
	{metabolite["adp", "c"][t], metabolite["amp", "c"][t], metabolite["atp", "c"][t], metabolite["dhap", "c"][t], metabolite["f6p", "c"][t], metabolite["fdp", "c"][t], metabolite["g6p", "c"][t], metabolite["gap", "c"][t], metabolite["glu", "c"][t], metabolite["h", "c"][t], metabolite["h2o", "c"][t], metabolite["lac", "c"][t], metabolite["nad", "c"][t], metabolite["nadh", "c"][t], metabolite["pep", "c"][t], metabolite["pg13", "c"][t], metabolite["pg2", "c"][t], metabolite["pg3", "c"][t], metabolite["phos", "c"][t], metabolite["pyr", "c"][t]}
	,
	TestID->"MASSmodelRelatedTests-20110511-S6Q4R5"
]
			
Test[(*Test Reactions accessor*)
	model["Reactions"]
	,
	expectedRxnList
	,
	TestID->"MASSmodelRelatedTests-20110511-H5H1Z7"
]

Test[(*Test Stoichiometry accessor*)
	model["Stoichiometry"]
	,
	expectedStoich
	,
	TestID->"MASSmodelRelatedTests-20110511-V3K8E3"
]

Test[
	Rationalize[L0[model]]
	,
	{{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0}, {0, -1, -1, -2, -1, -1, -2, -1, -1, -1, 0, 0, 0, 0, 0, 0, -1, -2}}
	,
	TestID->"MASSmodelRelatedTests-20120119-W9X4C1"
]

Test[
	Rationalize[Chop[L[model].SRed[model]]]
	,
	S[model]
	,
	TestID->"MASSmodelRelatedTests-20120119-T0F7M2"
]

Test[(*Test constructModel functionality*)
	modelFromReactionList = constructModel[expectedRxnList];
	Head[modelFromReactionList]
	,
	MASSmodel
	,
	TestID->"MASSmodelRelatedTests-20110511-Z0H9D4"
]

Test[(*Test if constructModel (from reactions) produces a qualitatively similar stoichiometry matrix as constructModel (from basic data types)*)
	Sort[modelFromReactionList["Stoichiometry"]]
	,
	Sort[model["Stoichiometry"]]
	,
	TestID->"MASSmodelRelatedTests-20110511-V6Q2N5"
]

Test[(*Test if reactionList2model produces a qualitatively similar compound list as constructModel*)
	Sort@modelFromReactionList["Species"]
	,
	Sort@model["Species"]
	,
	TestID->"MASSmodelRelatedTests-20110511-O8A7P4"
]

Test[(*Test if reactionList2model produces a qualitatively similar flux identifier list as constructModel*)
	Sort@modelFromReactionList["Fluxes"]
	,
	Sort@model["Fluxes"]
	,
	TestID->"MASSmodelRelatedTests-20110511-X9G9C8"
]

Test[
	modelTmp = model;
	Toolbox`Private`setModelAttribute[modelTmp, "ID", "NewID"];
	modelTmp["ID"]
	,
	"NewID"
	,
	TestID->"MASSmodelRelatedTests-20110511-T3X8Z0"
]

If[$VersionNumber > 7,
Test[
    modelTmp = model;
    CheckAbort[Toolbox`Private`setModelAttribute[modelTmp, "NonExistentAttribute", "Fake"], True]
    ,
    True
    ,
    {Toolbox`Private`setModelAttribute::wrongattr}
    ,
    TestID->"MASSmodelRelatedTests-20110511-Y6R7W3"
]
]


newReaction = 
 reaction["newReaction", {metabolite["atp", "c"], 
   metabolite["fictitious", "fic"]}, {metabolite["fictitious2", 
    "fic"]}, {1., 2., 3.}, True];

Test[(*Test adding reaction*)
	modelWithNewReaction = addReaction[model, newReaction];
	modelWithNewReaction["Reactions"][[-1]]
	,
	newReaction
	,
	TestID->"MASSmodelRelatedTests-20110511-T1U7C5"
]

Test[(*Undo reaction adding by deleting reaction*)
	And@@Thread[Equal[Sort@model["Reactions"],Sort@deleteReaction[modelWithNewReaction,getID[newReaction]]["Reactions"]]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20110511-H4J0B7"
]

newReactionIrrev = 
 reaction["newReaction", {metabolite["atp", "c"], 
   metabolite["fictitious", "fic"]}, {metabolite["fictitious2", 
    "fic"]}, {1., 2., 3.}, False];

Test[(*Test adding reaction*)
	modelWithNewReaction = addReaction[model, newReactionIrrev];
	modelWithNewReaction["Reactions"][[-1]]
	,
	newReactionIrrev
	,
	TestID->"MASSmodelRelatedTests-20110511-I0B6G5"
]

Test[(*Undo reaction adding by deleting reaction*)
    And@@Thread[Equal[Sort@model["Reactions"],Sort@deleteReaction[modelWithNewReaction,getID[newReactionIrrev]]["Reactions"]]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20110511-A1F5F7"
]

emptySetReaction = 
 reaction["emptySetReaction", {metabolite["fictitious", 
    "fic"]}, {}, {1.}, True];
    
Test[(*Test adding reaction*)
	modelWithNewReaction = addReaction[model, emptySetReaction];
	modelWithNewReaction["Reactions"][[-1]]
	,
	emptySetReaction
	,
	TestID->"MASSmodelRelatedTests-20110511-Q5S2R8"
]

Test[(*Undo reaction adding by deleting reaction*)
	And@@Thread[Equal[Sort@model["Reactions"],Sort@deleteReaction[modelWithNewReaction,getID[emptySetReaction]]["Reactions"]]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20110511-I1X1B5"
]

emptySetReactionIrrev = 
 reaction["emptySetReaction", {metabolite["fictitious", 
    "fic"]}, {}, {1.}, False];

Test[(*Test adding reaction*)
	modelWithNewReaction = addReaction[model, emptySetReactionIrrev];
	modelWithNewReaction["Reactions"][[-1]]
	,
	emptySetReactionIrrev
	,
	TestID->"MASSmodelRelatedTests-20110511-O6O6C0"
]

Test[(*Undo reaction adding by deleting reaction*)
	And@@Thread[Equal[Sort@model["Reactions"],Sort@deleteReaction[modelWithNewReaction,getID[emptySetReactionIrrev]]["Reactions"]]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20110511-C1M9N7"
]
    
emptySetReaction2 = 
 reaction["emptySetReaction2", {}, {metabolite["fictitious2", 
    "fic"]}, {1.}, True];

Test[(*Test adding reaction*)
	modelWithNewReaction = addReaction[model, emptySetReaction2];
	modelWithNewReaction["Reactions"][[-1]]
	,
	emptySetReaction2
	,
	TestID->"MASSmodelRelatedTests-20110511-C4L6Q3"
]

Test[(*Undo reaction adding by deleting reaction*)
	And@@Thread[Equal[Sort@model["Reactions"],Sort@deleteReaction[modelWithNewReaction,getID[emptySetReaction2]]["Reactions"]]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20110511-A3R7T4"
]
    
emptySetReaction2Irrev = 
 reaction["emptySetReaction2", {}, {metabolite["fictitious2", 
    "fic"]}, {1.}, True];

Test[(*Test adding reaction*)
	modelWithNewReaction = addReaction[model, emptySetReaction2Irrev];
	modelWithNewReaction["Reactions"][[-1]]
	,
	emptySetReaction2Irrev
	,
	TestID->"MASSmodelRelatedTests-20110511-Z3T5K9"
]

Test[(*Undo reaction adding by deleting reaction*)
	And@@Thread[Equal[Sort@model["Reactions"],Sort@deleteReaction[modelWithNewReaction,getID[emptySetReaction2Irrev]]["Reactions"]]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20110511-W1Y4D2"
]
    
testReactions = 
 Table[reaction[
   ToString@Unique["newReaction"], {metabolite["atp", "c"], 
    metabolite[ToString@Unique@"fictitious", "fic"]}, {metabolite[
     ToString@Unique@"fictitious2", "fic"]}, {1., 2., 3.}, 
   True], {10}];


Test[(*Test adding multiple reactions*)
	modelWithNewReactions = addReactions[model, testReactions];
	modelWithNewReactions["Reactions"][[-Length[testReactions];;]]
	,
	testReactions
	,
	TestID->"MASSmodelRelatedTests-20110511-Y6G5T6"
]

Test[(*Test undoing the addition of multiple reactions by deleting them*)
	And@@Thread[Equal[Sort@model["Reactions"],Sort@deleteReactions[modelWithNewReactions, getID /@ testReactions]["Reactions"]]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20110511-J3O8N3"
]

subModel1 = constructModel[model["Reactions"][[3;;5]]]
setID[subModel1, "subModel1"]
subModel2 = constructModel[model["Reactions"][[4;;]]]
setID[subModel2, "subModel2"]
subModel3 = constructModel[model["Reactions"][[1;;2]]]
setID[subModel3, "subModel3"]

Intersection[subModel1, subModel2]["ID"]
Test[
	Intersection[subModel1, subModel2]["ID"]
	,
	"subModel1 \[Intersection] subModel2"
	,
	TestID->"MASSmodelRelatedTests-20110525-L5N6D6"
]

Test[
	Intersection[subModel1, subModel2]["Reactions"]
	,
	{reaction["vald", {metabolite["fdp", "c"]}, {metabolite["dhap", "c"], metabolite["gap", "c"]}, {1, 1, 1}, True], reaction["vtpi", {metabolite["dhap", "c"]}, {metabolite["gap", "c"]}, {1, 1}, True]}
	,
	TestID->"MASSmodelRelatedTests-20110525-O1G2R9"
]

(*
Retired: it is now possible to have empty models (no reactions)
Test[
	CheckAbort[Intersection[subModel1, subModel3]["ID"],True]
	,
	True
	,
	{MASSmodel::empty}
	,
	TestID->"MASSmodelRelatedTests-20110525-Q5N3W9"
]

Test[
	CheckAbort[Intersection[subModel1, subModel2, subModel3]["ID"],True]
	,
	True
	,
	{MASSmodel::empty}
	,
	TestID->"MASSmodelRelatedTests-20110525-I0P0Z7"
]
*)

Test[
	Union[subModel1, subModel2]["ID"]
	,
	"subModel1 \[Union] subModel2"
	,
	TestID->"MASSmodelRelatedTests-20110525-N8S3H4"
]

Test[
	Sort@Union[subModel1, subModel2]["Reactions"]
	,
	Sort@model["Reactions"][[3;;]]
	,
	EquivalenceFunction-> (And@@Thread[Equal[#1, #2]]&)
	,
	TestID->"MASSmodelRelatedTests-20110525-O1M1D9"
]

Test[
	Sort@Union[subModel1, subModel2, subModel3]["Reactions"]
	,
	Sort@model["Reactions"]
	,
	EquivalenceFunction-> (And@@Thread[Equal[#1, #2]]&)
	,
	TestID->"MASSmodelRelatedTests-20110525-S1P0T1"
]

Test[
	Complement[subModel1, subModel2]["ID"]
	,
	"subModel1 \[Backslash] subModel2"
	,
	TestID->"MASSmodelRelatedTests-20111128-D9L3Y6"
]

Test[
	Complement[subModel1, subModel2, subModel3]["ID"]
	,
	"subModel1 \[Backslash] subModel2 \[Union] subModel3"
	,
	TestID->"MASSmodelRelatedTests-20111128-H6Q1V2"
]

Test[
	Complement[subModel3, subModel1, subModel2]["Reactions"]
	,
	subModel3["Reactions"]
	,
	TestID->"MASSmodelRelatedTests-20111128-R1I2J7"
]

pools = {"GP+" -> 2 m["dhap", "c"] + 3 m["f6p", "c"] + 4 m["fdp", "c"] + 3 m["g6p", "c"] + 2 m["gap", "c"] + 2 m["glu", "c"] + m["pep", "c"] + 2 m["pg13", "c"] + m["pg2", "c"] + m["pg3", "c"],
         "GP-" -> m["lac", "c"] + m["pyr", "c"], 
         "AP+" -> m["adp", "c"] + 2 m["atp", "c"],
         "AP-" -> m["adp", "c"] + 2 m["amp", "c"],
         "GR+" -> m["dhap", "c"] + 2 m["f6p", "c"] + 2 m["fdp", "c"] + 2 m["g6p", "c"] + m["gap", "c"] + 2 m["glu", "c"] + m["lac", "c"],
         "GR-" -> m["pep", "c"] + m["pg13", "c"] + m["pg2", "c"] + m["pg3", "c"] + m["pyr", "c"],
         "nadh" -> m["nadh", "c"],
         "P+" -> m["adp", "c"] + 2 m["atp", "c"] + m["dhap", "c"] + m["f6p", "c"] + 2 m["fdp", "c"] + m["g6p", "c"] + m["gap", "c"] + m["pg13", "c"],
         "P-" -> m["pep", "c"] + m["pg13", "c"] + m["pg2", "c"] + m["pg3", "c"],
         "Ptot" -> m["adp", "c"] + 2 m["atp", "c"] + m["dhap", "c"] + m["f6p", "c"] + 2 m["fdp", "c"] + m["g6p", "c"] + m["gap", "c"] + m["pep", "c"] + 2 m["pg13", "c"] + m["pg2", "c"] + m["pg3", "c"] + m["phos", "c"],
         "nadh-tot" -> m["nad", "c"] + m["nadh", "c"]
        };

Test[
	pools2poolMatrix[model,pools]
	,
	{{2, 3, 3, 4, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0}, {2, 2, 2, 2, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0}, {0, 1, 1, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0}, {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 1, 1, 2, 1, 1, 2, 1, 1, 1, 0, 0, 0, 0, 0, 2, 1, 0, 1, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0}}
	,
	TestID->"MASSmodelRelatedTests-20120716-S7J8W6"
]

Test[
	Thread[pools[[All, 2]] == pools2poolMatrix[model, pools].model["Species"]]
	,
	True
	,
	TestID->"MASSmodelRelatedTests-20120716-T1I8P4"
]


(*ecolicore=Import["Models/EcoliCore.m.gz"];
Test[
	splitReversible[ecolicore]
	,
	result
	,
	TestID->"MASSmodelRelatedTests-20120502-X3N0I4"
]*)
