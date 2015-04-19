(* ::Package:: *)

(* ::Title:: *)
(*Usage strings*)


(* ::Subsection::Closed:: *)
(*Options*)


BoundCatalytic::usage="BoundCatalytic is an option for enzyme that specifies other species that are bound to the enzyme.";

Compartment::usage="Compartment is an option for enzyme that specifies the compartment the enzyme operates in.";

Type::usage="Type is an option for getJacobian that specifies which type of Jacobian matrix to generate (either \"Concentration\" or \"Flux\")."

Strategy::usage="Strategy is an option for findSteadyState that specifies if Newton's method or forward integration should be used (either FindRoot or simulate)."

ReversibleDelimiter::usage="ReversibleDelimiter is an option for str2mass.";

IrreversibleDelimiter::usage="ReversibleDelimiter is an option for str2mass.";

Tooltipped::usage="Tooltipped is a boolean option for toolbox plots that specifies if tooltip information should be shown when the mouse pointer is over certain plot elements.";

Solver::usage="Solver is an option for optimization related functions that specifies the solver backend to be used for the solution process."

ReactionData::usage="ReactionData is an option for drawPathway.";

MetaboliteData::usage="MetaboliteData is an option for drawPathway.";

Legend::usage="Legend is an option for many plotting functions, e.g., plotSimulation.";

Category::usage="Category is an option for optimzation code e.g. GAMSForm or NEOS.";

Output::usage="Output is an option for many functions specifying the amount of detail that should be provided in the results.";

CompoundLabels::usage="CompoundLabels is an option for specifying if compound labels should be included in a pathway visualizations.";

TextLabels::usage="TextLabels is an option for specifying if generic text labels should be included in a pathway visualizations.";

ReactionLabels::usage="ReactionLabels is an option for specifying if reaction labels should be included in a pathway visualizations.";

ParametricSolve::usage="ParametricSolve is an option for specifying that a simulation should be run leaving some parameters unsolved.";

ExactSolve::usage="ExactSolve is an option for specifying that a simulation should be solved exactly, rather than using interpolation.";


(* ::Subsection::Closed:: *)
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


(* ::Subsection::Closed:: *)
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


getSubstrates::usage="getSubstrates[rxn] returns substrates of reaction rxn.";


(* ::Subsection::Closed:: *)
(*Chemoinformatics*)


cxcalc::usage="Provides an interface to ChemAxon's cxcal command-line utility.";


molconvert::usage="molconvert[input, outformat, cmdlineOpts] provides an interface to ChemAxon's molconvert command-line utility.";


drawCompound::usage="Takes a InChI or SMILES description of a compounds and uses openbabel to draw it.";


(* ::Subsection::Closed:: *)
(*COBRA*)


productionEnvelope::usage="productionEnvelope[model, fluxToBeControlled, ...] FIXME";


minspan::usage="minspan[model] calculates the MINSPAN basis for model."


CPLEXForm::usage="CPLEXForm provides the same argument signature as LinearProgramming and returns a optimization problem formulation in cplex lp format."


CPLEXStandalone::usage="CPLEXStandalone provides the same functionality and argument signature as LinearProgramming and can be used as a solver for fba.";


fba::usage="fba[stoichiometry_?MatrixQ, obj_List, colIDs_List, bounds_:{}, OptionsPattern[]] performs flux-balance analysis (FBA) ... An overloaded MASSmodel function exists.";


fva::usage="fva[stoichiometry_?MatrixQ, colIDs_List, bounds_List, opts] performs flux-variability analysis (FVA) on given S.colIDs==0 system. Options include a graphical progressbar. Other options are passed down to the flux-balance routine fba.";


GAMS::usage="Takes an optimization problem defined in the form of Mathematica equations and feeds it to GAMS (General Algebraic Modeling System). The problem definitions follows the argument signature and specifications of Mathematica's own optimization functions. Thus, GAMS can directly be used as a replacement for (N)Maximize, (N)Minimize, FindMinimum, and FindMaximum etc.";


GAMSForm::usage="Takes an optimization problem defined in the form of Mathematica equations and translates it into a GAMS problem formulation.";


GLPKStandalone::usage="GLPKStandalone provides the same functionality and argument signature as LinearProgramming and can be used as a solver for fba.";


gimme::usage="###FIXME###";


GurobiFVA::usage="GurobiFVA[model] performs flux-variability analysis (FVA) on given model. Additional flux bounds can be provided as GurobiFVA[model, {\"rxnID\"->{lb,ub}, ...}]"


