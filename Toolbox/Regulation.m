(* ::Package:: *)

(* ::Title:: *)
(*Regulation*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Util*)


solveEnzymeSteadyStateEquations[enzymeModule_MASSmodel]:=Module[{enzForms,ssEq,enzPool,sol},
	enzForms=Cases[enzymeModule["Species"],_enzyme];
	ssEq=getEnzymeSteadyStateEquations[enzymeModule][[All,2]];
	enzPool=Total[enzForms]==p[getID[enzForms[[1]]]<>"_total"];
	sol=anonymize[Solve[Join[ssEq,{enzPool}],enzForms]];
	Switch[sol,{},sol,{_List},sol[[1]],{_List..},sol]
];


getEnzymeSteadyStateEquations[enzModule_MASSmodel]:=Module[{},
	stripTime[FilterRules[Thread[enzModule["Species"]->enzModule["ODE"]],_enzyme]/._'[t]->0]
];


haldaneRelation[rxnID_String,elementaryRxns:{_reaction..}]:=Keq[rxnID]==Times@@(rateconst[getID@#,True]&/@elementaryRxns)/Times@@(rateconst[getID@#,False]&/@elementaryRxns)


(* ::Subsection:: *)
(*Regulatory modules*)


Options[constructEnzymeModule]={"ID"->"","Compartment"->_,"Substrates"->{},"Products"->{},"Mechanism"->"Ordered","ActivationSites"->0,"InhibitionSites"->0,"Activators"->{},"Inhibitors"->{},"Effectors"->{}};

constructEnzymeModule[opts:OptionsPattern[]]:=Module[{model,activatedForms,activationRxnList,inhibitingRxnList,catalyticRxnList,transition,exch,tmpE,options,enzID,enzComp,freeEnzyme},

catalyticRxnList=generateCatalyticReactions[Sequence@@updateRules[Options[constructEnzymeModule],List@opts]];

{enzID,enzComp}=If[MatchQ[OptionValue["Mechanism"],{_String..}],{getID[#],getCompartment[#]}&@Union[Cases[catalyticRxnList,_enzyme,\[Infinity]]][[1]],{OptionValue["ID"],OptionValue["Compartment"]}];
options=Options[enzyme];
SetOptions[enzyme,"CatalyticSites"->Max[Length/@{OptionValue["Substrates"],OptionValue["Products"]}],"Compartment"->enzComp,"ActivationSites"->OptionValue["ActivationSites"],"InhibitionSites"->OptionValue["InhibitionSites"]];

freeEnzyme=Cases[catalyticRxnList,e_enzyme/;Length[getCatalytic[e]]==0,\[Infinity]][[1]];
activationRxnList=Flatten[Table[
Table[
(*tmpE=e["ID"->enzID,"BoundActivators"->tup1];*)
tmpE=enzyme[Sequence@@updateRules[freeEnzyme[[1]],{"BoundActivators"->tup1}]];
r[enzID<>"_Activation_"<>getID[elem]<>ToString[Unique[]],{sortActivators@tmpE,elem},{sortActivators@bindActivator[tmpE,elem]},{1,1,1}],{tup1,Union[Sort/@Tuples[OptionValue["Activators"],i]]},{elem,OptionValue["Activators"]}],{i,0,OptionValue["ActivationSites"]-1}]];

inhibitingRxnList=Flatten[Table[
Table[
(*tmpE=e["ID"->enzID<>"_T","BoundInhibitors"->tup1];*)
tmpE=enzyme[Sequence@@updateRules[freeEnzyme[[1]],{"BoundInhibitors"->tup1,"ID"->enzID<>"_T"}]];
r[enzID<>"_Inhibition_"<>getID[elem]<>ToString[Unique[]],{sortInhibitors@tmpE,elem},{sortInhibitors@bindInhibitor[tmpE,elem]},{1,1,1}],{tup1,Union[Sort/@Tuples[OptionValue["Inhibitors"],i]]},{elem,OptionValue["Inhibitors"]}],{i,0,OptionValue["InhibitionSites"]-1}]];

transition=r[enzID<>"_TransitionStep",{freeEnzyme},{enzyme[Sequence@@updateRules[freeEnzyme[[1]],{"ID"->enzID<>"_T"}]]},{1,1}];
exch=r["EX_"<>ToString[#],{#},{},{1}]&/@Join[Union@OptionValue["Substrates"],Union@OptionValue["Products"]];
SetOptions[enzyme,Sequence@@options];

model=constructModel[Join[catalyticRxnList,activationRxnList,inhibitingRxnList,If[OptionValue["Inhibitors"]==={},{},{transition}],exch]];

updateCustomRateLaws[model,correctRatesForBindingSites@FilterRules[Thread[(getID/@model["Fluxes"])->model["Rates"]],_?(StringMatchQ[#,RegularExpression[".*(Activation|Inhibition).*"]]&)]];

(*If[activators==={},unifyRateConstants@model,model]*)
If[OptionValue["ActivationSites"]==0||OptionValue["Activators"]=={},unifyRateConstants@model,model]
];

constructEnzymeModule[rxn_reaction,activatingBindingSites_Integer,inhibitingBindingSites_Integer,activators:({_metabolite..}|{}):{},inhibitors:({_metabolite..}|{}):{},opts:OptionsPattern[]]:=
	constructEnzymeModule[rxn,Sequence@@updateRules[{"ActivationSites"->activatingBindingSites,"InhibitionSites"->inhibitingBindingSites,"Activators"->activators,"Inhibitors"->inhibitors},List[opts]]];


unifyRateConstants[rates_,postfixRegEx_String:"\$\\d+"]:=rates/.s_String:>StringReplace[s,RegularExpression[postfixRegEx]->""]


correctRatesForBindingSites[rates:(_List|_Times)]:=Module[{correctingRules},
correctingRules={
	parameter["Volume",_](-(e2_enzyme[t]/keq_Keq)+e1_enzyme[t]m:$MASS$speciesPattern[t])k_rateconst/;StringMatchQ[getID[k],RegularExpression[".*Activation.*"]]:>(-((Length[getActivators[e2]]e2[t])/keq)+(e1["ActivationSites"]-Length[getActivators[e1]])e1[t] m)k,

parameter["Volume",_](-(e2_enzyme[t]/keq_Keq)+e1_enzyme[t]m:$MASS$speciesPattern[t])k_rateconst/;StringMatchQ[getID[k],RegularExpression[".*Inhibition.*"]]:>(-((Length[getInhibitors[e2]]e2[t])/keq)+(e1["InhibitionSites"]-Length[getInhibitors[e1]])e1[t] m)k,

parameter["Volume",_]-e2_enzyme[t] kRev_rateconst+e1_enzyme[t] m:$MASS$speciesPattern[t] (k_rateconst/;StringMatchQ[getID[k],RegularExpression[".*Activation.*"]]):>-(Length[getActivators[e2]]e2[t]) kRev+(e1["ActivationSites"]-Length[getActivators[e1]])e1[t] m k,

parameter["Volume",_]-e2_enzyme[t] kRev_rateconst+e1_enzyme[t] m:$MASS$speciesPattern[t] (k_rateconst/;StringMatchQ[getID[k],RegularExpression[".*Inhibition.*"]]):>-(Length[getInhibitors[e2]]e2[t]) kRev+(e1["InhibitionSites"]-Length[getInhibitors[e1]])e1[t] m k
};
rates/.correctingRules
];


generateCatalyticReactions::unknownMechanism="`1` is not a valid mechanism. Try \"Ordered\", \"Random\", \"Ping-Pong\".";
Options[generateCatalyticReactions]=Options[constructEnzymeModule];
generateCatalyticReactions[opts:OptionsPattern[]]:=Module[{},
Switch[OptionValue["Mechanism"],
"Ordered",generateCatalyticReactionsOrdered[opts],
"Random",generateCatalyticReactionsRandom[opts],
{(_String->_String)..},generateCatalyticReactionsCleland[OptionValue["Mechanism"],opts],
{_String..},generateCatalyticReactionsFromString[OptionValue["Mechanism"],opts],
_,Message[generateCatalyticReactions::unknownMechanism,OptionValue["Mechanism"]];Abort[];
]
];


Options[generateCatalyticReactionsOrdered]=Options[constructEnzymeModule];
generateCatalyticReactionsOrdered[opts:OptionsPattern[]]:=Module[{activatedForms,numSubstrates,numProducts,fullyBoundSubstrates,fullyBoundProducts},
activatedForms=e["ID"->OptionValue["ID"]<>"_R","BoundActivators"->#]&/@Join[{{}},Sequence@@Table[Union[Sort/@Tuples[#,i]],{i,OptionValue["ActivationSites"]}]]&[OptionValue["Activators"]];
numSubstrates=Length[OptionValue["Substrates"]];
numProducts=Length[OptionValue["Products"]];
fullyBoundSubstrates=Table[bindCatalytic[a,OptionValue["Substrates"]],{a,activatedForms}];
fullyBoundProducts=Table[bindCatalytic[a,OptionValue["Products"]],{a,activatedForms}];
Join[
Flatten[expandEnzyme2elementaryReactions[#,"bind",OptionValue["ID"]<>"_R"]&/@fullyBoundSubstrates],
Flatten[expandEnzyme2elementaryReactions[#,"release",OptionValue["ID"]<>"_R"]&/@fullyBoundProducts],
isomerization[fullyBoundSubstrates,fullyBoundProducts,OptionValue["ID"]<>"_R"]
]
];


Options[generateCatalyticReactionsRandom]=Options[constructEnzymeModule];
generateCatalyticReactionsRandom[opts:OptionsPattern[]]:=Module[{activatedForms,numSubstrates,numProducts,substrPermutations,prodPermutations,fullyBoundSubstrates,fullyBoundProducts},
activatedForms=e["ID"->OptionValue["ID"]<>"_R","BoundActivators"->#]&/@Join[{{}},Sequence@@Table[Union[Sort/@Tuples[#,i]],{i,OptionValue["ActivationSites"]}]]&[OptionValue["Activators"]];
numSubstrates=Length[OptionValue["Substrates"]];
numProducts=Length[OptionValue["Products"]];
substrPermutations=Permutations[#,{Length[#]}]&[OptionValue["Substrates"]];
prodPermutations=Permutations[#,{Length[#]}]&[OptionValue["Products"]];
fullyBoundSubstrates=Flatten@Table[bindCatalytic[a,#]&/@substrPermutations,{a,activatedForms}];
fullyBoundProducts=Flatten@Table[bindCatalytic[a,#]&/@prodPermutations,{a,activatedForms}];
Join[
Flatten[expandEnzyme2elementaryReactions[#,"bind",OptionValue["ID"]<>"_R"]&/@fullyBoundSubstrates],
Flatten[expandEnzyme2elementaryReactions[#,"release",OptionValue["ID"]<>"_R"]&/@fullyBoundProducts],
isomerization[fullyBoundSubstrates,fullyBoundProducts,OptionValue["ID"]<>"_R"]
]
];


generateCatalyticReactionsFromString::multipleEnzymeIDs="The provided mechanism contains multiple enzymes `1`.";
Options[generateCatalyticReactionsFromString]=Options[constructEnzymeModule];
generateCatalyticReactionsFromString[mechanism:{_String..},opts:OptionsPattern[]]:=Module[{countCatalyticallyBound,tmpRxns,tmpRxnsSorted,enzID},
countCatalyticallyBound=Length[Flatten[getCatalytic/@Cases[getSubstrates@#,_enzyme,\[Infinity]]]]&;
tmpRxns=str2mass["tmpID: "<>#]&/@mechanism;
tmpRxns=tmpRxns/.e_enzyme:>enzyme[updateRules[e[[1]],FilterRules[List[opts],{"CatalyticSites","ActivationSites","InhibitionSites"}]]];
tmpRxnsSorted=Sort[tmpRxns,countCatalyticallyBound[#]<countCatalyticallyBound[#2]&];
enzID=If[Length[#]=!=1,Message[generateCatalyticReactionsFromString::multipleEnzymeIDs,#],#[[1]]]&@Union[Cases[tmpRxnsSorted,e_enzyme:>getID[e],\[Infinity]]];
mainCatalyticBranch=MapIndexed[ReplacePart[#,1->enzID<>ToString[First@#2]]&,tmpRxnsSorted];
activatorConfigurations=Flatten[Table[Union[Sort/@Tuples[OptionValue["Activators"],i]],{i,OptionValue["ActivationSites"]}],1];
Join[mainCatalyticBranch,Flatten@Table[uniquePostfix=ToString[Unique[]];mainCatalyticBranch/.e_enzyme:>bindActivators[e,config]/.r_reaction:>ReplacePart[r,1->getID[r]<>uniquePostfix],{config,activatorConfigurations}]]
]


Options[clelandSymbol2entity]=Join[{"SubstrateCharacters"->CharacterRange["A","D"],"EnzymeCharacters"->Join[CharacterRange["E","H"],CharacterRange["T","W"]],
"ProductCharacters"->CharacterRange["P","S"],"EffectorCharacters"->CharacterRange["I","O"]},Options[constructEnzymeModule]];
clelandSymbol2entity::notCleland="`1` is not a valid Cleland notation.";
clelandSymbol2entity::notInRxn="Check your Cleland notation, `1` does not specify a substrate or product in `2`.";
clelandSymbol2entity::notStartingWithEnzyme="`1` does not start with an enzyme character.";
clelandSymbol2entity[clSymbol_String/;StringLength[clSymbol]==1,opts:OptionsPattern[]]:=Module[{},
Quiet[Check[
Piecewise[{
{OptionValue["Substrates"][[Position[OptionValue["SubstrateCharacters"],clSymbol][[1,1]]]],MemberQ[OptionValue["SubstrateCharacters"],clSymbol]},

{OptionValue["Products"][[Position[OptionValue["ProductCharacters"],clSymbol][[1,1]]]],MemberQ[OptionValue["ProductCharacters"],clSymbol]},

{OptionValue["Effectors"][[Position[OptionValue["EffectorCharacters"],clSymbol][[1,1]]]],MemberQ[OptionValue["EffectorCharacters"],clSymbol]},

{enzyme["ID"->OptionValue["ID"]<>StringJoin[Sequence@@Table["*",{Position[OptionValue["EnzymeCharacters"],clSymbol][[1,1]]-1}]],"Compartment"->OptionValue["Compartment"]],MemberQ[OptionValue["EnzymeCharacters"],clSymbol]}

},Message[clelandSymbol2entity::notCleland,clSymbol];Abort[];
],Message[clelandSymbol2entity::notInRxn,clSymbol,Join[OptionValue["Substrates"],OptionValue["Products"]]];Abort[];,{Part::partw}],{Part::partw}]
]
clelandSymbol2entity[clSymbol_String/;StringLength[clSymbol]>1,opts:OptionsPattern[]]:=Module[{elem},
If[!MemberQ[OptionValue["EnzymeCharacters"],StringTake[clSymbol,1]],Message[clelandSymbol2entity::notStartingWithEnzyme,clSymbol];Abort[];];
elem=clelandSymbol2entity[#,opts]&/@StringSplit[clSymbol,""];
bindCatalytic[elem[[1]],elem[[2;;]]]
];


ClearAll@clelandEdge2rxn
Options[clelandEdge2rxn]=Options[constructEnzymeModule];
clelandEdge2rxn[edge_Rule,opts:OptionsPattern[]]:=Module[{node1,node2,cat1,cat2,complement,postfix},
node1=clelandSymbol2entity[edge[[1]],opts];
node2=clelandSymbol2entity[edge[[2]],opts];
{cat1,cat2}=getCatalytic/@{node1,node2};
postfix="("<>StringReplace[ToString[edge]," "..->""]<>")";
Piecewise[
{
{r[OptionValue["ID"]<>"_Catalysis_Transition"<>postfix,{node1},{node2},{1,1},True],Length[cat1]==Length[cat2]||(MemberQ[OptionValue["Substrates"],Alternatives@@cat1]&&MemberQ[OptionValue["Products"],Alternatives@@cat2])},
{complement=Complement[getCatalytic[node2],getCatalytic[node1]];r[OptionValue["ID"]<>"_Catalysis_Bind"<>postfix,{node1,Sequence@@complement},{node2},{1,Sequence@@Table[1,{Length[complement]}],1},True],Length[cat1]<Length[cat2]},
{complement=Complement[getCatalytic[node1],getCatalytic[node2]];r[OptionValue["ID"]<>"_Catalysis_Release"<>postfix,{node1},{node2,Sequence@@complement},{1,Sequence@@Table[1,{Length[complement]}],1},True],Length[cat1]>Length[cat2]}
(*,
{complement=Complement[getCatalytic[node1],getCatalytic[node2]];r[getID[elemRxn]<>"_R"<>"_Catalysis_Competitive_Inhibition"<>postfix,{node1},{node2,Sequence@@complement},{1,Sequence@@Table[1,{Length[complement]}],1},True],}
*)}
]
];


Options[generateCatalyticReactionsCleland]=Options[constructEnzymeModule];
generateCatalyticReactionsCleland[clelandGraph:{(_String->_String)..},opts:OptionsPattern[]]:=Module[{enzRxns},
enzRxns=clelandEdge2rxn[#,opts]&/@clelandGraph;
enzRxns=Flatten[Join[{enzRxns},enzRxns/.e_enzyme:>bindActivators[e,#]&/@Flatten[Table[Union[Sort/@Tuples[OptionValue["Activators"],i]],{i,OptionValue["ActivationSites"]}],1]]]/.reaction[id_String,otherStuff__]:>reaction[id<>ToString[Unique[]],otherStuff];
enzRxns
];


expandEnzyme2elementaryReactions[enzymeForm_enzyme,"bind",rxnIDprefix_String]:=Module[{tmpEform,len,result},
len=Length[getCatalytic[enzymeForm]];
tmpEform=enzymeForm;

Table[
{tmpEform,result}={#[[1]],r[rxnIDprefix<>"_Catalysis_Bind_"<>ToString[len+1-i]<>ToString[Unique[]],#,{tmpEform},{1,1,1}]}&[dropCatalytic[#]]&@tmpEform;
result
,{i,1,len}]
];


expandEnzyme2elementaryReactions[enzymeForm_enzyme,"release",rxnIDprefix_String]:=Module[{tmpEform,len,result},
len=Length[getCatalytic[enzymeForm]];
tmpEform=enzymeForm;
Table[
{tmpEform,result}={#[[1]],r[rxnIDprefix<>"_Catalysis_Release_"<>ToString[i]<>ToString[Unique[]],{tmpEform},#,{1,1,1}]}&[dropCatalytic[#]]&@tmpEform;
result
,{i,1,len}]
];
isomerization[enzymeForms1:{_enzyme..},enzymeForms2:{_enzyme..},rxnIDprefix_String]:=Flatten[Table[r[rxnIDprefix<>"_Catalysis_Transition"<>ToString[Unique[]],{e1},{e2},{1,1},True],{e1,enzymeForms1},{e2,enzymeForms2}]]


(* ::Subsection:: *)
(*King-Altman Method*)


kineticMatrix[model_MASSmodel]:=Module[{enzPos,enzForms,ssEquations},
enzPos=Flatten[Position[model["Species"],_enzyme]];
enzForms=model["Species"][[enzPos]];
ssEquations=model["ODE"][[enzPos]][[All,2]]/.elem_[t]:>elem;
{enzForms,Normal[CoefficientArrays[ssEquations,enzForms]][[2]]}
];


KingAltmanPatterns[model_MASSmodel]:=Module[{kMat,distributionTerms,kJJ,enzForms},
{enzForms,kMat}=kineticMatrix[model];
distributionTerms=Table[
(*kMatJ=ReplacePart[kMat,{_,i}->1];*)
kJJ=kMat[[#,#]]&[Drop[Range[1,Length[kMat]],{i}]];
enzForms[[i]]->anonymize[Det[kJJ]],{i,1,Length[enzForms]}
];
Table[enzForms[[i]]->(distributionTerms[[i,2]]/(Plus@@distributionTerms[[All,2]]))*parameter["Etot"],{i,1,Length[distributionTerms]}]
];


(* ::Subsection::Closed:: *)
(*End*)


End[]
