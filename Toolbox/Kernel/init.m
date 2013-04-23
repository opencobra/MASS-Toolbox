(* ::Package:: *)

(* ::Section:: *)
(*M9 hacks*)


If[$VersionNumber>8,SetOptions[Manipulate,TrackedSymbols:>True]]
If[$VersionNumber>=9,SetOptions[NDSolve,Method->{"EquationSimplification"->"Residual"}]];


(* ::Section:: *)
(*Third party stuff*)


cheatSheet[]:=TableForm[{{"Evaluate in place","Shift + Cmd + Return"},{"Convert to StandardForm","Shift + Cmd + N"},{"Convert to InputForm","Shift + Cmd + I"}}]


GurobiML::notinstalled="GurobiML seems to be not installed. Advanced LP/MILP/QP capabilities will be limited. GurobiML can be obtained from https://github.com/phantomas1234/GurobiML (very experimental at the moment!).";


AutoCollapse[]:=(If[$FrontEnd=!=$Failed,SelectionMove[EvaluationNotebook[],All,GeneratedCell];FrontEndTokenExecute["SelectionCloseUnselectedCells"]])


(* ::Section:: *)
(*Load defintions*)


If[$FrontEnd=!=Null,
	Monitor[ReleaseHold[#],Column[{progtext,If[$FrontEnd=!=Null,ProgressIndicator[prog,{1,22}],prog]}]],
	ReleaseHold[#]
]&@Hold[
	prog=0;
	progtext="Loading MathSBML ...";
	(* Mathematica Init File *)
	MathSBML::notinstalled="MathSBML seems to be not installed. SBML import/export capabilities will be limited. MathSBML can be obtained from http://sbml.org/Software/MathSBML";
	stubStream=OpenWrite[];bkupoutput=$Output;$Output={stubStream};
	Block[{$ContextPath},
		Quiet[Check[Needs["MathSBML`"],$Failed(*Message[MathSBML::notinstalled]*),{Get::noopen,Needs::nocont}]];
	];
	Quiet[Check[Remove[reaction,t,name,Stoichiometry],None,{Remove::rmptc}],{Remove::rmptc}];
	$Output=bkupoutput;Close[stubStream];
	Quiet[Check[Remove[stubStream,bkupoutput],None,{Remove::rmptc}],{Remove::rmptc}];
	prog++;
	
	progtext="Loading GurobiML ...";
	Quiet@Needs["GurobiML`"];prog++;

	progtext="Loading AutomaticUnits ...";
	Unprotect[BeginPackage];
	BeginPackage["PhysicalConstants`", "Units`"] = BeginPackage["PhysicalConstants`", "AutomaticUnits`"];
	Quiet[<<PhysicalConstants`;];
	(*Unprotect[PhysicalConstants`Private`Mole];*)
	PhysicalConstants`Private`Mole=AutomaticUnits`Unit[1,"Mole"];
	BeginPackage["PhysicalConstants`", "Units`"] =.;
	Protect[BeginPackage];
	progtext="Loading AutomaticUnits ...";Needs["AutomaticUnits`"];prog++;
	
	progtext="Loading InterpolatingFunctionAnatomy ...";Needs["DifferentialEquations`InterpolatingFunctionAnatomy`"];prog++;
	progtext="XML ...";Needs["XML`"];prog++;
	progtext="Loading JLink ...";Needs["JLink`"];prog++;
	
	BeginPackage["Toolbox`"];
	Needs["AutomaticUnits`"];
	progtext="Loading Config ...";Get["Toolbox`Config`"];prog++;
	progtext="Loading Usage strings ...";Get["Toolbox`UsageStrings`"];prog++;
	progtext="Loading Utilities ...";Get["Toolbox`Util`"];prog++;
	progtext="Loading Types ...";Get["Toolbox`Types`"];prog++;
	progtext="Loading Core ...";Get["Toolbox`Core`"];prog++;
	progtext="Loading IO ...";Get["Toolbox`IO`"];prog++;
	progtext="Loading COBRA ...";Get["Toolbox`COBRA`"];prog++;
	progtext="Loading Chemoinformatics ...";Get["Toolbox`Chemoinformatics`"];prog++;
	progtext="Loading Visualization ...";Get["Toolbox`Visualization`"];prog++;
	progtext="Loading Regulation ...";Get["Toolbox`Regulation`"];prog++;
	progtext="Loading Sensitivity Analysis ...";Get["Toolbox`Sensitivity`"];prog++;
	progtext="Loading Thermodynamics ...";Get["Toolbox`Thermodynamics`"];prog++;
	progtext="Loading Network Theory ...";Get["Toolbox`Networks`"];prog++;
	progtext="Loading Simulations ...";Get["Toolbox`Simulations`"];prog++;
	progtext="Loading QCQA ...";Get["Toolbox`QCQA`"];prog++;
	progtext="Loading ExampleData ...";Get["Toolbox`ExampleData`"];prog++;
	EndPackage[];
]


(* ::Section:: *)
(*Backwards compatibility*)


Toolbox`MASS`metabolite := metabolite
Toolbox`MASS`v := v
Toolbox`MASS`Keq := Keq
Toolbox`MASS`rateconst := rateconst
