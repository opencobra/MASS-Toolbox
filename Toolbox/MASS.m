(* ::Package:: *)

(* ::Title:: *)
(*MASS*)


(* ::Section:: *)
(*Documentation*)


(* ::Subsection:: *)
(*Assorted*)


(* Exported symbols added here with SymbolName::usage *) 


stripTime::usage="stripTime[expr] will remove the time dependency of variables, e.g. x[t] -> x";


particles2conc::usage="particles2conc[particlesProfile, model] will translate particle numbers into concentrations.";


conc2particles::usage="conc2particles[concentrationProfile, model] will translate concentrations into particle numbers.";


bind::usage="bind[species1, species2] generates complex of species1 and species2."


Toolbox::usage="MASS represent the namespace for a handfull of global exceptions and warnings.";


t::usage="t is a common variable representing time. Don't try to overwrite it.";


stringShortener::usage="###FIXME###.";


str2mass::usage="Parses string representations of metabolites, rate and equilibrium constants and other parameters.";


symbolize::usage="symbolize[stuff] takes any MASS modeling related equations or data structures and replaces metabolite, Keq, etc. by real symbols. It returns the translated input and a list of rules to reverse the process.";


pools2poolMatrix::usage="pools2poolMatrix[model, pools], where pools should look like {\"poolID\"-> m[\"id1\", \"c\"] + 2 m[\"id2\", \"c\"], ...}, returns a correctly sorted pool matrix, such that poolmatrix.model works.";


anonymize::usage="anonymize[f_[args__]] uses symbolize to translate any metabolite, rateconst etc. in args into real symbols. Afterwards, the output of f is translated back to the original args.";


annotateCurrencyMetabolites::usage="annotateCurrencyMetabolites[rxns] provides a GUI interface for annotating currency metabolites. The output is a list of rules ({\"rxnID\"->{currMet1, currMet1, ..}}) that specifies currency metabolites on a reactin basis. The number keys on the keyboard can be used to specify the currency metabolites in addition to the computer mouse.";


edit::usage="Opens a GUI dialog for editing.";


editModelInPlace::usage="editModelInPlace[model, attribute] opens a GUI for editing. Changes are stored in place.";


editModel::usage="editModel[model, attribute] opens a GUI for editing. A copy of model (including the changes) is returned.";


(* ::Subsection:: *)
(*Species & Reactions*)


e::usage="Shorthand for enzyme.";


enzyme::usage="enzyme[\"id\"] represents an enzyme.";


getCatalytic::usage="getCatalytic[enzyme] returns a list of catalytically bound ligands.";
getActivators::usage="getActivators[enzyme] returns a list of bound activators.";
getInhibitors::usage="getInhibitors[enzyme] returns a list of bound inhibitors.";
bindCatalytic::usage="bindCatalytic[enzyme] binds a ligand to the enzyme's catalytic binding site.";
dropCatalytic::usage="dropCatalytic[enzyme] removes a ligand from the enzyme's catalytic binding site.";
bindActivator::usage="bindActivator[enzyme] binds an activator to enzyme.";
bindActivators::usage="bindActivators[enzyme] binds multiple activators to enzyme.";
sortActivators::usage="";
dropActivator::usage="dropActivator[enzyme] removes an activator from the enzyme.";
bindInhibitor::usage="bindInhibitor[enzyme] binds an inhibitor to enzyme.";
bindInhibitors::usage="bindInhibitors[enzyme] binds multiple inhibitors to enzyme.";
sortInhibitors::usage="";
dropInhibitor::usage="dropInhibitor[enzyme] removes an inhibitor from the enzyme."


gene::usage="gene[id] encodes a gene.";


geneComplex::usage="geneComplex[gene1, gene2, ..] encodes a gene complex.";


makeIrreversible::usage="makeIrreversible[rxn] make rxn irreversible and leaves it unchanged if it was already irreverible.";


makeReversible::usage="makeReversible[rxn] makes rxn reversible and leaves it unchanged if it was alreay reversible";


metabolite::usage="metabolite[cmpdID, compartment] represents a compound in a specific cellular compartment. metabolite[cmpdID] represents the compound in any compartment.";
m::usage="m[id, compartment] is just a shorthand form for metabolite[id, compartment] ...";


protein::usage="protein[id] encodes a protein.";


proteinComplex::usage="proteinComplex[protein1, protein2, ...] encodes a protein complex.";


reaction::usage="reaction[id_String, substrates, products, stoichiometry, revQ] represents/constructs a reaction. The argument stoichiometry contains the stoichiometric factors (all positive). Argument revQ indicates a reversible reaction if True or an irreversible if False. \[EmptySet] is assumed if substrates or products are omitted.";
r::usage="r is just a shorthand form for reaction ...";


reactionQ::usage="reactionQ[expr] returns True if expr is a reaction.";


reversibleQ::usage="reversibleQ[rxn] returns True when reaction rxn is reversible and False if not.";


species::usage="###FIXME###";


v::usage="v[id] represents the flux of a reaction."


(* ::Subsection:: *)
(*Parameters*)


Keq::usage="Keq[fluxID_String] represents the equilibrium constant for the reaction \"fluxID\"";


Km::usage="Km[met, rxnID] represents a Michaelis-Menten constant."


Ki::usage="Ki[met, rxnID] represents an inhibition constant."


Kd::usage="Ki[met, rxnID] represents an inhibition constant."


parameter::usage="parameter[parameterID_String, secondaryID_String] -> \!\(\*UnderscriptBox[\(parameterID\), \(secondaryID\)]\) or parameter[parameterID_String] -> \!\(\*UnderscriptBox[\(parameterID\), \(Global\)]\) are generic parameter descriptors.";


p::usage="p is shorthand for parameter."


rateconst::usage="rateconst[fluxID_String, True] <=> \!\(\*SubsuperscriptBox[\(k\), \(fluxID\), \(\[LongRightArrow]\)]\) and rateconst[fluxID_String, False] <=> \!\(\*SubsuperscriptBox[\(k\), \(fluxID\), \(\[LongLeftArrow]\)]\) represent rate constants for the forward and reverse directions of reaction \"fluxID\".";


k::usage="k is a shorthand for rateconst."


vmax::usage="vmax[rxnID] represents a vmax parameter.";


(* ::Subsection:: *)
(*Model construction*)


constructModel::usage="constructModel[reactions] constructs a MASSmodel from reactions.";


MASSmodel::usage="MASSmodel is a data structure describing the static content of a metabolic system.";


(* ::Subsection:: *)
(*Model manipulation*)


addExchange::usage="addExchange[model_MASSmodel,m_species] adds a exchange reaction for metabolite to model.";


addExchanges::usage="addExchange[model_MASSmodel,metabolites] adds a exchange reactions for multiple metabolites to model.";


addReaction::usage="addReaction[model_MASSmodel, rxn_reaction] adds reaction 'rxn' to model.";


addReactions::usage="addReactions[model_MASSmodel, rxns:{_reaction..}] adds reactions 'rxns' to model.";


addSink::usage="addSink[model, species] will add a sink for species to model.";


addSinks::usage="addSinks[model] will add sinks for compounds that are only produced but not consumed. addSinks[modelm, {species1, species2, ...}] will add sinks for the specified species to model."


deleteGene::usage="deleteGene[model, gene] deletes gene from model. Depending reactions and proteins are also removed.";


deleteGenes::usage="deleteGenes[model, genes] deletes genes from model. Depending reactions and proteins are also removed.";


(*deleteSpecies::usage="deleteSpecies[model_MASSmodel, species] deletes species from model.";*)


deleteProtein::usage="deleteProtein[model, protein] deletes protein from model. Depending reactions and associated genes are also removed.";


deleteProteins::usage="deleteProteins[model, proteins] deletes proteins from model. Depending reactions and associated genes are also removed.";


deleteReaction::usage="deleteReaction[model, rxnID] deletes reaction with id 'rxnID' from model. Metabolites unique to the specified reaction are also removed.";


deleteReactions::usage="deleteReactions[model_MASSmodel, rxnIDs_List] deletes reactions 'rxnIDs' from model.";


splitReversible::usage="splitReversible[S, ColumnIDs, reversibleColumnIndices] splits reversible reactions (reversibleColumnIndices) into two irreversible reactions in the metabolic system represented by the stoichiometry matrix stoich. The updated matrix as well as the the new set of reaction identifiers are returned. An overloaded MASSmodel version of this function (splitReversible[mode;_MASSmodel]) also exists. It returns an updated copy of model.";


subModel::usage="subModel[model, {rxn1, rxn2, ...}] will extract a sub-model consisting of the specified reactions.";


(* ::Subsection:: *)
(*QC/QA*)


detectUnconservedMetabolites::usage="detectUnconservedMetabolites[stoichiometry, compounds] implements  (works with a model structure too)";


elementallyBalancedQ::usage="Checks if provided model is elementally balanced.";


stoichiometricallyConsistentQ::usage="Checks the stochiometric consistency of provide matrix or model (see Gevorgyan, A., Poolman, M. G., & Fell, D. A. (2008). Detection of stoichiometric inconsistencies in biomolecular models Bioinformatics (Oxford, England), 24(19), 2245\[Dash]2251. doi:10.1093/bioinformatics/btn425).";


(* ::Subsection:: *)
(*Chemoinformatics*)


elementalComposition2formula::usage="elementalComposition2formula[{\"C\"->10,\"H\"->16,\"N\"\[Rule]1,\"O\"->13,\"P\"->3}], for example, generate the molecular formula \"H16C10NO13P3\". Pseudo elements, e.g. \"NAD\", are escaped using \"&\".";


formula2elementalComposition::usage="formula2elementalComposition[\"H16C10NO13P3&NAD&\"] translates into the elemental composition rules {\"C\"\[Rule]10,\"H\"\[Rule]16,\"N\"\[Rule]1,\"O\"\[Rule]13,\"P\"\[Rule]3,\"NAD\"\[Rule]1}; &NAD& represents a  pseudo element (see als elementalComposition2formula).";


InChI::usage="Wrapper for an InChI string.";


inchi2elementalComposition::usage="Returns the elemental composition of a InChI string";


inchi2simpleInchi::usage="inchi2simpleInchi[inchi] extracts the main layer of inchi (effectively discarding the stereo-chemistry and other optional layers).";


SMILES::usage="Wrapper for a SMILES string.";


smiles2elementalComposition::usage="Returns the elemental composition of a SMILES string";


(* ::Subsection:: *)
(*Units*)


adjustUnits::usage="###FIXME###";


stripUnits::usage="stripUnits[exprs] will remove all units (as defined in the Units` package) from expression.";


(* ::Subsection:: *)
(*Structural*)


getDisequilibriumRatios::usage="getDisequilibriumRatios[stoichiometry, mets, equilbrium] returns \[CapitalGamma]/K (thermodynamic driving forces).";


\[Rho]::usage="\[Rho][model] is a shorthand for getDisequilibriumRatios[model]";


getMassActionRatios::usage="getMassActionRatios[stoichiometry, mets] returns \[CapitalGamma] (mass action ratios).";


\[CapitalGamma]::usage="\[CapitalGamma][model] is a shorthand for getMassActionRatios[model]";


getGradient::usage="getGradient[rates_List, mets_List] calculates the gradient matrix, given reaction rate expressions and metabolites. An overloaded MASSmodel version exists (getJacobian[model_MASSmodel])";


G::usage="G[model] is shorthand for getGradient[model]";


getJacobian::usage="getJacobian[stoich_?MatrixQ, rates_List, mets_List, type_:\"conc\"] calculates the Jacobian matrix, given stoichiometric matrix, reaction rate expressions and metabolites. Uses the function getGradient. Default is the concentration Jacobian. Optional argument specifies which Jacobian to calculate (flux vs conc). \ne.g. fluxJac = getJacobian[sMat, rates, mets, \"flux\"];. An overloaded MASSmodel version exists (getJacobian[model_MASSmodel])";


J::usage="J[model] is a shorthand for getJacobian[model]";


calcKappa::usage="calcKappa[rateconstants] ###FIXME###";


calcLinkMatrix::usage="calcLinkMatrix[s_?MatrixQ] returns the new order of S, S, reduced S and the corresponding link matrix.";


\[Kappa]::usage="\[Kappa][model] is a shorthand for calcKappa[model].";


L::usage="L[model] returns the link matrix of model.";


L0::usage="L0[model] returns the L0 matrix of model describing the conservation relationships of the dependent species.";


(* ::Subsection:: *)
(*Parameter estimation*)


calcPERC::usage="calcPERC[model, steadystateConc, steadystateFluxes, equilibriumConstants] calculates \"Pseudo-Elementary-Rate-Constants\" for the forward rate constanstants. calcPERC[stoich_, rowIDs_List, columnIDs, steadystateConc, steadystateFluxes, equilibriumConstants] can be uses for the more fundamental data types.";


complementParameters::usage="complementParameters[parameters] complements parameter set by calculating and inserting missing equilibrium (Keq) and rate (k) constants.";


(* ::Subsection:: *)
(*Accessors*)


getCompartment::usage="getCompartment[reaction|enzyme|species|model] returns the associated compartment(s) of the provided expression.";


setCompartment::usage="setCompartment[enzyme|species] will set a new compartment compartment for the provided species.";


getCompounds::usage="getCompounds[rxn] returns compounds of reaction rxn.";


getSpecies::usage="getSpecies[rxn] returns substrates and produces of rxn.";


getID::usage="getID[struct] returns the identifier of the provided structure.";


getMetaData::usage="getMetaData[struct] returns a list of meta information associated with struct."


getProdStoich::usage="getProdStoich[rxn] returns stoichiometric factors corresponding to products of reaction rxn.";


getProducts::usage="getProducts[rxn] returns products of reaction rxn.";


getSignedStoich::usage="getSignedStoich[rxn] returns signed stoichiometric factors of reaction rxn (coefficients associated with substrates are negative).";


getStoichiometry::usage="getStoichiometry[expression] returns stoichiometric factors of expression (e.g. a reaction or model).";


getSubstrates::usage="getSubstrates[rxn] returns substrates of reaction rxn.";


getSubstrStoich::usage="getSubstrStoich[rxn] returns stoichiometric factors corresponding to substrates of reaction rxn.";


S::usage="S[expression] is a shorthand for getStoichiometry[expression]";


SRed::usage="S[model] is a shorthand for model[\"Stoichiometry\"]";


(* ::Subsection:: *)
(*Translators*)


k2keq::usage="Shorthand for kRev2keq.";


keq2k::usage="keq2k[expression] replaces all \!\(\*UnderscriptBox[\(K\), \(FluxID\)]\) by  \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]]\)";


kFwd2keq::usage="kFwd2keq[expression] replaces all \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)]\) by \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]\) \!\(\*UnderscriptBox[\(K\), \(FluxID\)]\)";


kRev2keq::usage="kRev2keq[expression] replaces all \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]\) by \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], UnderscriptBox[\(K\), \(FluxID\)]]\)";


(* ::Subsection:: *)
(*Old*)


(*modalDecomposition::usage="modalDecomposition[jac_, norm_:0, cutoff_:Sqrt[2], removepairs_:1, evalCutOff_:1*^-15] computes the modal decomposition given the Jacobian.  Optional arguments are the norm (default is 0 - no normalization), the cutoff value to for flagging large imaginary components for the eigenvalues, and a decision variable for whether or not to remove complex conjugate pairs (default is 1 = remove complex conjugate pairs). Final option, evalCutOff specifies a cut-off for the eigenvalues - default is 1*^-15 - the modes should be composed of left null space variable interactions.\n\t{ts, modes} = modalDecomposition[rbcjac, 1,1.5,1, 1*^-12]; ";*)


(*reactionFromString::usage="reactionFromString[\"vpfk: atp_c + f6p_c <=> adp_c + fbp_c + h_periplasm\"] will parse the reaction string and return reaction[\"vpfk\", {metabolite[\"atp\", \"c\"], metabolite[\"f6p\", \"c\"]}, {metabolite[\"adp\", \"c\"], metabolite[\"fbp\", \"c\"], metabolite[\"h\", \"periplasm\"]}, {1, 1, 1, 1, 1}, True]";*)


(*setModelAttribute::usage="setModelAttribute[model, attribute, rhs] changes the model's attribute 'in place' to rhs";*)


(*keq2k::usage="keq2k[expression] replaces all \!\(\*UnderscriptBox[\(K\), \(FluxID\)]\) by  \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]]\)";*)


(*k2keq::usage="k2keq[expression] replaces all \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]\) by \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], UnderscriptBox[\(K\), \(FluxID\)]]\)";*)


(*\[EmptySet]::usage="\[EmptySet] represents a sink/source ... ###FIXME###"*)


(*updateModelAttribute::usage="updateModelAttribute[model, attribute, rhs] update the model's attribute 'in place' with rhs";*)


(* ::Section:: *)
(*Definitions*)


$MASS$speciesTypes={metabolite,species,enzyme,protein,gene,complex};
$MASS$speciesPattern=Alternatives@@(Blank/@$MASS$speciesTypes);

$MASS$parameterTypes={rateconst,Keq,parameter,vmax,Km};
$MASS$parametersPattern=Alternatives@@(Blank/@$MASS$parameterTypes);

