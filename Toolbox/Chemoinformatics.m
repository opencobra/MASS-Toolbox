(* ::Package:: *)

(* ::Title:: *)
(*Chemoinformatics*)


JLink`AddToClassPath["/Applications/ChemAxon/MarvinBeans/lib/"]


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


Unprotect[cxcalc];
Options[cxcalc]={"GeneralOptions"->"","Debug"->False};
cxcalc[input:(_String|_InChI|_SMILES),plugin_String,pluginOptions_String,opts:OptionsPattern[]]:=Module[{cmd},
	cmd=StringJoin[Sequence@@
			Riffle[
				{"echo","\""<>If[MatchQ[input,(_InChI|_SMILES)],input[[1]],input]<>"\"","|","cxcalc",OptionValue["GeneralOptions"],plugin,pluginOptions},
				" "]
		];
	If[OptionValue["Debug"],Print[cmd]];
	Import["!"<>$SystemCommandPrefix<>cmd,"Text"]
];
cxcalc[input:{(_InChI|_SMILES)..},plugin_String,pluginOptions_String,opts:OptionsPattern[]]:=cxcalc[ExportString[input[[All,1]],"Table"],plugin,pluginOptions,opts]
def:cxcalc[___]:=(Message[Toolbox::badargs,cxcalc,Defer@def];Abort[])
Protect[cxcalc];


Unprotect[molconvert];
molconvert[input:(_String|_InChI|_SMILES),outformat_String,options:_String:""]:=Module[{cmd,input2},
	input2=Which[MatchQ[input,_InChI],input[[1]]<>"{inchi}",MatchQ[input,_SMILES],input[[1]],StringMatchQ[input,RegularExpression["^InChI.*"]],input<>"{inchi}",True,input];
	cmd=StringJoin[Sequence@@
			Riffle[
				{"molconvert",outformat,"-s ","\""<>input2<>"\"",options},
				" "]
		];
	Import["!"<>$SystemCommandPrefix<>cmd,"Text"]
];
def:molconvert[___]:=(Message[Toolbox::badargs,molconvert,Defer@def];Abort[])
Protect[molconvert];


drawCompoundOpenBabel::obabelNotInstalled="obabel seems to be not installed or not on your system path.";
drawCompoundOpenBabel[cmpd:(_InChI|_SMILES),opts:OptionsPattern[]]:=Module[{svgInput,lines,texts,polygons,canvas},
	Check[
		svgInput=Switch[cmpd,
					_InChI,Import["!"<>$SystemCommandPrefix<>" echo '"<>getID@cmpd<>"' | obabel -i inchi -o svg","XML"],
					_SMILES,Import["!"<>$SystemCommandPrefix<>" echo '"<>getID@cmpd<>"' | obabel -i smiles -o svg","XML"]
				],
		Message[drawCompoundOpenBabel::obabelNotInstalled];Abort[];,{XML`Parser`XMLGet::prserr}
	];
	lines=Cases[svgInput,XMLElement["line",coords_,_]:>Line[-1Partition[ToExpression[({"x1","y1","x2","y2"}/.coords)],2].ReflectionMatrix[{1,0}]],\[Infinity]];
	texts=Cases[svgInput,XMLElement["text",specs_,text:{_}]:>Style[Text[text[[1]],-1*ToExpression[{"x","y"}/.specs].ReflectionMatrix[{1,0}],{-1.3,-.8}],FontSize->(ToExpression[("font-size"/.specs)]-1),FontFamily->"Helvetica"],\[Infinity]];
	polygons=Cases[svgInput,XMLElement["polygon",points_,_]:>(Polygon[-1*Partition[ImportString["points"/.points,"Table"][[1]],2].ReflectionMatrix[{1,0}]]),\[Infinity]];
	canvas=Cases[svgInput,XMLElement["svg",meta_,_]:>ToExpression[({"width","height"}/.meta)],\[Infinity]][[1]];
	Graphics[Join[lines,texts,polygons],ImageSize->canvas,Sequence@@FilterRules[List[opts],Options[Graphics]]]
];


Options[drawCompoundChemAxon]={"Options"->""(*http://www.chemaxon.jp/jdoc/marvin_help/developer/beans/api/index.html?constant-values.html*)}
drawCompoundChemAxon::chemaxonNotOnClassPath="The ChemAxon Java API seems to be not accessible. Please add the library to the class path via AddToClassPath[].";
drawCompoundChemAxon[cmpd:(_InChI|_SMILES),opts:OptionsPattern[]]:=Module[{tmpFile,exporter,importer,mol},
	JavaBlock[
		Check[importer=JavaNew["chemaxon.formats.MolImporter"];,Message[drawCompoundChemAxon::chemaxonNotOnClassPath];Abort[];,{LoadJavaClass::fail}];
		mol=importer@importMol[cmpd[[1]]];
		tmpFile=OpenWrite[];
		Close[tmpFile];
		tmpFile=tmpFile[[1]]<>".pdf";
		exporter=JavaNew["chemaxon.formats.MolExporter",tmpFile,"pdf:"<>OptionValue["Options"]];
		exporter@write[mol];
	];
	Show[Import[tmpFile][[1]],ImageSize->150]
];


Unprotect[drawCompound];
Options[drawCompound]=Join[{"Method"->"ChemAxon"(*or *)},Options[drawCompoundOpenBabel],Options[drawCompoundChemAxon]];
drawCompound[cmpd:(_InChI|_SMILES),opts:OptionsPattern[]]:=
	Switch[OptionValue["Method"],
		"OpenBabel",drawCompoundOpenBabel[cmpd,Sequence@@FilterRules[List[opts],Options[drawCompoundOpenBabel]]],
		"ChemAxon",drawCompoundChemAxon[cmpd,Sequence@@FilterRules[List[opts],Options[drawCompoundChemAxon]]]
	];
def:drawCompound[___]:=(Message[Toolbox::badargs,drawCompound,Defer@def];Abort[])
Protect[drawCompound];


End[]
