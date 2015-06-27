(* ::Package:: *)

(* ::Title:: *)
(*Util*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


intervalOverlap[interval1:{_?NumberQ,_?NumberQ},interval2:{_?NumberQ,_?NumberQ}]:=Min[{interval1[[2]]-interval2[[1]],interval2[[2]]-interval1[[1]]}]
intervalGaps[interval1:{_?NumberQ,_?NumberQ},interval2:{_?NumberQ,_?NumberQ}]:=If[#>=0,0,If[Abs@interval1[[2]]>Abs@interval2[[2]],1,-1]*#]&[intervalOverlap[interval1,interval2]]


AutoCollapse[]:=(If[$FrontEnd=!=$Failed,SelectionMove[EvaluationNotebook[],All,GeneratedCell];FrontEndTokenExecute["SelectionCloseUnselectedCells"]])


expandLog[expr_]:=Module[{rule1,rule2,a,b,x},
	rule1=Log[a_*b_]->Log[a]+Log[b];
	rule2=Log[a_^x_]->x*Log[a];
	(expr/.rule1)/.rule2
];


expandAllLog[expr_]:=FixedPoint[expandLog,expr]


adjustStoichiometry[rxn_reaction]:=Module[{stoich,lcm},
	If[MemberQ[rxn,_Real,\[Infinity]],
		stoich=getStoichiometry[rxn];
		lcm=LCM[Sequence@@Rationalize[stoich]];
		Return[r[getID[rxn],getSubstrates[rxn],getProducts[rxn],stoich*lcm,reversibleQ[rxn]]]
		,Return[rxn]
	]
];


makeIdXmlConform[str_String]:=StringReplace[str,RegularExpression["([^a-z_A-Z0-9])"]:>("_Char"<>ToString[ToCharacterCode["$1"][[1]]]<>"_")]
reverseIdXmlConform[str_String]:=StringReplace[str,RegularExpression["(_Char)(\\d+)(_)"]:>FromCharacterCode[ToExpression["$2"]]]


filter[listOfRules:{(_Rule|_RuleDelayed)...},keys_List]:=Module[{cleanKeys},cleanKeys=Select[keys,MemberQ[listOfRules[[All,1]],#]&];Thread[cleanKeys->(cleanKeys/.FilterRules[listOfRules,cleanKeys])]]
filter[listOfRules:{(_Rule|_RuleDelayed)...},key_]:=filter[listOfRules,{key}]


query[attr_,{},default_:Automatic]:=default
query[attr_,dict:({_Rule..}|Dispatch[{_Rule..}]),default_:Automatic]:=If[default===Automatic,#,#/.attr:>default]&[(attr/.Dispatch[dict])]


(*extractXMLelement[xml_,tag_String]:=Replace[Cases[xml,XMLElement[tag,attrVal_,data_]:>Rule[attrVal,data],\[Infinity]],{}->{{}}][[1]]*)
extractXMLelement[xml_,tag:(_String|_Alternatives),0,level_:\[Infinity]]:=Cases[xml,XMLElement[tag,attrVal_,data_],level]
extractXMLelement[xml_,tag:(_String|_Alternatives),pos_,level_:\[Infinity]]:=Replace[Cases[xml,XMLElement[tag,attrVal_,data_]:>{attrVal,data}[[pos]],level],{}->{{}}][[1]]


SetAttributes[integerChop,Listable];
integerChop[number_Real]:=If[Round@number==number,Round@number,number]
integerChop[other_?NumberQ]:=other


getReferenceFluxesAndBoundsFromXML[path_String]:=Block[{tmp,tmp2,tmp3,tmp4},
tmp=Import[path,"Text"];
tmp2=StringCases[tmp,RegularExpression["(?s)listOfReactions.+"]];
tmp3=Flatten[StringSplit[tmp2,RegularExpression["<reaction id="]][[1]][[2;;]]];
tmp4=Quiet@StringCases[#,RegularExpression["(?s)^(\"R_.+?\").+\"LOWER_BOUND\"\\s*?value=\"([-\\d\\.]+)\".+?\"UPPER_BOUND\"\\s*?value=\"([\\d\\.]+)\".+?\"FLUX_VALUE\"\\s*?value=\"(.+?)\""]:>{"$1"->{ToExpression@"$2",ToExpression@"$3",ToExpression@"$4"}}]&/@tmp3;
Flatten[tmp4]/.s_String:>StringReplace[s,{"\""->""}]
];


parseJSON[path_?FileExistsQ]:=parseJSON[Import[path,"Text"]]
parseJSON[json_String]:=Module[{cat,eval},
cat=StringJoin@@(ToString/@{##})&;(*Like sprintf/strout in C/C++.*)
eval=ToExpression;
ToExpression@StringReplace[cat@FullForm@eval[StringReplace[json,{"["->"(*MAGIC[*){","]"->"(*MAGIC]*)}",":"->"(*MAGIC:*)->","true"->"(*MAGICt*)True","false"->"(*MAGICf*)False","null"->"(*MAGICn*)Null","e"->"(*MAGICe*)*10^","E"->"(*MAGICE*)*10^"}]],{"(*MAGIC[*){"->"[","(*MAGIC]*)}"->"]","(*MAGIC:*)->"->":","(*MAGICt*)True"->"true","(*MAGICf*)False"->"false","(*MAGICn*)Null"->"null","(*MAGICe*)*10^"->"e","(*MAGICE*)*10^"->"E"}]]


iwith[pat_List,l_List] := Module[{mark},
iwith[mark, l /. Map[ (#-> mark)&,pat]]];
iwith[pat_,l_List] := Map[First,Position[l,pat]] //Union;
with[pat_,l_List] := l[[iwith[pat,l]]];


updateRules[rules:{(_Rule|_RuleDelayed)..},newRules:{(_Rule|_RuleDelayed)..}]:=Module[{},
	(*Join[DeleteCases[rules,r_Rule/;MemberQ[newRules[[All,1]],r[[1]]]],newRules]*)
	Join[FilterRules[rules,Except[newRules/.pat_Blank:>Verbatim[pat]]],newRules]
];
updateRules[{},newRules:{(_Rule|_RuleDelayed)..}]:=newRules
updateRules[rules:{(_Rule|_RuleDelayed)..},{}]:=rules
updateRules[{},{}]:={}
updateRules[rules:{(_Rule|_RuleDelayed)..},rule:(_Rule|_RuleDelayed)]:=updateRules[rules,{rule}]
updateRules[rule:(_Rule|_RuleDelayed),rules:{(_Rule|_RuleDelayed)..}]:=updateRules[{rule},rules]
updateRules[rule1:(_Rule|_RuleDelayed),rule2:(_Rule|_RuleDelayed)]:=updateRules[{rule1},{rule2}]
updateRules[rules__]:=Fold[updateRules[#1,#2]&,List[rules][[1]],List[rules][[2;;]]]


scatterFromDicts[dicts__]:=Module[{ldicts,commonkeys},
	ldicts=List[dicts];
	commonkeys=Union[Flatten@Intersection[Sequence@@ldicts[[All,All,1]]]];
	Table[k->(k/.#&/@ldicts),{k,commonkeys}]
];


calcLinkMatrix[s_?MatrixQ]:=Module[{Q,R,independent,tmp,dependent,newOrder,rank},
	{Q,R}=QRDecomposition[N@Transpose[s]];
	dependent=Flatten[Position[Chop@Tr[R,List],0]];
	independent=Complement[Range[1,Length[s]],dependent];
	newOrder=Join[independent,dependent];
	s[[newOrder]].PseudoInverse[N@s[[independent]]];
	{newOrder,s[[newOrder]],s[[independent]],Chop[s[[newOrder]].PseudoInverse[N@s[[independent]]]]}
];


initializeKernels[]:=Module[{},
	LaunchKernels[];
	ParallelEvaluate[Off[FrontEndObject::notavail];Needs["Toolbox`"];On[FrontEndObject::notavail]];
	];

initializeKernels[ker:{KernelObject..}]:=Module[{},
	LaunchKernels[ker];
	ParallelEvaluate[Off[FrontEndObject::notavail];Needs["Toolbox`"];On[FrontEndObject::notavail],ker];
	];

initializeKernels[ker_KernelObject]:=initializeKernels[{ker}];


Unprotect[Round];
Round[thing_Unit,number_?NumberQ]:=Unit[Round[First[thing],number],Last[thing]];
Protect[Round];


grep[file_String,patt_String]:=
	With[{data=Import[FileNameJoin[{$ToolboxPath,file}],"Lines"]},
		Pick[Transpose[{Range[Length[data]],data}],StringFreeQ[data,patt],False]
	]

grep[patt_String]:=
	With[{fileNames={"Chemoinformatics.m","COBRA.m","Config.m","Core.m","Design.m","ExampleData.m","IO.m","Networks.m","QCQA.m","Regulation.m","Sensitivity.m","Simulations.m","Style.m","Thermodynamics.m","Types.m","UsageStrings.m","Util.m","Visualization.m"}},
		Flatten[Function[name,Prepend[#,name]&/@grep[name,patt]]/@fileNames,1]
	]




(* ::Subsection:: *)
(*Update code*)


Needs["JLink`"];
Needs["Utilities`URLTools`"];
InstallJava[];


httpGet[url_String]:=
	JavaBlock@Module[{http,get},
		http=JavaNew["org.apache.commons.httpclient.HttpClient"];
		get=JavaNew["org.apache.commons.httpclient.methods.GetMethod",url];
		http@executeMethod[get];
		get@addRequestHeader["content-type","application/json"];
		get@getResponseBodyAsString[]
	];


latestRelease[]:=
	Module[{code,tags},
		code = httpGet["https://api.github.com/repos/opencobra/MASS-Toolbox/releases"];
		tags = StringTake[Select[StringSplit[code,","],StringMatchQ[#,"\"tag_name"~~___]&],14;;-2];
		First[tags]
	];


updateRequired[]:=
	Module[{newVersion,currentVersion},
		newVersion=latestRelease[];
		currentVersion=$ToolboxVersion;
		newVersion!=currentVersion
	];



updateToolbox::InvalidVersion = "Version must be of the format \"X.X.X\" where X is a number.";

Options[updateToolbox]={Install->True};

updateToolbox[ops:OptionsPattern[]]:=
	Module[{version},
		(* Check that an update is required *)
		Print["Checking version..."];
		version=latestRelease[];
		If[version==$ToolboxVersion,
			Print["No update necessary"],
			updateToolbox[version,ops]
		];
	];

updateToolbox[version_String,OptionsPattern[]]:=
	Module[{directory,newDirectory,fileName,url,task1,task2,progFunction},

		(* Check that the version is correctly formatted *)
		If[!StringMatchQ[version,DigitCharacter..~~"."~~DigitCharacter..~~"."~~DigitCharacter..],
			Message[updateToolbox::InvalidVersion];Abort[]
		];

		(* Download new version *)
		Clear[Global`progress];
		directory = $TemporaryDirectory;
		fileName=directory<>"/MASS-Toolbox-"<>version<>".tar.gz";
		Print["Please wait. Downloading Toolbox v"<>version<>"..."];
		url="https://github.com/opencobra/MASS-Toolbox/archive/v"<>version<>".tar.gz";
		Global`progress= 0.;
		Monitor[Null,Null];
		progFunction[_, "progress", {dlnow_, dltotal_, _, _}]:= Quiet[Global`progress = dlnow/dltotal];
		task1=URLSaveAsynchronous[url, fileName, progFunction, "Progress"->True];
		Monitor[WaitAsynchronousTask[task1],Dynamic[If[!NumberQ[Global`progress],"",ProgressIndicator[Global`progress]]]];
		Print["Download Complete!"];

		(* Extract Archive *)
		newDirectory=FileNameJoin[{directory,"MASS-Toolbox-"<>version}];
		Quiet@DeleteFile[FileNameJoin[{directory,"pax_global_header"}]];
		Quiet@DeleteDirectory[newDirectory,DeleteContents->True];
		Print["Please wait. Extracting Files..."];
		task2=ExtractArchive[fileName,directory];
		WaitAsynchronousTask[task2];

		(* Install new version of mathematica *)
		If[OptionValue[Install]==True,
			Module[{installNotebook,nb,cell},
				Print["Installing Toolbox..."];
				installNotebook=FileNameJoin[{newDirectory,"Installer.nb"}];
				nb=NotebookOpen[installNotebook];
				SelectionMove[nb,Next,Cell,3];
				SelectionEvaluate[nb];
				SelectionMove[nb,Next,Cell,1];
				SelectionEvaluate[nb];
				Print["The MASS Toolbox was successfully updated and installed!"];
			],
			Print["The MASS Toolbox was successfully updated!"];
			Print["Note: Manual installation is required."];
		];
	]


(* ::Subsection::Closed:: *)
(*End*)


End[]