model2LinearProgrammingData::usage="model2LinearProgrammingData[model, obj, bounds] returns the necessary data structures (c, m, b, bounds) for LinearProgramming (or other solvers that mimic its argument signature.)";


model2X3::usage="model2X3[model_MASSmodel] builds a string representation of model that can be used by X3."


NEOS::usage="NEOS[problemString, opts] interfaces with the NEOS optimization server. It uses NEOS's python xml-rpc client for the job submission. Alles necessary parameters (e.g. category, solver, inputMethod etc.) can be provided via options.";


parseGAMSoutput::usage="###FIXME###";


reduceModel::usage="reduceModel[model_MASSmodel,bounds_List] performs FVA on provided model and removes reactions that cannot carry flux under the provided conditions."


X3::usage="X3[model_MASSmodel, opts] calculates all extreme pathways for model using X3."


createWarmupPoints::usage="createWarmupPoints[model] will create warmup points for sampling."


ACHRsampler::usage="ACHRsampler[model] will perform Monte Carlo sampling with model."


(* ::Subsection::Closed:: *)
(*Design*)


differentialFVA::usage="";


generateDiffFvaReport::usage="";


(* ::Subsection::Closed:: *)
(*IO*)


biomodel2model::usage="biomodel2model[id_String] imports model with identifier id (B\\d+) from the Biomodels repository at ";


importModel::usage="importModel[path] will import a model and try to convert legacy models to the most current version of the toolbox.";


mat2model::usage="mat2model[path2mat] imports a Matlab .mat file and parses all COBRA models in it."


model2sbml::usage="model2sbml[model_MASSmodel] converts model into an SBML representation (returns a string). Initial conditions and other parameters can be provided as options and take precedence over the model's own definitions.";


sbml2model::usage="sbml2model[path|xml] either takes a path to a SBML file or symbolic XML as inputs and construct a MASSmodel data structure.";


eQuilibratorCompoundData::usage="eQuilibratorCompoundData[query] queries the eQuilibrator database for compound related data. Sample query:

