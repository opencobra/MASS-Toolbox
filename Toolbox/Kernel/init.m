(* ::Package:: *)

(* ::Section:: *)
(*M9 hacks*)


If[$VersionNumber>8,SetOptions[Manipulate,TrackedSymbols:>True]]
If[$VersionNumber>=9,SetOptions[NDSolve,Method->{"EquationSimplification"->"Residual"}]];


(* ::Section:: *)
(*Third party stuff*)


cheatSheet[]:=TableForm[{{"Evaluate in place","Shift + Cmd + Return"},{"Convert to StandardForm","Shift + Cmd + N"},{"Convert to InputForm","Shift + Cmd + I"}}]


GurobiML::notinstalled="GurobiML seems to be not installed. Advanced LP/MILP/QP capabilities will be limited. GurobiML can be obtained from https://github.com/phantomas1234/GurobiML (very experimental at the moment!).";


(* ::Section:: *)
(*Load defintions*)


(*Column[{icon,progtext,If[$FrontEnd=!=Null,ProgressIndicator[prog,{1,22}],prog]}]*)


Module[{licenseInfo,icon,delay,stubStream,bkupoutput,prog,progtext},
licenseInfo="Copyright (c) 2013, Regents of the University of California
All rights reserved.
Evaluate $ToolboxLicense for more information";
progtext="";
prog=0;
icon=Show[Import[FileNameJoin[{DirectoryName[$InputFileName],"MASS-Toolbox-Logo.m"}]],ImageSize->150];
delay=Pause[.03]&;
If[$FrontEnd=!=Null&&$VersionNumber>=8,
	Monitor[ReleaseHold[#],Grid[{{Blur[icon,(*Log[23-prog]*)Max[{15-prog,0}]],progtext},{licenseInfo,SpanFromLeft}}]],
	Monitor[ReleaseHold[#],Column[{progtext,licenseInfo}]]
]&@Hold[
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
	Quiet@Needs["GurobiML`"];Quiet@ParallelNeeds["GurobiML`"];prog++;delay[];

	progtext="Loading AutomaticUnits ...";
	Unprotect[BeginPackage];
	BeginPackage["PhysicalConstants`", "Units`"] = BeginPackage["PhysicalConstants`", "AutomaticUnits`"];
	Quiet[<<PhysicalConstants`;];
	(*Unprotect[PhysicalConstants`Private`Mole];*)
	PhysicalConstants`Private`Mole=AutomaticUnits`Unit[1,"Mole"];
	BeginPackage["PhysicalConstants`", "Units`"] =.;
	Protect[BeginPackage];
	progtext="Loading AutomaticUnits ...";Needs["AutomaticUnits`"];prog++;delay[];
	
	progtext="Loading InterpolatingFunctionAnatomy ...";Needs["DifferentialEquations`InterpolatingFunctionAnatomy`"];prog++;delay[];
	progtext="XML ...";Needs["XML`"];prog++;delay[];
	progtext="Loading JLink ...";Needs["JLink`"];prog++;delay[];
	
	BeginPackage["Toolbox`"];
	Needs["AutomaticUnits`"];
	progtext="Loading Config ...";Get["Toolbox`Config`"];prog++;delay[];
	progtext="Loading Usage strings ...";Get["Toolbox`UsageStrings`"];prog++;delay[];
	progtext="Loading Utilities ...";Get["Toolbox`Util`"];prog++;delay[];
	progtext="Loading Types ...";Get["Toolbox`Types`"];prog++;delay[];
	progtext="Loading Core ...";Get["Toolbox`Core`"];prog++;delay[];
	progtext="Loading IO ...";Get["Toolbox`IO`"];prog++;delay[];
	progtext="Loading COBRA ...";Get["Toolbox`COBRA`"];prog++;delay[];
	progtext="Loading Chemoinformatics ...";Get["Toolbox`Chemoinformatics`"];prog++;delay[];
	progtext="Loading Visualization ...";Get["Toolbox`Visualization`"];prog++;delay[];
	progtext="Loading Regulation ...";Get["Toolbox`Regulation`"];prog++;delay[];
	progtext="Loading Sensitivity Analysis ...";Get["Toolbox`Sensitivity`"];prog++;delay[];
	progtext="Loading Thermodynamics ...";Get["Toolbox`Thermodynamics`"];prog++;delay[];
	progtext="Loading Network Theory ...";Get["Toolbox`Networks`"];prog++;delay[];
	progtext="Loading Simulations ...";Get["Toolbox`Simulations`"];prog++;delay[];
	progtext="Loading QCQA ...";Get["Toolbox`QCQA`"];prog++;delay[];
	progtext="Loading ExampleData ...";Get["Toolbox`ExampleData`"];prog++;delay[];
	EndPackage[];
]
]


(* ::Section:: *)
(*Backwards compatibility*)


Toolbox`MASS`metabolite := metabolite
Toolbox`MASS`v := v
Toolbox`MASS`Keq := Keq
Toolbox`MASS`rateconst := rateconst

MASSToolbox`MASS`metabolite := metabolite
MASSToolbox`MASS`v := v
MASSToolbox`MASS`Keq := Keq
MASSToolbox`MASS`rateconst := rateconst

MASSToolbox`metabolite := metabolite
MASSToolbox`v := v
MASSToolbox`Keq := Keq
MASSToolbox`rateconst := rateconst
