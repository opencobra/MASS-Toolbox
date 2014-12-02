(* Mathematica Test File *)

testRxns=str2mass/@{"rxn1: a + b <-> c + d","rxn2: a + b <-> c","rxn3: a <-> b + c","rxn4: a <-> 0","rxn5: 0 <-> a",
"cmprt_rxn1: a_c + b_c <-> c_c + d_c","cmprt_rxn2: a_c + b_c <-> c_c","cmprt_rxn3: a_c <-> b_c + c_c","cmprt_rxn4: a_c <-> 0","cmprt_rxn5: 0 <-> a_c",
"trans1: a_c <=> a_e","trans2: a_c + b_d <=> a_e + 3.3 e_c","trans3: 0 <=> a_e + 3.3 e_c","cmprt_rxn_weird: a_c + b_c <-> c_c + 3.3 d_c"};

model=constructModel[testRxns,UnitChecking->True];

cmpds=Union[Flatten[getSpecies/@testRxns]];

metricPrefixes=Join[Sequence@@Table[{1,Milli,Micro,Pico,Femto,Giga,Tera,Yotta},{3}]]
conc=MapIndexed[#->metricPrefixes[[First@#2]]Mole Liter^-1&,cmpds];

param=Join[Keq[getID[#]]->1&/@testRxns,rateconst[getID[#]]->1&/@testRxns,rateconst[getID[#],False]->1&/@testRxns]

rates=stripTime@model["Rates"];


Test[
	adjustUnits[conc]
	,
	{metabolite["a", "c"] -> Unit[1000, "Millimole"/"Liter"], metabolite["a", "e"] -> Unit[1, "Millimole"/"Liter"], metabolite["a", None] -> Unit[1/1000, "Millimole"/"Liter"], metabolite["b", "c"] -> Unit[1/1000000000, "Millimole"/"Liter"], metabolite["b", "d"] -> Unit[1/1000000000000, "Millimole"/"Liter"], metabolite["b", None] -> Unit[1000000000000, "Millimole"/"Liter"], metabolite["c", "c"] -> Unit[1000000000000000, "Millimole"/"Liter"], metabolite["c", None] -> Unit[1000000000000000000000000000, "Millimole"/"Liter"], metabolite["d", "c"] -> Unit[1000, "Millimole"/"Liter"], metabolite["d", None] -> Unit[1, "Millimole"/"Liter"], metabolite["e", "c"] -> Unit[1/1000, "Millimole"/"Liter"]}
	,
	TestID->"UnitCheckingRelatedTests-20120822-X4U4H1"
]

Test[
    adjustUnits[{m["atp","c"] -> Pico Mole (Centi Meter)^-1}]
    ,
    {metabolite["atp", "c"] -> Unit[1/10000000, "Millimole"/"Meter"]}
    ,
    TestID->"UnitCheckingRelatedTests-20120927-G1X3U0"
]

Test[
    adjustUnits[{m["atp","c"] -> Pico Mole (Centi Meter)^-2}]
    ,
    {metabolite["atp", "c"] -> Unit[1/100000, "Millimole"/"Meter"^2]}
    ,
    TestID->"UnitCheckingRelatedTests-20120927-E8P5U8"
]

Test[
    adjustUnits[{m["atp","c"] -> Pico Mole Feet^-3}]
    ,
    {metabolite["atp", "c"] -> Unit[1/28316846592, "Millimole"/"Liter"]}
    ,
    TestID->"UnitCheckingRelatedTests-20120927-E8P5U8"
]

Test[
	Quiet[adjustUnits[param, testRxns],{adjustUnits::noUnitsProvidedKeq,adjustUnits::noUnitsProvidedRateConst}]
	,
	{Keq["rxn1"] -> 1, Keq["rxn2"] -> Unit[1, "Liter"/"Millimole"], Keq["rxn3"] -> Unit[1, "Millimole"/"Liter"], Keq["rxn4"] -> 1, Keq["rxn5"] -> 1, Keq["cmprt_rxn1"] -> 1, Keq["cmprt_rxn2"] -> Unit[1, "Liter"/"Millimole"], Keq["cmprt_rxn3"] -> Unit[1, "Millimole"/"Liter"], Keq["cmprt_rxn4"] -> 1, Keq["cmprt_rxn5"] -> 1, Keq["trans1"] -> 1, Keq["trans2"] -> Unit[1., "Millimole"^2.3/"Liter"^2.3], Keq["trans3"] -> 1, Keq["cmprt_rxn_weird"] -> Unit[1., "Millimole"^2.3/"Liter"^2.3], rateconst["rxn1", True] -> Unit[1, "Liter"^2/("Hour"*"Millimole")], rateconst["rxn2", True] -> Unit[1, "Liter"^2/("Hour"*"Millimole")], rateconst["rxn3", True] -> Unit[1, "Liter"/"Hour"], rateconst["rxn4", True] -> Unit[1, "Liter"/"Hour"], rateconst["rxn5", True] -> Unit[1, "Liter"/"Hour"], rateconst["cmprt_rxn1", True] -> Unit[1, "Liter"/("Hour"*"Millimole")], rateconst["cmprt_rxn2", True] -> Unit[1, "Liter"/("Hour"*"Millimole")], rateconst["cmprt_rxn3", True] -> Unit[1, "Hour"^(-1)], rateconst["cmprt_rxn4", True] -> Unit[1, "Hour"^(-1)], rateconst["cmprt_rxn5", True] -> Unit[1, "Hour"^(-1)], rateconst["trans1", True] -> Unit[1, "Liter"/"Hour"], rateconst["trans2", True] -> Unit[1, "Liter"^2/("Hour"*"Millimole")], rateconst["trans3", True] -> Unit[1., "Liter"^4.3/("Hour"*"Millimole"^3.3)], rateconst["cmprt_rxn_weird", True] -> Unit[1, "Liter"/("Hour"*"Millimole")], rateconst["rxn1", False] -> Unit[1, "Liter"^2/("Hour"*"Millimole")], rateconst["rxn2", False] -> Unit[1, "Liter"/"Hour"], rateconst["rxn3", False] -> Unit[1, "Liter"^2/("Hour"*"Millimole")], rateconst["rxn4", False] -> Unit[1, "Liter"/"Hour"], rateconst["rxn5", False] -> Unit[1, "Liter"/"Hour"], rateconst["cmprt_rxn1", False] -> Unit[1, "Liter"/("Hour"*"Millimole")], rateconst["cmprt_rxn2", False] -> Unit[1, "Hour"^(-1)], rateconst["cmprt_rxn3", False] -> Unit[1, "Liter"/("Hour"*"Millimole")], rateconst["cmprt_rxn4", False] -> Unit[1, "Hour"^(-1)], rateconst["cmprt_rxn5", False] -> Unit[1, "Hour"^(-1)], rateconst["trans1", False] -> Unit[1, "Liter"/"Hour"], rateconst["trans2", False] -> Unit[1., "Liter"^4.3/("Hour"*"Millimole"^3.3)], rateconst["trans3", False] -> Unit[1., "Liter"^4.3/("Hour"*"Millimole"^3.3)], rateconst["cmprt_rxn_weird", False] -> Unit[1., "Liter"^3.3/("Hour"*"Millimole"^3.3)]}
	,
	TestID->"UnitCheckingRelatedTests-20120822-I8U2C3"
]


Test[
	SetOptions[adjustUnits, "DefaultAmountUnit" -> Mole, "DefaultVolumeUnit" -> Meter^3, "DefaultTimeUnit"->Second];
    Quiet[adjustUnits[param, testRxns],{adjustUnits::noUnitsProvidedKeq,adjustUnits::noUnitsProvidedRateConst}]
    ,
    {Keq["rxn1"] -> 1, Keq["rxn2"] -> Unit[1, "Meter"^3/"Mole"], Keq["rxn3"] -> Unit[1, "Mole"/"Meter"^3], Keq["rxn4"] -> 1, Keq["rxn5"] -> 1, Keq["cmprt_rxn1"] -> 1, Keq["cmprt_rxn2"] -> Unit[1, "Meter"^3/"Mole"], Keq["cmprt_rxn3"] -> Unit[1, "Mole"/"Meter"^3], Keq["cmprt_rxn4"] -> 1, Keq["cmprt_rxn5"] -> 1, Keq["trans1"] -> 1, Keq["trans2"] -> Unit[1., "Mole"^2.3/"Meter"^6.8999999999999995], Keq["trans3"] -> 1, Keq["cmprt_rxn_weird"] -> Unit[1., "Mole"^2.3/"Meter"^6.8999999999999995], rateconst["rxn1", True] -> Unit[1, "Meter"^6/("Mole"*"Second")], rateconst["rxn2", True] -> Unit[1, "Meter"^6/("Mole"*"Second")], rateconst["rxn3", True] -> Unit[1, "Meter"^3/"Second"], rateconst["rxn4", True] -> Unit[1, "Meter"^3/"Second"], rateconst["rxn5", True] -> Unit[1, "Meter"^3/"Second"], rateconst["cmprt_rxn1", True] -> Unit[1, "Meter"^3/("Mole"*"Second")], rateconst["cmprt_rxn2", True] -> Unit[1, "Meter"^3/("Mole"*"Second")], rateconst["cmprt_rxn3", True] -> Unit[1, "Second"^(-1)], rateconst["cmprt_rxn4", True] -> Unit[1, "Second"^(-1)], rateconst["cmprt_rxn5", True] -> Unit[1, "Second"^(-1)], rateconst["trans1", True] -> Unit[1, "Meter"^3/"Second"], rateconst["trans2", True] -> Unit[1, "Meter"^6/("Mole"*"Second")], rateconst["trans3", True] -> Unit[1., "Meter"^12.899999999999999/("Mole"^3.3*"Second")], rateconst["cmprt_rxn_weird", True] -> Unit[1, "Meter"^3/("Mole"*"Second")], rateconst["rxn1", False] -> Unit[1, "Meter"^6/("Mole"*"Second")], rateconst["rxn2", False] -> Unit[1, "Meter"^3/"Second"], rateconst["rxn3", False] -> Unit[1, "Meter"^6/("Mole"*"Second")], rateconst["rxn4", False] -> Unit[1, "Meter"^3/"Second"], rateconst["rxn5", False] -> Unit[1, "Meter"^3/"Second"], rateconst["cmprt_rxn1", False] -> Unit[1, "Meter"^3/("Mole"*"Second")], rateconst["cmprt_rxn2", False] -> Unit[1, "Second"^(-1)], rateconst["cmprt_rxn3", False] -> Unit[1, "Meter"^3/("Mole"*"Second")], rateconst["cmprt_rxn4", False] -> Unit[1, "Second"^(-1)], rateconst["cmprt_rxn5", False] -> Unit[1, "Second"^(-1)], rateconst["trans1", False] -> Unit[1, "Meter"^3/"Second"], rateconst["trans2", False] -> Unit[1., "Meter"^12.899999999999999/("Mole"^3.3*"Second")], rateconst["trans3", False] -> Unit[1., "Meter"^12.899999999999999/("Mole"^3.3*"Second")], rateconst["cmprt_rxn_weird", False] -> Unit[1., "Meter"^9.899999999999999/("Mole"^3.3*"Second")]}
    ,
    TestID->"UnitCheckingRelatedTests-20120822-U7R3N3"
]


(*The following combinatorial code tests that rate and equilibrium constants always have the correct units regardless of the spatial dimension or compartimentalization of the model...*)
combinatorialRxns = 
  str2mass /@ {"1: a <=> p", "2: a + b <=> p", "3: a <=> p + q", 
    "4: a[c] <=> p[c]", "5: a[c] + b[c] <=> p[c]", 
    "6: a[c] <=> p[c] + q[c]", "7: a[c] <=> p[e]", 
    "8: a[e] + b[c] <=> p[d]", "9: a[c] <=> p[e] + q[e]", "9: a[c] <=> p[e] + q[e] + z[g]", "10: a <=> p[e] + q + z[g]"};
Do[
 SetOptions[adjustUnits, "DefaultAmountUnit" -> Millimole, "DefaultVolumeUnit" -> volumeUnit, "DefaultTimeUnit" -> Hour];
 adjustedParam = Quiet[adjustUnits[{k[getID[rxn]] -> 1, Keq[getID[rxn]] -> 2, k[getID[rxn], False] -> .1}, {rxn}], {adjustUnits::noUnitsProvidedKeq,adjustUnits::noUnitsProvidedRateConst}];
 units = Quiet[adjustUnits[adjustedParam, {rxn}],{adjustUnits::noUnitsProvidedKeq,adjustUnits::noUnitsProvidedRateConst}];
 rate = stripTime[Toolbox`Private`reaction2rate[rxn]];
 kkRate = keq2k[rate];
 numRate = rate /. m_metabolite :> RandomReal[] Millimole volumeUnit^-1 /. units /. parameter["Volume", "c"] -> 1.5 volumeUnit;
 numRate2 = kkRate /. m_metabolite :> RandomReal[] Millimole volumeUnit^-1 /. units /. parameter["Volume", "c"] -> 1.5 volumeUnit;
 With[{testID=StringJoin["UnitCheckingRelatedTests-",volumeUnit /. {Meter->"m",Meter^2->"m^2",Meter^3->"m^3",Liter->"l"} ,"-",ToString[rxn]]},
 Test[
	MatchQ[numRate, Unit[_?NumberQ, "Millimole"*("Hour")^-1]]&&MatchQ[numRate2, Unit[_?NumberQ, "Millimole"*("Hour")^-1]]
	,
	True
	,
	TestID->testID
]
];
 ,{rxn, combinatorialRxns}, {volumeUnit, {Meter, Meter^2, Meter^3,Liter}}
 ]
