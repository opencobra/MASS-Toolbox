(* ::Package:: *)

(* ::Title:: *)
(*Visualization*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Network visualization*)


Quiet@<<GraphUtilities`


showNetwork[model_MASSmodel,opts:OptionsPattern[]]:=Module[{net,nodes,coords,tmp},
	net=Replace[model2bipartite[model],s_String:>v[s],2];
	showNetwork[net,model,opts]
]
showNetwork[net_List,model_MASSmodel,opts:OptionsPattern[]]:=Module[{nodes,coords,tmp},
	nodes=VertexList[net];
	coords=Thread[nodes->GraphCoordinates[net,Sequence@@FilterRules[List@opts,Options[GraphCoordinates]]]];
	tmp=Flatten[Tuples[{Replace[getSubstrates[#],{}->{\[EmptySet]}],{v[getID[#]]},{v[getID[#]]},Replace[getProducts[#],{}->{\[EmptySet]}]}]&/@model["Reactions"],1]/.coords;
	tmp=DeleteCases[tmp,\[EmptySet]|_metabolite|_String|_enzyme,\[Infinity]];
	Show[
		Graphics[{Arrowheads[0.01],Arrow[BezierCurve[#],{.2,.2}]}&/@tmp/.coords],
		Graphics[{(*If[MatchQ[#[[1]],$MASS$speciesPattern],{White,Disk[#[[2]],.25],Black,Circle[#[[2]],.25]},{EdgeForm[Black],White,Rectangle[#[[2]]-.2,#[[2]]+.2]}],*)Style[Text[#[[1]],#[[2]]],FontSize->14,Background->None,Italic]}&/@coords],
		Sequence@@FilterRules[List@opts,Options[Graphics]]
	]
];


(*Options[visualizePathways]=updateRules[Join[Options[LayeredGraphPlot],{"MetaboliteRenderingFunction"->({Green,Disk[#,.1]}&),"EnzymeRenderingFunction"->({Orange,Disk[#,.1]}&),"ReactionRenderingFunction"->({Red,Disk[#1,.1]}&),"PlotFunction"->LayeredGraphPlot}],{MultiedgeStyle->None,DirectedEdges->True,PlotStyle->{Gray,Arrowheads[Small]}}];*)
Options[visualizePathways]=updateRules[Join[Options[LayeredGraphPlot],{"MetaboliteRenderingFunction"->(Text[#2,#1]&),"EnzymeRenderingFunction"->({Orange,Disk[#,.1]}&),"ReactionRenderingFunction"->(Text[#2,#1]&),"PlotFunction"->LayeredGraphPlot}],{MultiedgeStyle->None,DirectedEdges->True,PlotStyle->{Gray,Arrowheads[Small]},EdgeRenderingFunction->(Arrow[#,.3]&)}];
visualizePathways[bipartiteNetwork:{_Rule..},opts:OptionsPattern[]]:=Module[{vertFunc},
vertFunc=(Tooltip[Switch[#2,
	_metabolite|_species|_protein|_gene|_complex,OptionValue["MetaboliteRenderingFunction"][##],
	_enzyme,OptionValue["EnzymeRenderingFunction"][##],
	(_String|_v),OptionValue["ReactionRenderingFunction"][##],
	_,OptionValue["MetaboliteRenderingFunction"]
],#2]&);
OptionValue["PlotFunction"][bipartiteNetwork,VertexRenderingFunction->vertFunc,Sequence@@FilterRules[updateRules[Options[visualizePathways],List@opts],Options[OptionValue["PlotFunction"]][[All,1]]]]
];
visualizePathways[rxns:{_reaction..},opts:OptionsPattern[]]:=visualizePathways[reactions2bipartite[rxns],opts]
visualizePathways[model_MASSmodel,opts:OptionsPattern[]]:=visualizePathways[model2bipartite[model],opts]


Options[visualizeGPR]=updateRules[Options[LayeredGraphPlot],{VertexRenderingFunction->({Inset[If[Head[#2]===String,Style[Framed[#2],Background->LightPurple,FontColor->Black],StandardForm@#2],#1]}&),DirectedEdges->False,PlotStyle->{Black},ImageSize->{{800},{300}}}];
visualizeGPR[model_MASSmodel]:=visualizeGPR/@gpr2graphs[model["GPR"]]
visualizeGPR[gpr:{_Rule..},opts:OptionsPattern[]]:=Module[{},
	LayeredGraphPlot[gpr,Sequence@@updateRules[Options[visualizeGPR],List[opts]]]
];


(* ::Subsection:: *)
(*Dynamic visualization*)


tooltipNDSolveSolution[solution_List]:=Module[{tmpSolution},
tmpSolution=solution;
While[tmpSolution[[1,0]]===List,tmpSolution=tmpSolution[[1]]];
Thread[Tooltip[tmpSolution[[All,2]],tmpSolution[[All,1]]]]
];


Options[legend]={Background->Directive[Opacity[.7,White]],Frame->True,FrameStyle->Thin};
legend::numdirective="The number of directives (`1`) should match the number of legend items (`2`).";
legend[labels_List,directives_List,opts:OptionsPattern[]]:=Module[{grid},
	If[Length[labels]!=Length[directives],Message[legend::numdirective,Length[directives],Length[labels]];Abort[];];
	grid=Table[
		{Style[labels[[i]],FontSize->.8*Scaled[.1]], Graphics[{Sequence@@directives[[i]],Line[{{0,0},{.8,0}}]}]}
		,{i,1,Length[labels]}
		];
	If[Length[grid]>8,grid=Join[Sequence@@#]&/@Partition[grid,2,2,1,{{"",""}}]];
	GraphicsGrid[
		grid,Spacings->{Scaled[.1],Scaled[-.5]},Sequence@@FilterRules[updateRules[Options[legend],List[opts]],Options[GraphicsGrid]]
	]
];
legend[labels_List,opts:OptionsPattern[]]:=legend[labels,Table[Directive@ColorData[1][i],{i,1,Length[labels]}],opts]


Options[insetLegend]=Join[{"Position"->Right,"Size"->1},Options[legend]];
insetLegend::wrongPosition="`1` is not a valid position. Choose from Right, Left, {Right, Bottom}, {Right, Top}, {Left, Bottom} or {Left, Top}";
insetLegend[labels_List,directives:(_List|_Hold),opts:OptionsPattern[]]:=Module[{tmpLegend,adjust,size},
	tmpLegend=legend[labels,ReleaseHold@directives,Sequence@@FilterRules[List[opts],Options[legend][[All,1]]]];
	adjust=If[Length[labels]>1,1-(1/Length[labels]),.3];
	size=Scaled[adjust*OptionValue["Size"]];
	Switch[ToExpression@OptionValue["Position"],
		Right,Inset[tmpLegend,Scaled[{.98,1}],{Right,Top},size],
		Left,Inset[tmpLegend,Scaled[{.02,1}],{Left,Top},size],
		{Right,Bottom},Inset[tmpLegend,Scaled[{.98,0}],{Right,Bottom},size],
		{Right,Top},Inset[tmpLegend,Scaled[{.98,1}],{Right,Top},size],
		{Left,Bottom},Inset[tmpLegend,Scaled[{.02,0}],{Left,Bottom},size],
		{Left,Top},Inset[tmpLegend,Scaled[{.02,1}],{Left,Top},size],
		_,Message[insetLegend::wrongPosition,OptionValue["Position"]];Abort[];
	]
];
insetLegend[labels_List,opts:OptionsPattern[]]:=insetLegend[labels,Hold@Sequence[],opts]


(*Options[plotSimulation]=updateRules[Union[Options[LogLogPlot],Options[ListPlot]],{"PlotFunction"->LogLogPlot,"Tooltipped"->True,"ZeroFac"->1*^-6,Joined->True,"Legend"->False}];*)
Options[plotSimulation]={"PlotFunction"->LogLogPlot,"Tooltipped"->True,"ZeroFac"->1*^-6,Joined->True,"Legend"->False,"PlotLegends"->None};
plotSimulation[simulation:{_Rule..},{t_Symbol,tMin_?NumberQ,tMax_?NumberQ,tStep_:.1},opts:OptionsPattern[{plotSimulation,LogLogPlot,ListPlot}]]:=Module[{interPolDat,numericalDat,plotFunction,plotOpts,fac,interPolPlot,numericalPlotFunction,numericalPlot,legend},
	interPolDat=Cases[simulation,r_Rule/;MemberQ[r,InterpolatingFunction[__][_],\[Infinity]]||NumberQ[r[[2]]],\[Infinity]];
	numericalDat=DeleteCases[Complement[simulation,interPolDat],r_Rule/;r[[2]]==0.];
	numericalDat=If[OptionValue["Tooltipped"],MapIndexed[Tooltip[#,ToString[#2//First]]&,numericalDat[[All,2]]],numericalDat[[All,2]]];
	interPolDat=interPolDat/.{elem:InterpolatingFunction[__][t]:>elem,elem:InterpolatingFunction[__]:>elem[t]};
	interPolDat=If[OptionValue["Tooltipped"],Thread[Tooltip[stripUnits@interPolDat[[All,2]],(interPolDat[[All,1]]*(interPolDat[[All,2]]/.InterpolatingFunction[___][t]:>1)/.{u_Quantity:>Quantity["",u[[2]]],_?NumberQ:>1})]],stripUnits@interPolDat[[All,2]]];
	plotFunction=OptionValue["PlotFunction"];
	numericalPlotFunction=ToExpression["List"<>ToString[plotFunction]];
	If[$VersionNumber<9,
	legend=If[OptionValue["Legend"]===True||MatchQ[OptionValue["PlotLegends"],Automatic|"Expressions"],
		Epilog->If[OptionQ[OptionValue["Legend"]],
			insetLegend[StandardForm/@simulation[[All,1]],If[OptionValue["PlotStyle"]===Automatic,Hold@Sequence[],Directive/@OptionValue["PlotStyle"]],Evaluate[Sequence@@OptionValue["Legend"]]],
			insetLegend[StandardForm/@simulation[[All,1]],If[OptionValue["PlotStyle"]===Automatic,Hold@Sequence[],Directive/@OptionValue["PlotStyle"]]]],Epilog->{}];,
	legend=If[OptionValue["Legend"]===True||MatchQ[OptionValue["PlotLegends"],Automatic|"Expressions"],PlotLegends->simulation[[All,1]],PlotLegends->OptionValue["PlotLegends"]];
	];
	If[interPolDat!={},
		plotOpts=FilterRules[{opts},Options[plotFunction]];
		fac=If[tMin==0&&(plotFunction===LogLogPlot||plotFunction===LogLinearPlot),OptionValue["ZeroFac"],0.];
		Quiet@Check[interPolPlot=plotFunction[Evaluate[interPolDat],{t,Evaluate[tMin+fac],tMax},Evaluate[legend],Evaluate[Sequence@@plotOpts]],None,InterpolatingFunction::dmval];,
		interPolPlot={};
	];
	If[numericalDat!={},
		numericalPlot=numericalPlotFunction[numericalDat,Sequence@@FilterRules[{opts},Options[numericalPlotFunction]],Joined->True,PlotRange->{{Evaluate[tMin+fac],tMax},All}],numericalPlot={}];
		Show[Sequence@@Flatten[{interPolPlot,numericalPlot}]]
	];
plotSimulation[simulation:{_Rule..},opts:OptionsPattern[]]:=Module[{tStart,tEnd,adjusted},
	adjusted=simulation/.{elem:InterpolatingFunction[__][t]:>elem,elem:InterpolatingFunction[__]:>elem[t]};
	{tStart,tEnd}={Max[#[[1]]],Min[#[[2]]]}&@Transpose[Cases[adjusted,InterpolatingFunction[{{start_,end_}},___][_]:>{start,end},\[Infinity]]];
	plotSimulation[adjusted,{t,tStart,tEnd},opts]
];


Options[ppAnnotate]={startColor->Blue,endColor->Red,size->.04};
ppAnnotate[variables_List,solution_List,tfinal_,start_:0.,OptionsPattern[]]:={OptionValue[startColor],PointSize[OptionValue[size]],Point[variables/.solution/.t->start],OptionValue[endColor],Point[variables/.solution/.t->tfinal]}


ppAnnotate2[func1_,func2_,tfinal_,start_:0.]:=Module[{pt1,pt2,startPoint,endPoint},
pt1={func1,func2}/.t->start;
pt2={func1,func2}/.t->tfinal;
startPoint=pt1+.07(pt2-pt1);
endPoint=pt2+.07(pt1-pt2);
{Style[Text["\!\(\*SubscriptBox[\(t\), \(0\)]\)",startPoint],FontSize->Scaled[.06]],Style[Text[Subscript["t","\[Infinity]"],endPoint],FontSize->Scaled[.06]]}
]


ppColorFunction[func1_,func2_,opts:OptionsPattern[]]:=Module[{endOfAction,min,max,funcs},
funcs={func1,func2};
min=(Min[#[[0,1,1,1]]&/@Cases[funcs,_InterpolatingFunction[__],\[Infinity]]]);
max=(Min[#[[0,1,1,2]]&/@Cases[funcs,_InterpolatingFunction[__],\[Infinity]]]);
If[NumberQ[min]&&NumberQ[max],
endOfAction=Max[t/.Quiet[FindRoot[Evaluate[Abs[D[#,{var,1}]]+Abs[D[#,{t,2}]]],{t,min+max*.1}],{InterpolatingFunction::dmval,FindRoot::lstol}]&/@funcs];
Function[{x,y,time},ColorData["Rainbow"][1-(Log[10,time]/Log[10,endOfAction])]],
Function[{x,y,time},Black]
]
];


Options[annotateStartEnd]={"StartMarker"->(Style[Text[Subscript["t",ToString[#]]],FontSize->Scaled[.06]]&),"EndMarker"->(Style[Text[Subscript["t",#]],FontSize->Scaled[.06]]&)};
annotateStartEnd[func1_,func2_,start_?NumberQ,tfinal_?NumberQ,opts:OptionsPattern[]]:=Module[{pt1,pt2,startPoint,endPoint},
pt1={func1,func2}/.t->start;
pt2={func1,func2}/.t->tfinal;
startPoint=pt1+.07(pt2-pt1);
endPoint=pt2+.07(pt1-pt2);
{Inset[OptionValue["StartMarker"][start],startPoint],Inset[OptionValue["EndMarker"][tfinal],endPoint]}
]


(*Options[plotPhasePortrait]=updateRules[Join[Options[ParametricPlot],Options[Manipulate]],{PlotRangePadding->Scaled[.1],AspectRatio->1,ColorFunctionScaling->False,PlotStyle->Directive[Black,Thickness[.007]],*)
Options[plotPhasePortrait]={PlotRangePadding->Scaled[.1],AspectRatio->1,ColorFunctionScaling->False,PlotStyle->Directive[Black,Thickness[.007]],
ColorFunction->Automatic,FrameLabel->Automatic,"Annotate"->True};

plotPhasePortrait[simulation_,opts:OptionsPattern[{plotPhasePortrait,ParametricPlot,Manipulate}]]:=Module[{tStart,tEnd,tmp},
	tmp=Cases[simulation,InterpolatingFunction[{{start_,end_}},___][_]:>{start,end},\[Infinity]];
	If[tmp==={},
		plotPhasePortrait[simulation,{t,0,10000},opts],
		{tStart,tEnd}={Max[#[[1]]],Min[#[[2]]]}&@Transpose[tmp];
		plotPhasePortrait[simulation,{t,tStart,tEnd},opts]
	]
];

plotPhasePortrait[simulation:{_Rule..},{t_Symbol,tMin_?NumberQ,tMax_?NumberQ},opts:OptionsPattern[{plotPhasePortrait,ParametricPlot,Manipulate}]]:=Module[{plotOpts,style,cleanSimulation,pltFunc},
	cleanSimulation=stripUnits@simulation;
	plotOpts=FilterRules[updateRules[Options[plotPhasePortrait],List[opts]],Options[ParametricPlot]];
	(*pltFunc=ParametricPlot[#[[All,2]],{t,tMin,tMax},Epilog->annotateStartEnd[Sequence@@#[[All,2]],tMin,tMax,Sequence@@FilterRules[List@opts,Options[annotateStartEnd]]],Evaluate[Sequence@@If[OptionValue["FrameLabel"]===Automatic,updateRules[plotOpts,"FrameLabel"->(TraditionalForm/@#[[All,1]])],plotOpts]]]&;*)
	pltFunc=ParametricPlot[Evaluate[#[[All,2]]],{t,tMin,tMax},Evaluate[If[OptionValue["Annotate"]===True,Epilog->annotateStartEnd[Sequence@@#[[All,2]],tMin,tMax,Sequence@@FilterRules[List@opts,Options[annotateStartEnd]]],Unevaluated[Sequence[]]]],Evaluate[Sequence@@If[OptionValue["FrameLabel"]===Automatic,updateRules[plotOpts,{FrameLabel->(TraditionalForm/@#[[All,1]])}],plotOpts]]]&;
	If[Length[cleanSimulation]>2,
		Manipulate[
			pltFunc[FilterRules[cleanSimulation,{x,y}]],
			{{x,cleanSimulation[[All,1]][[1]],"Abscissa"},cleanSimulation[[All,1]]},
			{{y,cleanSimulation[[All,1]][[2]],"Ordinate"},cleanSimulation[[All,1]]},SaveDefinitions->True,Initialization:>(Needs["Toolbox`"];Needs["Toolbox`Style`"];Needs[""])
		],
		pltFunc[cleanSimulation]
	]
];

