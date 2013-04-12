(* Mathematica Test File *)

testMetabolite = metabolite["ATP", "Cytosol"]

Test[
	getID[testMetabolite]
	,
	"ATP"
	,
	TestID->"MetaboliteRelatedTests-20110613-A2C9H4"
]

Test[
	(*getCompartment[testMetabolite]*)
	getCompartment[testMetabolite]
	,
	"Cytosol"
	,
	TestID->"MetaboliteRelatedTests-20110613-V5O3F2"
]

Test[
	ToString[testMetabolite]
	,
	"ATP[Cytosol]"
	,
	TestID->"MetaboliteRelatedTests-20110613-A5B7Y5"
]