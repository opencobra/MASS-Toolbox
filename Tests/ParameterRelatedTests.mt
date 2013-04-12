(* Mathematica Test File *)

testKeq = Keq["vtpi"]
testRateConstFwd = rateconst["vtpi", True]
testArbitraryParam = parameter["Special"]
testArbitraryParam2 = parameter["Special", "vtpi"]

Test[
	getID[testKeq]
	,
	"vtpi"
	,
	TestID->"ParameterRelatedTests-20110613-G2X6L0"
]

Test[
	getID[testRateConstFwd]
	,
	"vtpi"
	,
	TestID->"ParameterRelatedTests-20110613-Z2F2Y2"
]

Test[
	getID[testArbitraryParam2]
	,
	{"Special", "vtpi"}
	,
	TestID->"ParameterRelatedTests-20110907-A1K4O5"
]

Test[
	getID[testArbitraryParam]
	,
	"Special"
	,
	TestID->"ParameterRelatedTests-20110907-V5Y7O0"
]

Test[
	k2keq[rateconst["test", False]]
	,
	rateconst["test", True]/Keq["test"]
	,
	TestID->"ParameterRelatedTests-20120119-H9Z0T3"
]

Test[
	kRev2keq[rateconst["test", False]] == k2keq[rateconst["test", False]]
	,
	True
	,
	TestID->"ParameterRelatedTests-20120119-E2D2T5"
]


Test[
	kFwd2keq[rateconst["test", True]]
	,
	Keq["test"]*rateconst["test", False]
	,
	TestID->"ParameterRelatedTests-20120119-Y7J5H3"
]


Test[
	keq2k[Keq["test"]]
	,
	rateconst["test", True]/rateconst["test", False]
	,
	TestID->"ParameterRelatedTests-20120119-R0U4D8"
]

Test[
	Sort@complementParameters[{Keq["vhk"] -> 850, Keq["vpgi"] -> 0.41, Keq["vpfk"] -> 310, Keq["vtpi"] -> 0.05714285714285714, Keq["vald"] -> 0.082, Keq["vgapdh"] -> 0.0179, Keq["vpgk"] -> 1800, Keq["vpglm"] -> 0.14705882352941177, Keq["veno"] -> 1.6949152542372883, 
 Keq["vpk"] -> 363000, Keq["vldh"] -> 26300, Keq["vamp"] -> Infinity, Keq["vapk"] -> 1.65, Keq["vpyr"] -> 1., Keq["vlac"] -> 1., Keq["vatp"] -> Infinity, Keq["vnadh"] -> Infinity, Keq["vgluin"] -> Infinity, Keq["vampin"] -> Infinity, Keq["vh"] -> 1., 
 Keq["vh2o"] -> 1., metabolite["pyr", "Xt"] -> 0.06, metabolite["amp", "Xt"] -> 1, metabolite["h", "Xt"] -> 0.00006309573444801929, metabolite[_, "Xt"] -> 1, rateconst["vhk", True] -> 0.7000072543398843, rateconst["vpgi", True] -> 3644.444444444491, 
 rateconst["vpfk", True] -> 35.36878374779938, rateconst["vtpi", True] -> 34.35582822085891, rateconst["vald", True] -> 2834.567901234576, rateconst["vgapdh", True] -> 3376.7492421768247, rateconst["vpgk", True] -> 1.2735312697410057*^6, 
 rateconst["vpglm", True] -> 4869.565217391283, rateconst["veno", True] -> 1763.7795275590574, rateconst["vpk", True] -> 454.38555191136817, rateconst["vldh", True] -> 1112.573988602781, rateconst["vamp", True] -> 0.16142399019925777, 
 rateconst["vapk", True] -> 100000, rateconst["vpyr", True] -> 744.1860465116215, rateconst["vlac", True] -> 5.599999999999999, rateconst["vatp", True] -> 1.4000000000000001, rateconst["vnadh", True] -> 7.44186046511628, 
 rateconst["vgluin", True] -> 1.12, rateconst["vampin", True] -> 0.014, rateconst["vh", True] -> 100000.00000000001, rateconst["vh2o", True] -> 100000}]
	,
    {Keq["vald"] -> 0.082, Keq["vamp"] -> Infinity, Keq["vampin"] -> Infinity, Keq["vapk"] -> 1.65, Keq["vatp"] -> Infinity, Keq["veno"] -> 1.6949152542372883, Keq["vgapdh"] -> 0.0179, Keq["vgluin"] -> Infinity, Keq["vh"] -> 1., Keq["vh2o"] -> 1., Keq["vhk"] -> 850, Keq["vlac"] -> 1., Keq["vldh"] -> 26300, Keq["vnadh"] -> Infinity, Keq["vpfk"] -> 310, Keq["vpgi"] -> 0.41, Keq["vpgk"] -> 1800, Keq["vpglm"] -> 0.14705882352941177, Keq["vpk"] -> 363000, Keq["vpyr"] -> 1., Keq["vtpi"] -> 0.05714285714285714, metabolite["amp", "Xt"] -> 1, metabolite["h", "Xt"] -> 0.00006309573444801929, metabolite["pyr", "Xt"] -> 0.06, metabolite[_, "Xt"] -> 1, rateconst["vald", False] -> 34567.901234568, rateconst["vald", True] -> 2834.567901234576, rateconst["vamp", False] -> 0., rateconst["vamp", True] -> 0.16142399019925777, rateconst["vampin", False] -> 0., rateconst["vampin", True] -> 0.014, rateconst["vapk", False] -> 60606.06060606061, rateconst["vapk", True] -> 100000, rateconst["vatp", False] -> 0., rateconst["vatp", True] -> 1.4000000000000001, rateconst["veno", False] -> 1040.6299212598437, rateconst["veno", True] -> 1763.7795275590574, rateconst["vgapdh", False] -> 188645.2090601578, rateconst["vgapdh", True] -> 3376.7492421768247, rateconst["vgluin", False] -> 0., rateconst["vgluin", True] -> 1.12, rateconst["vh", False] -> 100000.00000000001, rateconst["vh", True] -> 100000.00000000001, rateconst["vh2o", False] -> 100000., rateconst["vh2o", True] -> 100000, rateconst["vhk", False] -> 0.0008235379462822168, rateconst["vhk", True] -> 0.7000072543398843, rateconst["vlac", False] -> 5.599999999999999, rateconst["vlac", True] -> 5.599999999999999, rateconst["vldh", False] -> 0.04230319348299547, rateconst["vldh", True] -> 1112.573988602781, rateconst["vnadh", False] -> 0., rateconst["vnadh", True] -> 7.44186046511628, rateconst["vpfk", False] -> 0.11409285079935283, rateconst["vpfk", True] -> 35.36878374779938, rateconst["vpgi", False] -> 8888.888888889003, rateconst["vpgi", True] -> 3644.444444444491, rateconst["vpgk", False] -> 707.5173720783365, rateconst["vpgk", True] -> 1.2735312697410057*^6, rateconst["vpglm", False] -> 33113.043478260726, rateconst["vpglm", True] -> 4869.565217391283, rateconst["vpk", False] -> 0.001251750831711758, rateconst["vpk", True] -> 454.38555191136817, rateconst["vpyr", False] -> 744.1860465116215, rateconst["vpyr", True] -> 744.1860465116215, rateconst["vtpi", False] -> 601.226993865031, rateconst["vtpi", True] -> 34.35582822085891}
	,
	TestID->"ParameterRelatedTests-20120502-B3L3V8", EquivalenceFunction -> Equal
]