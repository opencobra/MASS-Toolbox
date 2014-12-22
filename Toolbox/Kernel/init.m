(* ::Package:: *)

(* ::Section:: *)
(*License*)


$ToolboxLicense="Copyright (c) 2013, The Regents of the University of California
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 * Neither the name of the University of California, San Diego (UCSD)
   nor the names of its contributors may be used to endorse or promote
   products derived from this software without specific prior written
   permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."


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


System`$ContextPath = Append[$ContextPath,"Toolbox`Units`"];


Module[{licenseInfo,icon,delay,stubStream,bkupoutput,prog,progtext,names,rules,messageCode},
licenseInfo="Copyright (c) 2013, Regents of the University of California
All rights reserved.
Evaluate $ToolboxLicense for more information";
progtext="";
prog=0;
icon=Show[Import[FileNameJoin[{DirectoryName[$InputFileName],"MASS-Toolbox-Logo.m"}]],ImageSize->150];
delay=Pause[.01]&;
If[$FrontEnd=!=Null&&$VersionNumber>=8,
	Monitor[ReleaseHold[#],Grid[{{Blur[icon,(*Log[23-prog]*)Max[{16-prog,0}]],progtext},{licenseInfo,SpanFromLeft}}]],
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
	
(*	progtext="Loading GurobiML ...";
	Quiet@Needs["GurobiML`"];Quiet@ParallelNeeds["GurobiML`"];prog++;delay[];*)
	
	progtext="Loading InterpolatingFunctionAnatomy ...";Needs["DifferentialEquations`InterpolatingFunctionAnatomy`"];prog++;delay[];
	progtext="XML ...";Needs["XML`"];prog++;delay[];
	progtext="Loading JLink ...";Needs["JLink`"];prog++;delay[];
	
	BeginPackage["Toolbox`"];
	Unprotect["Toolbox`*"];
	progtext="Loading Config ...";Get["Toolbox`Config`"];prog++;delay[];
	progtext="Loading Usage strings ...";Get["Toolbox`UsageStrings`"];prog++;delay[];
	progtext="Loading Units ...";Get["Toolbox`Units`"];prog++;delay[];
	progtext="Loading Utilities ...";Get["Toolbox`Util`"];prog++;delay[];
	progtext="Loading Types ...";Get["Toolbox`Types`"];prog++;delay[];
	progtext="Loading Core ...";Get["Toolbox`Core`"];prog++;delay[];
	progtext="Loading IO ...";Get["Toolbox`IO`"];prog++;delay[];
	progtext="Loading COBRA ...";Get["Toolbox`COBRA`"];prog++;delay[];
	progtext="Loading Design ...";Get["Toolbox`Design`"];prog++;delay[];
	progtext="Loading Chemoinformatics ...";Get["Toolbox`Chemoinformatics`"];prog++;delay[];
	progtext="Loading Visualization ...";Get["Toolbox`Visualization`"];prog++;delay[];
	progtext="Loading Regulation ...";Get["Toolbox`Regulation`"];prog++;delay[];
	progtext="Loading Sensitivity Analysis ...";Get["Toolbox`Sensitivity`"];prog++;delay[];
	progtext="Loading Thermodynamics ...";Get["Toolbox`Thermodynamics`"];prog++;delay[];
	progtext="Loading Network Theory ...";Get["Toolbox`Networks`"];prog++;delay[];
	progtext="Loading Simulations ...";Get["Toolbox`Simulations`"];prog++;delay[];
	progtext="Loading QCQA ...";Get["Toolbox`QCQA`"];prog++;delay[];
	
	progtext="Loading ExampleData ...";Get["Toolbox`ExampleData`"];prog++;delay[];
	
	(* Display error message for all functions for incorrect inputs *)
	Toolbox`Toolbox::badargs="There is no definition for '`1`' applicable to `2`.";
	names = Complement[ToExpression[Select[Names["Toolbox`*"],StringFreeQ[#,"$"]&]],Toolbox`$MASS$headTypes];
	rules={func->#}&/@names;
	messageCode = Hold[def:func[___]:=(Message[Toolbox`Toolbox::badargs,Evaluate[func],Defer@def];Abort[])]/.rules;
	ReleaseHold/@messageCode;

	(* Protect all public function names *)
	Protect["Toolbox`*"];
	EndPackage[];
]
]


(* ::Section:: *)
(*Backwards compatibility*)


(Unprotect[#];Evaluate[Symbol["MASStoolbox`MASS`"<>ToString[#]]]:=Evaluate[Symbol["Toolbox`"<>ToString[#]]];Protect[#])&/@(Join[$MASS$speciesTypes,$MASS$parameterTypes,{v,reaction,gene,geneComplex,protein,proteinComplex,enzyme}]);

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
