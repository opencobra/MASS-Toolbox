(* Mathematica Test File *)

testRxns = str2mass/@{"rxn1: a + b <-> c + d", "rxn2: a + b <-> c", "rxn3: a <-> b + c", "rxn4: a <-> 0", "rxn5: 0 <-> a"};

cmpds=Union[Flatten[getCompounds/@testRxns]];

conc=MapIndexed[#->{1,Milli,Micro,Pico,Femto}[[First@#2]]Mole Liter^-1&,cmpds];

param = Join[Keq[getID[#]]->1&/@testRxns,rateconst[getID[#]]->1&/@testRxns, rateconst[getID[#],False]->1&/@testRxns]

rates =  makeRates[testRxns];

Print[adjustUnits[conc]];

Test[
	adjustUnits[conc]
	,
	{metabolite["a", _] -> (1000*Milli*Mole)/Liter, metabolite["b", _] -> (Milli*Mole)/Liter, metabolite["c", _] -> (Milli*Mole)/(1000*Liter), metabolite["d", _] -> (Milli*Mole)/(1000000000*Liter)}
	,
	TestID->"UnitCheckingRelatedTests-20120822-X4U4H1"
]

Test[
    adjustUnits[{m["atp","c"] -> Pico Mole (Centi Meter)^-1}]
    ,
    {metabolite["atp", "c"] -> (Milli*Mole)/(10000000*Meter)}
    ,
    TestID->"UnitCheckingRelatedTests-20120927-G1X3U0"
]

Test[
    adjustUnits[{m["atp","c"] -> Pico Mole (Centi Meter)^-2}]
    ,
    {metabolite["atp", "c"] -> (Milli*Mole)/(100000*Meter^2)}
    ,
    TestID->"UnitCheckingRelatedTests-20120927-E8P5U8"
]

Test[
    adjustUnits[{m["atp","c"] -> Pico Mole Feet^-3}]
    ,
    {metabolite["atp", "c"] -> (Milli*Mole)/(28316846592*Liter)}
    ,
    TestID->"UnitCheckingRelatedTests-20120927-E8P5U8"
]

(*Test[
	adjustUnits[param, testRxns]
	,
	{Keq["rxn1"] -> 1, Keq["rxn2"] -> (1000*Liter)/Mole, Keq["rxn3"] -> Mole/(1000*Liter), Keq["rxn4"] -> 1, Keq["rxn5"] -> 1, rateconst["rxn1"] -> 1, rateconst["rxn2"] -> 1, rateconst["rxn3"] -> 1, rateconst["rxn4"] -> 1, rateconst["rxn5"] -> 1, rateconst["rxn1", False] -> (1000*Liter)/(Hour*Mole), rateconst["rxn2", False] -> Hour^(-1), rateconst["rxn3", False] -> (1000*Liter)/(Hour*Mole), rateconst["rxn4", False] -> Hour^(-1), rateconst["rxn5", False] -> Hour^(-1)}
	,
	{adjustUnits::noUnits}
	,
	TestID->"UnitCheckingRelatedTests-20120822-I8U2C3"
]*)

(*Test[
	{1 + 1}
	,
	{1 + 1}
	,
	TestID->"UnitCheckingRelatedTests-20120823-E7J5T9"
]


SetOptions[adjustParameters, "DefaultAmountUnit" -> Mole]

Test[
    adjustUnits[param, testRxns]
    ,
    {Keq["rxn1"] -> 1, Keq["rxn2"] -> (1000*Liter)/Mole, Keq["rxn3"] -> Mole/(1000*Liter), Keq["rxn4"] -> 1, Keq["rxn5"] -> 1, rateconst["rxn1"] -> 1, rateconst["rxn2"] -> 1, rateconst["rxn3"] -> 1, rateconst["rxn4"] -> 1, rateconst["rxn5"] -> 1, rateconst["rxn1", False] -> (1000*Liter)/(Hour*Mole), rateconst["rxn2", False] -> Hour^(-1), rateconst["rxn3", False] -> (1000*Liter)/(Hour*Mole), rateconst["rxn4", False] -> Hour^(-1), rateconst["rxn5", False] -> Hour^(-1)}
    ,
    TestID->"UnitCheckingRelatedTests-20120822-U7R3N3"
]*)

