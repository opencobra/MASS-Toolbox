(* ::Package:: *)

(* ::Title:: *)
(*Thermodynamics*)


(* ::Section:: *)
(*Definitions*)


Protect[is,pH,T];


Begin["`Private`"]


Toolbox::badargs="There is no definition for '``' applicable to ``."


(*Needs["Toolbox`ThirdParty`BiochemThermo`BasicBiochemData2`"]
Needs["Toolbox`ThirdParty`BiochemThermo`BasicBiochemData3`"]*)
(*$ContextPath=DeleteCases[$ContextPath,"BiochemThermo`BasicBiochemData2`"];*)
(*$ContextPath=DeleteCases[$ContextPath,"BiochemThermo`BasicBiochemData3`"];*)


(*constants={"T"->298.15(*Temperature*),"R"->8.31*^-3(*Gas constant (mM)*)};*)
(*constants={"T"->298.15 Kelvin(*Temperature*),"R"->Quiet[Convert[MolarGasConstant,Joule/(Kelvin Milli Mole)],{Convert::temp}](*Gas constant (mM)*),"F"->Quiet[Convert[FaradayConstant,Coulomb/(Milli Mole)]]};*)
constants={"R"->PhysicalConstants`MolarGasConstant};


defaults={"is"->is,"pH"->pH,"T"->298.15 Kelvin};


equilibrator2albertyFormat[pseudoisomers:{{_Rule..}...}]:={"dG0_f","dH0_f","z","nH"}/.#&/@pseudoisomers


Unprotect[calcDeltaG];
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
	dissEqRatios=SimplifyUnits[Chop[getDisequilibriumRatios[model]/.keq/.conc/.speciesParam]];
	Thread[(dG[getID[#]]&/@model["Fluxes"])->PhysicalConstants`MolarGasConstant*298.15 Kelvin*Chop[Log[dissEqRatios]]]
];

