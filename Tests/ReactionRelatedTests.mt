(* Mathematica Test File *)

(*Print[StringJoin[Sequence@@Riffle[(ToExpression[#<>"::usage"]& /@ (ToString/@Names["MUnit`*"])),"\n"]]]*)

testRxn = reaction["ID", {metabolite["ATP", "C"]}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {1, 2., 1/2}];
testRxnIrrev = reaction["ID", {metabolite["ATP", "C"]}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {1, 2., 1/2}, False];
testRxnSink = reaction["ID", {}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {2., 1/2}];
testRxnSink2 = reaction["ID", {metabolite["ATP", "C"]}, {}, {1}];

(* Test if correct messages are raised when the arguments to reaction are not consistent. Check also if Abort[] was triggered*)

Test[
	makeIrreversible[testRxn]
	,
	testRxnIrrev
	,
	TestID->"ReactionRelatedTests-20120822-K3K3T8"
]

Test[
    makeReversible[testRxnIrrev]
    ,
    testRxn
    ,
    TestID->"ReactionRelatedTests-20130103-V0O2D6"
]

Test[
	r["ID", {metabolite["ATP", "C"]}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {1, 2., 1/2}]
	,
	testRxn
	,
	TestID->"ReactionRelatedTests-20120119-G9X2W2"
]

If[$VersionNumber > 7,
Test[(*Too many stoichiometric factors*)
	CheckAbort[reaction["ID", {metabolite["ATP", "C"]}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {1, 2., 1/2, 3}];, True]
	,
	True
	,
	{reaction::arglen}
	,
	TestID->"ReactionRelatedTests-20110511-P6N5S8"
]
]

If[$VersionNumber > 7,
Test[(*Negative stoichiometric factors*)
	CheckAbort[reaction["ID", {metabolite["ATP", "C"]}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {-2., 1, 3}];, True]
	,
	True
	,
	{reaction::negativestoich}
	,
	TestID->"ReactionRelatedTests-20130103-O5H5W2"
]
]

If[$VersionNumber > 7,
Test[(*Not enough stoichiometric factors*)
	CheckAbort[reaction["ID", {metabolite["ATP", "C"]}, {metabolite["Pi", "C"]}, {1}];, True]
	,
	True
	,
	{reaction::arglen}
	,
	TestID->"ReactionRelatedTests-20110511-X7Z1H0"
]
]

If[$VersionNumber,
Test[(*Not enough stoichiometric factors*)
	CheckAbort[reaction["ID", {metabolite["ATP", "C"], metabolite["ATP", "C"]}, {metabolite["Pi", "C"]}, {1, 2, 3}];, True]
	,
	True
	,
	{reaction::unique}
	,
	TestID->"ReactionRelatedTests-20110511-H9T2P1"
]
]

 (* Test accessor functions*)
Test[
	getID[testRxn]
	,
	"ID"
	,
	TestID->"ReactionRelatedTests-20110510-C9X7K5"
]

Test[
	getCompounds[testRxn]
	,
	{metabolite["ATP", "C"], metabolite["ADP", "C"], metabolite["Pi", "C"]}
	,
	TestID->"ReactionRelatedTests-20110511-L0N0N6"
]

Test[
	getCompounds[testRxnSink]
	,
	{metabolite["ADP", "C"], metabolite["Pi", "C"]}
	,
	TestID->"ReactionRelatedTests-20110511-D8H5E2"
]

Test[
	getCompounds[testRxnSink2]
	,
	{metabolite["ATP", "C"]}
	,
	TestID->"ReactionRelatedTests-20110511-D9P6Q3"
]

Test[
	{reversibleQ[testRxnIrrev], reversibleQ[testRxn]}
	,
	{False, True}
	,
	TestID->"ReactionRelatedTests-20110511-Q7R7I9"
]

Test[
	getSubstrates[testRxn]
	,
	{metabolite["ATP", "C"]}
	,
	TestID->"ReactionRelatedTests-20110511-O7F0J4"
]

Test[
	getSubstrates[testRxnSink]
	,
	{}
	,
	TestID->"ReactionRelatedTests-20110511-H5G4N2"
]

Test[
	getSubstrates[testRxnSink2]
	,
	{metabolite["ATP", "C"]}
	,
	TestID->"ReactionRelatedTests-20110511-B6B5B6"
]

Test[
	getProducts[testRxn]
	,
	{metabolite["ADP", "C"], metabolite["Pi", "C"]}
	,
	TestID->"ReactionRelatedTests-20110511-R4P7J6"
]

Test[
	getStoichiometry[testRxn]
	,
	{1, 2., 1/2}
	,
	TestID->"ReactionRelatedTests-20110511-Y7P2R4"
]

Test[
	getSubstrStoich[testRxn]
	,
	{1}
	,
	TestID->"ReactionRelatedTests-20110511-Q8J8V5"
]

Test[
	getProdStoich[testRxn]
	,
	{2., 1/2}
	,
	TestID->"ReactionRelatedTests-20110511-H6P0K3"
]

Test[
	reaction["ID", {metabolite["ATP", "C"]}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {1, 2., 1/2}] == reaction["ID", {metabolite["ATP", "C"]}, {metabolite["Pi", "C"], metabolite["ADP", "C"]}, {1, .5, 2}]
	,
	True
	,
	TestID->"ReactionRelatedTests-20110525-O3E6X4"
]

Test[
	reaction["test",{metabolite["a","c"],metabolite["b","c"]},{metabolite["c","c"]},{2,1,1}] == reaction["test",{metabolite["b","c"],metabolite["a","c"]},{metabolite["c","c"]},{1,2,1}]
	,
	True
	,
	TestID->"ReactionRelatedTests-20110525-E5O7E1"
]

Test[
	reaction["test",{metabolite["a","c"],metabolite["b","c"]},{metabolite["c","c"]},{2,1,1}] == reaction["test",{metabolite["b","c"],metabolite["a","c"]},{metabolite["c","c"]},{2,1,1}]
	,
	False
	,
	TestID->"ReactionRelatedTests-20110608-R5X0F3"
]

Test[
	getCompartment[reaction["test",{metabolite["a","cytosol"],metabolite["b","cytosol"]},{metabolite["c","cytosol"]},{2,1,1}]]
	,
	"cytosol"
	,
	TestID->"ReactionRelatedTests-20110907-M6B9S9"
]


Test[
	getCompartment[reaction["test",{metabolite["a","cytosol"],metabolite["b","mitochondrium"]},{metabolite["c","cytosol"]},{2,1,1}]]
	,
	{"cytosol", "mitochondrium"}
	,
	TestID->"ReactionRelatedTests-20110907-B0N7L1"
]

Test[
	reactionQ[reaction["test",{metabolite["a","cytosol"],metabolite["b","mitochondrium"]},{metabolite["c","cytosol"]},{2,1,1}]]
	,
	True
	,
	TestID->"ReactionRelatedTests-20110907-I0Q2C4"
]

Test[
	reactionQ[notAreaction[1.]]
	,
	False
	,
	TestID->"ReactionRelatedTests-20110907-A5J7S3"
]
