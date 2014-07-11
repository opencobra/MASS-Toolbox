(* ::Package:: *)

(* ::Title:: *)
(*COBRA*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


Quiet@Get["GurobiML`"]


(*Warning and Error messages*)
Toolbox::Exists="Entity `1` already exists.";
Toolbox::NotImplemented="Function/Structure `1` has not been implemented yet.";
Toolbox::badargs="There is no definition for '``' applicable to ``."


(* ::Subsection:: *)
(*COBRA methods*)


(* ::Subsubsection:: *)
(*FBA & FVA*)


Unprotect[fba];
(*Options[fba]=Join[{"OptFlag"->"Max","Solver"->LinearProgramming,"Loopless"->False,"Minimize"->False},Options[LinearProgramming]];*)
Options[fba]={"OptFlag"->"Max","Solver"->LinearProgramming,"Loopless"->False,"Minimize"->False};
fba::noObjProvided="No objective provided. Optimizing `1`. An objective can be provided via fba[model, objective].";
fba::objdimension="Objective vector (size:`1`) should have a compatible shape with the provide matrix (`2`).";
fba::rxnnotexist="Reaction `1` in objective specification does not exist in problem description.";
fba::solverSolutionProblem="Unexpected solution `1` returned by `2`.";
fba::Minimize="`1` is not a valid norm specification. Try 'EuclideanDistance' or 'ManhattanDistance' instead.";
fba::MinimizeSolverNotSupported="Solver `` does not support QP";
fba[model_MASSmodel,bounds:({_Rule..}|{}):{},opts:OptionsPattern[{fba,LinearProgramming}]]:=Module[{guess,obj},
	If[model["Objective"]===Automatic,
		guess=Cases[model["Fluxes"],flux_v/;StringMatchQ[getID[flux],RegularExpression["(?i).*biomass.*"]]];
		obj=If[MatchQ[guess,{_v..}],guess[[1]],model["Fluxes"][[1]]];Message[fba::noObjProvided,obj];,
		obj=model["Objective"]
	];
	fba[model,obj,bounds,opts]
];

(*fba[model_MASSmodel,obj_,bounds:({_Rule..}|{}):{},opts:OptionsPattern[{fba,LinearProgramming}]]:=Module[{solution,internalObj,mat,rhs,internalBounds,objpos},
	{internalObj,mat,rhs,internalBounds}=model2LinearProgrammingData[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[model2LinearProgrammingData]]];
	
	If[OptionValue["Loopless"],
		solution=looplessFBA[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[looplessFBA]]],
		solution=Check[OptionValue["Solver"][Sequence@@model2LinearProgrammingData[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[model2LinearProgrammingData]]],Sequence@@FilterRules[List@opts,Options[OptionValue["Solver"]]]],Indeterminate,{LinearProgramming::lpsnf,DualLinearProgramming::lpsnf,GurobiSolve::lowlevelmessage}];
	];
	If[OptionValue["Minimize"]=!=False&&OptionValue["Solver"]=!=GurobiSolve,Message[fba::MinimizeSolverNotSupported,OptionValue["Solver"]];Abort[];];
	solution=Switch[OptionValue["Minimize"],
		False, solution,
		True|EuclideanDistance, objpos=Flatten@Position[internalObj,_?(#!=0&)]; OptionValue["Solver"][{Array[0&,Dimensions[model][[2]]],IdentityMatrix[Dimensions[model][[2]]]},mat,rhs,ReplacePart[internalBounds,Thread[objpos->({#,#}&/@solution[[objpos]])]],Sequence@@FilterRules[List@opts,Options[OptionValue["Solver"]]]],
		(*ManhattanDistance, Message[Toolbox::NotImplemented,"Minimization of the Manhattan distance"];Abort[];,*)
		ManhattanDistance, splitModel=splitReversible,
		_,Message[fba::Minimize,OptionValue["Minimize"]];Abort[]; 
	];
	Switch[solution,
		{(_?NumberQ|Indeterminate|\[Infinity]|-\[Infinity])..}|Indeterminate,Thread[Rule[model["Fluxes"],solution]],
		dualSol:{{(_?NumberQ|Indeterminate|\[Infinity]|-\[Infinity])..}..}/;Length[dualSol]==4,{Thread[Rule[model["Fluxes"],solution[[1]]]],Thread[Rule[model["Species"],solution[[2]]]],Thread[Rule[model["Fluxes"],solution[[3]]]],Thread[Rule[model["Fluxes"],solution[[4]]]]},
		_,Message[fba::solverSolutionProblem,Short@solution,OptionValue["Solver"]];Abort[];
	]
];*)
fba[model_MASSmodel,obj_,bounds:({_Rule..}|{}):{},opts:OptionsPattern[{fba,LinearProgramming}]]:=Module[{fluxes,splitModel,firstSolution,revFluxes,revFluxesStripped,newFluxes,adjustedRevFluxes,solution,internalObj,mat,rhs,internalBounds,objpos},
	
	(*If[OptionValue["Minimize"]=!=False&&OptionValue["Solver"]=!=GurobiSolve,Message[fba::MinimizeSolverNotSupported,OptionValue["Solver"]];Abort[];];*)
	(*{internalObj,mat,rhs,internalBounds}=model2LinearProgrammingData[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[model2LinearProgrammingData]]];*)
	Switch[OptionValue["Minimize"],
		False,
			
			If[OptionValue["Loopless"],
				solution=looplessFBA[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[looplessFBA]]],
				solution=Check[OptionValue["Solver"][Sequence@@model2LinearProgrammingData[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[model2LinearProgrammingData]]],Sequence@@FilterRules[List@opts,Options[OptionValue["Solver"]]]],Indeterminate,{LinearProgramming::lpsnf,DualLinearProgramming::lpsnf,GurobiSolve::lowlevelmessage}];
			];,
		True|ManhattanDistance,
			splitModel=splitReversible[model];
			{internalObj,mat,rhs,internalBounds}=model2LinearProgrammingData[splitModel,obj,bounds,Sequence@@FilterRules[List@opts,Options[model2LinearProgrammingData]]];
			firstSolution=OptionValue["Solver"][internalObj,mat,rhs,internalBounds,Sequence@@FilterRules[List@opts,Options[OptionValue["Solver"]]]];
			solution=OptionValue["Solver"][Array[1&,Length[internalObj]],Append[mat,internalObj],Append[rhs,{internalObj.firstSolution*.99,-1}],internalBounds,Sequence@@FilterRules[List@opts,Options[OptionValue["Solver"]]]];
			fluxes=Thread[Rule[splitModel["Fluxes"],solution]];
			revFluxes=Select[fluxes,StringMatchQ[getID[#[[1]]],RegularExpression[".*_Rev$"]]&];
			revFluxesStripped=v[StringTake[getID@#[[1]],{1,-5}]]->#[[2]]&/@revFluxes;
			newFluxes=FilterRules[fluxes,Except[revFluxes]];
			adjustedRevFluxes=#[[1]]->Subtract@@#[[2]]&/@scatterFromDicts[newFluxes,revFluxesStripped];
			Return[Join[FilterRules[newFluxes,Except[#]],#]&[adjustedRevFluxes]]
			,
		EuclideanDistance,
			{internalObj,mat,rhs,internalBounds}=model2LinearProgrammingData[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[model2LinearProgrammingData]]];
			objpos=Flatten@Position[internalObj,_?(#!=0&)];
			solution=OptionValue["Solver"][{Array[0&,Dimensions[model][[2]]],IdentityMatrix[Dimensions[model][[2]]]},mat,rhs,ReplacePart[internalBounds,Thread[objpos->({#,#}&/@solution[[objpos]])]],Sequence@@FilterRules[List@opts,Options[OptionValue["Solver"]]]],
		_,Message[fba::Minimize,OptionValue["Minimize"]];Abort[]; 
	];
	Switch[solution,
		{(_?NumberQ|Indeterminate|\[Infinity]|-\[Infinity])..}|Indeterminate,Thread[Rule[model["Fluxes"],solution]],
		dualSol:{{(_?NumberQ|Indeterminate|\[Infinity]|-\[Infinity])..}..}/;Length[dualSol]==4,{Thread[Rule[model["Fluxes"],solution[[1]]]],Thread[Rule[model["Species"],solution[[2]]]],Thread[Rule[model["Fluxes"],solution[[3]]]],Thread[Rule[model["Fluxes"],solution[[4]]]]},
		_,Message[fba::solverSolutionProblem,Short@solution,OptionValue["Solver"]];Abort[];
	]
];
def:fba[stuff___]:=(Message[Toolbox::badargs,1,ToString@stuff];Abort[])
Protect[fba];


Unprotect[looplessFBA];
Options[looplessFBA]=Options[fba];
looplessFBA[model_MASSmodel,obj_,bounds:({_Rule..}|{}):{},opts:OptionsPattern[]]:=Module[{solution},
	solution=Quiet[Check[
				OptionValue["Solver"][Sequence@@model2LooplessFbaFormulation[model,obj,bounds,Sequence@@FilterRules[List@opts,Options[model2LooplessFbaFormulation]]],Sequence@@FilterRules[List@opts,Options[OptionValue["Solver"]]]]
			,Indeterminate,LinearProgramming::lpsnf]
			,LinearProgramming::lpip];
	solution[[1;;Length[model["Fluxes"]]]]
];
def:looplessFBA[___]:=(Message[Toolbox::badargs,fba,Defer@def];Abort[])
Protect[looplessFBA];


(*Unprotect[fva];
Options[fva]=updateRules[FilterRules[Options[fba],Except[{"OptFlag"}]],{"ProgressBar"->True}];
fva[model_MASSmodel,bounds:({_Rule..}|{}):{},opts:OptionsPattern[]]:=Module[{maxTmp,minTmp,result,progressBarQ,rxns,i},
	If[OptionValue["Solver"]===GurobiFVA,
		result=GurobiFVA[model,bounds],
		progressBarQ=If[$FrontEnd=!=Null,OptionValue["ProgressBar"],False];
		rxns=getID/@model["Fluxes"];
		result=If[progressBarQ,
		Monitor[
			ReleaseHold[#],ProgressIndicator[i,{1,Length[rxns]}]],
			ReleaseHold[#]
		]&@Hold[Table[
		minTmp=Quiet[Check[v[rxns[[i]]]/.fba[model,rxns[[i]],bounds,"OptFlag"->"MIN",FilterRules[{opts}, Options[fba]]],-\[Infinity],LinearProgramming::lpsub],{LinearProgramming::lpsub}];
		maxTmp=Quiet[Check[v[rxns[[i]]]/.fba[model,rxns[[i]],bounds,"OptFlag"->"MAX",FilterRules[{opts}, Options[fba]]],\[Infinity],LinearProgramming::lpsub],{LinearProgramming::lpsub}];
		v[rxns[[i]]]->{minTmp,maxTmp},{i,1,Length[rxns]}]];
	];
	result
];
def:fva[___]:=(Message[Toolbox::badargs,fva,Defer@def];Abort[])
Protect[fva];*)

Unprotect[fva];
Options[fva]=updateRules[FilterRules[Options[fba],Except[{"OptFlag"}]],{"ProgressBar"->True}];
fva[model_MASSmodel,bounds:({_Rule..}|{}):{},opts:OptionsPattern[]]:=Module[{maxTmp,minTmp,result,progressBarQ,rxns,i,j},
	If[OptionValue["Solver"]===GurobiFVA,
		result=GurobiFVA[model,bounds],
		progressBarQ=If[$FrontEnd=!=Null,OptionValue["ProgressBar"],False];
		rxns=getID/@model["Fluxes"];
		SetSharedVariable[j];j=0;
		result=If[progressBarQ,
		Monitor[
			ReleaseHold[#],ProgressIndicator[j,{1,Length[rxns]}]],
			ReleaseHold[#]
		]&@Hold[ParallelTable[
		j++;
		minTmp=Quiet[Check[v[rxns[[i]]]/.fba[model,rxns[[i]],bounds,"OptFlag"->"MIN",FilterRules[{opts}, Options[fba]]],-\[Infinity],LinearProgramming::lpsub],{LinearProgramming::lpsub}];
		maxTmp=Quiet[Check[v[rxns[[i]]]/.fba[model,rxns[[i]],bounds,"OptFlag"->"MAX",FilterRules[{opts}, Options[fba]]],\[Infinity],LinearProgramming::lpsub],{LinearProgramming::lpsub}];
		v[rxns[[i]]]->{minTmp,maxTmp},{i,1,Length[rxns]},DistributedContexts:>{"Global`","Toolbox`","GurobiML`","GurobiML`GurobiML`"}]];
	];
	result
];
def:fva[___]:=(Message[Toolbox::badargs,fva,Defer@def];Abort[])
Protect[fva];


Unprotect[reduceModel];
Options[reduceModel]=Options[fva];
reduceModel[model_MASSmodel,bounds:({_Rule..}|{}):{},opts:OptionsPattern[]]:=Module[{blocked},
	blocked=Cases[Chop@fva[model,bounds,opts],r_Rule/;r[[2]]=={0,0}][[All,1]];
	deleteReactions[model,blocked]
];
def:reduceModel[___]:=(Message[Toolbox::badargs,reduceModel,Defer@def];Abort[])
Protect[reduceModel];


optiontest::wrngoption="The provided value `1` for option `2` does not pass the following test: `3`.";
optiontest[optionID_String,optionValue_,test_]:=If[!test[optionValue],Message[optiontest::wrngoption,optionValue,optionID,test];Abort[];];


gimme::everythingAboveThreshold="All reaction values (minimal value: `1`) lie below the provided threshold of `2`. The provided objective `3` is minimized instead.";
Options[gimme]={"Level"->.7,"Threshold"->12.,"ObjectiveValue"->Automatic,"Solver"->LinearProgramming};
gimme[model_MASSmodel,objective_,data:{_Rule...},opts:OptionsPattern[]]:=Module[{cleanData,fbaOptimum,fluxIDs,gimmeObj},
	optiontest["Level",OptionValue["Level"],NumberQ];
	cleanData=(#[[1]]|#[[1]]<>"_Rev"->#[[2]]&/@data)/.flux_v:>getID[flux];
	If[OptionValue["ObjectiveValue"]===Automatic,
		fbaOptimum=(Replace[objective,fluxID_String:>v[fluxID]]/.fba[model,objective,Sequence@@FilterRules[List[opts],Options[fba]]])*OptionValue["Level"];
		optiontest["ObjectiveValue",fbaOptimum,NumberQ];,
		optiontest["ObjectiveValue",OptionValue["ObjectiveValue"],NumberQ];
		fbaOptimum=OptionValue["ObjectiveValue"];
	];
	fluxIDs=getID/@model["Fluxes"];
	gimmeObj=Plus@@Thread[Times[fluxIDs,If[#>OptionValue["Threshold"],0,OptionValue["Threshold"]-#]&/@(fluxIDs/.cleanData/._String:>\[Infinity])]];
	If[gimmeObj==0,
	Message[gimme::everythingAboveThreshold,Min@cleanData[[All,2]],OptionValue["Threshold"],objective];Return[fba[model,objective,{objective->{fbaOptimum,\[Infinity]}},"OptFlag"->"MIN","Solver"->OptionValue["Solver"]]]];
	fba[model,gimmeObj,{objective->{fbaOptimum,\[Infinity]}},"OptFlag"->"MIN","Solver"->OptionValue["Solver"]]
];


Unprotect[GurobiFVA];
Options[GurobiFVA]=updateRules[Options[LinearProgramming],{"Infinity"->1.*^10}];
GurobiFVA::objdimension="Objective vector (size:`1`) should have a compatible shape with the provide matrix (`2`).";
GurobiFVA::rxnnotexist="Reaction `1` in objective specification does not exist in problem description.";
GurobiFVA[stoichiometry_?MatrixQ,colIDs_List,bounds:({_Rule..}|{}):{},opts:OptionsPattern[]]:=Block[{rhs,intrnlbnds,optFlag,solution,obj},
	obj=Table[0.,{Dimensions[stoichiometry][[2]]}];
	rhs=Table[{0,0},{Length[stoichiometry]}];
	intrnlbnds=Replace[colIDs/.Dispatch[bounds],a_/;!MatchQ[a,{(_?NumberQ|-\[Infinity]),(_?NumberQ|\[Infinity])}]:>{-\[Infinity],\[Infinity]},1];
	solution=GurobiML`GurobiML`GurobiSolveMinimaMaxima[stoichiometry,rhs,intrnlbnds];
	Thread[Rule[v/@colIDs,Transpose[solution]]]
];
GurobiFVA[model_MASSmodel,bounds:({_Rule..}|{}):{},opts:OptionsPattern[]]:=Module[{},GurobiFVA[model["Stoichiometry"],getID/@model["Fluxes"],updateRules[model["Constraints"],bounds]/.flux_v:>getID[flux],opts]]
def:GurobiFVA[___]:=(Message[Toolbox::badargs,GurobiFVA,Defer@def];Abort[])
Protect[GurobiFVA];


(* ::Subsubsection::Closed:: *)
(*Sampling*)


Unprotect[createWarmupPoints];
Options[createWarmupPoints]={"NumberOfPoints"->Automatic,"ProgressBar"->True,"Solver"->LinearProgramming};
createWarmupPoints[m_?MatrixQ,bounds_?MatrixQ,opts:OptionsPattern[]]:=Module[{b,obj,minSol,maxSol,nColumns,centerPoint,points,nPoints,i},
	nColumns=Dimensions[m][[2]];
	nPoints=OptionValue["NumberOfPoints"];
	nPoints=If[nPoints===Automatic||nPoints/2<nColumns,nColumns*4,nPoints];
	b=Table[{0,0},{Length[m]}];
	points=If[$FrontEnd=!=Null&&OptionValue["ProgressBar"],Monitor[ReleaseHold[#],Column[{"Generating warmup points ...",ProgressIndicator[i,{1,nPoints/2}]}]],ReleaseHold[#]]&@Hold[
		Table[
			If[i<=nColumns,
				obj=Array[0&,nColumns];
				obj[[i]]=1,
				obj=RandomReal[{-.5,.5},Dimensions[m][[2]]]
			];
			minSol=OptionValue["Solver"][obj,m,b,bounds];
			maxSol=OptionValue["Solver"][-obj,m,b,bounds];
			Sequence@@{minSol,maxSol}
		,{i,1,nPoints/2}
		]
	];
	centerPoint=Mean[points];
	(*Move towards center*)
	(#+0.67centerPoint&/@(0.33*points))/. 0.->1.*^-12
];
createWarmupPoints[model_MASSmodel,bounds:{_Rule...}:{},opts:OptionsPattern[]]:=Module[{obj,stoich,bees,bnds},
	{obj,stoich,bees,bnds}=model2LinearProgrammingData[model,model["Fluxes"][[1]],bounds]/.{-\[Infinity]->-1000,\[Infinity]->1000};
	createWarmupPoints[stoich,bnds,opts]
];
def:createWarmupPoints[___]:=(Message[Toolbox::badargs,createWarmupPoints,Defer@def];Abort[])
Protect[createWarmupPoints];


Unprotect[ACHRsampler];
Options[ACHRsampler]={"StepsPerPoint"->10,"Iterations"->10,"EvaluationMonitor"->None,"MaxMinTol"->1*^-9,"uTol"->1*^-9,"ProgressBar"->True};
ACHRsampler::tooCloseToBoundary="";
ACHRsampler[m_?MatrixQ,warmupPoints_?MatrixQ,bounds:{{_?NumberQ,_?NumberQ}..},opts:OptionsPattern[]]:=Module[{uTol,maxMinTol,stepsPerPoints,lb,ub,u,null,points,centerPoint,positiveDir,negativeDir,distUB,distLB,maxStepTemp,ptCnt,minStepTemp,maxStepVec,minStepVec,maxStep,minStep,stepDist,newPoint,n,s,i,again,rndPointOrder,prevPoint,gotoCount},
	{lb,ub}=Transpose[bounds];
	(*TODO check dimensions*)
	null=Orthogonalize[NullSpace[m]];
	points=warmupPoints;
	gotoCount=0;
	uTol=OptionValue["uTol"];
	maxMinTol=OptionValue["MaxMinTol"];
	stepsPerPoints=OptionValue["StepsPerPoint"];
	If[$FrontEnd=!=Null&&OptionValue["ProgressBar"],Monitor[ReleaseHold[#],Grid[{{"Sampling ...",""},{"Iteration: "<>ToString[n],ProgressIndicator[n,{1,OptionValue["Iterations"]}],ToString[OptionValue["Iterations"]]}}]],ReleaseHold[#]]&@Hold[
	Do[
		rndPointOrder=RandomSample[Range[1,Length[points]]];
		centerPoint=Mean[points];
		points=ParallelTable[
			prevPoint=points[[rndPointOrder[[i]]]];
			Do[
				Label[again];
				(*centerPoint+((newPoint-points[[1]])/Length[points]);*)
				(*u=points[[RandomChoice[Complement[Range[1,Length[points]],{i}]]]]-centerPoint;*)
				u=points[[NestWhile[RandomInteger[{1,Length[points]}]&,RandomInteger[{1,Length[points]}],#==i&]]]-centerPoint;
				u=u/Norm[u];
				positiveDir=Position[u,n_/;n>uTol]//Flatten;
				negativeDir=Position[u,n_/;n<-uTol]//Flatten;
				distUB=ub-prevPoint;
				distLB=prevPoint-lb;
				(*Division by Zeror errors might occur here ...*)
				maxStepTemp=distUB/u;
				minStepTemp=-distLB/u;
				maxStepVec=Join[maxStepTemp[[positiveDir]],minStepTemp[[negativeDir]]];
				minStepVec=Join[minStepTemp[[positiveDir]],maxStepTemp[[negativeDir]]];
				maxStep=Min[maxStepVec];
				minStep=Max[minStepVec];
				If[(Abs[minStep]<maxMinTol&&Abs[maxStep]<maxMinTol)||(minStep>maxStep),
					(*Message[ACHRsampler::tooCloseToBoundary];*)
					gotoCount+=1;
					Goto[again];
				];
				stepDist=RandomReal[]*(maxStep-minStep)+minStep;
				newPoint=prevPoint+stepDist*u;
				newPoint=MapIndexed[If[#>ub[[#2[[1]]]],ub[[#2[[1]]]],#]&,newPoint];
				newPoint=MapIndexed[If[#<lb[[#2[[1]]]],lb[[#2[[1]]]],#]&,newPoint];
				(*newPoint=null\[Transpose].null.newPoint;*)
				If[Mod[25,i]==0,
					newPoint=null\[Transpose].null.newPoint;
				];
				prevPoint=newPoint;
				,{s,1,stepsPerPoints}
			];
			null\[Transpose].null.newPoint
			,{i,1,Length[points]},DistributedContexts:>Automatic
		];
		,{n,1,OptionValue["Iterations"]}
	];
	];
	points
];
ACHRsampler[model_MASSmodel,warmupPoints_?MatrixQ,bounds:{_Rule...}:{},opts:OptionsPattern[]]:=Module[{obj,stoich,bees,bnds},
	{obj,stoich,bees,bnds}=model2LinearProgrammingData[model,model["Fluxes"][[1]],bounds]/.{-\[Infinity]->-1000,\[Infinity]->1000};
	ACHRsampler[stoich,warmupPoints,bnds,opts]
];
def:ACHRsampler[___]:=(Message[Toolbox::badargs,ACHRsampler,Defer@def];Abort[])
Protect[ACHRsampler];


(*Unprotect[ACHRsampler];
Options[ACHRsampler]={"StepsPerPoint"->10,"Iterations"->10,"EvaluationMonitor"->None,"MaxMinTol"->1*^-9,"uTol"->1*^-9};
ACHRsampler::tooCloseToBoundary="";
ACHRsampler[m_?MatrixQ,warmupPoints_?MatrixQ,bounds:{{_?NumberQ,_?NumberQ}..},opts:OptionsPattern[]]:=Module[{lb,ub,u,null,points,centerPoint,positiveDir,negativeDir,distUB,distLB,maxStepTemp,ptCnt,minStepTemp,maxStepVec,minStepVec,maxStep,minStep,stepDist,newPoint,n,s,i,again,rndPointOrder,prevPoint,gotoCount},
	{lb,ub}=Transpose[bounds];
	(*TODO check dimensions*)
	null=Orthogonalize[NullSpace[m]];
	points=warmupPoints;
	gotoCount=0;
	Monitor[
	Do[
		rndPointOrder=RandomSample[Range[1,Length[points]]];
		Do[
			centerPoint=Mean[points];
			prevPoint=points[[rndPointOrder[[i]]]];
			Do[
				Label[again];
				(*centerPoint+((newPoint-points[[1]])/Length[points]);*)
				(*u=points[[RandomChoice[Complement[Range[1,Length[points]],{i}]]]]-centerPoint;*)
				u=points[[NestWhile[RandomInteger[{1,Length[points]}]&,RandomInteger[{1,Length[points]}],#==i&]]]-centerPoint;
				u=u/Norm[u];
				positiveDir=Position[u,n_/;n>OptionValue["uTol"]]//Flatten;
				negativeDir=Position[u,n_/;n<-OptionValue["uTol"]]//Flatten;
				distUB=ub-prevPoint;
				distLB=prevPoint-lb;
				(*Division by Zeror errors might occur here ...*)
				maxStepTemp=distUB/u;
				minStepTemp=-distLB/u;
				maxStepVec=Join[maxStepTemp[[positiveDir]],minStepTemp[[negativeDir]]];
				minStepVec=Join[minStepTemp[[positiveDir]],maxStepTemp[[negativeDir]]];
				maxStep=Min[maxStepVec];
				minStep=Max[minStepVec];
				If[(Abs[minStep]<OptionValue["MaxMinTol"]&&Abs[maxStep]<OptionValue["MaxMinTol"])||(minStep>maxStep),
					(*Message[ACHRsampler::tooCloseToBoundary];*)
					gotoCount+=1;
					Goto[again];
				];
				stepDist=RandomReal[]*(maxStep-minStep)+minStep;
				newPoint=prevPoint+stepDist*u;
				newPoint=MapIndexed[If[#>ub[[#2[[1]]]],ub[[#2[[1]]]],#]&,newPoint];
				newPoint=MapIndexed[If[#<lb[[#2[[1]]]],lb[[#2[[1]]]],#]&,newPoint];
				(*newPoint=null\[Transpose].null.newPoint;*)
				If[Mod[25,i]==0,
					newPoint=null\[Transpose].null.newPoint;
				];
				prevPoint=newPoint;
				,{s,1,OptionValue["StepsPerPoint"]}
			];
			newPoint=null\[Transpose].null.newPoint;
			points[[rndPointOrder[[i]]]]=newPoint;
			,{i,1,Length[points]}
		];
		Sow[points\[Transpose]];
		,{n,1,OptionValue["Iterations"]}
	];,Grid[{{"Point: "<>ToString[i],ProgressIndicator[i,{1,Length[points]}],ToString[Length[points]]},{"Iteration: "<>ToString[n],ProgressIndicator[n,{1,OptionValue["Iterations"]}],ToString[OptionValue["Iterations"]]}}]];
	points
];
ACHRsampler[model_MASSmodel,warmupPoints_?MatrixQ,bounds:{_Rule...}:{},opts:OptionsPattern[]]:=Module[{obj,stoich,bees,bnds},
	{obj,stoich,bees,bnds}=model2LinearProgrammingData[model,model["Fluxes"][[1]],bounds]/.{-\[Infinity]->-1000,\[Infinity]->1000};
	ACHRsampler[stoich,warmupPoints,bnds,opts]
];
def:ACHRsampler[___]:=(Message[Toolbox::badargs,ACHRsampler,Defer@def];Abort[])
Protect[ACHRsampler];*)


(* ::Subsubsection::Closed:: *)
(*Concentration bounds*)


Options[calcConcentrationBounds]={"Fluxes"->{},"Concentrations"->{},"Parameters"->{}};
calcConcentrationBounds[model_MASSmodel,opt:OptionsPattern[]]:=Module[{logDisEqRatios,logParameters,logConcIneq,dissEqRatios,complexInfinityCases,fluxes,eq,vars,unbounded,thermoEq},
	logParameters=stripUnits[updateRules[model["Parameters"],OptionValue["Parameters"]]]/.num_?NumberQ:>Log[num];
	dissEqRatios=Thread[model["Fluxes"]->getDisequilibriumRatios[model]];
	logDisEqRatios=#[[1]]->(expandAllLog[Log[#[[2]]]])/.Log->Sequence&/@dissEqRatios;
	logDisEqRatios=N[logDisEqRatios/.logParameters];
	unbounded=Complement[Union[Cases[logDisEqRatios,$MASS$speciesPattern,\[Infinity]]],OptionValue["Concentrations"][[All,1]]];
	logConcIneq=stripUnits[(#[[2,1]]<=#[[1]]<=#[[2,2]]&/@OptionValue["Concentrations"])/.num_?NumberQ:>Log[num]];
	logConcIneq=Join[logConcIneq,-12<=#<=12&/@unbounded];
	complexInfinityCases=Cases[logDisEqRatios,r_Rule/;r[[2]]===DirectedInfinity[]];
	logDisEqRatios=FilterRules[logDisEqRatios,Except[complexInfinityCases]];
	fluxes=FilterRules[stripUnits@updateRules[model["InitialConditions"],OptionValue["Fluxes"]],Except[complexInfinityCases]];
	thermoEq=Table[
		Which[
			flux[[2]]==0.,(flux[[1]]/.logDisEqRatios)==0,
			flux[[2]]<0,(flux[[1]]/.logDisEqRatios)>0,
			flux[[2]]>0,(flux[[1]]/.logDisEqRatios)<0
		]
	,{flux,fluxes}];
	eq=Join[thermoEq,logConcIneq];
	vars=Union[Cases[eq,(_v|_rateconst|_metabolite|_parameter),\[Infinity]]];
	(#->{Check[GAMS[{#,Sequence@@eq},vars][[1]],$Failed],Check[-GAMS[{-#,Sequence@@eq},vars][[1]],$Failed]}&/@vars)/.num_?NumberQ:>N@Exp[num]
];


(* ::Subsection:: *)
(*Utilities*)


Unprotect[productionEnvelope];
Options[productionEnvelope]={"Points"->20};
productionEnvelope[model_MASSmodel,controlFlux_v,targets__v,opts:OptionsPattern[{productionEnvelope,fba}]]:=Module[{minGrowth,maxGrowth,minFlux,maxFlux,npts,growth,target,tmpResult},
	npts=OptionValue["Points"];
	minGrowth=controlFlux/.fba[model,controlFlux,OptFlag->"Min",Sequence@@FilterRules[{opts},Options[fba]]];
	maxGrowth=controlFlux/.fba[model,controlFlux,OptFlag->"Max",Sequence@@FilterRules[{opts},Options[fba]]];
	target={targets}[[1]];
	Monitor[
		tmpResult=Table[
		minFlux=target/.fba[model,target,{controlFlux->{growth,growth}},OptFlag->"Min",Sequence@@FilterRules[{opts},Options[fba]]];
		maxFlux=target/.fba[model,target,{controlFlux->{growth,growth}},OptFlag->"Max",Sequence@@FilterRules[{opts},Options[fba]]];
		{growth,minFlux,maxFlux}
	,{growth,Rescale[Range[1,npts],{1,npts},{minGrowth,maxGrowth}]}];
	,ProgressIndicator[growth,{minGrowth,maxGrowth}]
	];
	Transpose[tmpResult]
];
def:productionEnvelope[___]:=(Message[Toolbox::badargs,productionEnvelope,Defer@def];Abort[])
Protect[productionEnvelope];


Unprotect[model2LinearProgrammingData];
model2LinearProgrammingData::unknownObjectiveType="`1` is not a valid objective.";
Options[model2LinearProgrammingData]={"OptFlag"->"MAX"};
model2LinearProgrammingData[model_MASSmodel,obj_,bounds:({_Rule..}|{}):{},opts:OptionsPattern[]]:=Module[{stoich,intrnlbnds,internlobj,rhs,optFlag,pos,cleanObj},
	stoich=model["SparseStoichiometry"];
	intrnlbnds=Replace[getID/@model["Fluxes"]/.Dispatch[updateRules[model["Constraints"]/.flux_v:>getID[flux],bounds/.flux_v:>getID[flux]]],a_/;!MatchQ[a,{(_?NumberQ|-\[Infinity]),(_?NumberQ|\[Infinity])}]:>{-\[Infinity],\[Infinity]},1];
	optFlag=If["MAX"==ToUpperCase[OptionValue["OptFlag"]],-1,1];
	cleanObj=obj/.flux_v:>getID[flux];
	Switch[Chop@cleanObj,
		_String,Quiet[Check[pos=Position[getID/@model["Fluxes"],cleanObj][[1]],Message[fba::rxnnotexist,cleanObj];Abort[];,{Part::partw}],{Part::partw}];internlobj=Table[0,{Dimensions[stoich][[2]]}];internlobj[[pos]]=1;,
		_Plus,internlobj=getID/@model["Fluxes"]/.Dispatch[Reverse/@Rule@@@List@@Expand[1.*Chop[cleanObj]]]/._String->0.,
		_,Message[model2LinearProgrammingData::unknownObjectiveType,cleanObj];Abort[];
	];
	rhs=Table[{0,0},{Length[stoich]}];
	optFlag=If["MAX"==ToUpperCase[OptionValue["OptFlag"]],-1,1];
	{Chop[optFlag*internlobj],stoich,rhs,intrnlbnds}
];
def:model2LinearProgrammingData[___]:=(Message[Toolbox::badargs,model2LinearProgrammingData,Defer@def];Abort[])
Protect[model2LinearProgrammingData];


Unprotect[model2LooplessFbaFormulation];
Options[model2LooplessFbaFormulation]=Join[{"UpperBoundOnG"->1000},Options[model2LinearProgrammingData]];
model2LooplessFbaFormulation[model_MASSmodel,obj_,bounds:{_Rule...}:{},opts:OptionsPattern[]]:=Module[{lpObj,stoich,lpRhs,lpBnds,dim,internalModel,exchPos,intDim,nullInt,vIdentity,vNull,sNull,aDiagonalMat1,aDiagonalMat2,aNull,gNull,gIdentity,constrMat,looplessRhs,bnds,dom},
	{lpObj,stoich,lpRhs,lpBnds}=model2LinearProgrammingData[model,obj,bounds,Sequence@@FilterRules[updateRules[Options[model2LinearProgrammingData],List[opts]],Options[model2LinearProgrammingData]]];
	dim=Dimensions[model];
	internalModel=deleteReactions[model,getID/@model["Exchanges"]];
	exchPos=Position[getID/@model["Fluxes"],Alternatives@@(getID/@model["Exchanges"])];
	intDim=Dimensions[internalModel];
	nullInt=Chop@NullSpace[internalModel];
	vIdentity=Delete[IdentityMatrix[dim[[2]]],exchPos];
	vNull=Delete[DiagonalMatrix[Array[0&,dim[[2]]]],exchPos];
	sNull=Table[0,{dim[[1]]},{intDim[[2]]}];
	aDiagonalMat1=DiagonalMatrix[Array[-OptionValue["UpperBoundOnG"]&,intDim[[2]]]];
	aDiagonalMat2=DiagonalMatrix[Array[-OptionValue["UpperBoundOnG"]-1&,intDim[[2]]]];
	aNull=DiagonalMatrix[Array[0&,intDim[[2]]]];
	gIdentity=IdentityMatrix[intDim[[2]]];
	gNull=aNull;
	constrMat=ArrayFlatten[
		{
		{S[model],sNull,sNull},
		{vIdentity,aDiagonalMat1,gNull},
		{vIdentity,aDiagonalMat1,gNull},
		{vNull,aDiagonalMat2,-gIdentity},
		{vNull,aDiagonalMat2,-gIdentity},
		{vNull[[1;;Length[nullInt]]],aNull[[1;;Length[nullInt]]],nullInt}
		}
	];
	looplessRhs=Join[lpRhs,
		Table[{-OptionValue["UpperBoundOnG"],1},{intDim[[2]]}],
		Table[{0,-1},{intDim[[2]]}],
		Table[{-1,-1},{intDim[[2]]}],
		Table[{-OptionValue["UpperBoundOnG"],1},{intDim[[2]]}],
		Table[{0,0},{Length[nullInt]}]
	];
	bnds=Join[lpBnds,Table[{0,1},{intDim[[2]]}],Table[{-OptionValue["UpperBoundOnG"],OptionValue["UpperBoundOnG"]},{intDim[[2]]}]];
	dom=Join[Table[Reals,{dim[[2]]}],Table[Integers,{intDim[[2]]}],Table[Reals,{intDim[[2]]}]];
	{PadRight[lpObj,Dimensions[constrMat][[2]]],constrMat,looplessRhs,bnds,dom}
];
def:model2LooplessFbaFormulation[___]:=(Message[Toolbox::badargs,model2LooplessFbaFormulation,Defer@def];Abort[])
Protect[model2LooplessFbaFormulation];


(* ::Subsection:: *)
(*Solvers (that provide a similar argument signature as LinearProgramming)*)


(* ::Subsubsection:: *)
(*GLPK*)


Unprotect[GLPKStandalone];
GLPKStandalone::glpsolMissing="glpsol seems to be not installed or not on your system path.";
GLPKStandalone::GLP\[UnderBracket]UNDEF="Solution is undefined (GLP_UNDEF).";
GLPKStandalone::GLP\[UnderBracket]FEAS="Solution is feasable (GLP_FEAS).";
GLPKStandalone::GLP\[UnderBracket]INFEAS="Solution is infeasible (GLP_INFEAS).";
GLPKStandalone::GLP\[UnderBracket]NOFEAS="No feasible solution (GLP_NOFEAS).";
GLPKStandalone::GLP\[UnderBracket]UNBND="Solution is unbounded (GLP_UNBND).";
Options[GLPKStandalone]={"GlpsolOptions"->"","OutputFormat"->Automatic,"TerminalOutput"->False,"PrintableOutput"->False};
GLPKStandalone::nooptfound="No optimal solution was found (see terminal output of glpsol below).\n`1`";
GLPKStandalone[c_List,mat_?MatrixQ,b_List,bounds:((_?NumberQ|-Infinity)|{(_?NumberQ|-Infinity)...}|{{(_?NumberQ|-Infinity),(_?NumberQ|Infinity)}..}|Automatic):{},dom:((Integers|Reals)|{(Integers|Reals)..}):Reals,opts:OptionsPattern[]]:=Module[{status,cplexDef,tmpFile,plainOutputFile,outputFile,solution,solution2,termOutput,cmd},
	cplexDef=CPLEXForm[c,mat,b,bounds,dom];
	tmpFile=OpenWrite[];WriteString[tmpFile,cplexDef];Close[tmpFile];
	plainOutputFile=OpenWrite[];Close[plainOutputFile];
	If[OptionValue["PrintableOutput"],
		outputFile=OpenWrite[];Close[outputFile];
	];
	cmd="glpsol --cpxlp "<>"\""<>tmpFile[[1]]<>"\""<>If[OptionValue["PrintableOutput"]," -o "<>"\""<>outputFile[[1]]<>"\"",""]<>" -w "<>"\""<>plainOutputFile[[1]]<>"\""<>" --wglp "<>"\""<>plainOutputFile[[1]]<>".glp"<>"\""<>" "<>OptionValue["GlpsolOptions"]<>" 2>&1";
	termOutput=Import["!"<>$SystemCommandPrefix<>cmd,"Text"];
	If[termOutput=="",Message[GLPKStandalone::glpsolMissing];Abort[];];
	solution=parseGlpkPlainOutput[Import[plainOutputFile[[1]],"Table"],Import[plainOutputFile[[1]]<>".glp","Text"]];
	status="Status"/.solution;
	If[!StringMatchQ[termOutput, "*OPTIMAL SOLUTION FOUND*"],Message[GLPKStandalone::nooptfound,termOutput];Message[MessageName[GLPKStandalone,#]]&[status];Abort[]];
	solution=Switch[OptionValue["OutputFormat"],Automatic,("ColumnPrimals"/.solution),Full,solution,{_String..},FilterRules[solution,OptionValue["OutputFormat"]]];
	If[OptionValue["PrintableOutput"],
		solution2=Import[outputFile[[1]],"Text"];
	];
	Piecewise[
		{
		{solution,!OptionValue["PrintableOutput"]&&!OptionValue["TerminalOutput"]},
		{{solution,solution2},(OptionValue["PrintableOutput"]&&!OptionValue["TerminalOutput"])}
		},{solution,solution2,termOutput}
	]
];
def:GLPKStandalone[___]:=(Message[Toolbox::badargs,GLPKStandalone,Defer@def];Abort[])
Protect[GLPKStandalone];


parseGlpkPlainOutput[tab_List/;Length[tab[[2]]]==3,glpProblemDefinition_String]:=Module[{status,probTab,rowIDs,colIDs,rowNum,colNum,ord,rowOrdering},
	(*
	# define GLP_UNDEF 1/*solution is undefined*/
	#define GLP_FEAS 2/*solution is feasible*/
	#define GLP_INFEAS 3/*solution is infeasible*/
	#define GLP_NOFEAS 4/*no feasible solution exists*/
	#define GLP_OPT 5/*solution is optimal*/
	#define GLP_UNBND 6/*solution is unbounded*/
	*)
	status={1->"GLP\[UnderBracket]UNDEF",2->"GLP\[UnderBracket]FEAS",3->"GLP\[UnderBracket]INFEAS",4->"GLP\[UnderBracket]NOFEAD",5->"GLP\[UnderBracket]OPT","6"->"GLP\[UnderBracket]UNBD"};
	probTab=ImportString[glpProblemDefinition,"Table"];
	rowIDs=Cases[probTab,{"n","i",__}][[All,-1]];
	colIDs=Cases[probTab,{"n","j",__}][[All,-1]];
	rowNum=tab[[1,1]];
	colNum=tab[[1,2]];
	ord=Ordering[ToExpression[colIDs,TraditionalForm][[All,1]]];
	rowOrdering=Ordering[ToExpression@StringReplace[#,"r"->""]&/@rowIDs];
	{"RowIDs"->rowIDs[[rowOrdering]],
	"ColumnIDs"->colIDs[[ord]],
	"RowNum"->rowNum,
	"ColumnNum"->colNum,
	"ObjectiveValue"->tab[[2,3]],
	"Status"->(tab[[2,1]]/.status),
	"DualStatus"->tab[[2,2]]/.status,
	"RowStatuses"->tab[[3;;3+rowNum-1,1]][[rowOrdering]],
	"RowPrimals"->tab[[3;;3+rowNum-1,2]][[rowOrdering]],
	"RowDuals"->tab[[3+rowNum;;3+rowNum+colNum-1,3]][[rowOrdering]],
	"ColumnStatuses"->tab[[3+rowNum;;3+rowNum+colNum-1,1]][[ord]],
	"ColumnPrimals"->tab[[3+rowNum;;3+rowNum+colNum-1,2]][[ord]],
	"ColumnDuals"->tab[[3+rowNum;;3+rowNum+colNum-1,3]][[ord]]
	}
];
parseGlpkPlainOutput[tab_List/;Length[tab[[2]]]==2&&Length[tab[[3]]]==2,glpProblemDefinition_String]:=Module[{status,probTab,rowIDs,colIDs,rowNum,colNum,ord,rowOrdering},
	status={1->"GLP_UNDEF",2->"GLP_FEAS",3->"GLP_INFEAS",4->"GLP_NOFEAD",5->"GLP_OPT","6"->"GLP_UNBD"};
	probTab=ImportString[glpProblemDefinition,"Table"];
	rowIDs=Cases[probTab,{"n","i",__}][[All,-1]];
	colIDs=Cases[probTab,{"n","j",__}][[All,-1]];
	rowNum=tab[[1,1]];
	colNum=tab[[1,2]];
	ord=Ordering[ToExpression[colIDs,TraditionalForm][[All,1]]];
	rowOrdering=Ordering[ToExpression@StringReplace[#,"r"->""]&/@rowIDs];
	{"RowIDs"->rowIDs[[rowOrdering]],
	"ColumnIDs"->colIDs[[ord]],
	"RowNum"->rowNum,
	"ColumnNum"->colNum,
	"ObjectiveValue"->tab[[2,2]],
	"Status"->(tab[[2,1]]/.status),
	"RowPrimals"->tab[[3;;3+rowNum-1,1]][[rowOrdering]],
	"RowDuals"->tab[[3+rowNum;;3+rowNum+colNum-1,2]][[rowOrdering]],
	"ColumnPrimals"->tab[[3+rowNum;;3+rowNum+colNum-1,1]][[ord]],
	"ColumnDuals"->tab[[3+rowNum;;3+rowNum+colNum-1,2]][[ord]]
	}
];
parseGlpkPlainOutput[tab_List/;Length[tab[[2]]]==2&&Length[tab[[3]]]==1,glpProblemDefinition_String]:=Module[{status,probTab,rowIDs,colIDs,rowNum,colNum,ord,rowOrdering},
	status={1->"GLP_UNDEF",2->"GLP_FEAS",3->"GLP_INFEAS",4->"GLP_NOFEAD",5->"GLP_OPT","6"->"GLP_UNBD"};
	probTab=ImportString[glpProblemDefinition,"Table"];
	rowIDs=Cases[probTab,{"n","i",__}][[All,-1]];
	colIDs=Cases[probTab,{"n","j",__}][[All,-1]];
	rowNum=tab[[1,1]];
	colNum=tab[[1,2]];
	ord=Ordering[ToExpression[colIDs,TraditionalForm][[All,1]]];
	rowOrdering=Ordering[ToExpression@StringReplace[#,"r"->""]&/@rowIDs];
	{"RowIDs"->rowIDs[[rowOrdering]],
	"ColumnIDs"->colIDs[[ord]],
	"RowNum"->rowNum,
	"ColumnNum"->colNum,
	"ObjectiveValue"->tab[[2,2]],
	"Status"->(tab[[2,1]]/.status),
	"RowPrimals"->tab[[3;;3+rowNum-1,1]][[rowOrdering]],
	"ColumnPrimals"->tab[[3+rowNum;;3+rowNum+colNum-1,1]][[ord]]
	}
];


(* ::Subsubsection:: *)
(*CPLEX*)


Unprotect[CPLEXStandalone];
Options[CPLEXStandalone]={"OutputFormat"->Automatic};
CPLEXStandalone::cplexMissing="cplex seems to be not installed or not on your system path.";
CPLEXStandalone::failed="Probably no solution could be found.\n`1`";
CPLEXStandalone[c_List,mat_?MatrixQ,b_List,bounds:((_?NumberQ|-Infinity)|{(_?NumberQ|-Infinity)...}|{{(_?NumberQ|-Infinity),(_?NumberQ|Infinity)}..}|Automatic):{},dom:((Integers|Reals)|{(Integers|Reals)..}):Reals,opts:OptionsPattern[]]:=Module[{cplexDef,tmpFile,plainOutputFile,outputFile,cmd,termOutput,xmlOutput,cplexDirectives},
	plainOutputFile=OpenWrite[];Close[plainOutputFile];DeleteFile[plainOutputFile[[1]]];
	cplexDef=CPLEXForm[c,mat,b,bounds,dom];
	cplexDirectives={
		"enter problemID",
		cplexDef,
		"optimize",
		"write "<>FileBaseName@plainOutputFile[[1]]<>" sol all"
	};
	tmpFile=OpenWrite[];WriteString[tmpFile,StringJoin[Sequence@@Riffle[cplexDirectives,"\n"]]];Close[tmpFile];
	cmd="cd "<>DirectoryName@plainOutputFile[[1]]<>" && cplex < "<>"\""<>tmpFile[[1]]<>"\"";
	termOutput=Import["!"<>$SystemCommandPrefix<>cmd<>" 2>&1","Text"];
	If[termOutput=="",Message[CPLEXStandalone::cplexMissing];Abort[];];
	xmlOutput=Check[Import[plainOutputFile[[1]],"XML"],Message[CPLEXStandalone::failed,termOutput];Abort[];,{Import::nffil}];
	Switch[OptionValue["OutputFormat"],
		Automatic,ToExpression[StringReplace[#,"e"->"*^"]]&/@Sort[ToExpression[#[[1]],TraditionalForm][[1]]->#[[2]]&/@Flatten[Cases[Cases[xmlOutput,XMLElement["CPLEXSolutions",_,sol_List]:>sol[[1]]],XMLElement["variable",stuff_,_]:>({"name"->"value"}/.stuff),\[Infinity]]]][[All,2]],
		Full,{xmlOutput,termOutput}
	]
];
def:CPLEXStandalone[___]:=(Message[Toolbox::badargs,GLPKStandalone,Defer@def];Abort[]);
Protect[CPLEXStandalone];


Unprotect[CPLEXForm];
CPLEXForm::wrongbnds="Something is wrong with the provided variable bounds `1`.";
CPLEXForm[c:{_?NumberQ..},mat_?MatrixQ,b:({(_?NumberQ|-Infinity|Infinity)..}|{{(_?NumberQ|-Infinity|Infinity),(-1|0|1)}..}),bounds:((_?NumberQ|-Infinity)|{(_?NumberQ|-Infinity)...}|{{(_?NumberQ|-Infinity),(_?NumberQ|Infinity)}..}|Automatic):{},dom:((Integers|Reals)|{(Integers|Reals)..}):Reals]:=Module[{constr2str,vars,strVars,bClean,boundsClean,senses,objSection,subjectToSection,boundsSection,domainSection},
	constr2str=Switch[#[[2]],{-Infinity,Infinity},"-inf <= "<>#[[1]]<>" <= +inf",{-Infinity,_?NumberQ},"-inf <= "<>#[[1]]<>" <= "<>ToString[#[[2,2]],CForm],{_?NumberQ,Infinity},ToString[#[[2,1]],CForm]<>" <= "<>#[[1]]<>" <= +inf",{_?NumberQ,_?NumberQ},ToString[#[[2,1]],CForm]<>" <= "<>#[[1]]<>" <= "<>ToString[#[[2,2]],CForm]]&;
	vars=Table[C[i],{i,1,Length[mat\[Transpose]]}];
	strVars=ToString[#,CForm]&/@vars;
	bClean=If[MatchQ[b,{(_?NumberQ|-Infinity)..}],{#,1}&/@b,b];
	boundsClean=Switch[bounds,
		{{(_?NumberQ|-Infinity),(_?NumberQ|Infinity)}..},bounds,
		(_?NumberQ|-Infinity),Table[{bounds,Infinity},{Length[vars]}],
		{(_?NumberQ|-Infinity)...},Table[{bound,\[Infinity]},{bound,bounds}],
		Automatic,{},
		_,Message[CPLEXForm::wrongbnds,bounds];Abort[];
	];
	senses=Switch[#[[2]],-1," <= ",0," = ",1," >= "]&/@bClean;
	objSection="Minimize\n"<>ToString[c.vars,CForm]<>"\n";
	subjectToSection="Subject To\n"<>StringJoin[Sequence@@Riffle[StringJoin@@@DeleteCases[Thread[List[ToString[#,CForm]&/@(Chop[N[mat.vars]]),senses,ToString[#,CForm]&/@bClean[[All,1]]]],{"0",_,_}],"\n"]]<>"\n";
	subjectToSection="Subject To\n"<>StringJoin[Sequence@@Riffle[StringJoin@@@Thread[List[ToString[#,CForm]&/@(Chop[N[mat.vars]]),senses,ToString[#,CForm]&/@bClean[[All,1]]]],"\n"]]<>"\n";
	boundsSection=If[boundsClean!={},
		"Bounds\n"<>StringJoin[Sequence@@Riffle[constr2str[#]&/@Thread[List[strVars,boundsClean]],"\n"]]<>"\n",
		""
	];
	domainSection=Switch[dom,Reals,"",Integers,"Generals\n"<>StringJoin[Sequence@@Riffle[strVars,"\n"]],{(Integers|Reals)..},"Generals\n"<>StringJoin[Sequence@@Riffle[Pick[strVars,dom,Integers],"\n"]]];
	StringTrim[StringReplace[objSection<>subjectToSection<>boundsSection<>domainSection<>"\nEND\n","*"->" "]]
];
CPLEXForm[model_MASSmodel,objective_,bounds:{_Rule...}:{}]:=Module[{objSection,boundsSection,subjecttoSection,fluxAliases,fluxAliases2,constr2str},
CPLEXForm[Sequence@@model2LinearProgrammingData[model,objective,bounds]]
];
def:CPLEXForm[___]:=(Message[Toolbox::badargs,CPLEXForm,Defer@def];Abort[])
Protect[CPLEXForm];


(* ::Subsection:: *)
(*GAMS interface and code generation*)


Unprotect[GAMSForm];
GAMSForm::straySymbols="Stray symbols `1` detected.";
Options[GAMSForm]={"OptFlag"->"Minimizing","Category"->"NLP"};
GAMSForm[objAndEqu_/;!ListQ[objAndEqu],var_?AtomQ,opts:OptionsPattern[]]:=GAMSForm[{objAndEqu},{var},opts]
GAMSForm[objAndEqu_List,var_?AtomQ,opts:OptionsPattern[]]:=GAMSForm[objAndEqu,{var},opts]
GAMSForm[objAndEqu_/;!ListQ[objAndEqu],vars_List,opts:OptionsPattern[]]:=GAMSForm[{objAndEqu},Thread[List[vars,Automatic]],opts]
GAMSForm[objAndEqu_List,vars:{_?AtomQ..},opts:OptionsPattern[]]:=GAMSForm[objAndEqu,Thread[List[vars,Automatic]],opts]
GAMSForm[objAndEqu_List,vars:{{_Symbol,(_?NumberQ|Automatic)}..},opts:OptionsPattern[]]:=
Module[{straySymbols,objAndEquPrec,varsPrec,filterBounds,normalizeBounds,filterDomains,aliases,var2alias,variablesSection,obj,constr,bounds,domainSpec,equations,equAliases,equationsSection,normalizedBounds,upperBoundsSection,lowerBoundsSection,boundsSection,initialPointsSection,initialConditions,solveSection,strConv},
	(*Test for stray names*)
	straySymbols=Complement[Cases[objAndEqu,_Symbol,\[Infinity],Heads->False],vars[[All,1]],{Less,LessEqual,Equal,Greater,GreaterEqual}];
	If[straySymbols=!={},Message[GAMSForm::straySymbols,straySymbols];];
	{objAndEquPrec,varsPrec}=SetPrecision[{objAndEqu,vars}/.{Power[E,elem_]:>Global`exp[elem],Power->Global`power},10];(*Adjust precision, GAMS number format ist constrained to 10 digits*)
	strConv={"Log("->"log(","Abs("->"abs(","Power("->"power(","^"->"**",".le."->" =L= ",".ge."->" =G= ","<"->"=L=",">"->"=G=",".eq."->"=E=",RegularExpression["(E)\\*\\*"]:>"2.71828182845904**"};
	filterBounds=Cases[#,(
		(Less|Greater|LessEqual|GreaterEqual(*|Equal*))[(_?NumberQ|\[Infinity]|-\[Infinity]),_Symbol,(_?NumberQ|\[Infinity]|-\[Infinity])]|
		(Less|Greater|LessEqual|GreaterEqual(*|Equal*))[_Symbol,(_?NumberQ|\[Infinity]|-\[Infinity])]|
		(Less|Greater|LessEqual|GreaterEqual(*|Equal*))[(_?NumberQ|\[Infinity]|-\[Infinity]),_Symbol])|(i_Inequality/;MatchQ[i[[3]],_Symbol])]&;
	normalizeBounds=#/.i_Inequality:>i[[2]][i[[1]],i[[3]],i[[5]]]//.{LessEqual[s_Symbol,n:(_?NumberQ|\[Infinity])]:>LessEqual[-\[Infinity],s,n],GreaterEqual[s_Symbol,n:(_?NumberQ|-\[Infinity])]:>LessEqual[n,s,\[Infinity]],GreaterEqual[n2:(_?NumberQ|\[Infinity]),s_Symbol,n:(_?NumberQ|-\[Infinity])]:>LessEqual[n,s,n2]}&;
	filterDomains=Cases[#,_Element]&;
	aliases=ToString/@varsPrec[[All,1]];
	var2alias=Thread[Rule[varsPrec[[All,1]],aliases]];
	variablesSection="Variables "<>StringJoin[Sequence@@Riffle[aliases,", "]]<>", Z"<>";";
	obj=objAndEquPrec[[1]];
	If[Length[objAndEquPrec]>1,
		constr=(objAndEquPrec/.{Less->LessEqual,Greater->GreaterEqual})[[2;;]];,
		constr={};
	];
	bounds=filterBounds[constr];
	domainSpec=filterDomains[constr];
	equations=Complement[List@@constr,Join[List@@bounds,List@@domainSpec]];
	equAliases="eq"<>ToString[#]&/@Range[1,Length[equations]];
	equationsSection="Equations "<>StringJoin[Sequence@@Riffle[Join[equAliases,{"obj"}],", "]]<>";\n"<>(MapIndexed[#1<>".. "<>StringReplace[ToString[equations[[First@#2]],FortranForm],strConv]<>";\n"&,equAliases])<>"obj.. Z =E= "<>StringReplace[ToString[obj,FortranForm],strConv]<>";";
	
	normalizedBounds=normalizeBounds/@bounds;
	If[normalizedBounds!={},
		lowerBoundsSection="* lower bounds\n"<>Riffle[((#[[2]]/.Dispatch[var2alias])<>".lo = "<>Switch[#[[1]],-Infinity,"-INF",Infinity,"INF",_,ToString[#[[1]],CForm]]&/@normalizedBounds),";\n"]<>";";,
		lowerBoundsSection="* lower bounds\n";
	];
	If[normalizedBounds!={},
		upperBoundsSection="* upper bounds\n"<>Riffle[((#[[2]]/.Dispatch[var2alias])<>".up = "<>Switch[#[[3]],-Infinity,"-INF",Infinity,"INF",_,ToString[#[[3]],CForm]]&/@normalizedBounds),";\n"]<>";";,
		upperBoundsSection="* upper bounds\n";
	];
	boundsSection=lowerBoundsSection<>"\n\n"<>upperBoundsSection;
	initialConditions=DeleteCases[varsPrec,{_,Automatic}];
	If[initialConditions!={},
		initialPointsSection="* initial points\n"<>Riffle[((#[[1]]/.Dispatch[var2alias])<>".l = "<>ToString[#[[2]],CForm]&/@initialConditions),";\n"]<>";";,
		initialPointsSection="* initial points\n"
	];
	solveSection="Model problem / ALL /;\nSolve problem "<>OptionValue["OptFlag"]<>" Z USING "<>OptionValue["Category"]<>";";
	StringJoin[Riffle[{variablesSection,equationsSection,boundsSection,initialPointsSection,solveSection},"\n\n"]]
];
def:GAMSForm[___]:=(Message[Toolbox::badargs,GAMSForm,Defer@def];Abort[]);
Protect[GAMSForm];


gdxDumpParser[gdxdump_String]:=Module[{stuff,varStuff},
	stuff=DeleteCases[ImportString[StringReplace[gdxdump,","->""],"Table"],{"*",__}|{}];
	varStuff=Cases[stuff,{_,"Variable",__}];
	Symbol[#[[3]]]->{"Level"->(Cases[{#},{__,"/L",num_,___}:>num]/.{}->{0})[[1]],
	"Marginal"->(Cases[{#},{__,"M",num_,___}:>num]/.{}->{0})[[1]],
	"LowerBound"->(Cases[{#},{__,"LO",num_,___}:>num]/.{}->{-Infinity})[[1]],
	"UpperBound"->(Cases[{#},{__,"UP",num_,___}:>num]/.{}->{Infinity})[[1]]}&/@varStuff
];


Unprotect[GAMS];
Scan[(MessageName[GAMS,"returnCode"<>ToString[#[[1]]]]=#[[2]])&,{0->"normal return",1->"solver is to be called; the system should never return this number",2->"there was a compilation error",3->"there was an execution error",
		4->"system limits were reached",5->"there was a file error",6->"there was a parameter error",7->"there was a licensing error",8->"there was a GAMS system error",
		9->"GAMS cold not be started",10->"user interrupt"}];
(*Scan[(MessageName[GAMS,"modelCode"<>ToString[#[[1]]]]=#[[2]])&,
	{1->"Optimal",2->"Locally Optimal",3->"Unbounded",4->"Infeasible",5->"Locally Infeasible",6->"Intermediate Infeasible",7->"Intermediate Nonoptimal",8->"Integer Solution",9->"Intermediate Non-Integer",10->"Integer Infeasible",11->"Licensing Problems - No Solution",12->"Error Unknown",13->"Error No Solution",14->"No Solution Returned",15->"Solved Unique",16->"Solved",17->"Solved Singular",18->"Unbounded - No Solution",19->"Infeasible - No Solution"}
];*)
$GAMSSolverCodes={1->"Normal Completion",2->"Iteration Interrupt",3->"Resource Interrupt",4->"Terminated by Solver",5->"Evaluation Error Limit",6->"Capability Problems",7->"Licensing Problems",8->"User Interrupt",9->"Error Setup Failure",10->"Error Solver Failure",11->"Error Internal Solver Error",12->"Solve Processing Skipped",13->"Error System Failure"};
Scan[(MessageName[GAMS,"solverCode"<>ToString[#[[1]]]]=#[[2]])&,
	$GAMSSolverCodes
];
$GAMSModelCodes={1->"Optimal",2->"Locally Optimal",3->"Unbounded",4->"Infeasible",5->"Locally Infeasible",6->"Intermediate Infeasible",7->"Intermediate Nonoptimal",8->"Integer Solution",9->"Intermediate Non-Integer",10->"Integer Infeasible",11->"Licensing Problems - No Solution",12->"Error Unknown",13->"Error No Solution",14->"No Solution Returned",15->"Solved Unique",16->"Solved",17->"Solved Singular",18->"Unbounded - No Solution",19->"Infeasible - No Solution"};
Scan[(MessageName[GAMS,"modelCode"<>ToString[#[[1]]]]=#[[2]])&,
	$GAMSModelCodes
];

GAMS::wrongSolverSpec="Something is wrong with the provided solver specification. Please, check your optimization problem category (Category -> NLP, LP, MILP, etc.) and solver specifiation (e.g. Solver-> CONOPT, Gurobi etc.).";
GAMS::wrongOutputFormat="Output format `1` not recognized. Try \"Full\" or Minimize, Maximize, etc. intstead (to achieve a similar output as Mathematica's own optimization routins).";
GAMS::gamsMissing="gams seems to be not installed or not on your system path.";
GAMS::errors="No result file was written and the following error messages have been generated by gams:\n`1`"
Options[GAMS]=Join[{"CommandLineOptions"->"","Output"->Minimize,"Solver"->Automatic,"Translation"->{}},Options[GAMSForm]];
GAMS[objAndEqu_/;!StringQ[objAndEqu],vars_,opts:OptionsPattern[]]:=Module[{rosetta,objAndEquAnon,varsAnon,problemDef,fullOutput,solverString},
	{{objAndEquAnon,varsAnon},rosetta}=symbolize[{objAndEqu,vars}];
	problemDef=GAMSForm[objAndEquAnon,varsAnon,Sequence@@FilterRules[List@opts,Options[GAMSForm]]];
	GAMS[problemDef,opts,"Translation"->rosetta]
];
GAMS[problemDef_String,opts:OptionsPattern[]]:=Module[{outputFile,gdxFile,tmpFile,cmd,termOutput,solverString,$GAMSReturnCodes,returnCode,log,sol,solverStatus,modelStatus,modelCodes},
	solverString=Switch[
		{OptionValue["Solver"],OptionValue["Category"]},
		{Automatic,cat_String/;StringMatchQ[cat,"NLP",IgnoreCase->True]},"nlp=CONOPT",
		{Automatic,cat_String/;StringMatchQ[cat,"QCP",IgnoreCase->True]},"qcp=Gurobi",
		{Automatic,cat_String/;StringMatchQ[cat,"LP",IgnoreCase->True]},"lp=Gurobi",
		{Automatic,cat_String/;StringMatchQ[cat,"DNLP",IgnoreCase->True]},"dnlp=CONOPT",
		{_String,_},OptionValue["Category"]<>"="<>OptionValue["Solver"],
		_,Message[GAMS::wrongSolverSpec];Abort[];
	];
	tmpFile=OpenWrite[];
	gdxFile=tmpFile[[1]]<>".gdx";
	WriteString[tmpFile,problemDef<>"\nExecute_Unload '"<>gdxFile<>"'"];Close[tmpFile];
	outputFile=DirectoryName[#]<>FileNameTake[#]<>".lst"&[tmpFile[[1]]];
	cmd="gams "<>"\""<>tmpFile[[1]]<>"\""<>" -o "<>"\""<>outputFile<>"\""<>" "<>"lo=3 ps=0 pw=80 threads=0 "<>solverString<>" curdir="<>DirectoryName[outputFile]<>" "<>OptionValue["CommandLineOptions"]<>" && echo $?";
	termOutput=Import["!"<>$SystemCommandPrefix<>cmd,"Text"];
	If[termOutput=="",Message[GAMS::gamsMissing];Abort[];];
	returnCode=StringTake[termOutput,-1];
	If[returnCode=!="0",Message[MessageName[GAMS,#]]&["returnCode"<>returnCode]];
	log=Check[Import[outputFile,"Text"],Message[GAMS::errors,termOutput];Abort[];,{Import::nffil}];
	sol=gdxDumpParser[Import["!"<>$SystemCommandPrefix<>"gdxdump "<>gdxFile,"Text"]]/.OptionValue["Translation"];
	solverStatus=ToExpression[StringCases[log,RegularExpression["(\\*){4} SOLVER STATUS\\s+(\\d+)"]->"$2"][[1]]];
	If[solverStatus>1,Message[MessageName[GAMS,#]]& ["solverCode"<>ToString[solverStatus]]];
	modelStatus=ToExpression[StringCases[log,RegularExpression["(\\*){4} MODEL STATUS\\s+(\\d+)"]->"$2"][[1]]];
	If[modelStatus>2,Message[MessageName[GAMS,#]]& ["modelCode"<>ToString[modelStatus]]];
	Switch[OptionValue["Output"],
		Minimize|Maximize|NMinimize|NMaximize|FindMinimum|FindMaximum,{"Level"/.(Global`Z/.sol),#[[1]]->("Level"/.#[[2]])&/@FilterRules[sol,Except[Global`Z]]},
		"Full"|Full,{"Level"/.(Global`Z/.sol),#[[1]]->("Level"/.#[[2]])&/@FilterRules[sol,Except[Global`Z]],sol,StringReplace[log,ToString/@#&/@OptionValue["Translation"]],modelStatus/.$GAMSModelCodes,solverStatus/.$GAMSSolverCodes},
		_,Message[GAMS::wrongOutputFormat,OptionValue["Output"]];Abort[];
	]
];
def:GAMS[___]:=(Message[Toolbox::badargs,GAMS,Defer@def];Abort[]);
Protect[GAMS];


parseGAMSoutput[output_String]:=StringCases[output,RegularExpression["----\\sVAR\\s+(\\w+)~?\\s(.*)"]:>"$1"->Thread[Rule[{"LOWER","LEVEL","UPPER","MARGINAL"},ImportString["$2","Table"][[1]]]]]


(* ::Subsection::Closed:: *)
(*NEOS interface*)


getNEOSGDX::missinginf="No job number and password found in provided NEOS result log.";
getNEOSGDX[result_String]:=Module[{jobNumber,password,url,fhandle,file},
	{jobNumber,password}=If[Length[#]!=1,Message[getNEOSGDX::missinginf];,#[[1]]]&@StringCases[StringSplit[result,"\n"][[1]],RegularExpression[".*jobNumber = (\\d+)\\s*password = (\\w+)"]:>{"$1","$2"}];
	url="http://www.neos-server.org/neos/jobs/"<>jobNumber<>"-"<>password<>"-out.gdx";
	Needs["Utilities`URLTools`"];
	fhandle=OpenWrite[];Close[fhandle];
	file=fhandle[[1]]<>".gdx";
	Utilities`URLTools`FetchURL[url,file];
	gdxDumpParser[Import["!"<>$SystemCommandPrefix<>"gdxdump "<>file,"Text"]]
];

getNEOSstatuses::noStatusFound="No model/solver status found in provide log.";
getNEOSstatuses[log_String]:=Module[{modelStatus,solverStatus},
	solverStatus=If[Length[#]==1,#[[1]],Message[getNEOSstatuses::noStatusFound];Undefined]&@StringCases[log,RegularExpression["\\*\\*\\*\\* SOLVER STATUS\\s+(\\d+)"]:>ToExpression["$1"]];
	modelStatus=If[Length[#]==1,#[[1]],Message[getNEOSstatuses::noStatusFound];Undefined]&@StringCases[log,RegularExpression["\\*\\*\\*\\* MODEL STATUS\\s+(\\d+)"]:>ToExpression["$1"]];
	{modelStatus,solverStatus}
];


Unprotect[NEOS];
NEOS::neosMissing="NeosClient.py seems to be not installed or not on your system path. Check out http://www.neos-server.org/neos/downloads.html";
NEOS::wrongOutputFormat="Output format `1` not recognized. Try \"Full\" or Minimize, Maximize, etc. intstead (to achieve a similar output as Mathematica's own optimization routins).";
Options[NEOS]={"GAMSForm"->{},"ID"->Hold["Model"<>StringReplace[ToString[Unique[]],"$"->"_"]],"Translation"->{},"Options"->"","Category"->"nco","Solver"->"CONOPT","InputMethod"->"GAMS","Comments"->"","Output"->Minimize};
NEOS[objAndEqu_/;!StringQ[objAndEqu],vars_,opts:OptionsPattern[]]:=Module[{rosetta,objAndEquAnon,varsAnon,problemDef,fullOutput,solverString},
	{{objAndEquAnon,varsAnon},rosetta}=symbolize[{objAndEqu,vars}];
	problemDef=GAMSForm[objAndEquAnon,varsAnon,Sequence@@OptionValue["GAMSForm"]];
	NEOS[problemDef,opts,"Translation"->rosetta]
];
NEOS[problem_String,opts:OptionsPattern[]]:=Module[{modelStatus,solverStatus,problemID,xml,tmpFile,cmd,log,sol},
	problemID=ReleaseHold@OptionValue["ID"];
	xml=XMLObject["Document"][{},
			XMLElement[problemID,{},
				{XMLElement["exampleName",{},{"Chemical Equilibrium"}],
				XMLElement["category",{},{OptionValue["Category"]}],
				XMLElement["solver",{},{OptionValue["Solver"]}],
				XMLElement["inputMethod",{},{"GAMS"}],XMLElement["priority",{},{"short"}],
				XMLElement["model",{},{XMLObject["CDATASection"][problem]}],
				XMLElement["wantlog",{},{XMLObject["CDATASection"]["yes"]}],
				XMLElement["wantgdx",{},{XMLObject["CDATASection"]["yes"]}],
				XMLElement["comments",{},{OptionValue["Comments"]}],
				XMLElement["options",{},{XMLObject["CDATASection"][OptionValue["Options"]]}]
			}],{}
	];
	tmpFile=OpenWrite[];
	WriteString[tmpFile,ExportString[xml,"XML"]];
	Close[tmpFile];
	cmd="NeosClient.py "<>tmpFile[[1]];
	log=Import["!"<>$SystemCommandPrefix<>cmd,"Text"];
	If[log=="",Message[NEOS::neosMissing];Abort[];];
	sol=getNEOSGDX[log]/.OptionValue["Translation"];
	{modelStatus,solverStatus}=getNEOSstatuses[log];
	If[solverStatus>1,Message[MessageName[GAMS,#]]& ["solverCode"<>ToString[solverStatus]]];
	If[modelStatus>2,Message[MessageName[GAMS,#]]& ["modelCode"<>ToString[modelStatus]]];
	Switch[OptionValue["Output"],
		Minimize|Maximize|NMinimize|NMaximize|FindMinimum|FindMaximum,{"Level"/.(Global`Z/.sol),#[[1]]->("Level"/.#[[2]])&/@FilterRules[sol,Except[Global`Z]]},
		"Full"|Full,{"Level"/.(Global`Z/.sol),#[[1]]->("Level"/.#[[2]])&/@FilterRules[sol,Except[Global`Z]],sol,StringReplace[log,ToString/@#&/@OptionValue["Translation"]],modelStatus/.$GAMSModelCodes,solverStatus/.$GAMSSolverCodes},
		_,Message[NEOS::wrongOutputFormat,OptionValue["Output"]];Abort[];
	]
	
];
Protect[NEOS];


(* ::Subsection::Closed:: *)
(*X3 interface*)


Unprotect[model2X3];
model2X3[model_MASSmodel]:=Module[{rxns,external,internal,helpFunc,exchangeTab},
helpFunc=Piecewise[{
	{"Free",MatchQ[v[getID@#]/.#2,_v]},
	{"ZERO",(v[getID@#]/.#2)=={0,0}},
	{"Output",getSubstrates[#]==={}&&(v[getID@#]/.#2)[[2]]<=0},
	{"Input",getSubstrates[#]==={}&&(v[getID@#]/.#2)[[1]]>=0&&(v[getID@#]/.#2)[[2]]>0},
	{"Input",getProducts[#]==={}&&(v[getID@#]/.#2)[[2]]<=0},
	{"Output",getProducts[#]==={}&&(v[getID@#]/.#2)[[1]]>=0&&(v[getID@#]/.#2)[[2]]>0}
	},"Free"]&;
	rxns=model["Reactions"];
	external=model["Exchanges"];
	internal=Complement[rxns,external];
	exchangeTab=DeleteCases[Union@Table[
		{ToString[getCompounds[r][[1]]],helpFunc[r,model["Constraints"]]}
		,{r,external}],{_,"ZERO"}];
	exchangeTab=If[MemberQ[exchangeTab,{#[[1]],"Input"},\[Infinity]]&&MemberQ[exchangeTab,{#[[1]],"Output"},\[Infinity]],{#[[1]],"Free"},#]&/@exchangeTab;
	"(Internal fluxes)\n"<>ExportString[Table[reaction2x3reaction[r],{r,internal}],"TSV"]<>"\n(Exchange fluxes)\n"<>ExportString[exchangeTab,"TSV"]
];
Protect[model2X3];


reaction2x3reaction[rxn_reaction]:=Module[{substrStoich,prodStoich,gcd},
	substrStoich=Rationalize@getSubstrStoich[rxn];
	prodStoich=Rationalize@getProdStoich[rxn];
	gcd=GCD[Sequence@@Join[substrStoich,prodStoich]];
	{substrStoich,prodStoich}={substrStoich,prodStoich}/gcd;
	Join[
		{StringReplace[getID@rxn,"\[UnderBracket]"->"_"],If[reversibleQ[rxn],"R","I"]},
		Flatten[Join[Thread[{-1*substrStoich,ToString/@getSubstrates[rxn]}],Thread[{prodStoich,ToString/@getProducts[rxn]}]]]
	]
];


Unprotect[parseX3output];
parseX3output::nffil = "X3 output file `1` could not be found. Check the console output.";
parseX3output[path_String] := Module[{rxnIDs,tmp,pos,expas,typeIII},
	expas=Quiet[Check[Import[path <> "_myPaths.txt", "Table"], Message[parseX3output::nffil, path <> "_myPaths.txt"]; {}, {Import::nffil}],{Import::nffil}];
	typeIII=Quiet[Check[Import[path <> "_myT3.txt", "Table"], Message[parseX3output::nffil, path <> "_myT3.txt"]; {}, {Import::nffil}],{Import::nffil}];
	rxnIDs=Quiet@Check[
	tmp=Import[path <> "_myRxnMet.txt", "Table"];
	pos=Flatten[Position[tmp, {}]];
	Join[tmp[[2 ;; pos[[1]] - 1]][[All, 2]], tmp[[pos[[1]] + 2 ;; pos[[2]] - 1]][[All, 2]]]
	, Message[parseX3output::nffil, path <> "_myRxnMet.txt"]; {}, {Import::nffil}];
	{If[expas!={},expas.rxnIDs,{}],If[typeIII!={},DeleteCases[typeIII.rxnIDs,a_String+b_String/;StringReplace[a,RegularExpression["_R$"]->""]==StringReplace[b,RegularExpression["_R$"]->""]],{}]}
];
Protect[parseX3output];


Unprotect[X3];
Options[X3]={"x3path"->"X3"};
X3[model_MASSmodel,opts:OptionsPattern[]]:=Module[{tmpFile,x3Format,termOutput,cmd,files},
	x3Format=model2X3[model];
	tmpFile=OpenWrite[];
	WriteString[tmpFile,x3Format];
	Close[tmpFile];
	cmd="!"<>$SystemCommandPrefix<>OptionValue["x3path"]<>" \""<>tmpFile[[1]]<>"\" 2>&1";
	termOutput=Import[cmd,"Text"];
	{Sequence@@Thread[Rule[{"Expa","T3"},parseX3output[tmpFile[[1]]]]],"Terminal"->termOutput,"Input"->x3Format}
];
Protect[X3];


(* ::Subsection::Closed:: *)
(*End*)


End[]