calcDeltaG[pseudoIsomers:{_?(MatchQ[#,{_Rule..}&&MemberQ[Quiet@#[[All,1]],"dG0_f"]]&)..},opts:OptionsPattern[]]:=Module[{dGzero,dHzero,dGzeroT,zi,nH,pHterm,isterm,gpfnsp,T,R,stub,is,pH,Tstd,gibbsCoeff},
	dGzero=Table[
		Quiet[Check[stub=Convert["dG0_f"/.Dispatch[isomer],Kilojoule Mole^-1],Message[calcDeltaG::noOrWrongUnitsDG,isomer];stub,{Convert::incomp,Unit::incomp2}],{Convert::incomp,Unit::incomp2}]
		,{isomer,pseudoIsomers}
		]//stripUnits;
	dHzero=Table[
		(*Quiet[,{Convert::incomp,Unit::incomp2}]*)
		Check[stub=Convert["dH0_f"/.Dispatch[isomer],Kilojoule Mole^-1],Message[calcDeltaG::noOrWrongUnitsDH,isomer];stub,{Convert::incomp,Unit::incomp2}]
		,{isomer,pseudoIsomers}
		]//stripUnits;
	is=If[MatchQ[OptionValue["is"],_Symbol],OptionValue["is"],Quiet[Check[stub=stripUnits@Convert[OptionValue["is"],Mole Liter^-1],Message[calcDeltaG::noOrWrongUnitsIonicStrength];stub,{Convert::incomp,Unit::incomp2}],{Convert::incomp,Unit::incomp2}]];
	If[NumberQ[is]&&!(0<=is<=0.35),Message[calcDeltaG::pHandISandTrange,"ionic strength"]];
	pH=OptionValue["pH"];
	If[NumberQ[pH]&&!(5<=pH<=9),Message[calcDeltaG::pHandISandTrange,"pH"]];
	zi="z"/.pseudoIsomers;
	nH="nH"/.pseudoIsomers;
	Tstd=298.15;
	T=If[MatchQ[OptionValue["T"],_Unit],stripUnits[ConvertTemperature[OptionValue["T"],Kelvin]],OptionValue["T"]];
	If[NumberQ[T]&&!(273.15<=T<=313.15),Message[calcDeltaG::pHandISandTrange,"T"]];
	R=Quiet[stripUnits@Convert[OptionValue["R"],(Joule)/(Mole Kelvin)](*/.Unit[a_,Times[Power["Kelvin",-1],"Kilojoule",Power["Mole",-1]]]:>a*),{Convert::incomp,Unit::incomp2}];
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
	Chop[(((-R*T*Log[Apply[Plus,Exp[-1*gpfnsp/((R*T)/1000)]]])/1000)/.Dispatch[List[opts]])Kilojoule Mole^-1]
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
	conditions=Union[getConditions/@Cases[dGofFormation,dg_dGstd/;MemberQ[getCompounds[rxn],getID[dg]],\[Infinity]]];
	If[conditions==={},conditions=Union[getConditions/@dGofFormation[[All,1]]]];
	If[Length[conditions]>1,Message[calcDeltaG::inconcond];Abort[];];
	conditions=conditions[[1]];
	tmpRules=getID[#[[1]]]->#[[2]]&/@dGofFormation;
	ignore=Alternatives@@OptionValue["Ignore"];
	Chop[dGstd[getID[rxn],Sequence@@conditions]->Total[getSignedStoich[rxn]*(getCompounds[rxn]/. ignore->0)/.Dispatch[tmpRules]/.m:$MASS$speciesPattern:>dGstd[m,Sequence@@conditions]]]
];

calcDeltaG[rxns:{_reaction..},dGofFormation:{(_dGstd->_ )..}]:=calcDeltaG[#,dGofFormation]&/@rxns

def:calcDeltaG[___]:=(Message[Toolbox::badargs,calcDeltaG,Defer@def];Abort[])
Protect[calcDeltaG];


Unprotect[dG2keq];
dG2keq::nounits="No units provided. Assuming Kilojoule \!\(\*SuperscriptBox[\(Mole\), \(-1\)]\).";
Options[dG2keq]=Join[FilterRules[constants,{"R"}],FilterRules[defaults,{"T"}]];
dG2keq[dgz_Unit,opts:OptionsPattern[]]:=Module[{dgzConverted},
dgzConverted=Quiet[Check[Convert[dgz,Joule Mole^-1],dgz,{Convert::incomp}],{Convert::incomp}];
Exp[-(dgzConverted/(OptionValue["R"]*OptionValue["T"]))]
];
dG2keq[dgz_?NumberQ,opts:OptionsPattern[]]:=Module[{},
If[dgz==0,
1,
Message[dG2keq::nounits];
dG2keq[dgz Kilojoule Mole^-1,opts]
]
];
dG2keq[param:{_Rule..},opts:OptionsPattern[]]:=param/.r_Rule/;MatchQ[r[[1]],_dGstd]&&Head[getID[r[[1]]]]==String:>Keq[getID[r[[1]]]]->dG2keq[r[[2]]]
def:dG2keq[___]:=(Message[Toolbox::badargs,dG2keq,Defer@def];Abort[])
Protect[dG2keq]


adjustKeqUnits=stripUnits[Convert[#,Table[Liter^-i Mole^i,{i,Join[Range[-5,-1],Range[1,5]]}]]]&;
Unprotect[keq2dG];
Options[keq2dG]=Join[Join[FilterRules[constants,{"R"}],FilterRules[defaults,{"T"}]],{"is"->Undefined,"pH"->Undefined}];
keq2dG[keq_Keq,opts:OptionsPattern[]]:=Exp[-(dGstd[getID[keq],Sequence@@updateRules[FilterRules[Options[keq2dG],Options[dGstd][[All,1]]],FilterRules[List@opts,Options[dGstd][[All,1]]]]]/(OptionValue["R"]OptionValue["T"]))]
keq2dG[keq:(_?NumberQ|_Unit),opts:OptionsPattern[]]:=-OptionValue["R"] OptionValue["T"] Log[adjustKeqUnits[keq]]
keq2dG[param:{_Rule..},opts:OptionsPattern[]]:=param/.r_Rule/;r[[1,0]]==Keq&&Head[getID[r[[1]]]]==String:>(dGstd[getID[r[[1]]],Sequence@@updateRules[FilterRules[Options[keq2dG],Options[dGstd][[All,1]]],FilterRules[List@opts,Options[dGstd][[All,1]]]]]->-OptionValue["R"] OptionValue["T"] Log[adjustKeqUnits[r[[2]]]])
keq2dG[stuff_,opts:OptionsPattern[]]:=stuff/.keq_Keq:>Exp[-(dGstd[getID[keq],Sequence@@updateRules[Options[dGstd],FilterRules[List@opts,Options[dGstd][[All,1]]]]]/(OptionValue["R"]OptionValue["T"]))]
def:keq2dG[___]:=(Message[Toolbox::badargs,keq2dG,Defer@def];Abort[])
Protect[keq2dG];


Unprotect[dGstd];
Options[dGstd]={"is"->0. Mole Liter^-1,"pH"->0.,"T"->298.15 Kelvin};

dGstd[id:Prepend[$MASS$speciesPattern,_String],opts:OptionsPattern[]]:=Block[{$preventRecursion=True},
dGstd[id,Sequence@@updateRules[Options[dGstd],ToString[#[[1]]]->#[[2]]&/@List@opts]]
]/;!TrueQ[$preventRecursion]

dGstd/:MakeBoxes[dGstd[fluxID_String,conditions:OptionsPattern[]],_]:=InterpretationBox[TooltipBox[SubsuperscriptBox[#3,#4,#],#2],dGstd[fluxID,conditions]]&[simplyBlack[If[Complement[List@conditions,Options[dGstd]]==={},"\[SmallCircle]","\[SmallCircle]'"]],GridBox[Partition[ToBoxes/@List[conditions],1]],simplyBlack["\[CapitalDelta]G"],simplyBlack[fluxID]]       

With[{pat=$MASS$speciesPattern},dGstd/:MakeBoxes[dGstd[met:pat,conditions:OptionsPattern[]],StandardForm]:=
InterpretationBox[TooltipBox[
SubsuperscriptBox[#4,#,#2],#3
],dGstd[met,conditions]]&[ToBoxes@met,simplyBlack[If[Complement[List@conditions,Options[dGstd]]==={},"\[SmallCircle]","\[SmallCircle]'"]],GridBox[Partition[ToBoxes/@List[conditions],1]],simplyBlack["\[CapitalDelta]G"]]]

dGstd/:getID[elem_dGstd]:=elem[[1]]
dGstd/:getConditions[elem_dGstd]:=List@@elem[[2;;]]
dGstd/:ToString[elem_dGstd]:="dGstd_"<>ToString[getID[elem]];
Protect[dGstd];


(* ::Input:: *)
(*(*simplyBlack[str_String]:=StyleBox[str,RGBColor[0,0,0],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]*)*)


(* ::Input:: *)
(*(*Unprotect[dGstd];*)
(*ClearAll[dGstd];*)
(*Options[dGstd]={is->0.Millimole,pH->0.};*)
(**)
(*dGstd[id:Prepend[$MASS$speciesPattern,_String],opts:OptionsPattern[]]:=Block[{$preventRecursion=True},*)
(*	dGstd[id,Sequence@@updateRules[Options[dGstd],List@opts]]*)
(*]/;!TrueQ[$preventRecursion]*)
(**)
(*(*dGstd/:MakeBoxes[dGstd[fluxID_String,conditions:OptionsPattern[]],_]:=InterpretationBox[TooltipBox[SubsuperscriptBox[#3,#4,#],#2],dGstd[fluxID,conditions]]&[If[Complement[List@conditions,Options[dGstd]]==={},simplyBlack@"\[SmallCircle]",simplyBlack@"\[SmallCircle]'"],GridBox[Partition[ToBoxes/@List[conditions],1]],simplyBlack["\[CapitalDelta]G"],simplyBlack[fluxID]]       *)*)
(**)
(*With[{pat=$MASS$speciesPattern},dGstd/:MakeBoxes[dGstd[met:pat,conditions:OptionsPattern[]],_]:=*)
(*InterpretationBox[*)
(*RowBox[{SubsuperscriptBox[#3,#,#2],"(",##4,")"}],*)
(*dGstd[met,conditions]]&[ToBoxes@met,If[Complement[List@conditions,Options[dGstd]]==={},simplyBlack@"\[SmallCircle]",simplyBlack@"\[SmallCircle]'"],simplyBlack["\[CapitalDelta]G"],Sequence@@(Riffle[ToBoxes[Equal@@#,TraditionalForm]&/@List[conditions],","])]]*)
(**)
(*dGstd/:getID[elem_dGstd]:=elem[[1]]*)
(*dGstd/:getConditions[elem_dGstd]:=List@@elem[[2;;]]*)
(*dGstd/:ToString[elem_dGstd]:="dGstd_"<>ToString[getID[elem]];*)
(*Protect[dGstd];*)*)


Unprotect[dG];
dG/:MakeBoxes[dG[fluxID_String],StandardForm]:=InterpretationBox[SubscriptBox["\[CapitalDelta]G",fluxID],dG[fluxID]]
dG/:getID[elem_dG]:=elem[[1]]
dG/:ToString[elem_dG]:="dG_"<>ToString[getID[elem]];
Protect[dG];


(* ::Subsection::Closed:: *)
(*End*)


End[]
