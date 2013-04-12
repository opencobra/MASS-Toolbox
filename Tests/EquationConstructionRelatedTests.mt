(* Mathematica Test File *)

testRate = rateconst["vldh",True] * metabolite["h","c"] * metabolite["nadh","c"] * metabolite["pyr","c"] - rateconst["vldh", False] * metabolite["lac", "c"] * metabolite["nad", "c"]

Test[
	k2keq[testRate]
	,
	(-((metabolite["lac", "c"]*metabolite["nad", "c"])/Keq["vldh"]) + metabolite["h", "c"]*metabolite["nadh", "c"]*metabolite["pyr", "c"])*rateconst["vldh", True]
	,
	TestID->"EquationConstructionRelated-20110613-U2L4D6"
]

Test[
	kFwd2keq[testRate]
	,
	(-(metabolite["lac", "c"]*metabolite["nad", "c"]) + Keq["vldh"]*metabolite["h", "c"]*metabolite["nadh", "c"]*metabolite["pyr", "c"])*rateconst["vldh", False]
	,
	TestID->"EquationConstructionRelated-20110613-F7G0B2"
]

Test[
	keq2k[testRate]
	,
	testRate
	,
	TestID->"EquationConstructionRelated-20110613-A3O8W6"
]

Test[
	keq2k[kFwd2keq[testRate]]
	,
	testRate
	,
	TestID->"EquationConstructionRelated-20110613-A8X2D9"
]

Test[
	keq2k[k2keq[testRate]]
	,
	testRate
	,
	TestID->"EquationConstructionRelated-20110613-P5S6K9"
]


hbModel=constructModel["Hb Module",
Normal@SparseArray[{{1,1}->1,{1,2}->-1,{1,7}->-1,{2,3}->-1,{2,4}->-1,{2,5}->-1,{2,6}->-1,{2,8}->-1,{3,3}->-1,{3,7}->-1,{4,3}->1,{4,4}->-1,{5,4}->1,{5,5}->-1,{6,5}->1,{6,6}->-1,{7,6}->1,{8,7}->1}],
{metabolite["dpg23","c"],metabolite["o2","c"],metabolite["hb","c"],metabolite["hbo2","c"],metabolite["hbo22","c"],metabolite["hbo23","c"],metabolite["hbo24","c"],metabolite["dhb","c"]},
{"vdpgm","vdpgase","vhbo1","vhbo2","vhbo3","vhbo4","vhbdpg","vo2"}
];

