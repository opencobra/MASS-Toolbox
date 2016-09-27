(* ::Package:: *)

(* ::Title:: *)
(*Types*)


(* ::Section:: *)
(*Definitions*)


$MASS$speciesTypes={metabolite,species,enzyme,protein,gene,complex};
$MASS$speciesPattern=Alternatives@@(Blank/@$MASS$speciesTypes);

$MASS$parameterTypes={rateconst,Keq,parameter,vmax,Km};
$MASS$parametersPattern=Alternatives@@(Blank/@$MASS$parameterTypes);

$MASS$headTypes={v,InChI,SMILES,metabolite,m,species,reaction,r,gene,protein,geneComplex,proteinComplex,enzyme,e,complex,rateconst,k,Keq,vmax,Km,Ki,Kd,parameter,p,MASSmodel,dGstd,dG};

(*$MASS$unitsPattern=Alternatives@@Join[{_?NumberQ,\[Infinity],-\[Infinity]},Symbol/@Names["Units`*"],Power[Symbol[#],_]&/@Names["Units`*"]]*)
$MASS$unitsPattern=Alternatives@@Join[{_?NumberQ,\[Infinity],-\[Infinity],_?(NumberQ[stripUnits[#]]&)}]


Begin["`Private`"]


(* ::Subsection:: *)
(*Notation style*)


simplyBlack[str_String]:=StyleBox[str,RGBColor[0,0,0],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
geneStyle[stuff_]:=StyleBox[stuff,Background->RGBColor[0,1,1],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
proteinStyle[stuff_]:=StyleBox[stuff,Background->RGBColor[1,0.5`,0],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
activatorStyle[stuff_]:=StyleBox[stuff,Background->None,StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
inhibitorStyle[stuff_]:=StyleBox[stuff,Background->None,StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]


(* ::Subsection:: *)
(*Fluxes*)


v/:MakeBoxes[v[id_String],_]:=InterpretationBox[SubscriptBox[#1,#2],v[id],Selectable->False,Editable->False]&[simplyBlack["v"],Evaluate@simplyBlack[id]]
v/:ToString[flux_v]:=StringJoin["v_"<>getID[flux]]
v/:getID[flux_v]:=flux[[1]]


(* ::Subsection:: *)
(*Compounds*)


chemicalElements={"H","He","Li","Be","B","C","N","O","F","Ne","Na","Mg","Al","Si","P","S","Cl","Ar","K","Ca","Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Zn","Ga","Ge","As","Se","Br","Kr","Rb","Sr","Y","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd","In","Sn","Sb","Te","I","Xe","Cs","Ba","La","Ce","Pr","Nd","Pm","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","W","Re","Os","Ir","Pt","Au","Hg","Tl","Pb","Bi","Po","At","Rn","Fr","Ra","Ac","Th","Pa","U","Np","Pu","Am","Cm","Bk","Cf","Es","Fm","Md","No","Lr","Rf","Db","Sg","Bh","Hs","Mt","Ds","Rg","Cn","Uut","Uuq","Uup","Uuh","Uus","Uuo"};


smiles2elementalComposition[smiles_String]:=Module[{},
inchi2elementalComposition[Import["!source ~/.bashrc ; echo '"<>smiles<>"' | obabel -i smi -o inchi","Text"]]
];
smiles2elementalComposition[smiles_SMILES]:=smiles2elementalComposition[smiles[[1]]]


inchi2elementalComposition[inchi_String]:=formula2elementalComposition[StringSplit[inchi,"/"][[2]]]
inchi2elementalComposition[inchi_InChI]:=inchi2elementalComposition[inchi[[1]]]


inchi2simpleInchi[inchi_String]:=StringJoin[Sequence@@Riffle[If[Length[#]>3,#[[1;;4]],#]&@StringSplit[inchi,"/"],"/"]]
inchi2simpleInchi[inchi_InChI]:=InChI[inchi2simpleInchi[inchi[[1]]]]


Options[elementalComposition2formula]={"PseudoElements"->True,"EscapingCharacter"->"&"};
elementalComposition2formula[composition:{(_String->_Integer)..},opts:OptionsPattern[]]:=Module[{elems=chemicalElements,tmp},
	tmp=StringJoin[Sequence@@(ToString/@Flatten[DeleteCases[Thread[List[elems,elems/.(composition/. 1->"")]],{a_,a_},1]])];
	If[OptionValue["PseudoElements"],tmp=tmp<>StringJoin[Sequence@@(OptionValue["EscapingCharacter"]<>#[[1]]<>OptionValue["EscapingCharacter"]<>ToString[#[[2]]]&/@FilterRules[composition,Except[elems]])]];
	tmp
];
elementalComposition2formula[composition:_Plus,opts:OptionsPattern[]]:=Module[{},
	elementalComposition2formula[Switch[#,_String,#->1,_Times,Cases[#,_String][[1]]->Cases[#,_?NumberQ][[1]]]&/@List@@composition,opts]
];
elementalComposition2formula[composition:_String,opts:OptionsPattern[]]:=Module[{},
	elementalComposition2formula[{composition->1},opts]
];
elementalComposition2formula[composition:_Times,opts:OptionsPattern[]]:=Module[{},
	elementalComposition2formula[{Cases[#,_String][[1]]->Cases[#,_?NumberQ][[1]]},opts]&[composition]
];


Options[formula2elementalComposition]=Options[elementalComposition2formula];
formula2elementalComposition[formula_String,opts:OptionsPattern[]]:=Module[{tmp,elems=chemicalElements,realElements,weirdElements},
	realElements=StringCases[formula,RegularExpression["("<>StringJoin@@Riffle[Join[Reverse@SortBy[elems,StringLength],{OptionValue["EscapingCharacter"]<>".*?"<>OptionValue["EscapingCharacter"]}],"|"]<>")(\\d*)"]:>Rule["$1",ToExpression["$2"/.""->"1"]]];
	If[OptionValue["PseudoElements"],
		weirdElements=OptionValue["EscapingCharacter"]<>#[[1]]<>OptionValue["EscapingCharacter"]->#[[2]]&/@Complement[StringCases[formula,RegularExpression["("<>StringJoin@@Riffle[Join[Reverse@SortBy[elems,StringLength],{OptionValue["EscapingCharacter"]<>".*?"<>OptionValue["EscapingCharacter"],"\\D"}],"|"]<>")(\\d*)"]:>Rule["$1",ToExpression["$2"/.""->"1"]]],realElements];,
		weirdElements={};
	];
	
	tmp=Sort[Join[realElements,weirdElements]];
	tmp=Plus@@Times@@@tmp
];


metabolite[id_String]:=metabolite[id,None];
metabolite/:MakeBoxes[metabolite[id_String],_]:=InterpretationBox[#,metabolite[id,Blank[]],Editable->False,Selectable->False]&[simplyBlack[id]];
metabolite/:MakeBoxes[metabolite[id_String,None],_]:=InterpretationBox[#,metabolite[id,None],Editable->False,Selectable->False]&[simplyBlack[id]];
metabolite/:MakeBoxes[metabolite[id_String,compartment_Blank],_]:=InterpretationBox[SuperscriptBox[#1,#2],metabolite[id,compartment],Editable->False,Selectable->False]&[simplyBlack[id],simplyBlack["_"]];
metabolite/:MakeBoxes[metabolite[id_String,compartment_String],_]:=InterpretationBox[SuperscriptBox[#1,#2],metabolite[id,compartment],Editable->False,Selectable->False]&[simplyBlack[id],simplyBlack[compartment]];
metabolite/:ToString[m_metabolite/;getCompartment[m]===None]:=StringReplace[getID@m,{"M\[UnderBracket]"->"",RegularExpression["\[UnderBracket].*?$"]->"","\[UnderBracket]"->"_"}]
metabolite/:ToString[m_metabolite/;getCompartment[m]===None,"SBML"]:=makeIdXmlConform[StringJoin["M_",getID@m]]
metabolite/:ToString[m_metabolite]:=StringJoin[StringReplace[getID@m,{"M\[UnderBracket]"->"",RegularExpression["\[UnderBracket].*?$"]->"","\[UnderBracket]"->"_"}],"[",StringReplace[getCompartment[m]/._Blank->"any","\[UnderBracket]"->"_"],"]"]
metabolite/:ToString[m_metabolite,"SBML"]:=makeIdXmlConform[StringJoin["M_",getID@m,"_",getCompartment[m]/._Blank->"any"]]
metabolite/:getID[m_metabolite]:=m[[1]]
metabolite/:getCompartment[m_metabolite]:=m[[2]]
metabolite/:setCompartment[m_metabolite,compartment:(_String|None)]:=metabolite[getID[m],compartment]


species[id_String]:=species[id,None];
species/:MakeBoxes[species[id_String,None],_]:=InterpretationBox[#,species[id,None],Editable->False,Selectable->False]&[simplyBlack[id]];
species/:MakeBoxes[species[id_String,compartment_Blank],_]:=InterpretationBox[#,species[id,Blank[]],Editable->False,Selectable->False]&[simplyBlack[id],simplyBlack["_"]];
species/:MakeBoxes[species[id_String,compartment_String],_]:=InterpretationBox[SuperscriptBox[#1,#2],species[id,compartment],Editable->False,Selectable->False]&[simplyBlack[id],simplyBlack[compartment]];
species/:ToString[m_species/;getCompartment[m]===None]:=StringReplace[getID@m,{"M\[UnderBracket]"->"",RegularExpression["\[UnderBracket].*?$"]->"","\[UnderBracket]"->"_"}]
species/:ToString[m_species]:=StringJoin[StringReplace[getID@m,{"M\[UnderBracket]"->"",RegularExpression["\[UnderBracket].*?$"]->"","\[UnderBracket]"->"_"}],"[",StringReplace[getCompartment[m]/._Blank->"any","\[UnderBracket]"->"_"],"]"]
species/:ToString[m_species,"SBML"]:=StringJoin["S_",getID@m,"_",getCompartment[m]/._Blank->"any"]
species/:getID[m_species]:=m[[1]]
species/:getCompartment[m_species]:=m[[2]]
species/:setCompartment[m_species,compartment:(_String|None)]:=metabolite[getID[m],compartment]


m[a___]:=Evaluate@metabolite[a]


InChI/:getID[cmpd_InChI]:=cmpd[[1]];


SMILES/:getID[cmpd_SMILES]:=cmpd[[1]];


(* ::Subsection:: *)
(*Reactions*)


(*
Union[args:PatternSequence[{_reaction..},{_reaction..}]..]:=Union[args,SameTest->SameQ]
Intersection[args:PatternSequence[{_reaction..},{_reaction..}]..]:=Intersection[args,SameTest->SameQ]
Complement[args:PatternSequence[{_reaction..},{_reaction..}]..]:=Complement[args,SameTest->SameQ]
*)


reaction::arglen="The number of substrates (`1`) and products (`2`) does not match the number of stoichiometric factors (`3`).";
reaction::negativestoich="Stoichiometric factors `1` should exclusively include numbers > 0";
reaction::unique="The specified `1` argument (`2`) is not a list of unique items.";
reaction[id_String,substrates:{$MASS$speciesPattern...},products:{$MASS$speciesPattern...},stoichiometry:{_?NumberQ..},revQ_:True]:=Block[{$preventRecursion=True,lenSub,lenProd,lenStoich},
	lenSub=Length[substrates];
	lenProd=Length[products];
	lenStoich=Length[stoichiometry];
	(*Check for negative numbers*)
	If[MemberQ[stoichiometry,num_/;num<=0],Message[reaction::negativestoich,stoichiometry];Abort[]];
	(*Check dimensions*)	
	If[lenSub+lenProd!=lenStoich,Message[reaction::arglen,lenSub,lenProd,lenStoich];Abort[]];
	Scan[If[Length[#[[2]]]!=Length[Union[#[[2]]]],Message[reaction::unique,#[[1]],#[[2]]];Abort[]]&,{{"substrates",substrates},{"products",products}}];
	reaction[id,substrates,products,integerChop@stoichiometry,revQ]
]/;!TrueQ[$preventRecursion];

With[{pat=$MASS$speciesPattern},
	reaction/:MakeBoxes[reaction[id_String,substrates:{pat...},products:{pat...},stoichiometry:{_?NumberQ..},revQ_],_]:=Block[{rhs,lhs},
		rhs=Switch[substrates,{},Style[Global`\[EmptySet],Black,StripOnInput->False],_,Plus@@Thread[Times[#,stoichiometry[[1;;Length[#]]]]]&@substrates];
		lhs=Switch[products,{},Style[Global`\[EmptySet],Black,StripOnInput->False],_,Plus@@Thread[Times[#,stoichiometry[[-Length[#];;]]]]&@products];
		If[revQ,
			InterpretationBox[OverscriptBox[#,#2],reaction[id,substrates,products,stoichiometry,revQ],Editable->False,Selectable->False]&[ToBoxes@Equilibrium[rhs,lhs],simplyBlack[id]],
			InterpretationBox[OverscriptBox[#,#2],reaction[id,substrates,products,stoichiometry,revQ],Editable->False,Selectable->False]&[ToBoxes@RightArrow[rhs,lhs],simplyBlack[id]]
		]
	];
];

reaction/:SameQ[rxns__reaction]:=(SameQ@@(getID/@List[rxns]))&&(SameQ@@(Sort[getCompounds[#]]&/@List[rxns]))&&Union[Chop[Subtract@@(getStoichiometry[#][[Ordering[getCompounds[#]]]]&/@List[rxns])]]=={0}&&Length[Union[reversibleQ/@List[rxns]]]==1
reaction/:Equal[rxns__reaction]:=SameQ[rxns]
reaction/:Equivalent[rxns__reaction]:=SameQ[rxns]
reaction/:Unequal[rxns__reaction]:=!SameQ[rxns]
reaction/:ToString[rxn_reaction,rev_:" <=> ",irev_:" --> "]:=getID[rxn]<>": "<>ToString[getSubstrStoich[rxn].(ToString/@getSubstrates[rxn])]<>If[reversibleQ[rxn],rev,irev]<>ToString[getProdStoich[rxn].(ToString/@getProducts[rxn])]
reaction/:Reverse[rxn_reaction]:=reaction[getID[rxn],getProducts[rxn],getSubstrates[rxn],Join[getProdStoich[rxn],getSubstrStoich[rxn]],reversibleQ[rxn]]


reaction/:getID[rxn_reaction]:=rxn[[1]];

reaction/:getCompounds[rxn_reaction]:=Join[rxn[[2]],rxn[[3]]];

reaction/:getSpecies[rxn_reaction]:=Join[rxn[[2]],rxn[[3]]];

reaction/:getSubstrates[rxn_reaction]:=rxn[[2]];

reaction/:getProducts[rxn_reaction]:=rxn[[3]];

reaction/:getStoichiometry[rxn_reaction]:=rxn[[4]];

reaction/:S[rxn_reaction]:=getStoichiometry[rxn]

reaction/:getSignedStoich[rxn_reaction]:=Join[-getSubstrStoich[rxn],getProdStoich[rxn]];

reaction/:getSubstrStoich[rxn_reaction]:=rxn[[4]][[1;;Length[rxn[[2]]]]];

reaction/:getProdStoich[rxn_reaction]:=rxn[[4]][[Length[rxn[[2]]]+1;;]];

reaction/:getCompartment[rxn_reaction]:=If[Length[#]==1,#[[1]],#]&[Union[getCompartment/@getCompounds[rxn]]];

reaction/:reversibleQ[rxn_reaction]:=rxn[[5]];

reaction/:makeReversible[rxn_reaction]:=ReplacePart[rxn,-1->True];

reaction/:makeIrreversible[rxn_reaction]:=ReplacePart[rxn,-1->False];

reactionQ[stuff_]:=MatchQ[stuff,reaction[__]];


r[a___]:=reaction[a]


reactionFromString[rxn_String,rev_:"<=>",irev_:"-->"]:=Module[{id,rest,revQ,lhs,rhs,substrStoich,substr,prodStoich,prod,metsAndStoich,cleanUpRedundant},
	metsAndStoich=If[#=={"0"},{{},{}},If[Length[#]==1,{1.,speciesFromString@#[[1]]},{ToExpression[#[[1]]],speciesFromString@#[[2]]}]]&/@(StringSplit[#,RegularExpression["\\s+"]]&/@StringSplit[#,RegularExpression["(?m)\\s*\\+\\s*"]])&;
	cleanUpRedundant=Transpose[List@@@Flatten[{(#1.#2)/.Plus->List}]]&;
	{id,rest}=StringSplit[rxn,":"];
	revQ=StringMatchQ[rxn,RegularExpression[".+"<>If[MatchQ[rev,_RegularExpression],rev[[1]],rev]<>".+"]];
	{lhs,rhs}=StringSplit[rest,(rev|irev)];
	{substrStoich,substr}=Transpose@metsAndStoich[lhs];
	If[Length[substr]>1,
		{substrStoich,substr}=cleanUpRedundant[substrStoich,substr];
	];
	{prodStoich,prod}=Transpose@metsAndStoich[rhs];
	If[Length[prod]>1,
		{prodStoich,prod}=cleanUpRedundant[prodStoich,prod];
	];
	reaction[id,Flatten@substr,Flatten@prod,Flatten[Join[substrStoich,prodStoich]]/. 1.->1,revQ]
];


(* ::Subsection:: *)
(*GPRs*)


gene[id_String,opts:OptionsPattern[]]:=gene[id,None,opts]
gene/:getID[g_gene]:=g[[1]]
gene/:getCompartment[g_gene]:=g[[2]]
gene/:setCompartment[g_gene,compartment:(_String|None)]:=gene[getID[g],compartment]
gene/:ToString[g_gene]:="gene_"<>ToString[getID@g]
gene/:getMetaData[g_gene]:=List@@g[[3;;]]
gene/:MakeBoxes[gene[id_String,None,opts:OptionsPattern[]],_]:=InterpretationBox[#,gene[id,None,opts],Selectable->False,Editable->False]&[geneStyle[FrameBox[id]]];
gene/:MakeBoxes[gene[id_String,blank_Blank,opts:OptionsPattern[]],_]:=InterpretationBox[#,gene[id,blank,opts],Selectable->False,Editable->False]&[geneStyle[FrameBox[SuperscriptBox[id,"_"]]]];
gene/:MakeBoxes[gene[id_String,comp_String,opts:OptionsPattern[]],_]:=InterpretationBox[#,gene[id,comp,opts],Selectable->False,Editable->False]&[geneStyle[FrameBox[SuperscriptBox[id,comp]]]];


protein[id_String,opts:OptionsPattern[]]:=protein[id,None,opts]
protein/:getID[p_protein]:=p[[1]]
protein/:getCompartment[p_protein]:=p[[2]]
protein/:setCompartment[p_protein,compartment:(_String|None)]:=protein[getID[p],compartment]
protein/:ToString[p_protein]:="protein_"<>ToString[getID@p]
protein/:getMetaData[p_protein]:=List@@p[[3;;]]
protein/:MakeBoxes[protein[id_String,None,opts:OptionsPattern[]],_]:=InterpretationBox[#,protein[id,None,opts],Selectable->False,Editable->False]&[proteinStyle[FrameBox[id]]];
protein/:MakeBoxes[protein[id_String,blank_Blank,opts:OptionsPattern[]],_]:=InterpretationBox[#,protein[id,blank,opts],Selectable->False,Editable->False]&[proteinStyle[FrameBox[SuperscriptBox[id,"_"]]]];
protein/:MakeBoxes[protein[id_String,comp_String,opts:OptionsPattern[]],_]:=InterpretationBox[#,protein[id,comp,opts],Selectable->False,Editable->False]&[proteinStyle[FrameBox[SuperscriptBox[id,comp]]]];


geneComplex/:MakeBoxes[geneComplex[genes__/;MatchQ[List[genes],{(True|_gene)..}]],_]:=StyleBox[InterpretationBox[FrameBox[GridBox[#]],geneComplex[genes],Selectable->False,Editable->False],Background->LightGray]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@List[genes]]];
geneComplex[genes__/;MemberQ[List[genes],False]]:=False


proteinComplex[proteins__/;MemberQ[List[proteins],False]]:=False
proteinComplex/:MakeBoxes[proteinComplex[proteins__/;MatchQ[List[proteins],{(True|_protein)..}]],_]:=StyleBox[InterpretationBox[FrameBox[GridBox[#]],proteinComplex[proteins],Selectable->False,Editable->False],Background->LightGray]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@List[proteins]]];


(* ::Subsection:: *)
(*Enzymes*)


enzyme::catalyticSitesFull="Catalytic sites full. Attempted binding of `1` ligand(s) to `2` free binding site(s).";
enzyme::activationSitesFull="Activation sites full. Attempted binding of `1` ligand(s) to `2` free binding site(s).";
enzyme::inhibitionSitesFull="Inhibition sites full. Attempted binding of `1` ligand(s) to `2` free binding site(s).";
Options[enzyme]={"ID"->"Burb","Compartment"->None,"BoundCatalytic"->{},"BoundActivators"->{},"BoundInhibitors"->{},"CatalyticSites"->\[Infinity],"ActivationSites"->\[Infinity],"InhibitionSites"->\[Infinity]};
enzyme[opts:OptionsPattern[]]:=Block[{$preventRecursion=True},
enzyme[{"ID"->OptionValue["ID"],
"Compartment"->OptionValue["Compartment"],
"BoundCatalytic"->OptionValue["BoundCatalytic"]/.met:$MASS$speciesPattern:>wrapHead[met],
"BoundActivators"->OptionValue["BoundActivators"]/.met:$MASS$speciesPattern:>wrapHead[met],
"BoundInhibitors"->OptionValue["BoundInhibitors"]/.met:$MASS$speciesPattern:>wrapHead[met],
"CatalyticSites"->OptionValue["CatalyticSites"],
"ActivationSites"->OptionValue["ActivationSites"],
"InhibitionSites"->OptionValue["InhibitionSites"]
}]
]/;!TrueQ[$preventRecursion];
E_enzyme["ID"]:="ID"/.E[[1]]
E_enzyme[attribute:(Alternatives@@Options[enzyme][[All,1]])]:=unwrapHead[(Evaluate[attribute/.E[[1]]])]

enzyme/:getID[E_enzyme]:=E["ID"]
enzyme/:setID[E_enzyme,newID_String]:=enzyme[Sequence@@updateRules[E[[1]],{"ID"->newID}]]
enzyme/:getCompartment[E_enzyme]:=E["Compartment"]
enzyme/:setCompartment[E_enzyme,compartment:(_String|None)]:=enzyme[Sequence@@updateRules[E[[1]],{"Compartment"->compartment}]]
enzyme/:getCatalytic[E_enzyme]:=E["BoundCatalytic"]
enzyme/:getActivators[E_enzyme]:=E["BoundActivators"]
enzyme/:getInhibitors[E_enzyme]:=E["BoundInhibitors"]
enzyme/:bindCatalytic[E_enzyme,m:Sequence[$MASS$speciesPattern..]]:=If[(Length[E["BoundCatalytic"]]+Length[List[m]])<=E["CatalyticSites"],enzyme[Sequence@@updateRules[E[[1]],{"BoundCatalytic"->Join[E["BoundCatalytic"],List[m]]}]],Message[enzyme::catalyticSitesFull,Length[List[m]],E["CatalyticSites"]-Length[E["BoundCatalytic"]]];Abort[];]
enzyme/:bindCatalytic[E_enzyme,m:{$MASS$speciesPattern..}]:=bindCatalytic[E,Sequence@@m]
enzyme/:dropCatalytic[E_enzyme]:={enzyme[Sequence@@updateRules[E[[1]],{"BoundCatalytic"->Drop[E["BoundCatalytic"],-1]}]],E["BoundCatalytic"][[-1]]}
enzyme/:bindActivator[E_enzyme,m:Sequence[$MASS$speciesPattern..]]:=If[(Length[E["BoundActivators"]]+Length[List[m]])<=E["ActivationSites"],enzyme[Sequence@@updateRules[E[[1]],{"BoundActivators"->Join[E["BoundActivators"],List[m]]}]],Message[enzyme::activationSitesFull,Length[List[m]],E["ActivationSites"]-Length[E["BoundActivators"]]];Abort[];]
enzyme/:bindActivators[E_enzyme,m:{$MASS$speciesPattern..}]:=bindActivator[E,Sequence@@m]
enzyme/:dropActivator[E_enzyme]:={enzyme[Sequence@@updateRules[E[[1]],{"BoundActivators"->Drop[E["BoundActivators"],-1]}]],E["BoundActivators"][[-1]]}
enzyme/:sortActivators[E_enzyme]:=enzyme[Sequence@@updateRules[E[[1]],{"BoundActivators"->Sort@E["BoundActivators"]}]]
enzyme/:bindInhibitor[E_enzyme,m:Sequence[$MASS$speciesPattern..]]:=If[(Length[E["BoundInhibitors"]]+Length[List[m]])<=E["InhibitionSites"],enzyme[Sequence@@updateRules[E[[1]],{"BoundInhibitors"->Join[E["BoundInhibitors"],List[m]]}]],Message[enzyme::inhibitionSitesFull,Length[List[m]],E["InhibitionSites"]-Length[E["BoundInhibitors"]]];Abort[];]
enzyme/:bindInhibitors[E_enzyme,m:{$MASS$speciesPattern..}]:=bindInhibitor[E,Sequence@@m]
enzyme/:dropInhibitor[E_enzyme]:={enzyme[Sequence@@updateRules[E[[1]],{"BoundInhibitors"->Drop[E["BoundInhibitors"],-1]}]],E["BoundInhibitors"][[-1]]}
enzyme/:sortInhibitors[E_enzyme]:=enzyme[Sequence@@updateRules[E[[1]],{"BoundInhibitors"->Sort@E["BoundInhibitors"]}]]

enzyme/:MakeBoxes[e:enzyme[{_Rule..}],_]:=InterpretationBox[UnderoverscriptBox[#1,#3,#2],e,Selectable->False,Editable->False]&[
	StyleBox[RowBox[Riffle[Join[{SuperscriptBox[simplyBlack@e["ID"],simplyBlack@(e["Compartment"]/.(_Blank|None)->"")]},MakeBoxes[#]&/@e["BoundCatalytic"]],"&"]],Background->Lighter@LightGray],
	RowBox[ToBoxes[#]/._RGBColor:>RGBColor[0,2/3,0]&/@e["BoundActivators"]],RowBox[ToBoxes[#]/._RGBColor:>RGBColor[2/3,0,0]&/@e["BoundInhibitors"]]
]

(*Backwards compatibility*)
enzyme[id_String]:=enzyme["ID"->id]
enzyme[id_String,catalytic_List]:=enzyme["ID"->id,"BoundCatalytic"->catalytic]
enzyme[id_String,catalytic_List,activators_List]:=enzyme["ID"->id,"BoundCatalytic"->catalytic,"BoundActivators"->activators]
enzyme[id_String,catalytic_List,activators_List,inhibitors_List]:=enzyme["ID"->id,"BoundCatalytic"->catalytic,"BoundActivators"->activators,"BoundInhibitors"->inhibitors]

(*enzyme/:ToString[E_enzyme]:="enzyme["<>StringReplace[ToString[E[[1]]]," "->""]<>"]"*)
(*enzyme/:ToString[E_enzyme]:="enzyme"<>ToString[Hash[E]]*)
enzyme/:ToString[E_enzyme]:=Module[{adjustSpeciesCompartments,id,comp,catalytic,activators,inhibitors},
	adjustSpeciesCompartments=If[getCompartment[#]=!=comp,#,setCompartment[#,None]]&;
	id=getID[E];
	comp=getCompartment[E];
	catalytic=ToString[adjustSpeciesCompartments[#]]&/@getCatalytic[E];
	activators=ToString[adjustSpeciesCompartments[#]]&/@getActivators[E];
	inhibitors=ToString[adjustSpeciesCompartments[#]]&/@getInhibitors[E];
	"E_"<>id<>"["<>comp<>"]"<>
		StringJoin[Sequence@@("&"<>#&/@catalytic)]<>
			StringJoin[Sequence@@("@"<>#&/@activators)]<>StringJoin[Sequence@@("#"<>#&/@inhibitors)]
];
enzyme/:ToString[E_enzyme,"SBML"]:=makeIdXmlConform[ToString[E]]


e[a___]:=enzyme[a]


(* ::Subsection:: *)
(*Complexes*)


complex::multiCompartments="Multiple compartments encountered in complex `1`;";
complex[elements__]:=Block[{$preventRecursion=True,comp},
	comp=Union[Flatten[If[MatchQ[#,$MASS$speciesPattern],getCompartment[#],Unevaluated[Sequence[]]]&/@{elements}]];
	If[Length[comp]>1,Message[complex::multiCompartments,complex[elements]]];
	complex[elements]
]/;!TrueQ[$preventRecursion]
complex/:MakeBoxes[complex[elements__],_]:=StyleBox[InterpretationBox[FrameBox[GridBox[#]],complex[elements],Selectable->False,Editable->False],Background->LightGray]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@List[elements]]];


complex/:MakeBoxes[complex[elem__],_]:=InterpretationBox[GridBox[#,GridBoxDividers->{"Rows"->{{True}},"Columns"->{{True}}}],complex[elem],Selectable->False,Editable->False]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@(Times@@@Tally[List[elem]])]]
bind[elem_,elems__]:=complex[elem,elems]
complex/:bind[c_complex,species__]:=complex[Sequence@@c,species]
complex/:getCompartment[complex[elem__]]:=If[MatchQ[#,{_}],#[[1]],#]&[Union[getCompartment/@List[elem]]]
complex/:getID[complex[elem__]]:=ToString[complex[elem]]
complex/:ToString[complex[elem__]]:=StringJoin[Sequence@@Riffle[ToString/@(Times@@@Tally[ToString/@List[elem]])," & "]]


(* ::Subsection:: *)
(*Thermodynamics*)


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


dG/:MakeBoxes[dG[fluxID_String],StandardForm]:=InterpretationBox[SubscriptBox["\[CapitalDelta]G",fluxID],dG[fluxID]]
dG/:getID[elem_dG]:=elem[[1]]
dG/:ToString[elem_dG]:="dG_"<>ToString[getID[elem]];


(* ::Subsection:: *)
(*Parameters*)


rateconst[fluxID_String]:=rateconst[fluxID,True]
rateconst/:MakeBoxes[rateconst[fluxID_String],_]:=InterpretationBox[SubsuperscriptBox["k",#,"\[LongRightArrow]"],rateconst[fluxID,True],Selectable->False,Editable->False]&[simplyBlack[fluxID]];
rateconst/:MakeBoxes[rateconst[fluxID_String,True],_]:=InterpretationBox[SubsuperscriptBox["k",#,"\[LongRightArrow]"],rateconst[fluxID,True],Selectable->False,Editable->False]&[simplyBlack[fluxID]];
rateconst/:MakeBoxes[rateconst[fluxID_String,False],_]:=InterpretationBox[SubsuperscriptBox["k",#,"\[LongLeftArrow]"],rateconst[fluxID,False],Selectable->False,Editable->False]&[simplyBlack[fluxID]];
rateconst/:getID[r_rateconst]:=r[[1]]
rateconst/:ToString[k_rateconst]:="k_"<>getID[k]<>If[k[[2]]===True,"_fwd","_rev"];
rateconst/:ToString[k_rateconst,"SBML"]:=makeIdXmlConform[ToString[k]];


(*Shorthand for rateconst*)

k[a___]:=Evaluate@rateconst[a]


Keq/:MakeBoxes[Keq[fluxID_String],_]:=InterpretationBox[UnderscriptBox["K",#],Keq[fluxID],Selectable->False,Editable->False]&[simplyBlack[fluxID]]
Keq/:getID[k_Keq]:=k[[1]]
Keq/:ToString[K_Keq]:="Keq_"<>getID[K];
Keq/:ToString[K_Keq,"SBML"]:=makeIdXmlConform[ToString[K]];


vmax/:MakeBoxes[vmax[rxnID_String],_]:=InterpretationBox[UnderscriptBox[SubscriptBox["v",#2],#],vmax[rxnID],Selectable->False,Editable->False]&[simplyBlack[rxnID],simplyBlack["max"]]
vmax/:MakeBoxes[vmax[rxnID_String,index_Integer],_]:=InterpretationBox[UnderscriptBox[SubscriptBox["v",#2],#],vmax[rxnID,index],Selectable->False,Editable->False]&[simplyBlack[rxnID<>","<>ToString[index]],simplyBlack["max"]]
vmax/:getID[param_vmax]:=param[[1]]
vmax/:ToString[param_vmax]:="vmax_"<>getID[param];
vmax/:ToString[param_vmax,"SBML"]:=makeIdXmlConform[ToString[param]];


Km[m:$MASS$speciesPattern,rxnID_String]:=Block[{$preventRecursion=True},Km[wrapHead[m],rxnID]]/;!TrueQ[$preventRecursion];
Km/:MakeBoxes[Km[met_,rxnID_String],_]:=With[{m=simplyBlack@unwrapHead[met],r=simplyBlack[rxnID]},InterpretationBox[SubsuperscriptBox[SubscriptBox["K","m"],r,m],Km[met,rxnID],Selectable->False,Editable->False]]
Km/:getID[param_Km]:={unwrapHead[param[[1]]],param[[2]]}
Km/:ToString[param_Km]:="Km_"<>StringJoin[Sequence@@Riffle[ToString/@getID[param],"_"]];
Km/:ToString[param_Km,"SBML"]:=makeIdXmlConform[ToString[param]];


Ki[m:$MASS$speciesPattern,rxnID_String]:=Block[{$preventRecursion=True},Ki[wrapHead[m],rxnID]]/;!TrueQ[$preventRecursion];
Ki/:MakeBoxes[Ki[met_,rxnID_String],_]:=With[{m=simplyBlack@unwrapHead[met],r=simplyBlack[rxnID]},InterpretationBox[SubsuperscriptBox[SubscriptBox["K","i"],r,m],Ki[met,rxnID],Selectable->False,Editable->False]]
Ki/:getID[param_Ki]:={unwrapHead[param[[1]]],param[[2]]}
Ki/:ToString[param_Ki]:="Ki_"<>StringJoin[Sequence@@Riffle[ToString/@getID[param],"_"]];
Ki/:ToString[param_Ki,"SBML"]:=makeIdXmlConform[ToString[param]];


Kd[m:$MASS$speciesPattern,rxnID_String]:=Block[{$preventRecursion=True},Kd[wrapHead[m],rxnID]]/;!TrueQ[$preventRecursion];
Kd/:MakeBoxes[Kd[met_,rxnID_String],_]:=With[{m=simplyBlack@unwrapHead[met],r=simplyBlack[rxnID]},InterpretationBox[SubsuperscriptBox[SubscriptBox["K","d"],r,m],Kd[met,rxnID],Selectable->False,Editable->False]]
Kd/:getID[param_Kd]:={unwrapHead[param[[1]]],param[[2]]}
Kd/:ToString[param_Kd]:="Kd_"<>StringJoin[Sequence@@Riffle[ToString/@getID[param],"_"]];
Kd/:ToString[param_Kd,"SBML"]:=makeIdXmlConform[ToString[param]];


parameter/:MakeBoxes[parameter[paramID_String,rxnID_String],_]:=InterpretationBox[UnderscriptBox[#,#2],parameter[paramID,rxnID],Selectable->False,Editable->False]&[simplyBlack[paramID],simplyBlack[rxnID]]
parameter/:MakeBoxes[parameter[paramID_String],_]:=InterpretationBox[UnderscriptBox[#,#2],parameter[paramID],Selectable->False,Editable->False]&[simplyBlack[paramID],simplyBlack["Global"]]
parameter/:getID[param_parameter]:=If[Length[param]==1,param[[1]],{param[[1]],param[[2]]}]
parameter/:ToString[param_parameter]:="param_"<>StringJoin[Sequence@@Riffle[ToString/@Flatten[{getID[param]}],"_"]];
parameter/:ToString[parameter["Volume",comp_String],"SBML"]:=makeIdXmlConform[comp];
parameter/:ToString[param_parameter,"SBML"]:=makeIdXmlConform[ToString[param]];
parameter["Volume",None]:=1;


p[a___]:=Evaluate@parameter[a]


complementParameters[param:{_Rule...}]:=Module[{ids,completeSet},
	ids=Union[getID/@DeleteCases[param[[All,1]],Append[$MASS$speciesPattern,_parameter]]];
	If[ids==={},Return[param]]; (*Nothing to complement ...*)
	completeSet=Thread[Rule[#,#]]&@Flatten[Transpose[Table[{rateconst[i,True],rateconst[i,False],Keq[i]},{i,ids}]]];
	Join[
		FixedPoint[#/.{Rule[a_Keq,b_]:>(a->keq2k[b/.param]),Rule[a:rateconst[_,True],b_]:>(a->kFwd2keq[b/.param]),Rule[a:rateconst[_,False],b_]:>(a->k2keq[b/.param])}&,completeSet],
		FilterRules[param,Append[$MASS$speciesPattern,_parameter]]
	]
];
complementParameters[{}]:={}


(* ::Subsection:: *)
(*Numbers*)


Unprotect[ToString];
ToString[x_?NumericQ,"SBML"]:=Module[{str},
	Off[AccountingForm::sigz];
	str=StringReplace[ToString[Quiet@AccountingForm[N[x]]],"("~~num__~~")":>"-"<>num];
	On[AccountingForm::sigz];
	str
];
ToString[Infinity,"SBML"]:="INF";
ToString[-Infinity,"SBML"]:="-INF";
Protect[ToString];


(* ::Subsection:: *)
(*End*)


End[]
