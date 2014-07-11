(* ::Package:: *)

(* ::Title:: *)
(*Design*)


Begin["`Private`"]


Options[differentialFVA]={"FVASolver"->GurobiFVA,"Points"->10,"ImprovementsOnly"->True};
differentialFVA[designSpaceModel_MASSmodel,referenceModel_MASSmodel,cellularObjective_,productionObjective_,opts:OptionsPattern[]]:=Module[{completeEnvelope,referenceFVA,refProductionInterval,maxCellularObjectiveReferenceModel,normReferenceFVA,envelope,points2scan,progress,fluxRangeScan,fluxRangeScanNormalized,normalizedIntervalPairs,fluxRangeOverlaps,fluxRangeGaps,maxDistanceBetweenLbAndUb,stepSize},
PrintTemporary["Determining flux ranges for reference model ..."];
referenceFVA=fva[referenceModel,Solver->GurobiFVA];
(*referenceFVA=If[Head[#[[1]]]===String,v[#[[1]]],#[[1]]]\[Rule]#[[2]]&/@referenceFVA;*)
maxCellularObjectiveReferenceModel=(cellularObjective/.referenceFVA)[[2]];
normReferenceFVA=#[[1]]->#[[2]]/maxCellularObjectiveReferenceModel&/@referenceFVA;
PrintTemporary["Determining production envolope for design space model ..."];
envelope=productionEnvelope[designSpaceModel,cellularObjective,productionObjective,Sequence@@FilterRules[updateRules[Options[differentialFVA],List@opts],Options[productionEnvelope]]];
completeEnvelope=envelope;
If[OptionValue["ImprovementsOnly"],
refProductionInterval=(productionObjective/.Dispatch[referenceFVA]);
envelope=Transpose[Select[Thread[envelope],#[[3]]>refProductionInterval[[2]]&]];
envelope[[2]]=If[refProductionInterval[[1]]>#,refProductionInterval[[1]],#]&/@envelope[[2]];
];
maxDistanceBetweenLbAndUb=SortBy[Thread[envelope[[{2,3}]]],Abs[Subtract@@#]&][[-1]];
stepSize=(#[[2]]-#[[1]])/(OptionValue["Points"]-1)&[maxDistanceBetweenLbAndUb];
points2scan=Flatten[Table[NestWhileList[{envelope[[1,i]],#[[2]]+stepSize}&,{envelope[[1,i]],envelope[[2,i]]},#[[2]]<(envelope[[3,i]]-stepSize)&],{i,1,Length[envelope[[2]]]}],1];
points2scan=Union[points2scan,Thread[envelope[[{1,2}]]],Thread[envelope[[{1,3}]]]];
progress=points2scan;
(*points2scan=Reverse@Transpose[envelope[[{1(*objective1*),-1(*upper bound objective 2*)}]]];*)
progress={};
Monitor[
fluxRangeScan=Table[
AppendTo[progress,elem];
Thread[{cellularObjective,productionObjective}->elem]->(*Pause[.1]*)fva[designSpaceModel,{cellularObjective->{elem[[1]],elem[[1]]},productionObjective->{elem[[2]],elem[[2]]}},Solver->GurobiFVA],{elem,points2scan}],
(*Progress plot*)
ListPlot[{Thread[{completeEnvelope[[1]],completeEnvelope[[2]]}],Thread[{completeEnvelope[[1]],completeEnvelope[[3]]}],If[progress!={},progress,Unevaluated[]]},Joined->True,PlotMarkers->Automatic,Filling->{1->{{2},Lighter@Gray}},PlotStyle->{Directive[Black],Directive[Black],Directive[Red,Thick]},FrameLabel->{cellularObjective,productionObjective},PlotLegends->{"lower bound","upper bound","scanning progress"}]
];
SetDirectory[NotebookDirectory[]];
(*fluxRangeScan=Import["results/Beta_alanine_pathway_model_fva_increasing_3hp_demand_1.1_physiologically_constrained.wdx"]/.r_Rule/;r[[1,0]]\[Equal]String\[RuleDelayed](v[r[[1]]]\[Rule]r[[2]]);*)
fluxRangeScanNormalized=Table[elem[[1]]->(#[[1]]->#[[2]]/elem[[1,1,2]]&/@elem[[2]]),{elem,Select[fluxRangeScan,#[[1,1,2]]!=0&]}];
(*intervalPairs=Table[elem[[1]]->(scatterFromDicts[referenceFVA,elem[[2]]]/.{a_?NumberQ,b_?NumberQ}/;b<a:>{a,a}),{elem,fluxRangeScan}];*)
normalizedIntervalPairs=Table[elem[[1]]->(scatterFromDicts[normReferenceFVA,elem[[2]]]/.{a_?NumberQ,b_?NumberQ}/;b<a:>{a,a}),{elem,fluxRangeScanNormalized}];
fluxRangeOverlaps=Table[elem[[1]]->(#[[1]]->intervalOverlap[Sequence@@#[[2]]]&/@elem[[2]]),{elem,normalizedIntervalPairs}];
fluxRangeGaps=Table[elem[[1]]->(#[[1]]->intervalGaps[Sequence@@#[[2]]]&/@elem[[2]]),{elem,normalizedIntervalPairs}];
{"ReferenceModelFluxRanges"->referenceFVA,"FluxRangeScan"->fluxRangeScan,"NormalizedFluxRangeScan"->fluxRangeScanNormalized,"FluxRangeOverlaps"->fluxRangeOverlaps,"FluxRangeGaps"->fluxRangeGaps,"KOs"->{},"NormalizedFluxRangePairs"->normalizedIntervalPairs,"Envelope"->envelope}
];


generateDiffFvaReport[dFVAresult_List,pathwayID_String,model_MASSmodel,path_String,replacmentStuff_List]:=Module[{rxn2genes,rxnID2rxns,redgreenblack,path2,i=1,j=1,fluxRangePlot,fluxRangePairs,fluxRangeTooltips,fluxRangeGaps,elem,elem2,rID,rngPlt,envelope,envelopePlot,overlapPlots,refPoint},
redgreenblack=Blend[{Red,Black,Green},#]&;
rxn2genes=model["GeneAssociations"];
rxnID2rxns=getID[#]->#&/@model["Reactions"];
If[StringTake[path,1]!="/",path2=FileNameJoin[{NotebookDirectory[],path}],path2=path];
PrintTemporary["Generating tooltips ..."];
fluxRangePlot=Graphics[MapIndexed[{ColorData[1][First@#2],Thickness[.1],Line[#]}&,MapIndexed[Thread[{First@#2,#}]&,#]],Frame->{True,True,False,False},FrameTicks->{{{1,"Ref."},{2,"Target"}},Automatic,None,None},FrameLabel->{None,#2},AspectRatio->3,PlotRangePadding->Scaled[.1]]&;
fluxRangePairs=("NormalizedFluxRangePairs"/.dFVAresult);
fluxRangeGaps=("FluxRangeGaps"/.dFVAresult);
Monitor[
fluxRangeTooltips=Table[
elem=fluxRangePairs[[i]];
(*elem[[2]]=FilterRules[elem[[2]],Select[fluxRangeGaps[[i,2]],#[[2]]\[NotEqual]0&]];*)
elem[[1]]->Table[
elem2=elem[[2,j]];
rID=getID[elem2[[1]]];
rngPlt=Column[{rID,
rID/.Dispatch[model["Synonyms"]],
rID/.Dispatch[rxn2genes]/.pat:(_gene|_protein):>getID[pat](*/.Dispatch[gene2synonym]*),ToString[rID/.Dispatch[rxnID2rxns]],StringReplace[ToString[rID/.Dispatch[rxnID2rxns]/.Dispatch[model["Synonyms"]]],RegularExpression["^.*: "]->""],Row@{fluxRangePlot[elem2[[2]],"Flux range"]," ",fluxRangePlot[elem2[[2]]*elem[[1,1,2]],"Norm. flux range"]}}];
rID->rngPlt,{j,1,Length[elem[[2]]]}],{i,1,Length[fluxRangePairs]}
];,Column[{ProgressIndicator[j,{1,Length[elem[[2]]]}],ProgressIndicator[i,{1,Length[fluxRangePairs]}]}]];
(*fluxRangeTooltips={};*)
envelope="Envelope"/.dFVAresult;
fluxRangeGaps=("FluxRangeGaps"/.dFVAresult);
refPoint=(fluxRangeGaps[[1,1,All,1]]/.("ReferenceModelFluxRanges"/.dFVAresult))[[All,2]];
envelopePlot=ListPlot[{Thread[{envelope[[1]],envelope[[2]]}],Thread[{envelope[[1]],envelope[[3]]}],{refPoint}},Joined->True,PlotMarkers->Automatic,FrameLabel->{"Growth","3HP"},PlotLegends->{"lower bound","upper bound","ST938"}];

PrintTemporary["Generating pathway drawings ..."];

Monitor[
overlapPlots=Table[
elem=fluxRangeGaps[[i]];
Column[{elem[[1]],drawPathway[pathwayID,ReactionData->Select[Chop@elem[[2]],Abs[#[[2]]]>1*^-6&],ReactionStyle->{Directed->False},ImageSize->800,PlotLegends->True,ColorFunction->redgreenblack,"MinMaxHack"->True,Boundary->False]/.Dispatch[elem[[1]]/.fluxRangeTooltips]/.replacmentStuff,Show[envelopePlot,Graphics[{Red,Dashed,Arrow[{refPoint,elem[[1,All,2]]}]}]]}],{i,1,Length[fluxRangeGaps]}],ProgressIndicator[i,{1,Length[fluxRangeGaps]}]];
PrintTemporary["Writing report to "<>path2<>" ..."];
notebookObj=CreateDocument[{SlideView[(overlapPlots),AppearanceElements->All]}];
NotebookSave[notebookObj,path2]
]


End[]