Test[
	Toolbox`Private`makeRates[hbModel]
	,
	{parameter["Volume", "c"]*rateconst["vdpgm", True]*(metabolite["dpg23", "Xt"] - metabolite["dpg23", "c"][t]/Keq["vdpgm"]), parameter["Volume", "c"]*rateconst["vdpgase", True]*(-(metabolite["dpg23", "Xt"]/Keq["vdpgase"]) + metabolite["dpg23", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo1", True]*(-(metabolite["hbo2", "c"][t]/Keq["vhbo1"]) + metabolite["hb", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo2", True]*(-(metabolite["hbo22", "c"][t]/Keq["vhbo2"]) + metabolite["hbo2", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo3", True]*(-(metabolite["hbo23", "c"][t]/Keq["vhbo3"]) + metabolite["hbo22", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo4", True]*(-(metabolite["hbo24", "c"][t]/Keq["vhbo4"]) + metabolite["hbo23", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbdpg", True]*(-(metabolite["dhb", "c"][t]/Keq["vhbdpg"]) + metabolite["dpg23", "c"][t]*metabolite["hb", "c"][t]), parameter["Volume", "c"]*rateconst["vo2", True]*(-(metabolite["o2", "Xt"]/Keq["vo2"]) + metabolite["o2", "c"][t])}
	,
	TestID->"EquationConstructionRelatedTests-20110615-B6H8C8"
]

testData = {rateconst["vhbo3",False]->0.133665,rateconst["vo2",False]->0.669803,rateconst["vhbo4",False]->0.750582,rateconst["vdpgase",False]->0.546027,rateconst["vdpgm",False]->0.732108,Keq["vdpgm"]->Infinity,Keq["vo2"]->1.,Keq["vhbo3"]->178.,Keq["vdpgase"]->Infinity,Keq["vhbdpg"]->0.25}

Test[
	getRates[hbModel, Parameters -> testData]
	,
	{parameter["Volume", "c"]*rateconst["vdpgm", False]*(Keq["vdpgm"]*metabolite["dpg23", "Xt"] - metabolite["dpg23", "c"][t]), parameter["Volume", "c"]*rateconst["vdpgase", False]*(-metabolite["dpg23", "Xt"] + Keq["vdpgase"]*metabolite["dpg23", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo1", True]*(-(metabolite["hbo2", "c"][t]/Keq["vhbo1"]) + metabolite["hb", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo2", True]*(-(metabolite["hbo22", "c"][t]/Keq["vhbo2"]) + metabolite["hbo2", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo3", False]*(-metabolite["hbo23", "c"][t] + Keq["vhbo3"]*metabolite["hbo22", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbo4", False]*(-metabolite["hbo24", "c"][t] + Keq["vhbo4"]*metabolite["hbo23", "c"][t]*metabolite["o2", "c"][t]), parameter["Volume", "c"]*rateconst["vhbdpg", True]*(-(metabolite["dhb", "c"][t]/Keq["vhbdpg"]) + metabolite["dpg23", "c"][t]*metabolite["hb", "c"][t]), parameter["Volume", "c"]*rateconst["vo2", False]*(-metabolite["o2", "Xt"] + Keq["vo2"]*metabolite["o2", "c"][t])}
	,
	TestID->"EquationConstructionRelatedTests-20110615-V1P9K7"
]

Test[
	getGradient[hbModel]
	,
	{{-((parameter["Volume", "c"]*rateconst["vdpgm", True])/Keq["vdpgm"]), 0, 0, 0, 0, 0, 0, 0}, {parameter["Volume", "c"]*rateconst["vdpgase", True], 0, 0, 0, 0, 0, 0, 0}, {0, metabolite["hb", "c"]*parameter["Volume", "c"]*rateconst["vhbo1", True], metabolite["o2", "c"]*parameter["Volume", "c"]*rateconst["vhbo1", True], -((parameter["Volume", "c"]*rateconst["vhbo1", True])/Keq["vhbo1"]), 0, 0, 0, 0}, {0, metabolite["hbo2", "c"]*parameter["Volume", "c"]*rateconst["vhbo2", True], 0, metabolite["o2", "c"]*parameter["Volume", "c"]*rateconst["vhbo2", True], -((parameter["Volume", "c"]*rateconst["vhbo2", True])/Keq["vhbo2"]), 0, 0, 0}, {0, metabolite["hbo22", "c"]*parameter["Volume", "c"]*rateconst["vhbo3", True], 0, 0, metabolite["o2", "c"]*parameter["Volume", "c"]*rateconst["vhbo3", True], -((parameter["Volume", "c"]*rateconst["vhbo3", True])/Keq["vhbo3"]), 0, 0}, {0, metabolite["hbo23", "c"]*parameter["Volume", "c"]*rateconst["vhbo4", True], 0, 0, 0, metabolite["o2", "c"]*parameter["Volume", "c"]*rateconst["vhbo4", True], -((parameter["Volume", "c"]*rateconst["vhbo4", True])/Keq["vhbo4"]), 0}, {metabolite["hb", "c"]*parameter["Volume", "c"]*rateconst["vhbdpg", True], 0, metabolite["dpg23", "c"]*parameter["Volume", "c"]*rateconst["vhbdpg", True], 0, 0, 0, 0, -((parameter["Volume", "c"]*rateconst["vhbdpg", True])/Keq["vhbdpg"])}, {0, parameter["Volume", "c"]*rateconst["vo2", True], 0, 0, 0, 0, 0, 0}}
	,
	TestID->"EquationConstructionRelatedTests-20110926-D5C1A8"
]

Test[
	getJacobian[hbModel]
	,
	hbModel["Stoichiometry"].getGradient[hbModel]
	,
	TestID->"EquationConstructionRelatedTests-20110926-O6L3J7"
]
