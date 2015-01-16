(* ::Package:: *)

(* ::Title:: *)
(*Thermodynamics*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


(*Needs["Toolbox`ThirdParty`BiochemThermo`BasicBiochemData2`"]
Needs["Toolbox`ThirdParty`BiochemThermo`BasicBiochemData3`"]*)
(*$ContextPath=DeleteCases[$ContextPath,"BiochemThermo`BasicBiochemData2`"];*)
(*$ContextPath=DeleteCases[$ContextPath,"BiochemThermo`BasicBiochemData3`"];*)


(*constants={"T"->298.15(*Temperature*),"R"->8.31*^-3(*Gas constant (mM)*)};*)
(*constants={"T"\[Rule]Quantity[298.15,"Kelvins"](*Temperature*),"R"->UnitConvert[Quantity["MolarGasConstant"],Quantity[1, ("Joules"*"Millimoles")/"Kelvins"]](*Gas constant (mM)*),"F"\[Rule]UnitConvert[Quantity[1, "FaradayConstant"],Quantity[1, "Coulombs"/"Millimoles"]]};*)
constants={"R"->Quantity["MolarGasConstant"]};


defaults={"is"->is,"pH"->pH,"T"->Quantity[298.15,"Kelvins"]};


equilibrator2albertyFormat[pseudoisomers:{{_Rule..}...}]:={"dG0_f","dH0_f","z","nH"}/.#&/@pseudoisomers


calcDeltaG::inconcond="Inconsistent conditions encountered ###FIXME###.";
calcDeltaG::pHandISandTrange="Warning! According to Alberty 2003, it is save to adjust for ionic strength in the range of 0. to 0.35 M, pH in the range 5 to 9, and Temperature in the range of 273.15 to 313.15 Kelvin. `1` lies out of these range specification.";
calcDeltaG::noOrWrongUnitsDG="No (or incompatible) units have been specified for \!\(\*SubscriptBox[\(\[CapitalDelta]\), \(f\)]\)G in isomer `1`. Kilo Joule \!\(\*SuperscriptBox[\(Mole\), \(-1\)]\) are assumed.";
calcDeltaG::noOrWrongUnitsDH="No (or incompatible) units have been specified for \!\(\*SubscriptBox[\(\[CapitalDelta]\), \(f\)]\)H in isomer `1`. Kilo Joule \!\(\*SuperscriptBox[\(Mole\), \(-1\)]\) are assumed.";
calcDeltaG::noOrWrongUnitsIonicStrength="No (or incompatible) units have been specified for the ionic strength. Mole \!\(\*SuperscriptBox[\(Liter\), \(-1\)]\) assumed.";
calcDeltaG::missingPseudoisomerData="Missing pseudoisomer information encountered for `1` in reaction `2`.";
Options[calcDeltaG]=Join[FilterRules[constants,{"R"}], defaults, {"Concentrations"->{},"Parameters"->{},"Ignore"->{Toolbox`metabolite["h", Blank[]],Toolbox`metabolite["H", Blank[]],Toolbox`metabolite["C00080", Blank[]]}}];
(*SetAttributes[calcDeltaG,Listable];*)
calcDeltaG[model_MASSmodel,opts:OptionsPattern[]]:=Module[{fluxes,conc,tmpParam,keq,speciesParam,dissEqRatios},
	conc=updateRules[FilterRules[model["InitialConditions"],$MASS$speciesPattern],FilterRules[OptionValue["Concentrations"],species:$MASS$speciesPattern/;MemberQ[model["Species"],species]]];
	tmpParam=updateRules[model["Parameters"],OptionValue["Parameters"]];
	keq=FilterRules[tmpParam,_Keq];
	speciesParam=FilterRules[tmpParam,$MASS$speciesPattern];
	dissEqRatios=UnitSimplify[Chop[getDisequilibriumRatios[model]/.keq/.conc/.speciesParam]];
	Thread[(dG[getID[#]]&/@model["Fluxes"])->Quantity["MolarGasConstant"]*Quantity[298.15,"Kelvins"]*Chop[Log[dissEqRatios]]]
];

calcDeltaG[pseudoIsomers:{_?(MatchQ[#,{_Rule..}&&MemberQ[Quiet@#[[All,1]],"dG0_f"]]&)..},opts:OptionsPattern[]]:=Module[{dGzero,dHzero,dGzeroT,zi,nH,pHterm,isterm,gpfnsp,T,R,stub,is,pH,Tstd,gibbsCoeff},
	dGzero=Table[
		Quiet[Check[stub=UnitConvert["dG0_f"/.Dispatch[isomer],Quantity["Kilojoules"/"Moles"]],Message[calcDeltaG::noOrWrongUnitsDG,isomer];stub,{Quantity::compat}],{Quantity::compat}]
		,{isomer,pseudoIsomers}
		]//stripUnits;
	dHzero=Table[
		Quiet[Check[stub=UnitConvert["dH0_f"/.Dispatch[isomer],Quantity["Kilojoules"/"Moles"]],Message[calcDeltaG::noOrWrongUnitsDH,isomer];stub,{Quantity::compat}],{Quantity::compat}]
		,{isomer,pseudoIsomers}
		]//stripUnits;
	is=If[MatchQ[OptionValue["is"],_Symbol],OptionValue["is"],Quiet[Check[stub=stripUnits@UnitConvert[OptionValue["is"],Quantity["Moles"/"Liters"]],Message[calcDeltaG::noOrWrongUnitsIonicStrength];stub,{Quantity::compat}],{Quantity::compat}]];
	If[NumberQ[is]&&!(0<=is<=0.35),Message[calcDeltaG::pHandISandTrange,"ionic strength"]];
	pH=OptionValue["pH"];
	If[NumberQ[pH]&&!(5<=pH<=9),Message[calcDeltaG::pHandISandTrange,"pH"]];
	zi="z"/.pseudoIsomers;
	nH="nH"/.pseudoIsomers;
	Tstd=298.15;
	T=If[MatchQ[OptionValue["T"],_Quantity],stripUnits[UnitConvert[OptionValue["T"],"Kelvins"]],OptionValue["T"]];
	If[NumberQ[T]&&!(273.15<=T<=313.15),Message[calcDeltaG::pHandISandTrange,"T"]];
	R=Quiet[Check[stripUnits@UnitConvert[OptionValue["R"],Quantity[1, "Joules"/("Kelvins"*"Moles")]],Message[calcDeltaG::inconcond];Abort[](*/.Quantity[a_,Times[Power["Kelvin",-1],"Kilojoule",Power["Mole",-1]]]:>a*),{Quantity::compat}],{Quantity::compat}];
	(*
	dG=dH - Tstd dS
	dS->(-dG+dH)/Tstd;
	dGnewT=dH+(dG*T)/Tstd-(dH*T)/Tstd;
	dGnewT=(dG*T)/Tstd+dH-(dH*T)/Tstd;
	dGnewT=(dG*T)/Tstd+dH(1-T/Tstd);
	*)
	
	dGzeroT=(dGzero*T)/Tstd+dHzero*(1-T/Tstd);
	dGzeroT=(dGzero*T)/298.15+dHzero*(1-T/298.15);
	pHterm=(nH*R*T*Log[10^-pH])/1000;
	gibbsCoeff=((9.20483*T)/10^3-(1.284668*T^2)/10^5+(4.95199*T^3)/10^8);
	isterm=gibbsCoeff (((zi^2)-nH)*Sqrt[is])/(1+1.6*Sqrt[is]);
	gpfnsp=dGzeroT-pHterm-isterm;
	Chop[(((-R*T*Log[Apply[Plus,Exp[-1*gpfnsp/((R*T)/1000)]]])/1000)/.Dispatch[List[opts]])*Quantity["Kilojoules"/"Moles"]]
];
(*-((8.31451*t*Log[Plus@@(E^(-(gpfnsp/((8.31451*t)/1000))))])/1000)*)
calcDeltaG[metsAndIsomers:{($MASS$speciesPattern->{_?(MatchQ[#,{_Rule..}&&MemberQ[#[[All,1]],"priority"]]&)..})..},opts:OptionsPattern[]]:=
	calcDeltaG[(#[[1]]->("species"/.Dispatch[Sort[#[[2]],("priority"/.#1)<("priority"/.#2)&][[1]]])&/@metsAndIsomers),opts]

calcDeltaG[metsAndIsomers:{($MASS$speciesPattern->{_?(MatchQ[#,{_Rule..}&&MemberQ[#[[All,1]],"dG0_f"]]&)..})..},opts:OptionsPattern[]]:=
	dGstd[#[[1]],is->OptionValue["is"],pH->OptionValue["pH"]]->calcDeltaG[#[[2]],opts]&/@metsAndIsomers

(*http://equilibrator.weizmann.ac.il/download

Each pseudoisomer map has a "source" and a "priority" and contains data on a number of psuedoisomers (a word on priorities later). Each pseudoisomer in a map has a characteristic number of hydrogens ("nH") and charge ("z"). The standard Gibbs energy of formation is given as "dG0_f" and a reference is given for the data ("ref"). If an acid dissociation constant was used to compute the Gibbs energy of the pseudoisomer then reference represents the source of the pKa data (for example "ChemAxon").

As mentioned above, it is important not to mix measured and approximated data in thermodynamic calculations (more than is necessary). As such, each pseudoisomer map has an associated "priority". When calculating reactions energies,always use data from the same priority level.The priority tags are designed to prevent erroneous mixing of measured and approximate data.
*)

calcDeltaG[rxns:{_reaction..},equilibratorData:{($MASS$speciesPattern->{_?(MatchQ[#,{_Rule..}&&MemberQ[#[[All,1]],"priority"]]&)..})..},opts:OptionsPattern[]]:=Module[{ofInterest,allSpecies},
	allSpecies=getID/@Union[Flatten[getSpecies/@rxns]];
	ofInterest=Select[equilibratorData,MemberQ[allSpecies,getID[#[[1]]]]&];
	(calcDeltaG[#,ofInterest,opts]&/@rxns)
];

calcDeltaG[rxn_reaction,equilibratorData:{($MASS$speciesPattern->{_?(MatchQ[#,{_Rule..}&&MemberQ[#[[All,1]],"priority"]]&)..})..},opts:OptionsPattern[]]:=Module[{cmpds,matches,priorityLevel,pseudoisomers,nextBestPriority,tmp,dGofF},
	cmpds=getSpecies[rxn];
	matches=cmpds/.equilibratorData;
	If[MemberQ[matches,$MASS$speciesPattern],Message[calcDeltaG::missingPseudoisomerData,Cases[matches,$MASS$speciesPattern],rxn];Return[dGstd[getID[rxn]]->Undefined]];
	priorityLevel=Max[Min/@("priority"/.#&/@matches)];
	pseudoisomers=Table[
		tmp=Cases[elem,l_List/;("priority"/.Dispatch[l])==priorityLevel];
		nextBestPriority=priorityLevel-1;
		While[tmp==={}&&nextBestPriority>0,
			tmp=Cases[elem,l_List/;("priority"/.Dispatch[l])==nextBestPriority];
			nextBestPriority=priorityLevel-1;
		];
		"species"/.Dispatch[tmp[[1]]]
	,{elem,matches}];
	dGofF=calcDeltaG[Thread[Rule[cmpds,pseudoisomers]],opts];
	calcDeltaG[rxn,dGofF]
];

calcDeltaG[rxn_reaction,pseudosiomerData:{($MASS$speciesPattern->{{_Rule..}..})..},opts:OptionsPattern[]]:=Module[{cmpds,matches,priorityLevel,pseudoisomers,nextBestPriority,tmp,dGofF},
	cmpds=getCompounds[rxn];
	matches=cmpds/.pseudosiomerData;
	If[MemberQ[matches,$MASS$speciesPattern],Message[calcDeltaG::missingPseudoisomerData,Cases[matches,$MASS$speciesPattern],rxn];Return[dGstd[getID[rxn]]->Undefined]];
	dGofF=calcDeltaG[Thread[Rule[cmpds,matches]],opts];
	calcDeltaG[rxn,dGofF]
];

calcDeltaG[rxns:{_reaction..},pseudosiomerData:{($MASS$speciesPattern->{{_Rule..}..})..},opts:OptionsPattern[]]:=Module[{ofInterest,allSpecies},
	allSpecies=getID/@Union[Flatten[getSpecies/@rxns]];
	ofInterest=Select[pseudosiomerData,MemberQ[allSpecies,getID[#[[1]]]]&];
	(calcDeltaG[#,ofInterest,opts]&/@rxns)
]

calcDeltaG[rxn_reaction,dGofFormation:{(_dGstd->_ )..},opts:OptionsPattern[]]:=Module[{conditions,tmpRules,ignore},
	conditions=Union[getConditions/@Cases[dGofFormation,dg_dGstd/;MemberQ[getSpecies[rxn],getID[dg]],\[Infinity]]];
	If[conditions==={},conditions=Union[getConditions/@dGofFormation[[All,1]]]];
	If[Length[conditions]>1,Message[calcDeltaG::inconcond];Abort[];];
	conditions=conditions[[1]];
	tmpRules=getID[#[[1]]]->#[[2]]&/@dGofFormation;
	ignore=Alternatives@@OptionValue["Ignore"];
	Chop[dGstd[getID[rxn],Sequence@@conditions]->Total[Chop[getSignedStoich[rxn]*(getSpecies[rxn]/. ignore->0)/.Dispatch[tmpRules]/.m:$MASS$speciesPattern:>dGstd[m,Sequence@@conditions]]]]
];

calcDeltaG[rxns:{_reaction..},dGofFormation:{(_dGstd->_ )..}]:=calcDeltaG[#,dGofFormation]&/@rxns


dG2keq::nounits="No units provided. Assuming Kilojoule \!\(\*SuperscriptBox[\(Mole\), \(-1\)]\).";
Options[dG2keq]=Join[FilterRules[constants,{"R"}],FilterRules[defaults,{"T"}]];
dG2keq[dgz_Quantity,opts:OptionsPattern[]]:=Module[{dgzConverted},
dgzConverted=Quiet[Check[UnitConvert[dgz,Quantity["Joules"/"Moles"]],dgz,{Quantity::compat}],{Quantity::compat}];
Exp[-(dgzConverted/(OptionValue["R"]*OptionValue["T"]))]
];
dG2keq[dgz_?NumberQ,opts:OptionsPattern[]]:=Module[{},
If[dgz==0,
1,
Message[dG2keq::nounits];
dG2keq[dgz*Quantity[1, "Kilojoules"/"Moles"],opts]
]
];
dG2keq[param:{_Rule..},opts:OptionsPattern[]]:=param/.r_Rule/;MatchQ[r[[1]],_dGstd]&&Head[getID[r[[1]]]]==String:>Keq[getID[r[[1]]]]->dG2keq[r[[2]]]


adjustKeqUnits=stripUnits[UnitConvert[#,Table[Quantity["Liters"/"Moles"]^i,{i,Join[Range[-5,-1],Range[1,5]]}]]]&;

Options[keq2dG]=Join[Join[FilterRules[constants,{"R"}],FilterRules[defaults,{"T"}]],{"is"->Undefined,"pH"->Undefined}];
keq2dG[keq_Keq,opts:OptionsPattern[]]:=Exp[-(dGstd[getID[keq],Sequence@@updateRules[FilterRules[Options[keq2dG],Options[dGstd][[All,1]]],FilterRules[List@opts,Options[dGstd][[All,1]]]]]/(OptionValue["R"]OptionValue["T"]))]
keq2dG[keq:(_?NumberQ|_Quantity),opts:OptionsPattern[]]:=-OptionValue["R"] OptionValue["T"] Log[adjustKeqUnits[keq]]
keq2dG[param:{_Rule..},opts:OptionsPattern[]]:=param/.r_Rule/;r[[1,0]]==Keq&&Head[getID[r[[1]]]]==String:>(dGstd[getID[r[[1]]],Sequence@@updateRules[FilterRules[Options[keq2dG],Options[dGstd][[All,1]]],FilterRules[List@opts,Options[dGstd][[All,1]]]]]->-OptionValue["R"] OptionValue["T"] Log[adjustKeqUnits[r[[2]]]])
keq2dG[stuff_,opts:OptionsPattern[]]:=stuff/.keq_Keq:>Exp[-(dGstd[getID[keq],Sequence@@updateRules[Options[dGstd],FilterRules[List@opts,Options[dGstd][[All,1]]]]]/(OptionValue["R"]OptionValue["T"]))]


(* ::Subsection::Closed:: *)
(*End*)


End[]
