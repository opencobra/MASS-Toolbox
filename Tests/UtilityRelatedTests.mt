(* Mathematica Test File *)

testRxn = reaction["test", List[metabolite["atp", "c"]], List[metabolite["adp", "c"], metabolite["amp", "periplasm"]], List[1, 1, 2]];
testRxn1 = r["test", {m["atp", "c"]}, {m["adp", "c"], m["amp", "periplasm"]}, {1,1,2}, False]
testRxnSink = reaction["ID", {}, {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {2., 1/2}];
testRxnSink2 = reaction["ID", {}, {metabolite["ATP", "C"]}, {1}];

Test[
	str2mass["k_fba_fwd"]
	,
	rateconst["fba", True]
	,
	TestID->"UtilityRelatedTests-20120119-M7N1E4"
]

Test[
	str2mass["Keq_fba"]
	,
	Keq["fba"]
	,
	TestID->"UtilityRelatedTests-20120119-M1C4P9"
]

Test[
	str2mass["atp_c"]
	,
	m["atp", "c"]
	,
	TestID->"UtilityRelatedTests-20120119-D2E3O3"
]

Test[
	str2mass["test: atp_c <=> adp_c + 2 amp_perisplasm"]
	,
	reaction["test", {metabolite["atp", "c"]}, {metabolite["adp", "c"], metabolite["amp", "perisplasm"]}, {1, 1, 2}, True]
	,
	TestID->"UtilityRelatedTests-20120119-G5B1K0"
]

Test[
	str2mass["test: atp_c --> adp_c + 2 amp_perisplasm"]
	,
	reaction["test", {metabolite["atp", "c"]}, {metabolite["adp", "c"], metabolite["amp", "perisplasm"]}, {1, 1, 2}, False]
	,
	TestID->"UtilityRelatedTests-20120119-G4F4N7"
]

Test[
	str2mass["ID: 2 ADP_C + .5 Pi_C <=> 0"]
	,
	reaction["ID", {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {}, {2, 0.5}, True]
	,
	TestID->"UtilityRelatedTests-20120119-W1K8E7"
]

Test[
	str2mass["ID: 2 A + 0.5 A <=> 1/3 B"]
	,
	reaction["ID", {m["A"]}, {m["B"]}, {2.5, N[1/3]}, True]
	,
	TestID->"UtilityRelatedTests-20130822-P0R3E8"
]

Test[
	str2mass["ID: 2 ADP_C + 1/2 Pi_C <=> 0"]
	,
	reaction["ID", {metabolite["ADP", "C"], metabolite["Pi", "C"]}, {}, {2, 1/2}, True]
	,
	TestID->"UtilityRelatedTests-20120312-S0H5L0"
]

Test[
	str2mass["ID: 2 ADP + 1/2 Pi_C <=> 0"]
	,
	reaction["ID", {metabolite["ADP", None], metabolite["Pi", "C"]}, {}, {2, 1/2}, True]
	,
	TestID->"UtilityRelatedTests-20120312-L6E0S5"
]

Test[
	str2mass["ID: 0 <=> ATP_C"]
	,
	reaction["ID", {}, {metabolite["ATP", "C"]}, {1}, True]
	,
	TestID->"UtilityRelatedTests-20120119-D2A3B5"
]

Test[
	str2mass["ID: 0 <=> ATP"]
	,
	reaction["ID", {}, {metabolite["ATP", None]}, {1}, True]
	,
	TestID->"UtilityRelatedTests-20120312-K1U0N0"
]

Test[
	Sort@updateRules[{1->3, 4->5}, {1->666}]
	,
	{1->666, 4->5}
	,
	TestID->"UtilityRelatedTests-20110907-X3U5C1"
]

Test[
	Sort@updateRules[{1->3, 4->5}, {}]
	,
	{1->3, 4->5}
	,
	TestID->"UtilityRelatedTests-20110907-H5E0H1"
]

Test[
	Sort@updateRules[{}, {1->"a", 4->83.88}]
	,
	{1->"a", 4->83.88}
	,
	TestID->"UtilityRelatedTests-20110907-M0V4Y2"
]

Test[
	Sort@updateRules[{}, {}]
	,
	{}
	,
	TestID->"UtilityRelatedTests-20110907-P8X3R7"
]

Test[
	updateRules[{1. -> 4.}, {}]
	,
	{1. -> 4.}
	,
	TestID->"UtilityRelatedTests-20110907-E1A5M4"
]

Test[
	updateRules[{}, {}, {}]
	,
	{}
	,
	TestID->"UtilityRelatedTests-20111201-M2J7D9"
]

Test[
	updateRules[{1 -> 2}, {3 -> 4, 1 -> 3}, {1 -> 4, 5 ->6}]
	,
	{3 -> 4, 1 -> 4, 5 -> 6}
	,
	TestID->"UtilityRelatedTests-20111201-A5P8S5"
]

Test[
	str2mass["k_vtpi_fwd"]
	,
	rateconst["vtpi", True]
	,
	TestID->"UtilityRelatedTests-20110907-U2N3R4"
]

Test[
	str2mass["k_vtpi_multiUnderScore_rev"]
	,
	rateconst["vtpi_multiUnderScore", False]
	,
	TestID->"UtilityRelatedTests-20110907-S7J3Z3"
]

Test[
	str2mass["k_2_dr-Y_fwd"]
	,
	rateconst["2_dr-Y",True]
	,
	TestID->"UtilityRelatedTests-20110907-G1B9T2"
]

Test[
	str2mass["Keq_2_dr-Y_fwd"]
	,
	Keq["2_dr-Y_fwd"]
	,
	TestID->"UtilityRelatedTests-20110907-A6M3W3"
]

(*Test[
	Symbol@makeConform["2_dr-Y(e)"]
	,
	$2\[UnderBracket]dr\[OverBracket]Y\[LeftGuillemet]e\[RightGuillemet]
	,
	TestID->"UtilityRelatedTests-20110907-Q6K5T2"
]

Test[
	undoMakeConform[ToString[Symbol@makeConform["2_dr-Y(e)"]]]
	,
	"2_dr-Y(e)"
	,
	TestID->"UtilityRelatedTests-20110907-H5B8T4"
]*)