{\"InChI_identifiers\"->{\"InChI=1S/C10H16N5O13P3/c11-8-5-9(13-2-12-8)15(3-14-5)10-7(17)6(16)4(26-10)1-25-30(21,22)28-31(23,24)27-29(18,19)20/h2-4,6-7,10,16-17H,1H2,(H,21,22)(H,23,24)(H2,11,12,13)(H2,18,19,20)/t4-,6-,7-,10-/m1/s1\",\"InChI=1S/C10H15N5O10P2/c11-8-5-9(13-2-12-8)15(3-14-5)10-7(17)6(16)4(24-10)1-23-27(21,22)25-26(18,19)20/h2-4,6-7,10,16-17H,1H2,(H,21,22)(H2,11,12,13)(H2,18,19,20)/t4-,6-,7-,10-/m1/s1\"}}
"


eQuilibratorReactionData::usage="eQuilibratorReactionData[query] queries the eQuilibrator database for compound related data. Sample query:

{\"ionic_strength\"->1.0,\"KEGG_reactions\"->{\"R00002\",\"R00022\"},\"pH\"->7.0}
"


(* ::Subsection::Closed:: *)
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


(* ::Subsection::Closed:: *)
(*Model construction*)


constructModel::usage="constructModel[reactions] constructs a MASSmodel from reactions.";


MASSmodel::usage="MASSmodel is a data structure describing the static content of a metabolic system.";


(* ::Subsection::Closed:: *)
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


getElementalMatrix::usage="getElementalMatrix[model] displays a formatted elemental matrix for the model. Use TableForm->False for the raw matrix.";


stoichiometricallyConsistentQ::usage="Checks the stochiometric consistency of provide matrix or model (see Gevorgyan, A., Poolman, M. G., & Fell, D. A. (2008). Detection of stoichiometric inconsistencies in biomolecular models Bioinformatics (Oxford, England), 24(19), 2245\[Dash]2251. doi:10.1093/bioinformatics/btn425).";




(* ::Subsection::Closed:: *)
(*Chemoinformatics*)


elementalComposition2formula::usage="elementalComposition2formula[{\"C\"->10,\"H\"->16,\"N\"\[Rule]1,\"O\"->13,\"P\"->3}], for example, generate the molecular formula \"H16C10NO13P3\". Pseudo elements, e.g. \"NAD\", are escaped using \"&\".";


formula2elementalComposition::usage="formula2elementalComposition[\"H16C10NO13P3&NAD&\"] translates into the elemental composition rules {\"C\"\[Rule]10,\"H\"\[Rule]16,\"N\"\[Rule]1,\"O\"\[Rule]13,\"P\"\[Rule]3,\"NAD\"\[Rule]1}; &NAD& represents a  pseudo element (see als elementalComposition2formula).";


InChI::usage="Wrapper for an InChI string.";


inchi2elementalComposition::usage="Returns the elemental composition of a InChI string";


inchi2simpleInchi::usage="inchi2simpleInchi[inchi] extracts the main layer of inchi (effectively discarding the stereo-chemistry and other optional layers).";


SMILES::usage="Wrapper for a SMILES string.";


smiles2elementalComposition::usage="Returns the elemental composition of a SMILES string";


(* ::Subsection::Closed:: *)
(*Units*)


adjustUnits::usage="###FIXME###";


stripUnits::usage="stripUnits[exprs] will remove all units (as defined in the Units` package) from expression.";


(* ::Subsection::Closed:: *)
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


(* ::Subsection::Closed:: *)
(*Parameter estimation*)


calcPERC::usage="calcPERC[model, steadystateConc, steadystateFluxes, equilibriumConstants] calculates \"Pseudo-Elementary-Rate-Constants\" for the forward rate constanstants. calcPERC[stoich_, rowIDs_List, columnIDs, steadystateConc, steadystateFluxes, equilibriumConstants] can be uses for the more fundamental data types.";


complementParameters::usage="complementParameters[parameters] complements parameter set by calculating and inserting missing equilibrium (Keq) and rate (k) constants.";


(* ::Subsection::Closed:: *)
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


getSubstrStoich::usage="getSubstrStoich[rxn] returns stoichiometric factors corresponding to substrates of reaction rxn.";


S::usage="S[expression] is a shorthand for getStoichiometry[expression]";


SRed::usage="S[model] is a shorthand for model[\"Stoichiometry\"]";


(* ::Subsection::Closed:: *)
(*Translators*)


k2keq::usage="Shorthand for kRev2keq.";


keq2k::usage="keq2k[expression] replaces all \!\(\*UnderscriptBox[\(K\), \(FluxID\)]\) by  \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]]\)";


kFwd2keq::usage="kFwd2keq[expression] replaces all \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)]\) by \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]\) \!\(\*UnderscriptBox[\(K\), \(FluxID\)]\)";


kRev2keq::usage="kRev2keq[expression] replaces all \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]\) by \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], UnderscriptBox[\(K\), \(FluxID\)]]\)";


(* ::Subsection::Closed:: *)
(*Old*)


(*modalDecomposition::usage="modalDecomposition[jac_, norm_:0, cutoff_:Sqrt[2], removepairs_:1, evalCutOff_:1*^-15] computes the modal decomposition given the Jacobian.  Optional arguments are the norm (default is 0 - no normalization), the cutoff value to for flagging large imaginary components for the eigenvalues, and a decision variable for whether or not to remove complex conjugate pairs (default is 1 = remove complex conjugate pairs). Final option, evalCutOff specifies a cut-off for the eigenvalues - default is 1*^-15 - the modes should be composed of left null space variable interactions.\n\t{ts, modes} = modalDecomposition[rbcjac, 1,1.5,1, 1*^-12]; ";*)


(*reactionFromString::usage="reactionFromString[\"vpfk: atp_c + f6p_c <=> adp_c + fbp_c + h_periplasm\"] will parse the reaction string and return reaction[\"vpfk\", {metabolite[\"atp\", \"c\"], metabolite[\"f6p\", \"c\"]}, {metabolite[\"adp\", \"c\"], metabolite[\"fbp\", \"c\"], metabolite[\"h\", \"periplasm\"]}, {1, 1, 1, 1, 1}, True]";*)


(*setModelAttribute::usage="setModelAttribute[model, attribute, rhs] changes the model's attribute 'in place' to rhs";*)


(*keq2k::usage="keq2k[expression] replaces all \!\(\*UnderscriptBox[\(K\), \(FluxID\)]\) by  \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]]\)";*)


(*k2keq::usage="k2keq[expression] replaces all \!\(\*SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongLeftArrow]\)]\) by \!\(\*FractionBox[SubsuperscriptBox[\(k\), \(FluxID\), \(\[LongRightArrow]\)], UnderscriptBox[\(K\), \(FluxID\)]]\)";*)


(*\[EmptySet]::usage="\[EmptySet] represents a sink/source ... ###FIXME###"*)


(*updateModelAttribute::usage="updateModelAttribute[model, attribute, rhs] update the model's attribute 'in place' with rhs";*)


(* ::Subsection::Closed:: *)
(*Networks*)


gpr2graphs::usage="gpr2graphs[gprRules] transforms gprRules into a network and returns a list of its connected subgraphs.";


model2bipartite::usage="model2bipartite[model] converts model into a bipartite network, i.e., metabolites as well as reactions are represented as nodes.";


pathwaytize::usage="pathwaytize[network, numberOfHighDegreeNodesToTreat, ignoreNodes] attempts to make very dense network visually more appealing by masking high degree nodes (e.g. metabolites like ATP, NADPH, etc.).";


reactions2bipartite::usage="reactions2bipartite[rxns] converts a list of reactions into a bipartite network, i.e., metabolites as well as reactions are represented as nodes.";


(*stoich2bipartite::usage="stoich2bipartite[stoich_?MatrixQ,rxns_List,mets_List] returns a bipartite network representation of the system defined by its stoichiometry and corresponding row (mets) and column (rxns) identifiers. An overloaded MASSmodel version of this function exists also (stoich2bipartite[model_MASSmodel])";*)


(* ::Subsection::Closed:: *)
(*QCQA*)


thermodynamicallyConsistentQ::usage="thermodynamicallyConsistentQ[model] will check the model for thermodynamic consistency.";


qcqa::usage="qcqa[model] will run a series of quality assessment and control tests on model and return a report.";


(* ::Subsection::Closed:: *)
(*Regulation*)


solveEnzymeSteadyStateEquations::usage="solveEnzymeSteadyStateEquations[enzymeModule] will try to find analytical solutions (in terms of parameters and ligand concentrations) for all enzyme forms in module.";


getEnzymeSteadyStateEquations::usage="getEnzymeSteadyStateEquations[enzymeModule] will return the steady-state equations of all enzyme forms in module.";


constructEnzymeModule::usage="constructEnzymeModule[reaction, activatingBindingSites, inhibitingBindingSites, activators, inhibitors] generates an enzyme module that replaces the provided elementary reaction. ###FIXME### More documentation needed.";


correctRatesForBindingSites::usage="###FIXME###";


haldaneRelation::usage="haldaneRelation[rxnID,elementaryRxns] relates the overall equilibrium constant of the enzymatic reaction to the products of ratios of elemenatary rate constants";


KingAltmanPatterns::usage="KingAltmanPatterns[model] generates King-Altman patterns for all enzyme forms in model."


unifyRateConstants::usage="unifyRateConstatns[rates] replaces IDs of the form rxnID$\\d+ with rxnID.";


Mechanism::usage="Option for constructEnzymeModule.";


(* ::Subsection::Closed:: *)
(*Sensitivity*)


calculatePartialVariances::usage="###FIXME###"


calcLinIndependentFreq::usage="calcLinIndependentFreq[dim] returns a list of integer frequencies \[Omega] such that \!\(\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n\)]\)\!\(\*SubscriptBox[\(a\), \(i\)]\)\!\(\*SubscriptBox[\(\[Omega]\), \(i\)]\)\[NotEqual]0 for \!\(\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n\)]\)|a| \[LessEqual] M'+1. So far we can only provide linear independent frequencies upto order M=4 and dimension n=50.";


FASTsimul::usage="FASTsimul[func_Function,searchFunc_Function,parametersOfInterest:{_Rule..},opts:OptionsPattern[]] "


FASTcalcSensitivities::usage="###FIXME###"


(* ::Subsection::Closed:: *)
(*Simulations*)


findSteadyState::usage="findSteadyState[model, opts] tries to find a steady-state for model, either by using Newton's method (Strategy->FindRoot) or forward integration (Strategy->simulate).";


simulate::usage="simulate[model_MASSmodel, opts___] simulates model. simulate[model_MASSmodel,parameters_List,opts___] returns a simulation leaving 'parameters' as the simulation parameters.";


setSimulationParameters::usage="setSimulationParameters[simulation:{metabolites,fluxes,variables},parameterValues:{parameter->value..},model_MASSmodel] substitues the parameter values for parametric functions in the simulation.";


solveSteadyState::usage="solveSteadyState[model_MASSmodel] will attempt to solve for species concentrations assuming that the system is at steady state."


(* ::Subsection::Closed:: *)
(*Thermodynamics*)


calcDeltaG::usage="###FIXME###";


equilibrator2albertyFormat::usage="###FIXME###";


dG2keq::usage="###FIXME###";


keq2dG::usage="###FIXME###";


deltaGzero::usage="###FIXME###";


dG::usage="dG[rxnID] the change in free energy due to a chemical reaction."


dGstd::usage="dG[id] represents the formation energy \[CapitalDelta]G, if id is a metabolite, or the change in free energy due to a chemical reaction under standard conditions"


getConditions::usage="###FIXME###";


is::usage="Ionic strength";


pH::usage="pH";


T::usage="Temperature";


(* ::Subsection:: *)
(*Util*)


intervalOverlap::usage="FIXME!";
intervalGaps::usage="FIXME!";


AutoCollapse::usage="Check out http://mathematica.stackexchange.com/questions/680/how-to-keep-input-cells-hidden-after-evaluating-notebook/683#683"


expandLog::usage="Check out http://mathematica.stackexchange.com/questions/22705/simplify-expressions-with-log/22746#22746.";


expandAllLog::usage="Check http://mathematica.stackexchange.com/questions/22705/simplify-expressions-with-log/22746#22746.";


getReferenceFluxesAndBoundsFromXML::usage="getReferenceFluxesAndBoundsFromXML[path2xml] returns reference fluxe and bounds from files like Ec_iJR904_flux1.xml.gz"


parseJSON::usage="parseJSON[string] parses a JSON object structure. parseJSON[path] reads from path.";


scatterFromDicts::usage="scatterFromDicts[dict, ...] constructs a scatter representation of the data associated with the the common keys of dicts."


updateRules::usage="updateRules[rules, newRules] updates rules with newRules by joinging them. Key-value pairs of which keys are present in newRules are removed from rules prior joining.";


integerChop::usage="integerChop[number] will round real numbers to integers if Round[number] == number.";


query::usage="query[key, listOfRules] will return the corresponding value."(*## ## FIXME ## ##*);


filter::usage="filter[listOfRules, keys] behave like FilterRules with the exception that the filtered rules are returned in the order of keys.";


initializeKernels::usage="initializeKernels[] starts parallel kernels and loads the MASS Toolbox onto all kernels. Load specific kernels with initializeKernels[ker] or initializeKernels[{ker1,ker2,...}]."


updateToolbox::usage="updateToolbox[] searches for the newest release of the MASS Toolbox and downloads it. Use Install->False to prevent automatic installation.";


updateRequired::usage="updateRequired[] returns True if there is a newer release of the MASS Toolbox than the one currently installed.";


(* ::Subsection::Closed:: *)
(*Visualization*)


PlotFunction::usage="PlotFunction is an option to plotSimulation that specifies which Mathematic plotting function to use to visualize the provided time-course data.";


visualizeGPR::usage="Plots GPR association.";


visualizePathways::usage"visualizePathways[bipartiteNetwork] will attempt to layout the bipartite network representation (nodes as well reactions are encoded as nodes) of a metabolic system.";


insetLegend::usage="insetLegend[labels] returns a legend that can be used immediately in a plot, e.g., Plot[Sin[x], {x, 0, 2\[Pi]}, Epilog->insetLegend[{\"sin(x)\"}]]";


legend::usage="legend[labels] draws a legend.";


plotPhasePortrait::usage="Use plotPhasePortrait[simulation:{_Rule..}, opts] or plotPhasePortrait[simulation:{_Rule..}, {t_Symbol, tMin_?NumberQ, tMax_?NumberQ, tStep_:.1}, opts] for plotting phase portraits. If simulation contains more than two variables a GUI is started.";


plotSimulation::usage="plotSimulation[{var -> Inter}] Will plot time course ";


plotTiledPhasePortraits::usage="plotTiledPhasePortraits[simulation:{_Rule..}, opts] plot a tiled array of phase portraits.";


plotFVA::usage="Plot the result of a FVA.";


drawReactionMap::usage="drawReactionMap[reactionPositions] draws a reaction map. The following options are avaliable: {Thickness\[Rule]0.0001, Tooltips\[Rule]False}.";


drawMetaboliteMap::usage="drawMetaboliteMap[metabolitePositions]. The following options are available: {Size\[Rule]10.^-6, Tooltips\[Rule]False}."


drawPathway::usage="drawPathway[metPos, rxnPos, textPos] draws a pathway map."


importBIGGmap::usage="importBIGGmap[path] will import a SVG map from BIGG and return three data structures: (1) the metabolite coordinates, (2) the reaction Bezier curve coordinates, and (3) text labels and their positions."


drawNodeMaps::usage="drawNodeMaps[model,Fluxes->listOfFluxes, Metabolites->listOfMetabolites] will draw node maps for the corresponding metabolites.";