plotPhasePortrait[simulation:{{_Rule,_Rule}..},{t_Symbol,tMin_?NumberQ,tMax_?NumberQ},opts:OptionsPattern[{plotPhasePortrait,ParametricPlot,Manipulate}]]:=Module[{plotOpts,cleanSimulation},
	cleanSimulation=stripUnits@simulation;	
	plotOpts=FilterRules[updateRules[Options[plotPhasePortrait],{opts}],Options[ParametricPlot]];
	ParametricPlot[Evaluate[cleanSimulation/.r_Rule:>r[[2]]],{t,tMin,tMax},Evaluate[If[OptionValue["Annotate"]===True,Epilog->(annotateStartEnd[Sequence@@#[[All,2]],tMin,tMax,Sequence@@FilterRules[List@opts,Options[annotateStartEnd]]]&/@cleanSimulation),Unevaluated[Sequence[]]]],Evaluate[Sequence@@plotOpts]]
];


Options[plotTiledPhasePortraits]=updateRules[Options[plotPhasePortrait],{Frame->False,FrameTicks->False}];
plotTiledPhasePortraits[simulation:{_Rule..},opts:OptionsPattern[]]:=Module[{interPolDat,numericalDat,plotFunction},
GraphicsGrid[Table[
Piecewise[{
{plotPhasePortrait[simulation[[{i,j}]],Sequence@@FilterRules[List[opts],Options[plotTiledPhasePortraits]],ImageSize->{Automatic,300}],i>j},{Quiet@plotSimulation[{simulation[[i]]},Epilog->Style[Text[simulation[[i,1,0,1]],ImageScaled@{.9,.85}],FontFamily->"Helvetica",FontSize->Scaled[0.07],Bold],BaseStyle->{FontSize->Scaled[.04]},ImageSize->{Automatic,300}],i==j},
{"",i<j}}
],{i,1,Length[simulation]},{j,1,Length[simulation]}],ImageSize->Length[simulation]*200,Frame->False]
];
plotTiledPhasePortraits[simulation1:{_Rule..},simulation2:{_Rule..},opts:OptionsPattern[]]:=Module[{interPolDat,numericalDat,plotFunction},
GraphicsGrid[Table[
Piecewise[{
{plotPhasePortrait[{simulation1[[i]],simulation2[[j]]},Frame->False,PlotPoints->1000,PerformanceGoal->"Quality",ImageSize->{Automatic,300}],i!=j},{Quiet@plotSimulation[{simulation1[[i]],simulation2[[j]]},Epilog->Style[Text[simulation1[[i,1,0,1]],ImageScaled@{.9,.85}],FontFamily->"Helvetica",FontSize->Scaled[0.07],Bold],BaseStyle->{FontSize->Scaled[.04]},ImageSize->{Automatic,300}],i==j}}
],{i,1,Length[simulation1]},{j,1,Length[simulation2]}],ImageSize->5*200,Frame->False]
];


(* ::Subsection:: *)
(*COBRA*)


(*Options[plotFVA]=updateRules[Options[Graphics],{BaseStyle->{FontFamily->"Helvetica",FontSize->Scaled[.02]},"Sort"->True}];*)
Options[plotFVA]={BaseStyle->{FontFamily->"Helvetica",FontSize->Scaled[.02]},"Sort"->True,ImageSize->650,AspectRatio->1/6};
plotFVA[fvaresult_List,opts:OptionsPattern[{plotFVA,Graphics}]]:=Module[{fvaResult,ord,max,min},
If[OptionValue["Sort"],
ord=Ordering[fvaresult,All,EuclideanDistance[Sequence@@(#[[2]]/.{\[Infinity]->10*^12,-\[Infinity]->-10*^12})]>EuclideanDistance[Sequence@@(#2[[2]]/.{\[Infinity]->10*^12,-\[Infinity]->-10*^12})]&];,
(*ord=Ordering[fvaresult,All,If[#[[2,2]]===#[[2,2]],(#[[2,1]]/.{\[Infinity]->10*^12,-\[Infinity]->-10*^12})>(#2[[2,1]]/.{\[Infinity]->10*^12,-\[Infinity]->-10*^12}),(#[[2,2]]/.{\[Infinity]->10*^12,-\[Infinity]->-10*^12})>(#2[[2,2]]/.{\[Infinity]->10*^12,-\[Infinity]->-10*^12})]&];,*)
ord=Range[1,Length[fvaresult]];
];
fvaResult=fvaresult[[ord]];
{max,min}={Max[DeleteCases[fvaResult[[All,2,2]],\[Infinity]]/.{}->{100.}],Min[DeleteCases[fvaResult[[All,2,1]],-\[Infinity]]/.{}->{-100.}]};
{max,min}={max/. 0->100.,min/. 0->-100.};
Graphics[Thread[Tooltip[#,Row[Prepend[#[[2]],#[[1]]],"  "]&/@fvaResult]]&@Table[
Switch[fvaResult[[i,2]],
{-\[Infinity],\[Infinity]},
{Dotted,Line[{{i,min*2.1},{i,max*2.1}}]},
{-\[Infinity],_?NumberQ},
{Dotted,Line[{{i,min*2.1},{i,fvaResult[[i,2,2]]}}]},
{_?NumberQ,\[Infinity]},
{Dotted,Line[{{i,fvaResult[[i,2,1]]},{i,max*2.1}}]},
{a_?NumberQ,a_?NumberQ},
{Point[{i,fvaResult[[i,2,1]]}]},
{a_?NumberQ,b_?NumberQ}/;Chop[Abs[a-b]]===0,
{Point[{i,fvaResult[[i,2,1]]}]},
{_?NumberQ,_?NumberQ},
{Line[{{i,fvaResult[[i,2,1]]},{i,fvaResult[[i,2,2]]}}]}
],{i,1,Length[fvaResult]}],Sequence@@FilterRules[List[opts],Options[Graphics][[All,1]]],PlotRange->All(*PlotRange->{All,{min-EuclideanDistance[min,max]*.3,max+EuclideanDistance[min,max]*.3}}*),AspectRatio->1/6,Frame->True,FrameTicks->({{Automatic,None},{Thread[List[Range[1,Length[#]],Style[Rotate[stringShortener[#,10],90Degree],FontFamily->"Helvetica",FontSize->Scaled[0.005]]&/@#]]&[fvaResult[[All,1]]],None}})]
];


(* ::Subsection:: *)
(*BIGG map visualization*)


svgParser=XML`Parser`InitializeXMLParser["svg",FileNameJoin[{$ToolboxPath,"Cache/svg10.dtd"}]]


(*getMetCoords[blub_]:=(internalMetID[ToExpression@StringCases[#[[3,1,2,1,2]],RegularExpression[".*id=(\\d+)"]:>"$1"][[1]]]->(ToExpression[#]&/@#[[3,1,3,1,2]][[1;;2,2]])*-1&/@blub[[2,3,2,3,7,3]])/.r_Rule/;r[[1,0]]===internalMetID:>(r[[1]]->r[[2]]);*)
getMetCoords[svg_]:=Module[{metsRaw},
	metsRaw=Cases[svg,XMLElement["g",_,dat_List/;MemberQ[dat,XMLElement["a",_,dat2_/;MemberQ[dat2,XMLElement["circle",__]]]]],\[Infinity]];
	query["id",#[[2]]]->(ToExpression[Toolbox`Private`extractXMLelement[#,"circle",1][[All,2]]]/.{x_,y_,r_}:>{x*-1,y*-1,r})&/@metsRaw
];


getReactionPositions[svg_]:=Block[{auxArrowFunc,rxnsRaw},
	auxArrowFunc=Switch[#,"url(#Triangle)",-1,"url(#triangle)",1,_,0]&;
	rxnsRaw=Cases[svg,XMLElement["g",_,dat_List/;MemberQ[dat,XMLElement["a",_,dat2_/;MemberQ[dat2,XMLElement["path",__]]]]],\[Infinity]];
	query["id",#[[2]]]->({Partition[ToExpression[StringCases[query["d",#],RegularExpression["-?\\d+\\.?\\d+"]]],2]*-1,auxArrowFunc[query["marker-end",#,query["marker-start",#]]]}&/@Toolbox`Private`extractXMLelement[#,"path",0][[All,2]])&/@rxnsRaw
];


getTextLabelsMetabolites[blub_]:=Text[#[[3,1]],(ToExpression/@{"x"/.#[[2]],"y"/.#[[2]]})*-1,{1,0}]&/@Cases[blub[[Sequence@@Append[Position[blub,"Layer_label_met"][[1]][[;;-4]],3]]],XMLElement["text",__],\[Infinity]];


getTextLabelsReactions[blub_]:=Text[#[[3,1]],(ToExpression/@{"x"/.#[[2]],"y"/.#[[2]]})*-1,{1,0}]&/@Cases[blub[[Sequence@@Append[Position[blub,"Layer_label_rxn"][[1]][[;;-4]],3]]],XMLElement["text",__],\[Infinity]];


getOtherLabels[blub_]:=ToExpression@StringCases[#[[2,1,2]],RegularExpression["(\\d+)px"]:>"$1"][[1]]->Text[#[[3,1,3,1]],(ToExpression/@{"x"/.#[[3,1,2]],"y"/.#[[3,1,2]]})*-1,{1,0}]&/@Cases[blub[[Sequence@@Append[Position[blub,"Layer_text"][[1]][[;;-4]],3]]],XMLElement["g",a_List,b_List]/;b[[1,1]]==="text",\[Infinity]];


getCorners[any_]:=Block[{tmp,xMin,xMax,yMin,yMax},
	tmp=Union@Cases[any,{x_?NumberQ,y_?NumberQ,___},\[Infinity]];
	{xMin,xMax}={Min[#],Max[#]}&@tmp[[All,1]];
	{yMin,yMax}={Min[#],Max[#]}&@tmp[[All,2]];
	{xMin,xMax,yMin,yMax}
];


getAspectRatio[xMin_?NumberQ,xMax_?NumberQ,yMin_?NumberQ,yMax_?NumberQ]:=(xMax-xMin)/(yMax-yMin)


getSurface[mets_]:=Block[{xMin,xMax,yMin,yMax,surface},
{xMin,xMax,yMin,yMax}=getCorners[mets];
surface=Abs[xMin-xMax]*Abs[yMin-yMax];
surface
];


internalBIGGmetID2ID=Import[FileNameJoin[{$ToolboxPath,"Cache/internalBIGGmetID2ID.m"}]];
internalBIGGrxnID2ID=Import[FileNameJoin[{$ToolboxPath,"Cache/internalBIGGrxnID2ID.m"}]];
id2internalBIGGrxnID=Reverse/@internalBIGGrxnID2ID;
id2internalBIGGmetID=Reverse/@internalBIGGmetID2ID;


importBIGGmap::svgNotFound="`1` does not exist.";
Options[importBIGGmap]={"MetaboliteMapping"->internalBIGGmetID2ID,"ReactionMapping"->internalBIGGrxnID2ID,"Mirror"->True};
importBIGGmap[path_String,opts:OptionsPattern[]]:=Module[{xml,textLabels,metabolitePositions,reactionPositions},
If[!FileExistsQ[path],Message[importBIGGmap::svgNotFound,path];Abort[];];
xml=Quiet[XML`Parser`XMLGet[path,svgParser],{XML`Parser`XMLGet::nfprserr}];
textLabels={getTextLabelsMetabolites[#],getTextLabelsReactions[#],getOtherLabels[#]}&[xml];
metabolitePositions=getMetCoords[xml];
textLabels=DeleteCases[textLabels,r_Rule/;r[[1]]>100,\[Infinity]];
reactionPositions=getReactionPositions[xml];
If[OptionValue["Mirror"],#/.{x_?NumberQ,y_?NumberQ,other___}:>{-1*x,y,other},#]&/@({metabolitePositions,reactionPositions,textLabels}/.Dispatch[OptionValue["MetaboliteMapping"]]/.Dispatch[OptionValue["ReactionMapping"]])
];


drawMesh[xMin_Real,xMax_Real,yMin_Real,yMax_Real,part_:5,hLabels_List:CharacterRange["A","Z"],vLabels_List:(ToString/@Range[1,1000])]:=Block[{borders,vLines,hLines,labelCoordinates,labels},
borders=Graphics[{EdgeForm[Directive[Black,Thin]],White,Rectangle[{xMin,yMin},{xMax,yMax}]}];
vLines=Table[Line[{{pos,yMin},{pos,yMax}}],{pos,xMin,xMax,Abs[xMin-xMax]/part}];
hLines=Table[Line[{{xMin,pos},{xMax,pos}}],{pos,yMin,yMax,Abs[yMin-yMax]/part}];
labelCoordinates=Table[{posX,posY},{posX,xMin,xMax,Abs[xMin-xMax]/part},{posY,yMin,yMax,Abs[yMin-yMax]/part}];
labels=Table[Style[Text[hLabels[[i]]<>vLabels[[j]],labelCoordinates[[i,j]]+{150,100}],10,Gray,FontFamily->"Helvetica"],{i,1,Length[labelCoordinates]-1},{j,1,Length[labelCoordinates[[1]]]-1}];
Show[borders,Graphics[{Dashed,Thin,vLines[[2;;-2]]}],Graphics[{Dashed,Thin,hLines[[2;;-2]]}],Graphics[labels]]
];


Options[drawMetaboliteMap]={"Style"->{},"DefaultStyle"->{Lighter@Gray,PointSize[0.01]},"Tooltips"->True,"Hyperlinks"->False};
drawMetaboliteMap[mets_,opts:OptionsPattern[]]:=Block[{surface,metaboliteSize,graphicElements,url,aspectRatio},
aspectRatio=getAspectRatio[Sequence@@getCorners[mets]];
graphicElements=Table[
{Sequence@@If[MemberQ[OptionValue["Style"],elem[[1]],\[Infinity]],elem[[1]]/.OptionValue["Style"],OptionValue["DefaultStyle"]],If[Length[elem[[2]]]>2,Disk[elem[[2,1;;2]],elem[[2,3]]],Point[elem[[2]]]]}
,{elem,mets}];
If[OptionValue["Tooltips"],graphicElements=Thread[Tooltip[graphicElements,mets[[All,1]]]]];
If[OptionValue["Hyperlinks"],graphicElements=Table[
url="http://bigg.ucsd.edu/bigg/view3.pl?type=metabolite&id="<>ToString[(mets[[All,1]][[i]]/.Dispatch[id2internalBIGGmetID])[[1]]]<>"&model=3473243";
Button[graphicElements[[i]],SystemOpen[#]]&[url],{i,1,Length[graphicElements]}]];
Graphics[graphicElements/.elem:(_PointSize):>elem[[0]][elem[[1]]*(1/aspectRatio)]]
];


Options[drawReactionMap]={"AbsentStyle"->{Dotted,Thickness[0.001],Lighter@Gray},"DefaultStyle"->{Thickness[0.002],Gray},"Tooltips"->True,"Style"->{},"Directed"->True,"Arrowheads"->0.01,"Hyperlinks"->False};
drawReactionMap[reactionPositions_List,opts:OptionsPattern[]]:=Block[{rxnCoords,rxnPoints,rxnPos2Curve,color,thickness,defaultStyle,graphicElements,url,out,style,direction,aspectRatio},

defaultStyle=If[OptionValue["Style"]==={},OptionValue["DefaultStyle"],OptionValue["AbsentStyle"]];
aspectRatio=getAspectRatio[Sequence@@getCorners[reactionPositions]];
If[OptionValue["Directed"],
	rxnPos2Curve=If[#[[-1]]===0,BezierCurve[#[[1]]],If[#[[-1]]==#2,
		{(*Arrowheads[OptionValue["Arrowheads"]],*)Arrow[{BezierFunction[Reverse@#[[1]]][If[#[[-1]]===1,.95,.05]],#[[1,#[[-1]]]]}],BezierCurve[#[[1]]]},
		BezierCurve[#[[1]]]
	]]&;
	,
	rxnPos2Curve=BezierCurve[#1[[1]]]&;
];

graphicElements=Table[
{style,direction}=If[MemberQ[OptionValue["Style"],elem[[1]],\[Infinity]],{#[[1;;-2]],#[[-1]]}&[elem[[1]]/.OptionValue["Style"]],{defaultStyle,0}];
{Sequence@@style,rxnPos2Curve[#[[1]],#[[2]]]&/@Thread[List[elem[[2]],direction]]}
,{elem,reactionPositions}
];
If[OptionValue["Tooltips"],graphicElements=Thread[Tooltip[graphicElements,#&/@reactionPositions[[All,1]]]]];
If[OptionValue["Hyperlinks"],
graphicElements=Table[
url="http://bigg.ucsd.edu/bigg/view3.pl?type=reaction&id="<>ToString[(reactionPositions[[All,1]][[i]]/.Dispatch[id2internalBIGGrxnID])[[1]]]<>"&model=3473243";
Button[graphicElements[[i]],SystemOpen[#]]&[url],{i,1,Length[graphicElements]}]
];
Graphics[graphicElements/.elem:(_Thickness|_PointSize|_ArrowHeads):>elem[[0]][elem[[1]]*(1/aspectRatio)]]
];


$SimphenyInternalIDsToNames={"252134"->"iMM904_COMBINED","294177"->"iJR904_Alternate_Carbon_Sources","133267"->"iJR904_Amino_Acid_Metabolism","225959"->"iJR904_Cell_Membrane_Constituents","224016"->"iJR904_Central_Metabolism","303020"->"iJR904_Cofactor_Biosynthesis","305120"->"iJR904_Nucleotide_Metabolism","234509"->"iJR904_COMBINED","1226614"->"iAF1260_Alternate_Carbon_Sources","1230565"->"iAF1260_Amino_Acid_Metabolism","1555394"->"iAF1260_Central_Metabolism","1240422"->"iAF1260_Cofactor_Biosynthesis","1233958"->"iAF1260_Fatty_Acid_Biosynthesis","861115"->"iAF1260_Inorganic_Ion_Transport_(Inner_Membrane)","1243392"->"iAF1260_Lipopolysaccharide_(LPS)_Biosynthesis","651224"->"iAF1260_Murein_Biosynthesis_and_Recycling","1237864"->"iAF1260_Nucleotide_Metabolism","1225142"->"iAF1260_tRNA_Charging","1276939"->"iAF1260_COMBINED","745364"->"Recon1_AMINO_ACID_METABOLISM","607474"->"Recon1_CARBOHYDRATE_METABOLISM","854888"->"Recon1_ENERGY_METABOLISM","681892"->"Recon1_GLYCAN_METABOLISM","1103958"->"Recon1_LIPID_METABOLISM","700994"->"Recon1_NUCLEOTIDE_METABOLISM","821108"->"Recon1_SECONDARY_METABOLITES","851235"->"Recon1_VITAMIN_&_COFACTOR_METABOLISM","1014133"->"Recon1_COMBINED","22199"->"iND750_Amino_Acid_Metabolism","35089"->"iND750_Cofactor_and_Vitamin_Biosynthesis","38537"->"iND750_Lipid_Metabolism","20179"->"iND750_Nucleotide_Metabolism","666364"->"iND750_COMBINED","382379"->"iAF692_Vitamin_and_Cofactor_Biosynthesis","441083"->"iAF692_Nucleotide_Metabolism","447592"->"iAF692_COMBINED","549"->"iIT341_Central_Metabolism","503671"->"iIT341_Co-set_Order","387841"->"iIT341_COMBINED","340794"->"iSB619_Amino_Acid_Metabolism","340815"->"iSB619_Biomass","340795"->"iSB619_Central_Metabolism","340806"->"iSB619_Cofactor_Biosynthesis","385801"->"iSB619_Heme_Biosynthesis","340797"->"iSB619_Oxidative_Phosphorylation","340798"->"iSB619_Pentose_Phosphate","340800"->"iSB619_Purine/Pyrimidine_Metabolism","390808"->"iSB619_COMBINED","1576807"->"EcoliCore_coreMap","1148996"->"iNJ661_COMBINED"};
$AVAILABLEMAPS=StringReplace[FileNameSplit[#][[-1]],"_toolbox.json.gz"->""]->#&/@FileNames["*.gz",{FileNameJoin[{$ToolboxPath,"maps","bigg_maps"}]}];
$AVAILABLEMAPS=Select[$AVAILABLEMAPS,!StringMatchQ[#[[1]],RegularExpression["^\\d+"]]&];


Options[drawPathway]={"CompoundLabels"->True,"ReactionLabels"->True,"TextLabels"->False,"MinMaxHack"->False,"PlotLegends"->None,"Tooltips"->True,"ColorFunctionScaling"->True,"Boundary"->False,"ReactionData"->{},"MetaboliteData"->{},ColorFunction->ColorData["Rainbow"],"MinSize"->0.005,"MaxSize"->0.01,"MinThickness"->0.001,"MaxThickness"->0.003,"TextStyle"->{FontFamily->"Arial",FontSize->Scaled[.008]},"MetaboliteStyle"->Options[drawMetaboliteMap],"ReactionStyle"->Options[drawReactionMap],ImageSize->350};
drawPathway::unknownmap="Map `1` is not available. Try drawPathway[] to see a list of available maps";
drawPathway[]:=Sort[$AVAILABLEMAPS[[All,1]]]
drawPathway[mapID_String,opts:OptionsPattern[{drawPathway,drawReactionMap,drawMetaboliteMap}]]:=Module[{cmpdPos,rxnPos,finalLabels,mapData,cmpdLabels,rxnLabels,textLabels},
	If[MemberQ[$AVAILABLEMAPS[[All,1]],mapID], mapData=Import[mapID/.$AVAILABLEMAPS], Message[drawPathway::unknownmap,mapID];Abort[];];
	cmpdPos=Flatten[query["cmpd_pos",mapData,{}]];
	rxnPos=query["rxn_pos",mapData];
	cmpdLabels = Text[#[[1]], #[[2,2]]]&/@Flatten[query["cmpd_label_pos", mapData, {}]];
	rxnLabels = Text@@@query["rxn_label_pos", mapData, {}];
	textLabels = Text@@@query["text_label_pos", mapData, {}];
	finalLabels={};
	If[OptionValue["CompoundLabels"]==True, finalLabels=Join[cmpdLabels,finalLabels];];
	If[OptionValue["TextLabels"]==True, finalLabels=Join[textLabels,finalLabels];];
	If[OptionValue["ReactionLabels"]==True, finalLabels=Join[rxnLabels,finalLabels];];
	drawPathway[cmpdPos,DeleteCases[rxnPos,{"NaN","NaN"},\[Infinity]](*TODO: fix this in the maps*),finalLabels,opts]
];
drawPathway[metPos:{_Rule..},rxnPos:{_Rule..},textPos:({(_Text|_Rule|_Style)..}|{}),opts:OptionsPattern[{drawPathway,drawReactionMap,drawMetaboliteMap}]]:=Module[{refMin,refMax,helperFunc,min,max,directedQ,map,fluxStyle,metStyle,cellMembrane,corners,aspectRatio,cleanRxnData,scalingFunction,cleanMetaboliteData},
	directedQ="Directed"/.(ToString[#[[1]]]->#[[2]]&/@OptionValue["ReactionStyle"]);
	corners=getCorners[rxnPos];
	aspectRatio=getAspectRatio[Sequence@@corners];
	
	cleanRxnData=FilterRules[OptionValue["ReactionData"]/.elem_v:>getID[elem],rxnPos[[All,1]]];
	If[OptionValue["MinMaxHack"]===True,
		refMax=Max[Abs[{Min[#],Max[#]}&[cleanRxnData[[All,2]]]]];
		cleanRxnData=Join[cleanRxnData,{"Max"->refMax,"Moritz"->-refMax}];
	];
	If[MatchQ[OptionValue["MinMaxHack"],{_?NumberQ,_?NumberQ}],
		{refMin,refMax}=OptionValue["MinMaxHack"];
		cleanRxnData=Join[cleanRxnData,{"Max"->refMin,"Moritz"->refMax}];
	];
	
	scalingFunction=Switch[OptionValue["ColorFunctionScaling"],True,If[directedQ,Rescale[Abs@#,{Min[Abs@#],Max[Abs@#]},{0.,1.}]&,Rescale[#,{Min[#],Max[#]},{0.,1.}]&],_Function,OptionValue["ColorFunctionScaling"],False,#&];
	cleanMetaboliteData=FilterRules[OptionValue["MetaboliteData"]/.elem:$MASS$speciesPattern:>getID[elem],metPos[[All,1]]];
	If[directedQ,
		fluxStyle=Thread[Rule[cleanRxnData[[All,1]]/.elem_v:>getID[elem],Thread[List[Arrowheads/@Rescale[Abs@#,{Min[Abs@#],Max[Abs@#]},{OptionValue["MinThickness"]*(5/aspectRatio),OptionValue["MaxThickness"]*(5/aspectRatio)}],Thickness/@Rescale[Abs@#,{Min[Abs@#],Max[Abs@#]},{OptionValue["MinThickness"],OptionValue["MaxThickness"]}],OptionValue["ColorFunction"]/@scalingFunction[#],-1*Sign[#]]]]]&[cleanRxnData[[All,2]]];,
		fluxStyle=Thread[Rule[cleanRxnData[[All,1]]/.elem_v:>getID[elem],Thread[List[Thickness/@Rescale[Abs@#,{Min[Abs@#],Max[Abs@#]},{OptionValue["MinThickness"],OptionValue["MaxThickness"]}],OptionValue["ColorFunction"]/@scalingFunction[#],-1*Sign[#]]]]]&[cleanRxnData[[All,2]]];
	];

	metStyle=Thread[Rule[cleanMetaboliteData[[All,1]],Thread[List[PointSize/@Rescale[#,{Min[#],Max[#]},{OptionValue["MinSize"],OptionValue["MaxSize"]}],OptionValue["ColorFunction"]/@scalingFunction[#](*Rescale[#,{Min[#],Max[#]},{0.,1.}]*)]]]]&[cleanMetaboliteData[[All,2]]];
	If[OptionValue["Boundary"],
		cellMembrane=Graphics[{Opacity[0.],EdgeForm[{Thin,Black}],Scale[#,.99]&@Rectangle[Sequence@@Partition[corners[[{1,3,2,4}]],2],RoundingRadius->Scaled[.1]]}];,
		cellMembrane=Sequence[];,
		cellMembrane=Sequence[];
	];
	map=Show[
		cellMembrane,
		drawReactionMap[rxnPos,Sequence@@updateRules[OptionValue["ReactionStyle"],{"Style"->fluxStyle}],Sequence@@FilterRules[List@opts,Options[drawReactionMap]]]/.(Tooltip[graphics_,#[[1]]]:>Tooltip[graphics,#[[1]](*<>": "<>ToString[#[[2]]]*)]&/@cleanRxnData),
		drawMetaboliteMap[metPos,Sequence@@updateRules[OptionValue["MetaboliteStyle"],If[metStyle=!={},{"Style"->metStyle},{}]],Sequence@@FilterRules[{opts},Options[drawMetaboliteMap]]],Graphics@Style[textPos,Sequence@@(OptionValue["TextStyle"]/.elem:(_Scaled):>elem[[0]][elem[[1]]*(1/aspectRatio)])],
		ImageSize->OptionValue["ImageSize"]
	];
	map=If[OptionValue["PlotLegends"]=!=None&&OptionValue["ReactionData"]=!={},
		{min,max}={If[directedQ,0,Min[#]],If[directedQ,Max@Abs@#,Max@#]}&[cleanRxnData[[All,2]]];
		helperFunc=Composition[#,With[{minn=min,maxx=max},Rescale[#,{minn,maxx},{0.,1.}]&]]&;
		Legended[map,BarLegend[{If[MatchQ[OptionValue["ColorFunction"],_ColorDataFunction],OptionValue["ColorFunction"][[1]],helperFunc[OptionValue["ColorFunction"]][#]&],{min,max}},If[MatchQ[OptionValue["PlotLegends"],{_Rule..}],Sequence@@OptionValue["PlotLegends"],Unevaluated[Sequence[]]]]],map];
	map
];


(* ::Subsection:: *)
(*Node maps*)


distributeSinks[sinks_List/;Length[sinks]===1]:=Thread[sinks->{{1,0}}]
distributeSinks[sinks_List]:=Module[{num,start,end,interval},
	num=Length[sinks];
	start=Pi/Max[{num,3}];
	end=Pi-start;
	interval=(end-start)/(If[#===0,1,#]&[num-1]);
	Thread[sinks->({Sin[#],Cos[#]}&/@NestList[interval+#1&,start,num-1])]
];
distributeSources[sources_List/;Length[sources]==1]:=Thread[sources->{{-1,0}}]
distributeSources[sources_List]:=Module[{num,start,end,interval},
	num=Length[sources];
	start=Pi/Max[{num,3}];
	end=Pi-start;
	interval=(end-start)/(If[#===0,1,#]&[num-1]);
	Thread[sources->({Sin[#],Cos[#]}&/@NestList[interval+#1&,start+Pi,num-1])]
];

nodeMapCoordinates[nodeMap:{{_Rule,(_?NumberQ|_Quantity)}...}]:=Module[{sortedNodeMap,sources,sinks},
	sortedNodeMap=SortBy[nodeMap,#[[2]]&];
	sources=Cases[sortedNodeMap,r_Rule/;r[[1,0]]===v,\[Infinity]][[All,1]];
	sinks=Cases[sortedNodeMap,r_Rule/;r[[2,0]]===v,\[Infinity]][[All,2]];
	Join[distributeSources[sources],distributeSinks[sinks]]
];


Options[drawNodeMaps]={"Fluxes"->{},"Metabolites"->{},ColorFunction->ColorData["Rainbow"],"Legend"->False};
drawNodeMaps[model_MASSmodel,opts:OptionsPattern[{drawNodeMaps,GraphPlot}]]:=Module[{unitlessFluxes,stoichRules,minFlux,maxFlux,colorFunction,activeFluxes,directions,bip,activeBip,nodeMapGraphs,edgeThicknesses,colorValues,edgeRenderingFunc,nodeRenderingFunc,metabolites,legendFunc,netFluxes},
	stoichRules={model["Species"][[#[[1,1]]]],model["Fluxes"][[#[[1,2]]]]}->Abs[#[[2]]]&/@ArrayRules[model["SparseStoichiometry"]][[;;-2]];
	colorFunction=If[OptionValue["Fluxes"]==={},Black&,OptionValue["ColorFunction"]];
	netFluxes=Thread[model["Species"]->model.model["Fluxes"]];
	metabolites=If[OptionValue["Metabolites"]==={},model["Species"],OptionValue["Metabolites"]];
	activeFluxes=If[OptionValue["Fluxes"]==={},Thread[model["Fluxes"]->0],OptionValue["Fluxes"]];
	unitlessFluxes=stripUnits[activeFluxes];
	directions=#[[1]]->If[#[[2]]<0,"Reverse","Forward"]&/@unitlessFluxes;
	(*Generate a bipartite network representation of model; each edge contains the direction as a label: {{v -> m}}*)
	bip=model2bipartite[model,"EdgeDirections"->True];
	(*Get rid of edges that don't contain metabolites of interest*)
	bip=Select[bip,MemberQ[#,Alternatives@@metabolites,\[Infinity]]&];
	activeBip=Select[bip,(Cases[#,_v,\[Infinity]][[1]]/.Dispatch[directions])==#[[2]]&];
	nodeMapGraphs=SortBy[Select[#->Cases[activeBip,r_Rule/;MemberQ[r,#],\[Infinity]]&/@metabolites,#[[2]]!={}&],-Length[#[[2]]]&];
	nodeMapGraphs=Table[elem[[1]]->({#,If[#[[1,0]]===metabolite,Abs[((List@@#)/.Dispatch[stoichRules])*#[[2]]/.Dispatch[activeFluxes]],Abs[(Reverse[List@@#]/.Dispatch[stoichRules])*#[[1]]/.Dispatch[activeFluxes]]]}&/@elem[[2]]),{elem,nodeMapGraphs}];
	{minFlux,maxFlux}={Min[#],Max[#]}&[Abs@stripUnits[Flatten[nodeMapGraphs[[All,2,All,2]]]]];
	edgeRenderingFunc=({colorFunction[Rescale[stripUnits@#3,{minFlux,maxFlux},{0,1}]],Thickness[Rescale[stripUnits@#3,{minFlux,maxFlux},{0.001,0.02}]],Arrowheads[Max[{3*Rescale[stripUnits@#3,{minFlux,maxFlux},{0.001,0.02}],.02}]],Arrow[#,{.1,.1}],If[OptionValue["Fluxes"]=!={},Style[Text[#3/.{Quantity[num_?NumberQ,units_]:>Quantity[Round[Abs[num],.001],units],num_?NumberQ:>Round[Abs[num],.001]},Mean@#1,Background->Opacity[.8,White]],Black,FontFamily->"Helvetica",FontSize->Scaled[.02]]]}&);
	nodeRenderingFunc=({Style[Text[#2,#1],FontSize->Scaled[.02]]}&);
	legendFunc=If[OptionValue["Legend"]===True&&OptionValue["Fluxes"]=!={},Legended[#,Rasterize@BarLegend[{colorFunction[[1]],{0,maxFlux}},LegendLabel->"Flux\nmmol \!\(\*SuperscriptBox[\(h\), \(-1\)]\) \!\(\*SuperscriptBox[\(gDW\), \(-1\)]\)",LabelStyle->{FontFamily->"Helvetica"}]]&,#&];
	#[[1]]->legendFunc[GraphPlot[#[[2]],VertexCoordinateRules->Join[N@nodeMapCoordinates[#[[2]]],{#[[1]]->{0,0}}],PlotStyle->Gray,VertexLabeling->True,ImageSize->600,EdgeRenderingFunction->edgeRenderingFunc,VertexRenderingFunction->nodeRenderingFunc,PlotLabel->Style[#,Which[#[[1,2,1]]<0,Red,#[[1,2,1]]>0,Green,True,Black],FontFamily->"Helvetica",FontSize->Scaled[.025]]&[Row[{"Net flux: ",ScientificForm@Chop[#[[1]]/.netFluxes/.activeFluxes/._v->0]}]],Sequence@@FilterRules[{opts},Options[GraphPlot]]]]&/@nodeMapGraphs
];


(* ::Subsection:: *)
(*End*)


End[]
