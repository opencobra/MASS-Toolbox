(* ::Package:: *)

(* ::Title:: *)
(*IO*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


(* ::Subsection::Closed:: *)
(*IO*)


importModel::fileNotExist="File `1` does not exist.";
importModel::notModel="File `1` does not contain a model.";
Options[importModel]=Options[constructModel];
importModel[]:=importModel[SystemDialogInput["FileOpen"]];
importModel[path_String,opts:OptionsPattern[]]:=Module[{stuff},
    If[!FileExistsQ[path],Message[importModel::fileNotExist,path];Abort[];];
    stuff=Import[path,"Package"];
    If[!MatchQ[stuff,_MASSmodel],Message[importModel::notModel,path];Abort[];];
    constructModel[
        stuff["Reactions"],
        Sequence@@updateRules[
            FilterRules[stuff[[1]],Except[{"Stoichiometry","Species","Fluxes","ReversibleColumnIndices"}]],
            List@opts
        ]
    ]
];


(* ::Subsection::Closed:: *)
(*Matlab*)


grRules2gpr[grRules_List,rxnIDs_List]:=Module[{blub1,blub2,prot2gene,rxn2prot},
blub1=Flatten[ToExpression[StringReplace[StringReplace[#,{"and"->"&&","or"->"||","("->"{",")"->"}"}],RegularExpression["([^\\s\\{\\}\\|\\&]+)"]:>"gene[\""<>"$1"<>"\"]"]]/.pat1:{_gene}:>pat1[[1]]/.pat2:{HoldPattern@And[__gene]}:>geneComplex@@pat2[[1]]&/@Flatten[grRules]];
blub2=#/.pat1:(_geneComplex|_gene):>(protein["Unknown"<>ToString[Unique[]]]->pat1)&/@blub1;
prot2gene=Union[Cases[blub2,r_Rule/;r[[1,0]]===protein,\[Infinity]]];
rxn2prot=DeleteCases[#[[1]]->(#[[2]]/.r_Rule/;r[[1,0]]===protein:>r[[1]]/.pat:HoldPattern[And[__protein]]:>proteinComplex@@pat)&/@Thread[{rxnIDs,blub2}],r_Rule/;r[[2]]===Null];
Join[rxn2prot,prot2gene]
];


mat2model::noModelFound="No model found in `1`.";
mat2model[stuff:{_Rule...}]:=Module[{modelStructsFound,rxnIDs,irrev,constr,gpr,grRules},
	modelStructsFound=Cases[stuff,r_Rule/;MatchQ[r[[2]],{_Rule..}]&&Length[Intersection[r[[2,All,1]],{"S","rxns","mets","rev","lb","ub"}]]==6,1];
	If[modelStructsFound==={},Message[mat2model::noModelFound,FileNameTake[path]];Abort[];];
	Table[
		rxnIDs=Flatten["rxns"/.struct[[2]]];
		irrev=rxnIDs[[(Flatten@Position["rev"/.struct[[2]],{0.|0|False}])]];
		constr=Thread[Rule[rxnIDs,Thread[{Flatten["lb"/.struct[[2]]],Flatten["ub"/.struct[[2]]]}]]];
		grRules=Flatten["grRules"/.struct[[2]]/."grRules"->{}];
		gpr=If[grRules==={},{},grRules2gpr[grRules,rxnIDs]];
		struct[[1]]->constructModel["S"/.struct[[2]],
			str2mass[#]&/@Flatten["mets"/.struct[[2]]],
			rxnIDs,
			"Irreversible"->irrev,
			"ID"->struct[[1]],
			"Name"->("description"/.struct[[2]]/."description"->""),
			"Constraints"->constr,"GPR"->gpr
			]
	,{struct,modelStructsFound}]
];

mat2model[stuff_Rule]:=mat2model[{stuff}]

mat2model[path_String]:=Module[{stuff},
	Check[stuff=Import[path,{"MAT","LabeledData"}],Abort[];,{Import::nffil}];
	mat2model[stuff]
];

mat2model[]:=mat2model[SystemDialogInput["FileOpen"]];


(* ::Subsection::Closed:: *)
(*SBML import*)


(* ::Subsubsection:: *)
(*Utilities*)


sbmlString2Number[nmbrStr_String]:=Flatten[ImportString[nmbrStr,"Table"]][[1]]/.{"INF"->Infinity,"-INF"->-Infinity,"NaN"->NaN}

cleanUpMathML[math:XMLElement["math",_,_]]:=Module[{adjustments},
	adjustments={
		stuff:XMLElement["csymbol",{"encoding"->"text","definitionURL"->"http://www.sbml.org/sbml/symbols/time"},_]:>ReplacePart[stuff,3->{"t"}],
		stuff:XMLElement["csymbol",{"encoding"->"text","definitionURL"->"http://www.sbml.org/sbml/symbols/avogadro"},_]:>ReplacePart[stuff,3->{"avogadro"}],
		pat3:XMLElement["csymbol",{"encoding"->"text","definitionURL"->"http://www.sbml.org/sbml/symbols/delay"},_]:>ReplacePart[pat3,3->{"delay"}]
	};
	math/.XMLElement["ci",b_,c_List]:>XMLElement["ci",b,"\""<>#<>"\""&/@c]/.adjustments
];

(*mathML2mass=Replace[XML`MathML`SymbolicMathMLToExpression[cleanUpMathML[#]],s:(_Symbol):>StringReplace[ToString[s],"$UNDRSCR$"->"_"],{0,\[Infinity]},Heads->False]/.Complex[0,a_]:>Sign[a]"I"(*/.Dispatch[{"Pi"->Pi,"E"->E,"avogadro"->6.0221415`*^23,Global`avogadro->6.0221415`*^23}]*)&;*)
mathML2mass=XML`MathML`SymbolicMathMLToExpression[cleanUpMathML[#(*/.s_String\[RuleDelayed]StringReplace[s,"_"\[Rule]"$UNDRSCR$s"]*)]]&;


(* ::Subsubsection:: *)
(*listOfEvents*)


parseEventTriggerXML[event:XMLElement["event",_,__]]:=mathML2mass[extractXMLelement[event,"trigger",2][[1]]]
parseEventPriorityXML[event:XMLElement["event",_,__]]:=If[#==={},Automatic,mathML2mass[#[[1]]]]&[extractXMLelement[event,"priority",2]]
parseEventAssignmentsXML[event:XMLElement["event",_,__]]:=Module[{tmp},
	tmp=query["variable",#[[2]]]->mathML2mass[#[[3,1]]]&/@extractXMLelement[event,"listOfEventAssignments",2];\
	If[query["useValuesFromTriggerTime",event[[2]],"true"]/.{"true"->True,"false"->False},tmp[[All,1]]->tmp[[All,2]],tmp]
];
parseEventDelayXML[event:XMLElement["event",_,__]]:=If[#==={},{},t->t+mathML2mass[#[[1]]]]&[extractXMLelement[event,"delay",2]]
getListOfEvents[xml_/;Head[xml]===XMLObject["Document"],id2massID:{(_String->(_parameter|_parameter[t]|_species|_species[t]|_Symbol|_?NumberQ))..}]:=Module[{listOfEvents},
	listOfEvents=extractXMLelement[xml,"listOfEvents",2];
	Scan[If[parseEventDelayXML[#]=!={},Message[sbml2model::eventDelayDetected];Abort[];]&,listOfEvents];
	listOfEvents=(query["id",#[[2]],ToString[Unique[]]]->
		(WhenEvent[Evaluate[parseEventTriggerXML[#]/.Dispatch[id2massID],parseEventAssignmentsXML[#]/.Dispatch[id2massID],"Priority"->parseEventPriorityXML[#]]])&/@listOfEvents);
	listOfEvents
]


(* ::Subsubsection:: *)
(*listOfInitialAssignments*)


parseInitialAssignmentXML[initialAssignment_XMLElement,id2massID:{_Rule..}]:=(("symbol"/.Dispatch[initialAssignment[[2]]])->mathML2mass[extractXMLelement[initialAssignment[[3]],"math",0][[1]]])/.Dispatch[id2massID/.elem_[t]/;!MatchQ[elem,parameter["Volume",_]]:>elem]
getListOfInitialAssignments[xml_/;Head[xml]===XMLObject["Document"],id2massID:{(_String->(_parameter|_parameter[t]|_species|_species[t]|_Symbol|_?NumberQ))..}]:=parseInitialAssignmentXML[#,id2massID]&/@extractXMLelement[xml,"listOfInitialAssignments",2]


(* ::Subsubsection:: *)
(*listOfRules*)


parseRuleXML::unrecognizedRule="Rule of type `1` not recognized.";
parseRuleXML[rule_XMLElement,id2massID:{_Rule..}]:=Module[{},
Switch[#[[1]],
	"assignmentRule","assignmentRule"->(("variable"/.Dispatch[#[[2]]])->(mathML2mass[extractXMLelement[#[[3]],"math",0][[1]]]))/.Dispatch[id2massID],
	(*FIXME: rate rules might contain variables that are not covered by id2mass leading to D["var", t] -> 0*)
	"rateRule","rateRule"->(D["variable"/.Dispatch[#[[2]]]/.Dispatch[id2massID],t])==(mathML2mass[extractXMLelement[#[[3]],"math",0][[1]]]/.Dispatch[id2massID]),
	"algebraicRule","algebraicRule"->(0==mathML2mass[extractXMLelement[#[[3]],"math",0][[1]]]/.Dispatch[id2massID]),
	_,Message[parseRuleXML::unrecognizedRule,#[[1]]]Abort[];
]&[rule]
];
getListOfRules[xml_/;Head[xml]===XMLObject["Document"],id2massID:{(_String->(_parameter|_parameter[t]|_species|_species[t]|_Symbol|_?NumberQ))..}]:=parseRuleXML[#,id2massID]&/@extractXMLelement[xml,"listOfRules",2]


(* ::Subsubsection:: *)
(*listOfFunctionDefinitions*)


(*parseFunctionXML[XMLElement["functionDefinition",attrVal:{_Rule..},mathML_List]]:=("id"/.Dispatch[attrVal])->mathML2mass[extractXMLelement[mathML,"math",0][[1]]]*)
parseFunctionXML[XMLElement["functionDefinition",attrVal:{_Rule..},mathML_List]]:=("id"/.Dispatch[attrVal])->XML`MathML`SymbolicMathMLToExpression[extractXMLelement[mathML,"math",0][[1]]/.s_String:>StringReplace[s,"_"->"$UNDRSCR$s"]]

getListOfFunctionDefinitions[xml_/;Head[xml]===XMLObject["Document"],opts:OptionsPattern[]]:=Module[{},
parseFunctionXML/@extractXMLelement[xml,"listOfFunctionDefinitions",2]
];


(* ::Subsubsection:: *)
(*listOfUnitDefinitions*)


sbmlBaseUnit2mathematica={"ampere"->Quantity[1,"Amperes"],"avogadro"->Quantity[1,"Moles"],"becquerel"->Quantity[1,"Becquerels"],"candela"->Quantity[1,"Candelas"],
	"coulomb"->Quantity[1,"Coulombs"],"dimensionless"->1,"farad"->Quantity[1,"Farads"],"joule"->Quantity[1,"Joules"],"lux"->Quantity[1,"Lux"],"gram"->Quantity[1,"Grams"],
	"katal"->Quantity[1,("Moles")/("Seconds")],"metre"->Quantity[1,"Meters"],"gray"->GrayLevel[0.5],"kelvin"->Quantity[1,"Kelvins"],"mole"->Quantity[1,"Moles"],"henry"->Quantity[1,"Henries"],
	"kilogram"->Quantity[1,"Kilograms"],"newton"->Quantity[1,"Newtons"],"hertz"->Quantity[1,"Hertz"],"litre"->Quantity[1,"Liters"],"ohm"->Quantity[1,"Ohms"],"item"->Quantity[1,IndependentUnit["Items"]],
	"lumen"->Quantity[1,"Lumens"],"pascal"->Quantity[1,"Pascals"],"radian"->Quantity[1,"Radians"],"volt"->Quantity[1,"Volts"],"second"->Quantity[1,"Seconds"],"watt"->Quantity[1,"Watts"],"siemens"->Quantity[1,"Siemens"],
	"weber"->Quantity[1,"Webers"],"sievert"->Quantity[1,("Joules")/("Kilograms")],"steradian"->Quantity[1,"Steradians"],"tesla"->Quantity[1,"Teslas"]};
sbmlDefaultUnits={"substance"->Quantity[1,"Moles"],"volume"->Quantity[1,"Liters"],"area"->Quantity[1,("Meters")^2],"length"->Quantity[1,"Meters"],"time"->Quantity[1,"Seconds"]};
unitDefDefaults={"scale"->"0","multiplier"->"1","exponent"->"1"};

sbmlUnitPrefixes={Quantity[10^3,unit_String]:>Quantity[1,"Kilo"<>ToLowerCase[unit]],Quantity[10^-3,unit_String]:>Quantity[1,"Milli"<>ToLowerCase[unit]],Quantity[10^-6,unit_String]:>Quantity[1,"Micro"<>ToLowerCase[unit]],Quantity[10^-9,unit_String]:>Quantity[1,"Nano"<>ToLowerCase[unit]],Quantity[60,"Seconds"]:>Quantity[1,"Minutes"],Quantity[3600,"Seconds"]:>Quantity[1,"Hours"],Quantity[10^-15,"Liters"]:>Quantity[1,"Microns"^3]};

(*parseUnitXML[XMLElement["unit",attrVal:{_Rule..},_]]:=(10^sbmlString2Number["scale"/.attrVal/.unitDefDefaults]*sbmlString2Number["multiplier"/.attrVal/.unitDefDefaults]*("kind"/.attrVal)^sbmlString2Number["exponent"/.attrVal/.unitDefDefaults])/.Dispatch[sbmlBaseUnit2mathematica]*)

parseUnitXML[XMLElement["unit",attrVal:{_Rule..},_]]:=(10^sbmlString2Number["scale"/.attrVal/.unitDefDefaults]*sbmlString2Number["multiplier"/.attrVal/.unitDefDefaults]*("kind"/.attrVal)^sbmlString2Number["exponent"/.attrVal/.unitDefDefaults])/.Dispatch[sbmlBaseUnit2mathematica]/.sbmlUnitPrefixes

parseListOfUnitsXML[XMLElement["listOfUnits",_,units_List]]:=Times@@(parseUnitXML/@units)

makeValidSymbol=StringReplace[#,RegularExpression["([^a-zA-Z0-9])"]:>("$"<>ToString[ToCharacterCode["$1"][[1]]]<>"$")]&
parseUnitDefinitionXML[XMLElement["unitDefinition",attrVal:{_Rule..},listOfUnits_List]]:=
	("id"/.attrVal)->(parseListOfUnitsXML[extractXMLelement[listOfUnits,"listOfUnits",0][[1]]])

getListOfUnitDefinitions[xml_/;Head[xml]===XMLObject["Document"],opts:OptionsPattern[]]:=Module[{},
	(*Join[updateRules[sbmlDefaultUnits,parseUnitDefinitionXML/@extractXMLelement[xml,"listOfUnitDefinitions",2]],sbmlBaseUnit2mathematica,{elem_String\[RuleDelayed]Quantity[1,elem]}]*)
	Join[updateRules[sbmlDefaultUnits,parseUnitDefinitionXML/@extractXMLelement[xml,"listOfUnitDefinitions",2]],sbmlBaseUnit2mathematica,{elem_String:>Quantity[1,elem]}]
]


(* ::Subsubsection:: *)
(*listOfSpecies*)


parseSpeciesXML[xml:XMLElement["species",attrVal_List,data_List]]:=Module[{},
	If[query["constant", attrVal, "false"]==="false",(species["id","compartment"]/.Dispatch[attrVal])[t],species["id","compartment"]/.Dispatch[attrVal]]->attrVal
];
getListOfSpecies[xml_/;Head[xml]===XMLObject["Document"],opts:OptionsPattern[]]:=Module[{listOfSpecies},
	listOfSpecies=extractXMLelement[xml,"listOfSpecies",2];
	parseSpeciesXML/@listOfSpecies
	
];


getInitialConcentrations[listOfSpecies:{((_species[t]|_species)->_List)...},unitDefinitions:{(_Rule|_RuleDelayed)..}]:=Module[{init,unit,hasOnlySubstanceUnits,volume},
Table[
	unit=query["substanceUnits", spec[[2]], "substance"]/.Dispatch[unitDefinitions];
	volume="volume"/.unitDefinitions;
	init="initialConcentration"/.Dispatch[spec[[2]]];
	If[init=="initialConcentration",
	(* initialAmount is given*)
		init=(sbmlString2Number[("initialAmount"/.Dispatch[spec[[2]]])]*unit)/parameter["Volume",getCompartment[spec[[1]]]];,
	(* initialConcentration is given*)
		init=sbmlString2Number[init]*unit*volume^-1;
	];
	init=init/."initialAmount"->Indeterminate;
	spec[[1]]->init
	,{spec,listOfSpecies/.elem_[t]:>elem}]
];


getHasOnlySubstanceUnits[listOfSpecies:{((_species[t]|_species)->_List)...}]:=stripTime[If[(query["hasOnlySubstanceUnits",#[[2]],"false"]/.{"true"->True,"false"->False}),#[[1]],Unevaluated[Sequence[]]]&/@listOfSpecies];


getBoundaryConditions[listOfSpecies:{((_species|_species[t])->_List)...}]:=Cases[listOfSpecies/.elem_[t]:>elem,r_Rule/;("boundaryCondition"/.r[[2]])==="true"&&query["constant",r[[2]],"false"]==="false":>r[[1]]]


(* ::Subsubsection::Closed:: *)
(*listOfCompartments*)


parseCompartmentXML[XMLElement["compartment",attrVal:{_Rule..},{___}]]:=If[("constant"/.attrVal/."constant"->"true")==="false",parameter["Volume",("id"/.attrVal)][t],parameter["Volume",("id"/.attrVal)]]->FilterRules[attrVal,Except["id"]]

getListOfCompartments[xml_/;Head[xml]===XMLObject["Document"]]:=Module[{},
	parseCompartmentXML/@extractXMLelement[xml,"listOfCompartments",2]
];


getCompartmentVolumes[listOfCompartments:{((parameter["Volume",_String]|parameter["Volume",_String][t])->_List)...},unitDefinitions:{(_Rule|_RuleDelayed)...}]:=#[[1]]->sbmlString2Number[query["size",#[[2]],"1"]]*(query["units",#[[2]],"volume"]/.Dispatch[unitDefinitions])&/@listOfCompartments


(* ::Subsubsection:: *)
(*listOfReactions*)


parseReactionXML::fastReactionDetected="The toolbox does not support fast reactions. 'fast' flag ignored for reaction `1`.";
parseReactionXML[xml:XMLElement["reaction",{_Rule...},_List],id2massID:{(_String->(_parameter|_parameter[t]|_species|_species[t]|_Symbol|_?NumberQ))..}]:=Module[{id,revQ,listOfReactants,listOfProducts,substr,prod,stoich,fastQ},
	id="id"/.Dispatch[xml[[2]]];
	fastQ="fast"/.Dispatch[xml[[2]]]/."fast"->"false";
	If[fastQ==="true",Message[parseReactionXML::fastReactionDetected,id]];
	revQ=("reversible"/.Dispatch[xml[[2]]])/.{"reversible"->True,"true"->True,"false"->False};
	listOfReactants=getListOfReactants[xml];
	listOfProducts=getListOfProducts[xml];
	substr=listOfReactants[[All,1]]/.Dispatch[id2massID];
	prod=listOfProducts[[All,1]]/.Dispatch[id2massID];
	stoich=getStoich[#[[2]],id2massID]&/@Join[listOfReactants,listOfProducts];
	(*stoich="stoichiometry"/.Dispatch[#[[2]]]/.s_String:>sbmlString2Number[s]/.Dispatch[id2massID]/."stoichiometry"->1&/@Join[listOfReactants,listOfProducts];*)
	reaction[id,substr,prod,stoich,revQ]
];


parseSpeciesReference[XMLElement["speciesReference",attrVal:{_Rule...},{XMLElement["stoichiometryMath",{___},{math:XMLElement["math",_,_]}]}]]:=("species"/.attrVal)->updateRules[FilterRules[attrVal,Except["species"]],{"stoichiometry"->mathML2mass[math]}]
parseSpeciesReference[XMLElement["speciesReference",attrVal:{_Rule...},{___}]]:=("species"/.attrVal)->FilterRules[attrVal,Except["species"]]

getListOfReactants[XMLElement["reaction",{_Rule...},data_List]]:=Module[{},
	parseSpeciesReference/@extractXMLelement[data,"listOfReactants",2]
];
getListOfProducts[XMLElement["reaction",{_Rule...},data_List]]:=Module[{},
	parseSpeciesReference/@extractXMLelement[data,"listOfProducts",2]
];

getListOfReactions[xml_/;Head[xml]===XMLObject["Document"],id2massID:{(_String->(_parameter|_parameter[t]|_species|_species[t]|_Symbol|_?NumberQ))..},opts:OptionsPattern[]]:=Module[{listOfReactions},
	listOfReactions=extractXMLelement[xml,"listOfReactions",2];
	parseReactionXML[#,id2massID]&/@listOfReactions
];

getStoich::fishyStoich="Something is wrong with the stoichiometry in `1`.";
getStoich[attrVal:{_Rule...},id2massID:{(_String->(_parameter|_parameter[t]|_species|_species[t]|_Symbol|_?NumberQ))..}]:=Module[{id,stoich},
	id=query["id",attrVal,None];
	stoich=query["stoichiometry",attrVal,None];
	Which[
		id===None,query["stoichiometry",attrVal,1]/.Dispatch[id2massID]/.s_String:>sbmlString2Number[s],
		MatchQ[id,_String]&&stoich===None,id,
		MatchQ[id,_String]&&stoich=!=None,query["stoichiometry",attrVal,1]/.Dispatch[id2massID]/.s_String:>sbmlString2Number[s],
		True,Message[getStoich::fishyStoich,attrVal]
	]
(*	Switch[id,
		None,query["stoichiometry",attrVal,1]/.Dispatch[id2massID]/.s_String:>sbmlString2Number[s],
		_String,id
	]*)
];


(* ::Subsubsection:: *)
(*kineticLaw*)


getListOfKineticLawsAndLocalParameters[xml_/;Head[xml]===XMLObject["Document"],
id2massID:{(_String->(_parameter|_parameter[t]|_species|_species[t]|_Symbol|_?NumberQ))..},listOfFunctionDefinitions:{_Rule...},opts:OptionsPattern[]]:=Module[{rxnID,listOfReactions,compartmentID2compartment,law,param},
	listOfReactions=extractXMLelement[xml,"listOfReactions",2];
	Table[
		rxnID="id"/.rxn[[2]];
		{law,param}=getKineticLaw[rxn];
		rxnID->{law/.Dispatch[Join[{escape_parameter:>escape},id2massID]]/.Dispatch[listOfFunctionDefinitions],param}
	,{rxn,listOfReactions}]
];

getKineticLaw::moreThanOneLaw="More than one kinetic law encountered for reaction `1`.";
getKineticLaw[XMLElement["reaction",attrVal:{_Rule..},data_List]]:=
	Which[
		Length[#]==1,getKineticLaw[#[[1]],"id"/.Dispatch[attrVal]],
		Length[#]==0,None, 
		True,Message[getKineticLaw::moreThanOneLaw,"id"/.Dispatch[attrVal]]
	]&@extractXMLelement[data,"kineticLaw",0]

getKineticLaw[XMLElement["kineticLaw",attrVal:{_Rule...},data_List],rxnID_String]:=Module[{equation,parameters,law,localParameters,localParameterID2mass,mathML},
	mathML=extractXMLelement[data,"math",0][[1]];
	law=mathML2mass[mathML];
	localParameters=getListOfLocalParameters[data,rxnID];
	localParameterID2mass=getID[#/.elem_[t]:>elem][[1]]->#&/@localParameters[[All,1]];
	{law/.localParameterID2mass,localParameters}
];


(* ::Subsubsection::Closed:: *)
(*parameters*)


parseGlobalParameterXML[XMLElement["parameter",attrVal:{_Rule..},{___}]]:=Module[{},
	If[query["constant",attrVal,"true"]==="true",#,#[t]]&[parameter["id"/.Dispatch[attrVal]]/.Dispatch[attrVal]]->attrVal
];
getListOfGlobalParameters[xml_/;Head[xml]===XMLObject["Document"]]:=Module[{},
parseGlobalParameterXML/@extractXMLelement[xml,"listOfParameters",2,5]
];


parseLocalParameterXML[XMLElement["parameter"|"localParameter",attrVal:{_Rule..},{___}],rxnID_String]:=Module[{},
	If[query["constant",attrVal,"true"]==="true",#,#[t]]&[parameter["id"/.Dispatch[attrVal],rxnID]]->attrVal
];
getListOfLocalParameters[xml_,rxnID_String]:=Module[{listOfReactions},
	Flatten[parseLocalParameterXML[#,rxnID]&/@extractXMLelement[xml,"listOfParameters"|"listOfLocalParameters",2]]
];


getListOfParameters[xml_/;Head[xml]===XMLObject["Document"]]:=Module[{},
(*Join[getListOfLocalParameters[xml],getListOfGlobalParameters[xml]]*)
getListOfGlobalParameters[xml]
];


getParameterValues[listOfParameters:{((_parameter|_parameter[t])->_List)...}]:=#[[1]]->sbmlString2Number["value"/.Dispatch[#[[2]]]/."value"->"Indeterminate"]&/@listOfParameters


(* ::Subsubsection:: *)
(*main*)


xmlReaction2reaction[elem_XMLElement,species2compartment_List,boundaryConditions_List]:=Module[{id,revQ,listOfReactants,listOfProducts,substr,prod,stoich},
	id="id"/.Dispatch[elem[[2]]];
	revQ=("reversible"/.Dispatch[elem[[2]]])/.{"reversible"->True,"true"->True,"false"->False};
	listOfReactants=extractXMLelement[elem,"listOfReactants",2];
	listOfProducts=extractXMLelement[elem,"listOfProducts",2];
	listOfReactants=Select[listOfReactants,!MemberQ[boundaryConditions,"species"/.#[[2]]]&];
	listOfProducts=Select[listOfProducts,!MemberQ[boundaryConditions,"species"/.#[[2]]]&];
	If[listOfReactants==={},
		substr={},
		substr=metabolite[#,#/.Dispatch[species2compartment]]&["species"/.Dispatch[#[[2]]]]&/@listOfReactants;
	];
	If[listOfProducts==={},
		prod={};,
		prod=metabolite[#,#/.Dispatch[species2compartment]]&["species"/.Dispatch[#[[2]]]]&/@listOfProducts;
	];
	stoich=ToExpression[StringReplace[query["stoichiometry",#[[2]],"1"],"e"->"*10^"]]&/@Join[listOfReactants,listOfProducts];
	r[id,substr,prod,stoich,revQ]
];


Options[sbml2reactions]={"RemoveBoundaryConditions"->True};
sbml2reactions[path_String,opts:OptionsPattern[]]:=Module[{xml,species2compartment,rxns,tmpRxns},
xml=Import[path,"XML"];
sbml2reactions[xml]
];
sbml2reactions[xml_/;Head[xml]===XMLObject["Document"],opts:OptionsPattern[]]:=Module[{listOfSpecies,boundaryConditionsAsParameters,species2initialConditions,species2compartment,boundaryConditions,tmpRxns,rxnsLawsAndParams,rxns,laws,params},
	listOfSpecies=Cases[xml,XMLElement["listOfSpecies",_,species_List]:>species,\[Infinity]][[1]];
	species2compartment=("id"/.Dispatch[#[[2]]])->("compartment"/.Dispatch[#[[2]]])&/@listOfSpecies;
	species2initialConditions=DeleteCases[(metabolite[#,#/.Dispatch[species2compartment]]&["id"/.Dispatch[#[[2]]]])->ToExpression[StringReplace["initialConcentration"/.Dispatch[#[[2]]]/."initialConcentration"->"","e"->" 10^"]]&/@listOfSpecies,r_Rule/;r[[2]]===Null,\[Infinity]];

	If[OptionValue["RemoveBoundaryConditions"],
		boundaryConditions="id"/.#&/@Select[listOfSpecies[[All,2]],("boundaryCondition"/.#)==="true"&];
		boundaryConditionsAsParameters=Cases[species2initialConditions,r_Rule/;MemberQ[boundaryConditions,getID[r[[1]]]]];,
		boundaryConditionsAsParameters={};
		boundaryConditions={};
	];
	species2initialConditions=Complement[species2initialConditions,boundaryConditionsAsParameters];
	tmpRxns=Cases[xml,XMLElement["listOfReactions",_,reactions_List]:>reactions,\[Infinity]][[1]];
	If[$FrontEnd=!=Null,
		Monitor[ReleaseHold[#],ProgressIndicator[i,{1,Length@tmpRxns}]];,
		ReleaseHold[#];
	]&@Hold[rxnsLawsAndParams=Table[
		{
		xmlReaction2reaction[tmpRxns[[i]],species2compartment,boundaryConditions],
		{}
		},{i,1,Length[tmpRxns]}]];
	rxns=rxnsLawsAndParams[[All,1]];
	{rxns,{},{},{}}
];


Options[sbml2modelSimple]={"RemoveBoundaryConditions"->True,"ImportRateLaws"->False};
sbml2modelSimple::NotExistFile="File `1` does not exist.";
sbml2modelSimple[path_String,opts:OptionsPattern[]]:=Module[{xml},
	If[!FileExistsQ[path],Message[sbml2model::NotExistFile,path];Abort[];];
	xml=Import[path,"XML"];
	sbml2modelSimple[xml,opts]
];

sbml2modelSimple[xml_/;Head[xml]===XMLObject["Document"],opts:OptionsPattern[]]:=Module[{modelInfo,modelID,modelName,rxns,laws,params,xmlNotes2txt,notes,ic},
	xmlNotes2txt=ImportString[ExportString[XMLObject["Document"][{XMLObject["Declaration"]["Version"->"1.0","Standalone"->"yes"]},XMLElement["html",{"version"->"-//W3C//DTD HTML 4.01 Transitional//EN",{"http://www.w3.org/2000/xmlns/","xmlns"}->"http://www.w3.org/1999/xhtml"},{XMLElement["head",{},{XMLElement["meta",{"name"->"generator","content"->"Adobe GoLive"},{}],XMLElement["title",{},{"Your Website"}],XMLElement["style",{"type"->"text/css","media"->"screen"},{"<!--\n\t\t\t#outline { position: relative; height: 800px; width: 800px; margin: 18px auto 0; border: solid 1px #999; }\n\t\t\t#caption { width: 260px; left: 48px; top: 318px; position: absolute; visibility: visible; }\n\t\t\t#text { left: 336px; top: 318px; position: absolute; width: 400px; visibility: visible; margin-top: 10px; }\n\t\t\t#title { width: 800px; top: 100px; position: absolute; visibility: visible; }\n\t\t\tp { color: #666; font-size: 16px; font-family: \"Lucida Grande\", Arial, sans-serif; font-weight: normal; margin-top: 0; }\n\t\t\th1 { color: #778fbd; font-size: 20px; font-family: \"Lucida Grande\", Arial, sans-serif; font-weight: 500; line-height: 32px; margin-top: 4px; }\n\t\t\th2 { color: #778fbd; font-size: 18px; font-family: \"Lucida Grande\", Arial, sans-serif; font-weight: normal; margin: 0.83em 0 0; }\n\t\t\th3 { color: #666; font-size: 60px; font-family: \"Lucida Grande\", Arial, sans-serif; font-weight: bold; text-align: center; letter-spacing: -1px; width: auto; }\n\t\t\th4 { font-weight: bold; text-align: center; margin: 1.33em 0; }\n\t\t\ta { color: #666; text-decoration: underline; }\n\t\t-->"}]}],#}],{}],"XML"],"HTML"]&;
	modelInfo=Cases[xml,XMLElement["model",info_,_]:>info,\[Infinity]][[1]];
	modelID=query["id",modelInfo,Automatic];
	modelName=query["name",modelInfo,Automatic];
	notes=If[#==={},"",xmlNotes2txt[#[[1,3,1]]]]&[Cases[xml,XMLElement["notes",__],5]];
	{rxns,laws,params,ic}=sbml2reactions[xml,opts];
	constructModel[rxns,"ID"->modelID,"Name"->modelName,"CustomRateLaws"->laws,"Parameters"->params,"Notes"->notes,"InitialConditions"->ic,"ReorderStoichiometry"->False]
];


Options[sbml2model]=Join[{"Method"->"Full"},Options[constructModel]];
sbml2model::NotExistFile="File `1` does not exist.";
sbml2model::nonValidMethod="SBML import method `1` is not provided. Try \"Full\" or \"Light\" instead.";
sbml2model::eventDetected="The MASS Toolbox does not provide support events in Mathematica versions older than 9. Events will be ignored in further calculations.";
sbml2model::eventDelayDetected="Delayed event detected. The MASS Toolbox does not provide support for delayed events.";
sbml2model::variableStoichiometry="The toolbox does not support for variable stoichiometric factors (detected in reaction `1`)";
sbml2model::eventProblem="Problem encountered for the following events: `1`. Amongst other things, the toolbox does not provide support for events that involve parameters.";
sbml2model::conversionFactorDetected="Conversion factor detected. The MASS Toolbox does not provide support conversion factors. The conversion factors will be ignored in further calculations.";
sbml2model[xml_/;Head[xml]===XMLObject["Document"],opts:OptionsPattern[]]:=Module[{hosuRules,listOfUnitDefinitions,listOfFunctionDefinitions,listOfCompartments,compartmentVolumes,listOfParameters,parameters,
listOfSpecies,initialConditions,boundaryConditions,id2massID,listOfRxns,listOfRules,assignmentRules,rateRules,algebraicRules,listOfInitialAssignments,
listOfKineticLawsAndLocalParameters,listOfKineticLaws,listOfLocalParameters,speciesInReactions,notCoveredByReactions,customODE,constantSpecies,paramInListOfRules,
constParam,speciesIDs2names,modelID,modelName,notes,modelStuff,hasOnlySubstanceUnits,listOfEvents},

	Switch[OptionValue["Method"],
		"Full",
		If[MemberQ[xml,"conversionFactor",\[Infinity]],Message[sbml2model::conversionFactorDetected];];
		modelStuff=extractXMLelement[xml,"model",0,3][[1]];
		modelID=query["id",modelStuff[[2]]];
		modelName=query["name",modelStuff[[2]],modelID];
		notes=Quiet@Check[ImportString[ExportString[extractXMLelement[modelStuff[[3]],"notes",2][[1]],"XML"],"XHTML"],""];
		listOfUnitDefinitions=getListOfUnitDefinitions[xml];
		listOfFunctionDefinitions=getListOfFunctionDefinitions[xml](*/.Dispatch[listOfUnitDefinitions]*);
		
		listOfCompartments=getListOfCompartments[xml];
		(*compartmentIDs2names=DeleteCases[(#[[1]]->query["name",#[[2]],Undefined]&/@listOfCompartments)/.elem_[t]:>elem,r_Rule/;r[[2]]===Undefined];*)
		
		listOfParameters=getListOfParameters[xml];
		parameters=getParameterValues[listOfParameters];
		
		constParam=FilterRules[parameters,Except[_[t]]];

		listOfSpecies=getListOfSpecies[xml];
		constantSpecies=Cases[listOfSpecies[[All,1]],_species];
		speciesIDs2names=DeleteCases[(#[[1]]->query["name",#[[2]],Undefined]&/@listOfSpecies)/.elem_[t]:>elem,r_Rule/;r[[2]]===Undefined];
		
		id2massID=Join[getID[#/.elem_[t]:>elem]->#&/@listOfSpecies[[All,1]],getID[#/.elem_[t]:>elem][[2]]->#&/@listOfCompartments[[All,1]],If[Length[#]>1,#[[1]],#]&[getID[#/.elem_[t]:>elem]]->#&/@DeleteCases[listOfParameters[[All,1]],parameter["Volume",_]]];
		(*Temporary Fix*)
		id2massID=Join[id2massID,{"Pi"->Pi,"E"->E,"avogadro"->6.0221415`*^23}];
		listOfInitialAssignments=getListOfInitialAssignments[xml,id2massID];	
		
		listOfInitialAssignments=(#[[1]]->(#[[2]]/.Dispatch[listOfInitialAssignments])&/@listOfInitialAssignments)(*/."t"->0*);
		
		listOfRules=getListOfRules[xml,id2massID]/.Dispatch[listOfFunctionDefinitions]/.("algebraicRule"->eq_Equal/;MatchQ[Simplify[eq/.Dispatch[constParam]],(_parameter|_parameter[t])==_?NumberQ]):>("assignmentRule"->Rule@@Simplify[eq/.Dispatch[constParam]]);
		
		paramInListOfRules=Union[Join[Cases[FilterRules[listOfRules,("rateRule"|"assignmentRule")][[All,2,1]],_parameter,\[Infinity],Heads->True],Cases[FilterRules[listOfRules,"algebraicRule"],_parameter,\[Infinity],Heads->True]]];
		(*paramInListOfRules=Union[Join[Cases[FilterRules[listOfRules,("rateRule"|"assignmentRule")][[All,2]],_parameter,\[Infinity],Heads->True],Cases[FilterRules[listOfRules,"algebraicRule"],_parameter,\[Infinity],Heads->True]]];*)
		
		
		parameters=parameters/.p_parameter[t]/;!MemberQ[paramInListOfRules,p]:>p;
		
		id2massID=id2massID/.p_parameter[t]/;!MemberQ[paramInListOfRules,p]:>p;

		If[$VersionNumber<9&&MemberQ[xml,XMLElement["listOfEvents",_,_],\[Infinity]],
			Message[sbml2model::eventDetected];
			listOfEvents={};,
			listOfEvents=getListOfEvents[xml,id2massID]/.Dispatch[listOfFunctionDefinitions];
		];
		
		listOfRules=listOfRules/.p_parameter[t]/;!MemberQ[paramInListOfRules,p]:>p/.t^t->Piecewise[{{1,t==0},{t^t,True}}];
		assignmentRules=FilterRules[listOfRules,"assignmentRule"][[All,2]];
		rateRules=FilterRules[listOfRules,"rateRule"][[All,2]];
		algebraicRules=FilterRules[listOfRules,"algebraicRule"][[All,2]];

		compartmentVolumes=getCompartmentVolumes[listOfCompartments,listOfUnitDefinitions];
		compartmentVolumes=updateRules[compartmentVolumes,FilterRules[assignmentRules,parameter["Volume",_][t]]];
		compartmentVolumes=updateRules[compartmentVolumes,FilterRules[listOfInitialAssignments,parameter["Volume",_]|parameter["Volume",_][t]]];

		parameters=Join[parameters,FilterRules[compartmentVolumes,parameter["Volume",_String]]];

		initialConditions=getInitialConcentrations[listOfSpecies,listOfUnitDefinitions]/.Dispatch[compartmentVolumes];
		(* Handle constant species *)
		parameters=updateRules[parameters,FilterRules[initialConditions,constantSpecies]];
		initialConditions=FilterRules[initialConditions,Except[constantSpecies]];
		initialConditions=Join[initialConditions,FilterRules[compartmentVolumes,parameter["Volume",_String][t]]/.elem_[t]:>elem];
		hasOnlySubstanceUnits=getHasOnlySubstanceUnits[listOfSpecies];
		boundaryConditions=getBoundaryConditions[listOfSpecies];

		listOfRxns=getListOfReactions[xml,id2massID/.elem_[t]:>elem]/.Dispatch[FilterRules[listOfInitialAssignments,_String]]/.Dispatch[assignmentRules]/.Dispatch[listOfFunctionDefinitions]/.Dispatch[FilterRules[parameters,Except[_species]]];

		initialConditions=#[[1]]->(#[[2]]/.Dispatch[compartmentVolumes/.elem_[t]:>elem])&/@initialConditions;
		parameters=#[[1]]->(#[[2]]/.Dispatch[compartmentVolumes/.elem_[t]:>elem])&/@parameters;
		initialConditions=updateRules[initialConditions,stripTime[assignmentRules]/.Dispatch[parameters]];
		listOfKineticLawsAndLocalParameters=getListOfKineticLawsAndLocalParameters[xml,id2massID,listOfFunctionDefinitions];
		listOfKineticLaws=(#[[1]]->#[[2,1]]&/@listOfKineticLawsAndLocalParameters)/."t"->t;
		listOfLocalParameters=Flatten[#[[2,2]]&/@listOfKineticLawsAndLocalParameters];
		
		parameters=Join[parameters,getParameterValues[listOfLocalParameters]];

		speciesInReactions=Union[Flatten[getCompounds/@listOfRxns]];
		notCoveredByReactions=Complement[Union[listOfSpecies[[All,1]],FilterRules[assignmentRules,Except[_String]][[All,1]]],speciesInReactions];
		
		initialConditions=updateRules[FilterRules[parameters,_[t]]/.elem_[t]:>elem,initialConditions];
		parameters=FilterRules[parameters,Except[_[t]]];
		
		initialConditions=updateRules[initialConditions,FilterRules[listOfInitialAssignments,initialConditions[[All,1]]]];
		initialConditions=#[[1]]->(#[[2]]//.Dispatch[initialConditions])&/@initialConditions;
		initialConditions=initialConditions/.Dispatch[listOfFunctionDefinitions];
		initialConditions=initialConditions/.Global`delay[a_,b_]:>(a/.t->(t-b));
		(*FIXME updateRules might not be appropriate as units might get lost*)
		parameters=updateRules[parameters,FilterRules[listOfInitialAssignments,parameters[[All,1]]]];
		parameters=#[[1]]->(#[[2]]//.Dispatch[parameters])&/@parameters;
		parameters=parameters/.Dispatch[listOfFunctionDefinitions];
		initialConditions=#[[1]]->(#[[2]]//.Dispatch[parameters])&/@initialConditions;
		initialConditions=DeleteCases[initialConditions,r_Rule/;r[[2]]==="Indeterminate"](*/."t"->0*);
		parameters=#[[1]]->(#[[2]]//.Dispatch[initialConditions])&/@parameters;
		parameters=DeleteCases[parameters,r_Rule/;r[[2]]==="Indeterminate"];
		customODE=Join[#[[1]]==#[[2]]&/@FilterRules[assignmentRules,notCoveredByReactions],rateRules,algebraicRules]/.Dispatch[listOfFunctionDefinitions]/."t"->t;
		initialConditions=DeleteCases[initialConditions,r_Rule/;r[[2]]===Indeterminate](*/.t->0*)(*t0 is always zero in SBML*);
		parameters=DeleteCases[parameters,r_Rule/;r[[2]]===Indeterminate]/.t->0;
		
		(* FIXME: compartment volumes from ic to parameters if not covered by customODE *)
		parameters=updateRules[parameters,FilterRules[initialConditions,pat:parameter["Volume",_]/;!MemberQ[customODE[[All,1]],pat,\[Infinity],Heads->True]]];
		initialConditions=FilterRules[initialConditions,Except[pat:parameter["Volume",_]/;!MemberQ[customODE[[All,1]],pat,\[Infinity],Heads->True]]];
		(* Deal with delays *)
		customODE=customODE/.Global`delay[a_[t],b_]:>a[t-b]/.Global`delay[a_,_]:>a;
		customODE/.\!\(\*
TagBox[
StyleBox[
RowBox[{
RowBox[{
RowBox[{"Derivative", "[", "1", "]"}], "[", 
RowBox[{"s", ":", "$MASS$speciesPattern"}], "]"}], "[", "t", "]"}],
ShowSpecialCharacters->False,
ShowStringCharacters->True,
NumberMarks->True],
FullForm]\):>Derivative[1][s][t]*parameter["Volume",getCompartment[s]];
		customODE=If[MatchQ[#[[1]],Derivative[1][$MASS$speciesPattern][t]],If[MemberQ[hasOnlySubstanceUnits,#[[1,0,1]]],#[[1]]==#[[2]]/parameter["Volume",getCompartment[#[[1,0,1]]]],#[[1]](**parameter["Volume",getCompartment[#[[1,0,1]]]]*)==#[[2]]],#]&/@customODE;

		hosuRules=If[MemberQ[constantSpecies,#],#->#*parameter["Volume",getCompartment[#]],#[t]->#[t]*parameter["Volume",getCompartment[#]]]&/@hasOnlySubstanceUnits;
		listOfKineticLaws=listOfKineticLaws/.Global`delay[a_[t],b_]:>a[t-b]/.hosuRules;

		(* Temporary Fix: get rid of parameters that don't have an initial value*)
		parameters=DeleteCases[parameters,r_Rule/;MatchQ[r[[2]],_String]];
		If[!MatchQ[listOfEvents,{(_String->WhenEvent[_,({_[t]..}->{__})|(_[t]->_)|{(_[t]->_)..},OptionsPattern[]])...}],Message[sbml2model::eventProblem,DeleteCases[listOfEvents,{(_String->WhenEvent[_,({_[t]..}->{__})|(_[t]->_)|{(_[t]->_)..},OptionsPattern[]])...}]]];
		Scan[If[!MatchQ[getStoichiometry[#],{_?NumberQ...}],Message[sbml2model::variableStoichiometry,getID[#]];Abort[];]&,listOfRxns];
		constructModel[listOfRxns,
			Sequence@@updateRules[
				{"ID"->modelID,"Name"->modelName,"Notes"->notes,"InitialConditions"->N@initialConditions,"Parameters"->N@parameters,
				"CustomRateLaws"->listOfKineticLaws,"BoundaryConditions"->boundaryConditions,"Constant"->constantSpecies,"CustomODE"->customODE,
				"Synonyms"->speciesIDs2names,"Events"->listOfEvents},
				FilterRules[List[opts],Options[constructModel]]
			]
		],
		
		"Light",
		sbml2modelSimple[xml,FilterRules[List[opts],Options[constructModel]]],
		
		_,Message[sbml2model::nonValidMethod,OptionValue["Method"]];Abort[];
	]
];

sbml2model[]:=sbml2model[SystemDialogInput["FileOpen"]];

sbml2model[path_String,opts:OptionsPattern[]]:=Module[{xml},
(*If[!FileExistsQ[path],Message[sbml2model::NotExistFile,path];Abort[];];*)
Check[sbml2model[Import[path,"XML"],opts],Message[sbml2model::NotExistFile,path];Abort[];,{Import::nffil}]
];


(* ::Subsection::Closed:: *)
(*SBML export*)


model2sbml[model_MASSmodel]:=Module[{ratemapping,localParam,globalParam},
	Quiet[Check[Needs["MathSBML`"],Message[MathSBML::notinstalled];Abort[];,{Get::noopen,Needs::nocont}],{Get::noopen,Needs::nocont}];
	MathSBML`newModel[Global`id->makeIdXmlConform@StringReplace[ToString[model["ID"]],"$"->"_"]];
	Do[
		MathSBML`addSpecies[
			ToString[spec,"SBML"],
			Global`compartment->getCompartment[spec],
			Global`initialConcentration->(spec/.stripUnits[model["InitialConditions"]]/.stripUnits[model["Parameters"]]/.n_/;!NumberQ[n]:>Indeterminate),
			Global`boundaryCondition->MemberQ[model["BoundaryConditions"],spec],
			Global`constant->MemberQ[model["Constant"],spec]
		];
		,{spec,Union[model["Species"],model["BoundaryConditions"],model["Constant"]]}
	];
	ratemapping=stripTime[Thread[Rule[(getID/@model["Fluxes"]),model["Rates"]]]];
	localParam=If[MatchQ[#,_List],#[[2]],#]&[getID[#[[1]]]]->(ToString[#[[1]],"SBML"]->(stripUnits[#[[2]]]/.{\[Infinity]->"INF",-\[Infinity]->"-INF"}))&/@FilterRules[model["Parameters"],Cases[ratemapping,pat:$MASS$parametersPattern/;MemberQ[ratemapping[[All,1]],If[MatchQ[#,_List],#[[2]],#]&[getID[pat]]],\[Infinity]]];
	Do[
		MathSBML`addReaction[
			Global`id->makeIdXmlConform[getID[rxn]],
			Global`reactants->Evaluate[If[#=!={},ToString[#,"SBML"],{}]&/@getSubstrates[rxn]],
			Global`reactantStoichiometry->getSubstrStoich[rxn],
			Global`products->Evaluate[If[#=!={},ToString[#,"SBML"],{}]&/@getProducts[rxn]],
			Global`productStoichiometry->getProdStoich[rxn],
			Global`reversible->reversibleQ[rxn],
			Global`kineticLaw->(getID[rxn]/.Dispatch[ratemapping])/.pat:Join[$MASS$speciesPattern,$MASS$parametersPattern]:>ToString[pat,"SBML"],
			Global`parameters->FilterRules[localParam,getID[rxn]][[All,2]]
			(*,Global`parameters->(Union[Cases[getID[rxn]/.Dispatch[ratemapping],$MASS$parametersPattern,\[Infinity]]]/.model["Parameters"]/.p:(_rateconst|_Keq|metabolite[_,"Xt"]|_parameter):>ToString[p])/.{\[Infinity]->"INF",-\[Infinity]->"-INF"}*)
		];
		,{rxn,model["Reactions"]}
	];
	globalParam=FilterRules[model["Parameters"],Cases[ratemapping,((p_parameter/;!MatchQ[getID[p],_List])|metabolite[_,"Xt"]),\[Infinity]]];
	Do[
		MathSBML`addParameter[
			Global`id->ToString[param[[1]],"SBML"],
			Global`value->stripUnits[param[[2]]]
		];
	,{param,globalParam}];
	Return[ImportString[StringReplace[MathSBML`createModel["annotations"->False],{"<ms>"->"<ci>","</ms>"->"</ci>"}],"XML"]];
];


biomodelID2name={"BIOMD0000000299"->"Leloup1999_CircadianRhythms_Neurospora","BIOMD0000000298"->"Leloup1999_CircadianRhythms_Drosophila","BIOMD0000000159"->"Zatorsky2006_p53_Model1","BIOMD0000000156"->"Zatorsky2006_p53_Model5","BIOMD0000000155"->"Zatorsky2006_p53_Model6","BIOMD0000000158"->"Zatorsky2006_p53_Model2","BIOMD0000000157"->"Zatorsky2006_p53_Model4","BIOMD0000000162"->"Hernjak2005_Calcium_Signaling","BIOMD0000000163"->"Zi2007_TGFbeta_signaling","BIOMD0000000164"->"SmithAE2002_RanTransport","BIOMD0000000165"->"Saucerman2006_PKA","BIOMD0000000160"->"Xie2007_CircClock","BIOMD0000000161"->"Eungdamrong2007_Ras_Activation","BIOMD0000000289"->"Alexander2010_Tcell_Regulation_Sys1","BIOMD0000000288"->"Wang2009_PI3K_Ras_Crosstalk","BIOMD0000000287"->"Passos2010_DNAdamage_CellularSenescence","BIOMD0000000149"->"Kim2007_Wnt_ERK_Crosstalk","BIOMD0000000148"->"Komarova2003_BoneRemodeling","BIOMD0000000147"->"ODea2007_IkappaB","BIOMD0000000146"->"Hatakeyama2003_MAPK","BIOMD0000000145"->"Wang2007_ATP_induced_Ca_Oscillation","BIOMD0000000144"->"Calzone2007_CellCycle","BIOMD0000000153"->"Fernandez2006_ModelB","BIOMD0000000154"->"Zatorsky2006_p53_Model3","BIOMD0000000151"->"Singh2006_IL6_Signal_Transduction","BIOMD0000000152"->"Fernandez2006_ModelA","BIOMD0000000150"->"Morris2002_CellCycle_CDK2Cyclin","BIOMD0000000292"->"Rovers1995_Photsynthetic_Oscillations","BIOMD0000000293"->"Proctor2010_UCHL1_ProteinAggregation","BIOMD0000000290"->"Alexander2010_Tcell_Regulation_Sys2","BIOMD0000000291"->"Nikolaev2005_AlbuminBilirubinAdsorption","BIOMD0000000296"->"Balagadd\[EAcute]2008_E_coli_Predator_Prey","BIOMD0000000297"->"Ciliberto2003_Morphogenesis_Checkpoint","BIOMD0000000294"->"Restif2007_Vaccination_Invasion","BIOMD0000000295"->"Akman2008_Circadian_Clock_Model1","BIOMD0000000277"->"Shrestha2010_HyperCalcemia_PTHresponse","BIOMD0000000276"->"Shrestha2010_HypoCalcemia_PTHresponse","BIOMD0000000279"->"Komarova2005_PTHaction_OsteoclastOsteoblastCoupling","BIOMD0000000278"->"Lemaire2004_BoneRemodeling_RANKRANKLOPGpathway","BIOMD0000000178"->"Lebeda2008_BoTN_Paralysis_4stepModel","BIOMD0000000177"->"Conant2007_glycolysis_2C","BIOMD0000000179"->"Kim2007_CellularMemory_AsymmetricModel","BIOMD0000000180"->"Kim2007_CellularMemory_SymmetricModel","BIOMD0000000181"->"Sriram2007_CellCycle","BIOMD0000000182"->"Neves2008_Cell_Shape","BIOMD0000000183"->"Stefan2008_calmodulin_allostery","BIOMD0000000184"->"Lavrentovich2008_Ca_Oscillations","BIOMD0000000185"->"Locke2008_Circadian_Clock","BIOMD0000000186"->"Ibrahim2008_Spindle_Assembly_Checkpoint_dissociation","BIOMD0000000187"->"Ibrahim2008_Spindle_Assembly_Checkpoint_convey","BIOMD0000000283"->"Chance1943_Peroxidase_ES_Kinetics","BIOMD0000000284"->"Hofmeyer1986_SeqFb_Proc_AA_Synthesis","BIOMD0000000285"->"Tang2010_PolyGlutamate","BIOMD0000000286"->"Proctor2010_GSK3_p53_AlzheimerDisease","BIOMD0000000280"->"Morris1981_MuscleFibre_Voltage_reduced","BIOMD0000000281"->"Chance1960_Glycolysis_Respiration","BIOMD0000000282"->"Chance1952_Catalase_Mechanism","BIOMD0000000269"->"Liu2010_Hormonal_Crosstalk_Arabidopsis","BIOMD0000000268"->"Reed2008_Glutathione_Metabolism","BIOMD0000000267"->"Lebeda2008_BoNT_Paralysis_3stepModel","BIOMD0000000266"->"Voit2003_Trehalose_Cycle","BIOMD0000000265"->"Conradie2010_RPControl_CellCycle","BIOMD0000000169"->"Aguda1999_CellCycle","BIOMD0000000168"->"Obeyesekere1999_CellCycle","BIOMD0000000167"->"Mayya2005_STATmodule","BIOMD0000000166"->"Zhu2007_TF_modulated_by_Calcium","BIOMD0000000171"->"Leloup1998_CircClock_LD","BIOMD0000000172"->"Pritchard2002_glycolysis","BIOMD0000000170"->"Weimann2004_CircadianOscillator","BIOMD0000000175"->"Birtwistle2007_ErbB_Signalling","BIOMD0000000176"->"Conant2007_WGD_glycolysis_2A3AB","BIOMD0000000173"->"Schmierer_2008_Smad_Tgfb","BIOMD0000000174"->"Del_Conte_Zerial2008_Rab5_Rab7_cut_out_switch","BIOMD0000000274"->"Rattanakul2003_BoneFormationModel","BIOMD0000000275"->"Goldbeter2007_Somitogenesis_Switch","BIOMD0000000272"->"Becker2010_EpoR_AuxiliaryModel","BIOMD0000000273"->"Pokhilko2010_CircClock","BIOMD0000000270"->"Schilling2009_ERK_distributive","BIOMD0000000271"->"Becker2010_EpoR_CoreModel","BIOMD0000000013"->"Poolman2004_CalvinCycle","BIOMD0000000012"->"Elowitz2000_Repressilator","BIOMD0000000015"->"Curto1998_purineMetabol","BIOMD0000000014"->"Levchenko2000_MAPK_Scaffold","BIOMD0000000199"->"Santolini2001_nNOS_Mechanism_Regulation","BIOMD0000000017"->"Hoefnagel2002_PyruvateBranches","BIOMD0000000119"->"Golomb2006_SomaticBursting_nonzero[Ca]","BIOMD0000000016"->"Goldbeter1995_CircClock","BIOMD0000000019"->"Schoeberl2002_EGF_MAPK","BIOMD0000000018"->"Morrison1989_FolateCycle","BIOMD0000000116"->"McClean2007_CrossTalk","BIOMD0000000115"->"Somogyi1990_CaOscillations_SingleCaSpike","BIOMD0000000118"->"Golomb2006_SomaticBursting","BIOMD0000000117"->"Dupont1991_CaOscillation","BIOMD0000000112"->"Clarke2006_Smad_signalling","BIOMD0000000111"->"Novak2001_FissionYeast_CellCycle","BIOMD0000000114"->"Somogyi1990_CaOscillations","BIOMD0000000113"->"Dupont1992_Ca_dpt_protein_phospho","BIOMD0000000120"->"Chan2004_TCell_receptor_activation","BIOMD0000000121"->"Clancy2001_Kchannel","BIOMD0000000398"->"Sivakumar2011_NeuralStemCellDifferentiation_Crosstalk","BIOMD0000000397"->"Sivakumar2011_WntSignalingPathway","BIOMD0000000020"->"Hodgkin-Huxley1952 squid-axon","BIOMD0000000021"->"Leloup1999_CircClock","BIOMD0000000399"->"Jenkinson2011_EGF_MAPK","BIOMD0000000022"->"Ueda2001_CircClock","BIOMD0000000395"->"Sivakumar2011_HedgehogSignalingPathway","BIOMD0000000004"->"Goldbeter1991_MinMitOscil_ExplInact","BIOMD0000000396"->"Sivakumar2011_NotchSignalingPathway","BIOMD0000000003"->"Goldbeter1991_MinMitOscil","BIOMD0000000393"->"Arnold2011_Zhu2007_CalvinCycle_Starch_Sucrose_Photorespiration","BIOMD0000000002"->"Edelstein1996_EPSP_AChSpecies","BIOMD0000000394"->"Sivakumar2011_EGFReceptorSignalingPathway","BIOMD0000000001"->"Edelstein1996 - EPSP ACh event","BIOMD0000000391"->"Arnold2011_Poolman2000_CalvinCycle_Starch","BIOMD0000000008"->"Gardner1998_CellCycle_Goldbeter","BIOMD0000000392"->"Arnold2011_Laisk2006_CalvinCycle_Starch_Sucrose","BIOMD0000000007"->"Novak1997_CellCycle","BIOMD0000000188"->"Proctor2008_p53_Mdm2_ATM","BIOMD0000000109"->"Haberichter2007_cellcycle","BIOMD0000000006"->"Tyson1991_CellCycle_2var","BIOMD0000000390"->"Arnold2011_Giersch1990_CalvinCycle","BIOMD0000000189"->"Proctor2008_p53_Mdm2_ARF","BIOMD0000000108"->"Kowald2006_SOD","BIOMD0000000005"->"Tyson1991_CellCycle_6var","BIOMD0000000107"->"Novak1993_M_phase_control","BIOMD0000000106"->"Yang2007_ArachidonicAcid","BIOMD0000000105"->"Proctor2007_ubiquitine","BIOMD0000000104"->"Klipp2002_MetabolicOptimization_linearPathway(n=2)","BIOMD0000000009"->"Huang1996_MAPK_ultrasens","BIOMD0000000103"->"Legewie2006_apoptosis_NC","BIOMD0000000102"->"Legewie2006_apoptosis_WT","BIOMD0000000101"->"Vilar2006_TGFbeta","BIOMD0000000100"->"Rozi2003_GlycogenPhosphorylase_Activation","BIOMD0000000190"->"Rodriguez-Caso2006_Polyamine_Metabolism","BIOMD0000000110"->"Qu2003_CellCycle","BIOMD0000000198"->"Stone1996_NOsGC","BIOMD0000000197"->"Bartholome2007_MDCKII","BIOMD0000000196"->"Srividhya2006_CellCycle","BIOMD0000000195"->"Tyson2001_Cell_Cycle_Regulation","BIOMD0000000389"->"Arnold2011_Hahn1986_CalvinCycle_Starch_Sucrose","BIOMD0000000194"->"Ibrahim2008_Cdc20_Sequestring_Template_Model","BIOMD0000000010"->"Kholodenko2000_MAPK_feedback","BIOMD0000000388"->"Arnold2011_Zhu2009_CalvinCycle","BIOMD0000000193"->"Ibrahim2008_MCC_assembly_model_KDM","BIOMD0000000011"->"Levchenko2000_MAPK_noScaffold","BIOMD0000000387"->"Arnold2011_Damour2007_RuBisCO-CalvinCycle","BIOMD0000000192"->"G\[ODoubleDot]rlich2003_RanGTP_gradient","BIOMD0000000191"->"Monta\[NTilde]ez2008_Arginine_catabolism","BIOMD0000000386"->"Arnold2011_Sharkey2007_RuBisCO-CalvinCycle","BIOMD0000000134"->"Izhikevich2004_SpikingNeurons_SpikeLatency","BIOMD0000000133"->"Izhikevich2004_SpikingNeurons_resonator","BIOMD0000000136"->"Izhikevich2004_SpikingNeurons_thresholdVariability","BIOMD0000000135"->"Izhikevich2004_SpikingNeurons_subthresholdOscillations","BIOMD0000000138"->"Tabak2007_dopamine","BIOMD0000000137"->"Sedaghat2002_InsulinSignalling_noFeedback","BIOMD0000000139"->"Hoffmann2002_KnockOut_IkBNFkB_Signaling","BIOMD0000000140"->"Hoffmann2002_WT_IkBNFkB_Signaling","BIOMD0000000141"->"Izhikevich2004_SpikingNeurons_Class1Excitable","BIOMD0000000142"->"Izhikevich2004_SpikingNeurons_Class2Excitable","BIOMD0000000143"->"Olsen2003_neutrophil_oscillatory_metabolism","BIOMD0000000125"->"Komarova2005_TheoreticalFramework_BasicArchitecture","BIOMD0000000124"->"Wu2006_K+Channel","BIOMD0000000123"->"Fisher2006_NFAT_Activation","BIOMD0000000122"->"Fisher2006_Ca_Oscillation_dpdnt_NFAT_dynamics","BIOMD0000000129"->"Izhikevich2004_SpikingNeurons_inhibitionInducedSpiking","BIOMD0000000128"->"Bertram2006_Endothelin","BIOMD0000000127"->"Izhikevich2003_SpikingNeuron","BIOMD0000000126"->"Clancy2002_CardiacSodiumChannel_WT","BIOMD0000000131"->"Izhikevich2004_SpikingNeurons_reboundBurst","BIOMD0000000132"->"Izhikevich2004_SpikingNeurons_reboundSpike","BIOMD0000000130"->"Izhikevich2004_SpikingNeurons_integrator","BIOMD0000000330"->"Larsen2004_CalciumSpiking","BIOMD0000000031"->"Markevich2004_MAPK_orderedMM2kinases","BIOMD0000000030"->"Markevich2004_MAPK_AllRandomElementary","BIOMD0000000033"->"Brown2004_NGF_EGF_signaling","BIOMD0000000032"->"Kofahl2004_PheromonePathway","BIOMD0000000325"->"Palini2011_Minimal_2_Feedback_Model","BIOMD0000000023"->"Rohwer2001_Sucrose","BIOMD0000000324"->"Morris1981_MuscleFibre_Voltage_full","BIOMD0000000024"->"Scheper1999_CircClock","BIOMD0000000327"->"Whitcomb2004_Bicarbonate_Pancreas","BIOMD0000000025"->"Smolen2002_CircClock","BIOMD0000000326"->"DellOrco2009_phototransduction","BIOMD0000000026"->"Markevich2004_MAPK_orderedElementary","BIOMD0000000321"->"Grange2001_L_Dopa_PK","BIOMD0000000027"->"Markevich2004_MAPK_orderedMM","BIOMD0000000320"->"Grange2001_L_Dopa_Benserazide_PK","BIOMD0000000028"->"Markevich2004_MAPK_phosphoRandomElementary","BIOMD0000000323"->"Kim2011_Oscillator_SimpleIII","BIOMD0000000029"->"Markevich2004_MAPK_phosphoRandomMM","BIOMD0000000322"->"Kim2011_Oscillator_SimpleI","BIOMD0000000329"->"Kummer2000_CalciumSpiking","BIOMD0000000328"->"Bucher2011_Atorvastatin_Metabolism","BIOMD0000000340"->"Wajima2009_BloodCoagulation_warfarin_heparin","BIOMD0000000040"->"Field1974_Oregonator","BIOMD0000000341"->"Topp2000_BetaCellMass_Diabetes","BIOMD0000000044"->"Borghans1997_CaOscillation_model2","BIOMD0000000043"->"Borghans1997_CaOscillation_model1","BIOMD0000000042"->"Nielsen1998_Glycolysis","BIOMD0000000041"->"Kongas2007_CreatineKinase","BIOMD0000000338"->"Wajima2009_BloodCoagulation_aPTTtest","BIOMD0000000036"->"Tyson1999_CircClock","BIOMD0000000337"->"Pfeiffer2001_ATP-ProducingPathways_CooperationCompetition","BIOMD0000000037"->"Marwan_Genetics_2003","BIOMD0000000336"->"Jones1994_BloodCoagulation","BIOMD0000000034"->"Smolen2004_CircClock","BIOMD0000000335"->"Hockin2002_BloodCoagulation","BIOMD0000000035"->"Vilar2002_Oscillator","BIOMD0000000334"->"Bungay2003_Thrombin_Generation","BIOMD0000000333"->"Bungay2006_FollicularFluid","BIOMD0000000332"->"Bungay2006_Plasma","BIOMD0000000038"->"Rohwer2000_Phosphotransferase_System","BIOMD0000000331"->"Larsen2004_CalciumSpiking_EnzymeBinding","BIOMD0000000039"->"Marhl2000_CaOscillations","BIOMD0000000339"->"Wajima2009_BloodCoagulation_PTtest","BIOMD0000000053"->"Ferreira2003_CML_generation2","BIOMD0000000052"->"Brands2002_MonosaccharideCasein","BIOMD0000000055"->"Locke2005_CircadianClock","BIOMD0000000054"->"Ataullahkhanov1996_Adenylate","BIOMD0000000051"->"Chassagnole2002_Carbon_Metabolism","BIOMD0000000050"->"Martins2003_AmadoriDegradation","BIOMD0000000049"->"Sasagawa2005_MAPK","BIOMD0000000301"->"Friedland2009_Ara_RTC3_counter","BIOMD0000000300"->"Schmierer2010_FIH_Ankyrins","BIOMD0000000208"->"Deineko2003_CellCycle","BIOMD0000000303"->"Liu2011_Complement_System","BIOMD0000000045"->"Borghans1997_CaOscillation_model3","BIOMD0000000207"->"Romond1999_CellCycle","BIOMD0000000302"->"Wang1996_Synaptic_Inhibition_Two_Neuron","BIOMD0000000046"->"Olsen2003_peroxidase","BIOMD0000000305"->"Kolomeisky2003_MyosinV_Processivity","BIOMD0000000047"->"Oxhamre2005_Ca_oscillation","BIOMD0000000209"->"Chickarmane2008_StemCell_lineageDetermination","BIOMD0000000304"->"Plant1981_BurstingNerveCells","BIOMD0000000048"->"Kholodenko1999_EGFRsignaling","BIOMD0000000204"->"Chickarmane2006_StemCell_Switchirreversible","BIOMD0000000307"->"Tyson2003_Substrate_Depletion_Osc","BIOMD0000000203"->"Chickarmane2006_StemCell_Switchreversible","BIOMD0000000306"->"Tyson2003_Activator_Inhibitor","BIOMD0000000206"->"Wolf2000_Glycolytic_Oscillations","BIOMD0000000309"->"Tyson2003_NegFB_Homeostasis","BIOMD0000000205"->"Ung2008_EGFR_Endocytosis","BIOMD0000000308"->"Tyson2003_NegFB_Oscillator","BIOMD0000000200"->"Bray1995_chemotaxis_receptorlinkedcomplex","BIOMD0000000202"->"ChenXF2008_CICR","BIOMD0000000201"->"Goldbeter2008_Somite_Segmentation_Clock_Notch_Wnt_FGF","BIOMD0000000220"->"Albeck2008_extrinsic_apoptosis","BIOMD0000000066"->"Chassagnole2001_Threonine Synthesis","BIOMD0000000065"->"Yildirim2003_Lac_Operon","BIOMD0000000064"->"Teusink2000_Glycolysis","BIOMD0000000063"->"Galazzo1990_FermentationPathwayKinetics","BIOMD0000000062"->"Bhartiya2003_Tryptophan_operon","BIOMD0000000061"->"Hynne2001_Glycolysis","BIOMD0000000060"->"Keizer1996_Ryanodine_receptor_adaptation","BIOMD0000000312"->"Tyson2003_Perfect_Adaption","BIOMD0000000311"->"Tyson2003_Mutual_Activation","BIOMD0000000310"->"Tyson2003_Mutual_Inhibition","BIOMD0000000316"->"Shen-Orr2002_FeedForward_AND_gate","BIOMD0000000058"->"Bindschadler2001_coupled_Ca_oscillators","BIOMD0000000315"->"Montagne2011_Oligator_optimised","BIOMD0000000059"->"Fridlyand2003_Calcium_flux","BIOMD0000000219"->"Singh2006_TCA_mtu_model1","BIOMD0000000314"->"Raia2011_IL13_L1236","BIOMD0000000056"->"Chen2004_CellCycle","BIOMD0000000218"->"Singh2006_TCA_mtu_model2","BIOMD0000000313"->"Raia2010_IL13_Signalling_MedB1","BIOMD0000000057"->"Sneyd2002_IP3_Receptor","BIOMD0000000217"->"Bruggeman2005_AmmoniumAssimilation","BIOMD0000000216"->"Hong2009_CircadianClock","BIOMD0000000319"->"Decroly1982_Enzymatic_Oscillator","BIOMD0000000215"->"Schulz2009_Th1_differentiation","BIOMD0000000318"->"Yao2008_Rb_E2F_Switch","BIOMD0000000214"->"Akman2008_Circadian_Clock_Model2","BIOMD0000000317"->"Shen-Orr2002_Single_Input_Module","BIOMD0000000213"->"Nijhout2004_Folate_Cycle","BIOMD0000000212"->"Curien2009_Aspartate_Metabolism","BIOMD0000000211"->"Albert2005_Glycolysis","BIOMD0000000210"->"Chickarmane2008_StemCell_NANOG_GATA6switch","BIOMD0000000070"->"Holzhutter2004_Erythrocyte_Metabolism","BIOMD0000000372"->"Tolic2000_InsulinGlucoseFeedback","BIOMD0000000071"->"Bakker2001_Glycolysis","BIOMD0000000371"->"DeVries2000_PancreaticBetaCells_InsulinSecretion","BIOMD0000000072"->"Yi2003_GproteinCycle","BIOMD0000000374"->"Bertram1995_PancreaticBetaCell_CRAC","BIOMD0000000073"->"Leloup2003_CircClock_DD","BIOMD0000000373"->"Bertram2004_PancreaticBetaCell_modelB","BIOMD0000000074"->"Leloup2003_CircClock_DD_REV-ERBalpha","BIOMD0000000075"->"Xu2003_Phosphoinositide_turnover","BIOMD0000000370"->"Vinod2011_MitoticExit","BIOMD0000000076"->"Cronwright2002_Glycerol_Synthesis","BIOMD0000000077"->"Blum2000_LHsecretion_1","BIOMD0000000420"->"Ratushny2012_ASSURE_I","BIOMD0000000422"->"Middleton2012_GibberellinSignalling","BIOMD0000000421"->"Ratushny2012_ASSURE_II","BIOMD0000000424"->"Faratian2009_PTENrole_TrastuzumabResistance","BIOMD0000000423"->"Nyman2012_InsulinSignalling","BIOMD0000000231"->"Valero2006_Adenine_TernaryCycle","BIOMD0000000230"->"Ihekwaba2004_NFkB_Sensitivity","BIOMD0000000221"->"Singh2006_TCA_Ecoli_acetate","BIOMD0000000222"->"Singh2006_TCA_Ecoli_glucose","BIOMD0000000223"->"Borisov2009_EGF_Insulin_Crosstalk","BIOMD0000000224"->"Meyer1991_CalciumSpike_ICC","BIOMD0000000225"->"Westermark2003_Pancreatic_GlycOsc_basic","BIOMD0000000226"->"Radulescu2008_NFkB_hierarchy_M_14_25_28_Lipniacky","BIOMD0000000227"->"Radulescu2008_NFkB_hierarchy_M_39_65_90","BIOMD0000000228"->"Swat2004_Mammalian_G1_S_Transition","BIOMD0000000229"->"Ma2002_cAMP_oscillations","BIOMD0000000068"->"Curien2003_MetThr_synthesis","BIOMD0000000368"->"Beltrami1995_ThrombinGeneration_C","BIOMD0000000067"->"Fung2005_Metabolic_Oscillator","BIOMD0000000369"->"Beltrami1995_ThrombinGeneration_D","BIOMD0000000069"->"Fuss2006_MitoticActivation","BIOMD0000000364"->"Lee2010_ThrombinActivation_OneForm","BIOMD0000000365"->"Hockin1999_BloodCoagulation_VaInactivation","BIOMD0000000366"->"Orfao2008_ThrombinGeneration_AmidolyticActivity","BIOMD0000000367"->"Mueller2008_ThrombinGeneration_minimal","BIOMD0000000083"->"Leloup2003_CircClock_LD_REV-ERBalpha","BIOMD0000000385"->"Arnold2011_Schultz2003_RuBisCO-CalvinCycle","BIOMD0000000084"->"Hornberg2005_ERKcascade","BIOMD0000000384"->"Arnold2011_Medlyn2002_RuBisCO-CalvinCycle","BIOMD0000000081"->"Suh2004_KCNQ_Regulation","BIOMD0000000383"->"Arnold2011_Farquhar1980_RuBisCO-CalvinCycle","BIOMD0000000082"->"Thomsen1988_AdenylateCyclase_Inhibition","BIOMD0000000382"->"Sturis1991_InsulinGlucoseModel_UltradianOscillation","BIOMD0000000087"->"Proctor2006_telomere","BIOMD0000000381"->"Maree2006_DuCa_Type1DiabetesModel","BIOMD0000000088"->"Maeda2006_MyosinPhosphorylation","BIOMD0000000380"->"Smallbone2011_TrehaloseBiosynthesis","BIOMD0000000085"->"Maurya2005_GTPaseCycle_reducedOrder","BIOMD0000000086"->"Bornheimer2004_GTPaseCycle","BIOMD0000000242"->"Bai2003_G1phaseRegulation","BIOMD0000000241"->"Shi1993_Caffeine_pressor_tolerance","BIOMD0000000080"->"Thomsen1989_AdenylateCyclase","BIOMD0000000240"->"Veening2008_DegU_Regulation","BIOMD0000000234"->"Tham2008_PDmodel_TumourShrinkage","BIOMD0000000235"->"Kuhn2009_EndoMesodermNetwork","BIOMD0000000232"->"Nazaret2009_TCA_RC_ATP","BIOMD0000000233"->"Wilhelm2009_BistableReaction","BIOMD0000000238"->"Overgaard2007_PDmodel_IL21","BIOMD0000000239"->"Jiang2007 - GSIS system, Pancreatic Beta Cells","BIOMD0000000236"->"Westermark2003_Pancreatic_GlycOsc_extended","BIOMD0000000237"->"Schaber2006_Pheromone_Starvation_Crosstalk","BIOMD0000000079"->"Goldbeter2006_weightCycling","BIOMD0000000379"->"DallaMan2007_MealModel_GlucoseInsulinSystem","BIOMD0000000078"->"Leloup2003_CircClock_LD","BIOMD0000000377"->"Bertram2000_PancreaticBetaCells_Oscillations","BIOMD0000000378"->"Chay1997_CalciumConcentration","BIOMD0000000375"->"Mears1997_CRAC_PancreaticBetaCells","BIOMD0000000376"->"Bertram2007_IsletCell_Oscillations","BIOMD0000000096"->"Zeilinger2006_PRR7-PRR9light-Y","BIOMD0000000097"->"Zeilinger2006_PRR7-PRR9light-Yprime","BIOMD0000000098"->"Goldbeter1990_CalciumSpike_CICR","BIOMD0000000099"->"Laub1998_SpontaneousOscillations","BIOMD0000000350"->"Troein2011_ClockCircuit_OstreococcusTauri","BIOMD0000000092"->"Fuentes2005_ZymogenActivation","BIOMD0000000093"->"Yamada2003_JAK_STAT_pathway","BIOMD0000000094"->"Yamada2003_JAK_STAT_SOCS1_knockout","BIOMD0000000352"->"Vernoux2011_AuxinSignaling_AuxinFluctuating","BIOMD0000000095"->"Zeilinger2006_PRR7-PRR9-Y","BIOMD0000000351"->"Vernoux2011_AuxinSignaling_AuxinSingleStepInput","BIOMD0000000251"->"Nakakuki2010_CellFateDecision_Core","BIOMD0000000250"->"Nakakuki2010_CellFateDecision_Mechanistic","BIOMD0000000253"->"Teusink1998_Glycolysis_TurboDesign","BIOMD0000000090"->"Wolf2001_Respiratory_Oscillations","BIOMD0000000252"->"Hunziker2010_p53_StressSpecificResponse","BIOMD0000000091"->"Hsp90model_basis510","BIOMD0000000247"->"Ralser2007_Carbohydrate_Rerouting_ROS","BIOMD0000000248"->"Lai2007_O2_Transport_Metabolism","BIOMD0000000249"->"Restif2006_Whooping_Cough","BIOMD0000000243"->"Neumann2010_CD95Stimulation_NFkB_Apoptosis","BIOMD0000000244"->"Kotte2010_Ecoli_Metabolic_Adaption","BIOMD0000000245"->"Lei2001_Yeast_Aerobic_Metabolism","BIOMD0000000246"->"Vasalou2010_Pacemaker_Neuron_SCN","BIOMD0000000342"->"Zi2011_TGF-beta_Pathway","BIOMD0000000343"->"Brannmark2010_InsulinSignalling_Mifamodel","BIOMD0000000344"->"Proctor2011_ProteinHomeostasis_NormalCondition","BIOMD0000000345"->"Koschorreck2008_InsulinClearance","BIOMD0000000346"->"FitzHugh1961_NerveMembrane","BIOMD0000000347"->"Bachmann2011_JAK2-STAT5_FeedbackControl","BIOMD0000000089"->"Locke2006_CircClock_LL","BIOMD0000000348"->"Fridlyand2010_GlucoseSensitivity_A","BIOMD0000000349"->"Fridlyand2010_GlucoseSensitivity_B","BIOMD0000000363"->"Lee2010_ThrombinActivation_OneForm_minimal","BIOMD0000000362"->"Butenas2004_BloodCoagulation","BIOMD0000000361"->"Panteleev2002_TFPImechanism_schmema1","BIOMD0000000360"->"Panteleev2002_TFPImechanism_schmema2","BIOMD0000000264"->"Fujita2010_Akt_Signalling_EGFRinhib","BIOMD0000000263"->"Fujita2010_Akt_Signalling_NGF","BIOMD0000000262"->"Fujita2010_Akt_Signalling_EGF","BIOMD0000000261"->"Tiago2010_FeMetabolism_FeLoaded","BIOMD0000000260"->"Tiago2010_FeMetabolism_FeAdequate","BIOMD0000000258"->"Ortega2006_bistability_doublePhosphorylation","BIOMD0000000259"->"Tiago2010_FeMetabolism_FeDeficient","BIOMD0000000256"->"Rehm2006_Caspase","BIOMD0000000257"->"Piedrafita2010_MR_System","BIOMD0000000254"->"Bier2000_GlycolyticOscillation","BIOMD0000000255"->"Chen2009_ErbB_Signaling","BIOMD0000000355"->"Abell2011_CalciumSignaling_WithAdaptation","BIOMD0000000356"->"Nyman2011_M3Hierarachical_InsulinGlucosedynamics","BIOMD0000000353"->"Nag2011_ChloroplasticStarchDegradation","BIOMD0000000354"->"Abell2011_CalciumSignaling_WithoutAdaptation","BIOMD0000000359"->"Panteleev2002_TFPImechanism_schmema3","BIOMD0000000357"->"Lee2010_ThrombinActivation_OneForm_reduced","BIOMD0000000358"->"Stortelder1997_ThrombinGeneration_AmidolyticActivity","BIOMD0000000403"->"Ayati2010_BoneRemodelingDynamics_WithTumour+DrugTreatment","BIOMD0000000404"->"Bray1993_chemotaxis","BIOMD0000000401"->"Ayati2010_BoneRemodelingDynamics_NormalCondition","BIOMD0000000402"->"Ayati2010_BoneRemodelingDynamics_WithTumour","BIOMD0000000400"->"Cooling2007_IP3transients_CardiacMyocyte","BIOMD0000000409"->"Queralt2006_MitoticExit_Cdc55DownregulationBySeparase","BIOMD0000000407"->"Schliemann2011_TNF_ProAntiApoptosis","BIOMD0000000408"->"Hettling2011_CreatineKinase","BIOMD0000000405"->"Cookson2011_EnzymaticQueueingCoupling","BIOMD0000000406"->"Moriya2011_CellCycle_FissionYeast","BIOMD0000000412"->"Pokhilko2012_CircClock_RepressilatorFeedbackloop","BIOMD0000000413"->"Band2012_DII-Venus_FullModel","BIOMD0000000414"->"Band2012_DII-Venus_ReducedModel","BIOMD0000000415"->"Mellor2012_LipooxygenasePathway","BIOMD0000000410"->"Wegner2012_TGFbetaSignalling_FeedbackLoops","BIOMD0000000411"->"Heiland2012_CircadianClock_C.reinhardtii","BIOMD0000000416"->"Muraro2011_Cytokinin-Auxin_CrossRegulation","BIOMD0000000417"->"Ratushny2012_NF","BIOMD0000000418"->"Ratushny2012_SPF","BIOMD0000000419"->"Ratushny2012_SPF_I"};

biomodel2model::wrngid="`1`";
Options[biomodel2model]=Options[sbml2model];

biomodel2model[]:=Module[{model},
Print@Panel[Pane[Grid[{With[{tmp=#[[1]]},Button[Style[tmp,Small],model=biomodel2model[tmp];SelectionMove[EvaluationNotebook[],Previous,Cell];
NotebookDelete[EvaluationNotebook[]],Method->"Queued"]],Hyperlink[#[[2]],"http://www.ebi.ac.uk/biomodels-main/"<>#[[1]]]}&/@biomodelID2name],ImageSize->{Automatic,450},Scrollbars->True]];
model
]

biomodel2model[id_String,opts:OptionsPattern[]]:=Module[{sbmlString,tmpFile},
If[DownValues[Biomodels`getModelSBMLById]==={},PrintTemporary["Biomodel's web API is used for the first time. Installing web services from http://www.ebi.ac.uk/biomodels-main/services/BioModelsWebServices?wsdl"];Quiet@InstallService["http://www.ebi.ac.uk/biomodels-main/services/BioModelsWebServices?wsdl","Biomodels`"]];
sbmlString=Biomodels`getModelSBMLById[id];
If[sbmlString===Null,Message[biomodel2model::wrngid,sbmlString];Abort[];];
tmpFile=OpenWrite[];
WriteString[tmpFile,sbmlString];
Close[tmpFile];
sbml2model[tmpFile[[1]],opts]
];


(* ::Subsection::Closed:: *)
(*eQuilibrator*)


eQuilibratorAPI::badRequest="Unable to process your query. Got following response: `1`";
eQuilibratorAPI[query_,url_String]:=Module[{client,method,httpCode},client=JLink`JavaNew["org.apache.commons.httpclient.HttpClient"];
method=JLink`JavaNew["org.apache.commons.httpclient.methods.PostMethod",url];
method@addRequestHeader["content-type","application/json"];
method@setRequestBody[ExportString[query/.n_Real:>If[Mod[n,1]==0.,Round[n]],"JSON","Compact"->True]];
httpCode=client@executeMethod[method];
If[httpCode==200,ImportString[method@getResponseBodyAsString[],"JSON"],Message[eQuilibratorAPI::badRequest,httpCode]]];


eQuilibratorCompoundData[query_]:=eQuilibratorAPI[query,"http://equilibrator.weizmann.ac.il/compound_data"]


eQuilibratorReactionData[query_]:=eQuilibratorAPI[query,"http://equilibrator.weizmann.ac.il/reaction_data"]


(* ::Subsection:: *)
(*Escher*)


model2escher[model_MASSmodel]:=Module[{reactionList,metList},
	reactionList = {"subsystem"->"","name"->getID[#],"upper_bound"->1000, "lower_bound"-> -1000, "notes"->{}, "metabolites"->reactionMets2escher[#], "objective_coefficient"->0, "variable_kind"->"continuous", "id"->getID[#],"gene_reaction_rule"->""}&/@model["Reactions"];
	metList = {"name"->ToString[#],"notes"->"{}", "annotation"->"{}", "_constraint_sense"->"E", "charge"->"0", "_bound"->"0.0", "formula"->elementalComposition2formula[#/.getElementalComposition[model]], "compartment"->ToString[getCompartment[#]],"id"->ToString[#]}&/@model["Species"];
	{"reactions"->reactionList, "description"->getName[model], "notes"->{}, "genes"->{}, "metabolites"->metList,"id"->getID[model]}
];


reactionMets2escher[rxn_reaction]:=Module[{stringList},
	MapThread[ToString[#1]->#2&,
		{Join[getProducts[rxn],getSubstrates[rxn]],Join[getProdStoich[rxn],-getSubstrStoich[rxn]]}]
]


(* ::Subsection::Closed:: *)
(*End*)


End[]
