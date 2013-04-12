(* Mathematica Test File *)

Needs["Toolbox`"]

Test[
	elementalComposition2formula[{"C" -> 10, "H" -> 16, "N" -> 1, "O" -> 13, "P" -> 3}]
	,
	"H16C10NO13P3"
	,
	TestID->"ChemoInformaticsRelatedTests-20110914-E8N4Z6"
]

(*Test correct treatment of pseudo elements*)
Test[
	elementalComposition2formula[{"C" -> 10, "H" -> 16, "N" -> 1, "O" -> 13, "P" -> 3, "NAD" -> 2}]
	,
	"H16C10NO13P3&NAD&2"
	,
	TestID->"ChemoInformaticsRelatedTests-20110914-K6Q4V3"
]

(*Test that compounds like H2O are treated correctly*)
Test[
	elementalComposition2formula[{"H" -> 2, "O" -> 1}]
	,
	"H2O"
	,
	TestID->"ChemoInformaticsRelatedTests-20110914-Y5B9V8"
]

Test[
	formula2elementalComposition["P3C10H16N1O13"]
	,
	10*"C" + 16*"H" + "N" + 13*"O" + 3*"P"
	,
	TestID->"ChemoInformaticsRelatedTests-20110914-O5G7W5"
]

(*Test that pseudo elements are treated correctly*)
Test[
	formula2elementalComposition["H16C10NO13P3&NAD&&Bl&3"]
	,
	3*"&Bl&" + 10*"C" + 16*"H" + "N" + "&NAD&" + 13*"O" + 3*"P"
	,
	TestID->"ChemoInformaticsRelatedTests-20110914-W6Y5D4"
]

Test[
	elementalComposition2formula[10 "C"+13 "H"+5 "N"+10 "O"+2 "P"]
	,
	"H13C10N5O10P2"
	,
	TestID->"ChemoInformaticsRelatedTests-20120213-F0M4T1"
]

Test[
	elementalComposition2formula["H"+ 3 "NAD"]
	,
	"H&NAD&3"
	,
	TestID->"ChemoInformaticsRelatedTests-20120213-Z7N8V2"
]

Test[
	elementalComposition2formula["H"]
	,
	"H"
	,
	TestID->"ChemoInformaticsRelatedTests-20120213-M7K5P1"
]

Test[
	elementalComposition2formula[2 "NAD"]
	,
	"&NAD&2"
	,
	TestID->"ChemoInformaticsRelatedTests-20120213-U7P0U2"
]