(*$MASS$unitsPattern=Alternatives@@Join[{_?NumberQ,\[Infinity],-\[Infinity]},Symbol/@Names["Units`*"],Power[Symbol[#],_]&/@Names["Units`*"]]*)
$MASS$unitsPattern=Alternatives@@Join[{_?NumberQ,\[Infinity],-\[Infinity],_?(NumberQ[stripUnits[#]]&)}]


(* Stoolbox compatibility!!! *)
(Unprotect[#];Evaluate[Symbol["MASStoolbox`MASS`"<>ToString[#]]]:=Evaluate[Symbol["Toolbox`"<>ToString[#]]];Protect[#])&/@(Join[$MASS$speciesTypes,$MASS$parameterTypes,{v,reaction,gene,geneComplex,protein,proteinComplex,enzyme}]);


Begin["`Private`"];


(* ::Subsection:: *)
(*Util*)


stripTime[expr_]:=expr/.(pat:Join[$MASS$speciesPattern,$MASS$parametersPattern])[t]:>pat


Unprotect[conc2particles];
conc2particles[concProfile:{(Join[$MASS$speciesPattern,$MASS$parametersPattern]->_)..},volumes:{(parameter["Volume",_]->_)...}]:=Module[{},
	concProfile/.r_Rule/;MatchQ[r[[1]],$MASS$speciesPattern]:>r[[1]]->r[[2]]*(parameter["Volume",getCompartment[r[[1]]]]/.volumes(*compartments might be part of the solution*)/.concProfile)
];
conc2particles[concProfile:{(Join[$MASS$speciesPattern,$MASS$parametersPattern]->_)..},model_MASSmodel]:=conc2particles[concProfile,FilterRules[model["Parameters"],parameter["Volume",_]]];
def:conc2particles[___]:=(Message[Toolbox::badargs,conc2particles,Defer@def];Abort[])
Protect[conc2particles];


Unprotect[particles2conc];
particles2conc[particleProfile:{($MASS$speciesPattern->_)..},volumes:{(parameter["Volume",_]->_)..}]:=Module[{},
	particleProfile/.r_Rule/;MatchQ[r[[1]],$MASS$speciesPattern]:>r[[1]]->r[[2]]/(parameter["Volume",getCompartment[r[[1]]]]/.volumes)
];
particles2conc[particleProfile:{($MASS$speciesPattern->_)..},model_MASSmodel]:=particles2conc[particleProfile,FilterRules[model["Parameters"],parameter["Volume",_]]];
def:particles2conc[___]:=(Message[Toolbox::badargs,conc2particles,Defer@def];Abort[])
Protect[particles2conc];


Unprotect[symbolize];
symbolize[stuff_,opts___Rule]:=Module[{rules},
rules=#->Unique["var"]&/@Union[Cases[stuff,Join[$MASS$speciesPattern,$MASS$parametersPattern,Alternatives[_v]],\[Infinity],Heads->True]];
{stuff/.rules,Reverse/@rules}
];
def:symbolize[___]:=(Message[Toolbox::badargs,symbolize,Defer@def];Abort[])
Protect[symbolize];


Unprotect[anonymize];
SetAttributes[anonymize,HoldAll];
anonymize[f_[args__]]:=Module[{rosetta,args2},
{args2,rosetta}=symbolize[{args}];
Sow[rosetta];
f[Evaluate[Sequence@@args2]]/.rosetta
];
def:anonymize[___]:=(Message[Toolbox::badargs,anonymize,Defer@def];Abort[])
Protect[anonymize];


Unprotect[annotateCurrencyMetabolites];
annotateCurrencyMetabolites[rxns:{_reaction...},previousAnnotation:{(_String->_List)...}]:=Join[previousAnnotation,annotateCurrencyMetabolites[Select[rxns,!MemberQ[previousAnnotation[[All,1]],getID[#]]&]]]

annotateCurrencyMetabolites[rxns:{_reaction...}]:=Module[{endResult,input,result,cmpds,u},
	endResult={};
	Do[
		cmpds=getCompounds[rxn];
		u={};
		result=
			DialogInput[
				{rxn,
				EventHandler[TogglerBar[Dynamic[u],cmpds],{"KeyDown",ToString[#]}:>(If[MemberQ[u,cmpds[[#]]],u=DeleteCases[u,cmpds[[#]],\[Infinity]],u=Sort@Append[u,cmpds[[#]]]])&/@Range[1,Length[cmpds]]],
				Row[{DefaultButton[DialogReturn[u]],CancelButton[DialogReturn[False]]}]},
				NotebookEventActions->(Join[{"KeyDown",ToString[#]}:>(If[MemberQ[u,cmpds[[#]]],u=DeleteCases[u,cmpds[[#]]],u=Append[Evaluate@u,cmpds[[#]]]])&/@Range[1,Length[cmpds]],{"ReturnKeyDown":>DialogReturn[u],"EscapeKeyDown":>DialogReturn[False]}])
			];
		If[result===False,Break[]];
		AppendTo[endResult,getID[rxn]->result]
	,{rxn,rxns}
	];
	endResult
];
def:annotateCurrencyMetabolites[___]:=(Message[Toolbox::badargs,annotateCurrencyMetabolites,Defer@def];Abort[]);
Protect[annotateCurrencyMetabolites];


Unprotect[pools2poolMatrix];
pools2poolMatrix[model_MASSmodel,pools:{Rule[_,Join[_Plus|_Times,$MASS$speciesPattern]]..}]:=Module[{cmpds2indices,tmp},
	cmpds2indices=Thread[Rule[#,Range[1,Length[#]]]]&@model["Species"];
	Rationalize@Normal@SparseArray[
		Flatten[
			Table[
				tmp=If[Head[#]===Plus,List@@#,{#}]&[Expand[1.*pools[[i,2]]]];
				{i,Cases[#,$MASS$speciesPattern][[1]]}->Cases[#,_?NumberQ][[1]]&/@tmp
				,{i,1,Length[pools]}
			]
		]/.Dispatch[cmpds2indices],{Length[pools],Length@model}
	]
];
def:pools2poolMatrix[___]:=(Message[Toolbox::badargs,pools2poolMatrix,Defer@def];Abort[])
Protect[pools2poolMatrix];


metaboliteFromString::usage="metaboliteFromString[\"id_compartment\"] will return metabolite[\"id\", \"compartment\"].";


Unprotect[metaboliteFromString];
metaboliteFromString[met_String/;StringMatchQ[met,RegularExpression["^\\S+\\[\\S+\\]$"]]]:=StringCases[met,RegularExpression["^(.+)\\[(.+)\\]"]:>metabolite["$1","$2"]][[1]]
metaboliteFromString[met_String/;StringMatchQ[met,RegularExpression["\\S+(_[\\S]+)?"]]]:=If[Length[#]==1,metabolite[#[[1]],None],metabolite[StringJoin[Sequence@@Riffle[#[[1;;-2]],"_"]],#[[-1]]]]&@StringSplit[StringReplace[met,RegularExpression["^M_"]->""],"_"];
(*metaboliteFromString[met_String/;StringMatchQ[met,RegularExpression]]:=metabolite[,_]*)
def:metaboliteFromString[___]:=(Message[Toolbox::badargs,metaboliteFromString,Defer@def];Abort[])
Protect[metaboliteFromString];


Unprotect[speciesFromString];
speciesFromString[enz_String/;StringMatchQ[enz,RegularExpression["^E_.*"]]]:=Module[{tmp,enzID,allostericInhibitors,allostericActivators,catalyticBound,enzComp},
tmp=StringReplace[enz,RegularExpression["^E_"]->""];
{enzID,enzComp}=List@@speciesFromString[StringSplit[tmp,"&"|"@"|"#"][[1]]];
catalyticBound=speciesFromString/@StringCases[tmp,RegularExpression["&([^&@#]+)?"]:>"$1"];
catalyticBound=If[getCompartment[#]===None,setCompartment[#,enzComp],#]&/@catalyticBound;
allostericInhibitors=speciesFromString/@StringCases[tmp,RegularExpression["#([^&@#]+)?"]:>"$1"];
allostericInhibitors=If[getCompartment[#]===None,setCompartment[#,enzComp],#]&/@allostericInhibitors;
allostericActivators=speciesFromString/@StringCases[tmp,RegularExpression["@([^&@#]+)?"]:>"$1"];
allostericActivators=If[getCompartment[#]===None,setCompartment[#,enzComp],#]&/@allostericActivators;
enzyme["ID"->enzID,"Compartment"->enzComp,"BoundCatalytic"->catalyticBound,"BoundInhibitors"->allostericInhibitors,"BoundActivators"->allostericActivators]
]
speciesFromString[met_String/;StringMatchQ[met,RegularExpression["^\\S+\\[\\S+\\]$"]]]:=StringCases[met,RegularExpression["^(.+)\\[(.+)\\]"]:>metabolite["$1","$2"]][[1]]
speciesFromString[met_String/;StringMatchQ[met,RegularExpression["\\S+(_[\\S]+)?"]]]:=If[Length[#]==1,metabolite[#[[1]],None],metabolite[StringJoin[Sequence@@Riffle[#[[1;;-2]],"_"]],#[[-1]]]]&@StringSplit[StringReplace[met,RegularExpression["^M_"]->""],"_"];
(*metaboliteFromString[met_String/;StringMatchQ[met,RegularExpression]]:=metabolite[,_]*)
def:speciesFromString[___]:=(Message[Toolbox::badargs,speciesFromString,Defer@def];Abort[])
Protect[speciesFromString];


Unprotect[str2mass];
str2mass::wrngStrRepresentation="`1` cannot be parsed!";
(*Options[str2mass]={"ReversibleDelimiter"->"<=>","IrreversibleDelimeter"->"-->"};*)
Options[str2mass]={"ReversibleDelimiter"->RegularExpression["<[=-]*>"],"IrreversibleDelimeter"->RegularExpression["[=-]*>"]};
str2mass[s_String,opts:OptionsPattern[]]:=Module[{},
Switch[s,
elem_String/;StringMatchQ[elem,RegularExpression["k_.+"]],rateconst[StringJoin[Sequence@@Riffle[#[[2;;-2]],"_"]],Switch[#[[-1]],"fwd",True,"rev",False,_,Message[str2mass::wrngStrRepresentation,s];Abort[];]]&@StringSplit[s,"_"],
elem_String/;StringMatchQ[elem,RegularExpression["Keq_.+"]],Keq[StringJoin[Sequence@@Riffle[StringSplit[s,"_"][[2;;]],"_"]]],
elem_String/;StringMatchQ[elem,RegularExpression["^\\S+\\[\\S+\\]$"]|RegularExpression["\\S+(_[\\S]+)?"]],speciesFromString[s],
elem_String/;StringMatchQ[elem,RegularExpression[".+: .+"]],reactionFromString[s,OptionValue["ReversibleDelimiter"],OptionValue["IrreversibleDelimeter"]],
_,Message[str2mass::wrngStrRepresentation,s];s
]
];
def:str2mass[___]:=(Message[Toolbox::badargs,str2mass,Defer@def];Abort[])
Protect[str2mass];


Unprotect[stringShortener];
stringShortener[str_String,maxChar_:15]:=If[StringLength[str]>maxChar,StringTake[str,maxChar]<>ToString[StringSkeleton[StringLength[str]-maxChar]],str]
stringShortener[flux_v,maxChar_:15]:=stringShortener[getID[flux],maxChar]
def:stringShortener[___]:=(Message[Toolbox::badargs,stringShortener,Defer@def];Abort[])
Protect[stringShortener];


Unprotect[edit];
edit[dat:{_Rule..},title_:"Default title"]:=Module[{vars,varsStr,ret},
vars=Table[Unique[],{Length[dat]}];
varsStr=ToString/@vars;
Do[Evaluate[vars[[v]]]=dat[[v,2]],{v,1,Length[vars]}];
DialogInput[{TextCell[title],
Pane[Grid[Flatten/@Partition[Thread[List[dat[[All,1]],ToExpression[StringJoin["{",Sequence@@Riffle[("InputField[Dynamic["<>#<>"]]"&/@varsStr),","],"}"]]]],2],Alignment->{Right,Top}],ImageSizeAction->"Scrollable",Scrollbars->Automatic,ImageSize->{Automatic,600}],Row[{
DefaultButton[DialogReturn[ret=(Symbol/@varsStr)]],CancelButton[DialogReturn[ret=(Symbol/@varsStr)]],DefaultButton["Set all to 0",Clear/@varsStr;Do[Evaluate[Symbol[varsStr[[v]]]]=0,{v,1,Length[varsStr]}]],DefaultButton["Initialize",Clear/@varsStr;Do[Evaluate[Symbol[varsStr[[v]]]]=dat[[v,2]],{v,1,Length[varsStr]}]]}]}];
Clear/@varsStr;
Return[Thread[Rule[dat[[All,1]],ret]]]
];

edit[dat_String,title_:"Default title"]:=Module[{input},
input=dat;
DialogInput[{TextCell[title],InputField[Dynamic[input],String,FieldSize->{50,12}],DefaultButton[DialogReturn[]]},NotebookEventActions->{"ReturnKeyDown":>FrontEndExecute[{NotebookWrite[InputNotebook[],"\n",After]}]}];
Return@ToString@input
];
def:edit[___]:=(Message[Toolbox::badargs,edit,Defer@def];Abort[])
Protect[edit];


Unprotect[editModelInPlace];
SetAttributes[editModelInPlace,HoldFirst];
editModelInPlace[model_Symbol,attribute_String]/;MatchQ[Hold[model]/.OwnValues[model],Hold[_MASSmodel]]:=setModelAttribute[model,attribute,edit[model[attribute]]];
def:editModelInPlace[___]:=(Message[Toolbox::badargs,editModelInPlace,Defer@def];Abort[])
Protect[editModelInPlace];


Unprotect[editModel];
editModel[model_MASSmodel,attribute_String]:=Module[{modelTmp},modelTmp=model;setModelAttribute[modelTmp,attribute,edit[modelTmp[attribute],"Edit "<>attribute]];modelTmp];
def:editModel[___]:=(Message[Toolbox::badargs,editModel,Defer@def];Abort[])
Protect[editModel];


wrapHead::usage="wrapHead[expression] will wrap head around the Head of expression like wrap[Head[expression]][expression]";


unwrapHead::usage="unwrapHead[wrappedExpr] will the reverse the process of wrapHead.";


wrapHead[stuff_]:=wrap[Head[stuff]]@@stuff


unwrapHead[stuff_]:=stuff/.w_wrap:>w[[1]]


(* ::Subsection::Closed:: *)
(*Warnings and protection*)


Protect[t,G,J,\[CapitalGamma],\[Kappa],S,\[Rho]];


(*Warning and Error messages*)
Toolbox::Exists="Entity `1` already exists.";
Toolbox::NotImplemented="Function/Structure `1` has not been implemented yet.";
Toolbox::badargs="There is no definition for '``' applicable to ``.";
Toolbox::deprecated="`1` is deprecated and will be removed in the (very) near future. Please use `2` instead.";


(* ::Subsection:: *)
(*Old routines*)


Unprotect[getGradient];
getGradient[rates_List,mets_List]:=Table[\!\(
\*SubscriptBox[\(\[PartialD]\), \(mets[\([j]\)]\)]\(rates[\([i]\)]\)\),{i,1,Length[rates]},{j,1,Length[mets]}];
def:getGradient[___]:=(Message[Toolbox::badargs,getGradient,Defer@def];Abort[])
Protect[getGradient];


Unprotect[getJacobian];
getJacobian::unknownJacobianType="`1` is not a valid Jacobian type, try \"Concentration\" or \"Flus\" instead.";
Options[getJacobian]={"Type"->"Concentration"(* or flux *)}
getJacobian[stoich_?MatrixQ,rates_List,mets_List,opts:OptionsPattern[]]:=Module[{grad},
	grad=getGradient[rates,mets];
	Switch[OptionValue["Type"],
		"Concentration",stoich.grad,
		"Flux",grad.stoich,
		_,Message[getJacobian::unknownJacobianType,OptionValue["Type"]];Abort[];
	]
];
def:getJacobian[___]:=(Message[Toolbox::badargs,getJacobian,Defer@def];Abort[])
Protect[getJacobian];


Unprotect[modalDecomposition];
modalDecomposition[jac_,norm_:0,cutoff_:Sqrt[2], removepairs_:1, evalCutOff_:1*^-15]:=Module[{val, vec, i , rawts, ts,  rawModes, modes, conjpair,removeset,finalset, tempts, tempmodes, joinMat, temp},
conjpair = {}; 
removeset = {};
{val, vec} = Eigensystem[jac];

(* below starts to get a bit complicated -- initial test if eigenvalue is less than cutoff, it is set to 0, if it is not, then it goes through the series of tests to classify the point *)

Do[
(* eigenvalues that are smaller than cutoff, replace w/ 0 *)
If[Abs[val[[i]]] < evalCutOff, val[[i]] = 0,
If[ (Re[val[[i]]] == 0) &&( Im[val[[i]]] != 0), Print["Pure imaginary eigenvalues at: ", i, " equal to: ", val[[i]]] ];
If[ (Re[val[[i]]] > 0), Print["Positive eigenvalue (unstable) at: ", i," equal to: "val[[i]]] ];
If[Abs[Im[val[[i]]]]/Sqrt[Re[val[[i]]]^2 + Im[val[[i]]]^2] >cutoff,Print["Eigenvalue with imaginary component greater than cutoff at: ", i, " equal to: ",val[[i]] ] ];
If[ i < Length[val], 
If[ val[[i]] == Conjugate[val[[i+1]]], conjpair = Append[conjpair,{i,i+1}];Print["Complex conjugate pair at: ", i, " equal to: ", val[[i]]," and ", val[[i+1]] ];]];
];
, {i, 1, Length[val]}];

rawts = Table[Which[ val[[i]] == 0, Infinity, val[[i]] != 0, -1/val[[i]] ], {i,1,Length[val]}];
rawModes = Inverse[Transpose[vec]];

If[ norm != 0,temp = rawModes; rawModes = Table[temp[[i]]/Norm[temp[[i]], norm], {i,1,Length[rawModes]}]; ];

If[ (removepairs == 1) && (Length[conjpair] != 0), 
joinMat = DiagonalMatrix[Table[1,{Length[val]}]];
Do[
joinMat[[conjpair[[i,1]],conjpair[[i,2]]]] = 1;
joinMat[[conjpair[[i,2]],conjpair[[i,1]]]] = 1;
removeset = Append[removeset,conjpair[[i,2]]];
, {i,1,Length[conjpair]}];

tempts = rawts.joinMat;
tempmodes = rawModes.joinMat;

finalset = Complement[Table[i,{i,1Length[val]}], Flatten[removeset]];
Print["finalset: ", finalset];
ts = Table[ tempts[[ finalset[[i]] ]], {i,1,Length[finalset]}];
modes = Table[ tempmodes[[ finalset[[i]] ]], {i,1,Length[finalset]}], 
ts = rawts; modes = rawModes; ];

Return[{ts, modes}];
];
def:modalDecomposition[___]:=(Message[Toolbox::badargs,modalDecomposition,Defer@def];Abort[])
Protect[modalDecomposition];


(* ::Subsection:: *)
(*Notation style*)


simplyBlack[str_String]:=StyleBox[str,RGBColor[0,0,0],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
geneStyle[stuff_]:=StyleBox[stuff,Background->RGBColor[0,1,1],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
proteinStyle[stuff_]:=StyleBox[stuff,Background->RGBColor[1,0.5`,0],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
activatorStyle[stuff_]:=StyleBox[stuff,Background->RGBColor[0,2/3,0],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]
inhibitorStyle[stuff_]:=StyleBox[stuff,Background->RGBColor[2/3,0,0],StripOnInput->False,ShowSyntaxStyles->False,AutoSpacing->False,ZeroWidthTimes->True]


(* ::Subsection:: *)
(*Fluxes*)


Unprotect[v];
v/:MakeBoxes[v[id_String],_]:=InterpretationBox[SubscriptBox[#1,#2],v[id],Selectable->False,Editable->False]&[simplyBlack["v"],Evaluate@simplyBlack[id]]
v/:ToString[flux_v]:=StringJoin["v_"<>getID[flux]]
v/:getID[flux_v]:=flux[[1]]
Protect[v];


(* ::Subsection:: *)
(*Compounds*)


Unprotect[chemicalElements];
chemicalElements={"H","He","Li","Be","B","C","N","O","F","Ne","Na","Mg","Al","Si","P","S","Cl","Ar","K","Ca","Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Zn","Ga","Ge","As","Se","Br","Kr","Rb","Sr","Y","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd","In","Sn","Sb","Te","I","Xe","Cs","Ba","La","Ce","Pr","Nd","Pm","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","W","Re","Os","Ir","Pt","Au","Hg","Tl","Pb","Bi","Po","At","Rn","Fr","Ra","Ac","Th","Pa","U","Np","Pu","Am","Cm","Bk","Cf","Es","Fm","Md","No","Lr","Rf","Db","Sg","Bh","Hs","Mt","Ds","Rg","Cn","Uut","Uuq","Uup","Uuh","Uus","Uuo"};
Protect[chemicalElements];


Unprotect[smiles2elementalComposition];
smiles2elementalComposition[smiles_String]:=Module[{},
inchi2elementalComposition[Import["!source ~/.bashrc ; echo '"<>smiles<>"' | obabel -i smi -o inchi","Text"]]
];
smiles2elementalComposition[smiles_SMILES]:=smiles2elementalComposition[smiles[[1]]]
def:smiles2elementalComposition[___]:=(Message[Toolbox::badargs,smiles2elementalComposition,Defer@def];Abort[])
Protect[smiles2elementalComposition];


Unprotect[inchi2elementalComposition];
inchi2elementalComposition[inchi_String]:=formula2elementalComposition[StringSplit[inchi,"/"][[2]]]
inchi2elementalComposition[inchi_InChI]:=inchi2elementalComposition[inchi[[1]]]
def:inchi2elementalComposition[___]:=(Message[Toolbox::badargs,inchi2elementalComposition,Defer@def];Abort[])
Protect[inchi2elementalComposition];


Unprotect[inchi2elementalComposition];
inchi2simpleInchi[inchi_String]:=StringJoin[Sequence@@Riffle[If[Length[#]>3,#[[1;;4]],#]&@StringSplit[inchi,"/"],"/"]]
inchi2simpleInchi[inchi_InChI]:=InChI[inchi2simpleInchi[inchi[[1]]]]
def:inchi2simpleInchi[___]:=(Message[Toolbox::badargs,inchi2simpleInchi,Defer@def];Abort[])
Protect[inchi2elementalComposition];


Unprotect[elementalComposition2formula];
Options[elementalComposition2formula]={"PseudoElements"->True,"EscapingCharacter"->"&"};
elementalComposition2formula[composition:{(_String->_Integer)..},opts:OptionsPattern[]]:=Block[{elems=chemicalElements,tmp},
tmp=StringJoin[Sequence@@(ToString/@Flatten[DeleteCases[Thread[List[elems,elems/.(composition/. 1->"")]],{a_,a_},1]])];
If[OptionValue["PseudoElements"],tmp=tmp<>StringJoin[Sequence@@(OptionValue["EscapingCharacter"]<>#[[1]]<>OptionValue["EscapingCharacter"]<>ToString[#[[2]]]&/@FilterRules[composition,Except[elems]])]];
tmp
];
elementalComposition2formula[composition:_Plus,opts:OptionsPattern[]]:=Block[{},
elementalComposition2formula[Switch[#,_String,#->1,_Times,Cases[#,_String][[1]]->Cases[#,_?NumberQ][[1]]]&/@List@@composition,opts]
];
elementalComposition2formula[composition:_String,opts:OptionsPattern[]]:=Block[{},
elementalComposition2formula[{composition->1},opts]
];
elementalComposition2formula[composition:_Times,opts:OptionsPattern[]]:=Block[{},
elementalComposition2formula[{Cases[#,_String][[1]]->Cases[#,_?NumberQ][[1]]},opts]&[composition]
];
def:elementalComposition2formula[___]:=(Message[Toolbox::badargs,elementalComposition2formula,Defer@def];Abort[])
Protect[elementalComposition2formula];


Unprotect[formula2elementalComposition];
Options[formula2elementalComposition]=Options[elementalComposition2formula];
formula2elementalComposition[formula_String,opts:OptionsPattern[]]:=Module[{tmp},
tmp=Sort[StringCases[StringReplace[formula,RegularExpression[OptionValue["EscapingCharacter"]<>".*?"<>OptionValue["EscapingCharacter"]<>"\\d*"]->""],RegularExpression["([\\D^"<>OptionValue["EscapingCharacter"]<>"]{1})(\\d*)"]:>Rule["$1",ToExpression["$2"/.""->"1"]]]];
If[OptionValue["PseudoElements"],tmp=Join[tmp,StringCases[formula,RegularExpression["("<>OptionValue["EscapingCharacter"]<>".+?"<>OptionValue["EscapingCharacter"]<>")"<>"(\\d*)"]:>Rule["$1",ToExpression["$2"/.""->"1"]]]]];
Plus@@Times@@@tmp
];
def:formula2elementalComposition[___]:=(Message[Toolbox::badargs,formula2elementalComposition,Defer@def];Abort[])
Protect[formula2elementalComposition];


Unprotect[metabolite];
metabolite[id_String]:=metabolite[id,None];
metabolite/:MakeBoxes[metabolite[id_String],_]:=InterpretationBox[#,metabolite[id,Blank[]],Editable->False,Selectable->False]&[simplyBlack[id]];
metabolite/:MakeBoxes[metabolite[id_String,None],_]:=InterpretationBox[#,metabolite[id,None],Editable->False,Selectable->False]&[simplyBlack[id]];
metabolite/:MakeBoxes[metabolite[id_String,compartment_Blank],_]:=InterpretationBox[SuperscriptBox[#1,#2],metabolite[id,compartment],Editable->False,Selectable->False]&[simplyBlack[id],simplyBlack["_"]];
metabolite/:MakeBoxes[metabolite[id_String,compartment_String],_]:=InterpretationBox[SuperscriptBox[#1,#2],metabolite[id,compartment],Editable->False,Selectable->False]&[simplyBlack[id],simplyBlack[compartment]];
metabolite/:ToString[m_metabolite/;getCompartment[m]===None]:=StringReplace[getID@m,{"M\[UnderBracket]"->"",RegularExpression["\[UnderBracket].*?$"]->"","\[UnderBracket]"->"_"}]
metabolite/:ToString[m_metabolite]:=StringJoin[StringReplace[getID@m,{"M\[UnderBracket]"->"",RegularExpression["\[UnderBracket].*?$"]->"","\[UnderBracket]"->"_"}],"[",StringReplace[getCompartment[m]/._Blank->"any","\[UnderBracket]"->"_"],"]"]
metabolite/:ToString[m_metabolite,"SBML"]:=StringJoin["M_",getID@m,"_",getCompartment[m]/._Blank->"any"]
metabolite/:getID[m_metabolite]:=m[[1]]
metabolite/:getCompartment[m_metabolite]:=m[[2]]
metabolite/:setCompartment[m_metabolite,compartment:(_String|None)]:=metabolite[getID[m],compartment]
Protect[metabolite];


Unprotect[species];
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
Protect[species];


Unprotect[m];
m[a___]:=Evaluate@metabolite[a]
Protect[m];


Unprotect[InChI];
InChI/:getID[cmpd_InChI]:=cmpd[[1]];
Protect[InChI];
Unprotect[SMILES];
SMILES/:getID[cmpd_SMILES]:=cmpd[[1]];
Protect[SMILES];


(* ::Subsection:: *)
(*Reactions*)


(*Unprotect[Intersection,Union,Complement];
Union[args:PatternSequence[{_reaction..},{_reaction..}]..]:=Union[args,SameTest->SameQ]
Intersection[args:PatternSequence[{_reaction..},{_reaction..}]..]:=Intersection[args,SameTest->SameQ]
Complement[args:PatternSequence[{_reaction..},{_reaction..}]..]:=Complement[args,SameTest->SameQ]
Protect[Intersection,Union,Complement];*)

Unprotect[reaction];
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
	reaction[id,substrates,products,stoichiometry/. 1.->1,revQ]
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

Unprotect[getID,getCompounds,getSpecies,getSubstrates,getProducts,getStoichiometry,getSubstrStoich,getProdStoich,reversibleQ,reactionQ,makeReversible,makeIrreversible];
reaction/:getID[rxn_reaction]:=rxn[[1]];
def:getID[___]:=(Message[Toolbox::badargs,getID,Defer@def];Abort[])

reaction/:getCompounds[rxn_reaction]:=Join[rxn[[2]],rxn[[3]]];
def:getCompounds[___]:=(Message[Toolbox::badargs,getCompounds,Defer@def];Abort[])

reaction/:getSpecies[rxn_reaction]:=Join[rxn[[2]],rxn[[3]]];
def:getSpecies[___]:=(Message[Toolbox::badargs,getSpecies,Defer@def];Abort[])

reaction/:getSubstrates[rxn_reaction]:=rxn[[2]];
def:getSubstrates[___]:=(Message[Toolbox::badargs,getSubstrates,Defer@def];Abort[])

reaction/:getProducts[rxn_reaction]:=rxn[[3]];
def:getProducts[___]:=(Message[Toolbox::badargs,getProducts,Defer@def];Abort[])

reaction/:getStoichiometry[rxn_reaction]:=rxn[[4]];
reaction/:S[rxn_reaction]:=getStoichiometry[rxn]
def:getStoichiometry[___]:=(Message[Toolbox::badargs,getStoichiometry,Defer@def];Abort[])

reaction/:getSignedStoich[rxn_reaction]:=Join[-getSubstrStoich[rxn],getProdStoich[rxn]];
def:getSignedStoich[___]:=(Message[Toolbox::badargs,getSignedStoich,Defer@def];Abort[])

reaction/:getSubstrStoich[rxn_reaction]:=rxn[[4]][[1;;Length[rxn[[2]]]]];
def:getSubstrStoich[___]:=(Message[Toolbox::badargs,getSubstrStoich,Defer@def];Abort[])

reaction/:getProdStoich[rxn_reaction]:=rxn[[4]][[Length[rxn[[2]]]+1;;]];
def:getProdStoich[___]:=(Message[Toolbox::badargs,getProdStoich,Defer@def];Abort[])

reaction/:getCompartment[rxn_reaction]:=If[Length[#]==1,#[[1]],#]&[Union[getCompartment/@getCompounds[rxn]]];
def:getCompartment[___]:=(Message[Toolbox::badargs,getCompartment,Defer@def];Abort[])

reaction/:reversibleQ[rxn_reaction]:=rxn[[5]];
def:reversibleQ[___]:=(Message[Toolbox::badargs,reversibleQ,Defer@def];Abort[])

reaction/:makeReversible[rxn_reaction]:=ReplacePart[rxn,-1->True];
def:makeReversible[___]:=(Message[Toolbox::badargs,makeReversible,Defer@def];Abort[])

reaction/:makeIrreversible[rxn_reaction]:=ReplacePart[rxn,-1->False];
def:makeIrreversible[___]:=(Message[Toolbox::badargs,makeIrreversible,Defer@def];Abort[])

reactionQ[stuff_]:=MatchQ[stuff,reaction[__]];
Protect[getID,getCompounds,getSpecies,getSubstrates,getProducts,getStoichiometry,getSubstrStoich,getProdStoich,reversibleQ,reactionQ,makeReversible,makeIrreversible];

Protect[reaction];


Unprotect[r];
r[a___]:=reaction[a]
Protect[r];


Unprotect[reactionFromString];
reactionFromString[rxn_String,rev_:"<=>",irev_:"-->"]:=Module[{id,rest,revQ,lhs,rhs,substrStoich,substr,prodStoich,prod,metsAndStoich,cleanUpRedundant},
	metsAndStoich=If[#=={"0"},{{},{}},If[Length[#]==1,{1.,speciesFromString@#[[1]]},{ToExpression[#[[1]]],speciesFromString@#[[2]]}]]&/@(StringSplit[#,RegularExpression["\\s+"]]&/@StringSplit[#,RegularExpression["(?m)\\s*\\+\\s*"]])&;
	cleanUpRedundant=Transpose[List@@@(List@@(#1.#2))]&;
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
def:reactionFromString[___]:=(Message[Toolbox::badargs,reactionFromString,Defer@def];Abort[])
Protect[reactionFromString];


(* ::Subsection:: *)
(*GPRs*)


Unprotect[gene];
gene[id_String,opts:OptionsPattern[]]:=gene[id,None,opts]
gene/:getID[g_gene]:=g[[1]]
gene/:getCompartment[g_gene]:=g[[2]]
gene/:setCompartment[g_gene,compartment:(_String|None)]:=gene[getID[g],compartment]
gene/:ToString[g_gene]:="gene_"<>ToString[getID@g]
gene/:getMetaData[g_gene]:=List@@g[[3;;]]
gene/:MakeBoxes[gene[id_String,None,opts:OptionsPattern[]],_]:=InterpretationBox[#,gene[id,None,opts],Selectable->False,Editable->False]&[geneStyle[FrameBox[id]]];
gene/:MakeBoxes[gene[id_String,blank_Blank,opts:OptionsPattern[]],_]:=InterpretationBox[#,gene[id,blank,opts],Selectable->False,Editable->False]&[geneStyle[FrameBox[SuperscriptBox[id,"_"]]]];
gene/:MakeBoxes[gene[id_String,comp_String,opts:OptionsPattern[]],_]:=InterpretationBox[#,gene[id,comp,opts],Selectable->False,Editable->False]&[geneStyle[FrameBox[SuperscriptBox[id,comp]]]];
Protect[gene];


Unprotect[protein];
protein[id_String,opts:OptionsPattern[]]:=protein[id,None,opts]
protein/:getID[p_protein]:=p[[1]]
protein/:getCompartment[p_protein]:=p[[2]]
protein/:setCompartment[p_protein,compartment:(_String|None)]:=protein[getID[p],compartment]
protein/:ToString[p_protein]:="protein_"<>ToString[getID@p]
protein/:getMetaData[p_protein]:=List@@p[[3;;]]
protein/:MakeBoxes[protein[id_String,None,opts:OptionsPattern[]],_]:=InterpretationBox[#,protein[id,None,opts],Selectable->False,Editable->False]&[proteinStyle[FrameBox[id]]];
protein/:MakeBoxes[protein[id_String,blank_Blank,opts:OptionsPattern[]],_]:=InterpretationBox[#,protein[id,blank,opts],Selectable->False,Editable->False]&[proteinStyle[FrameBox[SuperscriptBox[id,"_"]]]];
protein/:MakeBoxes[protein[id_String,comp_String,opts:OptionsPattern[]],_]:=InterpretationBox[#,protein[id,comp,opts],Selectable->False,Editable->False]&[proteinStyle[FrameBox[SuperscriptBox[id,comp]]]];
Protect[protein];


Unprotect[geneComplex];
geneComplex/:MakeBoxes[geneComplex[genes__/;MatchQ[List[genes],{(True|_gene)..}]],_]:=StyleBox[InterpretationBox[FrameBox[GridBox[#]],geneComplex[genes],Selectable->False,Editable->False],Background->LightGray]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@List[genes]]];
geneComplex[genes__/;MemberQ[List[genes],False]]:=False
Protect[geneComplex];


Unprotect[proteinComplex];
proteinComplex[proteins__/;MemberQ[List[proteins],False]]:=False
proteinComplex/:MakeBoxes[proteinComplex[proteins__/;MatchQ[List[proteins],{(True|_protein)..}]],_]:=StyleBox[InterpretationBox[FrameBox[GridBox[#]],proteinComplex[proteins],Selectable->False,Editable->False],Background->LightGray]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@List[proteins]]];
Protect[proteinComplex];


(* ::Subsection:: *)
(*Enzymes*)


Unprotect[enzyme];
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
StringJoin[Sequence@@("@"<>#&/activators)]<>StringJoin[Sequence@@("#"<>#&/@inhibitors)]
]

(*def:enzyme[___]:=(Message[Toolbox::badargs,enzyme,Defer@def];Abort[])*)

Protect[enzyme];


Unprotect[e];
e[a___]:=enzyme[a]
Protect[e];


(* ::Subsection:: *)
(*Complexes*)


Unprotect[complex];
complex::multiCompartments="Multiple compartments encountered in complex `1`;";
complex[elements__]:=Block[{$preventRecursion=True,comp},
	comp=Union[Flatten[If[MatchQ[#,$MASS$speciesPattern],getCompartment[#],Unevaluated[Sequence[]]]&/@{elements}]];
	If[Length[comp]>1,Message[complex::multiCompartments,complex[elements]]];
	complex[elements]
]/;!TrueQ[$preventRecursion]
complex/:MakeBoxes[complex[elements__],_]:=StyleBox[InterpretationBox[FrameBox[GridBox[#]],complex[elements],Selectable->False,Editable->False],Background->LightGray]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@List[elements]]];
Protect[complex];


Unprotect[complex];
complex/:MakeBoxes[complex[elem__],_]:=InterpretationBox[GridBox[#,GridBoxDividers->{"Rows"->{{True}},"Columns"->{{True}}}],complex[elem],Selectable->False,Editable->False]&[If[Length[#]<=4,Partition[#,2,2,1,""],Partition[#,3,3,1,""]]&[MakeBoxes[#,StandardForm]&/@(Times@@@Tally[List[elem]])]]
bind[elem_,elems__]:=complex[elem,elems]
complex/:bind[c_complex,species__]:=complex[Sequence@@c,species]
complex/:getCompartment[complex[elem__]]:=If[MatchQ[#,{_}],#[[1]],#]&[Union[getCompartment/@List[elem]]]
complex/:getID[complex[elem__]]:=ToString[complex[elem]]
complex/:ToString[complex[elem__]]:=StringJoin[Sequence@@Riffle[ToString/@(Times@@@Tally[ToString/@List[elem]])," & "]]


(* ::Subsection:: *)
(*Parameters*)


Unprotect[rateconst];
rateconst[fluxID_String]:=rateconst[fluxID,True]
rateconst/:MakeBoxes[rateconst[fluxID_String],_]:=InterpretationBox[SubsuperscriptBox["k",#,"\[LongRightArrow]"],rateconst[fluxID,True],Selectable->False,Editable->False]&[simplyBlack[fluxID]];
rateconst/:MakeBoxes[rateconst[fluxID_String,True],_]:=InterpretationBox[SubsuperscriptBox["k",#,"\[LongRightArrow]"],rateconst[fluxID,True],Selectable->False,Editable->False]&[simplyBlack[fluxID]];
rateconst/:MakeBoxes[rateconst[fluxID_String,False],_]:=InterpretationBox[SubsuperscriptBox["k",#,"\[LongLeftArrow]"],rateconst[fluxID,False],Selectable->False,Editable->False]&[simplyBlack[fluxID]];
rateconst/:getID[r_rateconst]:=r[[1]]
rateconst/:ToString[k_rateconst,___]:="k_"<>getID[k]<>If[k[[2]]===True,"_fwd","_rev"];
Protect[rateconst];

(*Shorthand for rateconst*)
Unprotect[k];
k[a___]:=Evaluate@rateconst[a]
Protect[k];


Unprotect[Keq];
Keq/:MakeBoxes[Keq[fluxID_String],_]:=InterpretationBox[UnderscriptBox["K",#],Keq[fluxID],Selectable->False,Editable->False]&[simplyBlack[fluxID]]
Keq/:getID[k_Keq]:=k[[1]]
Keq/:ToString[K_Keq,___]:="Keq_"<>getID[K];
Protect[Keq];


Unprotect[vmax];
vmax/:MakeBoxes[vmax[rxnID_String],_]:=InterpretationBox[UnderscriptBox[SubscriptBox["v",#2],#],vmax[rxnID],Selectable->False,Editable->False]&[simplyBlack[rxnID],simplyBlack["max"]]
vmax/:MakeBoxes[vmax[rxnID_String,index_Integer],_]:=InterpretationBox[UnderscriptBox[SubscriptBox["v",#2],#],vmax[rxnID,index],Selectable->False,Editable->False]&[simplyBlack[rxnID<>","<>ToString[index]],simplyBlack["max"]]
vmax/:getID[param_vmax]:=param[[1]]
vmax/:ToString[param_vmax,___]:="vmax_"<>getID[param];
Protect[vmax];


Unprotect[Km];
Km[m:$MASS$speciesPattern,rxnID_String]:=Block[{$preventRecursion=True},Km[wrapHead[m],rxnID]]/;!TrueQ[$preventRecursion];
Km/:MakeBoxes[Km[met_,rxnID_String],_]:=With[{m=ToBoxes@unwrapHead[met],r=simplyBlack[rxnID]},InterpretationBox[SubsuperscriptBox[SubscriptBox["K","m"],r,m],Km[met,rxnID],Selectable->False,Editable->False]]
Km/:getID[param_Km]:={unwrapHead[param[[1]]],param[[2]]}
Km/:ToString[param_Km,___]:="Km_"<>StringJoin[Sequence@@Riffle[ToString/@getID[param],"_"]];
Protect[Km];


Unprotect[Ki];
Ki[m:$MASS$speciesPattern,rxnID_String]:=Block[{$preventRecursion=True},Ki[wrapHead[m],rxnID]]/;!TrueQ[$preventRecursion];
Ki/:MakeBoxes[Ki[met_,rxnID_String],_]:=With[{m=ToBoxes@unwrapHead[met],r=simplyBlack[rxnID]},InterpretationBox[SubsuperscriptBox[SubscriptBox["K","i"],r,m],Ki[met,rxnID],Selectable->False,Editable->False]]
Ki/:getID[param_Ki]:={unwrapHead[param[[1]]],param[[2]]}
Ki/:ToString[param_Ki,___]:="Ki_"<>StringJoin[Sequence@@Riffle[ToString/@getID[param],"_"]];
Protect[Ki];


Unprotect[Kd];
Kd[m:$MASS$speciesPattern,rxnID_String]:=Block[{$preventRecursion=True},Kd[wrapHead[m],rxnID]]/;!TrueQ[$preventRecursion];
Kd/:MakeBoxes[Kd[met_,rxnID_String],_]:=With[{m=ToBoxes@unwrapHead[met],r=simplyBlack[rxnID]},InterpretationBox[SubsuperscriptBox[SubscriptBox["K","d"],r,m],Kd[met,rxnID],Selectable->False,Editable->False]]
Kd/:getID[param_Kd]:={unwrapHead[param[[1]]],param[[2]]}
Kd/:ToString[param_Kd,___]:="Kd_"<>StringJoin[Sequence@@Riffle[ToString/@getID[param],"_"]];
Protect[Kd];


Unprotect[parameter];
parameter/:MakeBoxes[parameter[paramID_String,rxnID_String],_]:=InterpretationBox[UnderscriptBox[#,#2],parameter[paramID,rxnID],Selectable->False,Editable->False]&[simplyBlack[paramID],simplyBlack[rxnID]]
parameter/:MakeBoxes[parameter[paramID_String],_]:=InterpretationBox[UnderscriptBox[#,#2],parameter[paramID],Selectable->False,Editable->False]&[simplyBlack[paramID],simplyBlack["Global"]]
parameter/:getID[param_parameter]:=If[Length[param]==1,param[[1]],{param[[1]],param[[2]]}]
parameter/:ToString[k_parameter,___]:="param_"<>StringJoin[Sequence@@Riffle[ToString/@Flatten[{getID[k]}],"_"]];
parameter["Volume",None]:=1;
Protect[parameter];


Unprotect[p];
p[a___]:=Evaluate@parameter[a]
Protect[p];


Unprotect[complementParameters];
complementParameters[param:{Rule[(_rateconst|_Keq|metabolite[_,"Xt"]|_parameter),_]..}]:=Module[{ids,completeSet},
ids=Union[getID/@DeleteCases[param[[All,1]],Append[$MASS$speciesPattern,_parameter]]];
completeSet=Thread[Rule[#,#]]&@Flatten[Transpose[Table[{rateconst[i,True],rateconst[i,False],Keq[i]},{i,ids}]]];
Join[
FixedPoint[#/.{Rule[a_Keq,b_]:>(a->keq2k[b/.param]),Rule[a:rateconst[_,True],b_]:>(a->kFwd2keq[b/.param]),Rule[a:rateconst[_,False],b_]:>(a->k2keq[b/.param])}&,completeSet],
FilterRules[param,Append[$MASS$speciesPattern,_parameter]]
]
];
complementParameters[{}]:={}
def:complementParameters[___]:=(Message[Toolbox::badargs,complementParameters,Defer@def];Abort[])
Protect[complementParameters];


(* ::Subsection:: *)
(*Rates*)


Unprotect[addExternalConcentration];
addExternalConcentration=Switch[#,elem_/;MatchQ[elem,_rateconst],#,elem_/;MatchQ[elem,_Plus],Simplify@Replace[Expand[keq2k@#],pat:(-1_rateconst|_rateconst):>pat*Times@@Cases[#,m:$MASS$speciesPattern:>Head[m][getID[m],"Xt"],\[Infinity]],1],_,#]&;
Protect[addExternalConcentration];


reaction2rate[rxns:{_reaction..},ignore:{$MASS$speciesPattern...}:{}]:=reaction2rate[#,ignore]&/@rxns
reaction2rate[r_reaction,ignore:{$MASS$speciesPattern...}:{}]:=Module[{rate},
	rate=If[AtomQ[getCompartment[r]],parameter["Volume",getCompartment[r]],1]*k2keq[
		rateconst[getID[r],True]*Replace[Times@@((#[t]&/@getSubstrates[r])^integerChop[getSubstrStoich[r]]), 1->Times@@(m[getID[#],"Xt"]&/@getProducts[r])] -
		If[reversibleQ[r],rateconst[getID[r],False]*Replace[Times@@((#[t]&/@getProducts[r])^integerChop[getProdStoich[r]]), 1->Times@@(m[getID[#],"Xt"]&/@getSubstrates[r])],0]
	];
	(*If[Complement[getSpecies[r],ignore]!={},*)
	If[Select[getSpecies[r],!MatchQ[#,Alternatives@@ignore]&]!={},
		rate/.Dispatch[Thread[(#[t]&/@ignore)->1]],
		rate
	]
	(*If[MemberQ[r,_enzyme]&&MatchQ[getSubstrates[r]],,rate]*)
];


Unprotect[makeRates];
makeRates::usage="makeRates[stoich_?MatrixQ, rowIDs_List, columnIDs_List] constructs rate equations for the forward and reverse directions of the reactions specified by the provided arguments. An overloaded MASSmodel version of this function exists also (makeRates[model_MASSmodel])";
makeRates::wrongEquationType="`1` is not a valid equation type. Try either \"Keq\" for an equilibrium constant or \"k\" for a pure rate constant type equation.";
Options[makeRates]={"EquationType"->"Keq"(*or k*),"Ignore"->{},"Parameters"->{}};

makeRates[r:{_reaction..},opts:OptionsPattern[]]:=Module[{columnIDs,defaultScheme,rules,defaultRates,boolList},
	defaultScheme=Switch[OptionValue["EquationType"],"Keq",k2keq,"k",keq2k,_,Message[makeRates::wrongEquationType,OptionValue["EquationType"]];Abort[];];
	columnIDs=getID/@r;
	rules={
		{1,1,1}->defaultScheme,
		{1,1,0}:>(#&),
		{1,0,1}->k2keq,
		{1,0,0}->If[OptionValue["EquationType"]=="Keq",k2keq,#&],
		{0,1,1}->kFwd2keq,
		{0,1,0}->If[OptionValue["EquationType"]=="Keq",kFwd2keq,#&],
		{0,0,1}->k2keq,
		{0,0,0}->defaultScheme
	};
	defaultRates=keq2k@reaction2rate[r,OptionValue["Ignore"]];
	Table[
		boolList={rateconst[columnIDs[[f]],True],rateconst[columnIDs[[f]],False],Keq[columnIDs[[f]]]}/.elem:(_rateconst|_Keq):>If[MemberQ[OptionValue["Parameters"],elem,\[Infinity]],1,0];
		(boolList/.rules)[defaultRates[[f]]]
		,{f,1,Length[r]}
	]
];

makeRates[{},data:({_Rule..}|{}):{},opts:OptionsPattern[]]:={}

def:makeRates[___]:=(Message[Toolbox::badargs,makeRates,Defer@def];Abort[])
Protect[makeRates];


Unprotect[keq2k,k2keq,kRev2keq,kFwd2keq];
keq2k[expression_]:=Simplify[expression/.keq_Keq:>(rateconst[getID[keq],True]/rateconst[getID[keq],False])]
kRev2keq[expression_]:=Simplify[expression/.r_rateconst/;r[[2]]==False:>rateconst[r[[1]],True]/Keq[r[[1]]],ExcludedForms->(1/_Keq)]
kFwd2keq[expression_]:=Simplify[expression/.r_rateconst/;r[[2]]==True:>rateconst[r[[1]],False]*Keq[r[[1]]]]
k2keq[expression_]:=kRev2keq[expression]
def:keq2k[___]:=(Message[Toolbox::badargs,keq2k,Defer@def];Abort[])
def:kRev2keq[___]:=(Message[Toolbox::badargs,kRev2keq,Defer@def];Abort[])
def:kFwd2keq[___]:=(Message[Toolbox::badargs,kFwd2keq,Defer@def];Abort[])
Protect[keq2k,k2keq,kRev2keq,kFwd2keq];


(*Unprotect[getODE];
Options[getODE]={"Parameters"->{}};
getODE[stoich_?MatrixQ,rowIDs_List,rates_List]:=Block[{cleanRowIDs,rhs,cleanRates},
cleanRowIDs=rowIDs/.e_[t]:>e;
cleanRates=rates/.e_[t]:>e;
rhs=stoich.cleanRates/.Dispatch[Thread[Rule[cleanRowIDs,#[t]&/@cleanRowIDs]]];
Thread[Equal[#'[t]&/@cleanRowIDs,rhs]]
];
def:getODE[___]:=(Message[Toolbox::badargs,getODE,Defer@def];Abort[])
Protect[getODE];*)


(* ::Subsection:: *)
(*PERCs*)


Unprotect[calcPERC];
calcPERC::ZeroKeq="The equilibrium constant `1` of reaction `2` is zero, the PERC of the reverse rate constant `3` will be calculated.";
calcPERC::atequilibrium="Reaction `1` is either at equlibrium or not active. Forward rate constant `2` is set to `3` (this value can be specified using the option \"AtEquilibriumDefault\").";
calcPERC::negativePERC="Negative PERC (`1`) detected for reaction `2`.";
Options[calcPERC]={"SteadyStateConcentrations"->{},"SteadyStateFluxes"->{},"Parameters"->{},"AtEquilibriumDefault"->Undefined};

(*SetAttributes[calcPERC,Listable];*)

calcPERC[rate_,opts:OptionsPattern[]]:=Module[{getFluxID,fluxID,ssFlux,solution,keq,rateClean,finalRate},
	rateClean=rate/.parameter["Volume",_]->1;
	getFluxID=Cases[#,p:(_Keq|_rateconst):>getID[p],\[Infinity]][[1]]&;
	fluxID=Quiet[Check[getFluxID[rateClean],Return[{}],{Part::partw}],{Part::partw}];
	ssFlux=(v[fluxID]/.Dispatch[OptionValue["SteadyStateFluxes"]]);
	keq=Keq[fluxID]/.OptionValue["Parameters"];
	solution=If[
		MatchQ[stripUnits[ssFlux],0|0.],
		Message[calcPERC::atequilibrium,fluxID,rateconst[fluxID,True],OptionValue["AtEquilibriumDefault"]];rateconst[fluxID,True]->OptionValue["AtEquilibriumDefault"],
		If[NumberQ[keq]&&keq==0,
			Message[calcPERC::ZeroKeq,Keq[fluxID],fluxID,rateconst[fluxID,False]];
			finalRate=kFwd2keq[rateClean]/.elem_[t]:>elem/.Dispatch@OptionValue["SteadyStateConcentrations"]/.Dispatch@FilterRules[OptionValue["Parameters"],Except[_rateconst]];
			solution=Solve[ssFlux==finalRate,rateconst[fluxID,False]][[1,1]];
			solution,
			finalRate=k2keq[rateClean]/.elem_[t]:>elem/.Dispatch@OptionValue["SteadyStateConcentrations"]/.Dispatch@FilterRules[OptionValue["Parameters"],Except[_rateconst]];
			solution=Solve[ssFlux==finalRate,rateconst[fluxID,True]][[1,1]];
			solution
		]
	];
	Chop[solution]
];

calcPERC[rates_List,opts:OptionsPattern[]]:=calcPERC[#,opts]&/@rates

calcPERC[model_MASSmodel,opts:OptionsPattern[]]:=
Flatten@calcPERC[k2keq@Select[getRates[model],MemberQ[#,_rateconst,\[Infinity]]&],
"SteadyStateConcentrations"->FilterRules[updateRules[model["InitialConditions"],adjustUnits[OptionValue["SteadyStateConcentrations"],model]],$MASS$speciesPattern],
"SteadyStateFluxes"->FilterRules[updateRules[model["InitialConditions"],adjustUnits[OptionValue["SteadyStateFluxes"],model]],_v],
"Parameters"->updateRules[model["Parameters"],adjustUnits[OptionValue["Parameters"],model]],
Sequence@@FilterRules[List[opts],Except["SteadyStateConcentrations"|"SteadyStateFluxes"|"Parameters"|"ExternalConcentrations"]]
];

(*For backwards compatibility*)
calcPERC[model_MASSmodel,steadystateConc:{Rule[$MASS$speciesPattern,_?NumberQ]..},steadystateFluxes:{Rule[_String,_?NumberQ]..},equilibriumConstants:{Rule[_Keq,(_?NumberQ|\[Infinity])]..}]:=calcPERC[model,"SteadyStateConcentrations"->steadystateConc,"SteadyStateFluxes"->steadystateFluxes,"Parameters"->equilibriumConstants];

calcPERC[model_MASSmodel,steadystateConc:{Rule[$MASS$speciesPattern,_?NumberQ]..},steadystateFluxes:{Rule[_String,_?NumberQ]..},equilibriumConstants:{Rule[_Keq,(_?NumberQ|\[Infinity])]..},externalConcentrations:{Rule[$MASS$speciesPattern,(_?NumberQ|\[Infinity])]..}]:=calcPERC[model,"SteadyStateConcentrations"->steadystateConc,"SteadyStateFluxes"->steadystateFluxes,"Parameters"->Join[equilibriumConstants,externalConcentrations]]

def:calcPERC[___]:=(Message[Toolbox::badargs,calcPERC,Defer@def];Abort[])
Protect[calcPERC];


(* ::Subsection::Closed:: *)
(*Structural stuff*)


Unprotect[getDisequilibriumRatios];
Options[getDisequilibriumRatios]={"Ignore"->{}};
getDisequilibriumRatios[s_?MatrixQ,mets_List,equilibriumConstants_List,opts:OptionsPattern[]]:=(getMassActionRatios[s,mets]/.Thread[OptionValue["Ignore"]->1])/equilibriumConstants
getDisequilibriumRatios[rxn_reaction,opts:OptionsPattern[]]:=(getMassActionRatios[rxn]/.Thread[OptionValue["Ignore"]->1])/Keq[getID[rxn]]
getDisequilibriumRatios[rxns:{_reaction..},opts:OptionsPattern[]]:=getDisequilibriumRatios[#,opts]&/@rxns
def:getDisequilibriumRatios[___]:=(Message[Toolbox::badargs,getMassActionRatios,Defer@def];Abort[])
Protect[getDisequilibriumRatios];
Unprotect[\[Rho]];
\[Rho][stuff__,opts:OptionsPattern[]]:=getDisequilibriumRatios[stuff,opts]
Protect[\[Rho]];


Unprotect[calcKappa];
calcKappa[rateconstants_List]:=DiagonalMatrix[rateconstants]
def:calcKappa[___]:=(Message[Toolbox::badargs,calcKappa,Defer@def];Abort[])
Protect[calcKappa];


Unprotect[getMassActionRatios];
Options[getMassActionRatios]={"Ignore"->{}};
getMassActionRatios[s_?MatrixQ,mets_List,opts:OptionsPattern[]]:=Inner[Power,mets,s,Times]/.Thread[OptionValue["Ignore"]->1];
getMassActionRatios[rxn_reaction,opts:OptionsPattern[]]:=getMassActionRatios[{getSignedStoich[rxn]}\[Transpose],getSpecies[rxn],opts][[1]]
getMassActionRatios[rxns:{_reaction..},opts:OptionsPattern[]]:=getMassActionRatios[#,opts]&/@rxns
def:getMassActionRatios[___]:=(Message[Toolbox::badargs,calcKappa,Defer@def];Abort[])
Protect[getMassActionRatios];

Unprotect[\[CapitalGamma]];
\[CapitalGamma][stuff__,opts:OptionsPattern[]]:=getMassActionRatios[stuff,opts]
Protect[\[CapitalGamma]];


(* ::Subsection:: *)
(*Unit support*)


Unprotect[stripUnits];
stripUnits[expr_]:=Module[{replacementRules=Thread[Rule[Symbol/@Names["Units`*"],1]]},DropUnits[expr/.Dispatch[replacementRules]]]
Protect[stripUnits];


spatialDimension[units_]:=Module[{si},
si={Quiet[Convert[units,"MKS"],{Unit::noavailableunit}]}/.Sign->Sequence;
Which[
MemberQ[si,Power["Meter",_],\[Infinity]],Cases[si,Power["Meter",exp_]:>exp,\[Infinity]][[1]],
MemberQ[si,Unit[_,"Meter"],\[Infinity]],1,
True,0
]
]


Options[spatialUnit]={"DefaultVolumeUnit"->Liter,"DefaultSurfaceUnit"->Meter^2,"DefaultLengthUnit"->Meter};

(*spatialUnit[stuff_,rxnOrder_Integer,opts:OptionsPattern[]]:=Module[{dim,correctedDim},*)
spatialUnit[stuff_,rxnOrder_?NumberQ,opts:OptionsPattern[]]:=Module[{dim,correctedDim},
dim=spatialDimension[stuff];
correctedDim=If[dim==0,1,dim/(rxnOrder-1)];
Which[#==0,1,Abs[#]==1,OptionValue["DefaultLengthUnit"],Abs[#]==2,OptionValue["DefaultSurfaceUnit"],Abs[#]>2,OptionValue["DefaultVolumeUnit"]]&[correctedDim]
];

spatialUnit[stuff_,opts:OptionsPattern[]]:=Module[{dim},
dim=spatialDimension[stuff];
Which[#==0,1,Abs[#]==1,OptionValue["DefaultLengthUnit"],Abs[#]==2,OptionValue["DefaultSurfaceUnit"],Abs[#]>2,OptionValue["DefaultVolumeUnit"]]&[dim]
];


Unprotect[adjustUnits];
(*Options[adjustUnits]={"Ignore"->{},"DefaultAmountUnit"->Milli Mole,"DefaultVolumeUnit"->Liter,"DefaultSurfaceUnit"->Meter^2,"DefaultLengthUnit"->Meter,"DefaultMassUnit"->Gram,"DefaultTimeUnit"->Hour};*)
Options[adjustUnits]={"Ignore"->{},"DefaultAmountUnit"->Millimole,"DefaultVolumeUnit"->Liter,"DefaultSurfaceUnit"->Meter^2,"DefaultLengthUnit"->Meter,"DefaultMassUnit"->Gram,"DefaultTimeUnit"->Hour};
adjustUnits::unknownParmeterOrSpeciesType="No unit adjustment rules available for `1`.";
adjustUnits::noUnitsProvidedCompartment="No units provided for `1`. `2` assumed.";
adjustUnits::noUnitsProvidedSpecies="No units provided for `1`. `2` assumed.";
adjustUnits::noUnitsProvidedFlux="No units provided for `1`. `2` assumed.";
adjustUnits::noUnitsProvidedRateConst="No units provided for `1`. \!\(\*SuperscriptBox[\(`2`\), \(1 - rxnOrder\)]\)\!\(\*SuperscriptBox[\(`3`\), \(rxnOrder - 1\)]\)\!\(\*SuperscriptBox[\(`4`\), \(-1\)]\) assumed.";
adjustUnits::noUnitsProvidedKeq="No units provided for `1`. (`2`\!\(\*SuperscriptBox[\()\), \(fwdOrder - revOrder\)]\) assumed.";
adjustUnits::noUnitsProvidedKm="No units provided for `1`. `2` assumed.";
adjustUnits::noUnitsProvidedVmax="No units provided for `1`. `2` assumed.";
adjustUnits::incomp="Incompatible units encountered for `1`.";
adjustUnits::noRxnInfo="No reaction information available for `1`";
adjustUnits[stuff:{_Rule...},rxns:{_reaction...}:{},opts:OptionsPattern[]]:=Module[{id2rxns,unitLessQ,catchIncomp,volumeHelper,keqExp,speciesHelper,fluxHelper,fwdRateConstHelper,
revRateConstHelper,keqHelper,rxnOrder,defaultAmountUnit,defaultVolumeUnit,defaultLengthUnit,defaultSurfaceUnit,defaultTimeUnit,defaultMassUnit,defaultConcUnit,defaultFluxUnit,rxn,KmHelper,VmaxHelper,getVolumeUnit1,getVolumeUnit2},

defaultAmountUnit=OptionValue["DefaultAmountUnit"];
defaultVolumeUnit=OptionValue["DefaultVolumeUnit"];
defaultSurfaceUnit=OptionValue["DefaultSurfaceUnit"];
defaultLengthUnit=OptionValue["DefaultLengthUnit"];
defaultTimeUnit=OptionValue["DefaultTimeUnit"];
defaultMassUnit=OptionValue["DefaultMassUnit"];
defaultConcUnit=defaultAmountUnit defaultVolumeUnit^-1;
defaultFluxUnit=defaultAmountUnit defaultVolumeUnit^-1 defaultTimeUnit^-1;

catchIncomp=Function[{expr,elem},Check[expr,Message[adjustUnits::incomp,elem];Abort[];,{Convert::incomp,Unit::incomp2}],{HoldFirst}];
(*unitLessQ=((#!=0&&NumberQ[#])||#===\[Infinity])&;*)
unitLessQ=(NumberQ[#]||#===\[Infinity])&;

getVolumeUnit1=spatialUnit[#,Sequence@@FilterRules[updateRules[Options[adjustUnits],List[opts]],Options[spatialUnit]]]&;
getVolumeUnit2=spatialUnit[#1,#2,Sequence@@FilterRules[updateRules[Options[adjustUnits],List[opts]],Options[spatialUnit]]]&;

volumeHelper=If[unitLessQ[#[[2]]],Message[adjustUnits::noUnitsProvidedCompartment,#[[1]],OptionValue["DefaultVolumeUnit"]];#[[2]]OptionValue["DefaultVolumeUnit"],Convert[#[[2]],getVolumeUnit1[#[[2]]]]]&;

speciesHelper=If[unitLessQ[#[[2]]],Message[adjustUnits::noUnitsProvidedSpecies,#[[1]],defaultConcUnit];#[[2]]defaultConcUnit,Convert[#[[2]],defaultAmountUnit/getVolumeUnit1[#[[2]]]]]&;

fluxHelper=If[unitLessQ[#[[2]]],Message[adjustUnits::noUnitsProvidedFlux,#[[1]],defaultFluxUnit];#[[2]]defaultFluxUnit,Convert[#[[2]],defaultAmountUnit getVolumeUnit1[#[[2]]]^-1 defaultTimeUnit^-1]]&;

fwdRateConstHelper=(rxn=getID[#[[1]]]/.id2rxns;If[!MatchQ[rxn,_reaction],Message[adjustUnits::noRxnInfo,#];Abort[];];
    rxnOrder=getReactionOrders[rxn,Ignore->OptionValue["Ignore"]][[1]];
    Switch[#[[2]],
        _?unitLessQ,Message[adjustUnits::noUnitsProvidedRateConst,#[[1]],defaultAmountUnit,defaultVolumeUnit,defaultTimeUnit];
            #[[2]]defaultAmountUnit^(1-rxnOrder) defaultVolumeUnit^(rxnOrder-1) defaultTimeUnit^-1,
        _,Convert[#[[2]],defaultAmountUnit^(1-rxnOrder) getVolumeUnit2[#[[2]],rxnOrder]^(rxnOrder-1) defaultTimeUnit^-1]])&;

revRateConstHelper=(rxn=getID[#[[1]]]/.id2rxns;If[!MatchQ[rxn,_reaction],Message[adjustUnits::noRxnInfo,#];Abort[];];
    rxnOrder=getReactionOrders[rxn,Ignore->OptionValue["Ignore"]][[2]];
    Switch[#[[2]],
        _?unitLessQ,Message[adjustUnits::noUnitsProvidedRateConst,#[[1]],defaultAmountUnit,defaultVolumeUnit,defaultTimeUnit];
            #[[2]]defaultAmountUnit^(1-rxnOrder) defaultVolumeUnit^(rxnOrder-1) defaultTimeUnit^-1,
        _,Convert[#[[2]],defaultAmountUnit^(1-rxnOrder) getVolumeUnit2[#[[2]],rxnOrder]^(rxnOrder-1) defaultTimeUnit^-1]])&;

keqHelper=(rxn=getID[#[[1]]]/.id2rxns;If[!MatchQ[rxn,_reaction],Message[adjustUnits::noRxnInfo,#];Abort[];];keqExp=Subtract@@Reverse[getReactionOrders[rxn,Ignore->OptionValue["Ignore"]]];    
    Switch[#[[2]],
        _?unitLessQ,If[keqExp!=0,Message[adjustUnits::noUnitsProvidedKeq,#[[1]],defaultConcUnit]; #[[2]] Convert[(defaultConcUnit)^keqExp,(defaultAmountUnit defaultVolumeUnit^-1)^keqExp],#[[2]]],
        _,Convert[#[[2]],(defaultAmountUnit getVolumeUnit2[#[[2]],Abs[keqExp]+1]^-1)^keqExp]])&;

KmHelper=If[unitLessQ[#[[2]]],Message[adjustUnits::noUnitsProvidedKm,#[[1]],defaultConcUnit];#[[2]]defaultConcUnit,Convert[#[[2]],defaultAmountUnit getVolumeUnit1[#[[2]]]^-1]]&;
VmaxHelper=If[unitLessQ[#[[2]]],Message[adjustUnits::noUnitsProvidedVmax,#[[1]],defaultFluxUnit];#[[2]]defaultFluxUnit,Convert[#[[2]],defaultAmountUnit getVolumeUnit1[#[[2]]]^-1 defaultTimeUnit^-1]]&;

id2rxns=Thread[(getID/@rxns)->rxns];

#[[1]]->Switch[#[[1]],
parameter["Volume",_],catchIncomp[volumeHelper[#],#],
$MASS$speciesPattern,catchIncomp[speciesHelper[#],#],
_v,catchIncomp[fluxHelper[#],#],
rateconst[_,True],catchIncomp[fwdRateConstHelper[#],#],
rateconst[_,False],catchIncomp[revRateConstHelper[#],#],
_Keq,catchIncomp[keqHelper[#],#],
_Km,catchIncomp[KmHelper[#],#],
_vmax,catchIncomp[VmaxHelper[#],#],
_,(*Message[adjustUnits::unknownParmeterOrSpeciesType,#[[1]]];*)#[[2]]]&/@
stuff
];

adjustUnits[stuff:{_Rule...},model_MASSmodel,opts:OptionsPattern[]]:=If[model["UnitChecking"],adjustUnits[stuff,model["Reactions"],"Ignore"->Union[model["Ignore"],OptionValue["Ignore"]],Sequence@@FilterRules[List@opts,Except["Ignore"]]],stuff]

def:adjustUnits[___]:=(Message[Toolbox::badargs,adjustUnits,Defer@def];Abort[])
Protect[adjustUnits];


(* ::Subsection:: *)
(*Model construction and associated definitions*)


Unprotect[calcLinkMatrix];
calcLinkMatrix[s_?MatrixQ]:=Module[{Q,R,independent,tmp,dependent,newOrder,rank},
{Q,R}=QRDecomposition[N@Transpose[s]];
(*Print["After QR"];*)
dependent=Flatten[Position[Chop@Tr[R,List],0]];
independent=Complement[Range[1,Length[s]],dependent];
newOrder=Join[independent,dependent];
(*Print["Before PseudoInv"];*)
s[[newOrder]].PseudoInverse[N@s[[independent]]];
(*Print["After PseudoInv"];*)
{newOrder,s[[newOrder]],s[[independent]],Chop[s[[newOrder]].PseudoInverse[N@s[[independent]]]]}
];
def:calcLinkMatrix[___]:=(Message[Toolbox::badargs,calcLinkMatrix,Defer@def];Abort[])
Protect[calcLinkMatrix];


attributeTestPatterns={
"Stoichiometry"->_?MatrixQ,
"InitialConditions"->{((_String|_v|_species|_metabolite|_enzyme|_parameter|_complex)->(_?NumberQ|\[Infinity]|-\[Infinity]|NaN|Indeterminate|$MASS$unitsPattern|With[{pat=$MASS$unitsPattern},HoldPattern@Times[(pat)..]]))..}|{},
"Constraints"->{((_String|_v|_species|_metabolite|_enzyme)->{(_?NumberQ|-\[Infinity]),(_?NumberQ|\[Infinity])})..}|{},
"Parameters"->{(Join[$MASS$speciesPattern,$MASS$parametersPattern]->(_?NumberQ|Indeterminate|\[Infinity]|-\[Infinity]|NaN|_Unit))..}|{},
"GPR"->{((_String|_protein|_proteinComplex)->(_protein|_proteinComplex|_gene|_geneComplex|_Or))..}|{},
"BoundaryConditions"->{(_species|_metabolite|_enzyme)...},
"Constant"->{(_species|_metabolite|_enzyme)...},
"Name"->_String,
"ElementalComposition"->({((_species|_metabolite|_enzyme)->(Automatic|_Times|_Plus|Except["",_String]|_SMILES|_InChI))..}|{}),
"Notes"->_String,
"Ignore"->{(_species|_metabolite|_enzyme)..}|{},
"UnitChecking"->(True|False),
"Synonyms"->{(Join[$MASS$speciesPattern,$MASS$parametersPattern,_v|_String]->_String)..}|{},
"Events"->{(_String->WhenEvent[_,({_[t]..}->{__})|(_[t]->_)|{(_[t]->_)..},OptionsPattern[]])...},
"Objective"->(Automatic|_v|_Plus),
_->_
};

sortBySpecificity[{}]:={}

moreSpecificQ=Internal`ComparePatterns[#1,#2]/.Dispatch[{"Specific"->True,"Incomparable"->False,"Identical"->False,"Equivalent"->False}]&;
If[$VersionNumber>=6,
	sortBySpecificity[r:{_Rule..}]:=Sort[r,moreSpecificQ[#[[1]],#2[[1]]]&],
	sortBySpecificity[r:{_Rule}]:=r
];


checkConstraints::irrevNegativeLowerBound="Negative lower flux bound encountered for irreversible reaction `1`.";
checkConstraints[model_MASSmodel,constr:({((_String|_v|_species|_metabolite|_enzyme)->{(_?NumberQ|-\[Infinity]),(_?NumberQ|\[Infinity])})..}|{})]:=checkConstraints[model["Reactions"],constr]
checkConstraints[rxns:{_reaction...},constr:({((_String|_v|_species|_metabolite|_enzyme)->{(_?NumberQ|-\[Infinity]),(_?NumberQ|\[Infinity])})..}|{})]:=Module[{irrev},
	irrev=getID/@Select[rxns,!reversibleQ[#]&];
	Scan[If[#[[2,1]]<0,Message[checkConstraints::irrevNegativeLowerBound,#[[1]]];Abort[];]&,FilterRules[constr/.elem_v:>getID[elem],irrev]];
	constr
];

Toolbox::eventsNotSupported="Events are not supported in Mathematica `1`. They will be ignored in any calculations.";
attributeCallBacks={
	"Stoichiometry"->(SparseArray[#1]&),
	"InitialConditions"->(adjustUnits[Replace[#1,(s_String->val_):>v[s]->val,1],#2]&),
	"Fluxes"->(Replace[#, s_String:>v[s],1]&),
	"Constraints"->(checkConstraints[#2,#/.(s_String->val_):>v[s]->val]&),
	"CustomRateLaws"->(Replace[#,(s_String->val_):>v[s]->val,2]&),
	"Parameters"->(sortBySpecificity[adjustUnits[#1,#2]]&),
	"Events"->(If[$VersionNumber<9,Message[Toolbox::eventsNotSupported,$VersionNumber];#,#]&),
	(*"UnitChecking"->(If[#1===True,Print[#2["Species"]];updateInitialConditions[#2,{}];#,#]&),*)
	_->(#&)
};


(*Returns overall reaction orders for forward and reverse directions; should probably stay private*)
Unprotect[getReactionOrders];
Options[getReactionOrders]={"Ignore"->{}};
getReactionOrders[rxn_,opts:OptionsPattern[]]:=Module[{},
{Total[FilterRules[Thread[getSubstrates[rxn]->getSubstrStoich[rxn]],Except[OptionValue["Ignore"]]][[All,2]]]/. 0->1(*For exchange reactions*),
Total[FilterRules[Thread[getProducts[rxn]->getProdStoich[rxn]],Except[OptionValue["Ignore"]]][[All,2]]]/. 0->1(*For exchange reactions*)
}
];
def:getReactionOrders[___]:=(Message[Toolbox::badargs,getReactionOrders,Defer@def];Abort[])
Protect[getReactionOrders];


Unprotect[constructModel];
Options[constructModel]={"InitialConditions"->{},"Constraints"->{},"Parameters"->{},"Irreversible"->{},"GPR"->{},"CustomRateLaws"->{},
"CustomODE"->{}(*FIXME needs arg checking*),"Constant"->{},"BoundaryConditions"->{},"Name"->Automatic,"ID"->Automatic,"ElementalComposition"->{},
"Notes"->"","Ignore"->{},"ReorderStoichiometry"->True,"UnitChecking"->False,"Synonyms"->{},"Events"->{},"Objective"->Automatic};
constructModel::malformedarg="`1` `2` do/does not match the appropriate pattern `3`";
constructModel::nonUniqueRxnIDs="Non-unique flux IDs detected for `1`.";
constructModel::wrongdim="The dimensions of the stoichiometry matrix (`1`) do not match the lengths of the provided compounds (`2`) and flux identifiers (`3`).";
constructModel::wrongmatrixelements="Non Integer, Real, or Rational elements encountered at positions `1`.";
constructModel[modelID_String:"",S:(_?MatrixQ|{{}}),compounds:{$MASS$speciesPattern...},fluxes:({(_String|_v)..}|{}),opts:OptionsPattern[]]:=Module[{objective,events,fluxesFinal,variableComp,units,tmpRxns,modelIDtmp,model,contxtStr,constraints,initialConditions,parameters,boundaryConditions,constant,revColInd,irrevConstr,name,notes,exchLeftNull,exchRightNull,exchConstr,elementalComposition,newRowOrder,indepDepS,indepS,linkMatrix,gpr,ignore,pat,defaultInitializationNotes,synonyms},

fluxesFinal=Switch[#,_String,v[#],_v,#,_,v[ToString[#]]]&/@fluxes;

If[
Length[Union[fluxesFinal]]=!=Length[fluxesFinal],
Message[constructModel::nonUniqueRxnIDs,Cases[Tally[fluxesFinal],{fluxID_v,num_/;num>1}:>getID[fluxID]]];Abort[];
];

If[S==={{}},
	
	If[!(compounds===fluxesFinal==={}),
		Message[constructModel::wrongdim,Dimensions[S],Length[compounds],Length[fluxesFinal]];Abort[]
	];
	indepDepS={};
	newRowOrder={};,
	If[(Dimensions[S])!={Length[compounds],Length[fluxesFinal]},
		Message[constructModel::wrongdim,Dimensions[S],Length[compounds],Length[fluxesFinal]];Abort[]
	];

If[MemberQ[S,Except[_Integer|_Real|_Rational],{2}],Message[constructModel::wrongmatrixelements,Position[S[model],Except[_Integer|_Real|_Rational],{2},Heads->False]//Short];Abort[];];
If[OptionValue["ReorderStoichiometry"],
{newRowOrder,indepDepS,indepS,linkMatrix}=calcLinkMatrix[SparseArray[S]];,
{newRowOrder,indepDepS}={Range[1,Length[S]],SparseArray[S]};
];
];

initialConditions=OptionValue["InitialConditions"];
pat="InitialConditions"/.attributeTestPatterns;
If[!MatchQ[initialConditions,pat],Message[constructModel::malformedarg,"Initial conditions",Short[initialConditions,30],pat];Abort[]];
initialConditions=initialConditions/.(s_String->val_):>v[s]->val;

parameters=OptionValue["Parameters"];
pat="Parameters"/.attributeTestPatterns;
If[!MatchQ[parameters,pat],Message[constructModel::malformedarg,"Parameter(s)",Short[parameters],pat];Abort[]];
(*Silently setting compartment volumes to 1 Liter if not provided*)
variableComp=Union[Cases[OptionValue["CustomODE"],parameter["Volume",_][t]|Derivative[_][parameter["Volume",_]][t],\[Infinity]][[All,0]]/.Derivative[_]:>Sequence];
parameters=updateRules[If[OptionValue["UnitChecking"],#,stripUnits[#]]&[parameter["Volume",#]->1 Liter&/@Complement[getCompartment/@Union[Select[compounds,getCompartment[#]=!=None&]],getID[#][[2]]&/@variableComp]],parameters];

gpr=OptionValue["GPR"];
pat="GPR"/.attributeTestPatterns;
If[!MatchQ[gpr,pat],Message[constructModel::malformedarg,"GPR(s)",Short[gpr],pat];Abort[]];
gpr=("GPR"/.attributeCallBacks)[gpr];

boundaryConditions=OptionValue["BoundaryConditions"];
pat="BoundaryConditions"/.attributeTestPatterns;
If[!MatchQ[boundaryConditions,pat],Message[constructModel::malformedarg,"BoundaryConditions",Short[boundaryConditions],pat];Abort[]];
boundaryConditions=("BoundaryConditions"/.attributeCallBacks)[boundaryConditions];

constant=OptionValue["Constant"];
pat="Constant"/.attributeTestPatterns;
If[!MatchQ[constant,pat],Message[constructModel::malformedarg,"Constant",Short[constant],pat];Abort[]];
constant=("Constant"/.attributeCallBacks)[constant];

name=OptionValue["Name"];
If[!MatchQ[name,(Automatic|_String)],Message[constructModel::malformedarg,"Name",Short[name],Automatic|_String];Abort[]];
If[name==Automatic,name=modelIDtmp];

elementalComposition=OptionValue["ElementalComposition"];
pat="ElementalComposition"/.attributeTestPatterns;
If[!MatchQ[elementalComposition,pat],Message[constructModel::malformedarg,"ElementalComposition",Short[elementalComposition],pat];Abort[]];
elementalComposition=#[[1]]->Switch[#[[2]],Automatic,formula2elementalComposition["&"<>getID[#[[1]]]<>"&"],_String,formula2elementalComposition[#[[2]]],(_Plus|_Times),#[[2]],_SMILES,smiles2elementalComposition[#[[2]]],_InChI,inchi2elementalComposition[#[[2]]]]&/@Thread[Rule[compounds,((compounds)/.elementalComposition)/.$MASS$speciesPattern->Automatic]];

notes=OptionValue["Notes"];
If[!MatchQ[notes,_String],Message[constructModel::malformedarg,"Notes",Short[notes],"Notes"/.attributeTestPatterns];Abort[]];

ignore=OptionValue["Ignore"];
pat="Ignore"/.attributeTestPatterns;
If[!MatchQ[ignore,pat],Message[constructModel::malformedarg,"Ignore",Short[ignore],pat];Abort[]];

units=OptionValue["UnitChecking"];
pat="UnitChecking"/.attributeTestPatterns;
If[!MatchQ[units,pat],Message[constructModel::malformedarg,"UnitChecking",Short[units],pat];Abort[]];

modelIDtmp=modelID;
modelIDtmp=If[OptionValue["ID"]===Automatic,modelIDtmp,OptionValue["ID"]];
If[modelIDtmp==="",modelIDtmp="MASSmodel"<>ToString[Unique[]]];
contxtStr=modelIDtmp<>"`";
If[MemberQ[$ContextPath,contxtStr],Message[Toolbox::Exists,contxtStr];Abort[];];

revColInd=Flatten[Position[fluxesFinal,Alternatives@@Complement[fluxesFinal,Replace[OptionValue["Irreversible"],fluxID_String:>v[fluxID],1]]]];
irrevConstr=#->{0,\[Infinity]}&/@fluxesFinal[[Complement[Range[1,Length[Transpose@S]],revColInd]]];
exchLeftNull=Flatten[Position[Transpose[S],{_?NonNegative..}]];(* \[EmptySet] <-> m *)
exchRightNull=Flatten[Position[Transpose[S],{_?Negative..}]];(* m <-> \[EmptySet] *)

exchConstr=Join[#->{-\[Infinity],0}&/@(fluxesFinal)[[Intersection[exchLeftNull,revColInd]]](* \[EmptySet] <-> m *),
#->{0,0}&/@fluxesFinal[[Complement[exchLeftNull,revColInd]]](* m <-> \[EmptySet] *),
#->{0,\[Infinity]}&/@fluxesFinal[[Intersection[exchRightNull,revColInd]]](* \[EmptySet] -> m *),
#->{0,\[Infinity]}&/@fluxesFinal[[Complement[exchRightNull,revColInd]](* m -> \[EmptySet] *)]
];

tmpRxns=stoich2reactionList[S,compounds,fluxesFinal,revColInd];

constraints=OptionValue["Constraints"];
pat="Constraints"/.attributeTestPatterns;
If[!MatchQ[constraints,pat],Message[constructModel::malformedarg,"Constraints",Short[constraints],pat];Abort[]];
constraints=("Constraints"/.attributeCallBacks)[constraints,tmpRxns];


If[OptionValue["UnitChecking"],
{initialConditions,parameters}=adjustUnits[#,tmpRxns,"Ignore"->ignore]&/@{initialConditions,parameters};
];

synonyms=OptionValue["Synonyms"];
pat="Synonyms"/.attributeTestPatterns;
If[!MatchQ[synonyms,pat],Message[constructModel::malformedarg,"Synonyms",Short[synonyms,30],pat];Abort[]];

events=OptionValue["Events"];
pat="Events"/.attributeTestPatterns;
If[!MatchQ[events,pat],Message[constructModel::malformedarg,"Events",Short[events,30],pat];Abort[]];

objective=OptionValue["Objective"];
pat="Objective"/.attributeTestPatterns;
If[!MatchQ[objective,pat],Message[constructModel::malformedarg,"Objective",objective,pat];Abort[]];

model=MASSmodel[
{
"ID"->modelIDtmp,
"Stoichiometry"->indepDepS,
"Species"->compounds[[newRowOrder]],
"Fluxes"->(fluxesFinal),
"Constraints"->updateRules[updateRules[irrevConstr,exchConstr],constraints],
"InitialConditions"->initialConditions,
"Parameters"->parameters,
"GPR"->gpr,
"BoundaryConditions"->boundaryConditions,
"Constant"->constant,
"ReversibleColumnIndices"->revColInd,
"CustomRateLaws"->("CustomRateLaws"/.attributeCallBacks)[OptionValue["CustomRateLaws"]],
"CustomODE"->OptionValue["CustomODE"],
"Name"->name,
"ElementalComposition"->elementalComposition,
"Notes"->notes,
"Ignore"->ignore,
"UnitChecking"->units,
"Synonyms"->synonyms,
"Events"->events
}
];
model
];

constructModel[reactions:{_reaction...},opts:OptionsPattern[]]:=reactionList2model[reactions,opts]

constructModel[rxn_reaction,opts:OptionsPattern[]]:=constructModel[{rxn},opts]

def:constructModel[___]:=(Message[Toolbox::badargs,constructModel,Defer@def];Abort[])
Protect[constructModel];


Unprotect[setModelAttribute];
SetAttributes[setModelAttribute,HoldFirst];
Options[setModelAttribute]={"Sloppy"->False};
setModelAttribute::malformedarg="`1` `2` do/does not match the appropriate pattern `3`";
setModelAttribute::wrongattr="The attribute `1` does not exist in model `2` or might not be mutable.";
setModelAttribute[model_Symbol,attribute_String,rhs_,opts:OptionsPattern[]]:=Module[{attributeTest,callBack},
	If[OptionValue["Sloppy"]==True,
		model[[1]]=updateRules[model[[1]],{attribute->rhs}],
		If[!MemberQ[$MASSmodel$Attributes,attribute],Message[setModelAttribute::wrongattr,attribute,model["ID"]];Abort[];];
		attributeTest=MatchQ[#,attribute/.attributeTestPatterns]&;
		If[!attributeTest[rhs],Message[setModelAttribute::malformedarg,attribute,rhs//Short,attribute/.attributeTestPatterns];Abort[];];
		callBack=attribute/.attributeCallBacks;
		model[[1]]=updateRules[model[[1]],{attribute->callBack[rhs,model]}];
	];
];
def:setModelAttribute[___]:=(Message[Toolbox::badargs,setModelAttribute,Defer@def];Abort[])
Protect[setModelAttribute];


Unprotect[updateModelAttribute];
SetAttributes[updateModelAttribute,HoldFirst];
updateModelAttribute::malformedarg="`1` `2` do/does not match the appropriate pattern `3`";
updateModelAttribute::wrongattr="The attribute `1` does not exist in model `2` or might not be mutable.";
updateModelAttribute[model_Symbol,attribute_String,rhs_]:=Module[{attributeTest,prevAttribute,newAttribute,callBack},
If[!MemberQ[$MASSmodel$Attributes,attribute],Message[updateModelAttribute::wrongattr,attribute,model["ID"]];Abort[];];
attributeTest=MatchQ[#,attribute/.attributeTestPatterns]&;
If[!attributeTest[rhs],Message[setModelAttribute::malformedarg,attribute,rhs//Short,attribute/.attributeTestPatterns];Abort[];];
callBack=attribute/.attributeCallBacks;
prevAttribute=model[attribute];
newAttribute=Switch[prevAttribute,_v,callBack[rhs,model],_String,prevAttribute<>"\n"<>callBack[rhs,model],{_Rule..},updateRules[prevAttribute,callBack[rhs,model]],_List,Union[prevAttribute,callBack[rhs,model]],(True|False),callBack[rhs,model]];
setModelAttribute[model,attribute,newAttribute,"Sloppy"->True]
];
def:updateModelAttribute[___]:=(Message[Toolbox::badargs,updateModelAttribute,Defer@def];Abort[])
Protect[updateModelAttribute];


Unprotect[addModelAttribute];
SetAttributes[addModelAttribute,HoldFirst];
addModelAttribute[model_Symbol,attribute_String,rhs_]:=(AppendTo[model[[1]],attribute->rhs]);
def:addModelAttribute[___]:=(Message[Toolbox::badargs,addModelAttribute,Defer@def];Abort[])
Protect[addModelAttribute];


Unprotect[MASSmodel];

(*Attributes*)
$MASSmodel$MutableAttributes={"ID","Name","Constraints","InitialConditions","Parameters","GPR","BoundaryConditions","HasOnlySubstanceUnits",
"Constant","ReversibleColumnIndices","CustomRateLaws","CustomODE","ElementalComposition","Notes","Ignore","UnitChecking","Synonyms","Events","Objective"};
$MASSmodel$ImmutableAttributes={"Stoichiometry","Species","Fluxes"};
$MASSmodel$AdditionalImmutablAttributes={"Attributes","SparseStoichiometry","Reactions","Exchanges","Variables","ForwardRateConstants","ReverseRateConstants",
"EquilibriumConstants","IrreversibleColumnIndices","Rates","Compartments","ODE","Genes","Proteins","GeneAssociations","ProteinAssociations","Enzymes"}

$MASSmodel$Attributes=Join[$MASSmodel$MutableAttributes,$MASSmodel$ImmutableAttributes,$MASSmodel$AdditionalImmutablAttributes];
(*The next three Do blocks assign getters, setters and updaters for model attributes*)
Do[
Unprotect[Evaluate[Symbol["Toolbox`update"<>elem]]];
SetAttributes[Evaluate[Symbol["Toolbox`update"<>elem]],HoldFirst];
(Evaluate[Symbol["Toolbox`update"<>elem]][model_/;Head[model]===MASSmodel,stuff_]:=updateModelAttribute[model,#,stuff])&[elem];
(def:Evaluate[Symbol["Toolbox`update"<>elem]][___]:=(Message[Toolbox::badargs,#,Defer@def];Abort[]))&[Evaluate[Symbol["Toolbox`update"<>elem]]];
Protect[Evaluate[Symbol["Toolbox`update"<>elem]]];
,{elem,$MASSmodel$MutableAttributes}];

Do[
Unprotect[Evaluate[Symbol["Toolbox`set"<>elem]]];
SetAttributes[Evaluate[Symbol["Toolbox`set"<>elem]],HoldFirst];
(Evaluate[Symbol["Toolbox`set"<>elem]][model_/;Head[model]===MASSmodel,stuff_]:=setModelAttribute[model,#,stuff])&[elem];
(def:Evaluate[Symbol["Toolbox`set"<>elem]][___]:=(Message[Toolbox::badargs,#,Defer@def];Abort[]))&[Evaluate[Symbol["Toolbox`set"<>elem]]];
Protect[Evaluate[Symbol["Toolbox`set"<>elem]]];
,{elem,$MASSmodel$MutableAttributes}];

Do[
Unprotect[Evaluate[Symbol["Toolbox`get"<>elem]]];
(Evaluate[Symbol["Toolbox`get"<>elem]][model_/;Head[model]===MASSmodel,opts:OptionsPattern[]]:=model[#,opts])&[elem];
(def:Evaluate[Symbol["Toolbox`get"<>elem]][___]:=(Message[Toolbox::badargs,#,Defer@def];Abort[]))&[Evaluate[Symbol["Toolbox`get"<>elem]]];
Protect[Evaluate[Symbol["Toolbox`get"<>elem]]];
,{elem,$MASSmodel$Attributes}];
model_MASSmodel[attribute:(Evaluate[Alternatives@@$MASSmodel$Attributes])]:=attribute/.Join[model[[1]],Options[constructModel],{Automatic->""}]

model_MASSmodel["Compounds"]:=Module[{},
Message[Toolbox::deprecated,"Attribute \"Compounds\"","\"Species\""];If[MemberQ[model[[1,All,1]],"Compounds"],"Compounds"/.model[[1]],model["Species"]]
];

model_MASSmodel["Species"]:=Module[{},If[!MemberQ[model[[1,All,1]],"Species"],"Compounds"/.model[[1]],"Species"/.model[[1]]]]

model_MASSmodel["Attributes"]:=$MASSmodel$Attributes
model_MASSmodel["Stoichiometry"]:=Normal["Stoichiometry"/.model[[1]]]
model_MASSmodel["SparseStoichiometry"]:="Stoichiometry"/.model[[1]]
model_MASSmodel["ReducedStoichiometry"]:=#[[1;;MatrixRank[#]]]&[model["Stoichiometry"]];
model_MASSmodel["IndependentSpecies"]:=model["Species"][[1;;MatrixRank[model]]]
model_MASSmodel["DependentSpecies"]:=model["Species"][[MatrixRank[model]+1;;]]
model_MASSmodel["LinkMatrix"]:=Chop[model["Stoichiometry"].PseudoInverse[N@model["ReducedStoichiometry"]]];
model_MASSmodel["Reactions"]:=model2reactionList[model];
model_MASSmodel["Exchanges"]:=Cases[model2reactionList[model],r_reaction/;Length[getSubstrates[r]]==0||Length[getProducts[r]]==0,\[Infinity]]
(*model_MASSmodel["Variables"]:=Union[Cases[model["ODE"],Join[$MASS$speciesPattern,$MASS$parametersPattern][t|(t+___)]|D[Join[$MASS$speciesPattern,$MASS$parametersPattern][t],t],\[Infinity]]/.Derivative[_][stuff_]:>stuff/.(t+_):>t]*)
model_MASSmodel["Variables"]:=Union[Cases[Join[model["ODE"],model["Events"][[All,2]]],Join[$MASS$speciesPattern,$MASS$parametersPattern][t]|D[Join[$MASS$speciesPattern,$MASS$parametersPattern][t],t],\[Infinity]]/.Derivative[_][stuff_]:>stuff]
model_MASSmodel["ForwardRateConstants"]:=Union[Cases[model["Rates"],rateconst[_,True],\[Infinity]]];
model_MASSmodel["ReverseRateConstants"]:=Union[Cases[model["Rates"],rateconst[_,False],\[Infinity]]];
model_MASSmodel["EquilibriumConstants"]:=Union[Cases[model["Rates"],Keq[_],\[Infinity]]];
model_MASSmodel["IrreversibleColumnIndices"]:=Complement[Range[1,Length[Transpose[model]]],model["ReversibleColumnIndices"]];
model_MASSmodel["Rates",opts:OptionsPattern[]]:=makeRates[model,opts];
model_MASSmodel["Rates"]:=makeRates[model];
model_MASSmodel["Compartments"]:=Union[getCompartment/@model["Species"]]
model_MASSmodel["ODE"]:=getODE[model];
model_MASSmodel["Genes"]:=Union@Cases[model["GPR"],_gene,\[Infinity]];
model_MASSmodel["Proteins"]:=Union@Cases[model["GPR"],_protein,\[Infinity]];
model_MASSmodel["GeneAssociations"]:=(Union[Cases[model["GPR"],r_Rule/;r[[1,0]]===String,\[Infinity]]]/.p_proteinComplex:>And@@p)/.Union[Cases[model["GPR"],r_Rule/;r[[1,0]]===protein||r[[1,0]]===proteinComplex,\[Infinity]]]/.g_geneComplex:>And@@g
model_MASSmodel["ProteinAssociations"]:=Union[Cases[model["GPR"],r_Rule/;r[[1,0]]===String,\[Infinity]]]/.p_proteinComplex:>And@@p
model_MASSmodel["Enzymes"]:=Cases[model["Species"],_enzyme];

def:model_MASSmodel[args___]:=(Message[Toolbox::badargs,"MASSmodel["<>getID@model<>", ...]",List[args]];Abort[])

(*Overloading*)
MASSmodel/:MatrixPlot[model_MASSmodel,opts:OptionsPattern[]]:=MatrixPlot[model["SparseStoichiometry"],FrameTicks->{{Automatic,Thread[List[Range[1,Length[#]],#]]&[Tooltip[StandardForm[#],TraditionalForm@#]&/@model["Species"]]},{Thread[List[Range[1,Length[#]],#]]&[Thread[Tooltip[Rotate[stringShortener[#],90Degree]&/@model["Fluxes"],StandardForm/@model["Reactions"]]]],Automatic}},opts]
MASSmodel/:Dot[rest1___,model_MASSmodel,rest2___]:=Dot[rest1,model["Stoichiometry"],rest2];
MASSmodel/:Transpose[model_MASSmodel]:=Transpose[model["SparseStoichiometry"]];
MASSmodel/:NullSpace[model_MASSmodel]:=NullSpace[model["Stoichiometry"]];
MASSmodel/:Length[model_MASSmodel]:=Length[model["SparseStoichiometry"]];
MASSmodel/:Dimensions[model_MASSmodel]:=Dimensions[model["SparseStoichiometry"]];
MASSmodel/:MatrixRank[model_MASSmodel]:=MatrixRank[model["SparseStoichiometry"]];
MASSmodel/:RowReduce[model_MASSmodel]:=RowReduce[model["Stoichiometry"]];
MASSmodel/:MatrixForm[model_MASSmodel]:=MatrixForm[model["SparseStoichiometry"]];
MASSmodel/:SameQ[model1_MASSmodel,model2_MASSmodel]:=Sort[model1[[1]]]===Sort[model2[[1]]];
MASSmodel/:Equal[model1_MASSmodel,model2_MASSmodel]:=Sort[model1[[1]]]==Sort[model2[[1]]];
MASSmodel/:ReplaceAll[stuff_,model_MASSmodel]:=stuff/.Join[model["Parameters"],model["InitialConditions"],Thread[Rule[getID/@model["Fluxes"],Thread[{model["Reactions"],model["Rates"]}]]]]
MASSmodel/:Union[models__MASSmodel]:=Module[{listOfModels,commonAttributes,listOfAttributes,modelTmp,rhs},
	listOfModels=List[models];
	commonAttributes=Complement[Intersection[Union[Sequence@@(listOfModels[[All,1,All,1]])],Options[constructModel][[All,1]]],{"ID","Name"}];
	modelTmp=constructModel[
		Union[Sequence@@(#["Reactions"]&/@List[models]),SameTest->(#1==#2&)],
		"ID" -> StringJoin[Sequence@@Riffle[#["ID"]&/@listOfModels," \[Union] "]],
		"Name" -> StringJoin[Sequence@@Riffle[#["Name"]&/@listOfModels," \[Union] "]]
	];
	Do[listOfAttributes=#[attr]&/@listOfModels;
		rhs=Which[
				And@@(MatchQ[#,{}]&/@listOfAttributes),{},
				And@@(MatchQ[#,{_Rule...}]&/@listOfAttributes),updateRules[Sequence@@listOfAttributes],
				And@@(MatchQ[#,_List]&/@listOfAttributes),Union[Flatten[listOfAttributes]],
				And@@(MatchQ[#,_String]&/@listOfAttributes),StringJoin[Sequence@@Riffle[listOfAttributes,"\n"]],
				And@@(MatchQ[#,True|False]&/@listOfAttributes),And@@Flatten[(listOfAttributes)],
				True,Print["Panic!"]
			];
		setModelAttribute[modelTmp,attr,rhs,"Sloppy"->True];
	,{attr,commonAttributes}];
	modelTmp
];
MASSmodel/:Intersection[models__MASSmodel]:=Module[{listOfModels,commonAttributes},
	listOfModels=List[models];
	commonAttributes=Complement[Intersection[Union[Sequence@@(listOfModels[[All,1,All,1]])],Options[constructModel][[All,1]]],{"ID","Name"}];
	constructModel[
		Intersection[Sequence@@(#["Reactions"]&/@listOfModels),SameTest->(#1==#2&)],
		"ID" -> StringJoin[Sequence@@Riffle[#["ID"]&/@listOfModels," \[Intersection] "]],
		"Name" -> StringJoin[Sequence@@Riffle[#["Name"]&/@listOfModels," \[Intersection] "]],
		Sequence@@Table[
			attr->
			Switch[listOfModels[[1]][attr],
				{_Rule...},FilterRules[updateRules[Sequence@@(#[attr]&/@listOfModels)],Intersection[Sequence@@(#[attr][[All,1]]&/@listOfModels)]],
				_List,Intersection[Flatten[(#[attr]&/@listOfModels)]],
				_String,"Intersection of ...\n"<>StringJoin[Sequence@@Riffle[#[attr]&/@listOfModels,"\n"]],
				(True|False),And@@Flatten[(#[attr]&/@listOfModels)]
			]
		,{attr,commonAttributes}]
	]
];

MASSmodel/:Complement[model_MASSmodel, models__MASSmodel]:=Module[{listOfModels,commonAttributes},
	listOfModels=List[models];
	commonAttributes=Complement[Intersection[Union[Sequence@@(Prepend[listOfModels,model][[All,1,All,1]])],Options[constructModel][[All,1]]],{"ID","Name"}];
	constructModel[
		Complement[model["Reactions"],Sequence@@(#["Reactions"]&/@listOfModels),SameTest->(#1==#2&)],
		"ID" -> model["ID"]<>" \[Backslash] "<>StringJoin[Sequence@@Riffle[#["ID"]&/@listOfModels," \[Union] "]],
		"Name" -> model["Name"]<>" \[Backslash] "<>StringJoin[Sequence@@Riffle[#["Name"]&/@listOfModels," \[Union] "]],
		Sequence@@Table[
			attr->
			Switch[model[attr],
				{_Rule...},FilterRules[updateRules[Sequence@@(#[attr]&/@Append[listOfModels,model])],Except[Union[Sequence@@(#[attr][[All,1]]&/@listOfModels)]]],
				_List,model[attr],
				_String,model[attr],
				(True|False),model[attr]
			]
		,{attr,commonAttributes}]
	]
];


width=800;height=450;
specialPane=Pane[#,{{width},{height}},Scrollbars->{False,True}]&;
specialPane2=Pane[#,{{width},{height}},Scrollbars->{True,True}]&;

MASSmodel /:getOverview[model_MASSmodel]:=Module[{stoich},
stoich=getSparseStoichiometry[model];
specialPane2[
Style[#,FontSize->12]&@Grid[{{"Number of species(rows):",Length[stoich]},{"Number of columns(reactions):",Dimensions[model][[2]]},{"Number of exchange reactions:",Length[model["Exchanges"]]},{"Number of irreversible reactions:",Count[model["Reactions"],r_reaction/;!reversibleQ[r]]},
{"Matrix rank:",If[Length[stoich]<1000,MatrixRank[stoich],Missing["NotAvailable"]]},
{"Dimensions null space: ",If[Length[stoich]<1000,Dimensions[stoich][[2]]-MatrixRank[stoich],Missing["NotAvailable"]]},
{"Dimensions left null space: ",If[Length[stoich]<1000,Dimensions[stoich\[Transpose]/.{}->{{}}][[2]]-MatrixRank[stoich],Missing["NotAvailable"]]},
{"Number of parameters",Length@model["Parameters"]},
{"Number of custom rate equations",Length@model["CustomRateLaws"]},
{"Number of equilibrium constants:",Length@Union@Cases[model["Parameters"],keq_Keq/;MemberQ[(getID/@model["Fluxes"]),getID[keq]],\[Infinity]]},
{"Number of forward rate constants:",Length@Union@Cases[model["Parameters"],k:rateconst[_,True]/;MemberQ[(getID/@model["Fluxes"]),getID[k]],\[Infinity]]},{"Number of initial concentrations:",Length@Union@Cases[model["InitialConditions"],m:$MASS$speciesPattern/;MemberQ[model["Species"],m],\[Infinity]]},{"Number of genes:",Length[model["Genes"]]},{"Number of proteins:",Length[model["Proteins"]]}},
Dividers->{True,All},Background->{None,{{GrayLevel[.99],LightBlue}}},Spacings->{1,1}]
]
]

MASSmodel/:MakeBoxes[model_MASSmodel/;model["Stoichiometry"]=={},_]:=ToBoxes[Style[Global`\[EmptySet],Large]];

MASSmodel/:MakeBoxes[model_MASSmodel,_]:=ToBoxes@MenuView[{
"Overview"->getOverview[model],
If[Length[model]<=400,"Stoichiometry matrix"->MatrixPlot[model,ImageSize->{{width},{height}},BaseStyle->{FontFamily->"Helvetica",FontSize->Scaled[0.015]}],Unevaluated[Sequence[]]],
"Reactions"->specialPane2[Style[#,FontSize->12]&@Column[model["Reactions"],Dividers->{True,All},Background->{{GrayLevel[.99],LightBlue}},Spacings->{1,1}]],
If[Length[model]<1000,"Rates"->specialPane[TabView[{"Type I"->#,"Type II"->keq2k@#,"Type III"->kFwd2keq@#}]&[Style[Grid[Thread[List[model["Fluxes"],getRates@model]],Dividers->{True,All},Background->{None,{{GrayLevel[.99],LightBlue}}},Spacings->{1,1}],FontSize->12]]],Unevaluated[Sequence[]]],
If[Length[model]<1000,"ODE"->specialPane[Style[#,FontSize->10]&@Column[model["ODE"],Dividers->{True,All},Background->{{GrayLevel[.99],LightBlue}},Spacings->{1,1}]],Unevaluated[Sequence[]]],
"Constraints"->specialPane2@Style[TableForm[#[[2,1]]<=#[[1]]<=#[[2,2]]&/@model["Constraints"]],FontSize->10],
"Initial conditions"->specialPane2@Style[TableForm[#[[1]]'[0]==#[[2]]&/@model["InitialConditions"]],FontSize->10],
"Parameters"->specialPane2@Style[TableForm[List@@@model["Parameters"]],FontSize->10],
"GPR"->SlideView[If[#=={},{"No GPR associations defined"},#]&@(visualizeGPR/@gpr2graphs[model["GPR"]]),AppearanceElements->All,ImageSize->{{width},{height}}],
If[Length[model]<200,
"Pathway map"->Evaluate@Manipulate[visualizePathways[pathwaytize[model2bipartite[model],p,Method->method],PlotFunction->pltfunc,ImageSize->{{width},{height-140}}],{{p,0,"Currency metabolites to remove"},0,Length[model],1},{{method,"Remove","How to treat currency metabolites"},{"Remove","Mask"}},{{pltfunc,LayeredGraphPlot,"Plot function"},{LayeredGraphPlot,GraphPlot,TreePlot}}],Unevaluated[Sequence[]]],
"Nullspace"->If[NullSpace[model]=!={},specialPane2@TableForm[NullSpace[model].model["Fluxes"],TableHeadings->{None,model["Fluxes"]}],"Nullspace empty"],
"Left Nullspace"->If[NullSpace[Transpose@model]=!={},specialPane2@TableForm[NullSpace[Transpose@model].model["Species"],TableHeadings->{None,model["Species"]}],"Left Nullspace empty"],
"Notes"->specialPane2@Style[model["Notes"],FontSize->10]},ImageSize->{{width},{height}}]

(*Functions*)
MASSmodel/:getID[model_MASSmodel]:=model["ID"];
MASSmodel/:getCompounds[model_MASSmodel]:=model["Species"];

MASSmodel/:makeRates[model_MASSmodel,opts:OptionsPattern[]]:=Module[{finalOpts,finalParam,rates},
	finalOpts=FilterRules[updateRules[{"Ignore"->model["Ignore"]},FilterRules[List@opts,Except["Parameters"]]],Options[makeRates]];
	finalParam=updateRules[model["Parameters"],OptionValue["Parameters"]];
	rates=makeRates[model["Reactions"],"Parameters"->finalParam,Sequence@@finalOpts];
	(*Handle constant species*)	
	rates=rates/.elem_[t]/;MemberQ[model["Constant"],elem]:>elem;
	(*Handle custom rate laws*)
	model["Fluxes"]/.Dispatch@updateRules[
		Thread[model["Fluxes"]->rates],
		model["CustomRateLaws"]
	]
];

MASSmodel/:model2reactionList[model_MASSmodel]:=stoich2reactionList[model["SparseStoichiometry"],model["Species"],model["Fluxes"]/.flux_v:>getID[flux],model["ReversibleColumnIndices"]];

MASSmodel/:stoich2bipartite[model_MASSmodel]:=stoich2bipartite[model["Stoichiometry"],model["Fluxes"],model["Species"]];

Unprotect[getODE]
getODE::usage="getODE[model] will return a system of differential equation for model. getODE[stoich, rowIDs, rates] can be used with the ";
Options[getODE]={"Parameters"->{}};
MASSmodel/:getODE[model_MASSmodel,opts:OptionsPattern[]]:=Module[{hosuRules,tmpEq,cmp,constantSpecies,boundaryConditionsCoverdByRateRules,boundaryConditionsCoveredByAlgebraicRules,boundaryConditionsCoveredByAssignmentRules},
	tmpEq=Thread[#[t]&/@model["Species"]==model.makeRates[model,Parameters->OptionValue["Parameters"]]]/.eq_Equal/;MemberQ[model["BoundaryConditions"],eq[[1,0]]]:>eq[[1]]==0;
	(*BoundaryConditions that do not participate in any reaction*)
	tmpEq=Join[tmpEq,Thread[#[t]&/@Complement[model["BoundaryConditions"],model["Species"]]==0]];
	(*tmpEq=tmpEq/.eq_Equal/;MatchQ[eq[[1]],Derivative[1][$MASS$speciesPattern][t]]:>If[(cmp=Union[Cases[eq[[2]],parameter["Volume",getCompartment[eq[[1,0,1]]]][t],\[Infinity]]])=!={},D[cmp[[1]]eq[[1]],t]==eq[[2]],D[parameter["Volume",getCompartment[eq[[1,0,1]]]]*eq[[1]],t]==eq[[2]]];*)
	tmpEq=If[(cmp=Union[Cases[#[[2]],parameter["Volume",getCompartment[#[[1,0]]]][t],\[Infinity]]])=!={},D[cmp[[1]]#[[1]],t]==#[[2]],D[parameter["Volume",getCompartment[#[[1,0]]]]*#[[1]],t]==#[[2]]]&/@tmpEq;
	constantSpecies=model["Constant"];
	tmpEq=DeleteCases[tmpEq,eq_Equal/;MemberQ[eq,Alternatives@@(D[#[t],t]&/@constantSpecies),\[Infinity]]];
	(*tmpEq=Equal@@@updateRules[Rule@@@tmpEq,Rule@@@model["CustomODE"]];*)
	boundaryConditionsCoverdByRateRules=Cases[model["CustomODE"][[All,1]],Derivative[1][$MASS$speciesPattern][t]];
	boundaryConditionsCoveredByAlgebraicRules=D[#,t]&/@Union[Cases[Select[model["CustomODE"],#[[1]]==0&],pat:$MASS$speciesPattern[t]/;MemberQ[model["BoundaryConditions"],pat[[0]]],\[Infinity]]];
	boundaryConditionsCoveredByAssignmentRules=D[#,t]&/@Cases[model["CustomODE"][[All,1]],$MASS$speciesPattern[t]];
	(*boundaryConditionsCoveredByAlgebraicRules=D[#,t]&/@Union[Cases[model["CustomODE"][[All,1]],pat:$MASS$speciesPattern[t]/;MemberQ[model["BoundaryConditions"],pat[[0]]],\[Infinity]]];*)
	tmpEq=DeleteCases[tmpEq,eq_Equal/;MemberQ[eq[[1]],Alternatives@@Join[boundaryConditionsCoverdByRateRules,boundaryConditionsCoveredByAlgebraicRules,boundaryConditionsCoveredByAssignmentRules]]];
	tmpEq=Join[tmpEq,model["CustomODE"]]
];
Protect[getODE]

MASSmodel/:S[model_MASSmodel]:=model["Stoichiometry"]
MASSmodel/:SRed[model_MASSmodel]:=model["ReducedStoichiometry"]
Subscript[S, r][model_MASSmodel]:=SRed[model]
MASSmodel/:L[model_MASSmodel]:=model["LinkMatrix"]
MASSmodel/:L0[model_MASSmodel]:=model["LinkMatrix"][[MatrixRank[model]+1;;]]

MASSmodel/:getMassActionRatios[model_MASSmodel,opts:OptionsPattern[]]:=getMassActionRatios[model["Reactions"],"Ignore"->Union[model["Ignore"],OptionValue["Ignore"]]]
MASSmodel/:\[CapitalGamma][model_MASSmodel,opts:OptionsPattern[]]:=getMassActionRatios[model,opts]

MASSmodel/:getGradient[model_MASSmodel]:=getGradient[model["Rates"]/.m:_[t]:>m[[0]],model["Species"]]
MASSmodel/:G[model_MASSmodel]:=getGradient[model];

MASSmodel/:getDisequilibriumRatios[model_MASSmodel,opts:OptionsPattern[]]:=getDisequilibriumRatios[model["Reactions"],"Ignore"->Union[model["Ignore"],OptionValue["Ignore"]]]
MASSmodel/:\[Rho][model_MASSmodel,opts:OptionsPattern[]]:=getDisequilibriumRatios[model,opts]

MASSmodel/:getJacobian[model_MASSmodel,opts:OptionsPattern[]]:=Switch[OptionValue["Type"],
		"Concentration",S[model].G[model],
		"Flux",G[model].S[model],
		_,Message[getJacobian::unknownJacobianType,OptionValue["Type"]];Abort[];
	]
MASSmodel/:J[model_MASSmodel,opts:OptionsPattern[]]:=getJacobian[model,opts]

MASSmodel/:splitReversible[model_MASSmodel]:=Module[{splitModel,splitStoich,newColIDs,splitParam,revFluxes,pat},
	revFluxes=model["Fluxes"][[model["ReversibleColumnIndices"]]];
	splitModel=model;
	{splitStoich,newColIDs}=splitReversible[model["Stoichiometry"],getID/@model["Fluxes"],model["ReversibleColumnIndices"]];
	setModelAttribute[splitModel,"Stoichiometry",splitStoich];
	setModelAttribute[splitModel,"Fluxes",newColIDs];
	setModelAttribute[splitModel,"ReversibleColumnIndices",{}];
	setModelAttribute[splitModel,"Constraints",updateRules[#->{0,\[Infinity]}&/@(splitModel["Fluxes"]),Flatten[If[MemberQ[revFluxes,#[[1]]],{#[[1]]->{If[#[[2,1]]<=0,0,#[[2,1]]],#[[2,2]]},v[getID[#[[1]]]<>"_Rev"]->{If[#[[2,2]]>=0,0,-#[[2,2]]],-#[[2,1]]}},#]&/@(model["Constraints"])]]];
	pat=("Parameters"/.attributeTestPatterns)[[1,1,1,2]];
	splitParam=DeleteCases[FilterRules[complementParameters[model["Parameters"]],Except[_Keq]]/.r:rateconst[id_,False]:>rateconst[id<>"_Rev",True],r_Rule/;(r[[1,0]]===rateconst&&!MemberQ[getID/@splitModel["Fluxes"],getID[r[[1]]]])||!MatchQ[r[[2]],pat]];
	setModelAttribute[splitModel,"Parameters",splitParam];
	setModelAttribute[splitModel,"CustomRateLaws",splitModel["CustomRateLaws"]/._Keq->\[Infinity]];
	setModelAttribute[splitModel,"GPR",Flatten[If[MemberQ[revFluxes,#[[1]]],{#,v[getID[#[[1]]]<>"_Rev"]->#[[2]]},#]&/@model["GPR"]]];
	setModelAttribute[splitModel,"InitialConditions",Flatten[If[MemberQ[revFluxes,#[[1]]],{#[[1]]->If[stripUnits[#[[2]]]>=0,#[[2]],0],v[getID[#[[1]]]<>"_Rev"]->If[stripUnits[#[[2]]]<=0,-#[[2]],0]},#]&/@model["InitialConditions"]]];
	splitModel
];

Protect[MASSmodel];


Unprotect[splitReversible];
splitReversible[stoich_?MatrixQ,colIDs:{(_String|_v)..},reversibleColumnIndices:{_Integer..}]:=Module[{splitStoich,cleanColIDs},
	cleanColIDs=colIDs/.flux_v:>getID[flux];
	splitStoich=Transpose@Join[Transpose[stoich],-1*Transpose[stoich][[reversibleColumnIndices]]];
	{splitStoich,Join[cleanColIDs,#<>"_Rev"&/@cleanColIDs[[reversibleColumnIndices]]]}
];
def:splitReversible[___]:=(Message[Toolbox::badargs,splitReversible,Defer@def];Abort[])
Protect[splitReversible];


Unprotect[addExchange];
addExchange::wrngPrefix="Prefix `1` is not string.";
addExchange::wrngDirection="Direction has to be either Forward (m <=> 0) or Reverse (0 <=> m) and not `1`.";
Options[addExchange]={"Direction"->"Forward"(*or Reverse*),"Prefix"->"EX_"}
addExchange[model_MASSmodel,m:$MASS$speciesPattern,opts:OptionsPattern[]]:=Module[{},
	If[!MatchQ[OptionValue["Prefix"],_String],Message[addExchange::wrngPrefix,OptionValue["Prefix"]];Abort[];];
	addReaction[model,
		Switch[OptionValue["Direction"],
			"Forward", reaction[OptionValue["Prefix"]<>ToString[m],{m},{},{1}],
			"Reverse", reaction[OptionValue["Prefix"]<>ToString[m],{},{m},{1}],
			_,         Message[addExchange::wrngDirection,OptionValue["Direction"]];Abort[];
		]
	]
];
def:addExchange[___]:=(Message[Toolbox::badargs,addExchange,Defer@def];Abort[])
Protect[addExchange];


Unprotect[addExchanges];
Options[addExchanges]=Options[addExchange];
addExchanges[model_MASSmodel,m:{$MASS$speciesPattern..},opts:OptionsPattern[]]:=Fold[addExchange[#1,#2,opts]&,model,m]
def:addExchanges[___]:=(Message[Toolbox::badargs,addExchanges,Defer@def];Abort[])
Protect[addExchange];


Unprotect[addSinks];
addSinks[model_MASSmodel]:=Module[{bip,tmp,needSinks},
	bip=List@@@model2bipartite[model];
	tmp=Cases[bip,({m_metabolite,r_String}/;MemberQ[bip,{Except[r],m}]):>{m,r}][[All,1]];
	needSinks=Complement[model["Species"],tmp];
	addSinks[model,needSinks]
];
addSinks[model_MASSmodel,cmpds:{$MASS$speciesPattern..}]:=Module[{sinks},
	sinks=Table[reaction["Sink_"<>ToString[c],{c},{},{1},True],{c,cmpds}];
	addReactions[model,sinks]
];
def:addSinks[___]:=(Message[Toolbox::badargs,addSinks,Defer@def];Abort[])
Protect[addSinks];

Unprotect[addSink];
addSink[model_MASSmodel,cmpd:$MASS$speciesPattern]:=Module[{sinks},
	addSinks[model,{cmpd}]
];
def:addSink[___]:=(Message[Toolbox::badargs,addSink,Defer@def];Abort[])
Protect[addSink];


Unprotect[deleteReactions];
deleteReactions::rxnNotInModel="Reaction(s) `1` does/do not exist in the model.";
deleteReactions[model_MASSmodel,{}]:=model
deleteReactions[model_MASSmodel,rxns:{_reaction..}]:=deleteReactions[model,getID/@rxns]
deleteReactions[model_MASSmodel,rxnIDs:{(_String|_v)..}]:=Module[{modelTmp,notInModel,fixIDs},
	If[notInModel=Complement[rxnIDs/.flux_v:>getID[flux],getID/@model["Fluxes"]];notInModel!={},Message[deleteReactions::rxnNotInModel,notInModel];Abort[];];
	modelTmp=constructModel[DeleteCases[model["Reactions"],r_reaction/;MemberQ[rxnIDs/.flux_v:>getID[flux],getID[r]]]];
	setModelAttribute[modelTmp,"Ignore",Select[model["Ignore"],MemberQ[modelTmp["Species"],#]&],"Sloppy"->True];
	setModelAttribute[modelTmp,"ID",model["ID"],"Sloppy"->True];
	setModelAttribute[modelTmp,"Name",model["Name"],"Sloppy"->True];
	setModelAttribute[modelTmp,"InitialConditions",DeleteCases[model["InitialConditions"],r_Rule/;!MemberQ[modelTmp["Species"],r[[1]]]&&!MemberQ[modelTmp["Fluxes"],r[[1]]]],"Sloppy"->True];
	setModelAttribute[modelTmp,"Constraints",DeleteCases[model["Constraints"],r_Rule/;!MemberQ[modelTmp["Fluxes"],r[[1]]]],"Sloppy"->True];
	setModelAttribute[modelTmp,"CustomRateLaws",DeleteCases[model["CustomRateLaws"],r_Rule/;!MemberQ[modelTmp["Fluxes"],r[[1]]]],"Sloppy"->True];
	setModelAttribute[modelTmp,"CustomODE",model["CustomODE"],"Sloppy"->True];
	setModelAttribute[modelTmp,"GPR",DeleteCases[#,pat:(p_protein->_)/;Count[#,p,\[Infinity]]==1]&@DeleteCases[model["GPR"]/.Thread[(rxnIDs/.flux_v:>getID[flux])->False],pat:(False->_)],"Sloppy"->True];
	setModelAttribute[modelTmp,"ElementalComposition",DeleteCases[model["ElementalComposition"],r_Rule/;!MemberQ[modelTmp["Species"],r[[1]]]],"Sloppy"->True];
	(*FIX ME!*)
	fixIDs=Union[getID/@modelTmp["Fluxes"],getID/@Union[Cases[modelTmp["CustomRateLaws"][[All,2]],$MASS$parametersPattern,\[Infinity]]]];
	setModelAttribute[modelTmp,"Parameters",Cases[model["Parameters"],r_Rule/;MatchQ[r[[1]],_parameter]||MemberQ[fixIDs,getID@r[[1]]]||MatchQ[r[[1]],$MASS$speciesPattern]],"Sloppy"->True];
	setModelAttribute[modelTmp,"BoundaryConditions",Select[model["BoundaryConditions"],MemberQ[modelTmp["Species"],#]&],"Sloppy"->True];
	setModelAttribute[modelTmp,"Constant",Select[model["Constant"],MemberQ[modelTmp["Species"],#]&],"Sloppy"->True];
	setModelAttribute[modelTmp,"UnitChecking",model["UnitChecking"],"Sloppy"->True];
	setModelAttribute[modelTmp,"Objective",model["Objective"],"Sloppy"->True];
	modelTmp
];
deleteReactions[model_MASSmodel,regex_RegularExpression]:=deleteReactions[model,Select[getID/@model["Fluxes"],StringMatchQ[#,regex]&]];
def:deleteReactions[___]:=(Message[Toolbox::badargs,deleteReactions,Defer@def];Abort[])
Protect[deleteReactions];

Unprotect[deleteReaction];
deleteReaction[model_MASSmodel,rxn_reaction]:=deleteReactions[model,{getID@rxn}]
deleteReaction[model_MASSmodel,rxnID:(_String|_v)]:=deleteReactions[model,{rxnID}]
def:deleteReaction[___]:=(Message[Toolbox::badargs,deleteReaction,Defer@def];Abort[])
Protect[deleteReaction];


Unprotect[deleteGenes];
deleteGenes::notexists="Gene(s) `1` does(do) not exist in model `2`";
deleteGenes[model_MASSmodel,{}]:=model
deleteGenes[model_MASSmodel,geneIDs:{_String..}]:=deleteGenes[model,gene/@geneIDs]
deleteGenes[model_MASSmodel,genes:{_gene..}]:=Module[{newModel,gpr,tmp,affectedReactions,newGPR,compl},
	If[(compl=Complement[genes,model["Genes"]])!={},Message[deleteGenes::notexists,getID/@compl,model["ID"]];Abort[];];
	newModel=model;
	gpr=newModel["GPR"];
	tmp=#1/.{Sequence@@Cases[#1/.#2,p:(_->False)],Sequence@@#2}&[gpr,Thread[Rule[genes,False]]];
	affectedReactions=Union@Cases[tmp,p:(_String->False)][[All,1]];
	newGPR=DeleteCases[tmp,p:(_->False)];
	newModel=deleteReactions[newModel,affectedReactions];
	setModelAttribute[newModel,"GPR",newGPR];
	newModel
];
def:deleteGenes[___]:=(Message[Toolbox::badargs,deleteGenes,Defer@def];Abort[])
Protect[deleteGenes];

Unprotect[deleteGene];
deleteGene[model_MASSmodel,g_gene]:=deleteGenes[model,{g}]
def:deleteGene[___]:=(Message[Toolbox::badargs,deleteGene,Defer@def];Abort[])
Protect[deleteGene];


Unprotect[deleteProteins];
deleteProteins::notexists="Proteins(s) `1` does(do) not exist in model `2`";
deleteProteins[model_MASSmodel,proteins:{_protein..}]:=Module[{newModel,gpr,tmp,affectedReactions,newGPR,compl},
	If[(compl=Complement[proteins,model["Proteins"]])!={},Message[deleteProteins::notexists,getID/@compl,model["ID"]];Abort[];];
	newModel=model;
	gpr=newModel["GPR"];
	tmp=gpr/.Thread[Rule[proteins,False]];
	affectedReactions=Union@Cases[tmp,p:(_String->False)][[All,1]];
	newGPR=DeleteCases[tmp,r_Rule/;MemberQ[r,False]];
	newModel=deleteReactions[newModel,affectedReactions];
	setModelAttribute[newModel,"GPR",newGPR];
	newModel
];
def:deleteProteins[___]:=(Message[Toolbox::badargs,deleteProteins,Defer@def];Abort[])
Protect[deleteProteins];

Unprotect[deleteProtein];
deleteProtein[model_MASSmodel,p_protein]:=deleteProteins[model,{p}]
def:deleteProtein[___]:=(Message[Toolbox::badargs,deleteProtein,Defer@def];Abort[])
Protect[deleteProtein];


Unprotect[addColumn];
addColumn::usage="addColumn[matrix, column] appends column to matrix. Adjusts shape of matrix by zero padding in order to accomodate column.";
addColumn[mat_?MatrixQ,col:{_?AtomQ..}]:=Module[{nRows,nCols},
	{nRows,nCols}=Dimensions[mat];
	Transpose[Append[Transpose[PadRight[mat,{Length[col],Dimensions[mat][[2]]}]],col]]
];
def:addColumn[___]:=(Message[Toolbox::badargs,addColumn,Defer@def];Abort[])
Protect[addColumn];


Unprotect[addReaction];
addReaction::exists = "Reaction `` already exists in model `2`";
addReaction[model_,rxn_?reactionQ] :=
    Module[ {cmpdsNotYetInModel,pos,newColumn,numSubstr,tmpStoich,modelTmp,constr},
        modelTmp = model;
        If[ MemberQ[getID/@model["Fluxes"],getID[rxn]],
            Message[addReaction::exists,getID[rxn],model["ID"]];
            Abort[];
        ];
        newColumn = Table[0,{Length[model]}];
        cmpdsNotYetInModel = {};
        numSubstr = Length[getSubstrates[rxn]];
        tmpStoich = Join[-1*#[[1;;numSubstr]],#[[numSubstr+1;;]]]&[getStoichiometry[rxn]];
		
        Do[
			pos=Quiet@Check[Position[model["Species"],elem[[1]],1][[1,1]],None,Part::partw];
			If[IntegerQ[pos],
				newColumn[[pos]] = elem[[2]],
				AppendTo[newColumn,elem[[2]]];
				AppendTo[cmpdsNotYetInModel,elem[[1]]]
			];
        ,{elem,Thread[List[getCompounds[rxn],tmpStoich]]}];
        setModelAttribute[modelTmp,"Stoichiometry",addColumn[model["Stoichiometry"],newColumn]];
        setModelAttribute[modelTmp,"Species",Join[model["Species"],cmpdsNotYetInModel]];
        setModelAttribute[modelTmp,"Fluxes",Append[model["Fluxes"],getID[rxn]]];
        If[ reversibleQ[rxn],
            setModelAttribute[modelTmp,"ReversibleColumnIndices",Append[model["ReversibleColumnIndices"],Dimensions[model][[2]]+1]]
        ];
        constr = Switch[{getSubstrates[rxn],getProducts[rxn],reversibleQ[rxn]},{{__},{__},False},{0,\[Infinity]},{{},{__},True},{-\[Infinity],0},{{__},{},True},{0,\[Infinity]},{{},{__},False},{0,0},{{__},{},False},{0,\[Infinity]},_,False];
        If[ MatchQ[constr,{_,_}],
            setModelAttribute[modelTmp,"Constraints",Append[model["Constraints"],getID[rxn]->constr]]
        ];
        modelTmp
    ];
def:addReaction[___] :=
    (Message[Toolbox::badargs,addReaction,Defer@def];
     Abort[])
Protect[addReaction];

Unprotect[addReactions];
addReactions[model_MASSmodel,rxns:{_?reactionQ..}]:=Fold[addReaction,model,rxns];
def:addReactions[___]:=(Message[Toolbox::badargs,addReactions,Defer@def];Abort[])
Protect[addReactions];


Unprotect[deleteIndicesKeepConsistent];
deleteIndicesKeepConsistent::usage="Remove indices from a list of indices and change the resulting list of indices appropriately."
deleteIndicesKeepConsistent[indices_List,indices2delete_List]:=Fold[DeleteCases[#1,#2]/.i_Integer/;i>#2:>i-1&,Union@Sort[indices],Union@Sort[indices2delete]]
def:deleteIndicesKeepConsistent[___]:=(Message[Toolbox::badargs,deleteIndicesKeepConsistent,Defer@def];Abort[])
Protect[deleteIndicesKeepConsistent];


Unprotect[deleteSpecies];
deleteSpecies::notexists="species `1` does not exists in model `2`";
deleteSpecies[model_MASSmodel,met:$MASS$speciesPattern]:=Module[{modelTmp,pos,newMatrix,zeroColumns},
	modelTmp=model;
	pos=Position[model["Species"],met,1];
	If[pos==={},Message[deleteSpecies::notexists,met,model["ID"]];Abort[]];
	newMatrix=Delete[model["Stoichiometry"],pos];
	zeroColumns=Position[Transpose[newMatrix],row_List/;Union[row]==={0}];
	If[zeroColumns!={},
		newMatrix=Transpose[Delete[Transpose[newMatrix],zeroColumns]];
		setModelAttribute[modelTmp,"Fluxes",Delete[model["Fluxes"],zeroColumns]];
		setModelAttribute[modelTmp,"ReversibleColumnIndices",deleteIndicesKeepConsistent[model["ReversibleColumnIndices"],Flatten[zeroColumns]]];
	];
	setModelAttribute[modelTmp,"Stoichiometry",newMatrix];
	setModelAttribute[modelTmp,"Species",Delete[model["Species"],pos]];
	setModelAttribute[modelTmp,"InitialConditions",DeleteCases[model["InitialConditions"],r_Rule/;MemberQ[Append[model["Fluxes"][[zeroColumns]],met],r[[1]]]]];
	setModelAttribute[modelTmp,"Constraints",DeleteCases[model["Constraints"],r_Rule/;MemberQ[Append[model["Fluxes"][[zeroColumns]],met],r[[1]]]]];
	modelTmp
];
deleteSpecies[model_MASSmodel,{}]:=model
deleteSpecies[model_MASSmodel,mets:{$MASS$speciesPattern..}]:=Fold[deleteSpecies,model,mets]
def:deleteSpecies[___]:=(Message[Toolbox::badargs,deleteSpecies,Defer@def];Abort[])
Protect[deleteSpecies];


Unprotect[stoich2reactionList];
stoich2reactionList::usage="stoich2reactionList[stoich_?MatrixQ,compounds_List,fluxes_List,revColIndices:({_Integer..}|{})] generates a list of reactions using the provided stoichiometry matrix, compounds, and reaction IDs. The fourth argument (revColIndices) specifies the columns of the stoichiometry matrix that correspond to reversible reactions.";
stoich2reactionList[stoich_?MatrixQ,compounds_List,fluxes_List,revColIndices:({_Integer..}|{})]:=MapThread[stoichColumn2reaction[#,compounds,#2,#3]&,{Transpose@stoich,fluxes/.flux_v:>getID[flux],Table[If[MemberQ[revColIndices,i],True,False],{i,1,Length[Transpose@stoich]}]}]
stoich2reactionList[{},{},{},{}]:={}
def:stoich2reactionList[___]:=(Message[Toolbox::badargs,stoich2reactionList,Defer@def];Abort[])
Protect[stoich2reactionList];


Unprotect[stoichColumn2reaction];
stoichColumn2reaction[column_List,variables_,reactionID_,revQ_:True]:=Block[{substrPos,prodPos},
substrPos=Flatten[Position[Normal[#],coeff_/;coeff<0]]&[column];
prodPos=Flatten[Position[Normal[#],coeff_/;coeff>0]]&[column];
reaction[reactionID,variables[[substrPos]],variables[[prodPos]],Abs[Normal@column[[Join[substrPos,prodPos]]]],revQ]
];
stoichColumn2reaction[column_SparseArray,variables_,reactionID_,revQ_:True]:=Block[{arules,cmpds,stoich,neg,pos},
arules=ArrayRules[column][[;;-2]];
cmpds=variables[[arules[[All,1,1]]]];
stoich=arules[[All,2]];
neg=Negative[stoich];
pos=Positive[stoich];
reaction[reactionID,Pick[cmpds,neg],Pick[cmpds,pos],Abs[Join[Pick[stoich,neg],Pick[stoich,pos]]],revQ]
];
def:stoichColumn2reaction[___]:=(Message[Toolbox::badargs,stoichColumn2reaction,Defer@def];Abort[])
Protect[stoichColumn2reaction];


Unprotect[reactionList2model];
reactionList2model::usage="reactionList2model[reactionList:{HoldForm[_reaction]..}, opts___] constructs a MASSmodel given a list of reactions. Options are passed on to constructModel.";
reactionList2model::autoCatalyticRxn="So far, the MASS toolbox does not support autocatalytic reactions. Reaction `1` seems to be autocatalytic.";
Options[reactionList2model]=Options[constructModel];
reactionList2model[reactionList:{_reaction...},opts:OptionsPattern[]]:=Block[{mapping,mat,substrates,products,rows,tmpCoeff,coeff,irrev,autocatalyticIntersection,autocatalyicPos,id,customRateLaws},
	mapping=Thread[Rule[#,Range[1,Length[#]]]]&@Union[Cases[reactionList,$MASS$speciesPattern,\[Infinity]]];
	mat=Table[0,{i,1,Length[mapping]},{j,1,Length[reactionList]}];
	customRateLaws={};
	Do[
		substrates=getSubstrates[reactionList[[col]]];
		products=getProducts[reactionList[[col]]];
		autocatalyticIntersection=Intersection[substrates,products];

		If[autocatalyticIntersection=!={},
			Message[reactionList2model::autoCatalyticRxn,getID[reactionList[[col]]]];Abort[];
			(*id=getID[reactionList[[col]]];
			AppendTo[customRateLaws,id->k2keq[rateconst[id,True]*Times@@Thread[Power[#[t]&/@substrates,getSubstrStoich[reactionList[[col]]]]]-If[reversibleQ[reactionList[[col]]],rateconst[id,False]*Times@@Thread[Power[#[t]&/@products,getProdStoich[reactionList[[col]]]]],0]]]*)
		];
		autocatalyicPos=Position[Join[substrates,products],Alternatives@@autocatalyticIntersection];
		rows=Delete[Join[substrates,products],autocatalyicPos]/.Dispatch[mapping];

		substrates=Complement[substrates,autocatalyticIntersection];
		products=Complement[products,autocatalyticIntersection];
		tmpCoeff=Delete[getStoichiometry[reactionList[[col]]],autocatalyicPos];
		coeff=Join[-1*tmpCoeff[[1;;Length[substrates]]],tmpCoeff[[Length[substrates]+1;;]]];

		Do[mat[[rows[[r]],col]]=coeff[[r]],{r,1,Length[rows]}];

	,{col,1,Length[reactionList]}
	];
	
	irrev=getID/@Cases[reactionList,r_reaction/;!reversibleQ[r]];
	Return[constructModel[mat/.{}->{{}},mapping[[All,1]],getID/@reactionList,"Irreversible"->irrev,"CustomRateLaws"->updateRules[customRateLaws,OptionValue["CustomRateLaws"]],Sequence@@FilterRules[List[opts],Except["CustomRateLaws"]]]]
];
def:reactionList2model[___]:=(Message[Toolbox::badargs,reactionList2model,Defer@def];Abort[])
Protect[reactionList2model];


Unprotect[subModel];
subModel[model_MASSmodel,rxnIDs:{(_String|_v)..}]:=deleteReactions[model,Complement[getID/@model["Fluxes"],rxnIDs/.flux_v:>getID[flux]]];
def:subModel[___]:=(Message[Toolbox::badargs,subModel,Defer@def];Abort[])
Unprotect[subModel];


(* ::Subsection:: *)
(*QC/QA*)


Unprotect[elementallyBalancedQ];
Options[elementallyBalancedQ]={"ElementalComposition"->{},"RemoveExchanges"->True};
elementallyBalancedQ::notBalanced="The following reactions are not balanced: `1`.";
elementallyBalancedQ[model_MASSmodel,opts:OptionsPattern[]]:=Module[{balancing,exclude},
If[OptionValue["RemoveExchanges"],
exclude=model["Exchanges"];,
exclude={};
];
balancing=Thread[Rule[model["Reactions"],Expand/@((model["Species"]/.Dispatch[updateRules[model["ElementalComposition"],OptionValue["ElementalComposition"]]]).model)]];
balancing=DeleteCases[balancing,r_Rule/;MemberQ[exclude,r[[1]]]];
If[
Total[balancing[[All,2]]]===0,
True,
Message[elementallyBalancedQ::notBalanced,SlideView[Rule@@@Cases[balancing,r_Rule/;r[[2]]=!=0]]];False]
];
def:elementallyBalancedQ[___]:=(Message[Toolbox::badargs,elementallyBalancedQ,Defer@def];Abort[])
Protect[elementallyBalancedQ];


(*Gevorgyan,A.,Poolman,M.G.,& Fell,D.A.(2008).Detection of stoichiometric inconsistencies in biomolecular models Bioinformatics (Oxford,England),24(19),2245\[Dash]2251. doi:10.1093/bioinformatics/btn425*)
Unprotect[stoichiometricallyConsistentQ];
Options[stoichiometricallyConsistentQ]={"Solver"->LinearProgramming};
stoichiometricallyConsistentQ[m_MASSmodel,opts:OptionsPattern[]]:=stoichiometricallyConsistentQ[deleteReactions[m,getID/@m["Exchanges"]]["Stoichiometry"],opts]
stoichiometricallyConsistentQ[s_?MatrixQ,opts:OptionsPattern[]]:=Quiet[Check[OptionValue["Solver"][Array[1&,Length[s]],Transpose@s,Table[{0,0},{Length[Transpose@s]}],Array[1&,Length[s]]],False,{LinearProgramming::lpsnf}]/.{_?NumberQ..}:>True,{LinearProgramming::lpsnf}]
def:stoichiometricallyConsistentQ[___]:=(Message[Toolbox::badargs,stoichiometricallyConsistentQ,Defer@def];Abort[])
Protect[stoichiometricallyConsistentQ];


(*Gevorgyan,A.,Poolman,M.G.,& Fell,D.A.(2008).Detection of stoichiometric inconsistencies in biomolecular models Bioinformatics (Oxford,England),24(19),2245\[Dash]2251. doi:10.1093/bioinformatics/btn425*)
Unprotect[detectUnconservedMetabolites];
detectUnconservedMetabolites[m_MASSmodel]:=detectUnconservedMetabolites[#["Stoichiometry"],#["Species"]]&[deleteReactions[m,getID/@m["Exchanges"]]]
detectUnconservedMetabolites[s_?MatrixQ,compounds_List]:=Module[{milpResult},
milpResult=LinearProgramming[-1*Join[Array[0&,Length[#]],Array[1&,Length[#]]],
ArrayFlatten[{{Transpose@#,Table[0,{#1},{#2}]&[Sequence@@Dimensions[Transpose@#]]},{IdentityMatrix[Length[#]],-1IdentityMatrix[Length[#]]}}],
Join[Table[{0,0},{Length[Transpose@#]}],Table[{0,1},{Length[#]}]],
Join[Table[{0,\[Infinity]},{Length[#]}],Table[{0,1},{Length[#]}]],
Join[Table[Reals,{Length[#]}],Table[Integers,{Length[#]}]]
]&[s];
Cases[Thread[Rule[compounds,milpResult[[1;;Length[s]]]]],r_Rule/;r[[2]]<1][[All,1]]
];
def:detectUnconservedMetabolites[___]:=(Message[Toolbox::badargs,detectUnconservedMetabolites,Defer@def];Abort[])
Protect[detectUnconservedMetabolites];


(* ::Subsection:: *)
(*End*)


End[];

(#::usage=StringReplace[ToString[#],RegularExpression["^.*`"]->""]<>" is a model attribute. Use it like model[\""<>StringReplace[ToString[#],RegularExpression["^.*`"]->""]<>"\"].")&[Symbol["Toolbox`"<>ToString[#]]]&/@(If[Quiet@MatchQ[Context[#],_Context],#,Unevaluated[Sequence[]]]&/@Toolbox`Private`$MASSmodel$Attributes)

Type::usage="Type is an option for getJacobian that specifies which type of Jacobian matrix to generate (either \"Concentration\" or \"Flux\")."

Strategy::usage="Strategy is an option for findSteadyState that specifies if Newton's method or forward integration should be used (either FindRoot or simulate)."

ReversibleDelimiter::usage="ReversibleDelimiter is an option for str2mass.";

IrreversibleDelimiter::usage="ReversibleDelimiter is an option for str2mass.";

Tooltipped::usage="Tooltipped is a boolean option for toolbox plots that specifies if tooltip information should be shown when the mouse pointer is over certain plot elements.";

Solver::usage="Solver is an option for optimization related functions that specifies the solver backend to be used for the solution process."

ReactionData::usage="ReactionData is an option for drawPathway.";

MetaboliteData::usage="MetaboliteData is an option for drawPathway.";

Legend::usage="Legend is an option for many plotting functions, e.g., plotSimulation.";
