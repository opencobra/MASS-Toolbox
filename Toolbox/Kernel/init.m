(* ::Package:: *)

(* ::Section:: *)
(*Handle MathSBML*)


(* Mathematica Init File *)

MathSBML::notinstalled="MathSBML seems to be not installed. SBML import/export capabilities will be limited. MathSBML can be obtained from http://sbml.org/Software/MathSBML";
stubStream=OpenWrite[];bkupoutput=$Output;$Output={stubStream};
Block[{$ContextPath},
Quiet[Check[Needs["MathSBML`"],$Failed(*Message[MathSBML::notinstalled]*),{Get::noopen,Needs::nocont}]];];
Quiet[Check[Remove[reaction,t,name,Stoichiometry],None,{Remove::rmptc}],{Remove::rmptc}];
$Output=bkupoutput;Close[stubStream];
Quiet[Check[Remove[stubStream,bkupoutput],None,{Remove::rmptc}],{Remove::rmptc}];


(* ::Section:: *)
(*Handle GurobiML*)


Quiet@Needs["GurobiML`"]


(* ::Section:: *)
(*Handle PhysicalConstants vs. AutomaticUnits *)


(*If[$VersionNumber<9,
	Unprotect[BeginPackage];
	BeginPackage["PhysicalConstants`", "Units`"] = BeginPackage["PhysicalConstants`", "AutomaticUnits`"];
	Quiet[<<PhysicalConstants`;];
	(*Unprotect[PhysicalConstants`Private`Mole];*)
	PhysicalConstants`Private`Mole=AutomaticUnits`Unit[1,"Mole"];
	BeginPackage["PhysicalConstants`", "Units`"] =.;
	Protect[BeginPackage];
]*)
Unprotect[BeginPackage];
BeginPackage["PhysicalConstants`", "Units`"] = BeginPackage["PhysicalConstants`", "AutomaticUnits`"];
Quiet[<<PhysicalConstants`;];
(*Unprotect[PhysicalConstants`Private`Mole];*)
PhysicalConstants`Private`Mole=AutomaticUnits`Unit[1,"Mole"];
BeginPackage["PhysicalConstants`", "Units`"] =.;
Protect[BeginPackage];


(* ::Section:: *)
(*M9 hacks*)


If[$VersionNumber>8,SetOptions[Manipulate,TrackedSymbols:>True]]
If[$VersionNumber>=9,SetOptions[NDSolve,Method->{"EquationSimplification"->"Residual"}]];


(* ::Section:: *)
(*Begin package*)


BeginPackage["Toolbox`"]


(* ::Section:: *)
(*Third party stuff*)


cheatSheet[]:=TableForm[{{"Evaluate in place","Shift + Cmd + Return"},{"Convert to StandardForm","Shift + Cmd + N"},{"Convert to InputForm","Shift + Cmd + I"}}]


GurobiML::notinstalled="GurobiML seems to be not installed. Advanced LP/MILP/QP capabilities will be limited. GurobiML can be obtained from https://github.com/phantomas1234/GurobiML (very experimental at the moment!).";


Needs["DifferentialEquations`InterpolatingFunctionAnatomy`"]
(*Quiet[Check[
	Needs["GurobiML`"],
	Message[GurobiML::notinstalled],
	{Get::noopen,Needs::nocont}],
{Get::noopen,Needs::nocont}];*)

Needs["XML`"]
Needs["JLink`"]
(*If[$VersionNumber<9,
	Needs["AutomaticUnits`"]
]*)
Needs["AutomaticUnits`"]


(* ::Section:: *)
(*Load defintions*)


Get["Toolbox`Config`"]
Get["Toolbox`Util`"]
Get["Toolbox`MASS`"]
Get["Toolbox`IO`"]
Get["Toolbox`COBRA`"]
Get["Toolbox`Chemoinformatics`"]
Get["Toolbox`Visualization`"]
Get["Toolbox`Regulation`"]
Get["Toolbox`Sensitivity`"]
Get["Toolbox`Thermodynamics`"]
Get["Toolbox`Networks`"]
Get["Toolbox`Simulations`"]
Get["Toolbox`ExampleData`"]


(* ::Section:: *)
(*End package*)


EndPackage[]


AutoCollapse[]:=(If[$FrontEnd=!=$Failed,SelectionMove[EvaluationNotebook[],All,GeneratedCell];
FrontEndTokenExecute["SelectionCloseUnselectedCells"]])


(* ::Section:: *)
(*Backwards compatibility*)


Toolbox`MASS`metabolite := metabolite
Toolbox`MASS`v := v
Toolbox`MASS`Keq := Keq
Toolbox`MASS`rateconst := rateconst
